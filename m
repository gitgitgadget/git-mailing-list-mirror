From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Mon, 1 May 2006 08:48:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605010842130.21189@g5.osdl.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <20060501140410.GA3505@mars.ravnborg.org>
 <20060501140704.GA6096@mars.ravnborg.org> <20060501145328.GA14856@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 17:49:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaaeK-0008NQ-Rk
	for gcvg-git@gmane.org; Mon, 01 May 2006 17:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWEAPsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 11:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWEAPsx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 11:48:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932138AbWEAPsw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 11:48:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k41FmjtH029133
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 1 May 2006 08:48:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k41FmiT1031944;
	Mon, 1 May 2006 08:48:45 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060501145328.GA14856@mars.ravnborg.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19381>



On Mon, 1 May 2006, Sam Ravnborg wrote:
> 
> Seems I have confused myself.
>
>	git grep DEBUG '*/Kconfig*'
>
> does indeed work today.

Indeed. I was a bit confused about your report, since not only does it 
work today, that's how it has always worked, and it was very much designed 
that way. I use it all the time.

It takes the git-ls-files pathname syntax, which is a bit _different_ from 
the normal "limit to these paths" syntax, in that it honors '*'. And it 
honors that a bit differently than normal shell pathname expansion, 
because for git-ls-files a '*' pattern will match '/' as well.

So

	git grep pattern 'net/*.c'

will match every single C file found _recursively_ inside the "net/" 
subdirectory, not just in that single directory itself.

So "*" for git grep is a bit more like a "**" pattern in some shells.

		Linus
