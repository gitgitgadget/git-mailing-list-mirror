From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] compat: add a mkstemps() compatibility function
Date: Wed, 27 May 2009 01:20:55 -0700 (PDT)
Message-ID: <m33aarc5yc.fsf@localhost.localdomain>
References: <1243394364-13772-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 10:21:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ENn-000538-KU
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 10:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbZE0IU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 04:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbZE0IU4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 04:20:56 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:36891 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbZE0IUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 04:20:55 -0400
Received: by pzk7 with SMTP id 7so3504141pzk.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=4v+ktInWfG/7DyBWJwnuSBVpY36FT+CM6/5SktsyELc=;
        b=ZR6cD8EEgy7RtWz81ijEquSpsegjXkd50it0i9uh5yYJBG+TpR+FKxpj0ydzOmElzg
         4MgMczEx7DaIf8PAwBOOOEhghViQxOCgE7AOpetE4hUcmyyhXgH5z2YfMSwipmQdaYUc
         CucbCWZU/eEBWHb7dQ7Eula+SA2jegA3Vk41k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=d5E4iQpvkzxGI2+b+0E/zyrG4WLi+8qe0TSJTgbzX/4nJZuuRaDCttyEXE2RjUd/rI
         b6IXisJwGFZ/1BawUj5cONnXXV+5SmjjJYLjEH6U2hENz6s4T8o2FeG9E1d/AzKgmdjn
         G1j07o0G6nooEZR1gbEEhMFGFOCxcItDcSv+8=
Received: by 10.142.177.5 with SMTP id z5mr2999619wfe.32.1243412456696;
        Wed, 27 May 2009 01:20:56 -0700 (PDT)
Received: from localhost.localdomain (abvl57.neoplus.adsl.tpnet.pl [83.8.209.57])
        by mx.google.com with ESMTPS id 29sm95416wfg.8.2009.05.27.01.20.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 01:20:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4R8KmLF011047;
	Wed, 27 May 2009 10:20:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4R8Kj9T011043;
	Wed, 27 May 2009 10:20:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1243394364-13772-1-git-send-email-davvid@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120047>

David Aguilar <davvid@gmail.com> writes:

> mkstemps() is a BSD extension so provide an implementation
> for cross-platform use.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> This mkstemps() implementation is adapted from libiberty's
> GPLv2+ mkstemps.c.
> 
>  Makefile          |   19 +++++++++++++
>  compat/mkstemps.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  git-compat-util.h |    5 +++
>  3 files changed, 102 insertions(+), 0 deletions(-)
>  create mode 100644 compat/mkstemps.c

Could you squash this in?  I see that configure.ac is a bit outdated,
but we shouldn't make it even more so...

---
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 7cce0c1..b6619af 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,6 +46,7 @@ NO_STRTOUMAX=@NO_STRTOUMAX@
 NO_SETENV=@NO_SETENV@
 NO_UNSETENV=@NO_UNSETENV@
 NO_MKDTEMP=@NO_MKDTEMP@
+NO_MKSTEMPS=@NO_MKSTEMPS@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
diff --git a/configure.ac b/configure.ac
index 4e728bc..2ddf498 100644
--- a/configure.ac
+++ b/configure.ac
@@ -677,6 +677,12 @@ GIT_CHECK_FUNC(mkdtemp,
 [NO_MKDTEMP=YesPlease])
 AC_SUBST(NO_MKDTEMP)
 #
+# Define NO_MKSTEMPS if you don't have mkstemps in the C library.
+GIT_CHECK_FUNC(mkstemps,
+[NO_MKSTEMPS=],
+[NO_MKSTEMPS=YesPlease])
+AC_SUBST(NO_MKSTEMPS)
+#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_ICONV if your libc does not properly support iconv.
-- 
1.6.3.1
