Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762089;
	b=ns1v/gqA6VGq3O8vlIjFBfV5KH12mg6sCfJSlycbmNBHAEbBoZ01q0M9bhFCx3Et6kE0
	 cDOFBIxnZHXRgI/7LZbwN+/O/UDYtqbkTnNg+5KzD+OkfRmAu9YT7WukGCpdlXeeC5B96
	 Z9X6foXayJWxqtuch2gU1K6xzHnzpsGbMB3oQ+Zjf4MAJixVnPZVi2Y/9l5D4+bpggJJm
	 jaCP48jOgkBjB7h8GWtUYdrcpB0LwIbE0ZLywWAIJ0Ddl+7PuYRhK+/imkgE9GmniLNTV
	 til5Wo76N/TR3fmQVp582aR9FQAnlm5CvHTHebftaexT4OWj70rQUuw7pJ8KaoAFNBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tSLSQN1zLrSnTeGx2ePX863GqtbW23pQpp3lHrJifGw=;
	b=naCOo9HQZAj8YmRRWXHK5ZXQDp/niANMI6KOWa3U0C9/opDeL+vGA5u1nBV23lYedPqz
	 0/jlWYQddt4x6JweVBw3amumYZX66J1+ndRVEdbtQ63oWg6TUHoAl7LtoUO3GgteDufQn
	 Wk5WU0cJ3J8PYGLOGQ0UJvnvF5bRCi6vODSHx9apT5knz9pdJM1i1nsaT0JyoeA1b1JG7
	 wTemHoJe9rUpZHJgMr/Eij3O6RhwWXfVJOAkdT6AV+LIRB4OXrEtqp1JdGJW+0IaC/4w1
	 2Qzgf2PQ2TK+VnMMBi9YExIkJw+qEbG/veBQ1I7m4tkRXf1fqtYTd5h4NzvOgzJSN6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Me/qTaPZ";
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE98606A324
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE98606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Me/qTaPZ
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0a28a720aso8757017b3.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792762088; x=1793366888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSLSQN1zLrSnTeGx2ePX863GqtbW23pQpp3lHrJifGw=;
        b=Me/qTaPZr4s/tvrd2IU7zVfM8ABoO+HPuUwvejbejWSDVgLx32rrf+o0ymK0LP/FQ0
         keeWK9N23SFtW4vQlM28yCmIdr+ksUvyZ02wrcBMRnM8G6BUFG+tTPHqyNyhL3tH5UHO
         ecIIWGZABu5qi2eOSuOhptuVTP2pCmti8jGiTjLTARKOmwi6K3T2Tz5twyTMvn2gxT+d
         A27UA+SQoDhoR5PPuEJS0ygaFwd4eNQWMZigQXOeOlqvrJEk5tUIru9rO1SiL/SA29nq
         C8KamCD/dElcz8P/cM1aAWQCrs8s02VNVc9W0RVhzV3BK5YU6jieM3fxSekkmUR+u5KX
         pl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762088; x=1793366888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tSLSQN1zLrSnTeGx2ePX863GqtbW23pQpp3lHrJifGw=;
        b=pxhLLE40eh1+ybVQZMQFQFNJEymb/9z7D/buxM9d9aa/8yiT66lPzZjTtMqWvKVfuO
         U2LZzvNbpS9SHJDA/tiXj5YlonVKDNtQ3HOCkRUtT2PJvbZFyG0wmvypyzP0ZUGFRSxx
         kkmU9YKSkJ90KIKQmdswFNZVsdPa4ARts51P3bikdi0u6Ze4Gy5pcKKFCtgNAirxjrCU
         dG9jPROssf+C74BGtFFMVytF5gDc0TZnNy2uTAvznhBDWa00gH9Ql1r1aCIwAzLy7r8I
         V1b/rB9Lv5Pciwd+YG5iy5B3FTPQuzS+qeR+EyPtMTr/aFdnmkUqRFOsCKW+qNsL4f7v
         xi4g==
X-Gm-Message-State: AFq9FYJNVh4Iyx1ZWkIXtfvN5f2EzGLkCuzR58NzpkSETgsHsv0Y88rU
	A2aCPPVkbhdgDHdGenjdpcenL3tu3WZA4CbVtUwKmF1arkuq2O5D0Kh4E0weq60J
X-Gm-Gg: AYBFou2ki3Q3BjscYH9j+QItKRmAU50eli+a2xsmp8thvNJU79EkfK7+yfOheI+YSXR
	m+TWtuYVcCNC4Bg633I/2iV29bMXTOrNLhPEZXH0NJ0czPbQEd0mEvY+7xh39DXErfsj6JZWuc4
	LONrcSF7qD6HBXn+04csF3hfd6Www42uNkgTmA5C6+aCC9acgW82XRW043i/bVBeTwXtbt2MzDU
	juzVTjMKg65sToNOegYLJaZ/pyuUIkyQ97GYvDT9DMEURjfXQTK8hDolBTxk84SVCDwUhPp2RTk
	yFccW8cBPCxKvREpYJYicB0oY+RBjNg3zS5JnlcNKHbdglkdCbHvcrm46WdskUOmwgUBW1otch6
	Sqv4bUYh46f/xkYSudSQOkANiyM1Tuc0496JEcYGw+9fAmuy79TEvtpgq6/uZQEH4gKVrkLTzpw
	VO1I6kF+PFSiK5KrLOsYuk8W0F355i9metYrGV6cAVS8GTnBS0CPJ79c1pN+9tXRJ24daWcNgfw
	4mVUL8o8sY308CCmF153OGhLorc50a4nGlXRjNAPAsJf7lTVRf2AwzUwggRxw2sW/zAeSlHkZsB
	tvU2e+Z051VP6VVxHSPOEmzLN59FwU37aF81/3c+RnDNCrX8i6yexyF4x0jzP1GOIt8Ct0oq5C7
	2SFM=
X-Received: by 2002:a05:690c:e3ea:b0:8ae:dfee:cd0d with SMTP id 00721157ae682-8b157d4a81dmr17836327b3.35.1792762088513;
        Fri, 23 Oct 2026 06:28:08 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9d17:3000::3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156183032sm12898647b3.34.2026.10.23.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:28:08 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Quentin Bernet <quentin.bernet@bluewin.ch>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 4/5] doc: drop usage mentions of "git stash save"
Date: Fri, 23 Oct 2026 09:20:54 -0400
Message-ID: <3762f9d5bbe4096ee2704992749381627fdc4474.1792761643.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.237.g5414b88716.dirty
In-Reply-To: <cover.1792761643.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com> <cover.1792761643.git.ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though we previously deprecated it in fd2ebf14db (stash: mark "git
stash save" deprecated in the man page, 2017-10-22), the save subcommand
clings to life. For example, 951ec747d4 (doc txt & -h consistency: make
"stash" consistent, 2022-10-13) brought back "save" to the git-stash(1)
synopsis, and 41a28eb6c1 (stash: implement '--staged' option for 'push'
and 'save', 2021-10-18) gave it new options. But we really discourage
its use in modern Git, so let's drop mention of it from -h usage and the
synopsis.

It's still described in the manual, since some descriptions talk about
the "save" command. As we haven't gone ahead with a full deprecation and
removal, we can leave these pieces for folks whose fingers still type
"save" and need a reference for its behavior.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 Documentation/git-stash.adoc | 2 --
 builtin/stash.c              | 1 -
 2 files changed, 3 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index d6e8c4144c..6bf510702b 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -18,8 +18,6 @@ git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | -
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]
-git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
-           [-u | --include-untracked] [-a | --all] [<message>]
 git stash clear
 git stash create [<message>]
 git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..94869c2429 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -75,7 +75,6 @@ static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_APPLY_USAGE,
 	BUILTIN_STASH_BRANCH_USAGE,
 	BUILTIN_STASH_PUSH_USAGE,
-	BUILTIN_STASH_SAVE_USAGE,
 	BUILTIN_STASH_CLEAR_USAGE,
 	BUILTIN_STASH_CREATE_USAGE,
 	BUILTIN_STASH_STORE_USAGE,
-- 
2.56.0.237.g5414b88716.dirty

