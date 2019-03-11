Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B57B20248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfCKDmf (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDme (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id e17so2965125pgd.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tn5Kjz+CpnsYjAb/X8/zCWqi6dsaMkKGGIUH/uLWpBk=;
        b=mJUZZvteTlMNNPTPTI/NNE+W9UGJ7D3znE5SwpSfnhg8HIB7oZUAjBIhFf6cuLZ9SQ
         g0oPO3gXK7X3IgjKULaUKmyGHO5dVai2zkXC1/eF8kckUAHqd+DQr1ndKhEnP7iaRCGv
         lwsnzzeEPzejWI0OoOQ3An8Vr8XO4fA1+ndZTk20SwpY+1IFM1bJ081Cu3NeVMyJdHj1
         tM8k4E5Gxf0BWlvhJZ+yp+XNRMh1KM/eqjDSRRHu5VMxgTeZZoAkhQeYzCnZUtF+Nqni
         FCLw8zcAlPsja/PQWwOuyQCVRPKUBNA/gpVPZBL2D4NydHb010nERe/d8H53DIIXhnMy
         iQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tn5Kjz+CpnsYjAb/X8/zCWqi6dsaMkKGGIUH/uLWpBk=;
        b=P2FHxbKocef88AEH3Kpf8Vlsy/e9MeFISxLbw61Lg1TiXscdDX9DyeSUyJ/7J5prRi
         vbf7Yswm/aq+Shaq9DXNQMm9IGtIrzUkX8jfSjmmT9VdPvyTyvtcs9nFLoM3lzMity45
         /8aiVTHdZBGPI4kTziXC8NfJjZUF4U3qXDkYcefQewXkoBUScnAp3s9TdpzOW1/U7DBj
         SKyu1p0jPyaIr6DuL6dN+MbVcmXStSa6qDfweEMea6uJ6eg83KakIi5/cFV02cM/uJZg
         SzZnyiqJ/Uf2k2FxjMm2AnVMo9D00vsafxWa0SoFHvKhgjx/H+vSDkzTleOi6xDplly9
         Q+Mg==
X-Gm-Message-State: APjAAAV0gFo9xoTD/QhIabBIOj5JH1Sy9WGUzPYrhh1wme72mIRk1jyN
        n30vzgVHeab9ZoNFTUomCGSs99Cp
X-Google-Smtp-Source: APXvYqyPCOT3/pR8PKUE/8hXwPuzmKsHM0iYKqvScCXa31eco7xF/iI9khitbrfMu199dG0GHnDW+Q==
X-Received: by 2002:a62:d281:: with SMTP id c123mr30797235pfg.210.1552275753349;
        Sun, 10 Mar 2019 20:42:33 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id c13sm11291259pfm.34.2019.03.10.20.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:32 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 1/8] t7600: clean up 'merge --squash c3 with c7' test
Message-ID: <6716d28a5187c44c1d90f5ce840c44441f62352c.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cleans up the original test by removing some unnecessary braces and
removing a pipe.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..d879efd330 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -233,8 +233,7 @@ test_expect_success 'merge --squash c3 with c7' '
 	cat result.9z >file &&
 	git commit --no-edit -a &&
 
-	{
-		cat <<-EOF
+	cat >expect <<-EOF &&
 		Squashed commit of the following:
 
 		$(git show -s c7)
@@ -242,8 +241,8 @@ test_expect_success 'merge --squash c3 with c7' '
 		# Conflicts:
 		#	file
 		EOF
-	} >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
 	test_cmp expect actual
 '
 
-- 
2.21.0.370.g4fdb13b891

