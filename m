Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00D414A2B
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293817; cv=none; b=tppjgqXFMeRqqxgNvyNM1Aqbbr6BXMB05prrZPOwF5pHrqTThvpzpMV+n1N/d/2ty+zdXzyVRP2f4+Eel6+oDtpVrNlKl+ATMR2jEL1WiB0s09FMVCxrB/0DL7fx4V3U7RtddSL50bEEQJrAv+4mvDPZXBwdK3yf9n5JR5Xn8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293817; c=relaxed/simple;
	bh=m2j0Maw9119BXBzrEI+JSgruISzsfWOAuZPrF7mXZG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGzC9gZXCICfwZiPeyCfUKnh4Ium6dpTW8f0Ndhkj6O2iD+VrJ83BZYtUP21WOpgNLyzXjAeMvAAdzU/mLlMmadU7eG9+77OxT14ByWLcPIEYs44cSg+fxLdm31H/aOYlN0iAlXFnbdVrE3DlPIdCyUP0Jx0Texf3/twNJmIxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=liBp+Izo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cn/MNXfP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="liBp+Izo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cn/MNXfP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 447EA14001E9;
	Fri, 21 Aug 2026 02:30:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 21 Aug 2026 02:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787293814;
	 x=1787380214; bh=mhe0iVRuNMh3ZrRtB7FFkFsoJOVyoPeQcmkadfVIGCM=; b=
	liBp+IzoSYuCUPOj7DiYV0eqoiSnhLtMruuEapg/AZhn1Q0PWnSn/PcpvpERQE9i
	Z/GDZoibPnfUFGpZoo/Tp5nCXCtvJP2hAtlGZZ4dFC80uVIhNLnyk+IwZqcs/1uv
	LjNjh58w1ETHtibnzmKWPvbXoBY9u88OJXuwaaNW644pxtchcTeK00+d7OwacO8u
	KvDQdS2AZ/+mGMM0I7x6/Akp3PcApoMmLo9G8fLoCVVfdXJhcEjdiENEZF2agxBT
	TGuf4630Jfx6SYPD2xqI9cKHTroLI5TGFi4K/uGRGNLbTJiYLds8BYpbZy00AhMc
	iNuI2NysC5T/Rhoy6qQwMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787293814; x=
	1787380214; bh=mhe0iVRuNMh3ZrRtB7FFkFsoJOVyoPeQcmkadfVIGCM=; b=C
	n/MNXfPN03m4YKOvOxN1atOi4WJwAqlmGTY0COIQL/4rwQH/aglU1IKRh1NmfnEx
	Bn7Vu7sVGGC68SIes3hBn/TLw8514estiCgD4VpxYduXYOlWVBni7qeetPs102/H
	1C/+RMAT8EibGjkgsnfelHmYMfgoI//uqS5cPjfdmiAm7rE6V/jlLexOi6PqBXCs
	olBCBzaYopumb6LTC43Q2yljXXMeL+BGKBD4N9oE9ymwFXcpoAkL90jYiaoZ933h
	U2VOT1zi5WgRQZRVTEDuxDaHb4tWIMyEsUhRhtncAd7wSKb/AZLaC1xoBiRYUGud
	082omCSn11zwILpkf36uw==
X-ME-Sender: <xms:dvCHaoqlS5XL_Q6y_gPXx5Tvw7LXdJJbskEGUTX5GB-aj9pF3Z-VSg>
    <xme:dvCHalheVOqf3M-9KaLpCFLNU6fBPDQf0lAhA53XrxFUBFis3a0t6KjmsQb7mam4L
    7PJ7j_LNxyUpsv-m-nO0j1Vxk4L6zotLQJMFH4DQWPr52eLLzmnS8s>
X-ME-Received: <xmr:dvCHaljO4X7DuGNV3giZ9t29DLNwJuljf2Rc18WkZfEkdJqQTABGdzjOCUtC-gCiHibA1PHua5E66TMZPuAtYCXlgpeCd41zYntc7T4S9Tio>
X-ME-Proxy-Cause: dmFkZTE4livzZQEViiFuJlDvtHalR/9FSTk/Y5iWxY7udKBKIfnP3uN4Essy9oUEXw/ddw
    JijVdUG6GwV9ONoYIvSUP6ZXdwNbHLP1I5sDorH6MbJdga+4XefrN7F8JAR6WJ1kIDCwVW
    jUqxpCGQWN99uuNwjONbIV9Cgsv647mtk7LKtY61U7aqNOsrn2oCc5kVoXMrsiykDm+AKD
    wd1uWvXMHNycNPQjyv9EW/kjunufvBtvaINiX6v8Lnh91gcSwqsU84wBaG4q2220XUSxvJ
    3kVoCAYCOjix0Qq21t3CSWP5sxd8DsXxdFUbKX9hvR5VzbbAT8G9Gw6OV02lwetirSiwZn
    LZDTpH/2QwiMbcBmfI6cVNnF9c790fgt7OwWtD8CcGPT5UA1hU99VYTtGrJHwz3PygiC2t
    +r3xJtgA7HGRM44ufmPTVWc6UTWEDvi6SvXmGTB/HCxmoxpaudPpn2Zt9/tN+KIQN9my8L
    rRftwGA1LKCfFL//iuVdCoxEnPDeK9zssRzLBAD4vBhHR7V1YYTwiL5QQ9aQGBkBvn9cGg
    sXm40/RKQ1zM+VGnkE9BiWmUf4+AQUxMrvcRoqSeRoq6S+deJBAqHaaoywuYAmHppoa7qc
    4X4TMw5ZIiyKRY1WrMljK5F8BTxLHiqMC9EbzePM58mI+BDIVVPHguzP1/KQ
X-ME-Proxy: <xmx:dvCHargVSfSbK1b3TzjgAxhRYfUYms5puBNAYM1T9A3pCQQV3AKaeA>
    <xmx:dvCHalJMV3f4Ay5q2vemfMozJrFpnxS_IOkUkwD12ZbT4VbcbsJ0iw>
    <xmx:dvCHaqGEUbrdi5uaBFt-NjCUxpQ7uahXhokViiEYB_im1yh-oWKR8w>
    <xmx:dvCHapRmg8qOSm8-NLYpiUTebCTyxZHJ-KnVa6JulbcjND65QEu_pg>
    <xmx:dvCHauzNvmRvGKbBg8z8orv62nwmw_-VJnNjf_AW6CWeK4kLL7LjHVOa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:30:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1917ee25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:30:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Aug 2026 08:30:02 +0200
Subject: [PATCH v4 2/6] upload-pack: generate packfiles via the object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-pks-odb-generate-pack-v4-2-074e8bd641f8@pks.im>
References: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
In-Reply-To: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.15.2

When serving a fetch, git-upload-pack(1) spawns git-pack-objects(1)
directly to generate the packfile that gets sent to the client. This
hard-codes the assumption that the object database is able to serve
packfiles via git-pack-objects(1), which is specific to the "files"
backend.

Convert git-upload-pack(1) to instead use the pack generation interface
of the object database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 125 +++++++++++++++++++++-------------------------------------
 1 file changed, 45 insertions(+), 80 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index a52856d869..22573ad365 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -197,11 +197,11 @@ static void send_client_data(int fd, const char *data, ssize_t sz,
 	write_or_die(fd, data, sz);
 }
 
-static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
+static int append_one_shallow(const struct commit_graft *graft, void *cb_data)
 {
-	FILE *fp = cb_data;
+	struct oid_array *shallows = cb_data;
 	if (graft->nr_parent == -1)
-		fprintf(fp, "--shallow %s\n", oid_to_hex(&graft->oid));
+		oid_array_append(shallows, &graft->oid);
 	return 0;
 }
 
@@ -299,7 +299,8 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 static void create_pack_file(struct upload_pack_data *pack_data,
 			     const struct string_list *uri_protocols)
 {
-	struct child_process pack_objects = CHILD_PROCESS_INIT;
+	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
+	struct odb_pack_generator *generator;
 	struct output_state *output_state = xcalloc(1, sizeof(struct output_state));
 	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
@@ -307,78 +308,42 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	uint64_t last_sent_ms = 0;
 	ssize_t sz;
 	int i;
-	FILE *pipe_fd;
-
-	if (!pack_data->pack_objects_hook)
-		pack_objects.git_cmd = 1;
-	else {
-		strvec_push(&pack_objects.args, pack_data->pack_objects_hook);
-		strvec_push(&pack_objects.args, "git");
-		pack_objects.use_shell = 1;
-	}
 
 	if (pack_data->shallow_nr) {
-		strvec_push(&pack_objects.args, "--shallow-file");
-		strvec_push(&pack_objects.args, "");
-	}
-	strvec_push(&pack_objects.args, "pack-objects");
-	strvec_push(&pack_objects.args, "--revs");
-	if (pack_data->use_thin_pack)
-		strvec_push(&pack_objects.args, "--thin");
-
-	strvec_push(&pack_objects.args, "--stdout");
-	if (pack_data->shallow_nr)
-		strvec_push(&pack_objects.args, "--shallow");
-	if (!pack_data->no_progress)
-		strvec_push(&pack_objects.args, "--progress");
-	if (pack_data->use_ofs_delta)
-		strvec_push(&pack_objects.args, "--delta-base-offset");
-	if (pack_data->use_include_tag)
-		strvec_push(&pack_objects.args, "--include-tag");
-	if (repo_has_accepted_promisor_remote(the_repository))
-		strvec_push(&pack_objects.args, "--missing=allow-promisor");
-	if (pack_data->filter_options.choice) {
-		const char *spec =
-			expand_list_objects_filter_spec(&pack_data->filter_options);
-		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
-	}
-	if (uri_protocols) {
-		for (i = 0; i < uri_protocols->nr; i++)
-			strvec_pushf(&pack_objects.args, "--uri-protocol=%s",
-					 uri_protocols->items[i].string);
+		for_each_commit_graft(append_one_shallow, &opts.shallows);
+		opts.shallow = 1;
 	}
-
-	pack_objects.in = -1;
-	pack_objects.out = -1;
-	pack_objects.err = -1;
-	pack_objects.clean_on_exit = 1;
-
-	if (start_command(&pack_objects))
-		die("git upload-pack: unable to fork git-pack-objects");
-
-	pipe_fd = xfdopen(pack_objects.in, "w");
-
-	if (pack_data->shallow_nr)
-		for_each_commit_graft(write_one_shallow, pipe_fd);
-
 	for (i = 0; i < pack_data->want_obj.nr; i++)
-		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&pack_data->want_obj.objects[i].item->oid));
-	fprintf(pipe_fd, "--not\n");
+		oid_array_append(&opts.wants,
+				 &pack_data->want_obj.objects[i].item->oid);
 	for (i = 0; i < pack_data->have_obj.nr; i++)
-		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&pack_data->have_obj.objects[i].item->oid));
+		oid_array_append(&opts.haves,
+				 &pack_data->have_obj.objects[i].item->oid);
 	for (i = 0; i < pack_data->extra_edge_obj.nr; i++)
-		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&pack_data->extra_edge_obj.objects[i].item->oid));
-	fprintf(pipe_fd, "\n");
-	fflush(pipe_fd);
-	fclose(pipe_fd);
-
-	/* We read from pack_objects.err to capture stderr output for
-	 * progress bar, and pack_objects.out to capture the pack data.
-	 */
+		oid_array_append(&opts.haves,
+				 &pack_data->extra_edge_obj.objects[i].item->oid);
 
+	opts.thin = pack_data->use_thin_pack;
+	if (!pack_data->no_progress)
+		opts.progress = ODB_GENERATE_PACK_PROGRESS_STANDARD;
+	opts.ofs_delta = pack_data->use_ofs_delta;
+	opts.include_tag = pack_data->use_include_tag;
+	opts.missing_allow_promisor = repo_has_accepted_promisor_remote(the_repository);
+	if (pack_data->filter_options.choice)
+		opts.filter_spec = expand_list_objects_filter_spec(&pack_data->filter_options);
+	opts.uri_protocols = uri_protocols;
+	opts.pack_objects_hook = pack_data->pack_objects_hook;
+	opts.pack_fd = -1;
+	opts.progress_fd = -1;
+
+	if (odb_generate_pack(the_repository->objects, &generator, &opts))
+		die("git upload-pack: unable to generate pack");
+	odb_generate_pack_options_release(&opts);
+
+	/*
+	 * We read from generator->err to capture stderr output for the
+	 * progress bar, and generator->out to capture the pack data.
+	 */
 	while (1) {
 		uint64_t now_ms = getnanotime() / 1000000;
 		struct pollfd pfd[2];
@@ -393,14 +358,14 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		pollsize = 0;
 		pe = pu = -1;
 
-		if (0 <= pack_objects.out) {
-			pfd[pollsize].fd = pack_objects.out;
+		if (0 <= generator->out) {
+			pfd[pollsize].fd = generator->out;
 			pfd[pollsize].events = POLLIN;
 			pu = pollsize;
 			pollsize++;
 		}
-		if (0 <= pack_objects.err) {
-			pfd[pollsize].fd = pack_objects.err;
+		if (0 <= generator->err) {
+			pfd[pollsize].fd = generator->err;
 			pfd[pollsize].events = POLLIN;
 			pe = pollsize;
 			pollsize++;
@@ -437,15 +402,15 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 			/* Status ready; we ship that in the side-band
 			 * or dump to the standard error.
 			 */
-			sz = xread(pack_objects.err, progress,
+			sz = xread(generator->err, progress,
 				  sizeof(progress));
 			if (0 < sz) {
 				send_client_data(2, progress, sz,
 						 pack_data->use_sideband);
 				last_sent_ms = now_ms;
 			} else if (sz == 0) {
-				close(pack_objects.err);
-				pack_objects.err = -1;
+				close(generator->err);
+				generator->err = -1;
 			}
 			else
 				goto fail;
@@ -455,15 +420,15 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			bool did_send_data;
-			int result = relay_pack_data(pack_objects.out,
+			int result = relay_pack_data(generator->out,
 						     output_state,
 						     pack_data->use_sideband,
 						     !!uri_protocols,
 						     &did_send_data);
 
 			if (result == 0) {
-				close(pack_objects.out);
-				pack_objects.out = -1;
+				close(generator->out);
+				generator->out = -1;
 			} else if (result < 0) {
 				goto fail;
 			}
@@ -498,7 +463,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		}
 	}
 
-	if (finish_command(&pack_objects)) {
+	if (odb_pack_generator_finish(generator)) {
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}

-- 
2.55.0.822.g20453c30eb.dirty

