Received: from mail-oo2-f29.google.com (mail-oo2-f29.google.com [74.125.231.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD634772A1
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515229; cv=none; b=NZ3UiIwJM2RI4E+2Hj2J8VSAodkvXr5k7XowNGhZarpst9kBwyL22+BuzR11RK8UhKfBQhjl03i2TYmdtIyBuUkIBEPpQqJxUJt+3BPHaQau/kPndRrgINom9O5dvrUAwlnjW6CYENejHPlpfhQPZqs/Ldu6EV07sosiP6QFHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515229; c=relaxed/simple;
	bh=ZopxqhEUe88i/prO4X/PJ5fu5MfCorFZarnmSoHuJeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckW8s7qBkj80z/LTPE6Nvzeu3rTKpOIYLngdLfAup9MpjV9FFCy+aanU9s+e+eurUacZriV/YUX6zP/O07XMMkSoDVCsVtjT/C2DTQ0CO2VLmUb74xZAlkzqYtBGLjYDz4asktyEpeUdpyIVmrKdO1SwgdJg/VeRgdQdPxzsF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=q/wmBO3N; arc=none smtp.client-ip=74.125.231.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="q/wmBO3N"
Received: by mail-oo2-f29.google.com with SMTP id 46e09a7af769-805cc8b4231so178759a34.2
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789515227; x=1790120027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j17Cn//xKNZFBUsfcYOsYGMrWOuMdBInnoLQs1IqLkw=;
        b=q/wmBO3NF2xMUXgnyHel3tDKrkNfEL/E8ufgLlJSjge//0wsWTelORrzy42VRqgzJG
         t1oOmKTfKXwZM+SkqwMPVK9KthMwonJViQxUajjLVdkcYGXBLAF5w5QyrgUzayM2HT8B
         4Vx1xy+f/Nm8TBOrigre6INDXoiVgigpCf/6/cBof14w9WfyzKMTI/x20Jdoh/b8jkTI
         P8VPYeMWFvNGfdIo/etNW2T+DQm3kwsU65izfLOAe1FoLhvTxGv6ZyYn+W0klZ+Nj2kg
         PJM0uHEtU7U2ODyOp6ZRHTH8wTt1xiX256bLADUEhDybhs2wRo44iNAQ5y3UYL/T5TEa
         NRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515227; x=1790120027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j17Cn//xKNZFBUsfcYOsYGMrWOuMdBInnoLQs1IqLkw=;
        b=O778LRPf+PGTiBnIfgvgQJYwczi5DJibZAmdBG3oQ0nDY1R3+ydAmpwdCs2BdxuViB
         +yAKWoD21vk3NMarCEgcU+GugGIwvwPpS5cWuo79LYSTbwxTgNQEqPNN9Vfq6KE5dPs0
         61yFDT8rNlEqOTba1axAzXLn4UXakP830zg4tyVg90/CjPDuysrmVXurCWkMrdiz8T2+
         NNBRkRJMH0YnYTccVoIE0x0CpePcEsq4ChygvHWBX2a/vyUeG77pIGU7UHuZGjHI4nXX
         n4yyu2+LwQ5mDpFJJ/TnjLg3cAQaXgkk2PbsFqvPVUW4A/ZFrp+4A1P4xOETTRichZ2Y
         BurA==
X-Gm-Message-State: AFuF++n085relBKIQc/9ACGYdIfjgp0gOdxi33gn10skk+ECt/+It0xp
	MSnre3UnSOCpIPgY4qBV9UvFBdLqKHhKfGnnmPx2rUNYpgj/CmcoGs53GctfL8/nmwqf2XO0ivs
	zBLV5LDU=
X-Gm-Gg: AYBFou0hnYG7eqvgC3kYZKt6BnnM8l+B2zvt+lATxL0PMEPo/oocR1uVw9Z1kJ3wtjs
	Z/HYVgDWGggrKPD3UriKSouR2TaLF3cQpAJf18UDnsaLamofKupDxn+i2M7heSUOHmuWIOumkIg
	4fBgzJFMPs1aF49szvGTbtZMRXRMvjHwjlCBoUXw18zS2pbsE9a4dQ8yrpRII5wWbycsjVWJ1Cs
	rj6UoQo0Ga6YrUSDVep3JAfY997sghdPx8h7YwueOuRVpr3NxK67THNOCG0KGTCYi7ecG2NatJG
	jm2JCs8L7K/z3N0iHBPqJURrpcV6BDVku7n1k2VukDZsVj6deywzDuy5tIfOU+S/szH4yO4MENN
	j9CUeNQZ0Ycom+g20FkbwqCQEyFXDo59N0ec1HKsM9b3Xlc4vAmDyVQjiwZaQpF63Q94ahkQugU
	7OpaztHu8+fNM3ekcZ1CxTwrrpCIjWxjFaF0jvp8ti+X8tU4b9sfc8AoeFFYFM4nTu7GzgGEc=
X-Received: by 2002:a05:6830:81d7:b0:7f8:4b8d:d93f with SMTP id 46e09a7af769-80b2c6b363cmr653596a34.13.1789515226722;
        Tue, 15 Sep 2026 16:33:46 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-80b06685250sm957111a34.7.2026.09.15.16.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:33:46 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 3/3] push: --force-if-includes should allow fast-forward
Date: Tue, 15 Sep 2026 17:33:05 -0600
Message-ID: <20260915233305.334115-4-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915233305.334115-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260915233305.334115-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In set_ref_status_for_push, we verify --force-if-includes's reflog
reachability checks before fast-forward rules. As a result, valid
fast-forward pushes may be rejected when a force push is unneeded; like
when the reflog is expired:

    git clone repo.git repo
    git commit --allow-empty -m 1
    git reflog expire --expire=all --all
    git push --force-with-lease --force-if-includes origin main
    ! [rejected]    main -> main (remote ref updated since checkout)

Rejecting fast-forwards is a mismatch with the --force-if-includes
documentation "Force an update only if the tip of the remote-tracking
ref has been integrated locally."

Instead, defer check for --force-if-includes until after determining if
a push force is needed.

Opted to create a deferred_reject_reason in set_ref_status_for_push
rather than move the computation of reachability or verifiability to
winnow scope of changes in this patch. Lazily checking for reachability
or verifiability is a valid followup.

Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 remote.c            | 16 +++++++++++++---
 t/t5533-push-cas.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index b7b5ac0d28..db0b50b030 100644
--- a/remote.c
+++ b/remote.c
@@ -1669,6 +1669,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		int force_ref_update = ref->force || force_update;
 		int reject_reason = 0;
+		int deferred_reject_reason = 0;
 
 		if (ref->peer_ref)
 			oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
@@ -1693,16 +1694,17 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *
 		 * If the tip of the remote-tracking ref is unreachable
 		 * from any reflog entry of its local ref indicating a
-		 * possible update since checkout; reject the push.
+		 * possible update since checkout, then remember the
+		 * rejection in case the push is non-fast-forward.
 		 */
 		if (ref->expect_old_sha1) {
 			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
 			else if (ref->check_reachable && ref->unreachable)
-				reject_reason =
+				deferred_reject_reason =
 					REF_STATUS_REJECT_REMOTE_UPDATED;
 			else if (ref->check_reachable && ref->unverifiable)
-				reject_reason =
+				deferred_reject_reason =
 					REF_STATUS_REJECT_UNVERIFIABLE;
 			else
 				/*
@@ -1746,6 +1748,14 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
 
+		/*
+		 * If push is non-fast-forward and we were asked to
+		 * verify the reflog but were unable to, then reflog
+		 * verification is the right reject_reason.
+		 */
+		if (deferred_reject_reason && reject_reason)
+			reject_reason = deferred_reject_reason;
+
 		/*
 		 * "--force" will defeat any rejection implemented
 		 * by the rules above.
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 38576917e4..53e241c5b1 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -421,6 +421,33 @@ test_expect_success '"--force-if-includes" should allow forced update from HEAD'
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow fast-forward push without local reflog' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		test_commit I &&
+		git reflog expire --expire=all --all &&
+		git push --force-with-lease --force-if-includes origin main
+	)
+'
+
+test_expect_success '"--force-if-includes" should allow fast-forward push from tag' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch -c newbranch origin/main &&
+		test_commit I &&
+		git tag T &&
+		git push --force-with-lease --force-if-includes origin T:main
+	)
+'
+
 test_expect_success '"--force-if-includes" should reject forced update from differently named branches when local lacks remote ref' '
 	setup_src_dup_dst &&
 	test_when_finished "rm -fr dst src dup" &&
-- 
2.47.3

