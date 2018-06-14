Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D541F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754758AbeFNRoC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:44:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43800 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754689AbeFNRoC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:44:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so7292398wrm.10
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UP/uuQiEkGrSGo4sp743E8XBB2cGOhvrr2NddVQ7DAw=;
        b=JJPsGVFZMNDfNNbpmBpww3+/xEl3Il14TTN1hhBxSE/4UTuATHU4pqcV491u4H9KXm
         y9E/R61XHnPyrlW/wfcbgntjqVbzmeiHqukPAJoG9EcQOyWOwoAN8kOh/4TjKP0BMHFY
         8XKlqlDad6zK6kdS1N+1cicPD4MTzOcXrNQfErBCqXwb9DhAMK7YQa7tSRkQ3KKSdxR1
         Y51otaj46rcavMGV0kb0eA+6/ST0zs3TrnWqhu2k+Tj7xMHjhhNZ4jm1JtXXpLIs2yK9
         d9hfW0ib3SAlxAeaXrsP3UM1qlc48O96jmEO3AJFYmY6wvTs7lKpVYe1+WzSMdjVIcsb
         fbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UP/uuQiEkGrSGo4sp743E8XBB2cGOhvrr2NddVQ7DAw=;
        b=pZ1Ol+VSyF6PO8fe7Vc1Qh3Cj02Y955Ona6xVn75+ht2g/5akV+06ZyNMFtKzhnJPC
         /NM8mZXTpyOOkn/aXegVS4o80tA32huRC1j0lxSyH3+wBMD/JdF/2uNSXv4+zLnbVcfr
         gD+djZBTYgnHmSogAhcngqe40eiK58rS0DLxpMzbNVkcXyqNZmI6fEKCpKtlnym6HJgR
         XIXou5arZhV1N83genvmw9EwdEJFb0TYSRtYEVRABgFVw/ZXLm0ruN2zZHmxhHgdF1Vu
         TIOUmHE3UillhZQDBn4yg44acQzlanDrU6cHg5P1ol4MrVAspdGnZ7YMUXcUaBVsKhbt
         81AA==
X-Gm-Message-State: APt69E3gd3OUGZxtsvUagAd9N3sDjojbQCDCSCbQbLjN4iLfKxrPdcwd
        nXQiVInAn44DQTQ0GkzzciQ=
X-Google-Smtp-Source: ADUXVKK/SXH8tkWwXvgo0LAuWSaTlSrJxNc34ht3X7LrWUfDvFeN/ZkRBUeSRCzK27wMKbFpGGuC2A==
X-Received: by 2002:adf:9dc9:: with SMTP id q9-v6mr3319397wre.12.1528998240583;
        Thu, 14 Jun 2018 10:44:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 201-v6sm9502828wmm.18.2018.06.14.10.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:44:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH] t3200: clarify description of --set-upstream test
References: <20180605112446.17016-1-szeder.dev@gmail.com>
        <20180614140641.13752-1-kaartic.sivaraam@gmail.com>
Date:   Thu, 14 Jun 2018 10:43:59 -0700
In-Reply-To: <20180614140641.13752-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 14 Jun 2018 19:36:41 +0530")
Message-ID: <xmqqin6l461s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Support for the --set-upstream option was removed in 52668846ea
> (builtin/branch: stop supporting the "--set-upstream" option,
> 2017-08-17). The change did not completely remove the command
> due to an issue noted in the commit's log message.
>
> So, a test was added to ensure that a command which uses the
> '--set-upstream' option fails and doesn't silently act as an alias
> for the '--set-upstream-to' option due to option parsing features.
>
> To avoid confusion, clarify that the option is an unsupported one
> in the corresponding test description.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  t/t3200-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The above description is much clearer than what the test title after
the patch gives its readers.

It is technically correct to call --set-upstream "unsupported", but
the reason why we want to see it fail is not because it is
unsupported, but because we actively interfere with the usual
"unique prefix" logic parse-options API gives its users and make it
not to trigger the longer-and-unique --set-upstream-to logic.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 6c0b7ea4a..d14de82ba 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -884,7 +884,7 @@ test_expect_success 'test --unset-upstream on a particular branch' '
>  	test_must_fail git config branch.my14.merge
>  '
>  
> -test_expect_success '--set-upstream fails' '
> +test_expect_success 'unsupported option --set-upstream fails' '

In other words, I am wondering if s/unsupported/disabled/ makes it
even more clear what is going on here.

>      test_must_fail git branch --set-upstream origin/master
>  '

