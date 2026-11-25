Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577031;
	b=ScI3/GWpRcoUoTf+rRLsi6L/hkaMEZjORvDbQWiM1citlaZajbrwFXU6kUTLOLvNv7Oj
	 k76ULGssBt6F3gBytqjbKeWiCwFi1177aS2vlxskh6O4MGtNBecUMUDXAzIWkwbcNXaa6
	 hxBz6m2e2jpB2k+AfM2SOJHv45abJQEGNKDx8URFjId+kw/CDBrw2QsyCkjv7uOFxCjJC
	 xiYK3e1bqXqWtC/8r5r12W2SAVzKMH7hzA9v9hOuvI6+HEJNW40jrq0mCVMhQfnXHTerX
	 C0GJqLA0yaLulFA7SBXpXvjzjnLuZvNLDASSss7uzWIoMuXnyoZDTl/7J7N4L1dLyMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=8/Ael1UEeuFW957erIv9oJHJMBeHqrihz5R6kIoKTgw=;
	b=inJ0llpAKqw8ciMehsizLlUEUugEFJ8sHDGpGr3SrrbNy+sHf+4qlTcFrAFr9BudmO8a
	 plUQFf/Dk+qV6tv938cvkH0kv+kzLRY6rVOfOa/kJET5dk3vm/zLSn3yRc9jAR68vOXAW
	 TigFIeg6dMclV+qS1BjdSM1En583MOlpels9qY+jFwQtf+VmEKB/khX8/wFpgVGtBwwze
	 c+l7cNZZX556GKDnBwWMiSJnWwfFoIgBZ92LuMUXnMbjB7UZMexad+4LsWYD6JWj5jv36
	 /b05Sm5qF/ukJoVuVUIyhasYn55vEc25l0+UrOc+zqt9NMzw7TtSxWG04/M7I9WUiVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZohv1Xg;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB73606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 03:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB73606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZohv1Xg
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-843cf077f10so7245623a34.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577030; x=1796181830; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8/Ael1UEeuFW957erIv9oJHJMBeHqrihz5R6kIoKTgw=;
        b=cZohv1XgP4i4Cbu+KAcYUgH9IC65eU3tRIAiuhjqV66CxkwmTRiKg/Cq1xBog379NU
         PDJYXm0qPO8ENLIBFUCJbe3LjGqvIVXAEsQkYu8j9pySwasl2cK3y4jpPQojrUluEzwE
         O24uZDjLaTmYqGfd56tb1U6nIHqyDm3NB3Zwx0TqZdUVRFWFB6YPAbQCYtNIrMNXsxkd
         jv1pVJeXuEdvJP/QeWVFsiJNdRDDryOjHz3S9UxlG64as+e1HWJdSvs1r3x2W8Wnzt2U
         cXTVdJKqPmDzlkO2D2CP549M4lJGL8rBSp7rNiZMuPbpk1QHpO+QGr2QPrp3HsctYtm0
         50dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577030; x=1796181830;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/Ael1UEeuFW957erIv9oJHJMBeHqrihz5R6kIoKTgw=;
        b=emAbXywSIDcsVe9PUxv2j1KHaJqtgDJ6ZKfJieayUb+qQtte7IPzP6A+/2e6bbK9JC
         uArZhMiWHcUJqgr4JSlfBkvNpaYRMIBDYxm4NW51jPqajcPn9vgRVWFl5sjf4QQ3ejHD
         20Z9cDaiPirMDNxs3krwhO1GWfDxNeJ9S4hqLxu6Mfx18GMZWSlbyShBFmcbYcur7AiD
         MrFfb5wNeULKyvaCwMNC62byb5gS3tBGzeEclD8jizIDHJIgVQjlUjqixCs/i/ETSHoX
         ynUWVJu1SB8xnCxgfVMOmpbWY0za5n4VKnbbEccijza4qUp/ni1OkAjCD8izPcdoJKYZ
         qM9g==
X-Gm-Message-State: APuU4Z+Nn/EvB8uwq3obmJZnfeb38bGtra2hZl792acl7eoi6Vi/7WoK
	8kT9TjFu28LjcEW0mNNqeop4mFEOkHKlQTeioz5FsmO7JyAwCPvP6Ac1WU21HWHf
X-Gm-Gg: AZFdTZe8tdEPm9YVlrfc/qIAhZ37Z/rrEww/x5m+/LK84DP4yZEEzRgMurXBhg/hCV0
	PzJMDJ6Nk4XST0zRUF9Pk0QdklEYLm3HgTmoRTvfF0wWO5WRDqgHQCti6f70VNl4SI6r86IUcfE
	WPPCmenWpzMbjd9Zb+Fp3/3KXlJREJhCmQxG70EcI0mi2vOrEE/6VCU9P4IkFVCJ43EoWnqcC63
	ZyHnRWNO0S8ysjf/pQWKOBDUP+C0qACrVlYga4r5iPZ/qG3Q5B40rAzwlQIPBxp/6OK7Ir+uSf0
	jnvnBAmHX9zJvepFNfXwzATPDUeebf5je7tf0wbFh0C4dnKmtZttV3f0xvh8p/SKTYkQqaa02Wm
	DEFm/OLFcX1iwbb+zja9ezafrH9VDL0dwRvpN46CarryqhWUuSGyLbsE3RR1nIB074ce+X9ZRyr
	omySo9YpP6F8ltwUJrcDEvijAXPX5QiC5ddZlgsaYqcA7z1d4LlHblM3wImsI972r4l1Tq7B8aT
	cyIAobMbxztWHhpqrTmB8Qxk911oASMVbilpbr8/t8lwcOqUKzjPtwPk07W9tnIp/09sUiG8yox
	R2o3X1T9EnwDHMubE16LZ2pwdmQbzTUxFQ==
X-Received: by 2002:a05:6830:917:b0:83c:1efb:6424 with SMTP id 46e09a7af769-863152f905fmr22841859a34.1.1795577030299;
        Tue, 24 Nov 2026 19:23:50 -0800 (PST)
Received: from [127.0.0.1] ([172.169.255.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d9asm12867383a34.17.2026.11.24.19.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:23:49 -0800 (PST)
Message-Id: <7c0fe312f161247a5e7192e214e8677547521a92.1795577024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
	<pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
From: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 03:23:43 +0000
Subject: [PATCH v2 1/2] sequencer: clear saved HEAD OID when picking onto an
 unborn branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Wonseok Oh <wonseok_oh@korea.ac.kr>,
    Wonseok Oh <marinelay7@gmail.com>

From: Wonseok Oh <marinelay7@gmail.com>

When picking multiple commits, "git cherry-pick" saves the current HEAD
in .git/sequencer/head so "--abort" can return to it. An unborn branch
has no commit to return to, so cherry-pick is expected to save the null
OID instead. Only then can sequencer_rollback() refuse "--abort" with
"cannot abort from a branch yet to be born".

However, sequencer_pick_revisions() does not handle this case. On an
unborn branch, repo_get_oid() fails to resolve HEAD, and the function
saves the uninitialized 'oid' to .git/sequencer/head. As a result,
"--abort" is not guaranteed to refuse the abort as intended (e.g., the
saved 'oid' may point to a random commit, and "--abort" then moves the
branch there).

This bug was introduced in 0f974e2124 (cherry-pick: allow to pick to
unborn branches, 2016-06-06). Before that, picking onto an unborn
branch was refused.

Clear 'oid' with oidclr() when HEAD cannot be resolved, so that the
null OID is saved.

Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
---
 sequencer.c                     |  9 ++++++---
 t/t3510-cherry-pick-sequence.sh | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4a1c0e70b8..20bfe00ba3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5788,9 +5788,12 @@ int sequencer_pick_revisions(struct repository *r,
 		goto out;
 	}
 
-	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
-		res = error(_("can't revert as initial commit"));
-		goto out;
+	if (repo_get_oid(r, "HEAD", &oid)) {
+		if (opts->action == REPLAY_REVERT) {
+			res = error(_("can't revert as initial commit"));
+			goto out;
+		}
+		oidclr(&oid, r->hash_algo);
 	}
 
 	if (save_head(oid_to_hex(&oid))) {
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 9400ddfc45..d52fda1c54 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -269,6 +269,21 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
 	test_cmp expect advice
 '
 
+test_expect_success 'cannot abort a cherry-pick sequence started on an unborn branch' '
+	pristine_detach initial &&
+	git checkout --orphan new_disconnected_seq &&
+	git reset --hard &&
+	test_must_fail git cherry-pick initial picked 2>err &&
+	test_grep "could not apply .* picked" err &&
+	echo $ZERO_OID >expect &&
+	test_cmp expect .git/sequencer/head &&
+	git rev-parse HEAD >expect &&
+	test_must_fail git cherry-pick --abort 2>err &&
+	test_grep "cannot abort from a branch yet to be born" err &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
 	test_when_finished "rm unrelated" &&
 	pristine_detach initial &&
-- 
gitgitgadget

