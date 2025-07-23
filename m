Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47E282F5
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311630; cv=none; b=PNvLmJvAFXD899m9Jl1E1KY3C6x4DuFsqrINGVjJeKB7F42jFYocF292FYU/0+EZesIMJnAkxvO1b5NTh6OIvxVbjSvjnThkNY+h1qYvM2aafn41aGzkD9I4nqlXizYImt2lsu5J5S4FWrm7oC4RoZpJX+bUOujdlKTLJrkB41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311630; c=relaxed/simple;
	bh=CAZlfG67ulRQ2RMttL7i4ybglgLQWfRe2yG2d1Limjs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PRPBTGzWgHA/qZ2UCLlKPS4B9z/qo9uIxJODkvTRmpkTQSSn9NeiayUU3QpejKvu2zaXxAdv3xmAFobcfjCSBv6LOnX80UqG3inECTl931PNpIq+SMGuC6BeeROjA1HcAtu2+G2ChO2ac2/LWc7WwKgdJZb9a8dbFtlccKUdFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwpK+pR1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwpK+pR1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so2296145e9.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753311627; x=1753916427; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb0Vk5hCGSCzkJF6mFCEtStfA/rNkFUENe6Xsdj3Mt4=;
        b=SwpK+pR1zGofzbgsvIt1WsK4bQfHAPHN9/11hHE7EjDtJYJehSW9UX+VBVCao5GbYl
         KKKR4HywTAPtUHA7KqLJWcpxBfe0lf63pdlcWCmrzykTRm0wXmik1VSX/yNasCUzQ8SO
         uxi40G3NAzeIj3xaSQ/Bqnxk6FiRfn6aMIcll7R/ljBVvbYxIsgA3dLtdBlKcWXAa5aw
         mtzIcmSB1F90p9MphTU7T6jF9OL58PDPRjV177bdQa5DdMbqluQSzpBfKn5nmUrOsTXr
         /HmyVoZS9VBsoa8CNoB64pWzYs7YkgIlXbfUI+0rM3smkGxzBGG4rdh7bOe0VFZO/zMp
         pc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753311627; x=1753916427;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb0Vk5hCGSCzkJF6mFCEtStfA/rNkFUENe6Xsdj3Mt4=;
        b=Q7+JnYYK/QW+Iek/Z5QZA2NPTVYhtOXqt6E0R/fH8FUXPN3/DbrWS0VAOyXdB1+l/2
         4LbO8O8AXrgVo0X+m7s7Z2xHuTPH4x27v9Wilii3bdURSJb1gPMnwtubq3WGagE42oer
         HGByWixXc2VbL6Rfvz/5tw7oT+zW+CM6JelXXPWvrs7GdPv1HEBSMbHSnHsxRTe5wGaB
         +wkL8A6/qVGJSyg+MgwB2LGOhjDnn2qZWn/hUg+iwy2a58zmkahXQGaCPjUk5Y7qq/KE
         q5aelVgamNrIA8JdV5+uGKoohptRWSXveFdMEtLiO0fCVepyiDpFIbxFQ3bGhFYz5iBS
         54uw==
X-Gm-Message-State: AOJu0Yyd8UXMt48xfbSwggCFGSYg3VW0lR1hN99AZmjyqPQYuMHjQfOa
	LLiqDujeooSK3R7y3f3msO4+b2Hr98Q903Yv045TEwliQPVwboe61l1ivXrLcQ==
X-Gm-Gg: ASbGnculSv+ZEcIVDMW6TxkdBpJHmemXmHMc+yP1G4DtC9XWX5viwQTpJ6AbcGoigK4
	IZtSXOSEzJHS9o4C06KNtIIDmiGShoevrUQqW3gJx4xAfOYm2sk2AwjBU32jJETQbwXIjbJ8Rns
	Z2pduVS5FcxFopQpn/NxxUUIdcsGHcm35Uf8z+BtXOGwIfN85Om0c/AwXVnisLo/KQFm2iKTdNd
	Rb5TMSMgXddK8MDdYf/j+RW1lnPEkaMmLeSwe73KcH4Vk0rhvzshR5ACFjoNJMz2K6WxwOvF+kw
	qI6pjXaMld7uqL8uFqC3dFI7Xftik0Voo5tUFXFahpX0N3/ZtAExVPnfwGEBZpU2jrDXqo3aik8
	vw7S/5NQsT91lylf8MHvUJmw=
X-Google-Smtp-Source: AGHT+IFB9rRbjERh32GEFz/RG0o2BWMR6goI7nUKKGnNhKnSD/FlXUWEcYuxlw29kOrbM7tFuqPkxQ==
X-Received: by 2002:a05:600c:a408:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-45869e4b95dmr33023255e9.18.1753311626550;
        Wed, 23 Jul 2025 16:00:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869183ca5sm36288865e9.3.2025.07.23.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:00:25 -0700 (PDT)
Message-Id: <pull.1944.git.1753311625075.gitgitgadget@gmail.com>
From: "Dan Fabulich via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Jul 2025 23:00:24 +0000
Subject: [PATCH] doc: clarify difference between `push.default` `simple` and
 `current`
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
Cc: Dan Fabulich <dan@fabulich.com>,
    Dan Fabulich <dan@fabulich.com>

From: Dan Fabulich <dan@fabulich.com>

The documentation made `simple` and `current` sound identical. The
difference is that `simple` strictly checks that the upstream tracking
branch's name matches the current branch's name.

Signed-off-by: Dan Fabulich <dan@fabulich.com>
---
    doc: clarify difference between push.default simple and current

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1944%2Fdfabulich%2Fgit-config-simple-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1944/dfabulich/git-config-simple-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1944

 Documentation/config/push.adoc | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index 0acbbea18a3..3e03cb31606 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -15,7 +15,7 @@ push.default::
 	Different values are well-suited for
 	specific workflows; for instance, in a purely central workflow
 	(i.e. the fetch source is equal to the push destination),
-	`upstream` is probably what you want.  Possible values are:
+	`simple` is probably what you want.  Possible values are:
 +
 --
 
@@ -23,8 +23,8 @@ push.default::
   given. This is primarily meant for people who want to
   avoid mistakes by always being explicit.
 
-* `current` - push the current branch to update a branch with the same
-  name on the receiving end.  Works in both central and non-central
+* `current` - push the current branch to update the branch with the same
+  name on the remote.  Works in both central and non-central
   workflows.
 
 * `upstream` - push the current branch back to the branch whose
@@ -35,11 +35,13 @@ push.default::
 
 * `tracking` - This is a deprecated synonym for `upstream`.
 
-* `simple` - push the current branch with the same name on the remote.
+* `simple` - push the current branch to its upstream tracking branch,
+  but only if the upstream tracking branch has the same name as the
+  current branch. (`simple` will fail with an error if the upstream
+  tracking branch's name doesn't match the current branch's name.)
 +
-If you are working on a centralized workflow (pushing to the same repository you
-pull from, which is typically `origin`), then you need to configure an upstream
-branch with the same name.
+`simple` will also fail if the current branch doesn't have an upstream
+tracking branch configured, unless `push.autoSetupRemote` is enabled.
 +
 This mode is the default since Git 2.0, and is the safest option suited for
 beginners.

base-commit: 3f2a94875d2f41fe4758a439f68d8b73cfb19d0f
-- 
gitgitgadget
