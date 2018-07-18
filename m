Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891581F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbeGRQvS (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:18 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:47103 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbeGRQvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:18 -0400
Received: by mail-lj1-f170.google.com with SMTP id 203-v6so4572547ljj.13
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxRKCy8KkA/rd1acLLw4I3zngcNtamwwR/DaKg7F3y4=;
        b=DlMlTU40Gc5JW9O7e+4lB8R1ujnjZTBHPp5gAlb+NGcU617RMGi7CBLlwyCyCt6iXq
         cra3JZP0SozMu41bB/2Vl4wiSo9/yzlBfoQQuKiCNThOwx/bNnCEbDuQextMIePAmv2e
         uplq6rwCTuOhvviMI8uJVS1hqumu86GzAG+qUhzTHRjJmXMmdPspm//o5q4w+RujNeST
         2kCl4w0G/wTFiREJVBpbzJpmz+mN385YninA+lmINigCrzmRoo61J/Cj/TGbGkrhdGGq
         zwQa36t8kCXu+Af0qDoOHE6FiFIE1+Ks3Tt+1jQw1uIspK18a0s9ap+Lg5UGK9+p7nHi
         e36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxRKCy8KkA/rd1acLLw4I3zngcNtamwwR/DaKg7F3y4=;
        b=uD5AOONit67uFFYNn4+HcPNQcbBn5aypIC0DF0kGeS0gupIi9BxHYobPV+X4xiXxdr
         G8dS7zSjfVfnUKNfDrNXgHCb+0JC47WtrDbfETsfTYayt1VWt1ySqDpYiHHQwJ/XiUdH
         So3bHtAaqM1TB2xKurcSokGubKcNksvBXXRQbp4EqaSIkoTaOJnrg40w3acGq5F0wvUw
         j6EnGdQaMWN8vT+kdeeMdPRJKIq/ltLunzatuIHQnWcAJhhRR8mqMfhjn/0gTcsNsYJH
         4R5iVEgUx7Mg8hoLj31BkUxPtkcK9+s9w4/xktT3di6v0RBm/L+6oTfgsK8CUo/RCCbn
         P4Xw==
X-Gm-Message-State: AOUpUlHyBiBUgO9ytey+PwxbFKeaV1pFn/bp+4thcGbBLjaFn80GGLVC
        VU9iZykkMBLt4PTVwNc4utZUlw==
X-Google-Smtp-Source: AAOMgpeRPZm6T8er1Rj0wksvBw9gAaRdZgkHvHpugzQ1WR+z+ZXZAxUEPEXmfOmhO5ncmgm+Z9wMBw==
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr4965838ljb.119.1531930360661;
        Wed, 18 Jul 2018 09:12:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/23] archive-tar.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:40 +0200
Message-Id: <20180718161101.19765-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive-tar.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index b6f58ddf38..68e72d9176 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -121,7 +121,7 @@ static int stream_blocked(const struct object_id *oid)
 
 	st = open_istream(oid, &type, &sz, NULL);
 	if (!st)
-		return error("cannot stream blob %s", oid_to_hex(oid));
+		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
 		readlen = read_istream(st, buf, sizeof(buf));
 		if (readlen <= 0)
@@ -256,7 +256,7 @@ static int write_tar_entry(struct archiver_args *args,
 		*header.typeflag = TYPEFLAG_REG;
 		mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
 	} else {
-		return error("unsupported file mode: 0%o (SHA1: %s)",
+		return error(_("unsupported file mode: 0%o (SHA1: %s)"),
 			     mode, oid_to_hex(oid));
 	}
 	if (pathlen > sizeof(header.name)) {
@@ -283,7 +283,7 @@ static int write_tar_entry(struct archiver_args *args,
 		enum object_type type;
 		buffer = object_file_to_archive(args, path, oid, old_mode, &type, &size);
 		if (!buffer)
-			return error("cannot read %s", oid_to_hex(oid));
+			return error(_("cannot read %s"), oid_to_hex(oid));
 	} else {
 		buffer = NULL;
 		size = 0;
@@ -454,17 +454,17 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	filter.in = -1;
 
 	if (start_command(&filter) < 0)
-		die_errno("unable to start '%s' filter", argv[0]);
+		die_errno(_("unable to start '%s' filter"), argv[0]);
 	close(1);
 	if (dup2(filter.in, 1) < 0)
-		die_errno("unable to redirect descriptor");
+		die_errno(_("unable to redirect descriptor"));
 	close(filter.in);
 
 	r = write_tar_archive(ar, args);
 
 	close(1);
 	if (finish_command(&filter) != 0)
-		die("'%s' filter reported error", argv[0]);
+		die(_("'%s' filter reported error"), argv[0]);
 
 	strbuf_release(&cmd);
 	return r;
-- 
2.18.0.rc2.476.g39500d3211

