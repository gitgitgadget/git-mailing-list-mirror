Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8836165A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854896; cv=none; b=YmrWHgaZKOcIRjlAiPIQ6PG2m8d8euhVOq527t6WjGzjXSUHPspEpQfD0w3LAes/0ifCSBSDRUxJYRyFJdguoekXhceeMDaPd34ilhVJMZX8c0nUOg0z+tnCRuh40VoZ7D2S/QqPtf1p80Z5Tx6pfEVeRTrd16bYKg3/JZ89C6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854896; c=relaxed/simple;
	bh=wM6X1kOQ8RlWuvfEoeb3y4LRctIqntGIPQzSL9sCO5Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rHPbiWvtfTq05mFnxJV3YtqXkf3bgNQ3BjzEnYGNe3qcc/Ny1Jo6YU+rZZSxJHvNcMslqLRP7AF6PlKOFUSu6iOyTdDAPbtIj+yxR0AXN1Srf1yYMDlxeYHamcCWB90mvTWCJdjgJgpoEUCFxMkZOiBxRATx0hfR6XNrnTSE7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh79bGpE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh79bGpE"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfbbf35354so293916985a.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854892; x=1776459692; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45kNGcKZbNJJ2R6xHYB9UH7NOBs25a7xMtYNOIXh2zs=;
        b=lh79bGpEBdAsmjF5IpDgbkfJnOBGDT+N2W126OxdOI8E5Z8jqYL3o+n73Rsj6fBClI
         yWEl7bDSDD/yaDn6q7QfVCy7IxnTkkv6gDwNCq05YteFOz0nRLW1TIICTbXYKEsb3iav
         B9iZXybBxptc8hUIc2PkRRfzm19kI3ZfQELj3EBEYdQhAbi40LlYErkPR1YHXMlPGl/i
         0odWY1xq4vLVJv7+Av6voSXndTXfMIV3pFjWv8H3bD/Fh+E8Y2avlThWGnPaw9fpjr3o
         0nIN0S1HnhokRbMw2AVkISCYfywLawVeNbtPBiRBoh2AtcMmuOe9u+LvqVzFJDx8AyAM
         jMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854892; x=1776459692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45kNGcKZbNJJ2R6xHYB9UH7NOBs25a7xMtYNOIXh2zs=;
        b=cKLE9Yvb7cJaehmBAUp/kjlekswezfeiWxPclnkdD+N9Se3qABIRLt5lLnQOxzoO4Z
         l/y71AqLr/I3Y/zz4kYio9F2HGQY6zhtW1s0l7nhQNshYRxBaUJCAM5gK05HFgAgweoK
         QtVykZ3yeSZo9Cq/j30hT+y7sJ7mSfea/aKVqAgANzo/Dbra6vQve6JCM3o3FHfX5mRf
         elukHvGVJrWqugcRaQL7fLjiMiDCQ6SD7XF8kAg5nqWaULeRqJo0VOOMJ0tyQLp216AQ
         7lY3kuJ9UsiWH5IQiNXPxER6oRcqkiN0pKpQgYdFp1W0vlU4wnynsKemZFqC6I1nKTjI
         POpQ==
X-Gm-Message-State: AOJu0YzX2r0zaQzyCIBDQF9JQor6QKOzrtpPNok1S4PxLRUMIxa9KSIq
	ibF4oR+7Nx4Fp11RWqkN0nKae3rdOQYcQwMXFsBzEsQNUNwDSrEaU3vYt6GeNA==
X-Gm-Gg: AeBDievRNUsajtpk0m+AfST5/LvR6GEF41mWTPbJNfABRDtUyNrTvfaFlIc/NlIy31H
	sa78/dpHK+3dtBf5ZLXz/t5KrvT0tUZYJTRbiBu54c3dzovJQpCbApT2fHdsst5Qt1mr3cCON2y
	FK7fHxnOKfU+GT2G4MtQjptrFnc2HnpnPwoUMqdr08zcxHtXMCknhlCP1dSfeITM4/oJ0cEjueJ
	WG78d54eiKERakD8BN2lBtxUPqahDT/0CkgNs+FYjmBBs1xtaShd39TGN+POLHlMKDrdw7pAvly
	rGS/hF6iRBkjS2swNBe1dogwoUXiS3uEnWz/4tSfUzqT+STyeo+KQsVYRXoTrP92LYn4UOC5JcY
	oiqvpXGitJ2fjQnBimVbplHDfdtRp02QuoF0HE9QSxxTrN69XKlHZhmK2qAbpKobfL67lT5aBvr
	9o4FgvCZGWCzVwwd87AZgmdBpMAA2kaOyXbkTq
X-Received: by 2002:a05:620a:2688:b0:8d7:6d40:713e with SMTP id af79cd13be357-8ddcf5b32f1mr694169085a.39.1775854879373;
        Fri, 10 Apr 2026 14:01:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.30.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f88a19sm289916185a.7.2026.04.10.14.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:01:17 -0700 (PDT)
Message-Id: <a1fa04a965017797e9c500bd2e6148ac4b0e4431.1775854874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
References: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
	<pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Apr 2026 21:01:11 +0000
Subject: [PATCH v9 2/4] sequencer: allow create_autostash to run silently
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
    Chris Torek <chris.torek@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a silent parameter to create_autostash_internal and introduce
create_autostash_ref_silent so that callers can create an autostash
without printing the "Created autostash" message.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 15 +++++++++++----
 sequencer.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..1197d7d8a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      bool silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4702,7 +4703,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4716,17 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, false);
 }
 
 void create_autostash_ref(struct repository *r, const char *refname)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, false);
+}
+
+void create_autostash_ref_silent(struct repository *r, const char *refname)
+{
+	create_autostash_internal(r, NULL, refname, true);
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

