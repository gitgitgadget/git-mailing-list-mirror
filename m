Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm/CH4n9"
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B5113
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 04:33:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso734841a91.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 04:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557199; x=1703161999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gqcnUdaHkI9uNCyTBp370Qe6IgwebSWcd3Ab8C3WfE=;
        b=nm/CH4n9gxOeSzdyplNRPI7QrDLNa6P+IZPcqOcroOLOs9S5gZMyT3fHWetXyLhGkG
         20UM/xmAvAxi/9lnIcmMwNWLX7oJY8/69MoH7guKszG6oZAHuoGPhtVHcfyS51ehk0RG
         ya8BWHtoA00NTCdjo+1BhMKU6c8I/URr2vcvQPtizXSuIycu+LqSaW/WDne3eJIFUtXY
         adBovLtwX92FB8NrpYKVDOQpslHVKWHcAArTGNgERt41aLhW2BcXQW2WUSVfJ4AnHDb+
         RDa42hlYCeAo9KSBSdch5MnbpMf9ns2qWs8AUF7cwNmOaOddFIR9LPxqlCJQu3AOEP07
         5qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557199; x=1703161999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gqcnUdaHkI9uNCyTBp370Qe6IgwebSWcd3Ab8C3WfE=;
        b=BxtjmQ8vIe6nTyBPUuobyYBphigyP5DG6t3rZI+Vy+EnCCPC0S1evh9yG3yaBjtnFa
         /lPPjyYHhaeggUH/xYSCZVWIefL0yntQ5biHa3F4SwTgHrTrUaOk93fuuBfSBgXRNsf0
         ZPYwOZBo0RwbS+9ZjFOlJOKw7PNwWFuyf3sTYze7e38sCBmsWa7kNdjNWqtf+KT5UDj3
         +ZWiLHf+9xAQicrYX39qwQTKoLE95wYRv7OCLCex0iSjtyYaCFowlcTg2S/NMZU1Lrcl
         pRMCazGaVq2apwUL+C2OYbh/M/h7h+f3G6/o1xdCWv8+wEf2lB45YwA5YBf9Sd9y9iu3
         m82Q==
X-Gm-Message-State: AOJu0YxsRaj1uRqTxFCDAXm5XKNZydkcOMYuYcxsnjXAYDfAN5AYShNC
	bquExAeiSRTCTJQBtq97FyyKuURAznE=
X-Google-Smtp-Source: AGHT+IFiddYVHgolwtqQSkooW0cwgYXuuPwrhc3F1MI9ZoFxHX3l9MQssy8D3G/ntP8/twoHDHfzJQ==
X-Received: by 2002:a17:90a:6fc5:b0:28a:f2cc:e008 with SMTP id e63-20020a17090a6fc500b0028af2cce008mr1057788pjk.54.1702557198826;
        Thu, 14 Dec 2023 04:33:18 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a734800b0028ae9cb6ce0sm3112368pjs.6.2023.12.14.04.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:33:18 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 0/2] jx/fetch-atomic-error-message-fix
Date: Thu, 14 Dec 2023 20:33:10 +0800
Message-Id: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

# Changes since v1:

1. Add a "test_commit ..." command in test case of t5574, so we can run
   test cases 4-6 individually.

2. Improve commit logs.


# range-diff v1...v2

1:  8c85f83e66 ! 1:  210191917b t5574: test porcelain output of atomic fetch
    @@ Commit message
     
             test_must_be_empty stderr
     
    -    Refactor this test case to run it twice. The first time will be run
    -    using non-atomic fetch and the other time will be run using atomic
    -    fetch. We can see that the above assertion fails for atomic get, as
    -    shown below:
    +    But this assertion fails if using atomic fetch. Refactor this test case
    +    to use different fetch options by splitting it into three test cases.
     
    +      1. "setup for fetch porcelain output".
    +
    +      2. "fetch porcelain output": for non-atomic fetch.
    +
    +      3. "fetch porcelain output (atomic)": for atomic fetch.
    +
    +    Add new command "test_commit ..." in the first test case, so that if we
    +    run these test cases individually (--run=4-6), "git rev-parse HEAD~"
    +    command will work properly. Run the above test cases, we can find that
    +    one test case has a known breakage, as shown below:
    +
    +        ok 4 - setup for fetch porcelain output
             ok 5 - fetch porcelain output  # TODO known breakage vanished
             not ok 6 - fetch porcelain output (atomic) # TODO known breakage
     
    -    The failed test case had an error message with only the error prompt but
    +    The failed test case has an error message with only the error prompt but
         no message body, as follows:
     
             'stderr' is not empty, it contains:
    @@ Commit message
         In a later commit, we will fix this issue.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/t5574-fetch-output.sh ##
     @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
     +test_expect_success 'setup for fetch porcelain output' '
      	# Set up a bunch of references that we can use to demonstrate different
      	# kinds of flag symbols in the output format.
    ++	test_commit commit-for-porcelain-output &&
      	MAIN_OLD=$(git rev-parse HEAD) &&
    + 	git branch "fast-forward" &&
    + 	git branch "deleted-branch" &&
     @@ t/t5574-fetch-output.sh: test_expect_success 'fetch porcelain output' '
      	FORCE_UPDATED_OLD=$(git rev-parse HEAD) &&
      	git checkout main &&
2:  d3184a9d0f ! 2:  6fb83a0000 fetch: no redundant error message for atomic fetch
    @@ Commit message
         will appear at the end of do_fetch(). It was introduced in b3a804663c
         (fetch: make `--atomic` flag cover backfilling of tags, 2022-02-17).
     
    -    Instead of displaying the error message unconditionally, the final error
    -    output should follow the pattern in update-ref.c and files-backend.c as
    -    follows:
    +    In function do_fetch(), a failure message is already shown before the
    +    retcode is set, so we should not call additional error() at the end of
    +    this function.
    +
    +    We can remove the redundant error() function, because we know that
    +    the function ref_transaction_abort() never fails. While we can find a
    +    common pattern for calling ref_transaction_abort() by running command
    +    "git grep -A1 ref_transaction_abort", e.g.:
     
             if (ref_transaction_abort(transaction, &error))
                 error("abort: %s", error.buf);
     
    -    This will fix the test case "fetch porcelain output (atomic)" in t5574.
    +    We can fix this issue follow this pattern, and the test case "fetch
    +    porcelain output (atomic)" in t5574 will also be fixed. If in the future
    +    we decide that we don't need to check the return value of the function
    +    ref_transaction_abort(), this change can be fixed along with it.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,

Jiang Xin (2):
  t5574: test porcelain output of atomic fetch
  fetch: no redundant error message for atomic fetch

 builtin/fetch.c         |  4 +-
 t/t5574-fetch-output.sh | 97 ++++++++++++++++++++++++-----------------
 2 files changed, 59 insertions(+), 42 deletions(-)

-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

