Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E74F1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBISWo (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:22:44 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37914 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBISWn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:22:43 -0500
Received: by mail-wr0-f194.google.com with SMTP id t94so9147865wrc.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 10:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5Xc4vqLx3jqFBB/4vieDa7jCut5XseNr3qBky5XuRm0=;
        b=RnXcDhNnmOiklcdwZlfMc5y2Bxe2IbfA6Al89QDC/CH9QpiJvU09lob1T+G90ZFN90
         eJD+Aw3ny3pKNpi9OnZTfQhjd9ub+u9GLdzNI7w8Myn7LLGiDnx/w06aWLO2/5oayVIW
         s/MzVhlmI4NjLuiTtUIJ7cjV/4rYyyFxgn82W8+N9C3N5aT222xJFuo2ohWb74uZeexW
         Okt3+1WDJ898R+evAENC4diqgoNWTVY60py1oMeKe5hVCWbrEeqOjyMjWM+FhoBrTZuU
         /YW27oa5T9Vn2nFjttkDKw9K4r0dS4bvLxprddPUTUGGAJuOyG9Bql+8RO40UmJFcTTJ
         sjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5Xc4vqLx3jqFBB/4vieDa7jCut5XseNr3qBky5XuRm0=;
        b=k38Aya/Pwujd4t0cJaJqzPj+ilO6ckWd1gqKIeDroCCc0Nq9hC32KIMyPc1eYj9yuK
         kzuRTnQNnDEhfrJ09Z8c6ULtboHvSfvTRp60ccDqdqZROOzaVpeUwaBBL+G5Jag9v0y6
         qmBPpb5ni2qfNiQzVo92Cz8gASw2fkzSaHXOi1KsMu+mbpDVaWavuOzScK+pfeCqY0GY
         uPQN4ibdriJkWIY/0i80THnIyIwectJlFt4JOtcZSUf75T116JJsK5ZlOAsZhSbgDRqF
         ZgWR3RU/FsRw9U5XcPNI2ytR5/j4HWMfVC8PTO/FuVrMf0ME8YiJmsVfhdNwQWmXERoY
         bNew==
X-Gm-Message-State: APf1xPDpGQNLPJXkW5733p+7rSLAFjyLKUkfdjLy2TxkyCXW2qr7IHDv
        oHpqN25gZNIgAogdSrYhAeI=
X-Google-Smtp-Source: AH8x224LIWmf4Yh+O50nWgR2tSXzzboZW2abmqdL7yN80mdwAqJpaudYL0E4uiGQPlDthb9t83L/7A==
X-Received: by 10.223.173.239 with SMTP id w102mr3226789wrc.110.1518200561581;
        Fri, 09 Feb 2018 10:22:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f22sm2846642wmi.24.2018.02.09.10.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 10:22:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t1404: use 'test_must_fail stderr=<file>'
References: <20180209024235.3431-1-szeder.dev@gmail.com>
        <20180209024235.3431-4-szeder.dev@gmail.com>
        <CAPig+cTtC8WaqJg301WE+EN2RYzka-+pOoJZNZFzjqsHtx+M-Q@mail.gmail.com>
        <CAM0VKjnnt0Nq6GQXWaq6Jq_tvOzJx-KsEBjs-7NS2bim0UH+Og@mail.gmail.com>
Date:   Fri, 09 Feb 2018 10:22:39 -0800
In-Reply-To: <CAM0VKjnnt0Nq6GQXWaq6Jq_tvOzJx-KsEBjs-7NS2bim0UH+Og@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 9 Feb 2018 04:33:22
 +0100")
Message-ID: <xmqqh8qqxbtc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Feb 9, 2018 at 4:16 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Feb 8, 2018 at 9:42 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>> Instead of 'test_must_fail git cmd... 2>output.err', which redirects
>>> the standard error of the 'test_must_fail' helper function as well,
>>> causing various issues as discussed in the previous patch.
>>
>> ECANTPARSE: This either wants to say:
>>
>>     "Instead of <foo>, do <bar>."
>
> The "do <bar>" part is in the subject line.

Please don't.  The title should not be a half-sentence that begins
the first paragraph.
