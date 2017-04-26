Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E500207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 00:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1433584AbdDZAIT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 20:08:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34932 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1433581AbdDZAIS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 20:08:18 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so14186052pge.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pHqG2Ug/SNp08Nab2ot7cDod5ugrHMxE5pjkuHMBarg=;
        b=ZFgji7KVZxBH9hGqf1n6luh2WmKpgZie/uylrXj961Jt3SbaCqY1BpwCr4hAAq6H9j
         lfthYISMyITbu0OLmJ7iVghJkDlWJY8p1cZXhAV1+5ErqQXZUfGWUUjbtQpNnjOzH9UV
         tXql1NYMBrh1WDrAF6w+PLHa+43l+mCh1OMYA3JEZs01D+aHxJnQe4AzEhRjQiZ7Pb1D
         gIj6zSY8m+owIo2C8WkOQESSoaalLxCOuShvLFcTHTssIF+Vp1FHyqvJRTtn/kMK9FvE
         panumBgfJyfJbGsn768Ll6oEndb+KL6aFxDhgzk7XLLwF+OKbz3bilkW5DEc+nTtoFOS
         DoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHqG2Ug/SNp08Nab2ot7cDod5ugrHMxE5pjkuHMBarg=;
        b=she1cGOVb399B3nt+7kEs6EbAzGr5oXTsBiqp/3kjAA2hLuD6cKXqVxSeHETcU5KPC
         45bhs7nxbkGrdQmlzMz3+btLHFyJr5Ij9gQ5JWon1WPv3XQXlCcVLDKcNusuGyoseYyF
         DuggcTsBCjEubP4tFemUyoIaonLbmM57yqWiM2llkF+Bg6F1oorTzcgnPCqwCYzVDOI2
         dnLbbCw4H5S0qfRgc0ngpIBMTXKGbHKAFmqB4foDAm/8hkw11D8J7PaqN5ETU+TXi264
         R6/nlhaH8nX86naRvX0KsM3T7QV1RVfNFKTgBI8tZcndSKZ+AWCZKjmj6cQGNwAsXD7I
         r9ZQ==
X-Gm-Message-State: AN3rC/6kOAEXEQk5HQQZ3ZOMp2P1npKJSNlwNb7TZ2M4U3ahF+Puy77O
        XeIcr+FAy6JaFw==
X-Received: by 10.84.198.164 with SMTP id p33mr40539593pld.127.1493165263651;
        Tue, 25 Apr 2017 17:07:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id 30sm5725565pgx.14.2017.04.25.17.07.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 17:07:43 -0700 (PDT)
Date:   Tue, 25 Apr 2017 17:07:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        computersforpeace@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] sequencer: require trailing NL in footers
Message-ID: <20170426000741.GS28740@aiede.svl.corp.google.com>
References: <20170425190651.8910-1-jonathantanmy@google.com>
 <20170425235741.32546-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425235741.32546-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Reported-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
[...]
>  sequencer.c              | 11 +++++++++++
>  t/t3511-cherry-pick-x.sh | 14 ++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This is still pretty subtle (using the added newline that is added after
a non-footer to turn the invalid footer into a valid one), but

 * it is clear from the code that it will work correctly
 * the new test ensures we'll continue to support this case
 * it is understandable after a little head scratching
 * I'm hoping the subtlety will go away once the code learns to deal
   with ordinary non-footer text that has a missing newline

[...]
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -208,6 +208,20 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cherry-pick -x handles commits with no NL at end of message' '
> +	pristine_detach initial &&
> +	sha1=$(printf "title\n\nSigned-off-by: a" | git commit-tree -p initial mesg-with-footer^{tree}) &&

nit: Should this use a more typical sign-off line with an email
address, to avoid a false-positive success in case git becomes more
strict about its signoffs in the future?

Something like

	printf "title\n\nSigned-off-by: S. I. Gner <signer@example.com>" >msg &&
	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
	...

Thanks,
Jonathan
