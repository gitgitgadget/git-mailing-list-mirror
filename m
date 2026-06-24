Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57930C161
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274770; cv=none; b=E08ryKB7HS9pFjDtqZtM6iauHlj1cL+8YIlg9fn/k+pDulahjv02SQ9aQN5qxBz5slL6RZjredWnKlpPmWpY7C6BfWx0sokpVEuVhGbvGMoSkRl1lUEY8M2AyZUkFhF75BM1TvNoNhcmAn7Wfh6oY0UAJK2H5Tqb8KO1mFafFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274770; c=relaxed/simple;
	bh=vD+QUfZ+Dmi/waLGb3G34T9vWA/C90JZvLGzYOIC6+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQJYI/G7Wfdju+wxBW4basPBHZ5ml+cTvVgOLol9rZYfpPFc9bb8/xwDrgQzEParTSbiYASAWXNwewdnv1e0IeGLjYbwcMVoDweTgjo231PxcoL4lxdcwNsqUgZjHKSTcq5n7yOjMId094EgjOUzF96PiC1i3nIML39JYnZtJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pa8ObQI6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa8ObQI6"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48b7df4b4ccso1008390b6e.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 21:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274768; x=1782879568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBHNGX24n90/Yl2iK4KG6zekWz/ExXyxA6jkV70nP/Y=;
        b=pa8ObQI6qwn29GhwyUJHHGoHA/kqPs73sODzxCRYUHZR/xkZiL7GOzX2SQFWSpnUPJ
         0H6OW5EJEB3MulNfLGytKcwZtXXJzBamKCTw76gF+6heI0RU2CMWbDC6WX6UUFR49mR1
         IQZWH2H8NQwy4DUKRPOpdgc1elbKXmy2twQwyER+Nsos6u3SHmYrzcmZf7buo5d5ml1u
         k4wEqbuAUtEswvYp4+0w13FsS6xBK8FLz/O/Y3QFg+nu0aKzprGhj/k2uBDF6yacFFMv
         a8VV4c7kJdh9HyrdEQTTMvvVIpMWvZEv7DA3YuJquuchWSG9ewS3k9JRUbFNrL9EbPGl
         UDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274768; x=1782879568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBHNGX24n90/Yl2iK4KG6zekWz/ExXyxA6jkV70nP/Y=;
        b=WkJ7yupnyUznVGGcKBG4gh90PU4Y1aG4DihxHk/YqKrP/VIR6/bQjk+QCpKbZAWa3o
         PT6KD82soyxQDgc3u1HUGcCuPIJiAZs/NlxEEFDoLjmoIBMYaHokwQbcEU6qRO5L3f3l
         mc91W5eD2GGfhBv/1IRmSzNXi038C5cWCbh3k0EhwJj8ifxRYjNyklGxhI3kfUG9+T1w
         E+YTqY9tQWy5fv0fkAOKiF4Xt5PsTBBT7oOtxfpNbDK/DreY1VTpUwaXum6xzP+ubx4W
         tEzwA6D+MCinpujk4maHJxB6hX0wnCYy7yA8o3gEVvYpHG0PItE+oPZ+MtRLe5LcT4p7
         ZClw==
X-Gm-Message-State: AOJu0Yw8n0dyHVCk8fE/vBxpqEIK59vMmPSlB/E4WK0r1OUoKNkZsEcU
	rDRbenBk1BtbNNGbJAkZKf2ogYJLJ+8g4A1TgpofZjMOMVgmlx5LnglYcQadWQ==
X-Gm-Gg: AfdE7clormy36tWv+otFCJ6iT0dpa0z33vrFfIWo6OH5m5O7IxVrfJ6DT9tIIGAqTjq
	M2lWtLX5c4VE42DqBsaeZX9yMfTiWUTvQAzY5cWHvR/+GQLE6ubP21wwV92XZoFq7dEtyR0xpQi
	a08e+NoWFT4xfxQdzhpHye7T8h8TdmfSiwMXJeTzh40KBQDwc58btNVBBdCwpUlyM+WpUDYUyy2
	qxlY7JkHvvD9xraOVOkBSgXM9JM2mbh0znvIhs+P6DgVqI0WLG9bP+YHRqDeN/VY4rBgwFjEDzJ
	jdGLOonVekFMLrcfP/AdO7oCTvloLCU6oSfD4znLGA9BrL/3Bb0WEpDwH+LzurHfdZ/hemIexAV
	U8lAC6YwRdIFWiAxyGB3M6HcR/vZ4zeUnts2dnonuYeNDbo7cwGaqkZV3op2SIqxS7/9fNSsolr
	7ezGWoGkDvViEUp4tGtf8Z
X-Received: by 2002:a05:6808:2204:b0:487:5e6b:a3fc with SMTP id 5614622812f47-48ee4783bbfmr3566700b6e.18.1782274768227;
        Tue, 23 Jun 2026 21:19:28 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf21f5fsm8111799b6e.12.2026.06.23.21.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:19:27 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/6] object-file: rename files transaction prepare function
Date: Tue, 23 Jun 2026 23:19:15 -0500
Message-ID: <20260624041920.2601961-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "files" ODB transaction backend lazily creates a temporary object
directory when the first loose object is written to the transaction via
`prepare_loose_object_transaction()`. In a subsequent commit, the
temporary directory is used to also write packfiles to.

Rename the function to `odb_transaction_files_prepare()` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index e3d92bbda2..a3eb8d71dd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -499,7 +499,7 @@ struct odb_transaction_files {
 	struct transaction_packfile packfile;
 };
 
-static void prepare_loose_object_transaction(struct odb_transaction *base)
+static void odb_transaction_files_prepare(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
@@ -761,7 +761,7 @@ int write_loose_object(struct odb_source_loose *loose,
 	static struct strbuf filename = STRBUF_INIT;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(loose->base.odb->transaction);
+		odb_transaction_files_prepare(loose->base.odb->transaction);
 
 	odb_loose_path(loose, &filename, oid);
 
@@ -825,7 +825,7 @@ int odb_source_loose_write_stream(struct odb_source_loose *loose,
 	int hdrlen;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(loose->base.odb->transaction);
+		odb_transaction_files_prepare(loose->base.odb->transaction);
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", loose->base.path);
-- 
2.54.0.105.g59ff4886a5

