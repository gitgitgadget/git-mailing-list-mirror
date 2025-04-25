Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910762192F3
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609284; cv=none; b=B8Kxd4iGCY/qwjhIeGpjdlHJNcqfjOKsiOmkFwstencg6niB4grFi05FmcB7jsX8bTlfMSsnkcnxwwNQER7nslgJBqGj23l6IijSg0T+wvHqd4gCotooKcD8ahTjXuv+0WmC1R2Ct0dDrLx1GetqNDs/G78H9crJvf4wAW3RKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609284; c=relaxed/simple;
	bh=TU3R0HD9l/GGk6b2ec09bmNYe2TilE9yjYmmxcbS4hA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ao3ykSkBAk2lDSk3Ac0rzeUN7JzzlP5hhCzZKf8eKXYu1oGPORSF94DFJb8WA1Zrc/nHQ0ngJLSS7hEk7TCwBjIIFsfY/h+N2Uv0FE7ikWiZINP4XPyCDnLtLmakRPaaJ1CNVEAh+gZqAAhS3lQbTA/pC5BjFYbXfQsh0kgZARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuEJwKbT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuEJwKbT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so11719175e9.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609280; x=1746214080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk5GjnT7yk7e7jfxcfKurFpfhKCSBgPMGCueAbJk0Hk=;
        b=YuEJwKbT7hBW8Bz1/IXs8ODuJu6mzPKZH3e2z1NJ12t6dkQeKEo4rxGr/PhCbqvIAQ
         bpqVormhCB0nMQtxHzwWaVBcDZpidJKPXOtc6KdKsRYGi0X6aMRzc3YN9Awgs/ukKHS+
         5gf6pw2n/sVPOToMQsGaROoiMoX4KEq+2Yox8r7GZdx3vZKQjdd1UPFVqFSEDwrn2oB4
         jCK2VmFMaYphQ9kuFPNhmrz3CJZXOXJ5ZakH4quiETmulDC6KEWZwUs2ImTx2IX/plwQ
         q0O/1iH5yVIf/QwTUX8t4A3q6Nd56E6vV99dIBYkuwk/ULimDoONl4/a0NVlnUr61yvE
         A0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609280; x=1746214080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk5GjnT7yk7e7jfxcfKurFpfhKCSBgPMGCueAbJk0Hk=;
        b=LF8bfBxNM3ReDdP3QQ7VUHcCnD7lr0q46g7BnEiz6DxDOyPy2ecQn19y17i4berkv8
         vz6tTjNFhX3zzPwj5BMHqevr9Es1SogZm2sGSzB9XhE/JaGZlpj/XFzgdK1aw4VIwGVB
         gpfTbOHZ3a9zVRsuhDkvaGwCcoC63xOXXSRKdGn+xGfBZ6nguGtt4ehQeeZYHSPREn7n
         snljihVGor3lhq0NzKgJp9C1sO2edlxEAGywmiYe94LtvfsRmdHDz+XJi0fAnYpPMyPM
         LBPkphA7vTDKxu5xPwaW54TWh9/+5gMHvJwZa2pCa9wX2dt+uuHWjdXFh2W1kK3CDpAR
         kG+g==
X-Gm-Message-State: AOJu0Yx0oDerKUl4oNHx1bcvavn8LZsI8eX+Mnv1V8LDINyzWol4RGCz
	kH6gWzU4ZDoDeInSr0fwdwZHIMPPDQOhdMSPakNlyZ9gZWn0asgH4FmzEA==
X-Gm-Gg: ASbGncsu+AxgmYOhTWMG3r3wvkTnxvm+uF/l7na+JxOuoYaW4YuWeg4sMOR8YtFqOI8
	hb91ZvweG7K41/9HNYkihqIltJCL+leUvtcEnQgn2p92UnoiRCed/ZtPfF3lGR39JwbjZPO0fM9
	tqiAOb+jbRBjmg9VoSbvv0coPCe3IvaAeHzGUD+CHW+dLmPLdsbA/hmiN5+Ez5Sh1T6oT47tZmp
	EVfYrrzxHhiNPOPy0yWufhcb+Itwc9E8YdB+wQmYMHlxKpWqO5aXKPG0A2BIaN63qemkWeTX4rM
	jQHpUa0lltM5YBa9+rqJaCoHVebhI/uH/Tr3iTSg7g==
X-Google-Smtp-Source: AGHT+IFNmn/9SY4EgSlcrMAMR/H+GHvIIFxGLT4+jZy+OPPf0J9xWKYNNFs9QdFC8eIfcJ/9benotA==
X-Received: by 2002:a05:600c:3b25:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-440ab77d33cmr4316095e9.6.1745609280059;
        Fri, 25 Apr 2025 12:28:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a531072csm33853085e9.18.2025.04.25.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:27:59 -0700 (PDT)
Message-Id: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v5.git.git.1745607965.gitgitgadget@gmail.com>
References: <pull.1897.v5.git.git.1745607965.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:27:56 +0000
Subject: [PATCH v6 0/2] bundle-uri: copy all bundle references ino the refs/bundle space
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>

Edit the documentation to update the refspec and remove the untrue statement
that it can be configured.

> bundle-uri: copy all bundle references ino the refs/bundle space
> bundle-uri: update bundle clone tests with new refspec path

Scott Chacon (2):
  bundle-uri: copy all bundle references ino the refs/bundle space
  bundle-uri: add test for bundle-uri clones with tags

 Documentation/technical/bundle-uri.adoc |  14 +-
 bundle-uri.c                            |   2 +-
 t/t5558-clone-bundle-uri.sh             | 202 ++++++++++++++----------
 3 files changed, 124 insertions(+), 94 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v6
Pull-Request: https://github.com/git/git/pull/1897

Range-diff vs v5:

 1:  6957ee2fed2 ! 1:  d6ec5c87b43 bundle-uri: copy all bundle references ino the refs/bundle space
     @@ Commit message
      
          Signed-off-by: Scott Chacon <schacon@gmail.com>
      
     + ## Documentation/technical/bundle-uri.adoc ##
     +@@ Documentation/technical/bundle-uri.adoc: will interact with bundle URIs according to the following flow:
     +    are present in the client repository. If some are missing, then the
     +    client delays unbundling until other bundles have been unbundled,
     +    making those OIDs present. When all required OIDs are present, the
     +-   client unbundles that data using a refspec. The default refspec is
     +-   `+refs/heads/*:refs/bundles/*`, but this can be configured. These refs
     +-   are stored so that later `git fetch` negotiations can communicate each
     +-   bundled ref as a `have`, reducing the size of the fetch over the Git
     +-   protocol. To allow pruning refs from this ref namespace, Git may
     +-   introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
     +-   stale bundle refs can be deleted.
     ++   client unbundles that data using a refspec. The refspec used is
     ++   `+refs/*:refs/bundles/*`. These refs are stored so that later 
     ++   `git fetch` negotiations can communicate each bundled ref as a `have`,
     ++   reducing the size of the fetch over the Git protocol. To allow pruning
     ++   refs from this ref namespace, Git may introduce a numbered namespace
     ++   (such as `refs/bundles/<i>/*`) such that stale bundle refs can be
     ++   deleted.
     + 
     + 3. If the file is instead a bundle list, then the client inspects the
     +    `bundle.mode` to see if the list is of the `all` or `any` form.
     +
       ## bundle-uri.c ##
      @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *file)
       		const char *branch_name;
 2:  ec5d629f32b = 2:  825d2b01eae bundle-uri: add test for bundle-uri clones with tags

-- 
gitgitgadget
