Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDF920286
	for <e@80x24.org>; Wed, 13 Sep 2017 19:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdIMTUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 15:20:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33081 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdIMTUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 15:20:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id h4so462280pfk.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ujBLbNkBfYoLSzMeN0nCUo+o0bv1y/i09jiq/uVtfmU=;
        b=Ys9dGsjn0cYDzTkJx9crbg4RQSN8m0Fz1NMka26mMVr0Jw0LJ8OMqqhwAG1hp+LzAM
         ZfVhyPPuOAJAeStrbeZEZp03B8SYq924tZ9BIgHoVtsNMR4GQbMVppcvW0u5Ikb57nfB
         42AWMS9ScLD13xrTlNIyiMSh/7cgncKJo82q0d0N0eKq5EfuZXFZr6Velx7P3c2+brmV
         ZLngwqrJ45jv82JRJzpW2y5aMlVVAIPfgwXzKzudNywVKx08TsRWXRVit5wAsH6HAs41
         JU2bz60f2DqkKudyJMWSqe1YrpS+KeK1T/NXl8lmkd03vWkoDKi1XRw72mUxvDVJQHrs
         Ql4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ujBLbNkBfYoLSzMeN0nCUo+o0bv1y/i09jiq/uVtfmU=;
        b=r7qr4rkwioTf/WbC/iK5tTrIaaPWxpoUyHF1QbaCnVw8/GbHSUcrHzQs6gdb+1e5FE
         cHayymt9yJsBy/FgppN2+YtJP1tyKcnIlJ2nHng6GTojElhwe337PPl0DGSFVMSYYIMg
         wthFWsKq1B48WCStYSe49N6HRU/ne8Xzj7e6CRlyHFYjHkr4ayhu4QYFqZR+wJGkN5FA
         htLam9/w7IR6XUsZ8h9yw/bx6ffXBEaXKtHjAnhiAcYs4dL5F3UWl3ZzIpaOJ26LhxNI
         5Uy2XfO8rfSasSjXeJWEuxBkBWKne80qZvbL67CN5yJevj/zp9PsOwreUjGRK+EdDlow
         Wb3g==
X-Gm-Message-State: AHPjjUhXbmtlHgQoLrNtBjf3Sgc79wuJn8Tj57nUNl+IqeEe1HjjJjlS
        rcSa/HRh1QNK8g==
X-Google-Smtp-Source: AOwi7QDxy/G49s8CpLV00SlCMGTKNVUkkm92OvefwxbVWj468Aur9oxCUh8czCmyI5fzl2/YdQxMQQ==
X-Received: by 10.84.205.69 with SMTP id o5mr1950850plh.122.1505330441371;
        Wed, 13 Sep 2017 12:20:41 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id 22sm12441262pfb.31.2017.09.13.12.20.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 12:20:40 -0700 (PDT)
Date:   Wed, 13 Sep 2017 12:20:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: don't use ulimit in test prerequisites on
 cygwin
Message-ID: <20170913192038.GH27425@aiede.mtv.corp.google.com>
References: <b57731ed-4640-d27f-f7b2-6c70af8dd400@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57731ed-4640-d27f-f7b2-6c70af8dd400@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:

> On cygwin (and MinGW), the 'ulimit' built-in bash command does not have
> the desired effect of limiting the resources of new processes, at least
> for the stack and file descriptors. However, it always returns success
> and leads to several test prerequisites being erroneously set to true.
>
> Add a check for cygwin and MinGW to the prerequisite expressions, using
> 'uname -s', and return false instead of (indirectly) using 'ulimit'.
> This affects the prerequisite expressions for the ULIMIT_STACK_SIZE,
> CMDLINE_LIMIT and ULIMIT_FILE_DESCRIPTORS prerequisites.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  t/t1400-update-ref.sh | 11 ++++++++++-
>  t/t6120-describe.sh   |  1 -
>  t/t7004-tag.sh        |  1 -
>  t/test-lib.sh         | 22 ++++++++++++++++++++--
>  4 files changed, 30 insertions(+), 5 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

An alternative would be to do some more explicit feature-based test
like using "ulimit" to set a limit and then reading back the limit in
a separate process, but that feels like overkill.

Sincerely,
Jonathan
