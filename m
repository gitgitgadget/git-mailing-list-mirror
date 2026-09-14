Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8236D4FC
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358445; cv=none; b=VWB9IbUDyMtoia95pNhV1Gyjgf0Uf083EoZPcfiv9ltbp09YxyzQoYutuaFlvaLgAXaB2ui7ki4NwANmtEQPYK3p6SRuRgZboltXqRHvwk1j95TW9s5KUnWpcIksEWJPtt77pHaliM/XycVXSftONw4jf4WWNt0xWY0KGKouHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358445; c=relaxed/simple;
	bh=+79MjAl3dh8tsg2lttA8lSQNTeriukWfCgMTEKtg4Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEFvBzs6yAY8n+4SRqtSWzTlTS7qTLKc0lVKC61XMqxtHv7+Ki7pfYxxnmzBqrToU4/yAgIlGJ+3N0lUGhRBYOa+VfVGf0jFuVOEVSWSOfqaLvKll8Dal3kVeCLBbE/Ap66qlotpbxxo8cseumxns4cCwSF58CoonexJB33WY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=KBqUDyru; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="KBqUDyru"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6c9b72so235318eaf.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 21:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789358443; x=1789963243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJFu3k09NZTTPnWUN9D/naMHYE+Zx+p8+Kvp+Yeb0TU=;
        b=KBqUDyruUDifM9i3K06RdW9qhyWQRO93zBVbf4l71Qj4eUEf9mi3H9Y806bs/OV3wo
         kEJzuCeX6nuQjsjlpFEhNOQTANZEBAjtMNWf3HLE7S/Bg5Gtmd9S856o2L5L1vHzNEsn
         qcwPU2FNRJDhNuklC7gb1i4pSto8R+knVKW1YlY90JHolI3+f7NqSRW2lLFgJEh3O3z/
         ZFsFAcIByMSMXvRDgLaM2Z1TeIPV+vR99T5q88gFrguPHICq/teRs/6oYv72gJV+bWi8
         5mkWiGadYIqPJyjmoGkovSKngdCvlYWj3opwER1EUIxiCJLYsoeudnKAkrCdAmzwpw+3
         bcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789358443; x=1789963243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJFu3k09NZTTPnWUN9D/naMHYE+Zx+p8+Kvp+Yeb0TU=;
        b=HXjm/HYbACUBdnWD9dzBeHiFfyLYmeQ/Mc6229kIi1fzfXkP84+AxlwbGe7v9PgFz3
         TdaazwlOXUEUxxuTbqWrNaCnxkNMw6kiVIOy3DMRKzhB9rGw1cOPpHfxfcrrkqkC3N+5
         VUuwM6cr0VdSR23openP8hX9dg0uG7oWJpPgDE4G3brRTWzpd+l7f9K9NlNnbhdXFeJb
         0Zi6h0EQCb6wSfte0iGgp7wsw+kpH4mQ4Ip8nxoRAyWqIS8PoRVYYOCUULcN8xlcj9fF
         aCO1dNrdCbu68O2GHmv1oXxkD7WPWuxvpFa1I+K4JePwslbrKVbJ2IH+9ci+7sJ1BBD7
         NkrA==
X-Gm-Message-State: AFuF++kuNMS9uaqCdLjLGgFWJlDh4uZKYx2Od/RP/SfAOVctTwjYQmJs
	tclMtQkpoj7wl9C85SQkVc2pSOanKFHHVBju0QmOTROD3mO5/Qbw6jWVnbQjiOXHKasgnNXHKFo
	SJeZiCu4=
X-Gm-Gg: AYBFou0G+ElAIFdFp5npoDmrBXyORie1tUdpJuzWOh+3OHEPhub0pfrtQRWFdg7I2BT
	CeyN2BDGWMthDwxq/gLwLuol0c8m0hdpuUEnQiY2SwMkjCjjOFPuITQxFAqjYEjS0EZEjffZkcX
	OZ34lYoOzXhOKcAChu+8w0iNKYYqVH89Mi6bDB550vVcHZj+T8RwbDQM4m+PPEQk/mBT3f0z9KU
	75e0NCS6uUXm3jeNLw9L2ICNnOdcLYcQKjuNXT6lHPQfFythzMog4l+yUTNgmjLSed0rAi1gZ8b
	DzqeSQ5qGTMWdZAPmfQlNvKzUZm/7fLDotOnQSvmhbQ+dr3sWrm9N9/kOUsLgMeS+Nbwl4Dp56O
	ZW8vJThxmitXzt0sMqBa/Gt4Ynap/vsb/iIZ6I3dYTpOTkoGcOQFeO8Jg9LotPVCwfrs7CzRhlY
	DOYXiIme5Oxw9kbZM3MaMwxxU5BnZGhGo8rlplYRqfx74Ra1JFyPqC1ghyUNJePpEjA+tQ7GA=
X-Received: by 2002:a05:6820:2208:b0:6b4:117e:545 with SMTP id 006d021491bc7-6c5398bf14amr249061eaf.13.1789358442918;
        Sun, 13 Sep 2026 21:00:42 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6c0996dc5a6sm10106381eaf.6.2026.09.13.21.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 21:00:42 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v4 1/2] push: check pushed ref for --force-if-includes
Date: Sun, 13 Sep 2026 22:00:17 -0600
Message-ID: <20260914040018.76111-2-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914040018.76111-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260914040018.76111-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"--force-if-includes" ensures, "tip of the remote-tracking ref is
reachable from one of the 'reflog' entries of the local branch."

But check_if_includes_upstream() uses the local per-branch reflog based
on the destination branch rather than the branch being pushed; using
ref->name vs. ref->peer_ref->name.

For example, this command looks at the reflog for main vs. src, even
though src is being pushed:

    git push --force-if-includes --force-with-lease origin src:main

This can cause confusing rejections or unintended data loss.

False rejections: when src is up-to-date with the tip of origin's main,
but main is out-of-date or nonexistent, then the force-if-includes check
will fail, telling users the remote ref has been updated since the last
checkout.

Data loss: when src is an orphan/out-dated branch, but main is
up-to-date, then the force-if-includes check will allow the push,
clobbering the remote main.

Instead, use ref->peer_ref to locate a branch with a reflog. But if ref
does not resolve to a branch (e.g., a detached HEAD, a tag, an oid),
then we reject the push. The alternative would be to use HEAD's reflog,
which is too broad to tell us if the history being pushed includes the
tip of the remote. We need a per-branch reflog, which means that pushes
of a ref that do not resolve to a branch are rejected. Rejecting the
push of a ref like a detached HEAD already happens today (if the
same-named local branch lacks the remote tip); now the detached HEAD and
other non-branch pushes are explicitly rejected.

Allow deletions, e.g.:

    git push --force-if-includes --force-with-lease origin :main

A deletion has no source ref, so no branch reflog can be checked.
Existing tests already enforce that deletions should work with
force-if-includes.

ref->deletion is set after apply_push_cas (which triggers
check_if_includes_upstream). The ref->peer_ref name is "(delete)".
Instead check with is_null_oid to detect and allow deletion.

The early return when peer_ref is missing in check_if_includes_upstream
is necessary because apply_push_cas walks every advertised ref whenever
use_tracking_for_rest is set (i.e., a bare --force-with-lease), so
check_if_includes upstream is called for for refs that are not part of
the push.

Remove unnecessary check for empty return from get_local_ref, since it
never returns NULL for a non-empty name.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 remote.c            | 26 +++++++++++++--
 t/t5533-push-cas.sh | 81 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 00723b385e..887c7ec00c 100644
--- a/remote.c
+++ b/remote.c
@@ -2806,10 +2806,32 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
  */
 static void check_if_includes_upstream(struct ref *remote)
 {
-	struct ref *local = get_local_ref(remote->name);
-	if (!local)
+	struct ref *local;
+	const char *name;
+
+	/* ref without peer_ref will not be pushed */
+	if (!remote->peer_ref)
 		return;
 
+	/* A deletion has no local history to check against. */
+	if (is_null_oid(&remote->peer_ref->new_oid))
+		return;
+
+	name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+				       remote->peer_ref->name,
+				       RESOLVE_REF_READING, NULL, NULL);
+
+	/*
+	 * if we resolve the ref to anything other than a branch,
+	 * then there is no reliable reflog to check
+	 */
+	if (!name || !starts_with(name, "refs/heads/")) {
+		remote->unreachable = 1;
+		return;
+	}
+
+	local = get_local_ref(name);
+
 	if (is_reachable_in_reflog(local->name, remote) <= 0)
 		remote->unreachable = 1;
 	free_one_ref(local);
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872d..265be6a84c 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -396,4 +396,85 @@ test_expect_success '"--force-if-includes" should allow deletes' '
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow forced update when using differently named branches' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch -c newbranch origin/main &&
+		git rebase HEAD --onto HEAD^ &&
+		git push --force-if-includes --force-with-lease origin newbranch:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should allow forced update from HEAD' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch -c newbranch origin/main &&
+		git rebase HEAD --onto HEAD^ &&
+		git push --force-if-includes --force-with-lease origin HEAD:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should reject forced update from differently named branches when local lacks remote ref' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch --orphan orphan &&
+		test_commit I &&
+		test_must_fail git push --force-with-lease --force-if-includes origin orphan:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should reject forced update from HEAD when it lacks remote ref' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch --orphan orphan &&
+		test_commit I &&
+		test_must_fail git push --force-with-lease --force-if-includes origin HEAD:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should reject forced update from detached HEAD' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch -c newbranch origin/main &&
+		git checkout HEAD^ &&
+		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should reject forced update from tag' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch -c newbranch origin/main &&
+		git checkout HEAD^ &&
+		git tag stable &&
+		test_must_fail git push --force-if-includes --force-with-lease origin stable:main
+	)
+'
+
 test_done
-- 
2.47.3

