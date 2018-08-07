Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05296208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 13:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbeHGPyu (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 11:54:50 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38725 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389260AbeHGPyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 11:54:50 -0400
Received: by mail-ua0-f193.google.com with SMTP id o11-v6so16115309uak.5
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dmwO+AHPUBNmITjsiBsrfv/NhCGnLfD+kGKXwuXdv54=;
        b=EB6RRFq3vV119bL7VIH1R78t5hp6ksWAP7atnhIAqK1aUEEe7YQw9eQ9Xv6gYryuyS
         nsvcRnVnDfpaJDyQY41TxS6Qc8YnQWmsxOXreF3rvoWf9CLaDrZVAKvA/orsvE5+Dw61
         NDlbnGcJVTcfcf00LvYi9eEWaRANBlWoswXU9qeCwOh6Wz4jX5wEPAqGdwCW68gKP63E
         3BMRjIuAAjNQtlaoXn5tiZOnbdDFwjRVQ/9lWXlWlGsw/vscDrQvplEyg6oxlxZKm4ql
         GqhtrNmdLfByUz82R0mELLJMMZuBwdsoH5MTJcUc6+CEGRdzjZCSFOteKdJWD3Oi2N6v
         m0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dmwO+AHPUBNmITjsiBsrfv/NhCGnLfD+kGKXwuXdv54=;
        b=WNHeA7UuaFPtw2Hx2TgpuVq03S2xumUCHwSKbYm32lVPLQ0B98TICa8hjeBJKMTdMz
         M0QqZwy4g10B13IIqnOPZIKoSa5CZ2kXKHXU38j2I08gvmkfTMK1MeLQ85AEfCy56Y2a
         6UzzKmL6HrQH1G9dxwqdz/ArTbsuBW7irhLBntVtZYV0ppECmlwibzGrPybowaSf3+qY
         yUpC/nYoTOJ1KdsMAf8bCLtu8p31H2jfg1GXWgGa83iFpnhKL5EvdVZ12WSnVa6Edv1D
         t+MjEINcXxYH1CclCr9ttQPlaxblpasYqGsO1qVXw+mQy1zzjavIF2u+E/CS+gvxbN+G
         1Izw==
X-Gm-Message-State: AOUpUlG0NoL9Q+Cyed+aFg4sbyF9aQvulCzMeP47wsY8sHJxC+XtrWLX
        JmmgHXRgkDHv5r2Tv/+KY+mPz24Xlu03c/U8Dmg=
X-Google-Smtp-Source: AAOMgpcVHCNAtx86Q8rpXEQcbDk68Y4Dq/w130bc2Pw6woBoSr3eb4amSgRPT9lj+TqXnvSUQaynWcpKssLJ0c27hZI=
X-Received: by 2002:a1f:e1c7:: with SMTP id y190-v6mr11325501vkg.129.1533649225905;
 Tue, 07 Aug 2018 06:40:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 06:40:25 -0700 (PDT)
In-Reply-To: <CAN0heSqNFJm7cJ8SpTXLVi_0CFR5fphAT0D34a1k5i8d5T9E_g@mail.gmail.com>
References: <20180803231407.10662-1-newren@gmail.com> <20180806152524.27516-1-newren@gmail.com>
 <CAN0heSqNFJm7cJ8SpTXLVi_0CFR5fphAT0D34a1k5i8d5T9E_g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Aug 2018 06:40:25 -0700
Message-ID: <CABPp-BGQowPCMA2msTQ8pSQgak+7gig7qeq0dN-ZGU7K+ceCyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Simple fixes to t7406
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 12:50 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 6 August 2018 at 17:25, Elijah Newren <newren@gmail.com> wrote:
>> Changes since v1:
>>   - Simplify multiple tests using diff --name-only instead of diff --raw=
;
>>     these tests are only interested in which file was modified anyway.
>>     (Suggested by Junio)
>>   - Avoid putting git commands upstream of a pipe, since we don't run un=
der
>>     set -o pipefail (Suggested by Eric)
>>   - Avoid using test_must_fail for system binaries (Pointed out by
>>     both Eric and Junio)
>>
>> Elijah Newren (2):
>
> I'm not sure what's up with the count of 2 vs 3.

I started writing a cover letter, then realized I missed something in
the original review.  Fixed it up by adding another patch, but decided
to just manually "fix up" my cover letter to match -- and missed
something.  Oops.

>>   t7406: simplify by using diff --name-only instead of diff --raw
>>   t7406: avoid having git commands upstream of a pipe
>>   t7406: make a test_must_fail call fail for the right reason
>
> The subject of the final patch doesn't quite match its content anymore.
> The problematic test_must_fail is dropped, so it can no longer fail.
> Maybe something like "t7406: fix call that was failing for the wrong
> reason", or just s/test_must_fail// in what you have.

Good point; I'll fix it up.
