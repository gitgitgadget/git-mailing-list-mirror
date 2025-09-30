Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703D28C869
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262324; cv=none; b=aVUIqWw3PZxM0JGRGmDFddVQxmcUImqdV74nZAsW+t/CVKXzEayxxsisSp9xwR5hhX88mWLOMtYg6bGd5NOQ7jz7J4D2y4/HJzC5M8pdqFcv5J1GEMbXonqvPfFjldB/Ydnvm8mfFh4H+YaiW1g+jjtAF5dgMdcH/hPpQ6H1Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262324; c=relaxed/simple;
	bh=I//mrknEEmeFyUJPp/xW8AYJJ1J/shWbrXE5Pyl5RHw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nFWVipfvmuVUYV7C51RC3Qtwz8laf7VxRq8/CbGb/OGGd4JAJneqrVviyY02saITcpjHzNLzxH7nx9jESoZhq9YD72Ump2PPVKV8FsUmsJfhQNl3UQ7PE4U3ZznFlGqPzrlaw+fVZb0uRgpsZpQgqbcKMnSEr8RnKOn3O8wxAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEQZmuo/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEQZmuo/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3307de086d8so5840395a91.2
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262322; x=1759867122; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN2RshVnLWNPULWTXEOTYga8TOV9uc9g9x6x5V/x8iY=;
        b=FEQZmuo/p7jOdOyhLQBB5/9EwDh+yY+8e/F9Bd9TL5zWl5iXKWHZPCiJMcEbtVs/DR
         lvZa58F4hnLA1Bt0jB0+wpVYf67BS1rgqJdZzcnH/1jo/1x1TIas43bvaLbAvoqCqQAY
         tPUHJJFVPux14EjcD8myOo6MYGrP95UaP9ZsfWirAEpuPKPygYntPbCgkdXzdDQWEp1M
         7FDyAOhzxS+1GRhRzBvb/CjMsBFpSWTkz4272QVtaw7frPrBHdvDzOkdIJfgv30K7wAX
         6OLhPDi5w0IYOwuRBBAb06ybHKse5N9cEpS1mbEYg0LT26PPaEU+5m1LIG/W5xwy8jv7
         aHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262322; x=1759867122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN2RshVnLWNPULWTXEOTYga8TOV9uc9g9x6x5V/x8iY=;
        b=EYheGpTvHggLqSYlztLSGSImr6OFmJURzV4XS28aCWLsskigx40FOcQPyXC2vFP1Ir
         1+TFPK0pRvVaWJVwtRDuzgrTeo0weZMnVV+awQ82LMwjqcNYOEXcTnV6/T1xjo0Wd+qB
         cb8V/tV1982L+ajaK46Ha8CObXGsQPQELKjFs1rGLd5raKlxR0c9+RzWd6Ui5BVRni5i
         FMPU4AgcHiIsclnXw/PPF5l0PKZW34FoqweG/ECR2884bfe2rdCl8d6Aoz4NIn2EWcIk
         o+joWWa85wWEgwPyVrI3woOLVmiGgPvqneUaNNhnbHSqtMe18EVHmv8prpoJPElESOZS
         3EIA==
X-Gm-Message-State: AOJu0Yy3UUpUSrZ38bd3Y8on5PLOMi2h0wcn1hz3EgnjD39VcJNmllIH
	f5p2CzfC/O6AoVrbHldBI7SqiCssKxwYzicV83CzIrPW5gS8W3iKG7MSOLRI/ewb
X-Gm-Gg: ASbGncsHnElhuDE78YAnQ3vGMjXaLdTrD4N9KU8+8xd3T6o/HQNdQGs0dNHpRZI2wzl
	NDi9WAtbE8ZZ1oFGD6agQwcxt1y8K18hgtMM2RudXFFW19jz5VASetUVDRCssJmEaIManbPndcP
	gC7IauN4mGhC88WQIo59f2ExPREldJqvO9pqH7/YXp7719m+tirlziqd9bIlOnJeNhGvuODBq14
	vW1EQLijWYkNn0DDiDMXDSiyASS9eyJSOKP7WnOkg7AbRXVAeP5sIDcaMqjFA2hh5A6zi3HAmbB
	HqegjZx89/SAfLya0sSucSKwWKT0Cc2rghJhiCqdrRDTceZ80UfPazD4rYmptKypzuqPf8BUrw0
	IlHSyaWkTx1mhiBQihEPPLzy8LWYS16kMGAf+cKx5ykLiHiJjdg==
X-Google-Smtp-Source: AGHT+IEJEZvrVsTsOI8LLV6//Ob7NCHGftVr1W6PBjWb/aVcT0+7oz25SOCMP3w4kYD2RdLPgEzhfQ==
X-Received: by 2002:a17:90b:2241:b0:335:2b15:7f46 with SMTP id 98e67ed59e1d1-339a6f0624fmr694345a91.21.1759262321999;
        Tue, 30 Sep 2025 12:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.210.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9f0bcsm386859a91.1.2025.09.30.12.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:58:41 -0700 (PDT)
Message-Id: <c1d4ea8d27ff037fcc40c2c6dc1c4f0bd9000b1b.1759262314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 19:58:33 +0000
Subject: [PATCH v4 4/5] doc: git-push: clarify "what to push"
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: 6 users says they found the "what to push"
paragraphs confusing, for many different reasons, including:

* what does "..." in <refspec>... mean?
* "consult XXX configuration" is hard to parse
* it refers to the `git-config` man page even though the config
  information for `git push` is included in this man page under
  CONFIGURATION
* the default ("push to a branch with the same name") is what they use
  99% of the time, they would have expected it to appear earlier instead
  of at the very end
* not understanding what the term "upstream" means in Git
  ("are branches tracked by some system besides their names?"")

Also, the current explanation of `push.default=simple` ("the
current branch is pushed to the corresponding upstream branch, but
as a safety measure, the push is aborted if the upstream branch
does not have the same  name as the local one.") is not accurate:
`push.default=simple` does not always require you to set a corresponding
upstream branch.

Address all of these by

* using a numbered "in order of precedence" list
* giving a more accurate explanation of how `push.default=simple` works
* giving a little bit of context around "upstream branch": it's
  something that you may have to set explicitly
* referring to the new UPSTREAM BRANCHES section

The default behaviour is still discussed pretty late but it should be
easier to skim now to get to the relevant information.

In "`git push` may fail if...",  I'm intentionally being vague about
what exactly `git push` does, because (as discussed on the mailing list)
the behaviour of `push.default=simple` is very confusing, perhaps broken,
and certainly not worth trying to explain in an introductory context.
`push.default.simple` sometimes requires you to set an upstream and
sometimes doesn't and the exact conditions under which it does/doesn't
are hard to describe.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index acdf25e5cd..2848cf2e1f 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -26,18 +26,20 @@ that isn't already on the remote.
 The `<repository>` argument defaults to the upstream for the current branch,
 or `origin` if there's no configured upstream.
 
-When the command line does not specify what to push with `<refspec>...`
-arguments or `--all`, `--mirror`, `--tags` options, the command finds
-the default `<refspec>` by consulting `remote.*.push` configuration,
-and if it is not found, honors `push.default` configuration to decide
-what to push (See linkgit:git-config[1] for the meaning of `push.default`).
-
-When neither the command-line nor the configuration specifies what to
-push, the default behavior is used, which corresponds to the `simple`
-value for `push.default`: the current branch is pushed to the
-corresponding upstream branch, but as a safety measure, the push is
-aborted if the upstream branch does not have the same name as the
-local one.
+To decide which branches, tags, or other refs to push, Git uses
+(in order of precedence):
+
+1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
+   or the `--all`, `--mirror`, or `--tags` options
+2. The `remote.*.push` configuration for the repository being pushed to
+3. The `push.default` configuration. The default is `push.default=simple`,
+   which will push to a branch with the same name as the current branch.
+   See the <<CONFIGURATION,CONFIGURATION>> section below for more on `push.default`.
+
+`git push` may fail if you haven't set an upstream for the current branch,
+depending on what `push.default` is set to.
+See the <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> section below for more
+on how to set and use upstreams.
 
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
@@ -696,7 +698,7 @@ a `git gc` command on the origin repository.
 
 include::transfer-data-leaks.adoc[]
 
-CONFIGURATION
+CONFIGURATION[[CONFIGURATION]]
 -------------
 
 include::includes/cmd-config-section-all.adoc[]
-- 
gitgitgadget

