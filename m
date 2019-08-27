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
	by dcvr.yhbt.net (Postfix) with ESMTP id 181621F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 01:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfH0BjT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 21:39:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32959 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfH0BjS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 21:39:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id e65so7343743ywh.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 18:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ph3zp8COjo29PPGPlchCWM1mYjonWZr08TcJLynKNr0=;
        b=EVZM0S263SasedA8No1kcWYtxMqz329D0WNeOzExBcCSJPvNlyejHdMgvX8GtlM78R
         2qiU+zbic8PlJbUt8U3EEeurDk2n0yQEceuJBnDBwUlLuZF1JqL30mogWmDuYf9iXOUI
         0O3z9dCl6wFZ00iz1CabSaz82PzLTouaL0dTLcpRYKdiPwcc3OhNaB8Nh/Sn/0YaX4s/
         9vPPKG2qKbMlcy77lhpWybtmZZy2oMhAjU0tu6xChe/owGQ0cX+WOaLdoPGM97Gjq56x
         szWrhcU5+yp9O64iPnl3i8HlgSJZOOvntP6fAcJdjNUFcdXprH+52ojIj6eVK7O6kTEZ
         I+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ph3zp8COjo29PPGPlchCWM1mYjonWZr08TcJLynKNr0=;
        b=AwpFB+Xnq9XthchxxMBQ6eIkxjn7LpHHQ0YSljLgjpLYWzplIorCoM9agCOXEKYtlj
         4gdluNcA8bjNTDjCRBmoIE9Y8/xwsHxBqAHAm1PtfSqlamQWZJLwrozTO06NkGo9EIIx
         O1frV1x/pyBtzuecpYzF/m0fagTppGY3h1vtl48DJiVmD5jlK80b+ibpPSP9PaRmbRjl
         aieRCC36Got5h32gV+44fo3WjacsbSr8AQsPjaBt7AzHiZViXeSxv0+ZiMsZaJZqe3DA
         w1KdbhK+P1Ujo9mq0wPVI9mHCM2bMcVLieNAKGvzDE2y2N9YLMLKgJWMhxGpYVGzUEUD
         Dhcw==
X-Gm-Message-State: APjAAAUx38dTgeoP8B84Owm8QmgJyu/qxqC1KoHgt0lcnWarxBDgvVz5
        SNzgUEan2YDOas0RZFO0000=
X-Google-Smtp-Source: APXvYqy/GnPgwayVw/8wbssLlqYEdMJXfbL22riMgl8pu5YwIPZdWBbcLWjE7zPKnf6sOI/yCevqiA==
X-Received: by 2002:a0d:d989:: with SMTP id b131mr13643401ywe.374.1566869957694;
        Mon, 26 Aug 2019 18:39:17 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id g65sm3136780ywg.83.2019.08.26.18.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 18:39:17 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it
 elsewhere
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <922dbed9-3670-16b4-807c-ce68430ee591@gmail.com>
Date:   Mon, 26 Aug 2019 21:39:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190826235226.15386-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2019 7:52 PM, Elijah Newren wrote:
> Following up on the suggestion to make git.git smaller and shed non-core
> tools, here's an RFC series to do so with git-filter-branch.  This
> series first removes dependencies on git-filter-branch (of which there
> were very few), and then deletes git-filter-branch itself in the final
> commit.
> 
> I'm more than happy to consider alternate places for the filter-branch
> history (I had considered just merging it in with git-filter-repo), but
> for now I just made it available here:
>         https://github.com/newren/git-filter-branch
> 
> The rewrite above contains the history of the files deleted in Patch 5,
> plus a one-time copy of relevant build files (Makefiles, test-lib.sh,
> etc. -- I didn't want the whole history of these), and then touchups to
> streamline the build files and make them all work in this standalone
> repo.
> 
> 
> Some highlevel notes on the patches:
> 
>   * Patches 1&2: are good cleanups & performance wins regardless of
>     whether the rest of the series is taken

I agree! These are great. I just had a nit about extracting a helper
instead of copy-pasting the same three lines in multiple tests.

>   * Patch 3: an attempt to improve i18n situation for external scripts,
>     but discovered to not be necessary/useful for git-filter-branch
>     specifically

I'm not sure this is super-important now, but could be saved for a
later date, when it is important.

>   * Patch 4:
>     * If we are good with deleting git-filter-branch now and just noting
>       it in the release notes, then patch 4 could be simplified; there's
>       no need to update git-filter-branch.txt in that case.
>     * If, however, we want to do some external messaging for an
>       additional release cycle or two before moving git-filter-branch
>       out of git.git, this patch will help us until then to at least
>       avoid recommending a tool which will likely mangle user's data in
>       unexpected ways.  But it'd be really helpful if folks could review
>       and opine on the BFG stuff if so.

I think this is a good step, and should be taken even if we never
plan to take Patch 5.

>   * Patch 5: actually deletes git-filter-branch, its tests, and
>     documentation.

This is the one where others need to chime in with opinions. I
think this one can only be taken if we have a concrete plan about
how to support the tool _somehow_, even if it is "go download the
script from this place; it may have broken since we last tested it."

Yes, we want to strongly recommend that people use newer, better
tools. That's not always something users can accept. Having the
tool live somewhere that is accessible can appease some users for
a while, and it can decay and die a slow death there.

Thanks,
-Stolee
