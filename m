Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD943DC4D7
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903098; cv=none; b=u6TGWkfZst+ejB8pO3lGW66V9M9B/a6sJDKx5g+PQKs7Gs3ZD/wvb7naB4wgzeEMsSglTfAp1J4vdAxewGITsimzcvo9K6uYz0kVSMTncw3gNFTEXmeOYdQkL2ZgzaBFY6AU7DFr3PGMt2MPfu25XCJN7RHVFgfXxrT7hnlOryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903098; c=relaxed/simple;
	bh=MIM7Kf4HMK+IXkYCICmBaz/tzi8+Ql1ym6hXTd2gilI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XzTKuJz1V02OoBlKD9CHPEPLD7zc9OzqsxajmYSaxn8BgCs+SPC9MdVnPC9nBl9pyrcYHY2bPeg+4FxDx4hPrOhTzdrnTwQt+W+X3SlRqcNCuuqJg5rpm4Ck/waEuTAp/XbtUDsZwkwEakyRngv/aHL+JRbl1ha6OlORlJwLw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpxJ3ApE; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpxJ3ApE"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b28df1f600so664887b6e.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903095; x=1788507895; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pzhbpngrlm/rdB9/ok2Igwlirh8FxNnOTS0AS3IrIrc=;
        b=mpxJ3ApEMIvnOw1CoUpdIlbm5qNPyZEMH3K3YiZIIKnhfOMfMHZCCW11UcSMK0tjFy
         pscjhaXLYjSIMky/q8S/iYD9NXJWEhxqcmKlO+l6IFvlSE4jv0LHbK0gMHPJyV4qi+LO
         w9Uq4bE9hXGxUg/KmJgBJxCMvazOZ9DNgJ+ts1BxGs6e7RXsluCUya1MtBSj/H/EBrd3
         yh6Zi9w++0Eal6D1m2rz9RQT+3ODPKHyVL9Y1HTmU64AZx6B4HawpWBLboZ1uF8NwEB9
         7WvK2mWz/Ih1eC+KMxn3Iu5juao7dujYU7wh7+rZqB5m5VpnlBbfRPT6F2olG+s3z7/f
         8IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903095; x=1788507895;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzhbpngrlm/rdB9/ok2Igwlirh8FxNnOTS0AS3IrIrc=;
        b=cDENUEh2U8DKkzwM/t/DXzJTsuZ7LJz88EZhsgbTaLlLkxZD6ImmrQN3KRa/+aWnj0
         0iLAwcOA4KTNCT4Rr1MlUyUw/gUkTuCK80j2LKJT/3ObnUADgcNErgN9hJcHe6bu6CKo
         PIq8T8rXH9DvsKF3uCQHKb+qypLLP7hvpi+THIEENAL3Y3mgXwoJ5gu+EyTOw83TpYmF
         4/kcXJyAR3pOigzpp7v5RWTTT3M4yxGFGKWFQzpa8SrgYZBrRXkM/RpNkQBMozEhnh9U
         sfOM0C38xg6i44MZLTC3paPlJYzN2xNKah6XygW+y1qZF1FGJTInladg+PLpeHIv8gI+
         nyyw==
X-Gm-Message-State: AFuF++mXbC6STJIQD3K9tUhd01qvRIfvzB0clFqRI0SHSghnyEJnYRCy
	I7/vVHgr6Plpdfu/aSGocwX5gIIoe0eP+hHzU6IerNTmouUQBzCRUH4at2ZvLQCl
X-Gm-Gg: AR+sD13VZ+DNHQuET+4Uv8nHxCTTXd7/GzRHjtOoAq8mgw+o7O2UwBGJqnwhu0Tk4nJ
	FjhChEac4UjDDDsYGIxuhZDTaiR2slROe5Q6WKqbIN4Xvpy4pSOouWVnAuSBQcL4hnu5k5UEA+y
	AWV1jpDJPLm7E6LEu0W9R+ITeH5EgLOlaxeJ/XnhK6V1Vc7LFPmPag75zGfv07HvcOGC/m9hUB4
	qbOj/0DkWwlY2Z3y52mv3uPs5OZaJLMjPvnQK6L/wOmmBbJsDDZ40EUdtdyiUNTTDUm2wEPtVvt
	Tqhd6U3VRVn4gsqUEVkwd2+pBLjpoZ9mwK1P5S5tseCBiN1afXJyKLLQft28HuzdMFx6SypBODU
	QCyUwDdNNKEWx0uZWsRskEr+RGRfqj65wrUWhqFiz79RnkCxRmyAn29PYO1bvr8kKD/Okj+rTcJ
	D45dtScQvqtEbxNmmyYbHgLb+eRPPcJPMUtihRtUBtPpwEtuT++0YiIjZvSa1nkrE=
X-Received: by 2002:a05:6808:c165:b0:4ab:3210:b31a with SMTP id 5614622812f47-4b398253454mr5341640b6e.14.1787903095458;
        Fri, 28 Aug 2026 00:44:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.78.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a2ef0452sm876095fac.4.2026.08.28.00.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:44:54 -0700 (PDT)
Message-Id: <0850a999dab65345c9efe4b1d5bc6926b2641217.1787903085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 07:44:43 +0000
Subject: [PATCH v3 3/5] commit: reword the empty-commit rebase amend error
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When a rebase applies a commit that becomes empty, it stops and asks the
user to decide whether to keep it or drop it.  HEAD still points at the
previously-applied commit at that point, so amending is refused, with:

    You are in the middle of a rebase -- cannot amend.

That message would suggest that amending is not allowed during an 'edit'
or 'break' stop, which is misleading, plus it lacks the specificity that
might help the user know why their particular case is a problem: the
commit they intended to amend became empty and was dropped, so amending
would affect the wrong commit.  Reword the error accordingly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c              | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 610820c99f..774fb8299d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1332,7 +1332,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		else if (is_from_cherry_pick(whence))
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
 		else if (is_from_rebase_empty(whence))
-			die(_("You are in the middle of a rebase -- cannot amend."));
+			die(_("The now-empty commit has been dropped -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3588e16543..81f4844950 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1880,7 +1880,7 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	) &&
 	echo x>file1 &&
 	test_must_fail git commit -a --amend 2>err &&
-	test_grep "middle of a rebase -- cannot amend." err
+	test_grep "now-empty commit has been dropped -- cannot amend." err
 '
 
 test_expect_success 'todo has correct onto hash' '
-- 
gitgitgadget

