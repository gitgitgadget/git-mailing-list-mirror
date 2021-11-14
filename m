Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561BBC433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 07:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BEC60EB4
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 07:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhKNHfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 02:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNHe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 02:34:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4607C061570
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 23:32:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v19so1095470plo.7
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tDug4q13aoLsWZl8MWYqenS3vEYJLC7EboWSc/TW20=;
        b=P1cw5Kc/Ezw58H0fiWhp0wauTIQQ1hhzqkwAe7uIhfoHh6GyVW0LckQjbypPbJm6Tr
         7zQ45FvCO3j+/ikWk0ZQ7IpaxViXkHll1wHGNHnpjF8KW7c8tz++wWUfWb/5pWK3nfaG
         cPAsPQM+4QdqQxZnGiDmNjg7GSJTo9x3bKUu28Hy5Ve7AgV93kj4cEQyzy2XGoW2krwY
         9gWq7zQNRbfJQQzQZ2eY5jOZf1jaZyHelBANKk+T1eXfZCeU3iVCu7oC3TbMn8bjl/BX
         AgJiY96dTvFbjYWmZ2I5N9TK/r3lCY7BVvzWvPX+im6RgqF5thPcG0PWpzLcgGVVvUEe
         JtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tDug4q13aoLsWZl8MWYqenS3vEYJLC7EboWSc/TW20=;
        b=xZY/2rxX1yyfxhGtn9nCyowGCcBgemv2Ag+4WTpY4txQPhXrSiH2sENrnvMlXUEaxF
         ycTjyv6/i5JwDneqcjuhEvsNdmTpR0coPbHO2PPer7ertTa90LJhnQ5272SSWmnr8TWb
         AZBsi4dG7kTEcq7qSkTgNEXd9pBns81iqqYkS9Tg3LAeBzHkdV5NmR6c7nQFYkSpJQB2
         IHfeDNWl+MdEGgT8+uPj9c54YVujaar6/9jJ9l5b+6ogn9l2O+07q+EACyWiZL3FN6eW
         sSu96lnthtbGsg+SrEIEcKVqnqLtuUA87hWd6i5LTE3LVbYDI503zsqhXCZb15MLU2hT
         L2tw==
X-Gm-Message-State: AOAM532/qu5x/2y1owjgbpcOOesdK26jtH3hoaqLBtgaaxq39P0DngFo
        sXb7MGRG6b9uFX6saKMgO+gzCXtETAQ=
X-Google-Smtp-Source: ABdhPJxbg28KostvkeGl8C67ekLnjZKmVY/EjB/agQjoKqpas8VfUcd7+8TbDCr7SZ3CK+GZ9xwP7Q==
X-Received: by 2002:a17:90a:fe14:: with SMTP id ck20mr34550938pjb.72.1636875120053;
        Sat, 13 Nov 2021 23:32:00 -0800 (PST)
Received: from ubuntu.mate (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id p22sm2994600pgh.50.2021.11.13.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 23:31:59 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Daniel Santos <hello@brighterdan.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] fetch-pack: add TRANSLATORS notice for packfile ready messages
Date:   Sun, 14 Nov 2021 14:31:43 +0700
Message-Id: <20211114073143.84004-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two messages mention "... to be sent after 'ready'". The 'ready' string,
however, is actually in part of packet stream, which shouldn't be
translated. Because of lack of any notices, l10n teams treat it as
ordinary string, which results to inconsistency across teams. That is,
in `po/es.po` the string is translated:

```
msgid "expected packfile to be sent after 'ready'"
msgstr "se esperaba que el packfile fuera enviado luego del 'listo'"

msgid "expected no other sections to be sent after no 'ready'"
msgstr "se esperaba que ninguna otra sección fuera enviada luego del 'listo'"
```

whereas in `po/fr.po` and `po/de.po`, the string isn't translated:

```
msgid "expected packfile to be sent after 'ready'"
msgstr "fichier paquet attendu à envoyer après 'ready'"

msgid "expected no other sections to be sent after no 'ready'"
msgstr "aucune autre section attendue à envoyer après absence de 'ready'"
```

```
msgid "expected packfile to be sent after 'ready'"
msgstr "Erwartete Versand einer Packdatei nach 'ready'."

msgid "expected no other sections to be sent after no 'ready'"
msgstr "Erwartete keinen Versand einer anderen Sektion ohne 'ready'."
```

To avoid confusions, add TRANSLATORS notice.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fetch-pack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3..0cda8fc518 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1410,8 +1410,12 @@ static int process_ack(struct fetch_negotiator *negotiator,
 	 * otherwise.
 	 */
 	if (*received_ready && reader->status != PACKET_READ_DELIM)
+		/* TRANSLATORS: 'ready' string is in part of packet stream.
+		   Leave it as is. */
 		die(_("expected packfile to be sent after 'ready'"));
 	if (!*received_ready && reader->status != PACKET_READ_FLUSH)
+		/* TRANSLATORS: 'ready' string is in part of packet stream.
+		   Leave it as is. */
 		die(_("expected no other sections to be sent after no 'ready'"));
 
 	return 0;

base-commit: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b
-- 
An old man doll... just what I always wanted! - Clara

