Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357576;
	b=Q5O7kzBGxt9DCsCuEUsYGJu29jDfQAwE+cVaMAxrpGW1KGmBuzB5ikpFHUyjX/VidbU+
	 ZWPqLQFFiJ9VF38dt+SwwvXrSMEwgTZ9zj7QYz0jpF302wpN3YOOH6ci4afaiCLP+NNBc
	 JF8afkc0qNCdGK94PeQjldAW5bej66dTreSmaFPVvIM4AYC77UPAvlEFnOYfeup4Q3z3w
	 lgRoJdLj7J9MXrAac9hAIcU8tMc3peF+euuHEJAMGI52ohArpyIPM1+o51xnANKCGmnGg
	 JF/Jc+EGiqL61zUKmMoeg6zajnrYhaY0JLAEk46r/eK7kobV8O5mq91Inj2rUAYc47g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=eFasx2F2M8RCxA7v4JWIW0/D8AW3uMa5Y/Vs8OvI1A8=;
	b=EJXpDuruN1JpzHMHPUhunSt8ZMZ1D1yDiVtLIy+qDhQqYxifJlNn4J8rr67CmFRanJb+
	 Rj9Qv6+mIomvHgBQ3DvvVin6VaKz6m43rh/nYHS+4bm+9Dmm1kAtyCx4JMZn+a4qNZiZ5
	 Kew23SP162vNhHQQ2ep6ifcrcI5zNk8gg+xMZk0Il5QmtJ+84dffrKWKjAr1t6jYw71Ma
	 H2nTo5e5GcI98oZ1YS1iiUj0AmSVLWF4SdgafnvtqZu07O1Kmh1ayLvtIwVjYNnjTMlmQ
	 WYLdW4sdZMVjhXjflpHiu1BeCJxwc4wavMiUwStuYsjD42rHhCKIYUvtXqTHks+wjoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4U7ZnTF;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2DB606C4F2
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D2DB606C4F2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4U7ZnTF
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6d290b10a35so204070eaf.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357575; x=1793962375; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eFasx2F2M8RCxA7v4JWIW0/D8AW3uMa5Y/Vs8OvI1A8=;
        b=l4U7ZnTFCokoMf4dM4OTrejCvUNp4boaJfO5wqnaPebvFigA6oABQxt3dOyVNaq4Vz
         UuEJu4/LVpYUm+ja+ZebWJoxAuDQkVVDSodZnlT5AReNTYtmfie1llDfU0TJXNCjxScp
         OsFXEt6Ka340foj81lk9ArFixNsUncJD+zFsqiQV7svMD1n2RjHCpcHq+f+t1w7omQpM
         KAYYeQZdespXyMHc9U0/c7kuYtUlhCMAG8IeBTNRYYPb5BCgjJtIJeeP5vwwEQuZY2id
         D3VcB6vuu0guxIcTefSI9ZTAP+cEua99/NNAIPJ6vk1PI5kIkD1uYjtqpiD/zZPPMYeM
         MetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357575; x=1793962375;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFasx2F2M8RCxA7v4JWIW0/D8AW3uMa5Y/Vs8OvI1A8=;
        b=zrtQ09/F1AJsgBW+iXB1RAOY7950FNrGhZjUfj3EenVqSucpaR12LpAVYy+qtVEqSY
         BMd3E/fQtYjsjCDLNufsxqU3kYGKwFjqrjagpiJg7FP+hkQg+O0LFniEWPAkNDCX2d9v
         /QwBEX9PuVMQqidHe0NObt5ls0G/IPCMJ86Nas9bFvjkPqqUnbccXq37242Bg+IbGS9L
         euggUt11Yt7F87lp1LQz4GvS9GWuw9xKKHy9xO2yaEEeE5B0tKh13lmy+IERHtCy8+cr
         eRZs7v1vco8rmCEJ/wuTsZVl+2fofEEQj5nZAN0P76f1oV5P5PPnA0iCau1fqUnTIM7g
         aKtQ==
X-Gm-Message-State: AFq9FYKWRSo6cOkB25oFK6ib1bY10Prngg7/j4hw/MkoKYVVcNMxRooQ
	JGxw3jPHgNySMKIqGLaTSNobhJ7vmh5NOwDglpjO87afCDfB684ykZAzi7FI+zT3cKM=
X-Gm-Gg: AYBFou1sip5AWyKX0l0yagI9vx5JDtDsE8+pQZDTTOldsDeC3EAlZ7Rdc5GcOzO/kUu
	SU3s7/9IGKOE4Mp/Rd0y/utMuhfh74dxxXIM/7IvclQ0RFKjeOyJpL5CmdM16Bu+kbXlaXjcWWJ
	Pmzr323uNbvwT3nIBaoaC6aWi28+IRbtIX8T+B7Xgr9k5gPAgKmmlZFw5Mcv7XfRMOys0rVFpvM
	P5CjLS59egt226XqdI9caaRYt1MrZd9UX8AR5FSsu0OHGe8i9j0XIbqiwGKCcOGJsyFpGDyhrpp
	JA5pH0fVfR+nDjGoJqylmmZCqPQcDPlQZ/ijKLW8qi67UMM2+aL/XH505+RzB5qt0inRpc3dd28
	4zIk6CKsP9l6fI8S/4hfTj11yhntfrdXPZsEuvIuEuECUFxnJQ6VUfW84vtRRLmFhHkQzlkzr3p
	FrYuL+AcM0fkj5FKL3wYk28yCraVEB0FL63Dolm+T7jzujiCgVSzoDqxBvvjjcgkHfQDgTZBgqh
	wL17isqHGhN7xuzZy3avHfPpFoasubTfcCGU4+MsrI3USJzliXAZlxJus5UCDHxdWCPHZ1xykMu
	NZsKxlmwJVrOyNwV9MWEDAJqPGi4GnlKMJqgDnZeaUBxVfoyjMY=
X-Received: by 2002:a05:6820:1501:b0:70b:638d:4bae with SMTP id 006d021491bc7-714f29cb295mr1207876eaf.46.1793357575258;
        Fri, 30 Oct 2026 03:52:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.38.98])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90af650a1sm1454447fac.15.2026.10.30.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:52:53 -0700 (PDT)
Message-Id: <25eec8d9676d4adf82570616ca88a2b38d20afa4.1793357550.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:30 +0000
Subject: [PATCH v13 6/6] remote: resolve @{push} through
 remote.<name>.fetchRefmap
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A branch pushed to a remote set up with "git remote add
--limited-fetch" has no remote.<name>.fetch entry to map it
through, so @{push} cannot tell where it landed and fails with
"has no local tracking branch".

Give tracking_for_push_dest() the same fallback to
remote.<name>.fetchRefmap that get_ref_map() uses on the fetch
side, so a --limited-fetch remote supports @{push} resolution
the same way any other remote does.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                  |  2 ++
 t/t1514-rev-parse-push.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/remote.c b/remote.c
index 15cd96aa8e..ecd104766c 100644
--- a/remote.c
+++ b/remote.c
@@ -2018,6 +2018,8 @@ static char *tracking_for_push_dest(struct repository *repo,
 
 	remote = repo_remote_for_push_tracking(repo, remote);
 	ret = apply_refspecs(&remote->fetch, refname);
+	if (!ret)
+		ret = apply_refspecs(&remote->refmap, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 5a4f16867a..bcf00107f5 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -80,4 +80,23 @@ test_expect_success 'resolving @{push} fails with a detached HEAD' '
 	test_must_fail git rev-parse @{push}
 '
 
+test_expect_success '@{push} resolves after pushing to a --limited-fetch remote' '
+	test_when_finished "rm -fr upstream fork downstream" &&
+	git init -b main upstream &&
+	test_commit -C upstream base &&
+	git init --bare fork &&
+	git clone --sparse upstream downstream &&
+	(
+		cd downstream &&
+		git remote add --limited-fetch fork ../fork &&
+		git config push.default current &&
+		git config remote.pushDefault fork &&
+		git checkout -b topic main &&
+		test_commit on-topic &&
+		git push &&
+		resolve topic@{push} refs/remotes/fork/topic &&
+		test_cmp_rev topic topic@{push}
+	)
+'
+
 test_done
-- 
gitgitgadget
