From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Simplify MSGFMT setting in Makefile
Date: Fri, 14 Mar 2008 15:44:15 +1100
Message-ID: <18394.671.630499.836160@cargo.ozlabs.ibm.com>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
	<46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
	<20080222065836.GE8410@spearce.org>
	<46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
	<47C5A974.7080207@gmail.com>
	<alpine.LSU.1.00.0802271825330.22527@racer.site>
	<47C5AEFA.5020004@gmail.com>
	<alpine.LSU.1.00.0802272203270.22527@racer.site>
	<7vablmqc7q.fsf@gitster.siamese.dyndns.org>
	<47C7000C.1000809@gmail.com>
	<20080305071915.GI8410@spearce.org>
	<7v63w0gs87.fsf@gitster.siamese.dyndns.org>
	<7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1nC-0008LU-Jw
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbYCNEod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbYCNEoc
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:44:32 -0400
Received: from ozlabs.org ([203.10.76.45]:55312 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbYCNEoc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 00:44:32 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 18BB9DDE1A; Fri, 14 Mar 2008 15:44:30 +1100 (EST)
In-Reply-To: <7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77171>

Junio C Hamano writes:

>  * I am planning to close 'master' for -rc1 by the end of this week, so
>    please plan to tell me to pull if you have accumulated changes,
>    thanks.

I have a few commits for you to pull, but I am about to push a patch
for gitk like the one you sent for git-gui, so I'll send you a pull
request when I've done that.  However, I found that in this line:

>  else
>  	MSGFMT ?= msgfmt
> -	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
> +	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $?),0)

I had to put "echo $$?" for it to work rather than "echo $?".

Paul.
