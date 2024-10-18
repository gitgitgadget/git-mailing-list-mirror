Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279418EFDC
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241212; cv=none; b=KCSEa7TwBY997QbS8//dxPuXz64JVrvWm5r5bAxUGtAdgy1hYoF013SCXCH/wvuj8tCx2zXZ7A34i9NLv1U1xicP6NZAYaBw40ErTAKYfrkuDrkdoSpo49WVlF8XP9yJV5qERh4tYD1tEXZhOxOj1NTOdf1kEcs5F5iqtN9DaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241212; c=relaxed/simple;
	bh=ySZHEziCwma4aHXM01WWWZ5ees6nxtwmHvr+SrQyBqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtx7t7BdBIL/ik8E+H/uof9kyRCG/EGVJHPcoSS8k+cEVKOt+3pOwlGjFuLsReErQcrVObLgJOpXgTlCuHnJyXPYumQCFqBACK9nQ5fxhxY8slUiS3q1I71GgxoZGadTPAeZHSoaOdc40hqyyRu5RMpJNGkld23nCVjXObqpcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNIYGxjT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNIYGxjT"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99eb8b607aso184370966b.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729241209; x=1729846009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EbOgfYeEw+0ZUKV/EWdPP30oYeTwvFwi6cwRiK9b+E=;
        b=GNIYGxjT7BRhzY/qTBZmCekCrMj5BDa2jb64PEVfs8FHT3Tdwhzr/aUdBZKZD/ai+8
         Cfjve3wTYdEdTOIJAUu2dVF5bwFtccAjpR3Me7FfVUxPKhP674wY8A3bh/lfSk1RQh8W
         gfXb8Z/kboi5Rh+GgPslRy5p0FswIVE6S5q6DurOKKvMVQffKVPr7dKMvKvPqpy0VU+2
         hcenN9Dl/4HK4dYX7lHtlbpmFWuOOr25R5ibY7V/a1CsmqBNHf7jFdo0r07wCEENyq9O
         AnTLsw+YMiQsuhrcllLQtqXvFRL++CbhzcZdYxTVsEXyHW5/uuwWVuElEdk7QHRwDzt4
         /GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729241209; x=1729846009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EbOgfYeEw+0ZUKV/EWdPP30oYeTwvFwi6cwRiK9b+E=;
        b=fjNVSQXGRamZsiI8+qvjcPiL5J+Aecj3AQSeSzv0wBsDN47SjKToVHMokB4/Q47e8G
         6t74aJy8TrQ9Wp5SCxg/4HPE8kIdUqqhXb1SxbTBTkN9V3kbyRq4IoIQ+I6ZPZ12jqyB
         2xjqZUMLrmYGh2EhGYibxAaRNJBBpa+JAuJrQn72R97pHqY3ezectRfllcLvdZqrIg9r
         nDnZKkKcmlwAU/UtYU+2x4jqxHbG+WxjxiIcP20JZdZhi2pGcrwPQkUfidtURd2ISKEG
         4DO+NfAcICDefsLLA/J95uYP6mTCX3V/Yun9kFafXFqSrj087mS8hITggjhsFj9NxqmN
         T9Aw==
X-Gm-Message-State: AOJu0YyO+W/Ga1l6QKYx49jH4OM/B12kvNjuVYyeCxbcGNTHvauU18s3
	z8tTEPn/cqgXE5ljUm+zcxH9kgk/NuiJbRqJ+RuBIls6ETaL3dHkWmauWjGy
X-Google-Smtp-Source: AGHT+IH3woHieT+tQ9zFkh7RSEA8MYt5z4ta8TOCKfSJGRvp7DoZfxa+F4QZebYuKNSi3DcH63yDNg==
X-Received: by 2002:a17:907:94c9:b0:a9a:1e4d:856d with SMTP id a640c23a62f3a-a9a69a67e75mr126913766b.22.1729241209172;
        Fri, 18 Oct 2024 01:46:49 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8d9d9sm65596366b.44.2024.10.18.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:46:48 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	toon@iotcl.com,
	spectral@google.com
Subject: [PATCH v4 0/2] Subject: clang-format: fix rules to make the CI job cleaner
Date: Fri, 18 Oct 2024 10:46:44 +0200
Message-ID: <cover.1729241030.git.karthik.188@gmail.com>
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
1. Modify the penalties for linebreaks to be more considerate towards
readability. The commit goes into detail explaining how/why.  
2. Align the macro definitions. This is something we follow to keep the macros
readable. 

I will still keep monitoring the jobs from time to time to ensure we can fine
tune more as needed, if someone see's something odd, do keep me in the loop.

Thanks

Changes over the previous version:
1. I made the example in the first commit message a bit clearer so it is easier
to understand.
2. Removed the third commit, since I was convinced that it is good as-is for now. 

Karthik Nayak (2):
  clang-format: re-adjust line break penalties
  clang-format: align consecutive macro definitions

 .clang-format | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Range-diff against v3:
1:  74bbd2f9db ! 1:  a8c8df5d95 clang-format: re-adjust line break penalties
    @@ Commit message
         to instead have something more readable like:
     
            static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
    -              const char *path, int flags)
    +                                                                       const char *path,
    +                                                                       int flags)
    +
    +    (note: the tabs here have been replaced by spaces for easier reading)
     
         This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
         and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
2:  1586d53769 = 2:  fcf965ac74 clang-format: align consecutive macro definitions
3:  36a53299c1 < -:  ---------- clang-format: don't align expressions after linebreaks
-- 
2.47.0

