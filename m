Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7CF1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 15:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633071AbfJRPV0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 11:21:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46749 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389421AbfJRPV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 11:21:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so6667444wrv.13
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eZHHUtagNmYDVOtBPLyrNxU2j/zOoKbMVKDghFLOzjk=;
        b=A2oAsi6RBcs85DN+xgUrQnfCPzFPlyZdaQunwmD/3XbsoXN6y3HuFqmhPKXo14xfQM
         Ut4FPntYz2O3sgV3k+vfazJHBRQJl2cRVdiJeRHOFOejiwszJTlI8osE0PhejGBcVp/w
         DvHU2ZypUxsWtb4HGIcyKRB9oQaA/01kIqogsZxHnXYW01JHJmQ8tz73tZ/9Vt0uDvg9
         KJwo136hmXy5DKMQjp/+2BPTlAQPUq4owF4xBiyJ0DvgmR4rtw2hhOu38/NWjjB1h+kj
         +mX+RhWAksrJQpINr0Ve8xaCN3Db1YZ6El/zfqdc+4LBmveGtmopGdcyJYdLXhbjNOvf
         oSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZHHUtagNmYDVOtBPLyrNxU2j/zOoKbMVKDghFLOzjk=;
        b=n0YqtxqNHcvCy2Iy74dahFX6x9JgpUsYd1EAeVhqpcxXH8N/nZo0QXc8YrRsd1kCb+
         ISOiEo9SJQMMP4PnQaaJOXAfeSur0qd0poVhR5lNmsuITi2oQAai6fnMozpF0dBARWvI
         YklITryYsbztuNqY8CjMsMH2E+zMuJ4Wa4WIWVX0V0rvaNLSb7x3MUr1bBaJf5AYndvX
         UMeiE2O8iZrI/bq0pShToyEAy2e/T2lj6D1NZRUPZND0Ds9pkihA5LbtoQf/JWdGyfpx
         zW4BZw4GACkcxne3FQeOZHBayVjH3sZSnYsdFvz72XB+8PSC6+EwpsI6QFbQt+pU7eds
         Jeiw==
X-Gm-Message-State: APjAAAVMkt+sVyAlqNVQlaBYTgPEPgkVwZJObUdjswgELVJb2xVZ1bFI
        6xPYbnQl+sPzUwmcDPRo7BDp25gP
X-Google-Smtp-Source: APXvYqxb84qEtFr7GGsuDP76wCKLAPlNYyOFLEUGsiNFcLrkkjwD2XvdbGMnSbcMblWRWaVjqmU6/A==
X-Received: by 2002:adf:f010:: with SMTP id j16mr8502780wro.317.1571412083939;
        Fri, 18 Oct 2019 08:21:23 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id q19sm7432195wra.89.2019.10.18.08.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:21:23 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:21:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH v3 07/13] graph: example of graph output that can be
 simplified
Message-ID: <20191018152121.GE29845@szeder.dev>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
 <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
 <631ee3cecb68d9f776d4a8fb30c1bca70797ba14.1571183279.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <631ee3cecb68d9f776d4a8fb30c1bca70797ba14.1571183279.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 11:47:53PM +0000, James Coglan via GitGitGadget wrote:
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> new file mode 100755
> index 0000000000..4582ba066a
> --- /dev/null
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +
> +test_description='git log --graph of skewed merges'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
> +	cat >expect <<-\EOF &&
> +	*   H
> +	|\
> +	| *   G
> +	| |\
> +	| | * F
> +	| | |
> +	| |  \
> +	| *-. \   E
> +	| |\ \ \
> +	|/ / / /
> +	| | | /
> +	| | |/
> +	| | * D
> +	| * | C
> +	| |/
> +	* | B
> +	|/
> +	* A
> +	EOF
> +
> +	git checkout --orphan _p &&
> +	test_commit A &&
> +	test_commit B &&
> +	git checkout -b _q @^ && test_commit C &&
> +	git checkout -b _r @^ && test_commit D &&
> +	git checkout _p && git merge --no-ff _q _r -m E &&
> +	git checkout _r && test_commit F &&
> +	git checkout _p && git merge --no-ff _r -m G &&
> +	git checkout @^^ && git merge --no-ff _p -m H &&
> +
> +	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&

Please don't pipe 'git log --graph's output, but use an intermediate
file instead:

  git log --graph ... >out &&
  sed s/// out >actual &&
  test_cmp expect actual

The exit code of a pipeline is the exit code of the last process in
the pipeline, and the exit codes of processes upstream of a pipe are
ignored.  Consequently, if 'git log --graph' produced the expected
output but were to fail during housekeeping before exiting (segfault,
double free(), whatever), then that failure would go unnoticed.

This applies to several (all?) new tests added in this patch series as
well.


I'd like to join the praises from others: this is one excellent
first-time submission, thanks.


