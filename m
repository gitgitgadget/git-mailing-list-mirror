Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB803939D7
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117753; cv=none; b=PQccF9clpr4nbgCUfi8fqVbIlz4REYlCqjDZmGovlBQzjO3Vii/P9NYanwIDSuFExmUj12MM2SARhCz35N4qSkVff1rt37Ta4FPhIWuyse7ckIx6rTia4T8+lre8LY0sP+yMGpv7Gc8exzl4dIa5Fh7C5qcjLGzYqAUsHRhEt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117753; c=relaxed/simple;
	bh=f62n9TRPkzjR7KDh7PENIhPO+vQKBaLO8xpEuV62yrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjxkd2SEroQasl2vq81MySZ8k4yWTTvlbGFp06RoJe0qzVKzE0r24mbPOCMtdINbuCsSOR9ywbTPjepG+CVxi/Yp1Hk8svSE3LFVMJvaRtx6GlUvQBhlL6ABeWWzNWKPeyyqO/F0ymbxlziC/ogOuo817snWBMj9pWbVmuThRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMla8Rm8; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMla8Rm8"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4e4a4d77e5bso421023b6e.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117751; x=1792722551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7FizHUbTFOYfDAW+40B8MDzbsZCV1QpNLq36ZJpNYk=;
        b=mMla8Rm8672n65lr5BUP5R4fcOirxqS9CGVsf0rmycZipxgi5QZ++T7N/+uQBT/vty
         5KsGOVKnRxM98ckQdFcwRKvZ6+qM536JuMp14BX6zsMj/vfjubTZaGncsILsuDk5hhNs
         NK5tYlelnObk3qibkcd9CWc1Q32NQeUbaP+h/qNGkhUCDUqlEVKWiC8vZrg2/8/Gz51x
         bb8FKJbPJHySH6zea6DtqW+bBKUT1IcPkk/OS6Xr1M9XcMrL7Np8Un+yEdfy0lVAtbhg
         LUFkNscW/epQs6Sw/rBKiyjYxpDjjzXDuDZ6kn7uRMhX/6U6JnY08l3pFwBQ2kXGx0oR
         mWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117751; x=1792722551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7FizHUbTFOYfDAW+40B8MDzbsZCV1QpNLq36ZJpNYk=;
        b=QB8DIqxRes4pyzoIE1qXYmYn92DzoYbWFqZLQRJp0UdCf4l5x8DKk3nCUDREEb8jp8
         ZKuOC8bT7U9/KRaMGL/fjl4P8O5ysG8bh6LcQSpQxhz1yABjON9oWDuOBKD5CbTV5zHT
         4FiodUIG06LDc+XbD9p/zkGo7pxhvXSjT1gpWRDsIyPI7TeHBysqNuPy4+tHYr+F7lEM
         ZLq1rSBOdsVy7VEY1iZL8Pn9eHo6Ru8iPUPZ7BW799YFYYSMoNBq6RWW3Jmp71woYPI+
         +kv54ei+Ewi4WvQN3fVhNCKylUO7P8Gi1nTLOXjq5vpxkhOd5Qx/TdDnmMj+dlK5qBmd
         QG6g==
X-Gm-Message-State: AFq9FYJCxm8FSTI7ZLTRIPya2aTzooo+Z0YqreFsH6SNui2pca7MeL+8
	sJBUX9Rg5xEm/X1tmNh76mQmPSrnEao4ZwbaMsjc9ib5e/IQz4p9+0RMBFx/pQ==
X-Gm-Gg: AYBFou0/JgVKGLkKDMQCPwOgkdQzsW7noI3hsslPcKB9Knai3jUnlSfKNxwpEFrE0VL
	3rg92m7Ex9xRhZaFhk9vbq642YSGuBrIrYRAMTvY3G7ynibOC2JinlymafmYSC+FsgnJD/uUVdL
	H25uePBwv2Nf+tVAJRZsOpZ8+KMWZ3Lh4xugib1YLvmrLQbiP9aWbDc/LGxH/TZF37hjy+zI8Zk
	iGL23EZXixnmI0HBJ26m6RrcSNcQ0ENkjzJJ9iHhy6LnC1vOL1hyipr6wIt4Q4MXwjeqkvaQdol
	EKgdjp/pBlbWzsO3WfEs0PhCc5nKqmZFBaTIevp9Qqg6Kmoehg+D+6Iog4MHXadyyNoKhdWrrqE
	iw3UU/96wvdwr5cMxhF9BVCD57bRSlTpZuVg/mMMeBUhVmNF0JVpSRdcbr7d5kH6SxvCEdg4gw2
	9obT6XEdBjW6CFOKU2DDeITp7HgWjQzasWSVfPwrYImkBzK1ECDIcDItSUnz88t0gdG8IJ4dymX
	7FJ9JoFvfyZmvle/g8VI1iSAzglw3iLuLVBSw==
X-Received: by 2002:a05:6808:308d:b0:4e8:4a03:dfa3 with SMTP id 5614622812f47-537011c0fd5mr1469911b6e.40.1792117751091;
        Thu, 15 Oct 2026 19:29:11 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388a5572a9sm506284b6e.4.2026.10.15.19.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:29:10 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/3] object-file: explicitly write ".keep" lockfile
Date: Thu, 15 Oct 2026 21:29:00 -0500
Message-ID: <20261016022901.3838402-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20261016022901.3838402-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
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
 object-file.c | 99 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 20 deletions(-)

diff --git a/object-file.c b/object-file.c
index 210984f825..ebe46d35de 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1256,6 +1256,43 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
+static int write_pack_lock(struct odb_source *source, const char *pack_name,
+			   const char *keep_msg)
+{
+	struct strbuf lock_path = STRBUF_INIT;
+	struct strbuf contents = STRBUF_INIT;
+	int ret = -1;
+	int fd;
+
+	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
+		    source->path, pack_name);
+	strbuf_addf(&contents, "%s\n", keep_msg);
+
+	fd = safe_create_file_with_leading_directories(source->odb->repo,
+						       lock_path.buf);
+	if (fd < 0)
+		goto out;
+
+	if (write_in_full(fd, contents.buf, contents.len) < 0) {
+		close(fd);
+		unlink(lock_path.buf);
+		goto out;
+	}
+
+	if (close(fd)) {
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
@@ -1389,18 +1426,17 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 	} else {
+		struct strbuf final_path = STRBUF_INIT;
+		struct strbuf pack_name = STRBUF_INIT;
+		struct strbuf keep_msg = STRBUF_INIT;
 		char hostname[HOST_NAME_MAX + 1];
-		char *lockfile;
+		int ret;
 
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
@@ -1424,31 +1460,54 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
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
+			strbuf_release(&pack_name);
 			strbuf_addstr(err_msg, "index-pack abnormal exit");
 			return -1;
 		}
 
+		if (ret) {
+			strbuf_release(&pack_name);
+			strbuf_addstr(err_msg, "index-pack failed to report pack name");
+			return -1;
+		}
+
+		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
+			    (uintmax_t)getpid(), hostname);
+
+		if (write_pack_lock(transaction->quarantine, pack_name.buf, keep_msg.buf)) {
+			strbuf_release(&pack_name);
+			strbuf_release(&keep_msg);
+			strbuf_addstr(err_msg, "lockfile write failed");
+			return -1;
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
+
+		strbuf_release(&final_path);
+		strbuf_release(&pack_name);
+		strbuf_release(&keep_msg);
 	}
 
 	return 0;
-- 
2.55.0.424.g13c7afec21

