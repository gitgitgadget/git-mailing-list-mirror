Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CE1DE8B5
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657286; cv=none; b=F+FmPIr+yXLTPOQXXuTTRIzm9f4hd6ogTBQSJMDFBBXNmug7cim7v3mrdItTF7XBmvc87MkEpbXhktnsM5dm0VJ1fIjR9HsKy7MTG+gjWv9+TcJ79JCrcUG63b0v1OkDDVaJbmohlznPPrZV8Mj2Ci+f07TVD0YzDcMMPAxGbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657286; c=relaxed/simple;
	bh=r+C30kcjUZLWyTGIcU0alDeBuS78zYUGfio7xOXeSxA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TPLk8Y5CDlguik+ghMercy2C+/eLXZRDCN5tstSXnpKzRiXDwItPxEeizRYNhxuQNiyE5/IRnbC+J9q3lNwNLm+6SNpzFKSjxGUVWAKAK1rtcytID+v1IjTZ2M4CXhcEsZwFbm+KtSJS5yGecdINjRtB98iX0JV5XBWjZvhshxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPN5ubQa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPN5ubQa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so83769795e9.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749657279; x=1750262079; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Fd6D2EX5SmA3vjHsbcV3jAl+K0eykm0DZ6cYVix/DE=;
        b=FPN5ubQaAMoFFpzemB0kwijhPE6bxg1V0tGJJ+onlBYCZgPK/cA/UtoHO5X9H8/TX6
         jllwBqViNKUfDNTNlLnlL0OMQjKLFbgVN36fqgduXFMn+gXb6mAnEbasptaBfFFuLCZY
         epwZNOhdV9dJIBnKW1NuhQtMcGAUCJnKJ7sJu8fh/RT32Zsfr/qpuU2UCI5hp0BOfT6O
         wPTPS1hTyT5W2DLoZsMpdmX7aFt/6uWQqKalCCzCCC9plnNWwDSBYFku8bXuBQeBcEJf
         1fhXuObabpGnJKZaCgXMcEDFrRBJSq109Hm9TrpCdW2Lzwloka63QGM4w+7JwU6O0WKj
         ziyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657279; x=1750262079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Fd6D2EX5SmA3vjHsbcV3jAl+K0eykm0DZ6cYVix/DE=;
        b=bUsWKZnRZfP/TOmsNnlEByxLjjUkJv5665g0PNelgwrbUdqyMusa99JmCRdIK1L/0Y
         lRMUsKRFVoUQ4tsDxIJFzN0rNrx+lG2EkLYq/1bmurX77Cz28eae50BQRuZZnNclT6lp
         1vov76+jVlQjJ5mHnDEochvkvJ2hgxVlVsl50TuVTn/9RxJPWz0qmQRSNt+8G/qVKkAa
         TgjCVraUBCmVV4hxjwcAmbYn1IUkeCXxWWQE37iyMb2y8NPWBkXVuLYqqUIxsJOlRd/3
         v4aQq0av8tPkSwCKzlFAf9g4SVxsZh0nKNLfk9Zgz1rXgL1xPbfo/Tnq7rlxXgl7UASy
         FO8Q==
X-Gm-Message-State: AOJu0YylsJgnlp9Oc9s3qFQ4+6LEh5uGt5fOCGENmdtIZNhiLbGXqVmp
	BCUs6G29yL0dCRXsmywHDP25a+hFvJWtNnopQuj6dfidKZ/4uPDYxqgbv5FOAQ==
X-Gm-Gg: ASbGncsoAsYkdkxjNsQX/xBrO3SnOPmZmfgwOUZh5T7J4wPV0ka1Nki4GrghqXVnzVM
	ykZXhTwnlhvJK4IUuhs1KDrvEYxPmGceTbKsCucRhc4qMGDvH1DbyARpENHop4zVQwHF5p+nkXI
	f1ETVi75niKvT+kCHiNO7vHk6T8/VEN2SMs6QOteidKMPEQgW1w9di/AEBA3N0bGdPKMjhKVsu3
	iup6RW4GNWZRq8Zm17nf7yNEBNz+UJPHTErD7LuRjWO7guaNKd2bG+ea7zGTNGOEUO8yeLJypjc
	RUU9z3SMq0Yoo/8kUs+qVV1FZsPnpRQFKQqPuz5NwU1U5bhdsA0lScfQHwh98NA=
X-Google-Smtp-Source: AGHT+IEssTOVWYggEzl/8l50Tg7JDXdU07JpTfibENEbWHnOXbujIQFZ0EevV87+kJPO8v8xl3hGnQ==
X-Received: by 2002:a05:600c:1d0a:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45324879e63mr32945125e9.2.1749657279229;
        Wed, 11 Jun 2025 08:54:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b5147sm16047516f8f.37.2025.06.11.08.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:54:38 -0700 (PDT)
Message-Id: <pull.1934.v2.git.1749657278.gitgitgadget@gmail.com>
In-Reply-To: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 15:54:36 +0000
Subject: [PATCH v2 0/2] Fix Coverity builds on Windows
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

As of three weeks ago, Git for Windows' Coverity builds fail
[https://github.com/git-for-windows/git/actions/workflows/coverity.yml?query=branch%3Amain].

The reason is most likely the most recent Coverity release, 2025.3. Its
release notes
[https://documentation.blackduck.com/bundle/coverity-docs/page/webhelp-files/relnotes_latest.html]
do not shed any light into the issue (and do not mention that they bundle
JDK20 and JDK22 in addition to a JRE, because what's better than a single
Java installation: three, right?).

My investigation turned up .dll files that are located in Coverity's bin/
directory which have the same name as .dll files in Git for Windows' SDK. As
a consequence, the former override the latter and throw off MSYS2's logic to
find the MSYS2 root directory given the location of certain .dll files.

This patch series fixes this issue, and while at it, enhances the Coverity
workflow to print out the build log in case of failure. It is a companion of
https://github.com/git-for-windows/git/pull/5672 and of
(https://github.com/microsoft/git/pull/764.

Changes since v1:

 * Dropped unnecessary, non-portably cygpath call.

Johannes Schindelin (2):
  ci(coverity): fix building on Windows
  ci(coverity): output the build log upon error

 .github/workflows/coverity.yml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1934%2Fdscho%2Ffix-coverity-builds-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1934/dscho/fix-coverity-builds-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1934

Range-diff vs v1:

 1:  c65120f2570 ! 1:  712602c09e4 ci(coverity): fix building on Windows
     @@ .github/workflows/coverity.yml: jobs:
             - name: build with cov-build
               run: |
      -          export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
     -+          export PATH="$PATH:$(cygpath -au "$RUNNER_TEMP")/cov-analysis/bin" &&
     ++          export PATH="$PATH:$RUNNER_TEMP/cov-analysis/bin" &&
                 cov-configure --gcc &&
                 cov-build --dir cov-int make
             - name: package the build
 2:  3a829f11c07 ! 2:  52c34977b48 ci(coverity): output the build log upon error
     @@ Commit message
       ## .github/workflows/coverity.yml ##
      @@ .github/workflows/coverity.yml: jobs:
               run: |
     -           export PATH="$PATH:$(cygpath -au "$RUNNER_TEMP")/cov-analysis/bin" &&
     +           export PATH="$PATH:$RUNNER_TEMP/cov-analysis/bin" &&
                 cov-configure --gcc &&
      -          cov-build --dir cov-int make
      +          if ! cov-build --dir cov-int make

-- 
gitgitgadget
