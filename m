Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F0255E2B
	for <git@vger.kernel.org>; Tue, 20 May 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747706049; cv=none; b=kDefb5uqS0jRpr9d1Wvyas6a6Tdd01KYxOh0pWpm3JQ78UT8n7Od1jrk4KMHQEth1NnX02vhbSrYnuDOyMH+OOxaM3eeZ3gj8hjgoQ67OfNix/2sOX7q3pQ4y9flKlaLmqE0s+EX8dtRfzGaWVT6neXPI/EJqjKNUi+/UnMArMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747706049; c=relaxed/simple;
	bh=VtpXFTCePBEZFOXcT24W+8tT9tpK40w38TnwwxJTIxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObBNT5CmRYbWxfTMmVaSQ5c/YiTBtgQvUAOLNEYTDgOMCDNZwAD9zxPSwhhoierMeCcPwLlCjJqO65v3ESd4WrV0q5XNmw3Zz3/MO8G4DvU9joIG/pe3y9ng7fqFUt1E29tX7D2kFAA530WgrhbjdvkUagZ2CbmLMEy38Ga3ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyNvjoaI; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyNvjoaI"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so2214285fac.0
        for <git@vger.kernel.org>; Mon, 19 May 2025 18:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747706045; x=1748310845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWSQOAEI0MiRAxWJhq0yqc86Br+tc/9i+4+fDZlBXIo=;
        b=eyNvjoaItj73ccHaZVO9mV23S8+ASVTR2RpgaD65lSyQfShRD/PT/fbbXDjiJsypY+
         N0nw2VseR2iPqGtJveiGYK5uckkc3NxDff9OlK2Dv6rBpFgNTi+ruGlTlgsff4CZuc3d
         WC8wYI31mCvzdeRhZJ6DyPdboIcuJ7BWL4GQwZqUHyytoQRnUXyquh1W0hgkEhRzh+Oo
         dOouzfXu/DfBzENnwCynT9KdLN2bx064TDK2cQgp9zm/FR4yjVN92XQCCYKKXOWPzMaP
         /HrkHASU2LNMq4jIuDgkigAK90eF2hH4eyAkZZjIbVCPuLhMY7+rO+IUIwZsPFaikirj
         l+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747706045; x=1748310845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWSQOAEI0MiRAxWJhq0yqc86Br+tc/9i+4+fDZlBXIo=;
        b=K9JK4LszYyGpDi57laAFSvKA70BCfyvP7RhCLmlR0ICibDtZjTvgGVykY29tfHMQ/7
         hgJya7qcF4o+Up+x+QpVJZb8HcoWhaJhEbBfeSQDsKCw560HeAEBDNiJ3fXpl1OaeJYY
         JAVWLcceABk44nhqs9ScnycZq9zVbzhqteQt6Q0nTTyyZsFJfNFuBUKnyx+3p1QwNfq6
         p/rb3bEmsUL0vwjveWzbf0WdBtcxLA9zxRvgdp00q241CF6RLQsboBHIqbqEZytanzDX
         4ndtcHB5ZAz4mDYIYdKFR8D5PtG5hFsUul7dWhbXsM+cBXqU5lW98bGrwZNoFu0uOd2C
         HqMA==
X-Gm-Message-State: AOJu0Ywzj4u6WYmqZU766/UiT+7wyKxiti3a7se+xIHW0ag7WPByrCtF
	3GeUP2fAMdWqpmVK5SiG2b5X+6slxby3lxmLZCyj7wRNwO/b+pNltM6MXCF4GSJy
X-Gm-Gg: ASbGnct+RJiH9NGUUrI71o/Y7s0zvYRZssjl7tud9XMUFJA8kqVR+uBxs5q2/9K2wRn
	tggMwHVqN9kwVX1VGiS+cX8giq26ZxnU2IRMbZDZoXXGE+469w7zDSUp9r7lizqeERQn5UKpD2Z
	i6UsW/5FJtiwQSQXlrvrj2dLQC75+YQYIsG0mZ72ij/uke1zFwYqD6NoiNlSMRJey+SnS4Vrhlb
	/toG5lllqh53NCkSgB1O2nT27imTRGYUA+04U+LxV49pmuCVEbkGYN/dTELJ0GYLgUpO0UqCiei
	uyqRu2qbz5S96L87GpKLW0te/TjRLu5vFFpNEphuADCkzdtsHmC0sdTjQm0=
X-Google-Smtp-Source: AGHT+IHVTLACsbmLo1cvqNxktd66JNlXIVeHOHco8HxvGemjbfxEUmSnXgPpCr24zcODHqKZVAliTw==
X-Received: by 2002:a05:6870:ef84:b0:2d4:e101:13f1 with SMTP id 586e51a60fabf-2e3c2a988d6mr8967867fac.13.1747706044957;
        Mon, 19 May 2025 18:54:04 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0b21fe5sm2006368fac.45.2025.05.19.18.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 18:54:04 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] builtin/receive-pack: add option to skip connectivity check
Date: Mon, 19 May 2025 20:49:20 -0500
Message-ID: <20250520014920.201736-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250520014920.201736-1-jltobler@gmail.com>
References: <20250507030249.4802-1-jltobler@gmail.com>
 <20250520014920.201736-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During git-receive-pack(1), connectivity of the object graph is
validated to ensure that the received packfile does not leave the
repository in a broken state. This is done via git-rev-list(1) and
walking the objects which can be expensive for large repositories.

Generally, this check is critical to avoid an incomplete received
packfile from corrupting a repository. Server operators may have
additional knowledge though around exactly how Git is being used on the
server-side which can be used to facilitate more efficient connectivity
computatation of incoming objects.

For example, if it can be ensured that all objects in a repository are
connected and do not depend on any missing objects, the connectivity of
newly written objects can be checked by walking the object graph
containing only the new objects from the updated tips and identifying
the missing objects which represent the boundary between the new objects
and the repository. These boundary objects can be checked in the
canonical repository to ensure the new objects connect as expected and
thus avoid walking the rest of the object graph.

Git itself cannot make the guarantees required for such an optimization
as it is possible for a repository to contain an unreachable object that
references a missing object without the repository being considered
corrupt.

Introduce the --skip-connectivity-check option for git-receive-pack(1)
which bypasses this connectivity check to give more control to the
server-side. Note that without proper server-side validation of newly
received objects handled outside of Git, usage of this option risks
corrupting a repository.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-receive-pack.adoc | 12 +++++++++
 builtin/receive-pack.c              | 40 ++++++++++++++++-------------
 t/t5410-receive-pack.sh             | 21 +++++++++++++++
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 20aca92073..68427d93d9 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -46,6 +46,18 @@ OPTIONS
 	`$GIT_URL/info/refs?service=git-receive-pack` requests. See
 	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
 
+--skip-connectivity-check::
+	Bypasses the connectivity checks performed to validate incoming
+	objects. This option exists for server operators that may want to
+	implement their own object connectivity check outside of Git. This is
+	useful in such cases where the server-side knows additional information
+	about how Git is being used and thus can rely on guarantees to more
+	efficiently compute object connectivity that Git itself cannot make.
+	Usage of this option without a separate mechanism to validate and
+	ensure incoming objects connect properly to the references risks a
+	repository becoming corrupted and should not be used in the general
+	case.
+
 PRE-RECEIVE HOOK
 ----------------
 Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be314879e8..66674bc408 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -81,6 +81,7 @@ static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static int reject_thin;
+static int skip_connectivity_check;
 static int stateless_rpc;
 static const char *service_dir;
 static const char *head_name;
@@ -1936,27 +1937,29 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
-	if (use_sideband) {
-		memset(&muxer, 0, sizeof(muxer));
-		muxer.proc = copy_to_sideband;
-		muxer.in = -1;
-		if (!start_async(&muxer))
-			err_fd = muxer.in;
-		/* ...else, continue without relaying sideband */
-	}
+	if (!skip_connectivity_check) {
+		if (use_sideband) {
+			memset(&muxer, 0, sizeof(muxer));
+			muxer.proc = copy_to_sideband;
+			muxer.in = -1;
+			if (!start_async(&muxer))
+				err_fd = muxer.in;
+			/* ...else, continue without relaying sideband */
+		}
 
-	data.cmds = commands;
-	data.si = si;
-	opt.err_fd = err_fd;
-	opt.progress = err_fd && !quiet;
-	opt.env = tmp_objdir_env(tmp_objdir);
-	opt.exclude_hidden_refs_section = "receive";
+		data.cmds = commands;
+		data.si = si;
+		opt.err_fd = err_fd;
+		opt.progress = err_fd && !quiet;
+		opt.env = tmp_objdir_env(tmp_objdir);
+		opt.exclude_hidden_refs_section = "receive";
 
-	if (check_connected(iterate_receive_command_list, &data, &opt))
-		set_connectivity_errors(commands, si);
+		if (check_connected(iterate_receive_command_list, &data, &opt))
+			set_connectivity_errors(commands, si);
 
-	if (use_sideband)
-		finish_async(&muxer);
+		if (use_sideband)
+			finish_async(&muxer);
+	}
 
 	reject_updates_to_hidden(commands);
 
@@ -2517,6 +2520,7 @@ int cmd_receive_pack(int argc,
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
+		OPT_HIDDEN_BOOL(0, "skip-connectivity-check", &skip_connectivity_check, NULL),
 		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
 		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs, NULL),
 		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index 9afea54a26..10c67c2bf8 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -62,4 +62,25 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
 	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
 '
 
+test_expect_success 'receive-pack missing objects bypasses connectivity check' '
+	test_when_finished rm -rf repo remote.git setup.git &&
+
+	git init repo &&
+	git -C repo commit --allow-empty -m 1 &&
+	git clone --bare repo setup.git &&
+	git -C repo commit --allow-empty -m 2 &&
+
+	# Capture git-send-pack(1) output sent to git-receive-pack(1).
+	git -C repo send-pack ../setup.git --all \
+		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
+
+	# Replay captured git-send-pack(1) output on new empty repository.
+	git init --bare remote.git &&
+	git receive-pack --skip-connectivity-check remote.git <out >actual 2>err &&
+
+	test_grep ! "missing necessary objects" actual &&
+	test_must_be_empty err &&
+	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
+'
+
 test_done
-- 
2.49.0.111.g5b97a56fa0

