From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Tue, 6 Nov 2007 09:44:27 +0100
Message-ID: <8c5c35580711060044i7a3d0134p42e9437cbe2a258b@mail.gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
	 <Pine.LNX.4.64.0711060903070.8577@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:44:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpK3F-0007gR-Rb
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbXKFIog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbXKFIog
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:44:36 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:43253 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbXKFIof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:44:35 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2325102wah
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 00:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/cbdkdBduQyYyEGLMHlFIus7Xu1tBppDqhe1rGas0mE=;
        b=JPTzt89DrSnrLWlgEBjoiCqs/PRudFDypKk/fEjWRlu31vy+uEnj22Dk/KZ1ujIoZH8Py3iJBh5FjvaOGgkA/3qtqS1sYwTmtb2UZpgqxTPRI9GkPM5PNYqWIXYK+2YTvT2+WrP9xYxgLOtoyVQwPYqhEEEDU06Hpf8q5CLE2GA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lZq6e8n228S6i/1lxiVtr0ashFJSXeAbKgc5+DP/rLgWgbyMgNsz/PgNtD1vUHkln/cBhvIHWSe8vYzM6cMevPtB0IgN+7CS1E6fNinGr1W4zGxP6eTpMDYXe0bfHEJK0dKP9mokXCtRH1ycF2Hymemgsla8pomOeFT0wQdZIYk=
Received: by 10.114.151.13 with SMTP id y13mr376791wad.1194338667440;
        Tue, 06 Nov 2007 00:44:27 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Tue, 6 Nov 2007 00:44:27 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711060903070.8577@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63643>

On Nov 6, 2007 9:04 AM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> Lars Hjemli:
>
> > cgit v0.7 (a fast webinterface for git) is now available at
> >
> >      git://hjemli.net/pub/git/cgit
>
> Has anyone managed to compile this for Win32?

If (win32 == cygwin): yes, just did (but it needed a makefile tweak
regarding iconv)

-- 
From: Lars Hjemli <hjemli@gmail.com>
Date: Tue, 6 Nov 2007 09:35:07 +0100
Subject: [PATCH] Makefile: link with libiconv if NEEDS_LIBICONV is defined

This seems to be needed to compile on cygwin.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6abd82a..dbc34a2 100644
--- a/Makefile
+++ b/Makefile
@@ -19,6 +19,11 @@ OBJECTS = shared.o cache.o parsing.o html.o
ui-shared.o ui-repolist.o \
        ui-snapshot.o ui-blob.o ui-tag.o ui-refs.o


+ifdef NEEDS_LIBICONV
+       EXTLIBS += -liconv
+endif
+
+
 .PHONY: all git install clean distclean force-version get-git

 all: cgit git
-- 
1.5.3.4.452.g09149
