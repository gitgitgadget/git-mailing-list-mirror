Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C6720248
	for <e@80x24.org>; Tue, 26 Feb 2019 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBZQhm (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 11:37:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55798 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfBZQhm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 11:37:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so3070719wme.5
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 08:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u3jI2kqZxEU19+7Yifooh0yDHrA9SgNDqUbfp21ISDg=;
        b=E64GbkIlnIRM8INO2S1bx/XpfWjBPA5zHc7STX5rBG8BiFMalnh9FJ1v3iZY/1lLe0
         d1mcEXaszStZm2mD3eC/yOEkBAiYZYxsk/6LUkMnVz9uwCasblj+ddxMJlm7GhHJtzc+
         2rFdqcZYRwgKdRPLCRwWTJ6Hi39SyeDmrjZoKZR1eUr1uZqGY/eTtVyqngBNQGKmiimq
         L21JiXD1WYg7kLsRJ76tSBTSs0gwjBmTOO5vJrBdOWW8krsuUHc0Sn82TErk9niyAMR7
         GKQgwNo5Hi9UoE4Ua24gcCzexwQqTtatemCm3JOk2o9LYLjHGKVJakvl7FfTDj0yMjeL
         sp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u3jI2kqZxEU19+7Yifooh0yDHrA9SgNDqUbfp21ISDg=;
        b=hhdFlpCa6v0L6KhkSocgrnbl75nW7qCon0cfsS16cFN6JkEt5jc3kp53xGN8XmzXlG
         E+JRmOkdFDSVOZ03QCnFV9NICZ8fc7sQ6mMCCgJzLl3OOpNB+CyYjYJ9iLbey4lbdwNH
         UxnA0FXnI62qQLOU/co4SPfgf5WbRk3BF2S7q9bcSjZRyyNwD/EI/x0pRyYB4UQpFby5
         9usA/hyfRr/XEVx1XCfkQ82fidjJekWZq9/2A+4/YSzhv8THnFZF50fuaVR1T8/JCJBX
         zloIu69Rq3zqwBN3+Jvdk8aSYVMr7AyQbzpgQJkNoSR4Q4ZZwqRy+OslEpD7qePi5i2O
         R98Q==
X-Gm-Message-State: AHQUAua2NiUkBvx7LDtU6G5D7fl+Ykygewra/aGfCGHyBP4SVP5hW6hp
        UC0aQSxsrjYpAjXtLYGDJko=
X-Google-Smtp-Source: AHgI3IYNwJ/HXT20a5TsaxIiA4MegOd0AuaUtZEYXOcm1SCTmUIPtwBVapq9nmVvqKsefje+vloyTQ==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr3166650wmm.103.1551199060114;
        Tue, 26 Feb 2019 08:37:40 -0800 (PST)
Received: from szeder.dev (x4db46559.dyn.telefonica.de. [77.180.101.89])
        by smtp.gmail.com with ESMTPSA id u17sm28264919wrg.71.2019.02.26.08.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 08:37:39 -0800 (PST)
Date:   Tue, 26 Feb 2019 17:37:37 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH v2 1/1] t3600: use test_path_is_dir and test_path_is_file
Message-ID: <20190226163737.GB19739@szeder.dev>
References: <pull.152.git.gitgitgadget@gmail.com>
 <pull.152.v2.git.gitgitgadget@gmail.com>
 <fcafc87b382dfef00d8e33e875bcb8b03d5667e4.1551191168.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcafc87b382dfef00d8e33e875bcb8b03d5667e4.1551191168.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi and welcome!

On Tue, Feb 26, 2019 at 06:26:09AM -0800, Rohit Ashiwal via GitGitGadget wrote:
> Previously we were using `test -(d|f)` to verify
> the presence of a directory/file, but we already
> have helper functions, viz, `test_path_is_dir`
> and `test_path_is_file` with better functionality.
> This patch will replace `test -(d|f)` calls in t3660.sh

We prefer to use imperative mode when talking about what a patch does,
as if the author were to give orders to the code base.  So e.g.
instead of

  This patch will ...

we would usually write something like this:

  Replace 'test -(d|f)' calls in t3600 with the corresponding helper
  functions.

> These helper functions make code more readable
> and informative to someone new to code, also
> these functions have better error messages

> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  t/t3600-rm.sh | 96 +++++++++++++++++++++++++--------------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)

The patch itself seems to be a straightforward application of

  s/test -f/test_path_is_file/
  s/test -d/test_path_is_dir/

so it looks good for the most part, but it has a few issues:

>  test_expect_success 'Recursive with -r -f' '
>  	git rm -f -r frotz &&
> -	! test -f frotz/nitfol &&
> -	! test -d frotz
> +	! test_path_is_file frotz/nitfol &&
> +	! test_path_is_dir frotz
>  '

These should rather use the test_path_is_missing helper function.

However, if the directory 'frotz' is missing, then surely
'frotz/nitfol' could not possibly exist either, could it?  I'm not
sure why this test (and a couple of others) checks both, and wonder
whether the redundant check for the file inside the supposedly
non-existing directory could be removed.


Furthermore, there are a couple of place where the '!' is not in front
of the whole 'test' command but is given as an argument, e.g.:

  test ! -f file

Please convert those cases as well.

