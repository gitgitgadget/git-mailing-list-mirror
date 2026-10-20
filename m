Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458908;
	b=0E+mljOrH5VTEwTI6Ou4VQyO7lH72d5kALHVWOiW6gA2ivxEPt29FQ2mElILoDNxcOsJ
	 o9GjLbz8p3vlI5kew13t8Nz4kpQg3oAhbNEBsadq/+zPhCXmRhJ65YbnH6pKXMaKY1HOi
	 RWY3+wPIiZ1Gm4ej64gHHsCYqWcDJiuB46q2eMwhPtmHwMGDKd6cvk0snehHhEuV5BV42
	 Qqyvk0ychYh0EmDp32TwYaAccmIJlbwUelFZrQWjeXr7j/VRvL7e1+s+Hp8zIDQSFBRXM
	 EJWxWJft6Cl1DLeCBR0IKRV1AVd9QJxEeo3qVoX8UvEv3seCVWM+i37qgKwcFCW5SnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=ozyBrXK2ZWzjGttmA5hDsJ+vFAm136TmVFPcrxuOzqo=;
	b=1Q+CvBklznkb2F/VmXHScOQpJoITbRKRoLuwlF923Dqrw9SYB5aO9t1riylgaJ3ADqt+
	 NstQo2uxr6AAS1mM5DfL6/IIPrBeX0t36QJ0HjuUNygJy8Tiy/+bII7k3ym5c46nvEWgu
	 vHp00J8W4hZezkuH2TT7Y1jEOCDIBEcSrF1lBLCne4WqEB0M8pMB36wxq+bUxwd/TQ5gn
	 AJTNiCsFuvgwAcr/52dw/A9aFwyNcpOHSNj3qS8NZqb0Ir6Ab5FlMvieWqNLcwZ615gFr
	 itl4d69B5jzfhKnkGPR72p3BEXZCxELBBJiWsd8LIzQIlNo2PLzV34qt9lV+GcWFNMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bHvFJxaI;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83254606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 01:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83254606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bHvFJxaI
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-49e08af5fd4so1132717fac.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792458907; x=1793063707; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ozyBrXK2ZWzjGttmA5hDsJ+vFAm136TmVFPcrxuOzqo=;
        b=bHvFJxaIbpSLmh/15Zr5kePYnQAjUHNhN2mRxlJiQteGWJtIZbR6K6Kr36KtgJqEvE
         9Y9AsZTmsnd4zh2Ct67L1WHbGkat3h3klt4GR9CTMCuAaJuX77Z5PkRQUnaZK5DTOJ7k
         IrWVjXvwnP7whdZOEBFOQ5g5tltDS6fcT4JbkhQ1fHv/Waie/wOhESo2TK1KukN5bHlI
         RWlUsmxBU0vXWorOZYcXKLTE5YyvSCfnpdCLXJ5nR7i77Az4cGDrF0D4ab7gFkIlfICG
         88YKSWu6sxdZa4cxFYJAVgYTRe/9LFzvspaf0Dio0XrJa9MQmoOBdpIyhr+gLIhqjbOx
         BIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792458907; x=1793063707;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ozyBrXK2ZWzjGttmA5hDsJ+vFAm136TmVFPcrxuOzqo=;
        b=W0U1zjRh3Hy8QwWZsrocYPoc4ToBfmjctIiEO3j1Rf/LmQ3H7+NibNmrsuxgRFJiCz
         dWEzJwUJOx63y+nMLCAF37zusfjZrWltWoYHRQJMPQX1GWewqfR1NGYQSKJZHfJk9gx4
         OOM+H8QxDyVsUkPWxjBIIghdAwxoLg11LWOfYNsbt9brV/CyOW60T6fHri68di/NTpO2
         DcTD3mY3YY8U6lTeqGZOxqD0LDtM+0hsQEDstnKiGpbDRIERKADrIfsW2/UBxLr2kd3q
         23QGxFUK7TomAoXQG9K+HPlmqd7sZS+XyxIJ4NKTs5uEh/eeubFC25vZ0bwdvXt0fc9t
         xglA==
X-Gm-Message-State: AFq9FYJr5j0L0JAMhB3Bp0tSdMY4NkdIqT/SBaBwm0DDJ53Ujoam5eXM
	S/gDvCJUZZjqEc8CBtsLBpgHovDtBNyxvgOl32A6P8s1EKL4TECsrqq5bl+pk9xF
X-Gm-Gg: AYBFou2MaAOQfFGUUMXfKZNA57MksWBHMAqptXpgM588MBR8QQ/1KtRCE7dDhvU6EzT
	Gl+leb7X+WU4vo8l4ssrvVV9YBb4y3rNUNFrTa4jD5x8s7jY3LwlW/sewVkdhu8H2RUAJmszIDL
	9q5AZ0LesLBl74R18u2Xnk3gByC5BGT8AXbgOeo7j4etHO9qDomIlQ0GcbFeew1S4TT+v1IXOGp
	nXZemBctLXp/CljVdYj2JZu9vXUyEc52poUDL1GFnle2INwP06IriMlxGT++f02JN2lLYqD9Zco
	grFcwQJoEaVCMI7ZL3K8LOAzKD9Kj4gQF4bs2V2fsK+Un+br22oW3VyPriGycZjwS+j8AFh1nbG
	czsua5PzD8SCZa9U0Rfk8yZQ0ZokJpH6ONAWbkJq/hZ1d1MhlmsdSLfJqQ6VEWMLiK0/Xd7eEQY
	7eWN0CCgIx4xYUBtJ2mr3y5PLT3Ci3ix1O0rMRJm8zqaMKrRVa5Ky6EhpqADTsswF77Gm2KLbd8
	wHw
X-Received: by 2002:a05:6870:96a9:b0:4a7:4324:1807 with SMTP id 586e51a60fabf-4a757897322mr8095798fac.12.1792458907073;
        Mon, 19 Oct 2026 18:15:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.206.123])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b5b4278sm9040382fac.6.2026.10.19.18.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:15:06 -0700 (PDT)
Message-Id: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
From: "tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 01:15:04 +0000
Subject: [PATCH] branch: strip refs/heads/ from the --set-upstream-to hint
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
Cc: tsukasa-ino <inoue.tsukasa.4@gmail.com>,
    tsukasa inoue <inoue.tsukasa.4@gmail.com>

From: tsukasa inoue <inoue.tsukasa.4@gmail.com>

When git switch fails to write the tracking config, it prints a hint
with the command to set the upstream by hand. For example, if
.git/config.lock exists:

    error: could not lock config file .git/config: File exists
    error: unable to write upstream branch configuration
    hint:
    hint: After fixing the error cause you may try to fix up
    hint: the remote tracking information by invoking:
    hint:   git branch --set-upstream-to=origin/refs/heads/feat

The hint says origin/refs/heads/feat, but the correct name is
origin/feat. Running the command as printed fails, because the full
ref name is not a valid remote-tracking branch name here.

This has been wrong since a3f40ec4b0 (branch: accept multiple upstream
branches for tracking, 2021-12-20).

Strip refs/heads/ from the hint, as the success message in the same
function already does. The git config --add line for multiple upstreams
still needs the full ref name, so it is not changed.

Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
---
    branch: strip refs/heads/ from the --set-upstream-to hint

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2268%2FtsukasaI%2Ffix%2Fbranch-upstream-hint-shortname-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2268/tsukasaI/fix/branch-upstream-hint-shortname-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2268

 branch.c          |  8 +++++---
 t/t3200-branch.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 22f4f46b96..bb07846911 100644
--- a/branch.c
+++ b/branch.c
@@ -186,12 +186,14 @@ out_err:
 
 	advise(_("\nAfter fixing the error cause you may try to fix up\n"
 		"the remote tracking information by invoking:"));
-	if (remotes->nr == 1)
+	if (remotes->nr == 1) {
+		shortname = remotes->items[0].string;
+		skip_prefix(shortname, "refs/heads/", &shortname);
 		advise("  git branch --set-upstream-to=%s%s%s",
 			origin ? origin : "",
 			origin ? "/" : "",
-			remotes->items[0].string);
-	else {
+			shortname);
+	} else {
 		advise("  git config --add branch.\"%s\".remote %s",
 			local, origin ? origin : ".");
 		for_each_string_list_item(item, remotes)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..ce478d85cb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1080,6 +1080,21 @@ test_expect_success '--set-upstream-to fails on locked config' '
 	test_grep "could not lock config file .git/config" err
 '
 
+test_expect_success '--set-upstream-to hint uses short remote-tracking branch name on locked config' '
+	test_when_finished "git branch -D hint-local" &&
+	test_when_finished "git update-ref -d refs/remotes/hintremote/hintbranch" &&
+	test_config remote.hintremote.url . &&
+	test_config remote.hintremote.fetch "+refs/heads/*:refs/remotes/hintremote/*" &&
+	git update-ref refs/remotes/hintremote/hintbranch HEAD &&
+	git branch hint-local &&
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	test_must_fail git -c core.configLockTimeout=0 \
+		branch --set-upstream-to=hintremote/hintbranch hint-local 2>err &&
+	test_grep "git branch --set-upstream-to=hintremote/hintbranch\$" err &&
+	test_grep ! "refs/heads/" err
+'
+
 test_expect_success 'use --set-upstream-to modify HEAD' '
 	test_config branch.main.remote foo &&
 	test_config branch.main.merge foo &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
