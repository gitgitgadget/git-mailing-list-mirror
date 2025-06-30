Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59F1DE4FF
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272721; cv=none; b=s5mtCJiyTo2A/HqTdUO2nubVUq2S4JUTvhr+Uw5di92W3VuMc9oJX7dZ01GX2MDnn/A+84GWOWuD7CMy2dxkJ7BzPJ3OU6mBz+FYmwaTNRBeFzOOGjaOEJYJe1fMmrlF4jSB6ueZ2bOaj53vFKcjGTBsgDP9wL29/CQFTHj7UIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272721; c=relaxed/simple;
	bh=Vpr5WoPO3M/MxPwIqMvnnQ1IcEiCXJwPanBnVoizRiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ju0m24q2RcuKvwL9XNTjlW32CsCVtb57XRrAPJoxZV0/NAz63FOZaHac8eYuBGGF09TD7e56P4JyW/a4dZWV7EoxryN22iCoZ98xbJOiuS6sHQzNE7gl7BmmILavt/HAh4HL5OtIBJAIY9KPG9B03+ppVOBm56h0Az08yjEizCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBOGFoX0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBOGFoX0"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso3718344a12.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272716; x=1751877516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNkJJQLZapShHWYzzakLNBH+zq/DJ3E+rG+hUd/in/k=;
        b=MBOGFoX07xyZvqDzop449xK6I0v/dU8YT56JF0OqqRkgKQ16Fe3hGz1VpHQD8wcYZZ
         wmTvyBzN5lhsjUw/+8uw7+Es9g26ln5B7hubERiWudXaa0hKowFuD7HHdXv+jTLAXuED
         lMhiMFUqaRod9/wHskxF0vbkALLgnNriBc8UJPI2dw+C29v9HmKqDK7HCZoTGrc0y4bg
         6kfzV52DmLzOnaaUYnaV+Va4uaBWVLZdfqjvq4ve/oM3jgZa1KFhTVlWviqCsCL6KH5O
         42xIa5TWaJkbP+jNz7W5MJYE9E1kGRhbH8ZwDxt8VA2g9+X8sFZkFBUbiORI8ArKn55O
         Di6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272716; x=1751877516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNkJJQLZapShHWYzzakLNBH+zq/DJ3E+rG+hUd/in/k=;
        b=mpmZHjsrXtgiZ26kVZ7aJ+A39HDj/3Org9smK1rQ6Mhz7UzvBvkVXZ8lgKcdKjAYfc
         /fCAMaLaD29O60SeL1y0HzYyC1khCY5jWY6lfe+usL43C0rb0vz2hmZ8NyBth8lleTtQ
         1MFBkNLj3kkQ1bmqLfxckzrxsPIZMZpM8Z6IX3X8QmGQ+ECxH9Kv/9+fRKebzYHuTVZM
         79lKvXnHPWq8ZT8jbRYSgmz/T5uC6GIBZjb5zHtIs1hgcVkL7ZI0W1VcND9DqqSyftTF
         nAvN0BVgWM54DNbH06VTtCcSEUdZXIR50FdR/hos7zOb2OTBZz/LfxlaacCa7Z38Ifup
         qLug==
X-Gm-Message-State: AOJu0YxS50K2ZPNLUW4TWLe4FnuWY/ogXutAOZf30WJOm9KASTG7KIB5
	VRIvVS5wSM0grTs1HCopSMrYmi3HWAyHHMPSrtor6tXkTLtMiqljxpT/
X-Gm-Gg: ASbGncvwxfhu6FsJAwOM6KEZo3wDtZXcafcg6Mr/vqVUJ41L4/QmMLzqAUd8CNlSZfG
	aEQurT2d4hkfY0BsDP1ScoqOQSVKYjdK1s+07vwnEtFfsowejqEjQYryfN4rq/eos6/+p8eMGtr
	K0p38F/hmnZroQ4wj6datb4t8DwUOOD13xw01JWScTo70IRAKNOcsU8IAJ11Uir1nZ6P1tfdAm0
	USCjhBQDhpGBKFR7QDvqE+3R30PSh431DE6uYOazUd23SWcUB9iDjYe3gBWEGbc5UEU23Xxx5ef
	AzyD7VeHVhh8fnKH71dKS8XQTa7e7S3PZZehurq7khTD2o6HVZ3r+0P7
X-Google-Smtp-Source: AGHT+IHyJpdCLGRK5ycr7DVJ9pERIiGPEbmfmZLWl0vORTtAaR4iHYBnaqyUD5xJV74F0jZgvXLuZA==
X-Received: by 2002:a05:6402:234f:b0:607:ec09:d462 with SMTP id 4fb4d7f45d1cf-60c88b2809emr10433698a12.7.1751272716180;
        Mon, 30 Jun 2025 01:38:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:cab2:9615:a476:665f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ca83610a1sm3413749a12.12.2025.06.30.01.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:38:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 30 Jun 2025 10:38:20 +0200
Subject: [PATCH v2 1/3] clang-format: set 'ColumnLimit' to 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-525-make-clang-format-more-robust-v2-1-05cbcdbf7817@gmail.com>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
In-Reply-To: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Vpr5WoPO3M/MxPwIqMvnnQ1IcEiCXJwPanBnVoizRiA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhiTQkizzUIcXvkJxIoXhXwwpsF5Z6i4MyNz
 rAp95My8S3Xz4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoYk0JAAoJED7VnySO
 Rox/p78L/jgXIW1k+3nHXxCQkJ9/z3tocfON2vyueHq1MCfijt2T+aO6nN2X95Vl8rAnDMTCWBu
 emoXNzeo4w5TFRZwmZX+DqZfy/v2ijUqvPekwP9+qaXS6VDErYqD8b0kCdxySGDHI4OADX7LXu/
 YxJownm5Lfc57djyJizqn6AuNA5mj5N+D9u1tWb0T8MlhMErV8rS+wSkzLAxaUEm0eOrx2eA9lr
 imtQwAlUgDciN8VXauMYO/2QD0Q3F7pGemoCX2wYFWsrTEg5O6HrH+8gja+Wz1xhpjSUB58UJEy
 9yRAIPXKNNxstoSKTfia7AqDtV61ZtgwpBCkaXkSWxIpC82bmr47j45raZBzaBkIVhv8e0WamEG
 LZkoj3QZJw2QoEZwSAy262X/OUfimaH7iwfDgXtJDL/bZODjWuOjJp1U+VLn4H4PAv3aKkrc036
 lG3EgXxZJYsDbFfEpPFoSoUTUJr9k2So5eB22jZerv0hxYX8uSoPHm3u9LkQ09pKME7xluuTI06
 yo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When clang-format was introduced to the Git project in
6134de6ac1 (clang-format: outline the git project's coding style,
2017-08-14), the 'ColumnLimit' was set to 80. This is inline with our
recommendation in 'Documentation/CodingGuidelines', which states:

  We try to keep to at most 80 characters per line.

However while this is recommended limit, this is not the enforced
limit. In some cases in we do overflow this limit to prioritize
readability. Setting the 'ColumnLimit' also means that shorter lines are
concatenated to simply as the result would still be below 80 characters,
which is undesirable.

In the past, we tried to adjust the penalties around line wrapping, once
in 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29)
and another time in 5e9fa0f9fa (clang-format: re-adjust line break
penalties, 2024-10-18). While these settings help tweak the line break
penalties to be more in-line with the requirements of the Git project,
using 'clang-format' still produces a lot of false positives.

So to make 'clang-format' more usable, set the 'ColumnLimit' to 0. This
means that line-wrapping is no-longer a concern of the formatter and
something that the user needs to take care of. The previous commit also
added a more flexible guideline to the '.editorconfig' setting a
'max_line_length' of 120 characters. This should provide some guidance
to users.

In the future, it would be nice to re-instate this limit with adequate
penalties which would follow our guidelines, but currently, it makes
more sense to have a working formatter which we can rely on and which
doesn't create too many false positives.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/.clang-format b/.clang-format
index 9547fe1b77..19d6cf4200 100644
--- a/.clang-format
+++ b/.clang-format
@@ -12,7 +12,15 @@ UseTab: Always
 TabWidth: 8
 IndentWidth: 8
 ContinuationIndentWidth: 8
-ColumnLimit: 80
+
+# While we do want to enforce a character limit of 80 characters, we often
+# allow lines to overflow that limit to prioritize readability. Setting a
+# character limit here with penalties has been finicky and creates too many
+# false positives.
+#
+# NEEDSWORK: It would be nice if we can find optimal settings to ensure we
+# can re-enable the limit here.
+ColumnLimit: 0
 
 # C Language specifics
 Language: Cpp
@@ -210,16 +218,5 @@ MaxEmptyLinesToKeep: 1
 # No empty line at the start of a block.
 KeepEmptyLinesAtTheStartOfBlocks: false
 
-# Penalties
-# This decides what order things should be done if a line is too long
-PenaltyBreakAssignment: 5
-PenaltyBreakBeforeFirstCallParameter: 5
-PenaltyBreakComment: 5
-PenaltyBreakFirstLessLess: 0
-PenaltyBreakOpenParenthesis: 300
-PenaltyBreakString: 5
-PenaltyExcessCharacter: 10
-PenaltyReturnTypeOnItsOwnLine: 300
-
 # Don't sort #include's
 SortIncludes: false

-- 
2.49.0

