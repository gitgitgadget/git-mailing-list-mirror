Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171514;
	b=uPE2Yd8TQMCV2K3qP5LoUaa0GA2K1hYYwln9hp+s+HCbobcY7vGZHfkRB0SanP3I1dx1
	 aVeEMCvXk+KeEO7jP/QvhQ3ICoU0ovW3Y0/2S2x8ApFxghhri7TaDLMWB6RWFLdApHgGW
	 MXe3GJKsoopnYCrUIPdnoY7gWIEbrTV743CprcAH2VowSp3E8lweP//+b8+ohA8hpM0nH
	 sv85JE6DSYVXLu4Po0Ge/LenTunN6NCX4i9PvgeR78NSgnym6+KZ/xIch8wHK75JkyT5s
	 LGJzMYJ07E4iu6W4MwomkQTMmOzLcfAmQQ1WFgEzJn23cyy3hHtUnQ/qmQLV9JaMzBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171514;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Xjh+BlaAFfJG+HSTTexzwUvK2UsWrepiIu23cGh7Fl0=;
	b=LNhbD3gmR+Y/t2+ViQHvFDxqcZvmWCbI4XLMz6s1Ojr1sE+TcHXTw2P1ly19tr3dByqQ
	 YOSj7aQSUWSCBX9FMfLnsSgmkGX18wXsGrntstYU5mAgU2waCH2pU9V5+TA3V5Vd+dFaD
	 SF9s8daSDtRsPOn5JYtNgvCTKkWqLq/zzqK7vXml6GMDzJ3TC5XyN4tfGyKzABIMb9vtM
	 uzDHBUZrkpCXEPs4K2G3ZIoO2o2UxeE4TjGP/86CbYKNZuSfBGocf9ULrC+/iT87xMBLI
	 RrwIuy/6KRXMuc13aE5NBSPX8iPtJshflRQ8MekNy7KzucNHrYXOfR7R/eKx22sIFqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=k9WAR3Hl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QA+zbEdP;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B08606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=k9WAR3Hl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QA+zbEdP
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7523B1D00132
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:11:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 03:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171512;
	 x=1793257912; bh=Xjh+BlaAFfJG+HSTTexzwUvK2UsWrepiIu23cGh7Fl0=; b=
	k9WAR3Hla2BcvtHi6gNb+l6mBoPmVqhIRxqNDIT0MzoTtt2iILUSiRTikVrR0qpJ
	ZEEDWJAVAe8F1XI0PUuJUpeVEIbm8xNQJHZOEAYwf8X3XMcWO+LkHYdY3g4THdc3
	vfuIkToZGmd92XCj4FVeCI2QBGU4Ew4CSCUyZ8l0+7EdK7Rly+K3pvsN+GvMMGTr
	oou72Fqr5kAjN2hCJ8dboQb0PmqcrufnVKQHDdJf89GwaaT3yxeW5hC4364b/YoQ
	zRFsfq2wbPyE2graq9+u9Xsew9FI3cOM9EUAjso8oS9NgOmZG0BieTPioUyJ0fkq
	tDw/0VdoxnBB2gs/Oc9L/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171512; x=
	1793257912; bh=Xjh+BlaAFfJG+HSTTexzwUvK2UsWrepiIu23cGh7Fl0=; b=Q
	A+zbEdPvasNRv7dV5ZWkGFd5JxDt4azpwDcjQvVhqRWu1OpdN/QtDy0wTUdl4Ajt
	XCiraiCImb9iQljgAwt8C5PwhdT02uAj+oNqz3ZxA4J59NH67SWhbsVTA0sNuuxn
	K4aRLe7AtbR/doJA8ov/s3pGq/xSnLxo856RCoxx+RsPFIftpdr3isD4IcTXY1VJ
	C6T0xaGS0qju1tvprH20qSzfzHsgxLb0HL/Y4J/VL9GW4+FbRIhvpYWs/xYDSSPC
	Pf4kfRpluALoYGGsdKiz06BmJclQ8hbf3ut871JVfbtfqlvoQS1YBzvqtuMSAahH
	jDGuY1F5VdwhOdbHgGeFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171512; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:du6i4fM6bRArx5y8wQVs/HJTRV5Plnbaf/hJ9oHc7J3szPv
	buXO00AZqoODopuUgaRKDQEiELhObpoVhdJB48QUeuC/YE6mnCNFQFz1oDKAeV3A
	HKMSZA6i1fhLhOGktS8jnhp1SkHCI9qTNe4FjD4XyOc7UqpeLbSoCOrfD8yvH5QZ
	I6qQ1EkXpiKvNufW1dH6SXjG+prgbdf0lgqOX9Lfbp4gmj4iPmPyYswzunsSWR7U
	Nxl5m/9QaUadomVutvo62rWDTWmQd+XpeXALRq+R+AiF7dI57uVidrvTKshrKyeG
	BAB9ai0/iwOzZDp7UqA/SyBqC92dZulVY2+bC4g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dx2oiTaIMXx5rE0QSsmSammW+2Lc5nmVdNhhhqlrk1w=:jpzw/vyfnTtTT0om07dqG8vTh/J6+igRveNJX9GvPr0=;
X-ME-Sender: <xms:OKDhavijYkdSutlB4-fJdjuveetgwN4D_uWFYKNYC3K5aD21-6Ereg>
    <xme:OKDhaiBAhBWInbzVnXBavLLVGUyzdfFMsbyLf9QzUyQ51E6NJKgrZDwPQrDPmidIL
    7Tj1O8QsxByOm7V6fnNYst-Tn4JHUKFD22kezNtnz_87yTTwDGtNQ>
X-ME-Received: <xmr:OKDhassDtQygmnH2TKVYaVa1YlMQW3GuZI8jTl-WdovZTzv1Rgae3g>
X-ME-Proxy-Cause: dmFkZTEc37deRu1YjV1twq5x8S9h2vHzSpOqVUeY/oQALEq4MTycwj++wTftSJtpmBg179
    SJnohMVvYziqzg//5jnQToKdvt+XMQRpOm6yEJQlohEgJkkmNJdHX7XJwpxhGgueoh5KMu
    s9r8Js2aIJXnOsxIYKWDUruYSO/k92nvZABL2lKBtb9zjIUDB9aaPM5r4UpAGris3HVsGV
    Qg+H2VLQceKg6IlswIZKBbZHJZF6SwIx6wOXNwiEVtTmHiBBGHmXU30qTItsWyIS3nXmQy
    RPkL5ZHovsqaU4xY9l/R3h+um4aBLRdxuv/2iAYPEd17NECs0PSntrPYQ9YFKrO9aR77aS
    Qvz9HZB4R7Jn6jNLO6SbLKwIj8WhKSQqwYpg/Wi+nAs9qHpvto+Ufzp68fiSw4KX3w5R7F
    oMW4bmPwXgDwtcLYoo1AQQYumGiylF1UjPXDSmgyhdqURlyvwhNzEuCXaCdTxBNU3b9550
    ZfCO6HjG/zAnEg8+XRiOcaxgyCepGDlYvZs6QOEzm4yt3j6zkWDc3ediedMNqixK6wA8qe
    uhSRUnLdgTDEDPHsmw5wiIHRzxIrAITG6/V8Jsr/hhI/cZsYVVns0oGGGPRG9XkQx/7NHJ
    uLFO7a1Si1/eXpUZKzHJeOB3gE8WhCS0NfDalyZmf94F7HMUib7kH9hY91Kw
X-ME-Proxy: <xmx:OKDhanZIebvH9cstTYiiQ5iS9D6pGxQW2FMH2Pd9AxBJmEU7sLUYHA>
    <xmx:OKDhavVbTNQTC2Dha-HYWHabCuwy_0PN7BcRQFATeyX33K0ytYoY9w>
    <xmx:OKDhar4wldgF6l3KzZL93EWgseGkc-CLC0W_mFwI45rMSIdB_SpcIA>
    <xmx:OKDhaqgnDdBZD7yt9CbhHENmB8b2Tkku3lHMGUWRJsnQT55px1rsQw>
    <xmx:OKDhanQewcxcLTfuGmGgJLHc1WffttgfsMX23FaWtkskDS21WCMA3izA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:11:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 840ff19c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:11:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 08:11:41 +0100
Subject: [PATCH v3 3/6] odb/source-files: reload alternates on retry
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261028-pks-odb-files-reload-alternates-v3-3-011ddb64b626@pks.im>
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

When an object ID cannot be found we retry reading it from our packfiles
after we have flushed the respective caches of the packed backends. But
this misses one scenario: it may happen that the object databases'
alternates get rewritten concurrently and all of its objects are moved
to such an alternate. If so, we won't be able to find any of the objects
anymore. This used to be working just fine, but with 5946a564cd
(odb/source: make `read_object_info()` function pluggable, 2026-03-05)
we have accidentally dropped this logic.

This scenario sounds somewhat unlikely, but we've actually been hitting
it in the wild: when running long-lived git-cat-file(1) processes that
we interactively query over many minutes, and that repository gets
forked concurrently, then we move all objects into an object pool, write
a new alternates file, and the git-cat-file(1) process will remain
broken for the rest of its lifetime.

Fix this bug by re-preparing alternates when the object in question
could not be found and then retrying the read. A couple things to note:

  - This requires us to re-read loose objects, which is an operation
    that we previously skipped on the retry. But we only need to do this
    for the loose object directories that are actually new.

  - The result is still incomplete, as we only reload the alternates of
    the primary object directory. But alternates are added recursively,
    so in theory we'd also have to check whether alternates of any of
    the alternates have changed. But we never did that before the
    regression, either, so for now we don't care about this edge case.

  - It may happen that we reload when a quarantine directory is active.
    If no alternates existed before that reload we may not have lazily
    populated the map of object directories yet. So the assertion in
    `odb_files_dir_is_usable()` does not necessarily hold anymore, and
    we now have to populate the map with all object directories.

Furthermore, this change causes a performance regression when asking for
lots of missing objects. But that regression is basically in line with
the performance we had before this mechanism got broken. The following
benchmark demonstrates this when asking for 20k missing commits in an
empty repository with a single empty alternate:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    289.9 ms  ±     3.4 ms     285.8 ms  …   307.5 ms
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    184.8 ms  ±     2.5 ms     181.5 ms  …   191.9 ms           -36.2%  (1.6x faster)
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB           -0.1%

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    189.1 ms  ±     2.7 ms     185.9 ms  …   196.1 ms           -34.8%  (1.5x faster)
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.9%

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    293.2 ms  ±     2.6 ms     289.3 ms  …   303.2 ms            +1.1%
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.4%

There's no helping this though, with the regression fixed we will be
slower compared to before as we have to do more work. But the next
commits will improve the status quo a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  | 21 +++++++++++++--------
 t/t1006-cat-file.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index c0375e7cb70..d66949b7de5 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -243,10 +243,11 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	 * thing twice, or object directory itself.
 	 */
 	if (!hashmap_get_size(&files->dirs_by_path)) {
-		assert(!files->dirs->next);
-		hashmap_entry_init(&files->dirs->by_path_entry,
-				   strihash(files->dirs->abspath));
-		hashmap_add(&files->dirs_by_path, &files->dirs->by_path_entry);
+		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+			hashmap_entry_init(&dir->by_path_entry,
+					   strihash(dir->abspath));
+			hashmap_add(&files->dirs_by_path, &dir->by_path_entry);
+		}
 	}
 
 	if (!odb_files_dir_paths_cmp(files, path, normalized_objdir.buf))
@@ -425,6 +426,7 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 							      struct strbuf *errmsg)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct odb_files_dir **tail = NULL;
 	enum odb_read_status status = ODB_READ_NOT_FOUND;
 	enum odb_read_status ret;
 	bool retry = false;
@@ -448,10 +450,11 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 			status = ret;
 	}
 
-	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		if (retry)
-			break;
-
+	/*
+	 * When we have reprepared alternates then we only re-scan directories
+	 * that were newly added.
+	 */
+	for (struct odb_files_dir *dir = tail ? *tail : files->dirs; dir; dir = dir->next) {
 		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
@@ -461,6 +464,8 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	}
 
 	if (!retry && !(flags & OBJECT_INFO_QUICK)) {
+		tail = files->dirs_tail;
+		prepare_alternates(files, NULL);
 		retry = true;
 		goto retry;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 72fc8acc611..f2b24dd2787 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1481,4 +1481,36 @@ test_objects_filter "object:type=commit"
 test_objects_filter "object:type=tag"
 test_objects_filter "object:type=tree"
 
+test_expect_success PIPE 'concurrently written alternates are loaded' '
+	test_when_finished "rm -rf repo alternate stdin stdout" &&
+	git init repo &&
+	git init alternate &&
+	oid=$(git -C alternate hash-object -w --stdin </dev/null) &&
+	mkfifo stdin &&
+	mkfifo stdout &&
+	{ git -C repo cat-file --batch-check <stdin >stdout & } &&
+	(
+		exec 8>stdin &&
+		exec 9<stdout &&
+
+		# Read the object the first time, without having alternates
+		# wired up yet. The object should be reported as missing.
+		echo "$oid" >&8 &&
+		read line <&9 &&
+		echo "$line" >actual &&
+		echo "$oid missing" >expect &&
+		test_cmp expect actual &&
+
+		# Read the object the second time, this time with the alternate
+		# set up. The backend should reload alternates and thus find
+		# the object.
+		echo "$PWD/alternate/.git/objects" >repo/.git/objects/info/alternates &&
+		echo "$oid" >&8 &&
+		read line <&9 &&
+		echo "$line" >actual &&
+		echo "$oid blob 0" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done

-- 
2.56.0.341.g393f52fd96.dirty

