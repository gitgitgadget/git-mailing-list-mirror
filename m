From: Douglas Mencken <dougmencken@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Tue, 13 Nov 2012 14:55:10 -0500
Message-ID: <CACYvZ7jMC5xw4LxiuG5m+=grpQEg+wZb_7BaU4Xn-r7ix=S-bw@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<50A2978D.6080805@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:55:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYMa1-0002Qp-FR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 20:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab2KMTzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 14:55:14 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:43215 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab2KMTzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 14:55:13 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so5741575lag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QZA9twl2EPwk+Vknd2OErTDbXReDU/gxtjJCZbtR+TY=;
        b=Tff5+HN33Pt/wHKZuDVvHFPLuXnNh+Pao37y6cNmB3Bf1H2msj5Reu7uhHxdt4GyJ0
         GcdTb8BWNyHQREgnfCTAQjX/f7uB0xw6wqgz8By19TXp0gdRMvs0CDwaCl9tuxMkij7R
         yyF6u9bxaFsvAu540azt6vyhUjO6yGfuMDXFedHJNb6+Vfr6ub0+jrt1LrgsOvBEB0S0
         5vTYZ3HI95u1B+27MCRgMp5gAPBA3IU/KSCU0nZXdlP0oXN6MK/FojjcNP/kCLynPzKC
         TjOogZ06qJXHFX3ntUUF/ggHnCxqZR3TvPPw8Lw4iCCj1BWsSUYM87La0/EmTIhyzF9+
         zrIA==
Received: by 10.152.162.1 with SMTP id xw1mr15195654lab.3.1352836511329; Tue,
 13 Nov 2012 11:55:11 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Tue, 13 Nov 2012 11:55:10 -0800 (PST)
In-Reply-To: <50A2978D.6080805@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209664>

>  Could you try re-building git with the
> NO_THREAD_SAFE_PREAD build variable set?

Yeah! It works!!!

--- evil/Makefile
+++ good/Makefile
@@ -957,6 +957,7 @@
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
+	NO_THREAD_SAFE_PREAD = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease

With this, I do have correctly working git clone.
