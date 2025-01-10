Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082E21C173
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549685; cv=none; b=g7vhoVyVE16CbvTfV65H9kRB/WhtvYTrYIqHesuMmTciYoYchkG2+TMyBVTYMImHYwAtdadHi35yYhAnVoR9q5okOv4XhsQ4jPHwS2eC6ncNXJs29Makfu8yAsJDkurNEgXJUpGDiBU5QJHRH+59wxXoSMbXSZ7HFQiUTg+D/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549685; c=relaxed/simple;
	bh=QjJg2l/Ju/8ysPOshINlSfRw5Gj3rNyRlOAtw7HABhc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MvPMFBL6N4IbxcprYz6Pm9A49ekKtEotmycb2f1Reju11uHxFJzQmnXpQgC9Sd3Xmup3VuORWDZ6RVnf/1pbAhBmXn8fZ6tdaEVAUIYvaZtsjA5dXEI4XZIdFRv69J+okie1QrxnY8tv5/bKPXM+a9T9svDrk0C+xJ9fi14l/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjtf1frI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjtf1frI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436249df846so18702585e9.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 14:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736549681; x=1737154481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s3n7P+bZU9d2nkL84GZ7mc3q3ZRbXKzawvicheg9Vo=;
        b=Pjtf1frIKPhMzOm4nT5GTYNNAVxXh2Q4n5rJjHV2hEgtm7ih0mUX1pG/V7IxkdF9E6
         oL2IIlIKAmTTuR87/f66jeZ/smBZLLHFcu9GrtT3uucBuVfJdM53b6OqU04n7AlcC3ot
         JpyrHeJX5twMJn06GxcFCqGycrX0nFg2lJeHvewbTFTRuPGL9W88yWBkXDT4zbmP2Vlm
         qliJ2Gv0RRxrBHBWE5uc8bINzAe7swd9u2ICbE4HzKxxfuWrjjosQqAcnhjcoDukw7t6
         sAr0I6qshIwebnP4czqK3m1AT8pz56I1SmLgsjlR9Et96KEfqWICXbE852jIiO67dHWs
         4SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549681; x=1737154481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s3n7P+bZU9d2nkL84GZ7mc3q3ZRbXKzawvicheg9Vo=;
        b=h5CTFl39sQV64O2fVqNH5mxqd77FeQIwI7rXDAxlFfbu3aQfzrV3IfTc+hYTKj6oRB
         DwBb1Lht472DoInhGv8WK3g4zhx3ClISHMAeegElacZeHBCnv44vMR3L1KFENWFExZ5D
         rCZEYTPveSsAUtwQ0UiQXPriBGiqgnToH6qlpAQc8vzONo6vtwxk6auwbgGX9bL5G+nr
         zRoNrVk4f3Riv3DO8jZFtNwoXrt1S6gNiLP/3P0V7u1z9V73hj+heKFgiCVfyhnlKGsx
         Tldt6UexUSEOaeqK84/LQQjTl27yJZazArVhh3lupDAN3bPMxDfU0BcNcabmm4wuikal
         6YwQ==
X-Gm-Message-State: AOJu0Yz0ikWGLjJXkyySyMVSaHBCXTZQzgF/jMJ6onQPWpPPZpvHlSJg
	YDsl022v0sfKvUnBY0E0tI4WpRj9oLDXkgfsZN0UsrhnZ3ky31RiDse8rw==
X-Gm-Gg: ASbGnctmqQ14o3AJrd7lQJN9lgMvcZ5y1WU2smkC+aFX9NJWUcwyesHHV5XaisHYMcJ
	gVoPNaBljwg8ue/yMdeqIhGKTfILJjxUs+NEEd/pA21tTAQzk6ep3VRjzrqap+pl2SG2cs3/tTs
	7xMo4ulij5L7zm8bNnFAydQpZjDIqMFHjOFMn0aIgv7V4+OKW2POm9iDVbI/TH4DmnXrOSKEIEB
	74/r5MoKeejkeORBKCJI8EZGRJrU3NsNQmpzJKnmGwHO8sZ06sWsrnzcg==
X-Google-Smtp-Source: AGHT+IEV/w8sxb+lmYvg79HEuEdzPSYN4utQkOmnQTz/q8LS4LnTrIJ97JZQXASadtl8KMiWrL4tEA==
X-Received: by 2002:a05:600c:1da0:b0:434:a923:9310 with SMTP id 5b1f17b1804b1-436e26a1b4amr123671975e9.15.1736549681180;
        Fri, 10 Jan 2025 14:54:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc81sm65861875e9.5.2025.01.10.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:54:40 -0800 (PST)
Message-Id: <ac8c5e1b55289d6a0acc621d1b63fb57822af595.1736549677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1851.v2.git.1736549677.gitgitgadget@gmail.com>
References: <pull.1851.git.1736458019921.gitgitgadget@gmail.com>
	<pull.1851.v2.git.1736549677.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 22:54:37 +0000
Subject: [PATCH v2 2/2] docs: discuss caching personal access tokens
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Describe problems storing personal access tokens in git-credential-cache
and suggest alternatives.

Research suggests that many users are confused about this:

> the point of passwords is that (ideally) you memorise them [so]
> they're never stored anywhere in plain text. Yet GitHub's personal
> access token system seems to basically force you to store the token in
> plain text?

https://stackoverflow.com/questions/46645843/where-to-store-my-git-personal-access-token#comment89963004_46645843
Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 Documentation/git-credential-cache.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 487cc557a87..54fa7a27e19 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -78,6 +78,23 @@ variable (this example increases the cache time to 1 hour):
 $ git config credential.helper 'cache --timeout=3600'
 -------------------------------------------------------
 
+PERSONAL ACCESS TOKENS
+----------------------
+
+Some remotes accept personal access tokens, which are randomly
+generated and hard to memorise. They typically have a lifetime of weeks
+or months.
+
+git-credential-cache is inherently unsuitable for persistent storage of
+personal access tokens. The credential will be forgotten after the cache
+timeout. Even if you configure a long timeout, credentials will be
+forgotten if the daemon dies.
+
+To avoid frequently regenerating personal access tokens, configure a
+credential helper with persistent storage. Alternatively, configure an
+OAuth credential helper to generate credentials automatically. See
+linkgit:gitcredentials[7], sections "Available helpers" and "OAuth".
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
