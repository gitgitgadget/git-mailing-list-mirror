Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868D3375AB
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703318; cv=none; b=Z5tmXy6zYSsV9dYvawQVAhXlqqB19gE9AmqU2N++Xw5GjkQEHOa8+c19QqObVE+NDaiWgYG+fo+TIcQJ9bR0UemkQxxF+my4TtCP2pKAxf7qMGnQymhYFS7dsNPdd8X7EOJuSV7CzBrAJnbJgVQDoQfhWp6R8+vS7b50CeAJwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703318; c=relaxed/simple;
	bh=RXDPxHDR56ca2VWW487GSeTNwUInKw4VDvPq2J6slvI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S6B4LgK/Nh3/rlRPRB86UJjRYl6HMUUpFaRKernU8/LF8lbTlhiAs0lL/GVrs6c1dINMr3SEnWqYX+6ERUoZTzz3QgL03sDwswNR5GUYorPIKEBlY5Ou+i9pnxzhhY+9e3pb0d5fXRdeA4zIaC8I5/X78ix+76oZMay5BKGb+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEoThEcl; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEoThEcl"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-406630d3b17so24758195ab.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703316; x=1758308116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTfxScHb/TxsA4mMzw3nu2MKKryR4TQMnnr14RRUPPQ=;
        b=cEoThEcl3W0D3cWZvJa6adwfVbdIJSGwP9X5pFSZIvKq1KpA40F8WxsIANVXa/nFZZ
         fP+AuhqlN+nIBsymWcN10DbocQqmN0+6gfNkpCItQrDWqbxp1mF1Lv4IZdFnZR+g8fWW
         Af84eimNeEbYWAzjZVIYtVjED+xFqI8LmfBKbJwk9f5GeS9Jabc1OsztwW2XOHCkRGPW
         yTdPHdH+AJ3dAW4pMFYOXROYTh4iQJYM9F+QojtUIGAglhbrDNgwYFCMTDTLkbUDOupv
         WhFnUGdFJ2/5/7XBIjYddVyZ898NUh3mCOh6gDkN109eXRDLhE+D5vTcZYClY+LhXQkY
         hkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703316; x=1758308116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTfxScHb/TxsA4mMzw3nu2MKKryR4TQMnnr14RRUPPQ=;
        b=xGOMMZ55GIOsAD+A5n411RE5Y1ev5vPRC8kaA3yfFdeN9K76SmHx1gUSZOg1q9Z++T
         X7RFBrYc7Bxi77NvhlQIthJf2kEwwY5duUxTgleD41lsAcdCYsh0YC043UCvz0R1x7RP
         6y0K3YELMGjx5YeSkoPfk9S9rysoteVZxWRawxxIFyo02U9thdXpr8nm8OAO8hbBA9e4
         HwUZcy0Xi2wjb5oYVqJjageTMbkZFGt7XZIbmDNj5NFDuTf/z7Fq3IRlDzuamDOZeG7D
         5FCZmecL/IlaHa+Y9CHmsCbBo04NFe6UDaaT3HZYgKA6FSvh0kgca021hOl4aJCojrst
         /ehA==
X-Gm-Message-State: AOJu0YwvSrCBrKE/ukIWNzS759oth3Na1ow3iZG6Ftt+kTMCxdYWgPEO
	nt2e8fIsolLCB4C8TgbfoIWHUd1Yd/OHyIXOBaioAcyUe/0MTZNvdYNnvY7rNQ==
X-Gm-Gg: ASbGncswVLCZyEwlWoaElOyUtO86f5OzaYdRneX437wOnLDuLyXJHmKRyxWrSPbl1mz
	pb/VQ8r80TEbrZIIWsQlJl/GKov43NDiIY0AW+Dy04RXVzlDBMLiaN1iuQtTJzkX/wh+q7usFL5
	busyM/xyQTV4BWApeGhP87FOHpH3Jmt6nVUBGYmiuQ2+5/eOK136mgXIM7Unrt5IrZjkQnBM+UB
	F64dEWqTiiL4u63Z74waUmf91SffQMf7GK3h4k2Mh5JY6iPcurEMZOdY3/Uo1SitsXdKp8cAKb7
	OX5g7ra+Rfg/zG/dC/5VxPywqYpmYyGMJvxmZJT0zPcdx3GHpXO1pqQ7MZhUiM7F9BZZgCgYHw3
	Vd8ztqMlVS9y1MWk4q4cRKZsG/gIt1I8/HfSWEg==
X-Google-Smtp-Source: AGHT+IEE8RZQZh7gju27LW8VLVnsQ7+SjAuBMLB/4Aa7DWqEgIHJ+/ALP3U89k+ge96FamtFCkhsfw==
X-Received: by 2002:a05:6e02:19ce:b0:416:75eb:265e with SMTP id e9e14a558f8ab-420a4ee1eb0mr65146815ab.23.1757703316152;
        Fri, 12 Sep 2025 11:55:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.157.180])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-51202c9b8e3sm755987173.66.2025.09.12.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:55:15 -0700 (PDT)
Message-Id: <374740c678a62edd5cb5bace7517a36ce7ac00b5.1757703309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 18:55:08 +0000
Subject: [PATCH v2 3/4] doc: git-push: clarify "where to push"
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

Be clearer about what we're describing ("which repository" instead of
"what to push"), and start with a positive "try X, then Y, then Z"
instead of a negative ("if X is not specified..").

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index ec396b4cf2..909c69766c 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -22,10 +22,10 @@ DESCRIPTION
 Updates one or more branches, tags, or other references in a remote
 repository from your local repository.
 
-When the command line does not specify where to push with the
-`<repository>` argument, `branch.*.remote` configuration for the
-current branch is consulted to determine where to push.  If the
-configuration is missing, it defaults to 'origin'.
+To decide which repository to push to, Git uses the `<repository>`
+argument (for example `git push dev`), then if that's not specified the
+upstream configuration for the current branch, and then defaults
+to `origin`.
 
 When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
-- 
gitgitgadget

