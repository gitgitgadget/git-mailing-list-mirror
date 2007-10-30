From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 13:39:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301338260.30120@woody.linux-foundation.org>
References: <20071030042118.GA14729@sigill.intra.peff.net>
 <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org>
 <20071030134355.GA21342@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710300818390.30120@woody.linux-foundation.org>
 <20071030202014.GA22733@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Andy C <andychup@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imxth-0008Ob-93
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbXJ3Ukz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbXJ3Uky
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:40:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44268 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753223AbXJ3Ukx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 16:40:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UKdjBC003161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 13:39:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UKdjUY027020;
	Tue, 30 Oct 2007 13:39:45 -0700
In-Reply-To: <20071030202014.GA22733@coredump.intra.peff.net>
X-Spam-Status: No, hits=-3.231 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62754>



On Tue, 30 Oct 2007, Jeff King wrote:
> 
> Well, the problem is that instead of just "dropping" boilerplate text,
> we fail to count it as a similarity, but it still counts towards the
> file size. It may be that just dropping it totally is the right thing
> (in which case those renames _will_ turn up, because they will be filled
> with identical non-boilerplate goodness).

Yeah, you may well be right, and the normalization of the scores will just 
solve things.

			Linus
