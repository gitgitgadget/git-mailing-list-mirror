Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD61F9ED4
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105683; cv=none; b=ndErC9SKkrjue1FC+XWmzy7A7X6Xf5J54YBL6UvYjxxZMVXQRObnZpvVFnTcTqxuHPaYd8Uzvklhz+oaykjXkiYzWBCI730Yiar9JLWJAUVdmBUShOMPtp5JbDN3aOO/B2neS3q+YtTREYgibLvj/QCkluJCoU63FU0mk2gXe0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105683; c=relaxed/simple;
	bh=l/H1BXfgAsAT3JAZNzifnzOj2hY96z0VAYY5k4ZBJcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBlFGYlij7vPZAU8vuobLQCuXILXwyJzGEbdgNO8qiaeop1HlcDPjVhbyNRMUePhFplQnXjE2TZ5kUO1pjq52803T7BUxs1wgSP0T+G8EnzinPYzxeBObyv9gP76Wb9zNZGY9ByMHzn/uVOCb4FWjioFDedn3sfLFSZycnc+gyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/eRKf63; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/eRKf63"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2165cb60719so33784075ad.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 01:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105681; x=1737710481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpLuD5hTj+VGAyHqFcU6pyOaq44t+mr+iV+5XBO0Q/I=;
        b=C/eRKf637cEBbbyJ4fjibpDrgdzsQXks5MtNyc9zA8XHkmuv4htmdvWivbMhkGB6fP
         Md6C67eyM/GTXaalnN1NMZBaGzpCRQk7lhLSGYU7pLeg6lKF+YXnUV9UWzSsa/SXmx8a
         yt7l/Dp+IzRaHqdGXe/YzRbj7GgDwCJtehAeVC+KZOtTSg9lgsvjIB0c65hn2zctpG1V
         RNR7WYhIYaieFQwjDT7D4CivDhN2gvWt8TnG4xoBm3IgFNfviyo1zm+hL9g/EIUgV0M5
         j+foD4qnryPiSgdqRlg3fK/PWzOYx5/SyT1Y9AohzLDF46t1SFK3O+br9uBv8S0ulYfD
         eVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105681; x=1737710481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpLuD5hTj+VGAyHqFcU6pyOaq44t+mr+iV+5XBO0Q/I=;
        b=g1NfDj4EOHEA9nL3sw/IRTbZ3ue/DNwRWufAp+vm9daHgnZa43XWE79qJOyYBP5POV
         jRVMLSVdBU0Mdkb1ubl51H3LbNO5fznxAlhIBVmtaSQcevPrD9JLzWyAc+gy/o96kEE+
         E4SjHLWFJC+h1KSYfNph06UFPOEvDYgZ6pLa5soH27ON//cFnumXLeZhgHBk1MiAYvSc
         aZZP+arBgpoio8OA3f8CoN6WWh0ti/4OLep3wHCAwyY8YrUFS4iZHom5uPF//GG2l2OD
         XoMDj812ItnwwLBJ+HFHkarM8jylINaZxtBdRTBuTZJkIEOXTT7bTOjq7+ZTiJJFV2dl
         gkMA==
X-Gm-Message-State: AOJu0Ywiyv4psYzOZRKn6R3yz3TMqDLD1/ch1KvLOP7iFa7EanMl4wqm
	Gb0uoj9nAS0FS4FRevoinOwZbi2p8y8tiuEuqc8z3D+gmV6veDysGuH7etd9
X-Gm-Gg: ASbGncsaepU7ahESfanEblK+SnCTtY1IsURfkL55kc061qwj4RH+ZDPN7C6ah08RnIT
	MdAjccpLqlVJYh3+AvGPIdVhvLyut/BZlFQuj+sCOrw/Ifsaag+9Dbg9gH9fx08KaSFFqpm9LuC
	lgkCwct9X7w7QdHQiV/PS5E+B+xu5Ko3AasmJ5tW6qgLNVbZ2cdnj2o2uCIaXebDl7TDCbXdxzZ
	uBDzy76GcYQNtgRimQnLMfhM5e59I5AyTStcUpnfWLbqcoEmFbx5/kazRw=
X-Google-Smtp-Source: AGHT+IEsWhGNO9PWwN6yxPPJFPF38axgdUIe+kl06bFPlN3/RZDFeJ8DZLYMKXQfKWacKtfzK/t+hg==
X-Received: by 2002:a17:902:db11:b0:216:6283:5a8c with SMTP id d9443c01a7336-21c355bac6amr29773455ad.39.1737105680784;
        Fri, 17 Jan 2025 01:21:20 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm11714065ad.173.2025.01.17.01.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:21:20 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 10:20:49 +0100
Subject: [PATCH v2 2/5] pack-write: pass repository to
 `index_pack_lockfile()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-kn-the-repo-cleanup-v2-2-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=l/H1BXfgAsAT3JAZNzifnzOj2hY96z0VAYY5k4ZBJcI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKIQdYHluurQTKIL1YcaiUaKadvgNayzVIx
 GN2Jm8OHdrh6IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniiEHAAoJED7VnySO
 Rox/LQEL/RazomQtgtYP4tFoz62oAa/PfgKzpYBfqD7xFAPhs/bImWOUr0A7+IFNZbDfGV008Et
 XvyaxL6VJnkD5EfMiELCwSkW38gDGK0k/9ItnNU/BMN1tvLs6ozAXLg35UpKsnPy4D3x3IVe2Fs
 0YHnXeydYPhykFbNozE+JI4Br7pf8C3AXAN2W3qrqCqJJLq2ZZ0YGh5KBFIVMp2VvuEvuhKmAL8
 tELsj+gnPTmOyWlOZeQXvCP+42KJGVlZKWvMfILK4pW69WUJOtvUqlVDVEQmkKBziA0rkvNpyyG
 8dtF1pSybXoBYwerwcfhqFxaX64KHH9l3ac+SQzMvFVl3kJGa6DGzNDIp9YgmoW1HCdklT8vZPK
 lu7rnqiKztoDYpEW16wlkmSxgK+OLH2KcIBhdBUrLBuh8SmdOHL1hPy6Y9UwdUzmbfhaUxMiPup
 0L3hxK9Fd6el1Mabm+oPWteFgLX3Xml3GttPVmfxrnU2XkfvhSc9RsD8aQz90ZmX0+AfBaBLrz4
 9U=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `index_pack_lockfile()` function uses the global `the_repository`
variable to access the repository. To avoid global variable usage, pass
the repository from the layers above.

Altough the layers above could have access to the repository internally,
simply pass in `the_repository`. This avoids any compatibility issues
and bubbles up global variable usage to upper layers which can be
eventually resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 2 +-
 fetch-pack.c           | 4 +++-
 pack-write.c           | 6 +++---
 pack.h                 | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56347a79633505efe8dc05acf1583b4c9995eefe..b83abe5d220cefd3707b701409dc5e6b67566599 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2304,7 +2304,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (status)
 			return "index-pack fork failed";
 
-		lockfile = index_pack_lockfile(child.out, NULL);
+		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
 		if (lockfile) {
 			pack_lockfile = register_tempfile(lockfile);
 			free(lockfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index 3a227721ed0935d1f9c40584c57f54043354c032..824f56ecbca11cd9e4da6a3e4c450c6b2e7078ab 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1036,7 +1036,9 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
-		char *pack_lockfile = index_pack_lockfile(cmd.out, &is_well_formed);
+		char *pack_lockfile = index_pack_lockfile(the_repository,
+							  cmd.out,
+							  &is_well_formed);
 
 		if (!is_well_formed)
 			die(_("fetch-pack: invalid index-pack output"));
diff --git a/pack-write.c b/pack-write.c
index fc887850dfb9789132b8642733c6472944dbe32d..0cd75d2e55419362a61cf981fc11117ea7a1d88a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -460,10 +460,10 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(int ip_out, int *is_well_formed)
+char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
 {
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = the_hash_algo->hexsz + 6;
+	const int len = r->hash_algo->hexsz + 6;
 
 	/*
 	 * The first thing we expect from index-pack's output
@@ -480,7 +480,7 @@ char *index_pack_lockfile(int ip_out, int *is_well_formed)
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
-				       repo_get_object_directory(the_repository), name);
+				       repo_get_object_directory(r), name);
 		return NULL;
 	}
 	if (is_well_formed)
diff --git a/pack.h b/pack.h
index 6d9d477adc83e83d9e9175ccf699c100b4c147c6..46d85e5bec787c90af69700fd4b328b1ebf1d606 100644
--- a/pack.h
+++ b/pack.h
@@ -94,7 +94,7 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
-char *index_pack_lockfile(int fd, int *is_well_formed);
+char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
 
 struct ref;
 

-- 
2.47.0

