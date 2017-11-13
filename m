Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386691F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 10:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbdKMKYQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 05:24:16 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:53755 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbdKMKYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 05:24:16 -0500
Received: by mail-qt0-f180.google.com with SMTP id n61so18846484qte.10
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0mBOdo9mpBwfLAeyP4+UVsb3jlx2Ad4RCoxhpEeLtSg=;
        b=kaxPyEbDeM5NrczLKkMqteIIcn+JCBjs83ur2S7hRRLolanCubHzAxJw0cApyO2t9C
         Vduhkl/HZQ7nPnVnVTedGf7Mb7Xaucl1OeY7M7QA5NrUlqJCU946L+E58bKv11Zr38qg
         3+XF8sclYxK48y3no72ALu90wYl19CjFxZSP+480WnqYDJ0xjcLDZk6xtfXyAXZNydji
         gUrH96AITpNEMDl6lVXs2TVRL83ifLHE6pZw0ta3Rt2LQdh4fCcux07uC/T2ejqX96M0
         an2UuIyPkjMULSXCH7UFicUmt+Y9WxWbsYJKo4Bn8pVyyJxh4HLNAB6OCSVtvQKwPzAG
         34hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0mBOdo9mpBwfLAeyP4+UVsb3jlx2Ad4RCoxhpEeLtSg=;
        b=izMcDa6p7N6FDGIBLfR6DL+AJq/hnjPuZiKEcJa1ggeiQROJQArKycsw2jV1M5uHvp
         tofsJcH4/s3k5N174sZs9iEEWcRKSYfFXfoueHUgvQjK0xDwUmrqfp5ypQSK7+qEYO1T
         G7QF3IOL+Xw+ag4d6XyfiL3oR/7NTGilIFWkhumzyAam/1YcSKQEorxOitgirEVLQJL5
         DjqokoGB5c83KundwQjDOc/Yz4lbA2f4M8iB3FyE4757crDoglkeqCsMraZn4R+Kp2QY
         dva/xz0uDO3RPUV3Aej7/tcbIHQhhT6BSylqf877GcEDTY5NBJ6xg71wK8dj9kyNMoCB
         53rA==
X-Gm-Message-State: AJaThX60lBoZLvDRP1Y4AoGyjHHDPuvspuvYCLDwitPKYd3NlTx72gBA
        Zjj79s9GtuvMzUGdWlnNZW4YMVLfeGBEo8fQYOc=
X-Google-Smtp-Source: AGs4zMYZg21GXo5UTeHkWQLwfIFWZ0+nRVDNcFKW1wURUf459Do9KfHE9nOCCIZZDEv78izcOBll2vB7PvKCi1oqQgE=
X-Received: by 10.200.35.42 with SMTP id a39mr7370051qta.9.1510568655226; Mon,
 13 Nov 2017 02:24:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 13 Nov 2017 02:24:14 -0800 (PST)
In-Reply-To: <xmqqk1yvaq2e.fsf@gitster.mtv.corp.google.com>
References: <20171112130710.16000-1-jerzy.kozera@gmail.com>
 <CAPig+cSR_GGog2vATwGgMWDofVzkgDE7K=VvZ4GEyrzYC1t-GQ@mail.gmail.com> <xmqqk1yvaq2e.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Nov 2017 05:24:14 -0500
X-Google-Sender-Auth: 3XSvBVwuaFjYS_PCoPaMZm_63Y4
Message-ID: <CAPig+cQqLJsBTSMSPCVJ+_2JxkO=i4v681rK=THoN7xQ+jB91g@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: strip CR chars for Windows gpg2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jerzy Kozera <jerzy.kozera@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 9:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> +       size_t i, j;
>>> +       for (i = j = bottom; i < buffer->len; i++)
>>> +               if (!(i < buffer->len - 1 &&
>>> +                               buffer->buf[i] == '\r' &&
>>> +                               buffer->buf[i + 1] == '\n')) {
>>
>> Hmm, was this tested? If I'm reading this correctly, this strips out
>> the entire CRLF pair, whereas the original code only stripped the CR
>> and left what followed it (typically LF) alone. Junio's suggestion was
>> to enhance this to be more careful and strip CR only when followed
>> immediately by LF (but to leave the LF intact). Therefore, this seems
>> like a regression.
>>
>>> +                       if (i != j)
>>> +                               buffer->buf[j] = buffer->buf[i];
>>> +                       j++;
>>> +               }
>
> I think the "negate the entire thing" condition confuses the
> readers.  The negated condition is "Do we still have enough bytes to
> see if we are looking at CRLF?  Are we at CR?  Is the one byte
> beyond what we have a LF?  Do all of these three conditions hold
> true?"  If not, i.e. for all the bytes on the line except for that
> narrow "we are at CR of a CRLF sequence" case, the body of the loop
> makes a literal copy and advances the destination pointer 'j'.  The
> only thing that is skipped is CR that comes at the beginning of a
> CRLF sequence.
>
> So I think the loop does what it wants to do.

You're right. I misunderstood it. Rephrasing the logic in a simpler
fashion would help.

> In any case, I think this should be a two patch series---one with
> the code as-is with a better explanation, but without "make sure
> only CR in CRLF and no other CR are stripped" improvement, and the
> other as a follow-up to it to make the improvement.

Agreed, a 2-patch series makes sense.
