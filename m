Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E131A1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfGKAAX (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 20:00:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33515 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGKAAW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 20:00:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so3428574qkc.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaYJwpJwCwlCFXJ34eCSRh6aqVIv7haGmVVvxs7jUKA=;
        b=zVk8ZLgMl0KPWoFBU2Zy0KDHo3tQI58k8ydeEAgIQEH9vfZBT6PmTR6Diz3O46+3Ov
         Jo6LiAww63sxCy3wazcnyumxM7KdCKn0Fvc3odvtVBnj2dVWV+bhUoM0Mzeyc5V3CO7L
         Z8Md+OqPkJ2OLCK7WuLaBfX6KxaCcRdq+BIH6c2PCiJQk1QeGhuHdzEhkTBDs7NaeMml
         a998VBuJeIaaXGqQ2/r978l4vZseymOdi0on3kYfzxEi4wwvKITtbRXXgtld/kt4PTx/
         BJem2vZvTK3A8EieDGKgHPdZME1UPTUaMBBRu/89JAnwoYd1lXYN+hlmMdysUdmS10Ia
         6JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaYJwpJwCwlCFXJ34eCSRh6aqVIv7haGmVVvxs7jUKA=;
        b=Qd7FSqd1FlbWUwjm51uBaHGKKbsH4R1Jg3GmhfJn1D1XRmLYK8IEuusOp8w5OGnsPu
         m8GQCsFmW8Z0VF+FRvRrS/XTppfja0NP5eVs7xE2Yi0CMEzACWzJqmhd5JA74XTpH6aF
         qFyAY+FQlt1CuG4CJ8tZ3CAcfOeALeBMT7X9HdAM31SFFnPW3mFMaVc/kP98LyCqwKV0
         xBJbWw0sD/XgK+Ohx9atFZBO5zfbvGu3VcmKi6fbOhpIzhxpFpU7+uXJjIs1uyus6EZU
         R5nDtCjeBzfX6noVIHh/HX1wE5VvpSuIDsHwAxWgQlJHwU1Dhm21rbnH+3ZlIfHflpq8
         QvXw==
X-Gm-Message-State: APjAAAUkoESMU8/yACsD/GDtM9ooIa0ZQjuC7wgQLzzcy3ctLfJf5tJE
        TaxTgDQUIHvrKBecR+nuBvP1qQ==
X-Google-Smtp-Source: APXvYqz6k1u8MsiSvd4FYoN8H1vWZ8bCI5hnZ69vWKZHjrpaYoe7oR8P61hFWamkHSaxWSY/9xf6kA==
X-Received: by 2002:a37:bf07:: with SMTP id p7mr683051qkf.315.1562803221660;
        Wed, 10 Jul 2019 17:00:21 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.17.00.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:00:21 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v8 07/10] clone: copy hidden paths at local clone
Date:   Wed, 10 Jul 2019 20:59:01 -0300
Message-Id: <3da6408e045de6e39166227a60472bd1952664ad.1562801255.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the copy_or_link_directory function no longer skip hidden
directories. This function, used to copy .git/objects, currently skips
all hidden directories but not hidden files, which is an odd behaviour.
The reason for that could be unintentional: probably the intention was
to skip '.' and '..' only but it ended up accidentally skipping all
directories starting with '.'. Besides being more natural, the new
behaviour is more permissive to the user.

Also adjust tests to reflect this behaviour change.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            | 2 +-
 t/t5604-clone-reference.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4a0a2455a7..9dd083e34d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -430,7 +430,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
+			if (!is_dot_or_dotdot(de->d_name))
 				copy_or_link_directory(src, dest,
 						       src_repo, src_baselen);
 			continue;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 459ad8a20b..4894237ab8 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -247,16 +247,25 @@ test_expect_success 'clone a repo with garbage in objects/*' '
 	done &&
 	find S-* -name "*some*" | sort >actual &&
 	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-dir
+	S--dissociate/.git/objects/.some-hidden-dir/.some-dot-file
+	S--dissociate/.git/objects/.some-hidden-dir/some-file
 	S--dissociate/.git/objects/.some-hidden-file
 	S--dissociate/.git/objects/some-dir
 	S--dissociate/.git/objects/some-dir/.some-dot-file
 	S--dissociate/.git/objects/some-dir/some-file
 	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-dir
+	S--local/.git/objects/.some-hidden-dir/.some-dot-file
+	S--local/.git/objects/.some-hidden-dir/some-file
 	S--local/.git/objects/.some-hidden-file
 	S--local/.git/objects/some-dir
 	S--local/.git/objects/some-dir/.some-dot-file
 	S--local/.git/objects/some-dir/some-file
 	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir
+	S--no-hardlinks/.git/objects/.some-hidden-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir/some-file
 	S--no-hardlinks/.git/objects/.some-hidden-file
 	S--no-hardlinks/.git/objects/some-dir
 	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
-- 
2.22.0

