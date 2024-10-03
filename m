Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA80154458
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956730; cv=none; b=ha0JeDTGSYAswh+mC9uJs4XmA1HWWWMvxn7lteIP3j06owp+tgws+gXghpNUb0HdPgxIMKF8IjlfTQObBMkUTv/WeWf9B6h5pRDZVmmR4ETjXPCg3447QVXPE0LmnbQ1e9uYx+zuei5l46HIl0OFl9gjaBSwJbwiWOKAmDMmTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956730; c=relaxed/simple;
	bh=kMsxzJwQlXjdN9ALnzx/PANTP9SQS799boXGSOfaPdM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CdkbTF+di4aHenkxs+tEOOat52lBDx2POUJeSVjXTth9BW69xwzRdh3g+OfQREPtKoxq1sMg5sR4DMRrcleNxQY0a0a3cTee+al/+6BrdY+ew/yFn7N8HUvHTZF/OeJANaO2naIMmnafGIyjfmLOI4LGJQ7yxsF/tA4paTJYJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d61jWX7E; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d61jWX7E"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so1117971a12.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956727; x=1728561527; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw3O/v1CH9/heMAp8jbVePwD0pdMwb6lkVrKIie2NQg=;
        b=d61jWX7EI26AgLimaGW3o5eZMQvTXor0+mWAv9rrKDUBWTWyMqvFQfog+f4hneOaWq
         628n0GiGCGQRi2mKqCHstwuB/SxEeDmmnPKd9ww26SThC6SkO8MlRJozK9sbYY0j6AWc
         CdnjFTfZ8Ylp7w7NeKv4S5KnCpdmiecAp185j81UYMbEpZ2xwyhDe9JYTCZ8AivW7tgV
         yqKdlXbwXMxhE89GjKHfvBv8Sf0mbI+qPTpcT7d6pMSFpACDAzEEetd81H7Zwa8d6kwf
         7TDYGEA79ti1N23if/K/wuRRLd5UkKHBOIf/0U0qcScs4qIKV1CAApT6/nTWLL9sjk1Y
         MGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956727; x=1728561527;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw3O/v1CH9/heMAp8jbVePwD0pdMwb6lkVrKIie2NQg=;
        b=r7hWG8bxceC8RCGlYDmLi2ZVxMf/eLoXM5oYq523l/DiLJa5fypomp1h5MLrMWDUCB
         ICSVUxe18d2spbSd/4aDbllfkXBvRL5G+jPbvajngO8ZstjUifuD3Fi/uFc3qLq/zSjm
         wL+7PfoIliCwNKdCENmpkrYFKqgYi1MMPhTpq6vCyNj1+4CaIRyg+JVDNoTPKhHfsgbc
         1EnLMkhCSx9mxvBqHI2lGkP1QBY3kIs3atPIhR+wSMwQ3LXMXbjwpeHyp/h023mDYzYj
         jTXn8vwZiFOSjqEvi/C6r4719MdTt+dJsLx0v/elJqinsTFBUzJ2vB+T/ECTR4wiBeDb
         JF2A==
X-Gm-Message-State: AOJu0YyvcNKqwfzvqahIYLNSwMsAtzG8pToZ64KDhJroek4hNSegz2YC
	XiBvN5hDXgc+TII73oIsPCHjF7bHfu8pNuMt0G3YxrnJcnJrKRxxfkwIag==
X-Google-Smtp-Source: AGHT+IHczr7/+HOOKWqWBDgq5BOKekIOBv51RoPjFzmkLohkG6qOkuqH3rl+7fLamLUCcHuKn7goUg==
X-Received: by 2002:a17:907:989:b0:a7a:a892:8e05 with SMTP id a640c23a62f3a-a98f8269b77mr692919966b.33.1727956726420;
        Thu, 03 Oct 2024 04:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103bbb7bsm78185866b.140.2024.10.03.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:58:45 -0700 (PDT)
Message-Id: <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
In-Reply-To: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Oct 2024 11:58:41 +0000
Subject: [PATCH v2 0/3] line-log: protect inner strbuf from free
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>

This fixes a regression introduced in 2.46.0.

The change made in 394affd46d (line-log: always allocate the output prefix,
2024-06-07) made the method more consistent in that it did not return a
static empty string that would fail to free(), but it does lead to
double-frees when a strbuf buffer is freed multiple times.

In v2, I add Peff's test to the first patch. I also split his diff into two
more follow-up patches because the additional clarity seems valuable to me.
I have forged his sign-off in all three patches.

Note to the maintainer: feel free to take only the first patch, as Peff
replied that he may work on the remaining cleanup independently (but I had
already prepared patches 2 & 3).

Thanks, -Stolee

Derrick Stolee (1):
  line-log: protect inner strbuf from free

Jeff King (2):
  line-log: remove output_prefix()
  diff: modify output_prefix function pointer

 diff-lib.c          |  4 ++--
 diff.c              |  8 +++-----
 diff.h              |  2 +-
 graph.c             |  4 ++--
 line-log.c          | 16 ++--------------
 log-tree.c          |  4 ++--
 range-diff.c        |  4 ++--
 t/t4211-line-log.sh | 28 ++++++++++++++++++++++++++++
 8 files changed, 42 insertions(+), 28 deletions(-)


base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1806%2Fderrickstolee%2Fline-log-use-after-free-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1806/derrickstolee/line-log-use-after-free-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1806

Range-diff vs v1:

 1:  5d341e42d83 ! 1:  05c21616c35 line-log: protect inner strbuf from free
     @@ Commit message
      
          [1] https://github.com/git-for-windows/git/issues/5185
      
     +    This issue would have been caught by the new test, when Git is compiled
     +    with ASan to catch these double frees.
     +
     +    Co-authored-by: Jeff King <peff@peff.net>
     +    Signed-off-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## line-log.c ##
     @@ line-log.c: out:
       
       	while (range) {
       		dump_diff_hacky_one(rev, range);
     +
     + ## t/t4211-line-log.sh ##
     +@@ t/t4211-line-log.sh: test_expect_success 'zero-width regex .* matches any function name' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'show line-log with graph' '
     ++	qz_to_tab_space >expect <<-EOF &&
     ++	* $head_oid Modify func2() in file.c
     ++	|Z
     ++	| diff --git a/file.c b/file.c
     ++	| --- a/file.c
     ++	| +++ b/file.c
     ++	| @@ -6,4 +6,4 @@
     ++	|  int func2()
     ++	|  {
     ++	| -    return F2;
     ++	| +    return F2 + 2;
     ++	|  }
     ++	* $root_oid Add func1() and func2() in file.c
     ++	ZZ
     ++	  diff --git a/file.c b/file.c
     ++	  --- /dev/null
     ++	  +++ b/file.c
     ++	  @@ -0,0 +6,4 @@
     ++	  +int func2()
     ++	  +{
     ++	  +    return F2;
     ++	  +}
     ++	EOF
     ++	git log --graph --oneline -L:func2:file.c >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_done
 -:  ----------- > 2:  94d2c034b4a line-log: remove output_prefix()
 -:  ----------- > 3:  e1d825ad212 diff: modify output_prefix function pointer

-- 
gitgitgadget
