Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098050;
	b=SSO4VXPGT9+yM8vgw9g/1d1vBcBU1nt7AWFWE+1PFYcUNoe4wJrbVnl0VTgZr4JAmHyd
	 7XIIn/JJgU45o8HO7Yx7wOUSf3YaymhQ1BQndFYbV+OuyQQpoct6uxQyB7FgAAmQsBSvV
	 UhwkdYiTJU10FV3Dlpk8qhB3mAwfAssM4Fmt0lJVRi9n79gO9rk0Dlky2ZOuQYUZS8X46
	 aubf3TqJWwhOyM60N3psk1We6TgbFsF3VicUR9V62/OoOwf68nYnPlU36iYdoWOqARQ/f
	 56ASvlTES6C/oufrnLMFrDM+oYlQMvsyk3yQE2KefbJBc3Z3u9VvKT6ET1fdt12OYhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098050;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=x4uPlJbw36Q8P4p5+NuzbfCHCG4/fY/Mq3ZAQtL4B3U=;
	b=ftLpWZa1A67sj6gGRx+zbZ2g9fI5J+BJwCJFKOM1586penJ4t1GWFpCbz5OQy5zoqAUq
	 De5vs1rD8e9/VDLqnVW47HJOFIcWQBezMqN9lPxRtyHoWLH8KiFxD8HQ28ou3WP07D6CP
	 9LTWy/QN7/1qQmqms9Vdq4s+lZMbpAyj0xr2HjQtW4qbq8KHuFsqV+6p/WzbHVYqThycn
	 jZm6m4w35co9flb5vF1+Jf8E7O3jEvSOm5QXCrbFwxglngh72ncxlW++qT2+GWUB7HJO7
	 zX8cHpsYM3YWQtbj0Jr/sSbBYJah3rx6iBB2GHttgAAsW+FqYW4iCzkz0hE2Kno/vlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=YiAy5nJj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MDMdIac9;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF1606A32A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45AF1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=YiAy5nJj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MDMdIac9
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 777B01D00119
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 27 Oct 2026 06:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098049;
	 x=1793184449; bh=x4uPlJbw36Q8P4p5+NuzbfCHCG4/fY/Mq3ZAQtL4B3U=; b=
	YiAy5nJjWAn+bXsibw52z8OVauzvZiedZGhSAFfmiFAjvqfhhzK7I9+rkUCf3B6T
	p1VSIi8bTUfabKK2/rF3sVImfd7BEV2zCerjoyqbtXr/cIvQNE/XimHwzN7LndtT
	6qIbRlsv9SsIGx22POXOXi7y3es1W296d3FwZ48wNH66f5m4CicjaTAvRS2xftmZ
	3IcCZcJr/2ZC3ET2RgNLGoib+BZKbNseo6oZTgUc8jcgHR4SCBlz8DYx2s6DbASI
	VQR9kW8QqPVUG0yZPqjeOQRH/8I/jpfRF4rcXrUYVL+PqxPhkyAhBQ11JNm/RJmg
	AnTc9epsPststKwHRcnv7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098049; x=
	1793184449; bh=x4uPlJbw36Q8P4p5+NuzbfCHCG4/fY/Mq3ZAQtL4B3U=; b=M
	DMdIac9wzpeC7sg4bTmIU7l4KN7LYEes7/S62VQFL4XuWIwOgx2lmahBxnA0yojE
	chcg6YcwRWGHq3coKghXxflrGxxUgVagMfw5LsqeUj7f65eW5Hovjv80ggkxuPfe
	P6GqGEO2m1sDH45EdXxdA7m6MgR3ote/z8IRPzTl7Fa68lIYseXgt0rDmyouytcU
	nEZVj913PpN2bnQ+L4ZBB9v9EVD5BZOjoeCwn/z4Ham40FtRaEGF4p0kBJ1ywp9R
	fgx/NoMFfQAXhf6KIsN1YiH/tOAFsU5ddXWe1Kbf7eGwwHHgiyfCRSAe+doWl23/
	bB0PY74xZcR803G+dQw8A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098049; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JhOY5s1Rdxs3ZKZtRtOZuKDCYoWMRNHhfiqpY9nQThzxmOR
	WG7FWRNfe5NzCEZ/1OAvCzZx73kAA+JzufItf/Bzg8aNJLlc46njMorb4l9mAIJ7
	jKG4qcokImaO50FW3rprxVX5c7wAlOBtYwTybX9L5oBr9/yG1ytO/elfWJ9pCoyK
	Zvco+FR+mKXNLgOpQbayn0f4Y6+nzKuTJ5TBn4tFK/vAk4RvIQKRPE/4IRi2VeF1
	qgFTT1R/2eW5OT4VCojVsunvZoFXgwcyInAC5W/0vbuZUin24cz5vRIgt3Bk24YK
	2orE3bjeWvqfUrN4LkNgNmlHg45npeC+dxvR0MA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1l3kchFTIt4+rBvZ6yBrTYMYgdRt/IWV2icoscqBayM=:JZX0bxlJceQzs6yd8kwV4BOAf9AqPrZhCmaH7wkeUEU=;
X-ME-Sender: <xms:QYHgat0AfwQNeL9nPsG7vDUGvM-sml8dNYW5Jj5II_CynRgKAroDaQ>
    <xme:QYHgarAANh2X9XYfPcVARjHrxf69hWAnjtULGjR8x16GX28Wj7nsG-4rMfySzI1on
    7O8S54mRhRr_HAOuczkGLj-mocyfuIDsyW-JJU_176pHPt_zNLg1A>
X-ME-Received: <xmr:QYHgajjW_rL89HU5-Ug0xDYkV7OaZLuyFz5H9p4OnRqt-YZC24N0Sw>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYfL
    J1Or8HQq143XPJm7XLsn1eXasdTNUXYj8pPKm07JqSFd0smWJmri25YjzLGkaMPNBrgbPy
    +i3I3rruGhVxe0vcY2QievJZIvxu3fwP3tUifs+P45Bfa//kyWo1ew2ATeN4gN9Q8yf+Pg
    q0d0px08rv6OmZJhZ0ZlIYSTlnqQEsb2nkOiuJJOlOt3N5NekZ53INUPW5nJLAGzB/Z2aH
    AmqgBBW4a0SfvOy2bejdSy8Esjac3dmm5CucGDW/585Og+5hPpCoAq67Z2husQ0IQy3QtP
    Gp+zzSOo/qunHEhoUfkfQf0wnOwVTUprLHo24AsmSSJS9i24VRLcjwzxYAVA
X-ME-Proxy: <xmx:QYHgav8GDZ-DJ0sGBtdK1ygJH0Epk1Jdp4wUo8ZiUcbKOzhEf-0J7w>
    <xmx:QYHgav8JDqOLfmLh1-bMogFmamHkS_rcFfqnF4miZkGxmQLFKnmVzQ>
    <xmx:QYHgaoBItCSY1teYTXBYCYxKdw-txmgf8tBRQiiqnPGTtDvI-VmqRw>
    <xmx:QYHgavzn5H5epEtrazwX6mkytTof9AGhzwoK7_wguVLq0ua68dIEoQ>
    <xmx:QYHgajEU3anxFM5xzJnQPfQRofNnrXb9RzXLjsIEhg4EPLrrrDQo_1fD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6578a52b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:53 +0100
Subject: [PATCH 10/12] builtin/rerere: turn "gc" into a proper subcommand
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-pks-rerere-subcommands-v1-10-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "gc" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c  | 43 ++++++++++++++++++++++++++++++-------------
 t/t4200-rerere.sh |  5 -----
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 87ee4eddd0a..67626e13845 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -128,6 +128,30 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_gc(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo)
+{
+	int skip_locked = 0;
+	struct option options[] = {
+		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
+				N_("skip gc while another process holds the lock")),
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_gc(repo, &merge_rr,
+		  skip_locked ? RERERE_NOWAIT : 0);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_remaining(int argc,
 				const char **argv,
 				const char *prefix,
@@ -187,21 +211,16 @@ int cmd_rerere(int argc,
 	       const char *prefix,
 	       struct repository *repo)
 {
-	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int autoupdate = -1, skip_locked = 0, flags = 0;
+	int autoupdate = -1, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
 			N_("register clean resolutions in index"), 1),
-		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
-			N_("skip gc while another process holds the lock")),
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
-
-	if (skip_locked && (argc < 1 || strcmp(argv[0], "gc")))
-		die(_("the option '%s' requires '%s'"), "--skip-locked", "gc");
+	argc = parse_options(argc, argv, prefix, options, rerere_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	repo_config(repo, git_xmerge_config, NULL);
 
@@ -215,11 +234,10 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "clear")) {
+	else if (!strcmp(argv[0], "clear"))
 		return cmd_rerere_clear(argc, argv, prefix, repo);
-	} else if (!strcmp(argv[0], "gc"))
-		rerere_gc(repo, &merge_rr,
-			  skip_locked ? RERERE_NOWAIT : 0);
+	else if (!strcmp(argv[0], "gc"))
+		return cmd_rerere_gc(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "status"))
 		return cmd_rerere_status(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "remaining"))
@@ -229,6 +247,5 @@ int cmd_rerere(int argc,
 	else
 		usage_with_options(rerere_usage, options);
 
-	string_list_clear(&merge_rr, 1);
 	return 0;
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index ab412ecc6e8..0d4cbf5114a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -263,11 +263,6 @@ test_expect_success 'gc --skip-locked prunes while MERGE_RR is not locked' '
 	test_path_is_missing $rr2/preimage
 '
 
-test_expect_success '--skip-locked is only accepted by gc' '
-	test_must_fail git rerere --skip-locked clear 2>err &&
-	test_grep "option .--skip-locked. requires .gc." err
-'
-
 test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
 	git reset --hard &&
 	rm -rf $rr &&

-- 
2.56.0.341.g393f52fd96.dirty

