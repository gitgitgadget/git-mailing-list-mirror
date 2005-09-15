From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon --inetd
Date: Thu, 15 Sep 2005 11:47:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
References: <43290EFF.3070604@zytor.com> <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
 <4329BDD9.4010507@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 20:48:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFylW-0001ra-Vs
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 20:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbVIOSrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbVIOSrU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 14:47:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030575AbVIOSrT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 14:47:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FIlHBo009109
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 11:47:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FIlGC8017495;
	Thu, 15 Sep 2005 11:47:17 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4329BDD9.4010507@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8624>



On Thu, 15 Sep 2005, H. Peter Anvin wrote:
> 
> Wrapping it in chroot() would mean having enough things in the chroot 
> environment to support starting up programs, which is ugly.  I'll test 
> the patch when I get a chance.

Fair enough. This still requires "git-upload-pack" and any libraries that
requires, of course. You might want to do a statically linked version or
something.

Hmm. A quick check seems to say that git-upload-pack only does libz and 
libc. And the SHA1 stuff, of course, but that you can always get static by 
using the git built-in mozilla versions.

			Linus
