Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8AC3211B5
	for <e@80x24.org>; Tue, 22 Jan 2019 19:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfAVThh (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 14:37:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51836 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAVThh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 14:37:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so15403620wmj.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 11:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/ldBOSM+xemjmWIYcHW8vHaXU+Sl0+2E4yZbzVoheV8=;
        b=UepwYCUTtnNmIk4DwR8vCkjDf2GqagIqP0yHbhNCbz5ASqkuqFWHIbOpcLNZDNAfVl
         h2JmztVaHsWJZE7zL37iuPi0QR5dgLHAV7ZQjPp4sJAnufY/J3h8d0V0WDc5iSKuoYCM
         K1WDzTIMBGTrFTJqnZvPnJfiL3N4Pf/V4lTJS+y184KDejvzOSuZTcVgoG33ajuinUwn
         2M4vXVApxEcsGs7KABcqS6+bJOQ1V64DGOdXUaOKBHQ3zb4A4raPg7BNH7zN4f9M940b
         1xm1nQeJk4U6i8d4c0DS7wXdPu3GFXxnaKwGCog8ek5xq93CdetnSe21Vd4tWIkkTQDL
         vw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/ldBOSM+xemjmWIYcHW8vHaXU+Sl0+2E4yZbzVoheV8=;
        b=pVxXNwhOFjgfE5IuwtqXY7jGbCtCJDVRYbGFhQIVLetVlWaciqm0+vtEaAMFSvZxM8
         rdEF4YiwjQ80ngfcfkjCDf3QfBte51j8u7cMZE70WD8McDzruuvN3I6jORrRlRMhhE6a
         M3pT+UPhTHeeSL1sH2mOAymbVZXj1PAqUoSLcU283IjAaopwHfXluquVdiQhXYoQIHWX
         gaDzNqHMxkLo2WzZcIuTYwQ9KB/gfMfoAZiG6zJEa5nATk2cWdNKg1Qn4bIZdXnzMR/d
         AnT9s6hVzr0pwgWdaP6ogAXTR82+NJUd5tcL9+mYsN4FbAo75Oj06JGY8DsclPH1htrW
         7stQ==
X-Gm-Message-State: AJcUukd9m+GTEwg2OH24mYbw4zkv8qrjzFnEdGFY+yB/ZagPi+3I860r
        1xC5d/6lLrCq3AzrG+tTItA=
X-Google-Smtp-Source: ALg8bN7zlrioNRgSTdd3AwlDRR7jdA0XFLTBdXrNuSlNVGMn1ojyGEgmNdOQ83LFOPdMxU5R/fEvsw==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr5125715wmg.75.1548185854575;
        Tue, 22 Jan 2019 11:37:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v133sm43854014wmf.19.2019.01.22.11.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:37:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 00/10] commit-graph write: progress output improvements
References: <20190116132947.26025-1-avarab@gmail.com>
        <20190119202121.3590-1-avarab@gmail.com>
Date:   Tue, 22 Jan 2019 11:37:33 -0800
In-Reply-To: <20190119202121.3590-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 19 Jan 2019 21:21:11 +0100")
Message-ID: <xmqqsgxkfpqa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Improvements since v6:
>
>  * Integrate my "commit-graph write: use pack order when finding
>    commits" patch, and per Junio's suggestion put it at the start so
>    it's easier to split the two apart.
>
>  * A signed-off-by of mine was missing on that patch. Fixed.
>
>  * Replace SZEDER's two patches with his re-roll at
>    https://public-inbox.org/git/20190118170549.30403-1-szeder.dev@gmail.com/
>    for convenienc, since mine needed rebasing on top of his.
>
>  * SZEDER rightly pointed out that I was doing some work for nothing
>    in https://public-inbox.org/git/20190118171605.GM840@szeder.dev/;
>    fixed.

Reading the whole diff from the previous round, aside from
"large" vs "extra" rename, and removal of the extra "graph_passes"
variable, this looks identical to the previous one.

Looking good.  Let's merge it to 'next' soonish.

Thanks.

