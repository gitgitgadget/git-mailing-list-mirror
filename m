Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA124282F30
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762243; cv=none; b=GnL5XRrh91YQ1aHFHVGsMJrz/Ox5w6BP35ldUUVr6B6kbVqFeocgFS4I0hIwv6uCWiwZWJJUafsdgU73XmM+W6pv54YJMedFUr+pwVU0CKIYXIj+EOPIaMs8FfkV9jOxsa15SOuX6f9hRNbi3WyHg5VAomITX+8gtXmXD33neys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762243; c=relaxed/simple;
	bh=aerVltdC9CL0GTUN+goGZKeYyjOQdtGrqjYAIwKWgUM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NzpHGXbzD3aCNvFFhU4fMvgBZhLH5/zXJ2HrIepfVChdf5rueyM8vblUr+jPSqZJBn+ICyPKlZOBX0CYhSS0/1Wpl1yHgOyb4bgPDZKHhng09r2bAgZ0/xGdw2WIgVi5k1G2wwsH+at/YcXhE2fiRn1GeQtg/iZ1Izbylbg5E0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAWiJoqn; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAWiJoqn"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1a170a50so1102961c88.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762240; x=1776367040; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9yzHLL0eDNEtURdXCitrp7JMf+msL9yqpE3QQ0aCxM=;
        b=mAWiJoqnFAARBL9FqOCJwwXPL+Dr93ACnZR4c0e/8h7t8Ab8W6lWs+rxnacstFDOgI
         x5ELnUpFL+1dQDEyly2XiDIWna/bh6tJiqfHkZ2qhka5kmVFO+KvlMm7kJgmW5PU2GNw
         qso4e8yOud6IezcFtHeAqZkaokfxwXvylBNMB3Hiu6a5Ljq3uAgBgWqxbO+6x7E5uu5I
         Y2r7qnUN5OAF4R+O93ki6dsRoU3i5/rTXRGqdO2ZzXXQnxogkE5LxPA39MMf4g2Gyius
         UlVfPeK4dVoKyQDX3B/mWLK98yAE9ud85LvU7zN6rViEv4BSnvOitBQfXCDBt2Ahuorx
         0nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762240; x=1776367040;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9yzHLL0eDNEtURdXCitrp7JMf+msL9yqpE3QQ0aCxM=;
        b=iTh5dCfViR7Xl5sgFtWkDfz4XQOGAcVhFHQvi853OKQ9tKHA3SY4iNnGUaFHjsM9yP
         LbtIr5s5tgxNb/PmP5t1zuZ+CtNlKH48tav+Qc2VXFpVS0g1TaZEo5Id6U7JHqui7t2d
         ASN151JfLlnJT0u9b7kD4TzOl5p4vwYeK6+N5ItmygyvpgZyQ6p4P0en+Vo1SmjcavLO
         vi5tP8WWJpQ/uv9AsXYa4WzaHOqVL61IRNMBsMitFOndExoYIS4lw+ny1AxAFP7hosCN
         POvUxwj8/B0MeukohNPqH2HlWSfbtJcuV0J+nQBSq7sykg0JHu3Rp3Y9AFBAy5eM+qKA
         JF0g==
X-Gm-Message-State: AOJu0YxP8OgRXttK487dB7wCh5EIyjRdBDtaHSHcujAG2m3U9qCwF7Mx
	DfJz4fOpiMqXRLfdoYkyoIV3WZD4+f+s2VFEQ3J1y6YO0IIgR1+TQn+oCZ/eEw==
X-Gm-Gg: AeBDievERELU2Un4Stf3DEpmymsm8VoABR5lL8CyC/DR1Qv6/K72o6DLDicSDjPYIhO
	RDao8Z0T+jx1bxIwOw/POLmnA9m2JFoz2IKyJd5V8BQre5ik8pmIP5Maoly7bxFOWMwIcuq4jo1
	nFIW0ME3OPHBYIISOHJ4/q+MkZbMtExZhuO+mLT1z4R0zpBjebOpCQfpabVqCLTe+ub1FHX3Waa
	M1KrLdo86eUXjvthLnSZnFaqKCzgSmW8bRAYxArAgerS9LiIDhPeJOOC5cQf6v/iYZAVRNBj94X
	4UHs4mvR+A/OM2eVtkG0IT2B3LTi05ehEixaK8E1A3STUgWK4uuRhkUBn3hQZpoI52QazfjHwZ5
	lwhQkSqYtbqZAEPPVvk9k9KhoutKAVT0vf7AfU96+bjzvKkMCui7/Wojk3Xzbn0vOu42r9b4hL6
	02J0AhBexJq4G2wi2lSHCSYtgsH4Vi
X-Received: by 2002:a05:7301:d16:b0:2c8:7172:3b8d with SMTP id 5a478bee46e88-2d5871b0783mr204087eec.2.1775762240095;
        Thu, 09 Apr 2026 12:17:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm998156eec.23.2026.04.09.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:17:19 -0700 (PDT)
Message-Id: <86cf68d0240ef90ce941cc162ada658a5058795b.1775762235.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 19:17:13 +0000
Subject: [PATCH v8 2/4] sequencer: allow create_autostash to run silently
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
index b7d8dca47f..e500a94a59 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      int silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4702,7 +4703,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4716,17 @@ static void create_autostash_internal(struct repository *r,
 
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
index a6fa670c7c..570f804457 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -230,6 +230,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref_silent(struct repository *r, const char *refname);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

