Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40D18787A
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740145; cv=none; b=Rya/Lq6n5c+oZNhKvwIVpsQaGRgwNmQFOEwaIV0O/Oe/RQEjR8crDbniy9UNxSNZktntYUg3Q00XmNEeSL9laB9+NhAJTP9lykYomDXuMPCCCAp4oV97JvcU+16wLx8ZhO1oi9T1AhdjQIRQ9pwN5syGKLL2n7mE6m3swBYoXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740145; c=relaxed/simple;
	bh=gJ4IlDJ/XrBMGQgVUqR+Gv5OJmZdxLSWbWKG7cc8FUk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WLWg/FImbLXRQrFpQpyeYT3vLlspV7Phziari2Hsfv7BGoXkJHbOYRb23HEzLQfeZ8lvHPWbA8JWsgJ+oeTxN3nq1d2NQBICBH3NsmFMlTemH55TpgwbHzHTY5IMIzhzykmidchyGYTHUWDxQ79pwozwVYWM5O1dCNN/nNNTae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8rIZ+ok; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8rIZ+ok"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0484a6de4so12088975ad.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740143; x=1774344943; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM9vvjK5adSTxVSGIFfPK2SdCoOIAp53eJyHlFtRMjk=;
        b=G8rIZ+okhfN+MgtrGja3R0G0JAz6B77oaNFwNfAbiUKNI9xf8b9ATPlIw4CBLb73Sv
         8UQ5G5qABLIoiQMq0H5woMOM72NzOzAPM/3D6pp3iutHYR03efTQ0665j2Cy5ziKPvH+
         S+U7A4B9Qy6r5hcQHb5IaDW8kuFOxdMancrgS5rJT98C2er9vVw28BEkMyrbLBeK0ynv
         Ign/lMPm0nS6k7BpIhPQFYiHL4Ijh1nmLKoxl0GV02GciGmWlwpAix5/tzmg4LJ9Fj4b
         8Jbll4zCr/7CoXJkBLUucdrwbimSYkHN8pkz+qaFOR/iJ10APzczfTQpUrQ5i0zDkg54
         S0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740143; x=1774344943;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vM9vvjK5adSTxVSGIFfPK2SdCoOIAp53eJyHlFtRMjk=;
        b=DpG5ruXaEVjWX7vBq/N1c8wimjkuiHkreluJT8ZEWTZzmaUV/iDzL5jGWCq4/mb5tY
         Z72Er+WSiKgGitujCHyNEYA8GyjIAYghHNK1AEOk4roRR7KxNfSP+aPKIQCdtQItUdJv
         +wR8BuZl8rMPubsj0V6SizpVhIJP3joGlwfFUe0+Yp848D8WM+irlx5FUS7fUb9dyrGe
         Vi+xWCvBAhzt9f7EKivInc1qp7zB6N/EmJT4ZhqNgbNv47e6DkAMaeEdTmY3V4WzxL4k
         zZlHsnGDrRA8HhgiXTtBZVZyBi8PMTmObwUl3vY5aXNm/hORIIHyJuskbepJ4Rt24GhA
         5PXQ==
X-Gm-Message-State: AOJu0Yx8yTaMqry6IggYt18H5wJLgtP4xCUpL7SkVq2DJ4uvOrO/Hq+F
	XuxP9DKwHFO246fNsaUA39lnjGTSpQT8jqqxaEkKt5FuUgcopP/vxTI9GeblCg==
X-Gm-Gg: ATEYQzx1/PRd16LwYfXlGWi7jzZ5E9qjIxwPYxSxDAUXwtCrX8agD1VONx/vjFj13NZ
	P8sP4lSdzKuOK2htkfM7NC1K6VqvBc8MoOUhD6ZT4o/CDW0YI0it1Gk2u2P9AiZ5jtTXfemm2zj
	PimcSWk4Kw1TpJ1MrDMKjRBoq+MMSEYhQqfNbpfPBnPyNPkVNHdHKSXCjSmCwdyNF37DyoacHaS
	g/kZhNhGAhKGQK1tnUbRo9+ROHgsOaDgF6+uVDTWgzuqDTsWCyvNxT3kQKiT7alF3nCSBERbLGi
	lICoaZRK6tJZXMdWb7ftpB/5Oi7+DSSO1uYp7G7z+ZyhqEBku5Nbl9VH1xH0IK8Azbs+U0HVur5
	vAeNv8FD7EKjaXFaVx+v4dw1AXRSHpOos/yAaW84BTpnddTMg9l5ArA7sIMxG9wwCowIQgPfpxe
	SaiOCH8XC9FFcfhy+7RzZgVhZuAGPFOS5zBg==
X-Received: by 2002:a17:903:3b8e:b0:2ae:3afc:eb42 with SMTP id d9443c01a7336-2aecab04a1dmr154010755ad.38.1773740143497;
        Tue, 17 Mar 2026 02:35:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.221.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05f0ab2b7sm60462415ad.39.2026.03.17.02.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:35:42 -0700 (PDT)
Message-Id: <d572c4bb7df20b1dcca50f279d4a795027471407.1773740139.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
References: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
	<pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 09:35:37 +0000
Subject: [PATCH v6 2/4] sequencer: allow create_autostash to run silently
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

Add a silent parameter to create_autostash_internal and introduce
create_autostash_ref_silent so that callers can create an autostash
without printing the "Created autostash" message.  Use stderr for
the message when not silent.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 15 +++++++++++----
 sequencer.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index aafd0bc959..eebefd731b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4632,7 +4632,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      int silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4677,7 +4678,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4689,12 +4691,17 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, 0);
 }
 
 void create_autostash_ref(struct repository *r, const char *refname)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, 0);
+}
+
+void create_autostash_ref_silent(struct repository *r, const char *refname)
+{
+	create_autostash_internal(r, NULL, refname, 1);
 }
 
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9..0b09d6799b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -227,6 +227,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref_silent(struct repository *r, const char *refname);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

