Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C032DECA3
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777141; cv=none; b=uI+ruHEg9p2UBLCx9e3gZfhXswqtmrqNcPHrJlk0kammIvLA+lelSiL6Q3wNgYN+SrfgEIdfn06WApMaSJlAHaAvgT9wVsopK4jNSDwKSe0st4bo9IoMlzFGZCqEHtYH3tFQoqI1HswUujeILodKI88ySBLMhijHOHmheoWciFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777141; c=relaxed/simple;
	bh=ulBy5lYTJTcLIfhvwmiarU488LU6KXU77mxX3J4DKXc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SnWJvq7nfkf9vEWww3RYM3x1UotVPDQYmnqt5SEZqVgX00OBhguxLdtXQ0WH9Xz7dnCJXqM/TgavYbwWv1eMMPv1r2QYzNxGquCaDhwif1VA/fvXUPLKiWJESc0YaTCYhvUKtHeUlgbtZP7sRxlGtD2lnzWgXh5mhIloDFAGROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PahgURYG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PahgURYG"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso5311040a91.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777138; x=1760381938; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWzMACl0gDCpdMfTo1qKW918JugqSilkQYqnRAmWryY=;
        b=PahgURYGrtsM9dFdZQkz6jP/WrL9jt8SFKNrlo4NWYXkBZO1jF/eNITIppBCc1JlG8
         afO83gmrqxfQGTiEspUmLpdrAQtyAKiImDH1oNrkeBu/J21js/sjOiFurTMLvlcdg+QT
         vTtSkNrngeFfbR4F86wFdA+mS9C2TIJvZf+M4OCg50Hi33J4vu02yb4hY+Q9R3FOk+m/
         0bNmQ82a38mblvdZSlVtEe+eYYUxjfO5fum+Bp/TvEr2IunE2kHrViUf94+qRgZZVm1V
         /fC/DHn6j3lt6gUHevrV9aJEqT1KGUN07Q39oxcubywurNeeDjAOh7CPW9kFMSGdVL2A
         Rl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777138; x=1760381938;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWzMACl0gDCpdMfTo1qKW918JugqSilkQYqnRAmWryY=;
        b=RcP8z6XGktIXgR7C+MbRPO7BLWHI4FTZZh1W4XnFiibICW80BrTU+ZEXzYPxXRl14g
         fsSjzbLlIBEQpbUa9X9F+3jP4wYwfXv+uDROi76X3XLC/B5ygVOidDmVqh9O23aC5HZS
         nMeOb9y4xTGl/3tgoMOP7vZzwaIs81sjscmvFLHlaczY73C0n5l0g2EgXs0edUu7WsrU
         tSAh1t8f0pnHwpf2IOdRaJY+zqkRDEgDvOWd23rKdgk34m6Guf7/LdvT70stmfBBdfYX
         WkJhlHPJ9jh9hvCl5AYejTOqNnxgriEBPq0pYh8SfavCrl9OiF8oRecy40XYp7+arjIG
         GHww==
X-Gm-Message-State: AOJu0YyCNjcMabNTujL0Y9kP2+DQgJQFKiZB7E61fz5SDqikDlMdSx+K
	wIg/y8Lr7Rhw3ApScMr0IFeHPDo39R9ydsDCV6zmLutEsViWotvOSGVZNaCesEhm
X-Gm-Gg: ASbGnct7KYiUYiiA6ipUtx7WmLTf8WeBdugi/Em18uU8Fwwz07HMHZSG3ZyXi044LGa
	V0lb3cNNaFBdvoHJQmCV+bivkfivHvdGBch6pa8Eae3xpHyvMFJD7kVfzC4kth4VLYF5+MCALax
	e1x5PavSriUzW9++FoZZ+VHY+N5wSfxST1Iw8ChQ35yPAgF6cj+cV65ByBvfnQOiqXls/ctS0t8
	j5pLZcQKbe6iYqi9XMGR0ZD85Vlh+4g7KcMlUYpVXzJXwR0UNEMYGYnRRDFBOlzmj97L3DJt87H
	0h9GKE61yrfVCKYn0+8QMIwM+cZQ8UWp9l+Bvag2z/gPXpqgj6MSlAF2ea3yK1voGohpI56WG2n
	m5YGYU1eFy/X8nQH8wPzx4PwVs2C4XoZI6bsfRIho64t+f3ZmgA==
X-Google-Smtp-Source: AGHT+IFFhpRpHa4BzhIiah9MiBTSjupniBDzPFsDH2z9zms8onBEnFNIidSR75Yp8UkhdXfvHkGq+A==
X-Received: by 2002:a17:90b:1645:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-339c276e987mr20087655a91.15.1759777138516;
        Mon, 06 Oct 2025 11:58:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099ad9405sm12865777a12.10.2025.10.06.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:58:57 -0700 (PDT)
Message-Id: <336023fbf14b15dd473fc02ff25bedc43ea0ea7a.1759777131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 18:58:49 +0000
Subject: [PATCH v5 3/5] doc: git-push: clarify "where to push"
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
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

It's not obvious that "`branch.*.remote` configuration"` refers to the
upstream, so say "upstream" instead.

The sentence is also quite hard to parse right now, use "defaults to" to
simplify it.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 25d972f248..acdf25e5cd 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -23,10 +23,8 @@ Updates one or more branches, tags, or other references in a remote
 repository from your local repository, and sends all necessary data
 that isn't already on the remote.
 
-When the command line does not specify where to push with the
-`<repository>` argument, `branch.*.remote` configuration for the
-current branch is consulted to determine where to push.  If the
-configuration is missing, it defaults to 'origin'.
+The `<repository>` argument defaults to the upstream for the current branch,
+or `origin` if there's no configured upstream.
 
 When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
-- 
gitgitgadget

