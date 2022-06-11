Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A307C43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiFKPIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiFKPIv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 11:08:51 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC038A6
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 08:08:49 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id p63so1190848qkd.10
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GdaIYc5hL9bbTzh/A9PM9ZREmxUYNkuKLeM6TPNkRRQ=;
        b=ILOMjlel44MyU2Tk+xtVBZH//BhLC9tXhcvgc9mdU7dWG//Pfn1QoIQ0AnKyGApg1h
         Dzo4VZGIE+kC6ZaF/G0TjXwfK2tmUhdgEK65NrVjboeNOJhoJWwoaHpDrrZfNrdTOqYu
         9KvmqhFrTQz9TXOVFExaN8HfL0MrCQuTAXs7F8idRfCiNzAyW/oGC+sJimMgUpTDzGuU
         j0lLeeomVjYYCvk9i+jbZSgP66bWk4i5H9qLD3OWONz6WZ6CBco5WOVJF5TLa3agIkT1
         SmsSqE7AdGsZ5gd2fD3er2rWSWix7HceZRxH0eIa29c55cgY6mXhE5E8u5963XCn5+q7
         LYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GdaIYc5hL9bbTzh/A9PM9ZREmxUYNkuKLeM6TPNkRRQ=;
        b=ARIGUmgqWU7vMhgZV4Xc07esIu7qdl62QdMfRelDk4AVeYR0EzAh195hCtotju/clY
         xWHBOGXreE1Uilb80bZ+iXHgtPrn0uUYuvB7pwC/QfjZ8WPFy9eqHlGmupzdEws3fiFG
         By+OstkF4QHdeUFgvYyGhKU9p09C/KFzKqVJ3lf/u7Aa5PZwkBPmI7HiNk8jY2wM0kmw
         MN38jdQKIWJKk/fD6odxBGQldOYRnBsrSqGuMvGQDtqItiqrVgCJ8P6ywNEHzyUX7+gd
         IB3nQsJ64eNYXr/51/QLpDm/dJ1xRWC7bJZOz3SpT4ysLS7ABoP+ns7pfuddoDJHSkOh
         JofA==
X-Gm-Message-State: AOAM533AGen3GlPVc1ybjjXvRhhMiuyb35Wzbd1IL0Aw67sZFid7T1BY
        P0uzv3sjJIOk9oxPrIhSQrP+feVW7Sc=
X-Google-Smtp-Source: ABdhPJy1v07p+eB/uFF1mz7OPwk3m/41+9O/p2Q8MzMmWOaP5W5CwNy81lUNDPX2n0FDvMqbi9W5Yg==
X-Received: by 2002:a37:ab02:0:b0:6a6:b111:61a8 with SMTP id u2-20020a37ab02000000b006a6b11161a8mr24598125qke.260.1654960128658;
        Sat, 11 Jun 2022 08:08:48 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a40d400b006a6c9e17088sm2164613qko.65.2022.06.11.08.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 08:08:47 -0700 (PDT)
Subject: pb/range-diff-with-submodule (was: Re: What's cooking in git.git (Jun
 2022, #03; Fri, 10))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfobc1hw.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <6fc6c301-591f-7e51-f9c2-ee74f9428664@gmail.com>
Date:   Sat, 11 Jun 2022 11:08:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfobc1hw.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-06-10 à 23:39, Junio C Hamano a écrit :

> --------------------------------------------------
> [Cooking]
> 
> * pb/range-diff-with-submodule (2022-06-06) 1 commit
>   (merged to 'next' on 2022-06-07 at e5e31590c4)
>  + range-diff: show submodule changes irrespective of diff.submodule
> 
>  "git range-diff" did not show anything for submodules that changed
>  in the ranges being compared.  Change the behaviour to include the
>  "--submodule=short" output unconditionally to be compared.
> 
>  Will merge to 'master'.
>  source: <pull.1244.v2.git.1654549153769.gitgitgadget@gmail.com>
> 

As I wrote in my reply to your previous "what's cooking" [1], I think
the merge message (and thus release notes blurb) for this topic could 
be a little more precise, something like:


"git -c diff.submodule=log range-diff" did not show anything for 
submodules that changed in the ranges being compared, and 
"git -c diff.submodule=diff range-diff" did not work correctly.
Fix this by including the "--submodule=short" output 
unconditionally to be compared.


I was not sure if you disagreed and thus did not answer on Tuesday,
or if my reply fell through the cracks, so I'm trying again.

Cheers,

Philippe.


[1] https://lore.kernel.org/git/15dd34af-14c1-5b41-5d33-a2e3b9611c25@gmail.com/
