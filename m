Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAE280CC1
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781342195; cv=none; b=l98+tBkYKvso8dUlkK1993E3+WMNUVkSxFtM9bgvwzqltPNrqFDRVt3hEkBmkzXDWEvMkrKlY+IScQuHEBZZASUMWClH8QHxDlt5ONuZXnIY2AxLyK2k2GmVJNeUM4wGbEdUd/6UDyp4Z7poNiUKtqp6O2Hwakn+v3OSRso9IFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781342195; c=relaxed/simple;
	bh=lmzW+qFqvH9S/cUWCZ34z4NUcBO95DHg7LrJfhU0rVo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pIrz7oApMdRB0u+UEwr6Bsotzwi3mniLWjjHbX4KxK9T2s1d5xlE3uDkko6ITMgNExm+3BuueeOzjnyB3EayI3ju0FNTojCZcU8F0HYFMnrEPajLz81GBovhUx8eHHoz28djm78YjohDXdWjx8C5EWT0VqTcKyAjUlCc30FJ+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRSuQX9F; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRSuQX9F"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-517de710886so14489981cf.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781342193; x=1781946993; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoKCCGfcOiooXeH+W273x4qwNnyOecwOLpJO4Q+1KN4=;
        b=KRSuQX9FQqj9lqfF5MIA1RvIpPN7K4DnJ7g/s3I2I4uyJnH91e7wCa3j/y7yL4kRaQ
         UxRrbb5BlcIhSjuSqQ8TW+eBWYdhoTeHtdtvEr77U5f1VKJp05CdQcLF6rb2p8x+5jgU
         sQy1Hb/4k63oHjhLu5AFM4i8/6hQXplXMOJN0vNAvdF3X03sfE9b5l+lxEAWqpaadRA7
         fXahlPRTT101E31XeKV0Yoy2nzc7xXuTe4qXHubHtJ8u03yOH2O/YSttGqOMMWXbBdlH
         8Zw0Jw0E0W+8805PR0MHkYpP3XFL+53I72gPo1sNGh6mCqNmGuu9f5HB6Hhacr8JfTsQ
         f/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781342193; x=1781946993;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RoKCCGfcOiooXeH+W273x4qwNnyOecwOLpJO4Q+1KN4=;
        b=bQ9i1dD/sOI1ZUMgrm8IrfT6pzZzQRx99bUPvVEXmnz4zkuzybIepEL1z+gRX/xNF4
         O9/qS9yZOnSoJexg8qyQZ/QLSEvntukSxGmtW47aMMwR+lMiYJI6u0bZ7Lp+kz7YQTxK
         ERlIUG/8WcH/n8/Rh3y80ZFbb98ADuYefMudt91F9F4FSIROdMqYGWO6YzNwIPWin20C
         EsyNMMWDJNjG5dwV+Nglk6asuZvCT3egJwyuv4yzNWVX3QDWKeuroc/Cqri2sb+t0/mr
         8SCiySKLlJ3NYFCrIKrjaH+rt/NLEY3BbmnlNloSBbigEshxXpBwRutfucDYNim9GLRe
         gB5A==
X-Gm-Message-State: AOJu0Ywb3sxwZ0mXdz6f8NbWaq9VA+losJQyQnCHgDUnMI88TldfIZE1
	0PHuDhcZKl4jT9yWaFHt9Dgf6Yj7gu5uYwCyGtWRT7Iw+juwpaNCNaIm9rupmwqN
X-Gm-Gg: Acq92OFIS1gMt5HwUWY5wmkkx2KUYYebkkF/3eH8IaHmViJ7OLbmDaF6u4M5hW/TGNv
	RDcMAfP4pzR2ZgLZ/1LHJ3rDAScHPyotn/g4Gm6irZr7KD9P67XzEZF7mb9l26RfKGxBrqAlYHi
	GTR5PTgOunv3LWUVn6AUqTybFjIbsZRjm+U2nqnmipAPc8gxymNfXpAQpnqYt2Q944PXrnT7S5D
	lA13HHOS6gP/IFcBVqGsEyOWMoKMHYjsMflSeLF6IbdygmSm08VGkF4Eny59KwNVUmdvPQmWD0j
	iHIpF7uuDP8IGIv7m8GKo2DskKgfK7I113WXSbHflyRNYR3qMcD9CZ/h8qCJjADzbSWrYTQfOEe
	0BpVugwOiDqH6IBhuo7KDLdl6u1hlqxxNnephIQkLXiqq1P2MHUnS0o9CFjKNpJuMYF27YJpwTO
	GKk9g09WUn9MWwYBreKUBTTcqR6Aw=
X-Received: by 2002:a05:622a:4d06:b0:517:917d:e3e0 with SMTP id d75a77b69052e-517fe4ddc18mr96237931cf.32.1781342193216;
        Sat, 13 Jun 2026 02:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.134.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642541sm44459561cf.10.2026.06.13.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 02:16:32 -0700 (PDT)
Message-Id: <ddb720a8bded60b6efa35e571dff0e23ffb7b1a6.1781342189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
References: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 09:16:28 +0000
Subject: [PATCH 1/2] commit: extract commit_index_files_or_die() helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A later change adds a second caller that commits the index lock and dies
on failure, so wrap that into a helper to avoid duplicating its message.

No functional change intended.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/commit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..1a51450660 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -248,6 +248,14 @@ static int commit_index_files(void)
 	return err;
 }
 
+static void commit_index_files_or_die(void)
+{
+	if (commit_index_files())
+		die(_("repository has been updated, but unable to write\n"
+		      "new index file. Check that disk is not full and quota is\n"
+		      "not exceeded, and then \"git restore --staged :/\" to recover."));
+}
+
 /*
  * Take a union of paths in the index and the named tree (typically, "HEAD"),
  * and return the paths that match the given pattern in list.
@@ -1954,10 +1962,7 @@ int cmd_commit(int argc,
 	unlink(git_path_merge_mode(the_repository));
 	unlink(git_path_squash_msg(the_repository));
 
-	if (commit_index_files())
-		die(_("repository has been updated, but unable to write\n"
-		      "new index file. Check that disk is not full and quota is\n"
-		      "not exceeded, and then \"git restore --staged :/\" to recover."));
+	commit_index_files_or_die();
 
 	git_test_write_commit_graph_or_die(the_repository->objects->sources);
 
-- 
gitgitgadget

