Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491BDDA8
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697801; cv=none; b=sDD1YfIzWvyU0Y0qgsr+Eagtat5Nlkro8KQ502tWImEsyDZo9giDbCG+jKwf409bY3cIongVo29smWeZYNRUQTfJIFnsqWWSivdphBFxAUcgxN+wL1dzaEwhdjoc72KuM/5buKpcnxChrq/7LMe7DM5Yfy3vj6ZOR30B1KMBgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697801; c=relaxed/simple;
	bh=WBd8H9hYxXfKpmltQjP6ULiPeizDgW28P2Asoi3Veec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mzvad7r3YtTLizpO0/zr106W4BSTLOmlLtVpPekHPBynI+H58wJFXmibC95cuNxKWNQDcsKTMLg5yaYljKN4TfF7hKeo0GQLDXqY96PjER+C4MRAOQjNvCjaxJbKb8S9t38hH9i9NpFinWbF59VNdmzANwV6rBGuCimOiYIE5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMWZhnQX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMWZhnQX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so179636866b.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728697798; x=1729302598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElC9X8k8PpnM/rlIQpBl01QQh0P6CX6rDaB7g4FF6vI=;
        b=lMWZhnQXxkJv7GuBDfs1KELmI0yPFLngmW9zQPAkYKIFa54g3bHh40+f0w5gacQwle
         4dmw/XlJUcF5i2fIhMYdiDnSotudU9Vx64RjCg4LDubQoS9lnEjxjpUJodx8IXve/HiX
         MOb5xnWwuna4aiOh8ipatZ3LJp/NnWkVc9sAVAMgFx0AMZEY1s9+Ibops8eYb4FeYG/B
         /87aQWyaxbHpWkNSrG63yJmGwIDnFPHhy7ImNL6kIgYsEBLFlpqr5Nb+5n6EU1j2fwQY
         4EPfS/FQXpDXB4b4olN1RZgdRHOaI3qbYQzhrLglliyDef/1zhdLTbNxhqA/tWIBedIw
         mJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728697798; x=1729302598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElC9X8k8PpnM/rlIQpBl01QQh0P6CX6rDaB7g4FF6vI=;
        b=cQwRIpsX0P9xboILGhaiPwZlYv0d4d0Fwl1P8eJudkFaR2VEKKWb9JBESG5C2iE732
         53Y0Ox0YF/o/9OpbyvxSTiFeHWInlVvErIQNEG/BGq09SRK+GtEGaAt7ALtvJXmXHgBS
         3BwZkBVAv/+3569ljHyIWGOQKfJip9O4hYvsSlsGMqWwDxtLi22eilUdiDomeK01P06U
         wz/S/MASNLQWMZg812PeSPtMuH8rbGfcj+aOoBgk8aIHxmlyfgCUgrUlm0BGOYRlcADT
         8dLfEvMJXKEdPJMzrR/jUshv61e4+EoeThmHTLMUWfE8VncNAwBqjFODAA2+0E7pBQtr
         2Yew==
X-Gm-Message-State: AOJu0Yx7XlmqyBKFKeTkzhTpw6rd6jtpOWJ5pv39jszHOujw9FwWtj9E
	iqWeofxCwUSe9xcUQTEV6b/M91Ab7sE59KlQQuJpLnZXQtGLXPiwvcOGWM9F
X-Google-Smtp-Source: AGHT+IEia3vuqVB8sOsbl00sdiTETJo66NSADv3VjTRYdNY9gpm4Lw4iMEouWKY5UbURzTLpp/qfwQ==
X-Received: by 2002:a17:907:c7d6:b0:a99:5629:b3ac with SMTP id a640c23a62f3a-a99b957e3b1mr366965866b.26.1728697797473;
        Fri, 11 Oct 2024 18:49:57 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bfc5esm273122266b.142.2024.10.11.18.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:49:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johannes.schindelin@gmx.de,
	spectral@google.com
Subject: [PATCH v3 0/3] clang-format: fix rules to make the CI job cleaner
Date: Sat, 12 Oct 2024 03:49:50 +0200
Message-ID: <cover.1728697428.git.karthik.188@gmail.com>
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
2. Don't align expressions after linebreaks to ensure that we instead rely on
'ContinuationIndentWidth'. This fix is rather small and ensures that instead of
trying to align wrapped expressions, we follow the indentation width.
3. Align the macro definitions. This is something we follow to keep the macros
readable. 

I will still keep monitoring the jobs from time to time to ensure we can fine
tune more as needed, if someone see's something odd, do keep me in the loop.

Thanks

Changes over the previous version:
1. I figured that we can keep the column limit to the previous 80 while still
having some breathing room by tweaking the penalties associated with line breaks.
Also CC'in Johannes here, since this builds on top of his changes.

Karthik Nayak (3):
  clang-format: re-adjust line break penalties
  clang-format: align consecutive macro definitions
  clang-format: don't align expressions after linebreaks

 .clang-format | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Range-diff against v2:
1:  e22ffbe0f6 ! 1:  74bbd2f9db clang-format: change column limit to 96 characters
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    clang-format: change column limit to 96 characters
    +    clang-format: re-adjust line break penalties
     
    -    The current value for the column limit is set to 80. While this is as
    -    expected, we often prefer readability over this strict limit. This means
    -    it is common to find code which extends over 80 characters. So let's
    -    change the column limit to be 96 instead. This provides some slack so we
    -    can ensure readability takes preference over the 80 character hard
    -    limit.
    +    In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) we
    +    adjusted the line break penalties to really fine tune what we care about
    +    while doing line breaks. Modify some of those to be more inline with
    +    what we care about in the Git project now.
    +
    +    We need to understand that the values set to penalties in
    +    '.clang-format' are relative to each other and do not hold any absolute
    +    value. The penalty arguments take an 'Unsigned' value, so we have some
    +    liberty over the values we can set.
    +
    +    First, in that commit, we decided, that under no circumstances do we
    +    want to exceed 80 characters. This seems a bit too strict. We do
    +    overshoot this limit from time to time to prioritize readability. So
    +    let's reduce the value for 'PenaltyExcessCharacter' to 10. This means we
    +    that we add a penalty of 10 for each character that exceeds the column
    +    limit. By itself this is enough to restrict to column limit. Tuning
    +    other penalties in relation to this is what is important.
    +
    +    The penalty `PenaltyBreakAssignment` talks about the penalty for
    +    breaking an assignment operator on to the next line. In our project, we
    +    are okay with this, so giving a value of 5, which is below the value for
    +    'PenaltyExcessCharacter' ensures that in the end, even 1 character over
    +    the column limit is not worth keeping an assignment on the same line.
    +
    +    Similarly set the penalty for breaking before the first call parameter
    +    'PenaltyBreakBeforeFirstCallParameter' and the penalty for breaking
    +    comments 'PenaltyBreakComment' and the penalty for breaking string
    +    literals 'PenaltyBreakString' also to 5.
    +
    +    Finally, we really care about not breaking the return type into its own
    +    line and we really care about not breaking before an open parenthesis.
    +    This avoids weird formatting like:
    +
    +       static const struct strbuf *
    +              a_really_really_large_function_name(struct strbuf resolved,
    +              const char *path, int flags)
    +
    +    or
    +
    +       static const struct strbuf *a_really_really_large_function_name(
    +                struct strbuf resolved, const char *path, int flags)
    +
    +    to instead have something more readable like:
    +
    +       static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
    +              const char *path, int flags)
    +
    +    This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
    +    and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
    +    few characters above the 80 column limit to make code more readable.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .clang-format ##
    -@@ .clang-format: UseTab: Always
    - TabWidth: 8
    - IndentWidth: 8
    - ContinuationIndentWidth: 8
    --ColumnLimit: 80
    -+
    -+# While we recommend keeping column limit to 80, we want to also provide
    -+# some slack to maintain readability.
    -+ColumnLimit: 96
    +@@ .clang-format: KeepEmptyLinesAtTheStartOfBlocks: false
    + 
    + # Penalties
    + # This decides what order things should be done if a line is too long
    +-PenaltyBreakAssignment: 10
    +-PenaltyBreakBeforeFirstCallParameter: 30
    +-PenaltyBreakComment: 10
    ++PenaltyBreakAssignment: 5
    ++PenaltyBreakBeforeFirstCallParameter: 5
    ++PenaltyBreakComment: 5
    + PenaltyBreakFirstLessLess: 0
    +-PenaltyBreakString: 10
    +-PenaltyExcessCharacter: 100
    +-PenaltyReturnTypeOnItsOwnLine: 60
    ++PenaltyBreakOpenParenthesis: 300
    ++PenaltyBreakString: 5
    ++PenaltyExcessCharacter: 10
    ++PenaltyReturnTypeOnItsOwnLine: 300
      
    - # C Language specifics
    - Language: Cpp
    + # Don't sort #include's
    + SortIncludes: false
3:  6ebcd2690e = 2:  1586d53769 clang-format: align consecutive macro definitions
2:  b55d5d2c14 ! 3:  36a53299c1 clang-format: don't align expressions after linebreaks
    @@ Commit message
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .clang-format ##
    -@@ .clang-format: AlignConsecutiveDeclarations: false
    +@@ .clang-format: AlignConsecutiveMacros: true
      #   int cccccccc;
      AlignEscapedNewlines: Left
      
-- 
2.47.0

