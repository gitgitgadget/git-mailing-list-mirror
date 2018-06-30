Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA921F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934455AbeF3JIi (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:08:38 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38155 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754103AbeF3JI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:27 -0400
Received: by mail-lj1-f181.google.com with SMTP id v15-v6so9069147ljk.5
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxRKCy8KkA/rd1acLLw4I3zngcNtamwwR/DaKg7F3y4=;
        b=rl4p3eMJatIKqJTfdhR67vxrBVBQoFXdX2L4bH+MGhMyvcVoTZ/x6b9od13/Dwc/bc
         8rrG3ARy1XDSIf4ACm5Krdz8e/BpKTuZyeNSErkushMCFSKYUXmeIx3myd+DYbkayCQB
         +3dKUGJVyHxtzfo0nerUDnniSyKDA8Tdzfd8DDQixVibjjUfWixRk+2aiySDHyOszlCy
         O1/4UFMKa9InZnFMxY8hvuLHsL4hl5sGn+fQheUu4E6q/RkWKDZzuSpdXkKykBoE6dEH
         uf4xmx2KmcOkYyXrEUC5Df2MblgJAbFwxQkS7xNhD0ckvBRilky4hGiAWpUZCTrg9Lu/
         MXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxRKCy8KkA/rd1acLLw4I3zngcNtamwwR/DaKg7F3y4=;
        b=fT5EfLP2wc/3p3LQcmjKOMw7i3cNyoSO/7eRsVskubtieszPnksTQl1SuQu6zT5A9u
         g7Ol7F7oWBneq7gk1zuNcwU0TJ9wmuos9M6rxA/wctcz0TLRcZgCutDag/cWaJ6dro3F
         pPiRA8S1c1/ctmB4fXi5gLkY9ecTx+20+A+4McW3brBtfdTh4cqQROvD8F9r/udjwG5F
         ARUwEZuXDcZpP+/WSBlHM5My5x6j33hlL4Xp6HKKfpey9qCmeQvQd7OuXD5TuRd+FKU4
         Y7+vLEkFl87b0XVIdX0Vz+j+HVV+oaSdp4nni5mOx1TxvYa/GKIooEVCbLjR0GTw5Om6
         2mDA==
X-Gm-Message-State: APt69E3mCplIhDgKTgy03XsX/Q/8s2Gt9VP9Xy/qQl4+rYGH2Nox0Cdw
        mISELxHF7iR7xZERrydhwV0CsA==
X-Google-Smtp-Source: ADUXVKK1PffPoNe3iWbjlh9D/+6u9MO1S8SMnmuoJWytyGBaGnZD+KTugFgCASTD4GoofKvLsTkWTg==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr11892239ljf.120.1530349705737;
        Sat, 30 Jun 2018 02:08:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/23] archive-tar.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:07:57 +0200
Message-Id: <20180630090818.28937-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
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

