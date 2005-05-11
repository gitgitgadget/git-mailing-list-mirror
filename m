From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: History messup
Date: Wed, 11 May 2005 17:09:05 +0000
Organization: linutronix
Message-ID: <1115831345.22180.75.camel@tglx>
References: <1115657971.19236.33.camel@tglx>
	 <1115659677.16187.393.camel@hades.cambridge.redhat.com>
	 <1115660903.19236.39.camel@tglx>  <427FB3A7.8050906@zytor.com>
	 <1115665598.12012.422.camel@baythorne.infradead.org>
	 <427FBB53.1000801@zytor.com> <3772.10.10.10.24.1115676539.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 19:23:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVuuz-0005Xu-PM
	for gcvg-git@gmane.org; Wed, 11 May 2005 19:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEKRaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 13:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEKRaM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 13:30:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43904
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261221AbVEKR30
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 13:29:26 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 8B99E65C003;
	Wed, 11 May 2005 19:29:24 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id BBED32807D;
	Wed, 11 May 2005 19:08:15 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3772.10.10.10.24.1115676539.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-09 at 18:08 -0400, Sean wrote:
> On Mon, May 9, 2005 3:34 pm, H. Peter Anvin said:
> Seems the only solution is a full search of the history, unless there is
> some clever way to label branches or detect fast forward heads.

You can apply some heuristic guessing to detect fast forward heads, but
at the very end you will end up with manual selection puzzles.

On one hand we keep care to track the source of a change in the kernel
code by adding signed,acked but on the other hand we don't care about
history correctness. If you look at some file revisions, which you read
from the tree history then you just have patches applied in the wrong
order. 

Maybe nobody cares, but for maintaining customer trees with a bugfix,
stable and experimental branch it's necessary to keep track of
information in a consistent way especially if you have to deal with the
QA department.

I know that there is no simple and fool proof solution for this problem,
but some band-aid to make the reconstruction of history simpler would be
not too bad. 

tglx


