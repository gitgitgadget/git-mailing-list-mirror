Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6703431E8
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636377; cv=none; b=Im5sbsxX5nitu9Qmu7ExNI/NRU/aeZjz4NsOqIXyNoLSPPBnIV2DNXHAniquNavkIp6ALv3HNmZqS5I8HNTzBGOvrloVOPp5t22gNbEwGKRjpbSPe534sSgLkbt36AJzdKzDbEfWHx8LqqOKrGADvh8e2jDeUJxCHEmnxV2PBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636377; c=relaxed/simple;
	bh=XkLunMjiDtJDUqd6qODhjWnO+nnRCRDHST7tf6BUqhI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oxfVWXgFjnTBqphcp0IWK0iodd1JireQFwNQVR6PqQKB54OdR3OijeES6O7O2x09UA5DqM74+GGVeUychiXLEPDOc/mF/5dRdL/7gpwwdJWcmB5oP+h3aNki7VNJOpZVPagbFQCE8w3NU7tTbouvr5NZqvK+WWu/iD5JPee7u6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQc4srEd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQc4srEd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b0cd668so30885265e9.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636374; x=1756241174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDtNALTwVdCG8LPQo/eZ2Hre+XV56hOoZVk6Ta1erQk=;
        b=bQc4srEdN2QrZHv3NLJPC2xhYvavHIfWtyLyC1AksvFhxUaLRy0wvzFXx0dxvtob6e
         Y/DNgVkx2oQP6cijP5P0AK2nTybtMHx2IRbQw4iSh1Cd70rf0iKg/7Gefe8Pvl/fGj7n
         sp6+bZmQWZKK6bGa9KSCFLoEtoGNmNNgGG2OT4seo8KKKQqeHOyw2FR5zaTDMIEkwAy7
         /DnZwzYVex5OPsS+rBvAvrsFdsQvwZD9rk9qXsbf3833HrorgFdQQIDP1PJBHYoLdkPP
         Q8s3OkOpKi7LNlAm4yVBT3nQNcCWDaUlwUuvKxUyegN1fsRMDpxNzEGYj+hFE12OnO51
         SCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636374; x=1756241174;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDtNALTwVdCG8LPQo/eZ2Hre+XV56hOoZVk6Ta1erQk=;
        b=abngK9bgHmOA8x2aRWOm5gw+gUvf1C3QVKCytH1W787M7+IH9rRsFLgvtZPOK26SbF
         Kty1xLNL7aRCwXXHw6I7OqusgRq/67AFBmP3wUE3EllIO7T2pB9hHHpgrZZATgtBaMWC
         HLaIzbRWQgAvhWitJb7a+xInp+CyuKaffdEq2tLJd9nk1a1bC4tUhGHgbvv1Hsf4koHz
         ahdkWxP3Dm01RROQNnPqxn3gFQiHCf/PDxCrHgcEBCr/cCxBHU6Y4LdxGo7ZmxsMB+7V
         gOmRwh7aEL4qaWXLdAhjTL9ebLfL31iX+sssOdHkVvrgCwgSrXfk2bgULA1sA87XoaFb
         b3gw==
X-Gm-Message-State: AOJu0YxEw+hai3gYxLzjpbGD1LCmLb+OvSh5Jh6OfGetSW8jXMclc3Ui
	PsM/SvZ0oHXPnVdEGN/6z6TGI+zFF3niruKQ1yPQCgFNnOntMS5M1Mshaz6ZXNgK
X-Gm-Gg: ASbGncuPIzR0AXkhQN6vGPej7pYcdnXDamSHJl8fsTq6m5AxlWn32goC+C0sK+AmwoG
	wtxxFzQHWKOWxFCwoL0xMxnd10EYiszu1+vO8e0uDrruhvsymnrwIZ9bpV3lWuHiIDSXJgXQ7+2
	8rvyRClQR/NuFOUoaEduOedFGKpV12KKYm0wk++fJYA2PwJEvvJkJUmpA8x/M150kmAuRmcSFa7
	eTtCzWxCz4YIF+PbcXpi557SWUtIPKtF7C1kjvjUbOn3U0mpPsLemmXwiHhyxOAPaIKNid/77VG
	318cMnjM/y8j3DMbvDT20Hqbr0bgY1AiZo57tMuyBu/31QeepL6P3yb8CF2UufIs7LX9pGmNTzG
	Gt8wxvWqqnEBhBZM146M0E6I=
X-Google-Smtp-Source: AGHT+IFYKckG08ipBPM9syqgV6G9cegv6/hLJ0f10VVj0JQihfQsxJm88WFBaUTMMuWukyskQvOQWw==
X-Received: by 2002:a05:6000:3107:b0:3b7:837c:5679 with SMTP id ffacd0b85a97d-3c32e6068ccmr245080f8f.40.1755636373881;
        Tue, 19 Aug 2025 13:46:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0777892basm4912310f8f.56.2025.08.19.13.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:46:13 -0700 (PDT)
Message-Id: <fc2ec305a9eb267b7705c34c1b3bcdfa26207af8.1755636370.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 20:46:10 +0000
Subject: [PATCH v3 3/3] doc: git-add: simplify discussion of ignored files
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Mention the --force option earlier
- Remove the explanation of shell globbing vs git's internal glob
  system, since users are confused by it and there's a clearer
  discussion in the EXAMPLES section.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 19f99b0e7f6f..bf793d289493 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -37,12 +37,10 @@ you must run `git add` again to add the new content to the index.
 The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
 
-The `git add` command will not add ignored files by default.  If any
-ignored files were explicitly specified on the command line, `git add`
-will fail with a list of ignored files.  Ignored files reached by
-directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The `git add` command can
-be used to add ignored files with the `-f` (force) option.
+The `git add` command will not add ignored files by default. You can
+use the `--force` option to add ignored files. If you specify the exact
+filename of an ignored file, `git add` will fail with a list of ignored
+files. Otherwise it will silently ignore the file.
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
-- 
gitgitgadget
