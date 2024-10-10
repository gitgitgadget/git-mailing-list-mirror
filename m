Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A61C1AB3
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583159; cv=none; b=q0vuai8jWH1ZdNAEzAPGZGad//cc3XpV1lzZ+BraFq81wJd/q4gGiVihUHhoEj4rKw0YvHBxh38Jrg3E12rCLuFI3Ma3cy5f2okj/g8YIhAb2j30huihirHsz5MILEdTRJ/f4VLqvYsOwX1BWMhHamdeGEq5NfwL6Cs9zHFXDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583159; c=relaxed/simple;
	bh=onFLVelbwibDHloU6+XDJFqTrNmOdOZvEuE7C85Zk6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLtUe+2MTRCktD+LMToKR+GAK7Fj5ZiLNa4WEiZ0CO4D3JCZDq4LKALx/7TzlZc9qJtPMxk/ydUHyM17iaOXpk/R6SosMfvMLzHtCa+i1poa5T3LmzfmTQxwkystr5pwFE9hDv8fDlZfG0PiFvGO9Il3lrRJeOkhSRbKWrQG2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk1OEN5m; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk1OEN5m"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53959a88668so1668261e87.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728583155; x=1729187955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHUXgpKFT7bhKdJKg/5is4AIszCSE8MFmF1d3kt+W/M=;
        b=Qk1OEN5mmIngYwFQUuy3tVYtVts3BPaAnbCXGkticZB5azUcTYnEukrW5QPFMPJ2yM
         kjsUTr7eHVuiY1f5TrtZwzqGeJCS51JyI1nY9jERrVDX2HlhD4FPagczqzkAbvh8ZBKm
         m/fk21+puNE4IW9KNyKlYZlNeLsjEexEKfCl+tS2NC4rljBxUcWSOvHZb3nDAv3YcQDt
         uvlAFvN18NyCiiVzg78xZR3KuvZ5HbCRlWJjJR0GodDVGI5L3ftV+P96H050ya+SxiRO
         Y1tccdKQf9aPD4bPwyH3WKDXxiIvgmePK16wIRh1HPZMQbh2ZoCNrA4OkQSBPxOqDduL
         x/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583155; x=1729187955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHUXgpKFT7bhKdJKg/5is4AIszCSE8MFmF1d3kt+W/M=;
        b=uZToeR3maKnPrGm9QmR4uyL1I+XXpWY7A9LZHl2SNk3/0cimSYxbY9zICrFsplCV4/
         IG1Otu8CYgPMXfahvjjXJzwqgoQJzPwkM2U7/8lzTIH/o1dUfy5/mII5XIispj8gFwoW
         ckE+ILvJdXaOZUHGbYeOG4+8xjCp4A2VbzCEQK7XCr+6TAKh+hhJSmkFqZJMdOizs8Nv
         bMV6EfB1WOhUSw/sSpJHNBCfrWXaWlgR5EoqGxaLEJ1kzGjPHS2kjrMJDFATUf1Jny71
         sGQQ9zC9e+pEyRjf5hwAOA0k8itWXtb3KDFMllJrhzMRI6uimvt0GLG8hKLdX1Ul43gu
         v9yg==
X-Gm-Message-State: AOJu0Yyu6A4AnN13E8JZpBm2WYi2+RAr8L9qYXLuoVzVJx3LMa8mkMQF
	lAttkXn2sj54SExnsH/1hjDFX/a3mmL5vR39LlxzknIxY72vxNhx
X-Google-Smtp-Source: AGHT+IH46zQBudHkc8l9HvdrCyzlPgictF+YnBKkEFaRxfSx/agvzT1B9BW4KtHC0AU5gK5sj3NDUw==
X-Received: by 2002:a05:6512:6cb:b0:52f:c148:f5e4 with SMTP id 2adb3069b0e04-539c489919dmr5105174e87.21.1728583154939;
        Thu, 10 Oct 2024 10:59:14 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372608f4sm1059995a12.70.2024.10.10.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:59:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com
Subject: [PATCH v2 0/3] clang-format: fix rules to make the CI job cleaner
Date: Thu, 10 Oct 2024 19:59:08 +0200
Message-ID: <cover.1728582927.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clang-format CI job is currently cluttered due to too many errors being
reported. See some of the examples here:

* https://gitlab.com/gitlab-org/git/-/jobs/7854601948
* https://gitlab.com/gitlab-org/git/-/jobs/7843131109

So modify the clang-format with the following changes:
1. Modify the column limit to 96 to provide some slack so we can make code more
readable and don't have to be constrained to 80 characters always. This is the
cause of most of the errors reported by the tool and should cleanup the reports
so we can actually focus on the real remaining issues.
2. Don't align expressions after linebreaks to ensure that we instead rely on
'ContinuationIndentWidth'. This fix is rather small and ensures that instead of
trying to align wrapped expressions, we follow the indentation width.
3. Align the macro definitions. This is something we follow to keep the macros
readable. 

I will still keep monitoring the jobs from time to time to ensure we can fine
tune more as needed, if someone see's something odd, do keep me in the loop.

Thanks

Changes over the previous version:
1. Change the column limit from 0 to 96, this way we still have a column limit
but provide some slack.
2. Add an example for the third commit.

Karthik Nayak (3):
  clang-format: change column limit to 96 characters
  clang-format: don't align expressions after linebreaks
  clang-format: align consecutive macro definitions

 .clang-format | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  34cd0c29f6 ! 1:  e22ffbe0f6 clang-format: don't enforce the column limit
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    clang-format: don't enforce the column limit
    +    clang-format: change column limit to 96 characters
     
         The current value for the column limit is set to 80. While this is as
         expected, we often prefer readability over this strict limit. This means
         it is common to find code which extends over 80 characters. So let's
    -    change the column limit to be 0 instead. This ensures that the formatter
    -    doesn't complain about code strictly not following the column limit.
    +    change the column limit to be 96 instead. This provides some slack so we
    +    can ensure readability takes preference over the 80 character hard
    +    limit.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ .clang-format: UseTab: Always
      ContinuationIndentWidth: 8
     -ColumnLimit: 80
     +
    -+# While we recommend keeping column limit to 80, we don't want to
    -+# enforce it as we generally are more lenient with this rule and
    -+# prefer to prioritize readability.
    -+ColumnLimit: 0
    ++# While we recommend keeping column limit to 80, we want to also provide
    ++# some slack to maintain readability.
    ++ColumnLimit: 96
      
      # C Language specifics
      Language: Cpp
2:  3557012fea = 2:  b55d5d2c14 clang-format: don't align expressions after linebreaks
3:  ad023a6cf6 ! 3:  6ebcd2690e clang-format: align consecutive macro definitions
    @@ Metadata
      ## Commit message ##
         clang-format: align consecutive macro definitions
     
    -    We generally align consecutive macro definitions for better readability.
    +    We generally align consecutive macro definitions for better readability:
    +
    +      #define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
    +      #define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
    +      #define OUTPUT_RAW_TIMESTAMP        (1U<<2)
    +      #define OUTPUT_PORCELAIN            (1U<<3)
    +
    +    over
    +
    +      #define OUTPUT_ANNOTATE_COMPAT (1U<<0)
    +      #define OUTPUT_LONG_OBJECT_NAME (1U<<1)
    +      #define OUTPUT_RAW_TIMESTAMP (1U<<2)
    +      #define OUTPUT_PORCELAIN (1U<<3)
    +
         So let's add the rule in clang-format to follow this.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
-- 
2.47.0

