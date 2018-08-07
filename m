Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD322208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 17:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbeHGTuO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:50:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51457 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbeHGTuO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 15:50:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so18271501wma.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h6Jk1hXoaUErHjEvLUJuVcGHIFvs4Izsuk5WhJqoGpM=;
        b=AUpX0bNEbLgeEg/euzcSsrd3UAbNV6q04QLXduO4FqJd+hW8O3ADQqQL8YgBHHITHb
         s6uUOadB6ZaUYoXT/Jmof9isWi2LkBb3XE5sa3yRJSjTGl1XDqaHIAl8Jw3JvQW1eMON
         OYJANdPLLBzmDunXHpkiXDALtwe0nEHv+n+TXcEUPY7A8lvTmzmMAdrKxXE+HVV7z1dK
         k6Ap0yJNko2vAf8dK5ieQEJ6bHpAaayioN+N4xOUIsB5kXX2N3I4car4kWgzsXQhEwXk
         bqrOp9Q1r1JSuPRVkrxOmWW0wapG6SCpA30yZqtMtrGENUhRJ85hyHQE35mzC8BJh3zP
         R2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h6Jk1hXoaUErHjEvLUJuVcGHIFvs4Izsuk5WhJqoGpM=;
        b=dhxX81L9+q8ZGrX+x4De6gCtKSfLdyYnw+ZGmdUCtFX6UZs3HbBqelUYQ4h+e6v95X
         ln7h9/H7tCtHX27t5K8ygBizqNj3FNk7WUc5nHh9gc3RMxq1vgJob5YpBbsBUQGSJYkr
         Qcx9tgGjlh15caCC5YX22f4V6V9mDlI0RTRFjomhDBc8YFFVpHDDs2YWuP+uTCm/m3sS
         D8M0ua0cjhfpF+DkvHFWQZJqKMgyXMnfRgWKVe6fMfSJw8qXPfEUtLhsnZCkLwXHoX1V
         SFmi+MV7j0s0m3ixiDVuQdENmzlsavhjG0try4aj2gpMNFIdJUAzBV6mC3T7yENKCXlC
         ppew==
X-Gm-Message-State: AOUpUlEEOzJQo2D4H1MCi4gASjbMrQD1fwrrlKT2pgt+V3h31Wp+muK5
        KVAHR79YGoYImAG2bkkBGPo=
X-Google-Smtp-Source: AA+uWPzmTsAYG28wMsIUt2e9D7lywhxFjiqUAzrDoqtORz21Udllzz8EdfWLjxSc8jps7P7DDoVFyQ==
X-Received: by 2002:a1c:b609:: with SMTP id g9-v6mr2148889wmf.73.1533663289685;
        Tue, 07 Aug 2018 10:34:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 1-v6sm4211814wmf.47.2018.08.07.10.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:34:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCHv3 3/5] t7406: prefer test_* helper functions to test -[feds]
References: <20180806152524.27516-1-newren@gmail.com>
        <20180807164905.3859-1-newren@gmail.com>
        <20180807164905.3859-4-newren@gmail.com>
Date:   Tue, 07 Aug 2018 10:34:48 -0700
In-Reply-To: <20180807164905.3859-4-newren@gmail.com> (Elijah Newren's message
        of "Tue, 7 Aug 2018 09:49:03 -0700")
Message-ID: <xmqqk1p2krlz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> test -e, test -s, etc. do not provide nice error messages when we hit
> test failures, so use the test_* helper functions from
> test-lib-functions.sh.

Good explanation.

> Note: The use of 'test_path_is_file submodule/.git' may look odd, but
> it is a file which is populated with a
>    gitdir: ../.git/modules/submodule
> directive.  If, in the future, handling of the submodule is changed and
> submodule/.git becomes a directory we can change this to
> test_path_is_dir (or perhaps write a test_path_exists helper function
> that doesn't care whether the path is a file or a directory).

Yup, path_exists would be a good direction going forward.  If we
already have "missing" and use it in this rewrite, it may make sense
to introduce "exists" and use it at the same time here.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7406-submodule-update.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index c6b7b59350..ab67e373c5 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -174,7 +174,7 @@ test_expect_success 'submodule update does not fetch already present commits' '
>  	  git submodule update > ../actual 2> ../actual.err
>  	) &&
>  	test_i18ncmp expected actual &&
> -	! test -s actual.err
> +	test_must_be_empty actual.err
>  '
>  
>  test_expect_success 'submodule update should fail due to local changes' '
> @@ -619,8 +619,8 @@ test_expect_success 'submodule update --init skips submodule with update=none' '
>  	git clone super cloned &&
>  	(cd cloned &&
>  	 git submodule update --init &&
> -	 test -e submodule/.git &&
> -	 test_must_fail test -e none/.git
> +	 test_path_is_file submodule/.git &&
> +	 test_path_is_missing none/.git
>  	)
>  '
