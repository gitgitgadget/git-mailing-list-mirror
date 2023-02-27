Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53995C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjB0RSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjB0RSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:18:41 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED323C4E
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:18:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s18so4002187pgq.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M40s0heN2ywraGyQa9lh4srATVD3craz3xR9efFXVN4=;
        b=U31mRRjOeSdIkffsJWIFc6dI511X2+17Uazc2ZlGAkZuEdVp73bhGf+ybHYWDUgTEW
         YKHGEfbI40phMlwiSfeigWdNCQyx50uLsGsY3sCNIli8+CLI8Vwn88gWFwfmpbXJIdMA
         dK5tDoufScrzTdaevRhLzVQHSQlp4GnRmXXKYXiRj6Rm7UxiJIjftnPPJ/N7wSnWqtDI
         njHYviDmlMvAMKQ3+ZccJJFbEGOkVKbUmSTdbzgc+BnQlgyCE98eXAX7+7wYgrlQYIr4
         4BNpSH3otAc6PTESlXCW9USDBgvfy9cyt3rr+pzy3Vx25yiu1CcQeGuQ70pnsaVPwVVf
         nEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M40s0heN2ywraGyQa9lh4srATVD3craz3xR9efFXVN4=;
        b=1MgvJKfQJPI5oL1r5kg54LnpvmWFX5lqsWr5zf3L8SuTjVdaGBQI0kFgcpufdvfVde
         2xUg3EwcW15INhyTcXgbAUGnex4MMkxZZJjAKpy5Z28rHummXXAb9pWzFuJ8614LmgVg
         NDf4Tg+QjzVYqX4Vc1AxSOdcZopBxqN2YeB4pORDBhzg7NjAqmZ4r3plMXFZxbmZuCpr
         0vLigTWHqCxOI8DveiYFhU1E0cNtMX+C6H6iJaI0En0EM3PcCZup2PqFlVZ7TzZ7BY6p
         0QAjo1cdtKOcHMu0/j4ade0MyTu7sqo+mZKm9sJVeZZuK0VL9LbkwghsuwpKRSM+ycpZ
         U1YA==
X-Gm-Message-State: AO0yUKUVEkqqyUQz8yTX0yYIe0ctzyMJWIjNxQ14UrOpAnWadRU6C+WT
        5AypXwzXJiKaU4YH6rsSpPn2XBeZWW5neI8=
X-Google-Smtp-Source: AK7set/yGTcrsZ3Rt2EKGWTzvv4l54+dHIDrfkjPXNJ/kgign36f4NpfB6gMYASPpZvhlXFkmzHjhg==
X-Received: by 2002:a62:5bc6:0:b0:5f2:104b:4c46 with SMTP id p189-20020a625bc6000000b005f2104b4c46mr4337577pfb.2.1677518311989;
        Mon, 27 Feb 2023 09:18:31 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b005a8f1d76d46sm4615195pfo.13.2023.02.27.09.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 09:18:31 -0800 (PST)
Message-ID: <9fcd235e-9dcd-8b13-156b-800da9121b33@github.com>
Date:   Mon, 27 Feb 2023 09:18:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC PATCH 0/1] check-attr: integrate with sparse-index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
References: <20230227050543.218294-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230227050543.218294-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Integrate git check-attr with sparse-index.

Since you're only looking for feedback on a test (one that theoretically
passes without any sparse index changes), the title should reflect that.
Something like "t1092: add a test for check-attr".

Also, the line wrapping of the following lines is a bit strange. Please make
sure to wrap to 72 characters, as it makes responding inline easier for
reviewers. For the sake of commenting here, I've rewrapped them.

> 
> Also, I have a question about git rev-parse. I read the documentation and
> wanted to add a test for it, but I noticed that Derrick already integrated
> it with sparse-index last year. Is there anything else I can do with git
> rev-parse to integrate with sparse-index, or should we just leave it be? 

Ah, sorry about that, I forgot to remove it. I don't think there's anything
else to do there, so we can leave it be.

I also think the list on the SoC Ideas 2023 [1] is somewhat out of order
(there are definitely some easier/almost trivial ones marked as "harder"
than some more involved ones) - I noticed last year, but never got around to
updating it. I'll try to submit a pull request to update the order and
remove 'rev-parse' sometime today or tomorrow. Sorry about that!

In the meantime, I think the easiest commands will probably be 'git
describe', 'git diff-files', and 'git diff-index' - feel free to switch to
one of those if you'd like. Of course, you're welcome to continue working on
'check-attr' - it'll be a little more complicated, but I don't think it'll
be as bad as, say, 'git mv' was (which needed substantial changes to its
sparse-checkout behavior before even starting the sparse index integration).

[1] https://git.github.io/SoC-2023-Ideas/

> 
> Thanks!
> 
> Shuqi Liang (1):
>   test check-attr pathspec inside sparse definition
> 
>  builtin/check-attr.c                     |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> 
> base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1

