Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88E2EB5C9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587595; cv=none; b=QpG4AZAd6EK/j4Ld/SH5Y0e7dF2mleH9ccl9xXxPznOPyUEpD5yhjqp7YYPTz73AJ/4ieswv4iUSSLguPC8Kz2xNBPpJgGKS4VtPV/iVarLcaZ0RqfQXBDWPcFfRqGkPZhKMJLasyFVn0VF9e2GrQ/z/vwKiP0cepB9YtGy+KFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587595; c=relaxed/simple;
	bh=lwwFbeObczUnPmqHvwyGeq4NSqx4saMddKIWdcD3JZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBRVVIvquiAalvH2J7N+DVK6gRaqGZI2dAfcXrVQvRMPtYuHDDaUtyrpFa8jzdPIJONO6GReMS6P1ejYvg026BJXrg+XuIPW8kE/MGdMeQ6EwX8SQYpban8IVw2wSqWSKZl+TfaySzW3Bm73+XLu+CkPQdp8KgWI8pRyp30xaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hunfsFOQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hunfsFOQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3343950f8f.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752587592; x=1753192392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hApIPVUE6jfAr3ZXMNSP5fGYykcytUX0jeoqFLayqLw=;
        b=hunfsFOQD0LM7BKz210y+Z960hJU3vqa7BErkg1ZLcpQZVyRfmhnqvIZKjWGmKwXj7
         sAiJk+7YAtSnua6rXWCmbcclePCPfACELHkqnHiT1NoufyNINWA5A+n6PpftpjRT7dEZ
         fQ6skyNIWDxSS5GYp+JIylttjuSoGIZwpm8HrZ1cqvdQ+AOqPJrsZFyI3sacgkaXe1DD
         mg7D0kQIap39/8nUvpv+pKUZpWINmKRFuHzMp8wF2govEN2gUQfqv1Y3UYSFiLrrYwJf
         xN96jCHZ4PdB6soqC6ExETtYOaZ3K3lnq2oRAuB46yPF5fEfAMp1V+l/XVumpgo9Xxyn
         cHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587592; x=1753192392;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hApIPVUE6jfAr3ZXMNSP5fGYykcytUX0jeoqFLayqLw=;
        b=gUzpsQjKpl1K+VpIVoeEA3/Ea8kJ5sUB6klSQODACIESpC643r+Iclpus4K6x2Z5HE
         gtQ1+LnSvT7GqRru/mn/uSzyQ2FE9hMvDh4UIuhBZqg5Gom5hxTZquOykmyMJ+3tNL1g
         UbTQVxPguUFIVGA3sXCB+NB/S+8qXeeOtMclwSniiHm3L53xlhFLG7Y6igcqkaqXbjGi
         2MHperewJufkGafWGuW19WFoTce0ZOmvmnqhn8+xWLMGajpZf2CvQLUC70FWeFD2q2z1
         d0P694RvTWAvCe8hGgDudn0cRrNC2AU03eF2/+obNajLnuQl+PYrd5KUVh2i8/OD32fj
         AXzA==
X-Gm-Message-State: AOJu0YwYhG+GY75J+Gduq3MkTTqNSdocxcZbpkgNZhf7JS0ozSnKWoSl
	D8d1quW5+CiYuxPWBMPgImn205SsmZgWBu+jxMTOWPat3aTJpVGRRGMrSCJIog==
X-Gm-Gg: ASbGncteIIM62R74+u6eABWOCIr0NmJBau55rIDcnisBNL5lTylX+B7z9H45Tc9Cubl
	kUBGqlolnwe+3HwMDgRY6zq+I/XcvXsCqHlj9oXZz4nfRx0c2JS66bwnb9lLSFBQzxNieFeTcGQ
	fyt8m4WvJM+YB6OdUfB0Zpby/q+RopltvYUh1F8+LSFwz8dyJDNZFF6DLaJaOkO6reGOvbd3jBF
	W6tIi2lA3ssfZIIR1POK5fCKbeWxLFTuXEw89nOdzme0gxe5xOBTvnJcMOzprqazGEo8RVubTEe
	AdDu4GTpQVwWip9QqzP7Hfw/eLzEZ9TzDrMQTucL+J7LrH1IRA1qXy1n9M7APi6IB1/LrrLsnaY
	ejW5d6QiBfMmpgxYHFkV5ynpDwjCZKHASkTLLbaLx7ewe
X-Google-Smtp-Source: AGHT+IGy9s2Il1FYWKe4NpQlycDDFjVeeOJ0yRv2MkEyf2Cm0skc+dW7GvW4bNKIcHj2wVhjqlFQ5g==
X-Received: by 2002:a05:6000:230b:b0:3a3:67bb:8f46 with SMTP id ffacd0b85a97d-3b5f18e80e5mr15070238f8f.57.1752587591803;
        Tue, 15 Jul 2025 06:53:11 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm15421112f8f.39.2025.07.15.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:53:11 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] C99: declare bool experiment a success
Date: Tue, 15 Jul 2025 14:52:49 +0100
Message-ID: <cover.1752587571.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We've had a test balloon for C99's bool type since 8277dbe987
(git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
2023-12-16). As it has been over 18 months since this was added and
there have been no complaints let's declare it a success and convert
the return type our other string predicates to match.

Thank you to everyone who commented on V1, the only change here is
to fix the typos in the commit message for patch 2.

Base-Commit: a30f80fde927d70950b3b4d1820813480968fb0d
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fuse-c99-bool%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/a30f80fde...669687147
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/use-c99-bool/v2


Phillip Wood (3):
  CodingGuildlines: allow the use of bool
  git-compat-util: convert string predicates to return bool
  strbuf: convert predicates to return bool

 Documentation/CodingGuidelines |  3 +++
 git-compat-util.h              | 12 ++++++------
 strbuf.c                       | 28 ++++++++++++++--------------
 strbuf.h                       | 12 ++++++------
 4 files changed, 29 insertions(+), 26 deletions(-)

Range-diff against v1:
1:  352f80c49b7 = 1:  352f80c49b7 CodingGuildlines: allow the use of bool
2:  a0f9182aa20 ! 2:  0b2402e11cc git-compat-util: convert string predicates to return bool
    @@ Commit message
         git-compat-util: convert string predicates to return bool
     
         Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
    -    to bool, 2023-12-16) a number of our sting predicates have been
    -    returning bool instead of int. Now we've declared that experiment
    -    a success lets convert the return type the case independent
    +    to bool, 2023-12-16) a number of our string predicates have been
    +    returning bool instead of int. Now that we've declared that experiment
    +    a success, let's convert the return type of the case-independent
         skip_iprefix() and skip_iprefix_mem() functions to match the return
    -    type of their case dependent equivalents. Returning bool instead of
    +    type of their case-dependent equivalents. Returning bool instead of
         int makes it clear that these functions are predicates.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
3:  7eaf8042061 = 3:  66968714739 strbuf: convert predicates to return bool
-- 
2.49.0.897.gfad3eb7d210

