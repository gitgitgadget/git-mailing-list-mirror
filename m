Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB971F462
	for <e@80x24.org>; Tue, 18 Jun 2019 15:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfFRPPN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 11:15:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45711 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFRPPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 11:15:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so14370731wre.12
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:date:to:subject:cc:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=1ab0InR24stCWrLVrQQxGqYiLg8XVU23ZNjHL3O2exU=;
        b=F8DKkNru31YVgK3fLJMAEg+ZgumIW4XUbsRNOzts5F8oQD9bKNwlJ7c5udd1SHJl8y
         IzvXmw90AxCA16jhFtudpGUIZlMaV4BZRiDvbSbr+PNk71TUw/Y/vQ3ZcueQE7Rq6Emo
         u5aTrXwqUHD/xtkNIRjJ5KAaExYu3YT4eUk4T2CPDGH4txpCUOM1xGZmJL5orc1MgUlU
         y5IUbXn7yyclcbxFVHx0XqLdaUPD8v58x05JPVhSGPn8BRo8aats+DjnX2pgP1fItwUZ
         PNQMfgTYq8IGwWK9qEaXnoKSWkzkXmImY3yKQOvaR3WthzrYLi8QbogaIDRjlLmGUhfx
         s2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:date:to:subject:cc:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=1ab0InR24stCWrLVrQQxGqYiLg8XVU23ZNjHL3O2exU=;
        b=Sl/0yORrY3FQo9xb5uPRzRzLkG0kD0/b9KXFFUtTYazQE1Fqc6umqRA19hgGCYK2iR
         L/aR7tm7rhx5z9/G+scszutGEhKqlOgfMOpZrbp1bZ1OTJWK9LfZNzpmYB/RfdMWJXaW
         EHSLNU/McKrfeOdg2tnT1MtG86peO22OB4sGffk6zDI4emLTLNdcyfvXmMJiVTg/0otU
         f/b2ORQ/lKaquLNQZ74xvR8LOX75Pow9nxk/BxR9U9POdfuuEJXres27PQxlQfirLrp4
         Or061Jb2P/iff7kispyofVHJeuhPXsirM4r+W5QaQ2CNZZdnGwWWY0BtGXW7V7NVMMlx
         8Udg==
X-Gm-Message-State: APjAAAUIv17BAc0t/z5gL8x4/eTB+LckHpvdz//iunaMkOCQ+Yo1j/sI
        JW48Ey4GrBl2uHmbnu+rvYs3E4mbrYo=
X-Google-Smtp-Source: APXvYqw2cSw7/isOp4GOOiSERArjBzUFyhjGtRef8CSsg3wkGqKTDKmq4APfv6ENJod/uYfkeLp2fQ==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr80752376wrr.70.1560870911042;
        Tue, 18 Jun 2019 08:15:11 -0700 (PDT)
Received: from pool-147-74-zam859.wlan.kfa-juelich.de ([134.94.60.226])
        by smtp.gmail.com with ESMTPSA id y6sm3176159wmd.16.2019.06.18.08.15.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 08:15:10 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <momo@pool-147-74-zam859.wlan.kfa-juelich.de>
Received: from pool-147-74-zam859.wlan.kfa-juelich.de (localhost [127.0.0.1])
        by pool-147-74-zam859.wlan.kfa-juelich.de (8.15.2/8.15.2) with ESMTPS id x5IFF9aV005588
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 17:15:09 +0200
Received: (from momo@localhost)
        by pool-147-74-zam859.wlan.kfa-juelich.de (8.15.2/8.15.2/Submit) id x5IFF8bg005587;
        Tue, 18 Jun 2019 17:15:08 +0200
Message-Id: <201906181515.x5IFF8bg005587@pool-147-74-zam859.wlan.kfa-juelich.de>
Date:   Tue, 18 Jun 2019 17:15:08 +0200
To:     sunshine@sunshineco.us, gitgitgadget@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] submodule foreach: fix recursion of options
Cc:     MorianSonnet@googlemail.com, gitster@pobox.com
References: <pull.263.git.gitgitgadget@gmail.com>
 <pull.263.v2.git.gitgitgadget@gmail.com>
 <c46e5bd1403b45d25192220ce689fcd55d897981.1560371293.git.gitgitgadget@gmail.com>
In-Reply-To: <c46e5bd1403b45d25192220ce689fcd55d897981.1560371293.git.gitgitgadget@gmail.com>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com> wrote:

I fixed the problem with the test case. Please take another look.

> From: Morian Sonnet <MorianSonnet@googlemail.com>
>
> Calling
>
>     git submodule foreach --recursive git reset --hard
>
> leads to an error stating that the option --hard is unknown to
> submodule--helper.
>
> Reasons:
>
> . Above call is internally translated into
>
>     git submodule--helper foreach --recursive -- git reset --hard
>
> . After calling
>
>     git reset --hard
>
>   inside the first first level submodule,
>
>     git --super-prefix <submodulepath> submodule--helper \
>       foreach --recursive git reset --hard
>
>   is called. Note the missing --.
>
> . Due to the removal of PARSE_OPT_KEEP_UNKNOWN in commit a282f5a906 the
>   option --hard is not passed to
>
>     git reset
>
>   anymore, but leads to git submodule--helper complaining about an
>   unknown option.
>
> Fix:
>
> . Add -- before the command to execute, such that now correctly
>
>     git --super-prefix <submodulepath> submodule--helper \
>       foreach --recursive -- git reset --hard
>
>   is called.
>
> Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
> ---
>  builtin/submodule--helper.c  | 1 +
>  t/t7407-submodule-foreach.sh | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 0bf4aa088e..afaf0819c9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>  		if (info->quiet)
>  			argv_array_push(&cpr.args, "--quiet");
>  
> +		argv_array_push(&cpr.args, "--");
>  		argv_array_pushv(&cpr.args, info->argv);
>  
>  		if (run_command(&cpr))
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 706ae762e0..c554589e6f 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'option-like arguments passed to foreach recurse correctly' '
> +  (
> +    cd super &&
> +    git submodule foreach --recursive git reset --hard
> +  )
> +'
> +
>  test_done
> -- 
> gitgitgadget
