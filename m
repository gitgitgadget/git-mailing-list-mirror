From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Sun, 26 Feb 2006 12:18:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org>
References: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se>
 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
 <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
 <20060226195552.GA30735@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 21:18:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSLd-0000rH-8a
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWBZUS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWBZUS0
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:18:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60075 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbWBZUS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 15:18:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1QKIODZ010421
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 12:18:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1QKIJXo023031;
	Sun, 26 Feb 2006 12:18:22 -0800
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20060226195552.GA30735@trixie.casa.cgf.cx>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16792>



On Sun, 26 Feb 2006, Christopher Faylor wrote:
> 
> If the speed of cygwin's fork is an issue then I'd previously suggested
> using spawn*.  The spawn family of functions were designed to emulate
> Windows functions of the same name.  They start a new process without
> the requirement of forking.

I thought that cygwin didn't implement the posix_spawn*() family?

Anyway, we probably _can_ use posix_spawn() in various places, and 
especially if that helps windows performance, we should.

		Linus
