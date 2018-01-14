Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990161F406
	for <e@80x24.org>; Sun, 14 Jan 2018 10:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeANKSn (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 05:18:43 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44115 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeANKSm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 05:18:42 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so6807547pfj.11
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMei7Icr0Dw/QVkCDC/NnN2ZRm/L5UN8M/BCHHKiemk=;
        b=DtAwYEeb5Ae48FnSBtOR2oeYC6SWiJsGA4OYmp+ke0jD2Ww9ltW2BXexQmvoQVLuao
         sjAHbkasC9WMg1w18e2PS6gpNB3Me132dZ6K2tBFGcakGcBad/dpdRLiliXBqE3wX5OD
         svtelcPryTaIXXQ8LxjskETh2dbW7Yiz3Mmut+thIQpg6103JSss9L4mcM/P6yh2KFzz
         fd8jv9Y1vPFRG4pDrhKQKEKmY/N7gBdgiOowPM7JLKVEKqOCGbEJhuO0CON8PWqLm55A
         0229CjT/TRF6uaEdmG8loGW6cwTehLI34z/G5hCQJsqcCeQCyG30esbPKcoraE5OhwHm
         0YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMei7Icr0Dw/QVkCDC/NnN2ZRm/L5UN8M/BCHHKiemk=;
        b=fHhRqNBv7h5lr2T2mifHznf2GhzCitaerGi2o65YP6DyMbzRhVRU4CFP0T9qByYZdE
         uYxT1yci2oiF6jeZf1yzf+71yZWARgdfNYFNouIb1bhDSD0biKs0PsobhcWpPpDiJqZ1
         ALT5OFBTOPsONclisp1+fqhgleiksJvLnCzkEuJnQd6rrAQ2sU1SVAbI+Lqh2n7urYdY
         z6X29lirQRkGHOoKlMU2d3wPEsTVzlkUDXSZzOHhhDpyNjOLpfmpYyUCM9dMyhltBHVb
         9OFRNuq9hVoQ+kv+KYeW0CefaTxRPrEUZWmDXydaZDBPqQbnUuxRcUx/bfkgttUgqbja
         T8cg==
X-Gm-Message-State: AKGB3mJqGjDXdVQg5H3GK7kIH/mPoWuMr8MxXTmLjVyXndtxYTcSGJ2r
        wWT7rr91XQqG4/8xOZCGez42vQ==
X-Google-Smtp-Source: ACJfBoswPFH60xvGO2e+IDxjavrYfMR6NamaJKFf1ffTOP+n11x7a8BeOYKUC/SMd6HLrY2m5Lrmfw==
X-Received: by 10.98.65.216 with SMTP id g85mr28631554pfd.76.1515925121412;
        Sun, 14 Jan 2018 02:18:41 -0800 (PST)
Received: from ash ([115.73.186.82])
        by smtp.gmail.com with ESMTPSA id w83sm31265859pfi.56.2018.01.14.02.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jan 2018 02:18:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 14 Jan 2018 17:18:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, larsxschneider@gmail.com, bmwill@google.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        szeder.dev@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] read-cache.c: change type of "temp" in write_shared_index()
Date:   Sun, 14 Jan 2018 17:18:18 +0700
Message-Id: <20180114101820.4273-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This local variable 'temp' will be passed in from the caller in the next
patch. To reduce patch noise, let's change its type now while it's still
a local variable and get all the trival conversion out of the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..536086e1fe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2474,30 +2474,32 @@ static int clean_shared_index_files(const char *current_hex)
 static int write_shared_index(struct index_state *istate,
 			      struct lock_file *lock, unsigned flags)
 {
-	struct tempfile *temp;
+	struct tempfile *real_temp;
+	struct tempfile **temp = &real_temp;
 	struct split_index *si = istate->split_index;
 	int ret;
 
-	temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
-	if (!temp) {
+	real_temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+	if (!real_temp) {
 		hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
 	}
+	temp = &real_temp;
 	move_cache_to_base_index(istate);
-	ret = do_write_index(si->base, temp, 1);
+	ret = do_write_index(si->base, *temp, 1);
 	if (ret) {
-		delete_tempfile(&temp);
+		delete_tempfile(temp);
 		return ret;
 	}
-	ret = adjust_shared_perm(get_tempfile_path(temp));
+	ret = adjust_shared_perm(get_tempfile_path(*temp));
 	if (ret) {
 		int save_errno = errno;
-		error("cannot fix permission bits on %s", get_tempfile_path(temp));
-		delete_tempfile(&temp);
+		error("cannot fix permission bits on %s", get_tempfile_path(*temp));
+		delete_tempfile(temp);
 		errno = save_errno;
 		return ret;
 	}
-	ret = rename_tempfile(&temp,
+	ret = rename_tempfile(temp,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret) {
 		hashcpy(si->base_sha1, si->base->sha1);
-- 
2.15.1.600.g899a5f85c6

