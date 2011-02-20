From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/72] gettextize: git-init basic messages
Date: Sat, 19 Feb 2011 20:21:24 -0600
Message-ID: <20110220022124.GA17547@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 03:21:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqyvY-0001j2-3R
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 03:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab1BTCVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 21:21:31 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61646 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab1BTCVa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 21:21:30 -0500
Received: by iwn8 with SMTP id 8so739333iwn.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 18:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WogJEtH6xKkRCdCsIF6s1bE/tgCIKWP0dkQ6Wm0rTio=;
        b=VOKVjAfbMV+PV5lXWSnI+9Xl1zi2RSqRQzvvh/AQOaAaVV2oYDytvEntrR/aE+5hNU
         gf3EQVxUbSY9HH8HSxQWzwUZCBgYT7ZPiEohCw1UE9dj29eZtsX3vEFyFBFF3CxF165H
         4sEwkCIvJYdPMnLtM+Bm0qmtE+xEmhuJ6dp1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u8o6Blgu8EQOiFNIFi2GbuSLSKU0TlkDDBTNlxoAEtQbV7i/HNPo0Qubk6IbvEM/jM
         5OWmOqT3XpxODvee6yk6k3YdMV9JdOrTTyafHc8CAMlALsqDL2hfcBz4fAyLrN800pmD
         9lru4j/fI+uDUVMxBOxWSuHtt66cvjr+Sjtuk=
Received: by 10.231.200.195 with SMTP id ex3mr1832588ibb.46.1298168489880;
        Sat, 19 Feb 2011 18:21:29 -0800 (PST)
Received: from elie ([69.209.79.88])
        by mx.google.com with ESMTPS id u9sm3460955ibe.14.2011.02.19.18.21.28
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 18:21:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298143495-3681-5-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167392>

One more comment.  (The gettextization so far looks good to me.)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -31,7 +31,7 @@ static void safe_create_dir(const char *dir, int sh=
are)
>  		}
>  	}
>  	else if (share && adjust_shared_perm(dir))
> -		die("Could not make %s writable by group", dir);
> +		die(_("Could not make %s writable by group"), dir);

Hmm, forgot to include something like the following in the reply to
patch 1.

> @@ -346,7 +346,7 @@ int init_db(const char *template_dir, unsigned in=
t flags)
>  		else if (shared_repository =3D=3D PERM_EVERYBODY)
>  			sprintf(buf, "%d", OLD_PERM_EVERYBODY);
>  		else
> -			die("oops");
> +			die(_("oops"));

(Not related to this series, but that seems like a pretty unhelpful
error message.)
---
 gettext.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gettext.h b/gettext.h
index 2f806cb..2bd70d4 100644
--- a/gettext.h
+++ b/gettext.h
@@ -5,6 +5,8 @@
 #error "namespace conflict: _ is pre-defined?"
 #endif
=20
+#define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
+
 /*
  * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
  *
@@ -13,7 +15,7 @@
  * a future patch series.
  */
=20
-static inline const char *_(const char *msgid)
+static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
 	return msgid;
 }
--=20
1.7.4.1
