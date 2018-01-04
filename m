Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D141F406
	for <e@80x24.org>; Thu,  4 Jan 2018 00:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeADAws (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 19:52:48 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40348 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeADAwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 19:52:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id f206so661708wmf.5
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 16:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :signed-off-by:content-transfer-encoding;
        bh=wUrQdtetHnvfwRkmIcIWzf1VvDYn3+5TUtJ+X+Oc4yI=;
        b=k4+49QYcEoiH5WCc3QaYIcvFOfn1dx7C/cis/1oIiJEYahxlvMnsqK4o5iEJnaEpm9
         YYkHYEtYGbVneQR4cMzcCbHHSaVcGr0nH6UOxjekEH3r1NFU0HmzhFOMQxSxglDobCuS
         XdXEEUXJ8thBfbfyJSB+l9fhkz/DxJaCpXDpymV1C0A5GGP8GSOZzzya+MgY8S4HLV/T
         TjFhkwb6wsS8/KovmAzbcPw5Ma0gK1F1X9jzpOHdqggID0GZmqUr2fmabvMAPBDkClxU
         27Y+7XgQSR9jS9L7IEVFZvlgQ2z7Sn0N9ttzGtfsmBoLwZnBM8/6TCbDwsXvTXu/hMf5
         IClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:signed-off-by:content-transfer-encoding;
        bh=wUrQdtetHnvfwRkmIcIWzf1VvDYn3+5TUtJ+X+Oc4yI=;
        b=tL9tNC7ramHsrF4Nv1g/S3q584iwWj5DvNcpjYfanY1K5zLoeO3UV+sPs+uhatyxgS
         v03dpXZkItkgj6OvmbReYFw5pocr5K6duW4/1LiFsAyYSXngti0hTC4VzOzukJinTNd+
         Y32+/BS2H+HdArWPznlaEHxT82jox7uLzmY0c1j1M5SWxyqI823gsjbalJamEw5ibHgV
         XhP5ztn+m4Jc28+D+k48GUfqDYVJ7i/vu0vd0g3F4vmKwIdGoNR9DrTr0oq5B3gp+bQr
         Q1EBbnjGiNmA0/eJrZK2l3l6U05BFISasu66odWVQYd9+/nKIXZwHniEzCM7dc08fYVQ
         mj9w==
X-Gm-Message-State: AKGB3mLbOnH33Vpo+LVg8Lo3uZKXh/1Iid20nqO9fgr6vuGTK00C0pOx
        YiyeifR6FMpz0enRNcwm7VY=
X-Google-Smtp-Source: ACJfBotCOnp819q5qEuDECcoPvjnYvOE4NRwMHDmmJJwep7huc3fIccUnPHTJqGbr0SskoqHqpKbFQ==
X-Received: by 10.28.136.66 with SMTP id k63mr2835959wmd.50.1515027166454;
        Wed, 03 Jan 2018 16:52:46 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id s86sm2220477wma.29.2018.01.03.16.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jan 2018 16:52:45 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5 13/34] directory rename detection: tests for handling overwriting untracked files
Date:   Thu,  4 Jan 2018 01:52:23 +0100
Message-Id: <20180104005223.13566-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.ge0c5f1248
In-Reply-To: <20171228041352.27880-14-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Signed-off-by: Elijah Newren <newren@gmail.com>
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> ---
>  t/t6043-merge-rename-directories.sh | 337 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 337 insertions(+)

> +test_expect_failure '10b-check: Overwrite untracked with dir rename + delete' '
> +	(
> +		cd 10b &&
> +
> +		git checkout A^0 &&
> +		echo very >y/c &&
> +		echo important >y/d &&
> +		echo contents >y/e &&
> +
> +		test_must_fail git merge -s recursive B^0 >out 2>err &&
> +		test_i18ngrep "CONFLICT (rename/delete).*Version B^0 of y/d left in tree at y/d~B^0" out &&
> +		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B^0 instead" out &&
> +
> +		test 3 -eq $(git ls-files -s | wc -l) &&
> +		test 2 -eq $(git ls-files -u | wc -l) &&
> +		test 5 -eq $(git ls-files -o | wc -l) &&
> +
> +		test $(git rev-parse :0:y/b) = $(git rev-parse O:z/b) &&

There is a test helper for that :)

  test_cmp_rev :0:y/b O:z/b

Note, that this is not only a matter of useful output on failure, but
also that of correctness and robustness.  A failing command inside
those command substitutions won't cause the whole command above to
fail, and if both 'git rev-parse' were to fail without writing
anything to stdout, the whole condition would still be fulfilled:

  $ test $(false) = $(false) && echo true
  true

I noticed that this patch series adds several similar

  test $(git hash-object this) = $(git rev-parse that)

conditions.  Well, for that we don't have a test helper
function.  Similar 'hash-object = rev-parse' comparisons are already
present in two other test scripts, so perhaps it's worth adding a
helper function.  Or you could perhaps

  git cat-file -p that >out &&
  test_cmp this out

I also noticed that all existing 'hash-object = rev-parse' conditions
came from you, so I would leave it up to you to decide which is easier
to work with and whether it's worth it.


> +		test "very" = "$(cat y/c)" &&
> +
> +		test "important" = "$(cat y/d)" &&

The 'verbose' helper could make conditions like these more, well,
verbose about their failure:

  verbose test "very" = "$(cat y/c)" &&

> +		test "important" != "$(git rev-parse :3:y/d)" &&

I'm not sure what this condition is supposed to check.

I'm not particularly well versed in the intricacies of 'git rev-parse'
operating on different stages of the index, but to my understanding
'git rev-parse rev' either outputs the object name pointed by 'rev',
or 'rev' verbatim if that doesn't resolve to a valid object.  IOW, it
would never output "important" and the condition would always be
fulfilled.
What am I missing?

> +		test $(git rev-parse :3:y/d) = $(git rev-parse O:z/c) &&
> +
> +		test "contents" = "$(cat y/e)" &&
> +		test "contents" != "$(git rev-parse :3:y/e)" &&
> +		test $(git rev-parse :3:y/e) = $(git rev-parse B:z/e)
> +	)
> +'
