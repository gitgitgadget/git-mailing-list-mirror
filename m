Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00EF1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 16:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIMVUq (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 17:20:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36934 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeIMVUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 17:20:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so2971170pgo.4
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b+wZqc7e795Uqfwn6zWM8YZaLLSY3pSpDonxA647UGU=;
        b=Mc3nQ/xM2r9mKGXCSDjL4TBJBHcinzeX/PsJedENArSkzazIiKw4F6mV/5bi59/RpR
         5u4NDhlIqWwdONsXddfCh+k3Rj3sVjXZxshyC7gEHNdKwzeBP0OinzPmfNa0XzJTnYde
         g6U66MlOToxgjVGHYPqT6/gW2W1N9Wd5MFHBXvba8XGNg9ICwrhZBklDg36evUV5q/9R
         xsk+kr7CJZjl2RAsSY+GS1N83IIsssHwwQoNMI3SVsahvx2tXN8ogeZzyaIVFnRZ8Uj/
         0J8AmBO9T2/CWarOBKCeEEGzuuj4KohP0OKByx4EoV3s2L7ccGftUNIKkMdTd8QP2/5F
         mFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b+wZqc7e795Uqfwn6zWM8YZaLLSY3pSpDonxA647UGU=;
        b=NuqwKBxgpYtrsC4icWimAaTilT8j6hJ614fnmO4JZSgJ5eLLfBLqmOXphrAi9lUevF
         bu09j8TNn/NBhL5OEiMLM6lKzzl6zGryIq5ZlFBl9lAQNh8EcfuqGlJSOcOCAPSZo3x9
         9YK3oxwk4PRRJo/1YPNU2/MFrtN6w1aHa0ZwrSxWDeIqXgjs58b8/saHXemN3W7xfbOh
         7NdgzNaYMhEkt3/iij5FSyeumtFsTd3fUJBMiUzkZlRw+rXsKDgG8j01/Hdf6+r5jCto
         kPwnLp4SnH1wjyn5pspVDfqK6hZ8QcTq5jk13nSvg9yT74OxsCfeRtbVEwUv7t6yHQCl
         rnjg==
X-Gm-Message-State: APzg51DeYfDUYuthD9uVomYIiiVkE+gCBkkisfoTBEachFRTtLimgL/l
        PI7kVAUmHcy+wcGwUbXSigFSlW9s
X-Google-Smtp-Source: ANB0VdZBQc2UrkNimcRG+/Dh2KigON+f8jG042XxxK6tgTHaSIy2AXLAMSI4LCd7Ed8OAb19tyA8Nw==
X-Received: by 2002:a63:4702:: with SMTP id u2-v6mr7573591pga.95.1536855035051;
        Thu, 13 Sep 2018 09:10:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z6-v6sm6764591pgr.41.2018.09.13.09.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 09:10:34 -0700 (PDT)
Date:   Thu, 13 Sep 2018 09:10:34 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 16:10:30 GMT
Message-Id: <pull.39.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.39.git.gitgitgadget@gmail.com>
References: <pull.39.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Properly peel tags in can_all_from_reach_with_flags()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Peff reported [1], the refactored can_all_from_reach_with_flags() method
does not properly peel tags. Since the helper method can_all_from_reach()
and code in t/helper/test-reach.c all peel tags before getting to this
method, it is not super-simple to create a test that demonstrates this.

I modified t/helper/test-reach.c to allow calling
can_all_from_reach_with_flags() directly, and added a test in
t6600-test-reach.sh that demonstrates the segfault without the fix.

For V2, I compared the loop that inspects the 'from' commits in commit
ba3ca1edce "commit-reach: move can_all_from_reach_with_flags" to the version
here and got the following diff:

3c3
<                 if (from_one->flags & assign_flag)
---
>                 if (!from_one || from_one->flags & assign_flag)
5c5,7
<                 from_one = deref_tag(the_repository, from_one, "a from object", 0);
---
>
>                 from_one = deref_tag(the_repository, from_one,
>                                      "a from object", 0);
14a17,22
>
>                 list[nr_commits] = (struct commit *)from_one;
>                 if (parse_commit(list[nr_commits]) ||
>                     list[nr_commits]->generation < min_generation)
>                         return 0; /* is this a leak? */
>                 nr_commits++;

This diff includes the early termination we had before 'deref_tag' and the
comment for why we can ignore non-commit objects.

[1] 
https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u

Derrick Stolee (1):
  commit-reach: properly peel tags

 commit-reach.c        | 33 ++++++++++++++++++++++++++-------
 t/helper/test-reach.c | 22 +++++++++++++++++-----
 t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++--
 3 files changed, 71 insertions(+), 14 deletions(-)


base-commit: 6621c838743812aaba96e55cfec8524ea1144c2d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-39%2Fderrickstolee%2Ftag-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-39/derrickstolee/tag-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/39

Range-diff vs v1:

 1:  948e222228 ! 1:  4bf21204dd commit-reach: properly peel tags
     @@ -36,9 +36,17 @@
      -		if (parse_commit(list[i]) ||
      -		    list[i]->generation < min_generation)
      -			return 0;
     ++		if (!from_one || from_one->flags & assign_flag)
     ++			continue;
     ++
      +		from_one = deref_tag(the_repository, from_one,
      +				     "a from object", 0);
      +		if (!from_one || from_one->type != OBJ_COMMIT) {
     ++			/* no way to tell if this is reachable by
     ++			 * looking at the ancestry chain alone, so
     ++			 * leave a note to ourselves not to worry about
     ++			 * this object anymore.
     ++			 */
      +			from->objects[i].item->flags |= assign_flag;
      +			continue;
      +		}
     @@ -187,7 +195,7 @@
      +	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
      +	test_three_modes can_all_from_reach_with_flag
      +'
     -+	
     ++
       test_expect_success 'commit_contains:hit' '
       	cat >input <<-\EOF &&
       	A:commit-7-7

-- 
gitgitgadget
