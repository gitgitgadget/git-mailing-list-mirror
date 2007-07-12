From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: handle --continue more like non-interactive rebase
Date: Fri, 13 Jul 2007 00:26:40 +0200
Message-ID: <20070712222640.GA30532@steel.home>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 13 00:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I977Y-0007sK-IF
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 00:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380AbXGLW0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 18:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbXGLW0o
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 18:26:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15628 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbXGLW0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 18:26:43 -0400
Received: from tigra.home (Fc891.f.strato-dslnet.de [195.4.200.145])
	by post.webmailer.de (klopstock mo28) (RZmta 8.3)
	with ESMTP id 301ba2j6CJJN25 ; Fri, 13 Jul 2007 00:26:41 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0F0BD277BD;
	Fri, 13 Jul 2007 00:26:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CEDA8C164; Fri, 13 Jul 2007 00:26:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707080300440.4093@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+bxu8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52340>

Johannes Schindelin, Sun, Jul 08, 2007 04:01:29 +0200:
> Non-interactive rebase requires the working tree to be clean, but
> applies what is in the index without requiring the user to do it
> herself.  Imitate that, but (since we are interactive, after all)
> fire up an editor with the commit message.

Could we also have "git rebase <base> <branch>"?
I find it useful when I have many branches to rebase:

    ~/project @master$ git rebase master branch1
    ~/project @branch1$ git rebase master branch2
    ~/project @branch2$ git rebase master branch3
    ...

Otherwise one have to, for example, "git checkout branch1" first,
and only then run rebase-interactive. Checkout is not very pleasant
operation on windows if you have many files (well, nothing is pleasant
there, but this one have to be done often). Rebase-interactive is
*very* slow there, but I just could not part with it after having
tried it once :)
