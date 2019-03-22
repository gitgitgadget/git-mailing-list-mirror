Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC7D20248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfCVXXD (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:23:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43805 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfCVXXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:23:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so4410478qtc.10
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w31IgR5n4pwxD0WOvj4gks83n9A5TGB3dAAc+WgAmPY=;
        b=d7V3ZXWyptx2RPHy6T51wj9UysUp/DtZVRsiqD/0hpKFrPa7u0QQAwLRHqamxKd/dz
         VaeipOIFBG+SUWzY7M5vi3L6iHvZKM570j1GBH0xvT4ck2wDHlC2WAe1Fod27EJ/LC3e
         +4ngbTcdfyRxR4XQUyUqi0w+kJyZakjdZ23t/fy1YFAip5lLB+NG9eKZc5P8+6Jy9+wr
         g0Tt4uTpcVyv9g+2PgaHLRjEiaxvJMDIHJZFFJXv1zYkurzHXmCrmL5YZQrikGG3/npQ
         BFIXvrtX/jzIY0gFF9P6Vqm9icP8qxpfjn3z3KHXyWFbIoHiiiOFQ7kIMhaw5J8Nd4qJ
         KV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w31IgR5n4pwxD0WOvj4gks83n9A5TGB3dAAc+WgAmPY=;
        b=sE5PV/cqLyNJCl/KdHv0goAT3dOOQTqPXTZv+xB+sBy1PT49JxumeDmqQ5HMmTmkIe
         IdjRYM5B/1qcmaQR/QKw82NEl6IMgtGpvxOufe+xD9jPsoRiobDoq/AtkDRJZ2dq2CNg
         ZfCHmb/eRw3StsWThnRM9Uv19JnDVX5/PtleIUQge/XqL/rtQ9SQdbT5wP5ag/SRXAwI
         NbGNtTy+4e+0ofEOVS5CKAHpFTzzod7qrhAqZDthY1JMQk8SFVaIBi7hA6xsoIBMRuuL
         4zSSxEQaGzGqA/BExLhso3zqdek1QXGmxQnQp+iD5II4n113vWn93O/M7MOEVE0xgeMj
         lx/w==
X-Gm-Message-State: APjAAAWB9icqvBl8ea2+unA4L2DKqezMNEFmR/1xbKLy833TvZXPMQhE
        QrSHqf9UtqDgAyofVTxXj193MFjyzR8=
X-Google-Smtp-Source: APXvYqyDqQ6gVYR/mvog4h8moLZcL/EWZbkyeRp6Jf09Ateb9hgErBGP/8PthYIlJ0+Gbv6tJPJ0dw==
X-Received: by 2002:ac8:3821:: with SMTP id q30mr10356765qtb.73.1553296981330;
        Fri, 22 Mar 2019 16:23:01 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:23:00 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v4 4/7] clone: copy hidden paths at local clone
Date:   Fri, 22 Mar 2019 20:22:34 -0300
Message-Id: <20190322232237.13293-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
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
index b76f33c635..60c6780c06 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -428,7 +428,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
+			if (!is_dot_or_dotdot(de->d_name))
 				copy_or_link_directory(src, dest,
 						       src_repo, src_baselen);
 			continue;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 76d45f1187..0992baa5ac 100755
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
2.20.1

