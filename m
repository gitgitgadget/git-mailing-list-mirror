Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D084028DA
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814059; cv=none; b=poCmO4ASLyoT9OAsNiSX5/VaKmeKLSLNYOUezFXoxL41KPF8tYICDh8p11dalXAFehEhqGFVTI26lMcyeveYGQSELD193UmdDNqXFFE5jhdjO0hVyZ6Z0ITM05/DY8fb4BlxNZRHKUS1PahVh4DNgT+ASQDsELLQJCjO4RzEufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814059; c=relaxed/simple;
	bh=yoDQ4w6884OK4PP+6lZSw5e14XDvg1K6BWNpTlh3jDI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cJw2IJlu0I2jJcolhC2C+W8Iq2rtFG5EoHx8FfbnPuAcTccWW6ZktKn2uv6NHgv41/fd/QLYxcu6WcQuy+ipo8yvlF+nEjJx15XL90KJlOoeg43XyyRp6x8U3SsNIz9C4Dpu6WQl5SoggrJ7HeOYNBiCeRqVG9QPt4GK39i175A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+1Aru3J; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+1Aru3J"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516d6402264so30250291cf.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779814057; x=1780418857; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIWFayKHf4AOv2QLTRTpiJlLuaJ91sKfzwoT9NgL7Cw=;
        b=B+1Aru3JJebjej36M4m40TASi80k0yNiCcHedakd/J4VDad7E0TnkXkTkloQsEe9wT
         6AJhjvtmZmKIdKo4auqYRsVOaeiuB1F1mxbsjowx+4nZDNgJyjxJAKVwIAcTnujgpmwr
         WKcZnxv+nHFNVc5vWPWnASks3/pJMF7D3fLf2CdYCnUx8dvW45CbJnnNnP00Lp7l7OvE
         yXRbNrucivR22oghQYskGhxXkzuaXcw7+ptO//KCipMVSreIs43rQnK9zcCQKBRnSdJB
         8J1dNkTAubl9JODKQL9WXfOV3A3dFoE6fs/QZZgYNgx21MypxfTMubxR5EoMLiNdmDPa
         ZlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814057; x=1780418857;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xIWFayKHf4AOv2QLTRTpiJlLuaJ91sKfzwoT9NgL7Cw=;
        b=MbsFKdz+KCtK9g600p7M1Gahh7StFpGKTQ5rMN6LENRS4aDxUm16W8AEYDaIX4LL8A
         QkZ3nqiEGbWiD20MSueUc523aVTjN13BpC5NqAVpw31hVFhVhn+q1RBvnzBLiJdHYNRT
         68pHgUsN6Mc2LTJXZmoVClpTtKQuQlNXkeFL5GSbFT+9MAicHP97zkXy0KOmTbgDC/tc
         ClfWck7e/MvUCC76xppryB44rPMmshM36HXL7UDtrEexyx/9WFfzxYScTnUJy5/lImPj
         Kd6g0t0le0rJANHdsPrCEcFFIb8VxxDS8IEHMVDwuvGXp56098gUbUN0M4WI87sLLbhm
         Xenw==
X-Gm-Message-State: AOJu0YwAzHbPkfTCZgmI8cK+qWizKXRB0xvR3wl4L4ZUez0kQD/XsGnI
	IJxrbLREx2+wyXf3J3szWosIVMznmWi5LiM1Qut5ls8ircRBRH/XOJdI6iDizg==
X-Gm-Gg: Acq92OEDx8zPFdCxOwFwWQ4G1LpDRwzzsanKRZjabQtubDuyw9gEKDeBfO4kAVEdawG
	YnEbUMComlZbN3L9o4HNj4tGH0ItcCzFdDqSZUS/R+JnMa6ArwGUGRz7aAhyL+NIKBr10hyedHF
	ciCFgDOYkTA/z2P9crzq1bKGPLwXpih5KIsapDhB1rCvhnsfDjuWuxAn6984ErD3EGDRSGzl8/k
	3DPmkdKk0Mq0BIfCl47xBYGIyEX/nf/H1UjHndFkJy2OLKqHkIcvD6pHis2Bl7zn7mwTaWjr9op
	SVM1h6TSEEe5fC8sM2Q2/uG4NuMbSoVL7USsbIPomsCjWLTnlft/LBHFguF9NTwm96KJ66FHzuB
	iNpm7y5fEnT4u6XiAqpxhh8rK9QbeReuHdr+zQwA1Rwb7gpcK3SSGip/tmuBNIadeg6RB+RCie/
	MS1hOS0zPdLbB2Kp0IuE7DriI=
X-Received: by 2002:ac8:5d04:0:b0:50d:770f:ad23 with SMTP id d75a77b69052e-516d42ea812mr273570251cf.26.1779814057119;
        Tue, 26 May 2026 09:47:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf4a9sm144140136d6.2.2026.05.26.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:47:36 -0700 (PDT)
Message-Id: <652381886f8cf839d533b9322c1c5e5983f3ffe4.1779814052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
From: "Evan Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 16:47:30 +0000
Subject: [PATCH 4/5] git-son: add documentation
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
Cc: Evan Haque <evanhaque1@gmail.com>,
    Evan Haque <evanhaque1@gmail.com>

From: Evan Haque <evanhaque1@gmail.com>

Add a man page (git-son.adoc) documenting the synopsis, options, and
usage examples for the new command. Register the page in
Documentation/meson.build so it is built by the meson doc target.

Assisted-by: Claude Opus 4.6
Signed-off-by: Evan Haque <evanhaque1@gmail.com>
---
 Documentation/git-son.adoc | 64 ++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build  |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/git-son.adoc

diff --git a/Documentation/git-son.adoc b/Documentation/git-son.adoc
new file mode 100644
index 0000000000..17ec992bfd
--- /dev/null
+++ b/Documentation/git-son.adoc
@@ -0,0 +1,64 @@
+git-son(1)
+==========
+
+NAME
+----
+git-son - Create an independent child repository that knows its parent
+
+SYNOPSIS
+--------
+[verse]
+'git son' [--inherit] [--branch <branch>] <name>
+
+DESCRIPTION
+-----------
+
+Create a new independent Git repository inside the current working
+tree as a subdirectory named `<name>`. Unlike a submodule, the child
+repository is not tracked by the parent; instead, `<name>/` is added
+to the parent's `.gitignore`.
+
+The child repository is configured with a remote called `parent`
+pointing back to the parent repository's origin URL (or local path
+if no origin is set), allowing the child to fetch from the parent
+at any time.
+
+OPTIONS
+-------
+--inherit::
+	Fetch the parent's history into the child repository at
+	creation time. Without this flag, the child starts with a
+	single initial commit.
+
+--branch <branch>::
+	When used with `--inherit`, check out the given branch from
+	the parent instead of the default branch. This option
+	requires `--inherit`.
+
+<name>::
+	The name of the subdirectory (and child repository) to create.
+	Must not already exist.
+
+EXAMPLES
+--------
+
+Create a simple child repository:
+
+	git son my-tool
+
+Create a child that inherits the parent's history:
+
+	git son --inherit my-fork
+
+Create a child starting from a specific parent branch:
+
+	git son --inherit --branch feature my-experiment
+
+Later, from within the child, fetch updates from the parent:
+
+	cd my-tool
+	git fetch parent
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..1ae7e5f644 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -139,6 +139,7 @@ manpages = {
   'git-show-ref.adoc' : 1,
   'git-show.adoc' : 1,
   'git-sh-setup.adoc' : 1,
+  'git-son.adoc' : 1,
   'git-sparse-checkout.adoc' : 1,
   'git-stage.adoc' : 1,
   'git-stash.adoc' : 1,
-- 
gitgitgadget

