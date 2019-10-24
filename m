Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90CB61F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 20:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfJXU3w (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 16:29:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34334 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfJXU3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 16:29:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id b72so94553edf.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M2458B7SVbu49FU/UbS7XZu5GBdsJw/XtAJSAHQCqn0=;
        b=jgEPSd4+rJYY9+NVdUlslfJE2XesKVgxU3tPwXMVXwFG2X/VrWPHh/isIjH6Yjf1mP
         25UsuEWtLnn2/WnGGE5xLStY39gkPLsyavF8mDpB5ONOUCyjEVAkIbal0vG8PyHoLhsB
         doiCMCW4LHjjhjC3VfHizEkgZh3a+7fgxsep5jutzcHsAzBPeB7tqlsgFKD2vzO3XFGT
         bbs+HvG0SdXhzedOPsr+89oCyKeBWZ6SQQpL8VesvylL9O+VEgRJSZ+hOtBCfrReM351
         xNw3c7A7XPyEgfp51YDMTedchyk1US16GhbCVMhLnhyb22RakhG9VvuLS+Vby3FsdtMJ
         Rlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M2458B7SVbu49FU/UbS7XZu5GBdsJw/XtAJSAHQCqn0=;
        b=IDD3gBUMNYdZCrGDx98grJulL7KudidRuam0voNDAtu42ha7PaO0JBRJPczSPpBe5L
         MBND7FZWhG3mufXaZn0awxLts0B4C9+HFNTNSwCR4jgHOzYYYvUBYBImZRkQu9vuFvlj
         kTdxu3n+Qj29YfmUy6gMFDjTsVY2zfzrEhGL9HZLLIT4fZ97y6eGc2h3Y/maPM84jQI0
         xp9/N2aXvZMDh7/bu183wCMTH422db/1/pTbKf/zUQ4YLh9U2qMP2C8GD62E69tT5h8R
         WHI0q/m2vKS3CcQofEOTzWFvXMjdLav1eMngfVM/qcDMqlOCDRnjrf2fjPB6/7MfU8j9
         gUOQ==
X-Gm-Message-State: APjAAAVpX3UoeYTQ2JVDYeImippRfhbneMljDFFiVwHUTnCb1L7074y3
        S2j09dcQWKHRZaxWp8yLC4c=
X-Google-Smtp-Source: APXvYqzB9NDH9UtxbI/TAVKcKWPcd9uego3Wie8r1cB5VDTdRU/+uzIl+umL4naHNAGsdYave/aEmA==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr62515ejb.206.1571948990616;
        Thu, 24 Oct 2019 13:29:50 -0700 (PDT)
Received: from szeder.dev (x4dbd3359.dyn.telefonica.de. [77.189.51.89])
        by smtp.gmail.com with ESMTPSA id f6sm862194edr.12.2019.10.24.13.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 13:29:49 -0700 (PDT)
Date:   Thu, 24 Oct 2019 22:29:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pretty: add "%aL"|"%al|%cL|%cl" option to output
 local-part of email addresses
Message-ID: <20191024202947.GN4348@szeder.dev>
References: <20191024125332.29958-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191024125332.29958-1-prarit@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Just a couple of test nits:

On Thu, Oct 24, 2019 at 08:53:32AM -0400, Prarit Bhargava wrote:
> +test_expect_success 'log pretty %an %ae %al %aN %aE %aL' '
> +	git checkout -b anaeal &&
> +	test_commit anaeal_test anaeal_test_file &&
> +	git log --pretty="%an%n%ae%n%al%n%aN%n%aE%n%aL" -1 > actual &&

Style: no space between redirection and filename, i.e. >actual

> +	{
> +		echo "${GIT_AUTHOR_NAME}" &&
> +		echo "${GIT_AUTHOR_EMAIL}" &&
> +		echo "${TEST_AUTHOR_LOCALNAME}"

Broken &&-chain (though with just a bunch of echos it won't really
make much of a difference)

> +		echo "${GIT_AUTHOR_NAME}" &&
> +		echo "${GIT_AUTHOR_EMAIL}" &&
> +		echo "${TEST_AUTHOR_LOCALNAME}"

All these variables stand on their own, so the curly braces around
them are unnecessary.

> +	} > expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log pretty %cn %ce %cl %cN %cE %cL' '
> +	git checkout -b cncecl &&
> +	test_commit cncecl_test cncecl_test_file &&
> +	git log --pretty="%cn%n%ce%n%cl%n%cN%n%cE%n%cL" -1 > actual &&
> +	{
> +		echo "${GIT_COMMITTER_NAME}" &&
> +		echo "${GIT_COMMITTER_EMAIL}" &&
> +		echo "${TEST_COMMITTER_LOCALNAME}"
> +		echo "${GIT_COMMITTER_NAME}" &&
> +		echo "${GIT_COMMITTER_EMAIL}" &&
> +		echo "${TEST_COMMITTER_LOCALNAME}"
> +	} > expect &&
> +	test_cmp expect actual
> +'
> +
