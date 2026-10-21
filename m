Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607138;
	b=ZBfrJjNmifco8O348Uz+cHtTHtBVLnDlcZUaVVcj7erLRdHGf5Nw9zysgxlG3Hnq+389
	 JKopAEVjDYlyQ14xQtQGQ6sXitDG/uMXl/seUtjkpuWhQm3SbeBq2PoazLPvAH6308RXz
	 EPp8vZrkIeKWK/NVZX7BRq2rHMMdr6YsUEAJjcclabBFLUGjqgPdlNh06bPl135jCxOEw
	 kv/ViVVV+12k+B0dN6qYCz7jlK/A8qWQ2KzLKDZpAZTlvYknJ3yXwmIyA2KdNYxwt2yLm
	 3nHy0dvIWBwO+Q4CGRL8Oo0CT1+4w5J37nrBzJToXois/Jt4WDZBthGLwbmG8vnvbkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GM3ky/kdYYNJ8bgPv3sXzWbw4y3aRqzBlwkGkCQGku4=;
	b=B0PCmEhRiErTB+dFidLRGVEyG1BGiq+VyRq6hZwTaazmpb6QFP4eCQIeGET4Uincf8a0
	 y41sxPsJhhekZlqjpqKzm6uud32Ww40WbaiU+zUZBvXgo9sc0fjaNV4eFuQ3IMmOiwQ9p
	 kdYuNVmuL5jt6JEHHpfX3ixa/F0jd56N/UuopAGY4ZU565uW5HmF/peEkS8QJvpQR8F6K
	 4DnLY9mxgRviRRLRxyk3MmbiV5g+y6DWQOjryNdZum5YEnGd45PBPwVJu0oJgN1hakIDp
	 eQRZREq0IOmpKacUOQqiY3Ml3PWfxNI27ZLf9OA9YyG6Tr6hsk3in3/o5b1+alkgBZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QI5PxcMS;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82331606A320
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82331606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QI5PxcMS
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f84a55cc06so620696a34.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607137; x=1793211937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GM3ky/kdYYNJ8bgPv3sXzWbw4y3aRqzBlwkGkCQGku4=;
        b=QI5PxcMS/OPlo+i8ecxAWIe1Wcic4uhmgEZHhZfJZ4A5JoLQ/OsBo4TSp7gzw0OKfV
         kXFVZIcKhr/spxj5Ynm1Dqp4rbbZO8GTHKb782C2vd8ohp2TJNVuxsbXB1C6rc9eTdNf
         yeHbmI/jaaS7Ln0j7HPkbkzUTKrjljAUlEXvHsim90s+AnLq//4u8dLXLLPJrkWrpHWm
         8+DQP9Wa7dua7U899lYRFktUNTBMaDGUCll9/ICg/eVK8nJl7pkxz60F3YvpcH3qxu3J
         npZ7ZZHFoJ6Z20UAPvl32rEgDxjVlluh2PzizkPQUz2u9Eh2mMnpQ4Wji4nN3buN8944
         ECTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607137; x=1793211937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GM3ky/kdYYNJ8bgPv3sXzWbw4y3aRqzBlwkGkCQGku4=;
        b=u9lfEaMzjy2T6wwAefOD/2TEAPJRfGlcTT6f0CCSGipp+xM0br/QkKfue/vBbJh7rv
         +cMXnJS3S+gE1XW0OSQFC1GrwzyiwPSLHtZRL+KikWVES9o5TkxuABEnMw4WkyzLm3Az
         uR8Pbsdq+YLjJlKEUed6gY13uxyo7cgDEIENre8eDVtZLKcoB7QZLUnCUYkH9QYicd3M
         /R1B8FB7x/bahGEXGVk1L4ZJey4EhAqy9r0eDgg52uIS2Y/4CXehhbyRYxv8qlEue3nm
         4nxC/N+vcePjbAnMTF1tYUlZ7oTteYFrhrGDKhdyS/D2Hm0fs1kuEDLWrn9T2wfEp7+7
         P3Xw==
X-Gm-Message-State: AFq9FYIPQJ9LcR427zDOXFpVVztPkYvbqJYfkRmSkeGIGmAAp6F65VkL
	Jj9Udf632gH6PdepKiu7tOg+INDM6NdekzTZBmL+IqoGmxy8YQEcid3q6iMk9w==
X-Gm-Gg: AYBFou2Q/w3NG1TRCzpjefOJjw1oINs/2ChhZrl42yQjaEmEJoMsjs1llRjRKNxK7eu
	vkeBmYwKvZryRe8/uAsdzHer3uHdDMaDaAVPLfaVJPzMFkNH3s6Ic/ycNuEvGsrjB+VN7jVa6tr
	138Ps/xelcBDIulHP1UUdWD2qjHwBW5VeO/ybZxyKuEOrKQfzgMVEnA6mTBDAV864nk1ESbyzPA
	pGNpzdAK33Jp6l9JwtbPtOKGuxi/qKxBaJIzB/3OOURoZ0Wef5W1a8/iIb2glRMTGq1PdPIsJnM
	5JNEK5+haTOjzmseyNa++A22f20RCebBcNEBr/T1ni9blKb2tTQaL35fhW3F5ybo4/qc2pSu0vx
	B/I3gUbkQoS80eEaeE5z30UXThx4+lcXbYGCBSl5dXSidazkorleVr/qlsrFfWgQHPfqvOThcD+
	FgGxIPu/JFkY+ffLwe0em8BFclt/oFRDZcmRPkGfyl+EeI8WfNgElj3HdFu0JJ26r27sgl9eId3
	nse7Ype2m/yRQTwW5qYoMrEUqm5xWvrza/sLpYNZqpu6dg+Uy25xFPhrlBC2nqfzHaBzLssZqku
	vuVAIURz+aA2GwbbWqc=
X-Received: by 2002:a05:6830:6d4a:b0:81d:54f9:d6a3 with SMTP id 46e09a7af769-84d05db28a1mr2166095a34.4.1792607137413;
        Wed, 21 Oct 2026 11:25:37 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d3csm2831887a34.9.2026.10.21.11.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:25:37 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/4] object-file: explicitly write ".keep" lockfile
Date: Wed, 21 Oct 2026 13:25:27 -0500
Message-ID: <20261021182528.3055494-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261021182528.3055494-1-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `odb_transaction_write_pack()` interface for the "files" backend
relies on git-index-pack(1) to write the specified packfile into an ODB
transaction as a packfile. To prevent a concurrent housekeeping
operation from deleting the newly written packfile prior to the
references being updated, a ".keep" lockfile is also generated by
git-index-pack(1) via the `--keep` option. Consequently, the ".keep"
lockfile is written into the ODB transaction alongside the packfile and
later migrated together to the primary ODB during transaction commit.

In a subsequent commit, writing the lockfile is deferred until
transaction commit and thus cannot rely on git-index-pack(1) to write
it. In preparation for this, update `odb_transaction_files_write_pack()`
to explicitly generate the same ".keep" lockfile itself.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 107 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/object-file.c b/object-file.c
index 210984f825..74a31760bc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1256,6 +1256,47 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
+static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
+			       const char *keep_msg)
+{
+	struct strbuf lock_path = STRBUF_INIT;
+	struct strbuf contents = STRBUF_INIT;
+	int ret;
+	int fd;
+
+	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
+		    source->path, pack_name);
+	strbuf_addf(&contents, "%s\n", keep_msg);
+
+	fd = safe_create_file_with_leading_directories(source->odb->repo,
+						       lock_path.buf);
+	if (fd < 0) {
+		ret = error_errno(_("unable to create '%s'"), lock_path.buf);
+		goto out;
+	}
+
+	if (write_in_full(fd, contents.buf, contents.len) < 0) {
+		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
+		close(fd);
+		unlink(lock_path.buf);
+		goto out;
+	}
+
+	if (close(fd) < 0) {
+		ret = error_errno(_("unable to close '%s'"), lock_path.buf);
+		unlink(lock_path.buf);
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&lock_path);
+	strbuf_release(&contents);
+
+	return ret;
+}
+
 static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
@@ -1348,9 +1389,13 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		container_of(base, struct odb_transaction_files, base);
 	struct repository *repo = base->source->odb->repo;
 	struct child_process child = CHILD_PROCESS_INIT;
+	struct strbuf final_path = STRBUF_INIT;
+	struct strbuf pack_name = STRBUF_INIT;
+	struct strbuf keep_msg = STRBUF_INIT;
 	struct pack_header hdr;
 	const char *hdr_err;
 	int err_fd = opts->err_fd;
+	int ret = -1;
 	int status;
 
 	hdr_err = parse_pack_header(&hdr, pack_fd);
@@ -1390,17 +1435,12 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		}
 	} else {
 		char hostname[HOST_NAME_MAX + 1];
-		char *lockfile;
 
 		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
 
 		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
-		strvec_pushf(&child.args,
-			     "--keep=receive-pack %"PRIuMAX" on %s",
-			     (uintmax_t)getpid(),
-			     hostname);
 
 		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
@@ -1424,34 +1464,57 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 
-		/*
-		 * The lockfile filepath is expected to be the final location of
-		 * the ".keep" file after being migrated to the main ODB source.
-		 * This ensures the lockfile can be found and removed later
-		 * after the ODB transaction has been committed.
-		 */
-		lockfile = index_pack_lockfile(base->source, child.out, NULL);
-		if (lockfile) {
-			ALLOC_GROW(transaction->pack_lockfiles,
-				   transaction->pack_lockfiles_nr + 1,
-				   transaction->pack_lockfiles_alloc);
-			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
-				register_tempfile(lockfile);
-			free(lockfile);
-		}
+		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
+
 		close(child.out);
 
 		status = finish_command(&child);
 		if (status) {
 			strbuf_addstr(err_msg, "index-pack abnormal exit");
-			return -1;
+			goto out;
+		}
+
+		if (ret) {
+			strbuf_addstr(err_msg, "index-pack failed to report pack name");
+			goto out;
 		}
 
+		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
+			    (uintmax_t)getpid(), hostname);
+
+		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
+					keep_msg.buf)) {
+			strbuf_addstr(err_msg, "lockfile write failed");
+			goto out;
+		}
+
+		ALLOC_GROW(transaction->pack_lockfiles,
+			   transaction->pack_lockfiles_nr + 1,
+			   transaction->pack_lockfiles_alloc);
+
+		/*
+		 * The lockfile filepath is expected to be the final location of
+		 * the ".keep" file after being migrated to the main ODB source.
+		 * This ensures the lockfile can be found and removed later
+		 * after the ODB transaction has been committed.
+		 */
+		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
+			    base->source->path, pack_name.buf);
+		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
+			register_tempfile(final_path.buf);
+
 		odb_source_prepare(transaction->quarantine,
 				   ODB_PREPARE_FLUSH_CACHES);
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	strbuf_release(&final_path);
+	strbuf_release(&pack_name);
+	strbuf_release(&keep_msg);
+
+	return ret;
 }
 
 static int odb_transaction_files_finalize(struct odb_transaction *base)
-- 
2.56.0.173.gf57c9a7388

