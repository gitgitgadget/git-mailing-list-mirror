Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2728AC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 09:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbiF1JNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbiF1JNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 05:13:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F010FD9
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:13:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so4628400wmi.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cddJFtEtKdlcT15DRleTmAhSwKX+753QKhUJroZG4UQ=;
        b=f9UOdhb78w9pwIVHxCRCob3E5b7m9vdsF8C+AoB0keQI4L5ohR9dDUTknLeORKcbzm
         Q8VVapVc5PKeHdR7pl6ikk/q1M+b+CxxILKcq6wW4c9M/itf/MD2E6WCB7lCyXByIwLQ
         VPYEPk+EF4TvTxBFbr3IcRT8t1lxGQHPWWkWSbeWVfKkcGvCfWenC+womLlqdw8QgeAr
         CTa4QOxLOMgFa/wB8XbWk0t8ovJY4UGiySsaX1rQfBD83KWhmh+nEFW/tcoI47w0zJnd
         3euZQpDiNVZ+NUiwOuOf6xDvFWhpBg3H/ob3vTnufZzbKa4wZz3AziB74G1BVgeRr5V9
         I2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cddJFtEtKdlcT15DRleTmAhSwKX+753QKhUJroZG4UQ=;
        b=StSEqro4+b8bA1VMwix3t28qn9Ls3HllN/5qeZg6yZgQiGIvVyFN3bxdcJE2aCIEsy
         SOkMnO/ZF+WSt9nEYz+vdabuiPICjnl3ElKyB9oW5LtltZhwA0Lqxexp4iQQjOKWAg+g
         oQyMtgb7lpNS2Eis9WFE+fBe9ewXC4Ld9wVg6XuWt843Tk79ldwvMG5yHwFf5YwjTqff
         jSKYbWRjl7aTeD4JneLMYycqqY83JkkdYi7A+roDsaJ3cmbTt15x6tx4TMahY0OMd1Tv
         rxPNz9QWQ+qC9zZplr4D18cfhBeobBDe/5btM5gNT7Sv0E0DqB66e6hmQ3GbqtIxxHCs
         bWHA==
X-Gm-Message-State: AJIora9bU3bmSOxfUozksJ69/nohUtcJXlH1L8eh0ZafjvTpLf0CQ0D6
        dHeerA+WhpiKjH4VaezeA6V61Y5IGUA=
X-Google-Smtp-Source: AGRyM1vHyhRaM7WXIfqpplWap7pyP517s/eSG9UQvBMegWtkzP5+Pcc5k2fg0eCfB9VYeZ2LKLDN5A==
X-Received: by 2002:a05:600c:34c4:b0:39c:9236:4e9e with SMTP id d4-20020a05600c34c400b0039c92364e9emr25222905wmq.67.1656407621704;
        Tue, 28 Jun 2022 02:13:41 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c230500b0039c8a22554bsm16201312wmo.27.2022.06.28.02.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 02:13:41 -0700 (PDT)
Message-ID: <72a1a225-5d84-56c3-2652-ec7c17c18cbd@gmail.com>
Date:   Tue, 28 Jun 2022 10:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Oddities in gitignore matching
Content-Language: en-GB-large
To:     John Thorvald Wodder II <jwodder@gmail.com>, git@vger.kernel.org
References: <DC3C4CED-3781-4380-95E6-97F5CBE1B13C@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <DC3C4CED-3781-4380-95E6-97F5CBE1B13C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 26/06/2022 20:34, John Thorvald Wodder II wrote:
> First: I've found that the pattern "foo**/bar" causes the path "foo/glarch/bar" (as well as "foobie/glarch/bar") to be ignored.  However, the gitignore(5) documentation states that "**/" only has special meaning when it's "leading"; in other circumstances, the double star should be treated the same as a single star (and "foo*/bar" does not match "foo/glarch/bar").  Is this behavior of non-leading "**/" deliberate or a bug?

I've no idea if it is deliberate or not but it seems reasonable and I 
think it matches shells like fish, tcsh and zsh though not bash (I think 
our documented behavior matches bash).

> Interestingly, checking the pattern with the wildmatch test-tool (`t/helper/test-tool wildmatch wildmatch foo/glarch/bar 'foo**/bar'`) shows that the pattern should not match the path.
> 
> Second: The pattern "[[:space:]]" does not match 0x0B (\v, vertical tab) or 0x0C (\f, form feed) despite the fact that the C isspace() function accepts these characters, and I cannot figure out the cause for this discrepancy.  (The pattern does match the other characters that isspace() accepts, though — tab, line feed, carriage return, and space character.)  The wildmatch test-tool agrees with this behavior, though.

This is because git defines its own isspace() that does not treat '\v' 
or '\f' as whitespace (see git-compat-util.h and ctype.c). I'm not sure 
why we exclude those characters, I think the reason for defining our own 
isspace() is to avoid the locale dependent behaviour of the standard 
version.

I'm afraid I don't have anything useful to add for your third point

Best Wishes

Phillip

> Third: While the documentation for `git-check-ignore` only states that it works on files, I've found that it also works with directory paths, as well as treating any nonexistent path ending in a slash as a directory.  For example, in a fresh repository containing only a .gitignore file with the pattern "foo/", `git-check-ignore` will accept the path "foo/" but not "foo", and if `mkdir foo` is run, it will accept both.
> 
> However, I've found a case in which `git-check-ignore` deviates from the actual .gitignore behavior regarding ignoring directories.  If .gitignore contains only the pattern "foo/*", then (regardless of whether a directory named "foo" exists or not), `git-check-ignore` will accept "foo/" but not "foo" — and yet, if you do `mkdir foo; touch foo/bar` and run `git status --ignored=matching --porcelain`, it shows "!! foo/bar", rather than "!! foo/" (which you get with the .gitignore pattern "foo/"), indicating that "foo/*" matches the contents of "foo" but not "foo" itself, in apparent disagreement with `git-check-ignore`.  Is this a flaw in `git-check-ignore`, or should it just not be trusted in the first place when it comes to directories?
> 
> These observations were made using Git version 2.36.1, installed via Homebrew on macOS 11.6.6, with test-tool compiled from commit 39c15e4855 of the Git source.
> 
> Thank you for your time reading & responding,
> 
> -- John Wodder
> 
