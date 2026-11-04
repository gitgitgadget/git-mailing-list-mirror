Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752060;
	b=dozbtdQfRtSlnmnkJr+wK78jqV7hZBylYLVmGFvnkOKNvxhH8kE5x/eC24DyotOOKpmM
	 OFJNcSo0j1WkAleYPcHCdHVPx/q9ESuvQhSWjR/dGKz35QsxH2BMQQhTsuOJ6d9ZfkKR/
	 N1y8aK9M/VZ2HOKex9oTdWH1+4oYKMAmoLzHzHBuilXJWx/cito6c6ROCYu9OeIPEDPaM
	 cjPaoYL8CHeDuOU1ZJlidfH2aA5DAQWK99pgDpgcxCI+1ZpjPldxtZlkpWCHkgrbpvFbQ
	 +QBZkexQ5YN7KoKp1uo99DVt3C/fnu0n/OHZcADEwktgFzTerLGCG7hrBIPN4gvo1hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YIrLvC3uzIZQMWWE74OtBTUK8HeOruQeTqtawsHtXHk=;
	b=szFtYFSToaL29D9pfMDVGqVANtMj+4I2IHI1Ag1PaieFtWgcmpTP1fj9CDIvTXKKAQ8Z
	 0r0A0LFhQGuamgNm2DGHJK8+GcMDTn+0btO6NHSpmt/YkUMBN5iaUPfW8llflNBhudDHU
	 PkhSxAA5f2E6+wSgMt3QqwgJk3IrBccylD/of7A63YbLkHq9MqwbhHxyXl/EpBgnW7PXS
	 RhAoV9PmfCJ4HWALr4ammH42nX9SCRG2qlry0QkZXTfXyU4tKMlYJDLKlrhp0U40YXSyr
	 oasWSemJuztaV8YcjHY4MI7rA00fPsX28YsG9Zt9CSMgWSsydu9X9TPDSzGvJwx9mvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZfXZsp2i;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D85606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 00:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D85606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZfXZsp2i
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6dd7070699eso83611eaf.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20260707.gappssmtp.com; s=20260707; t=1793752059; x=1794356859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YIrLvC3uzIZQMWWE74OtBTUK8HeOruQeTqtawsHtXHk=;
        b=ZfXZsp2iyBkv4zYFM8imprEkm7SRTmnJeVnnXIaR6y3ckRxGHWRnoLVfDvKwZHAxs/
         Mrm6/j3rFXVqK1LeJQ2mvYZbpNVnsw70g1Ii4+YdJwBgRyP/hIcb++eXfblJkmK+njzE
         gxk/x8coN/r6vNF+cZriDNFKWJ/JLftFnlAUbWtHlVXOdYOk+2lUtjMlr7C70G0v3Vnt
         Hi+qY2N21qjHo7ayYI/03DH67G+qy9TzCxIpnxoovfNJf/LrIri3Pf8BNy/Hpn0Y0O/Y
         p95MrJMGluspjBiMtj1y00cvZEc9OeYpLztVh0TS5SCP8BMXwqQ/E2lAEYvXdHCBoVRz
         Us4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752059; x=1794356859;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YIrLvC3uzIZQMWWE74OtBTUK8HeOruQeTqtawsHtXHk=;
        b=1NCMZAcIwWPtlKgGyGpG9V9mLOGRw/rj4oDtLHReZWDdRVcLC4RxI+pQA764j93G+Q
         0NmIRZjdu2HMkYtP6jItStmWSpWKu2DcAojxLIV87BvpptNJBHxkvbjLWdOzhzhI9T2l
         ElAvIYSy6qMgolISm1jX9dWkhZuluG07ZClbYCZr3MRanYC+tbB4AAMgnOMJPmTO8MAz
         1wUrZr12kEXefppL6KqDD8CLpcq257ap4Vb1WxKRlg12GLfWA9A/U6Ig/dQ9uQYoraan
         4lsZCMrvCIKgeHKfqhGJ0+5nEcpuM/vEwn7G47I3g+h92gndcdZorg6XqqQRQpNoVr4l
         wXvA==
X-Gm-Message-State: APuU4Z/dgUjbVrgqvjUHdPrQjgrZ/EnFMR9fxV/y6MBHkAn/PAaP3h9C
	6k2qp3ih4eI/sF0F6lAmqz+NewxsG/TcF6f0D/vY1Gg8kQIOMEUFIKxFZ99YiqPMlqIeUcjTQht
	3bAn4
X-Gm-Gg: AYBFou2+DHntZDXhKws2PKGY486iQTkYUdtQ0r+KXiH+csqb71xgYtW/dX23PgPpg+g
	Pp5GlRgG+AtO7bTrrbUcccc2JdJoMMRXazSvFnbcEbHKcMiEDDTHYoDNg8wwyC5IHxEbyLk6X/V
	Gb194IS9m30djyZ13vobipO7LjbH+SP7Rgp56rSWbwE3Z5PNMnnxhJLDGJll5svF1dkMqC9N2vu
	xdPFwg09RCRySNXhHG6eqW8y8itgvrzjCnCUTd7fZ3TJzAAcFPjqvC4yt7UrML8LTa13rpE9PG9
	sRdST6rS+RVtifliHDxPUL89+nf27te7f9EXVtEMZ3M4uiLdW1ZNMvpnicB4SuRZ7BVTlJEGvd5
	dRlyP3Gt4+YhpRzZdNMGJXI2UkrH5E0douopIXLCOZBlc7YXSmRVxGpWiuJBnZvs3bozMbS8y68
	6RVrg7kF41ZbmsHXln+lt/gjQSrik7l4h5JbsuycuMOtUtYwiDZLlC0tFtATsDTXXgXeeMyA2R6
	HnRlQk0kfQrdw4oyi/kE/NzgbV06139ycCmKa2S3Yzz4+YATfi8ZfeyM7lVuXdFAIOpt5YliMf6
	w2ZZhzJtjgmW/MMJ6Aa6pCRShZykmHv+Mp/qj7a04+0jCTnmtz8u
X-Received: by 2002:a05:6820:a515:20b0:6d8:57bf:57de with SMTP id 006d021491bc7-714f24fb57amr6020626eaf.65.1793752059109;
        Tue, 03 Nov 2026 16:27:39 -0800 (PST)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-716c1308c96sm502295eaf.11.2026.11.03.16.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:27:38 -0800 (PST)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Patrick=20Pero=C5=A1a?= <pa3ck.perosa@gmail.com>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH] push: fix --force-with-lease forwarding in push_multiple()
Date: Tue,  3 Nov 2026 17:27:21 -0700
Message-ID: <20261104002721.304153-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

8ea8281665 (push: support pushing to a remote group, 2026-05-03) taught
push how to handle a remote group, but mishandled --force-with-lease.

Fix two bugs with remote group --force-with-lease:

- Bare --force-with-lease always rejects non-fast-forward pushes since
  it was never forwarded. The bare option sets cas.use_tracking_for_rest
  without adding a cas entry; only cas entries were forwarded.

- Using --force-with-lease=<ref>: (i.e., expect that <ref> is absent on
  the remote) could overwrite a remote branch if <ref>'s remote-tracking
  branch is up-to-date with the remote, which is the usual state
  following fetch.

Reported-by: Patrick Perośa <pa3ck.perosa@gmail.com>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
Thanks for the clear reproduction case, Patrick!

Based off maint since it's a bug in 2.56.0.

 builtin/push.c      |  7 ++++++-
 t/t5533-push-cas.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..7f0091206a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -627,6 +627,9 @@ static int push_multiple(struct string_list *list,
 		strvec_pushf(&argv, "--push-option=%s",
 			     push_options->items[i].string);
 
+	if (cas.use_tracking_for_rest)
+		strvec_push(&argv, "--force-with-lease");
+
 	for (i = 0; i < cas.nr; i++) {
 		if (cas.entry[i].use_tracking) {
 			strvec_pushf(&argv, "--force-with-lease=%s",
@@ -636,7 +639,9 @@ static int push_multiple(struct string_list *list,
 				     cas.entry[i].refname,
 				     oid_to_hex(&cas.entry[i].expect));
 		} else {
-			strvec_push(&argv, "--force-with-lease");
+			/* <ref>: means expect ref not to exist */
+			strvec_pushf(&argv, "--force-with-lease=%s:",
+				     cas.entry[i].refname);
 		}
 	}
 
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 2e14aecaa2..6a56aa46d3 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -168,6 +168,48 @@ test_expect_success 'push to update (allowed even though no-ff)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push to update (allowed even though no-ff) multiple remotes' '
+	setup_srcdst_basic &&
+	git clone --bare src src2 &&
+	test_when_finished "rm -rf src2" &&
+	(
+		cd dst &&
+		git remote add src2 ../src2 &&
+		git fetch src2 &&
+		git config remotes.multi "origin src2" &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		git push --force-with-lease multi main 2>err &&
+		test_grep "forced update" err
+	) &&
+	git ls-remote dst refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
+	git ls-remote src2 refs/heads/main >actual2 &&
+	test_cmp expect actual &&
+	test_cmp expect actual2
+'
+
+test_expect_success 'push to update (protected, expect absent) multiple remotes' '
+	setup_srcdst_basic &&
+	git clone --bare src src2 &&
+	git ls-remote src refs/heads/main >expect &&
+	test_when_finished "rm -rf src2" &&
+	(
+		cd dst &&
+		git remote add src2 ../src2 &&
+		git fetch src2 &&
+		git config remotes.multi "origin src2" &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		test_must_fail git push --force-with-lease=main: multi main 2>err &&
+		test_grep "stale info" err
+	) &&
+	git ls-remote src refs/heads/main >actual &&
+	git ls-remote src2 refs/heads/main >actual2 &&
+	test_cmp expect actual &&
+	test_cmp expect actual2
+'
+
 test_expect_success 'push to delete (protected)' '
 	setup_srcdst_basic &&
 	git ls-remote src refs/heads/main >expect &&
-- 
2.47.3

