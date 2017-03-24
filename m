Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A2920958
	for <e@80x24.org>; Fri, 24 Mar 2017 01:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbdCXB3R (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 21:29:17 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34327 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdCXB3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 21:29:16 -0400
Received: by mail-pg0-f53.google.com with SMTP id 21so523435pgg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 18:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=215g+9b8Qgc9fRaA+D+noWFn7ch2c9CZR5u56fWkqaI=;
        b=PjLO4XBHpzCpVWSY94xWgeZGTb+tDlbJx0ahElnveJmdBdH4yOpOQloZ8z86RpohDK
         C6W84xhEDEOnBqKLnzaCJjI8EwIOPQGGXbcro2lsljEw6QaIl67bUHUUaTLKueU74zdL
         +TI1sHLVonQZ83irSlxkKSDicyvY6Ox1KPWfwIlI+q4O1y5KTWT9LWDLe/KuuO1Yrrxv
         YPv0EMGFUH7A4Oi0zlJ4VZJ2w4IqKVlLbqpo9wJNaPB5onqGgwNCYoglXigtOactYxZJ
         fVQgykQmPtoirgVF/obRNQ4zcKFV2gA8YnazUdbBL7X7a5ikGY9EHWrLVJlPt4Z+l2O3
         KZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=215g+9b8Qgc9fRaA+D+noWFn7ch2c9CZR5u56fWkqaI=;
        b=ONmYh25Ubu6aOMojEl1KxyCToRrwsNcO/JouZAQNpz9xIpkpvkGfIZ2UKCOubwdkmw
         HuyYaSPUpMCOV2wSIzx4GF1CTia2L0VC+og6RGi2f1JPHYWOaD7wzYVn0dSvC/U5zYkB
         PS56a0HpWOK/ZfdpqoNuO18o5JwIT+Do5yn/8p+3S/q5vMvLXjGg3cqEtbG2W8U5ci/V
         wjGaM1rTbQGbGGdaG4mA2w6CN3Ov2x7AjDSVd26kT+dXbSISvZvG6uOBEhAvg0SP19Sf
         CmBjBqTTXdTNLRBHkaoZGijkEH/yLw41gM6mcSBOq1cmSkdrHdQ68sFD0ks5SfZWDyG5
         76UA==
X-Gm-Message-State: AFeK/H2j3PTEAclG5XtHWuwm1WjHJjbOdkP1LGX1hk8bCfXKJ44oDVdPBP2lo64owsY/VQ==
X-Received: by 10.98.57.23 with SMTP id g23mr6263234pfa.32.1490318954943;
        Thu, 23 Mar 2017 18:29:14 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id t70sm633908pfe.64.2017.03.23.18.29.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 18:29:14 -0700 (PDT)
Date:   Thu, 23 Mar 2017 18:29:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] tests: lint for run-away here-doc
Message-ID: <20170324012912.GH20794@aiede.mtv.corp.google.com>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <xmqq7f3ghhc7.fsf_-_@gitster.mtv.corp.google.com>
 <xmqqshm4fszt.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshm4fszt.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> We found a few run-away here documents that are started with an
> end-of-here-doc marker that is incorrectly spelled, e.g.
>
> 	git some command >actual &&
> 	cat <<EOF >expect
> 	...
> 	EOF &&
> 	test_cmp expect actual
>
> which ends up slurping the entire remainder of the script as if it
> were the data.  Often the command that gets misused like this exits
> without failure (e.g. "cat" in the above example), which makes the
> command appear to work, without eve executing the remainder of the

s/eve/ever/

> test.
>
> Piggy-back on the test that catches &&-chain breakage to detect this
> case as well.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I also wonder if we can use an "sh -n" style syntax check some day,
but that's likely harder.

[...]
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -624,9 +624,9 @@ test_run_ () {
>  		trace=
>  		# 117 is magic because it is unlikely to match the exit
>  		# code of other programs
> -		test_eval_ "(exit 117) && $1"
> -		if test "$?" != 117; then
> -			error "bug in the test script: broken &&-chain: $1"
> +		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
> +		then
> +			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
>  		fi

Neat.  Why the double-LF?

In some shells, the 3>&1 will last past the function call.
Fortunately, the $() substitution creates a subshell so this doesn't
affect anything later on.

test_eval_inner_ contains a warning not to append anything after the
commands to be evaluated, since whatever you append would pollute -x
tracing output.  Fortunately, in this context we have already set
trace= so the warning does not apply.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
