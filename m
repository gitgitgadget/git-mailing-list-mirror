From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 22:49:02 +0000
Organization: linutronix
Message-ID: <1115851742.22180.154.camel@tglx>
References: <1115839456.22180.79.camel@tglx>
	 <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net> <1115843429.22180.90.camel@tglx>
	 <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
	 <20050511221719.GH22686@pasky.ji.cz>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:41:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzsz-0002Qh-8V
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVEKWsc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVEKWsc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:48:32 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:131
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261297AbVEKWsL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:48:11 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id B47B065C003;
	Thu, 12 May 2005 00:48:09 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 7C587282A1;
	Thu, 12 May 2005 00:48:11 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511221719.GH22686@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 00:17 +0200, Petr Baudis wrote:
> But the very fact that you want this makes me *quite* nervous - I think
> this is bad thing to do. The problem is, for something like
> it won't show the full merge. 
> 
> I think you mean it to show everything going into the tree since foo -
> that would include the whole branch you cut off now.

>From a SCM POV it does not matter.

Rn   o
     | \
Rn-1 o  |
     |  o Mn
     |  o Mn-1
Rn-2 o /
Rn-3 o

If you are in Repository R, then tracking Rn to Rn-123 gives you a
linear result depending on the stop point you chose.
Rn
---- Stop = Rn-1
Rn-1
---- Stop = Rn-2
Rn-2
---- Stop = Rn-3

The diff between Rn and Rn-1 contains always the changes merged from M

> Thomas, what are you going to use it for?

Displaing the the changes between commit shaX and shaY :)

tglx


