Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE939733E
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355631; cv=none; b=mGZlCoBuzedSstcHX8NwoZKXgoiay1m/aDYo8r0rylOcq5bnuqnJXYIb0q3hh92gKd8ygdJ9tLc9kwxSGV7XAfwiQ9gK23YWjJ4Gz+IyDYEEeE+AqOU1+XkCBN/QLnwxruSPMrqBI3X6xd549RBs4lVsuN4Zjlp/EF6qPsFU2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355631; c=relaxed/simple;
	bh=Jl3GYG9vbyIwMV3BSvpDqnm0qg3QtWCaZd+AbKYfXuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3TLaJFoQ7Lu9SK59/cpferWt6yr0FiW1ItSQcYxbcKWSPY3lRTQBvh0Pgy06bXoebG/vni+Pjo6Q+yn7ZHoEsOgfJoRnuLGVSLfs44s4UjjzmMbAXYviAYJAlGP8dFhq9mNWm2MdbiIZKM3c/hZNvlCWXD98crAA4kT4QlfCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=L+YiT6/L; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="L+YiT6/L"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-843a4ca671eso670646a34.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792355629; x=1792960429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tx99+7x7Sp07RtLsh8O1ThaSFYaRVHMS35crL/aYMqc=;
        b=L+YiT6/LaVo3tMS9qVENNDuljT7Knsep2MbU8GdkHtBdjcnumBAwFDJXEBqeFkRiPV
         doH0e7ZNzav2Ta20fqNL6qwPydmg6RJoB1PYGKZw8zbvdS+NgW2IqhENa/K6ZKm3guiU
         AWzz2Ei6+N2HiOSuXcd+pPmnvF9QXjgnpLfIhiXUIr53E2F5WLF+19k/FwkP1Ep3GYnQ
         HdQXHehg44TysFmP4h/Or6swnVFZyoMHKf9JTITvY3KMweRBdk9qtKi2pRGtlSuLdJAT
         PaN0hlrvXSBt1+asNhtCqhom/Fm21kp1AppWDzjj0z0YZitr2b0oIcka/+BPDF14B4W9
         6VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355629; x=1792960429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tx99+7x7Sp07RtLsh8O1ThaSFYaRVHMS35crL/aYMqc=;
        b=J2g+h5pxb31fHk/zcSRib7Z9SPVxLFugscMw/PsllcbPB/nRqWYgry/9TlyyEYUPzF
         J1EyQ7gCSyIidSUlE6TusC1EHsxteJelNgV9Ob41wy6WMLZ5Nqrsz5dMUk7ZIX1erxyd
         xl64uBrXDYFWle8J80pe0zGvFz6DO5QwwQrsKgYkQ/BojbYitlFY0AbvLSuZ7JrX0pa/
         0g5Y41msIzgUmfdU86KOOXekyKgrll11YlKlAnDUpP5IJg1JtUBCsiuyKN950F9FUcJw
         2JiOICRlgXBQGnrhSBMQ03f88C/v5k33Z/7Gm9IUUE4uodpEbWJXexHbkiz/8K1PofcM
         0L6w==
X-Gm-Message-State: AFq9FYJNnacSSmAievtte3rQcgVpCh5UDxBR9hmBT9+8KWfGpyt9TdmX
	VEJDt6u/+lnOkAVLqh6AS1Rk4rnoB4Qdlu/B2MLFAhv+hKOMkM1nyu4QnwXDfhhoKJUnr74KScZ
	pljQj
X-Gm-Gg: AYBFou005Xo8F5h+dIEoVCtnQkdIbfuPvb/naL2wFtZSU/UzPMkaFiTws8NDifUL2R2
	iFPNEyRjCvkg7qoygERzeNUQ930TyxLWHdptZ2WFLsKJoCPJ10NVS9k/AlIvH4tW/RmxO1gbBMB
	KFBBkMfHABqO8Wnvk/8GI5/Cn8dEFJaNx+LDbKpbZB1Yujm1X0A3t5ARJ4pjje53WoJcyXbgcmS
	xU/tzyYOx/0bmbUzK/vLzrwb3i2SJVnk8plksHV+cDmamDDcAImQvLwCeFdG8v7yP/HEashHboE
	BPH1xpNDcLlyH3q9WWBHbf/SIJN7fFX9vZLIlz6SAASOteZ+dTdj7orCDNrGAYgAOVuu2szwx+j
	99tuynosslcB6JJBioo0zTacnH3rjXUvblhmrqu1bZdX+uH+12BD20Zo8kswavgf16yp3ODiIbh
	QtOlkXGSC23o4AQSXp2SrJgAPQpUADqb0nBmhthQm/kJjN+F13vkDWHe6HzVLaYXITXkCqRWTb
X-Received: by 2002:a05:6808:6716:b0:4f9:6348:cd3b with SMTP id 5614622812f47-53ccf4ee273mr4729565b6e.41.1792355628768;
        Sun, 18 Oct 2026 13:33:48 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-5388a5572b4sm5867334b6e.6.2026.10.18.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:33:48 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v7 3/3] push: --force-if-includes should allow fast-forward
Date: Sun, 18 Oct 2026 14:32:54 -0600
Message-ID: <20261018203255.2343005-4-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018203255.2343005-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20261018203255.2343005-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In set_ref_status_for_push(), we apply --force-if-includes's reflog
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

Instead, defer reflog rejection for --force-if-includes until after
determining if a force push is needed.

Remember the reflog rejection reason as needs_force_reject_reason. If
the fast-forward rules reject the push for a ref, show the reflog
rejection reason to preserve existing behavior. But if fast-forward
rules allow a push (a fast-forward, deletion, or new ref), then a force
push is unneeded, the reflog rejection reason is discarded, and the push
proceeds.

Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 remote.c            | 16 +++++++++++++---
 t/t5533-push-cas.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 4258d8dabd..0d7fd62a95 100644
--- a/remote.c
+++ b/remote.c
@@ -1687,6 +1687,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		int force_ref_update = ref->force || force_update;
 		int reject_reason = 0;
+		int needs_force_reject_reason = 0;
 
 		if (ref->peer_ref)
 			oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
@@ -1711,16 +1712,17 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *
 		 * If the tip of the remote-tracking ref is unreachable
 		 * from any reflog entry of its local ref indicating a
-		 * possible update since checkout; reject the push.
+		 * possible update since checkout, then remember the
+		 * rejection in case force push is needed.
 		 */
 		if (ref->expect_old_sha1) {
 			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
 			else if (ref->check_reachable && ref->unreachable)
-				reject_reason =
+				needs_force_reject_reason =
 					REF_STATUS_REJECT_REMOTE_UPDATED;
 			else if (ref->check_reachable && ref->unverifiable)
-				reject_reason =
+				needs_force_reject_reason =
 					REF_STATUS_REJECT_UNVERIFIABLE;
 			else
 				/*
@@ -1764,6 +1766,14 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
 
+		/*
+		 * If fast-forward rules rejected the push and we were
+		 * asked to verify the reflog but were unable to, then
+		 * reflog verification is the right reject_reason.
+		 */
+		if (needs_force_reject_reason && reject_reason)
+			reject_reason = needs_force_reject_reason;
+
 		/*
 		 * "--force" will defeat any rejection implemented
 		 * by the rules above.
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 957b19f826..e99e93e411 100755
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

