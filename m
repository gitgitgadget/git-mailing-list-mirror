Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098044;
	b=BbZmYYiVt/cSGd3rXpdjWQzIunxIwoEQpNuqkWF5gE1Sf/gWMu4gPlXkoJZBirt0mw1y
	 CoKaGFbx1V83JUEPxUrH8b0jZvYalN+3BaxGpEyF+qpzKjs+ihDTES7S2iZGSShDAlfpw
	 RJkh4nWnSJgotnpBpZbJrIVxppD9GBeuH86QQa6US5V6kEj9mLC4YO6d+MYBp134LClVr
	 PFTtvyQvW37HqsfYbU5HInbCINYSclwGPakB0A5YiwbeLNDXDs+1HvkvrclvDHFzqEMXS
	 iqP1lSjui8AGV7eO6h7TS2oR1Nlc4Fu+XPDuxYFGoh+KsUBASijhPOCaZYi9GhalL2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098044;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ZbyV/GN+HBlPdnTiqgsVrqudluh/GuMvCAZa4bRHXHM=;
	b=VznLkpzAXZ3+UUnXDT1nGkvNM2Srgy5jJuYqtuacZiO+jWQY4W+GeBgoJoq+lOSxhaww
	 ZF2tGzN8359T+/IQ92zE6XhaRRZHQQU8HQgymih5K2XCya00/jeAVizCoD3nIyoE3zrct
	 q1g4nKTZ0PU7t/j0hrNdkavrnZbxnDICJIiG8S5V5h5ZXZPr7sy1WTsgR7tb1HTtu+qB+
	 K7neibmBE2F5MuNnkjwwLHt4khj+TA5DU+ZolBaoOHcz8RG71ey5vHhyOJdh6uG7LX5qn
	 YWP1wbV4WqLY0Yhm8KdZoEwpOLF9iBBV/UH7IGo9WXhmD4LgLUk88O6m9JTUnJ3njWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gmfZK4Nx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hPf5gCkq;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC5606A327
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEC5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gmfZK4Nx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hPf5gCkq
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 915AA7A00E0
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 06:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098043;
	 x=1793184443; bh=ZbyV/GN+HBlPdnTiqgsVrqudluh/GuMvCAZa4bRHXHM=; b=
	gmfZK4Nxt07+uM5eMp3Ji/ypz+xV7TDjFQsnjyEFpN16kS6Yls5W45w2WKS5jDEy
	Pml95GTH997utuMEstW0LMwRztUQvAe5Kgz1XQ/czLT311vXDhd5nhI/5pHink9H
	IPjgJvAqasB3YhLfz15tr4FGyyz71S8+j0bMLqUlLARgZPa3oUIzQzkCP4eRgdJi
	WNQvSdsf1tIRAFyAecYJuPqJb9BBewTlOa6CQUR1Ta//OJNriqnUFsIH7U7iGht4
	puzJNJNZKFwNphEFBlKevAOn6QzHUmyW3+PSsFyXRH6liTKCPKxdC4qhP9LwtJal
	fuLFpkhoXN9TvNH8dlOcsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098043; x=
	1793184443; bh=ZbyV/GN+HBlPdnTiqgsVrqudluh/GuMvCAZa4bRHXHM=; b=h
	Pf5gCkqrkpQoyCwYV1OWalWn6+V9oluYI/bm+ceyXGoG+ZLcwQJW691uAfMdpI5C
	3ehPMwnouOz25oWgqQDFzU54PsJ7jxgXmD4oE+JuTPL6yqh+besTBOMBMKB+hJII
	zJRU0iJD7vVKXumE3H8/AToDVAaMTk3xjYoIg0OCSO2dEtuIZ/ZFn9qXQak+WIBe
	l44bqdI2wPx4J4khBrnr9T0iWtVLiB0U0pmkIvUWEK8ykg/I+83+Bk9RrRhoO2eS
	x9nEWWfzdf7DMZDe5H7B+MD6wGMULG+mSfimg1bbrFVwAKoTBhpFzdbvilrLGGZV
	UistLvGFcOJbjWa2E6Zcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098043; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gqW7ThdT/S2ol5NAyBSI1fU5PxJ+JGAw04tGTaeq2xNupNB
	yROm39H2Z/Rc84TEUcX4NqqXvKd95AldBLomn+asjI+GjeeLstk8dnpgoxGezuts
	TNiaUiJlc8cRMVfk84axyrsH99RsHbyH0UiEgio62NFVOXE3wPc8Eer7wkWHgDLa
	AMD0KXZS2seILy3OOxw7sWr70ghVRStruVqMJYuTvMUWRA4f2Ro+1vAbPnAC5tPO
	GzLcL2T46HR3V9ylMaaeDB0LM9mf3KVWoPU7wVtoX7ttiSzPYm5fkJYoW0T+FFKF
	CG5peOcFGgfjzBuZEaZL24Lh5OD+RNcJTjy6eiQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IqiwJiO/ci7FYYHpoecuI7Lbj19MFIzxSiBfbGYx3L4=:AePdhPl9acmhpGtvi/sw1xysMx6S8Kw3TanT9ue9Dtk=;
X-ME-Sender: <xms:O4HgakhJUkSQmK0GrcJY7TyPqa_sbayPBjR5ehugWR65MPl2bWPgow>
    <xme:O4Hgaj_436l62a74qXs1o9S0GQjfKRzX5jhkvVKndiczOXEn85cv7By4Eyd8OWQfr
    0bSMKhiA9U-o8iqNiMT43ipE-hX2z0q48cYj4eJOdwyjzAN5miplvw>
X-ME-Received: <xmr:O4Hgahu4m4Xk8ihStsElBJkjmybQNTqTqm32O3pSk1dRTXWxqNA-LQ>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYII
    J+rqEabWWQCMC/SwOvjAKoRK7nmItfVKKmbTeqP8MQP02hR6hJ0U/pRKMIvcPjFqv2wwq8
    viJrFP8NfBScu1pgMecjF8pISo9vux2Xt6fBXb32ykfpgDgesacNerr4C87mlYbC2pWJ7i
    F092hcaQlebvZD/BywlOw3niqxgSPz7S3zEqEGPtU718cduLri8NKgwK4tTPGuXsQEKGEZ
    O5369xTnQBYRn5t+KYc5wrxsCR8V7eB3lc778xcZrHzU6x1kilGPxqpnZZncPstXw8hFDl
    o5UtFtV8M5worBv+lIDkYLtLEqH/kbe52eJUZqhrloZsDyjRPgqxJ/ubXoXA
X-ME-Proxy: <xmx:O4HgaqYmD1ZDjWqjN7cNghpZzzzbm8ka0_qas0swPMfau0Rp00bGeQ>
    <xmx:O4HgahqOWXdTcdA2F3g4PEgSZdKlIMYet_Q5iQI1iRQ7YpgY4EqZMA>
    <xmx:O4Hgav_Jb5QG1DHg2kC8Ri0KhNStu0A92mWVkOVqKMubmrftfTx-gw>
    <xmx:O4Hgag8lJwvLxaMyWjkgnKti9U6D4_1Kk8T-hxdM-kEt66g4qZiizA>
    <xmx:O4HgaphrUh0GAl82E8Rvro7O2X-FMC31buEDBhC4pLtWvTtfWxBaFKMW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 454df844 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:51 +0100
Subject: [PATCH 08/12] builtin/rerere: turn "remaining" into a proper
 subcommand
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
Message-Id: <20261027-pks-rerere-subcommands-v1-8-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "remaining" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index e2955fea20e..31c1b37540e 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -94,6 +94,34 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_remaining(int argc,
+				const char **argv,
+				const char *prefix,
+				struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_remaining(repo, &merge_rr);
+	for (size_t i = 0; i < merge_rr.nr; i++) {
+		if (merge_rr.items[i].util != RERERE_RESOLVED)
+			printf("%s\n", merge_rr.items[i].string);
+		else
+			/* prepare for later call to
+			 * string_list_clear() */
+			merge_rr.items[i].util = NULL;
+	}
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_status(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -160,17 +188,9 @@ int cmd_rerere(int argc,
 			  skip_locked ? RERERE_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status"))
 		return cmd_rerere_status(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "remaining")) {
-		rerere_remaining(repo, &merge_rr);
-		for (size_t i = 0; i < merge_rr.nr; i++) {
-			if (merge_rr.items[i].util != RERERE_RESOLVED)
-				printf("%s\n", merge_rr.items[i].string);
-			else
-				/* prepare for later call to
-				 * string_list_clear() */
-				merge_rr.items[i].util = NULL;
-		}
-	} else if (!strcmp(argv[0], "diff")) {
+	else if (!strcmp(argv[0], "remaining"))
+		return cmd_rerere_remaining(argc, argv, prefix, repo);
+	else if (!strcmp(argv[0], "diff")) {
 		struct strbuf buf = STRBUF_INIT;
 		struct rerere_cache cache;
 

-- 
2.56.0.341.g393f52fd96.dirty

