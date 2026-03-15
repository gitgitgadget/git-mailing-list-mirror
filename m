Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E443368B5
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773573565; cv=none; b=V/RZ/3+GU710uINHeA/CIxX2lcrtjLVvCnIhD/TOHGqUEjr37LWEXGgfJ602/xSRrhYJN0N8Ricynx4RvGEC8qtw/j8/MN89cJPaiEr4TIIfEsJWd2SyEAO4MH/vYxyDWQUZragwP9rqR94Zp3zPJalnjl+xIYl0eh10ULz3MUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773573565; c=relaxed/simple;
	bh=gJ4IlDJ/XrBMGQgVUqR+Gv5OJmZdxLSWbWKG7cc8FUk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Me0SzBGptRpG2jHTrMjCnV9/WheS4SbsHp8z73pMZ/aAAK42QnT6svBqehze0MsNulzu9Zot9MBwtSrhjxfKzfznP5pbenWlb2WtPnxfuHKPWU/ROS6brYozUuneY8OKca5QBEuVJJJWRI81B60NH6BGUi7EdCKZd0dCgRq3xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0i5kNVh; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0i5kNVh"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4048184eec.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773573561; x=1774178361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM9vvjK5adSTxVSGIFfPK2SdCoOIAp53eJyHlFtRMjk=;
        b=l0i5kNVhJNwdc6QhBtovIyvjYl9ESB4TnSVEc+pKSlUo0NP3QhGoReLEXgUyFZLtTw
         69Lc73Twb3BA66xdrq4APZRwSGUd2OR/N9DqfiEc/u6XysLw1yE75REVPVqq7CISNa1J
         He2I7c8vZlQTpJXOQjEUcmdI+SQmZtDtRmo6wmj/v+b5ddD1k4Ir09UKkH3w4sJE8eRp
         GYDCLGDy2CMb71x7r2eFMJ654xg6TSlcrLiuynSF5I6m85br6Qj0EociqvI2B62+61SC
         lZ7ZFYrXT/sX+r7tJRJmMMrQCLlhQhbECuMteUSOTgxvj3nmQRRCqan1zu8VLuYcepfV
         uwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773573561; x=1774178361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vM9vvjK5adSTxVSGIFfPK2SdCoOIAp53eJyHlFtRMjk=;
        b=F1+A8wZ3lmpsuAFj8B3t0nvQli8d1to6Ik28QVFlKu/hxGym7/+gfptmovFJn4WM5V
         idRMiuBtQYT/4K3+5FZgw0UlijG2JpPJWA91TDyabSAuzl76zX0GWiLszhO0mWk/xlk6
         IHPkorjMgfdgcOWWHHMvesRAoFBHwN37la+94DocsxiGrSOt8n5xWiznc5iBwmht8plp
         02rtdObN8ei/nr9hk9fBGEawW0IkH/cIXqdtqTn+UVr3yLHeJ/rcgplDF+t9VYFexLBk
         8qmC3ofUdzfhyYwqguy4/dN3ORLyRvPAZTXLDoIbk6XJ35jqa/YCYmjWVIR7bABn45Z1
         mOxA==
X-Gm-Message-State: AOJu0YzkA/W/dqmp6BmS2qBX/DXIcaVIuQz0L+NcuKaVaOghtmdbE8py
	dbOFAbajnlMcdLXnbTfqOAt9rEzfTSx3Ic/+LEU6KzakXuNwpmamiPIk2Y6zYw==
X-Gm-Gg: ATEYQzwoFsecuk6ar71V0c6gRZZfi1Oam+yvYYHBVNO+5fqQ3dbIE2dUtVFAP3hQqEB
	vVFG7Jxom5XLErne9Fwq1RfV+Ig26dnE0zCBiXgKWnU9Pig2KMKIlDgNNfXtvYXiajkFI7hBo9n
	IHY3LtPIpr8+/w5+PBgG68ayIqz0LsQ85TdwAfquM2G9PacUXPY2ti99kAqDVoLDFTvx/qjUiAY
	U33nKLxX4CUhWTWdVfjeXmEciM4XZkZCput+oXwjT2VajUVYRJEwpqEPexnAsWjig4B8pT1AQ3n
	0Nb+VMGZdGuqoN3MohMoilzr0Z0NPZ7pIDQ7zO/gz1bIXAj/vX352GKrymaGWWZHVIfLDgaXhoL
	Dh9YMALdUikSUSdJ8HpL64a8aUcnX8mRowCQZ1tMRNSfRE93R7i0X1+tDwc8H3c07WEC74o8XYX
	rENzkV3DSmGROCF8aYvR3CVlpmr+o=
X-Received: by 2002:a05:693c:6086:b0:2c0:c415:cfd0 with SMTP id 5a478bee46e88-2c0c415d4aamr59039eec.15.1773573560656;
        Sun, 15 Mar 2026 04:19:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab55541fsm12033624eec.24.2026.03.15.04.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:19:19 -0700 (PDT)
Message-Id: <5d176f1700ce1f8e8f38af1af9ce8fc5823dc4c8.1773573553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
References: <pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
	<pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Mar 2026 11:19:11 +0000
Subject: [PATCH v5 2/4] sequencer: allow create_autostash to run silently
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

