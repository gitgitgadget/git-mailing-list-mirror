Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E418E02A
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241213; cv=none; b=BicLLBajPwHf0n1aQmtd+ycFcJ8jCTOZcxyIbvV+o6nEIwfv419XgjM86OYRQPlkk/N7hSGKMLCWoYVKii8oQmhGMq3TASMd4e4Y41xgG+KiF8owFxxWcn3stA4YdCupbpq6kjC2I6MzIAidg0D0zyDl3A+FhiXqjhAwv++ybMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241213; c=relaxed/simple;
	bh=cjlJuT5A6U2QRwLqBJihPuXomtl5Jn7FhzdJ2ltwQ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVd7eS58Ga9gg2hY0BFZS2fHkfC1Q47KmCE+6q4w2QlXFMZx4f6I5Wpi+vP+/GHdd0DKQ9PHwjLRt5fMVvvKag9+wHMyc5NtoDS+nIH/qvUaPzatUV79GPwecGDPdaZaNUuegdl9LJ7RcA/RM72C8GzV05XB+EQ6sprGg8dy+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY7IvqA2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY7IvqA2"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a998a5ca499so232091466b.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729241210; x=1729846010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBzg43nLvVAFXDgJJPHJeVKFPtT+hMLoC4Ef1SciVlI=;
        b=AY7IvqA2EaJJF/bquwbkWrXa9WB4OdZhu8acNepf+Qc5L661ZYGl7SgAZFGVthIWOy
         jompneTE/jaFVOF7xsz2+5NIGE4DnK7qfh+rY/Dh17ZIkF3McXneDFbxPRGYqCMHytrd
         dJFroF694kvVpYdwOJmqKC14MLjJk0ZaE0vjKtZf8+SxK6Fe18Ga1CZH6PjOHUC54/Si
         5S/FKSxwq9z05Opl4X7EbCMGlW+zC0ESq0/tQzT0Sy2WFNkNPK5NABl27VGfdoSHfs0A
         ifeEhY8VxuI4wcfHDXqjbwcn90kIQVHRj6rY9Cd2yfjbUrcASWf3Sr2Te8Yta/PO1irr
         Scbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729241210; x=1729846010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBzg43nLvVAFXDgJJPHJeVKFPtT+hMLoC4Ef1SciVlI=;
        b=Rpx062qcsrSHulADuFISR3L8ulebCvPLYGEcoTlwgvnz5JJdT4FHKq+d9wOiO9TgVc
         J6piz2qU2OGvXwxjNBUfO2AMo2pueQa/HNMpEhFsjaGvPqUmm83AGPzNZ0dEwUaCCvhD
         6i6x9oDAXHPPRFSxdNHBRiOh5SQsQTv/UvpSDQp4kcQs7b2r920T4Knj5V2t5YVYW3Wy
         xPhbSJJx+3Lt8Gc4UlGRZF7AxwtsSyJvGnKhPCclA44oLhb0dNaRs8VGl3UfJ/BiFnmF
         yFAJPglSs3RevMzq+74Er3W7f4LjTvx0F6WO7QnmaPdTOyLEqAefv1mqcLkjBdnBng2H
         NNPQ==
X-Gm-Message-State: AOJu0Yx/ILJHSi5aSvVJCy2hVwxeroeVniW9+dwEBBW5RgH/aWcz3/Nu
	JNDRu/RcbfyfGGeogw/aaRRorCDZNQLjGs2oH2dOLpPnhXh5TsNHxbyK6ksk
X-Google-Smtp-Source: AGHT+IF8XRJUViiaLOcpjwK25/CBaNz+GXy+QD43/BlcfZb3aqssR9HsLlEWPnemO0E9tzHh8WVqtA==
X-Received: by 2002:a17:907:7293:b0:a99:ef5d:443e with SMTP id a640c23a62f3a-a9a69773b2emr140054966b.13.1729241209937;
        Fri, 18 Oct 2024 01:46:49 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8d9d9sm65596366b.44.2024.10.18.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:46:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	toon@iotcl.com,
	spectral@google.com
Subject: [PATCH v4 1/2] clang-format: re-adjust line break penalties
Date: Fri, 18 Oct 2024 10:46:45 +0200
Message-ID: <a8c8df5d95b0defec672ee139acd366219ea3302.1729241030.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729241030.git.karthik.188@gmail.com>
References: <cover.1729241030.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) we
adjusted the line break penalties to really fine tune what we care about
while doing line breaks. Modify some of those to be more inline with
what we care about in the Git project now.

We need to understand that the values set to penalties in
'.clang-format' are relative to each other and do not hold any absolute
value. The penalty arguments take an 'Unsigned' value, so we have some
liberty over the values we can set.

First, in that commit, we decided, that under no circumstances do we
want to exceed 80 characters. This seems a bit too strict. We do
overshoot this limit from time to time to prioritize readability. So
let's reduce the value for 'PenaltyExcessCharacter' to 10. This means we
that we add a penalty of 10 for each character that exceeds the column
limit. By itself this is enough to restrict to column limit. Tuning
other penalties in relation to this is what is important.

The penalty `PenaltyBreakAssignment` talks about the penalty for
breaking an assignment operator on to the next line. In our project, we
are okay with this, so giving a value of 5, which is below the value for
'PenaltyExcessCharacter' ensures that in the end, even 1 character over
the column limit is not worth keeping an assignment on the same line.

Similarly set the penalty for breaking before the first call parameter
'PenaltyBreakBeforeFirstCallParameter' and the penalty for breaking
comments 'PenaltyBreakComment' and the penalty for breaking string
literals 'PenaltyBreakString' also to 5.

Finally, we really care about not breaking the return type into its own
line and we really care about not breaking before an open parenthesis.
This avoids weird formatting like:

   static const struct strbuf *
          a_really_really_large_function_name(struct strbuf resolved,
          const char *path, int flags)

or

   static const struct strbuf *a_really_really_large_function_name(
   	    struct strbuf resolved, const char *path, int flags)

to instead have something more readable like:

   static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
                                                                   const char *path,
                                                                   int flags)

(note: the tabs here have been replaced by spaces for easier reading)

This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
few characters above the 80 column limit to make code more readable.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/.clang-format b/.clang-format
index 41969eca4b..66a2360ae5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -209,13 +209,14 @@ KeepEmptyLinesAtTheStartOfBlocks: false
 
 # Penalties
 # This decides what order things should be done if a line is too long
-PenaltyBreakAssignment: 10
-PenaltyBreakBeforeFirstCallParameter: 30
-PenaltyBreakComment: 10
+PenaltyBreakAssignment: 5
+PenaltyBreakBeforeFirstCallParameter: 5
+PenaltyBreakComment: 5
 PenaltyBreakFirstLessLess: 0
-PenaltyBreakString: 10
-PenaltyExcessCharacter: 100
-PenaltyReturnTypeOnItsOwnLine: 60
+PenaltyBreakOpenParenthesis: 300
+PenaltyBreakString: 5
+PenaltyExcessCharacter: 10
+PenaltyReturnTypeOnItsOwnLine: 300
 
 # Don't sort #include's
 SortIncludes: false
-- 
2.47.0

