Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA75204C1A
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790430; cv=none; b=Z8can40g3kLz3FMRiqT2+Z7d5b7tlKwqYjwtFXfqlD35lqzm5kMx7hlcwwL4dj7MvbW6Te7ivRW5YZxt4VQjjFlbCzLyw0pGbTuREwcY8M6iJn5SQ9+a2du9fPy8/s/wiB96Wbg5oHrk/ZCIblKvR4997F0oO9dNgWVjEZ1046c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790430; c=relaxed/simple;
	bh=JkghgAhXuUegyo6dtMBhNb9c4FT/HbjDpkMOxjmeRMU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=csoGqiAGBGfKdB8o/B6xjy9mMaA4EADK+pAUKT1b4JboRGDkGZBk1vKbWCkAZlRZS7dl39rsbSLO7n6VlO2GJgfVcWN4NAsNEyD+wH2FPPR7O/jFM3ZaxHatTVhpYhYaqeEhj5UJkFuvRNYMI9dcRrddCSMAPMraRWOFSlp9/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwqeZSUk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwqeZSUk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec61d0f65so59640066b.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 13:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790426; x=1739395226; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MSF0Ano+Z51jn73IkRIXqUwwuW46mDnHr4itvEWpYx8=;
        b=IwqeZSUkg0tOYheDXdmdVckUGri8sPrNFeeYeNfnX439msoxwu57j0yNg6UwMltzG3
         MASpiTvYEfeDCaSo0iVAJYopsbwpfdudXnJE0saA+qzfGIOu0YeCI2jq8FKRFWRKFRCu
         qNsleSj9gOBMGSdvB8piqDUgcVGfdp1G92aBI3Cc/RPNBDvJLGuArAOT8y9VUPI/CIb8
         zdCimeeI9LRBF8CQuZVRV2ezpBkvalm7V59zJpjA4WseWHzaNqlm4eI78pwmT9hkRQpo
         tZFb9S1nChmG7ftvNvBhqf3ow1dJNNh6hgunxeuTYkywyYEIIjZjzSGjDeggn0ULJ1YH
         3CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790426; x=1739395226;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSF0Ano+Z51jn73IkRIXqUwwuW46mDnHr4itvEWpYx8=;
        b=V89/FeG4iBQMJ5K4x5WfFZsUG2DKcyznaFEuvNRNFNe4z0N86QBHup+KEZIsl08IF8
         7+5EMQLepJtO9o1mjQm8fi+FgrI0g9A5WRdCA5MZPlFNj1VREPrPaMMaf4tjNPOSpjDn
         Y08ie7pJ/wUyclNvA6ZC7i/LTKBM6qRzjuJaG/oE3mtPRYlfXjgVeepK+aR1MaUb10JV
         6obOQN08nt4SaWvb4rmzlyks90GEDqX92NOhxQXRdngUqpbFgp8w1rFq8AHsRkdWCy+i
         GiAJDj4wC2a4dRqbpk2kR0J0p1JSsobEepsSsSYqeN2NtjPvBbelzxwJk24F4d0tbClK
         6Z4A==
X-Gm-Message-State: AOJu0Yy0E5h5U6GzEs8CMYBMKGcORMAMXwL0ISKzyUN/ibG/3tAenFex
	qZTAq7nLJJU0q0IxDOFBcOkPeL1sT0/5DKXJs/2QaoYKV0u80jjNalms6g==
X-Gm-Gg: ASbGncv9AZTAMEhSt65889SdatT8KS0dLP6MR+0MFJsmqjt+47rV37HpgdQi9hGdeyV
	Ptx4K2IdUZhEH9IZP3mU2LqEP3ZJ/SWepbTZB/EdRI9q6fvGANfx3Ibwpuqnn+5HCXjzH0lKc/o
	cUknC2Fh4FA4D8NC/wXY3HfFQvbUpJFzeUKlPSaioi7xguGt4Ahy9YuysXI/wo/WsqDr3fI0SmH
	ORLCZBKqJlx+Mv47amCTYLRERm9aL+vWxSDgPpzAyrbb0DuMxeYlJPIdXfyCQkqH9Wm54c1omj6
	fu904/WoxxyF2UHD
X-Google-Smtp-Source: AGHT+IFqeWV+nyrzVbpi1N2bDx2NnKu1P2w9OmeeYHv8fQU5ynd7LpbGHYXesjjCV5Tmq2f/QYTMzQ==
X-Received: by 2002:a17:907:7d90:b0:aaf:74d6:6467 with SMTP id a640c23a62f3a-ab75e347a2dmr474504266b.42.1738790426153;
        Wed, 05 Feb 2025 13:20:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d21aasm1158045766b.74.2025.02.05.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:20:25 -0800 (PST)
Message-Id: <pull.1885.git.git.1738790425046.gitgitgadget@gmail.com>
From: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Feb 2025 21:20:24 +0000
Subject: [PATCH] doc: documentation for http.uploadarchive config option
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
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
    Jeff King <peff@peff.net>,
    Piotr Szlazak <piotr.szlazak@gmail.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>

From: Piotr Szlazak <piotr.szlazak@gmail.com>

In Git v2.44.0 support for 'git archive' over HTTP protocol
was added, but it was nowhere documented how it should be
enabled in git-http-backend.
This commit adds needed information.

Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
---
    doc: documentation for http.uploadarchive config option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1885%2Fpszlazak%2Fdocument-http-uploadarchive-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1885/pszlazak/document-http-uploadarchive-v1
Pull-Request: https://github.com/git/git/pull/1885

 Documentation/git-http-backend.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index f37ddaded82..1dea4268520 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -56,6 +56,10 @@ http.receivepack::
 	disabled by setting this item to `false`, or enabled for all
 	users, including anonymous users, by setting it to `true`.
 
+http.uploadarchive::
+	This serves 'git archive' clients for remote archive over HTTP/HTTPS
+	protocols. It is disabled by default. It only works in protocol v2.
+
 URL TRANSLATION
 ---------------
 To determine the location of the repository on disk, 'git http-backend'

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
-- 
gitgitgadget
