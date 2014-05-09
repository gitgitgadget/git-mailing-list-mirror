From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v1 12/25] contrib: remove 'vim'
Date: Thu, 8 May 2014 19:23:50 -0700
Message-ID: <20140509022350.GH9218@google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-13-git-send-email-felipe.contreras@gmail.com>
 <20140509020205.GC9787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 04:24:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaTe-0005AH-27
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbaEICXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:23:54 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41710 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbaEICXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:23:53 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so3061846pdi.7
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sqk1sgwS5NvZ0PBSOx381F+taEa58YzLuht5O7upHDY=;
        b=kCml7WZ/jJlkOSp+7A+UwEMQoWONVkfH5WkZG7fibsYn+Yh+MJdqn4s20/Ksce7ume
         Zews8PHk78lnH6N5LAZc62eekGNj4qTdeJP7AOW9Dj1+6eqtORalYWx8P49jH3b2SN2+
         b4WNOjIelDAWAHw+UrS92IDjIBkqexd7Jh7m7YGtXMjsWE0iOlBvnyJimY/pUnD1fHfg
         YEAfRmqDlFNnOPIEOxOWwq8cbHfsiUsk7Yo0IeOlrWmPIv2Zb1AYyrXXmh/tAATjgVi1
         nL0evAQJ4uYlCvGeDL9iN7SdJVY9UDgArmapArULG6Do7v2Tiw85WuNNNOWlW1Uv2y4H
         xpwg==
X-Received: by 10.66.237.100 with SMTP id vb4mr515899pac.21.1399602233537;
        Thu, 08 May 2014 19:23:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qq5sm4506767pbb.24.2014.05.08.19.23.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 May 2014 19:23:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140509020205.GC9787@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248506>

Hi,

Jeff King wrote:

> However, I would certainly agree that that period of time is probably
> over; the scripts started shipping in upstream vim in mid-2008. I'd be
> happy to see this directory go away whether or not the rest of contrib/
> is dropped.

RHEL 6 has vim 7.2.something, so yeah, this should be mostly safe.

Git needs to keep working for people stuck on RHEL 5, but niceties
like vim support seem less important there.  But I am not convinced it
is worth inconveniencing them (or putting any obstacles in the way of
upgrading) without a good reason, and one less directory in contrib/
does not seem like a very strong reason.

Here's a new commit message in case we want to do this.

-- >8 --
Subject: contrib: remove vim support instructions

The git support scripts started shipping in upstream vim in version
7.2 (2008-08-09).  Clean up contrib/ a little by removing the
instructions for people on older versions of vim.

RHEL 6 already has vim 7.2.something, so anyone on a reasonably modern
operating system should not be affected.  Users on RHEL 5 presumably
know that means sometimes missing out on niceties like syntax
highlighting, so this should be safe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/vim/README | 22 ----------------------
 1 file changed, 22 deletions(-)
 delete mode 100644 contrib/vim/README

diff --git a/contrib/vim/README b/contrib/vim/README
deleted file mode 100644
index 8f16d06..0000000
--- a/contrib/vim/README
+++ /dev/null
@@ -1,22 +0,0 @@
-Syntax highlighting for git commit messages, config files, etc. is
-included with the vim distribution as of vim 7.2, and should work
-automatically.
-
-If you have an older version of vim, you can get the latest syntax
-files from the vim project:
-
-  http://ftp.vim.org/pub/vim/runtime/syntax/git.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitcommit.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitconfig.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitrebase.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitsendemail.vim
-
-These files are also available via FTP at the same location.
-
-To install:
-
-  1. Copy these files to vim's syntax directory $HOME/.vim/syntax
-  2. To auto-detect the editing of various git-related filetypes:
-
-	$ curl http://ftp.vim.org/pub/vim/runtime/filetype.vim |
-		sed -ne '/^" Git$/, /^$/ p' >>$HOME/.vim/filetype.vim
-- 
1.9.1.423.g4596e3a
