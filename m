Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0515B1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeAES42 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 13:56:28 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:43530 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeAES42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 13:56:28 -0500
Received: by mail-wm0-f53.google.com with SMTP id n138so4142889wmg.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 10:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shabtay.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q4HjmkNpYyz/bmNCk3lj5KA4yshKQkRRjS46H+sc9Ak=;
        b=hniR47WoR7j7GAudGKRXid8QLnWUcX975wFWgOPzd/jP9lqIaP3NlBDdRz3l4mU1lH
         AR6dcsRmXK/v5kgnPVrNqtvmkVkp/ounhCmjXvTV+sA63tbZ2UFAcKOZMdRbsR/n4kit
         iHl9jYhjI5FcAbTpuXOI/zyCZcQvuvKrIhW28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q4HjmkNpYyz/bmNCk3lj5KA4yshKQkRRjS46H+sc9Ak=;
        b=cH5RFMGO60qc9PGzn2DPnLMEMp9LjZEj1hGPSevUMkcLLRWFeccYSH+WkQGvHiYqdM
         cnCRs8RfnXp/xBLHK+OciTQpnaaE0Q0fAuQbSa7mr+ZLmano0J7aGtgR3Z3SJRvaGrKA
         X5mW3a7MabY3tPPHtW13hjwwKnJacrevs28nNZf0m6CzehF9zwVhWf0AjUdI0IaJgW9F
         RKXFnq0l7GmKuTFztxYFHJgvsByObpYQiSwMxbwihYCuwkxZhQhQKXagrut7GadG7y7s
         yYpjHimTxwAXOWx7js+fcz+Kb0h8g6TiswQgTfG9DkS3MrrzBnJb4t9WSFMpQuVd9IgT
         yYDg==
X-Gm-Message-State: AKGB3mIW9XFgFQZuRYSiU+ugiitSoZPIWV2TbMeX00zZQe2nHFksDe33
        7dbYw6y2vLlA2YhIOEKt8eTR7k1OFa6WYMch/7NCOA==
X-Google-Smtp-Source: ACJfBosT6bEYi8LtR6E9xZ5626vexpdlSFBJsl80CXv6UUrC24fOTsECIioprNhml0DBpD7iLyy2w2kJxYS7QaUm6Gc=
X-Received: by 10.80.204.212 with SMTP id b20mr5551735edj.201.1515178586908;
 Fri, 05 Jan 2018 10:56:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.170.203 with HTTP; Fri, 5 Jan 2018 10:55:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1801051130500.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net> <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com>
 <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com> <alpine.DEB.2.21.1.1801051130500.32@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   Isaac Shabtay <isaac@shabtay.com>
Date:   Fri, 5 Jan 2018 10:55:46 -0800
Message-ID: <CAK2k7nSWoNX+Y5dhLqLVzhzE12f3MgZo0R8xrHYKFwxCL+9mEg@mail.gmail.com>
Subject: Re: Bug report: git clone with dest
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Done: https://github.com/git-for-windows/git/pull/1421

I added credit to Jeff in the PR's description.

Note that I tried compiling master, but failed due to a reason
unrelated to this patch:

builtin/checkout.c:24:10: fatal error: fscache.h: No such file or directory

Maybe I wasn't building it right.



On 5 January 2018 at 02:33, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Isaac,
>
> On Thu, 4 Jan 2018, Isaac Shabtay wrote:
>
>> I cloned git's codebase, applied the four patches on master, built and
>> tested on Ubuntu Trusty. (After verifying that master indeed exhibits
>> this behaviour on Linux as well. Just checking).
>> Seems to work fine.
>> I also looked at the code. Most of the patched lines relate to tests,
>> and the one for clone.c seems reasonable to me. Added tests seem to
>> have very good coverage too.
>
> Thanks.
>
>> I qualify everything I had written above by saying that it's my first
>> time ever looking at Git's source code.
>
> We all started at some point.
>
> Now, if you want to make this easier for me, could you please apply those
> patches on top of Git for Windows' master branch and open a Pull Request
> at https://github.com/git-for-windows/git?
>
> Thank you,
> Johannes
