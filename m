Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D93B1F42D
	for <e@80x24.org>; Tue, 29 May 2018 04:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeE2Etl (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 00:49:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46798 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeE2Etk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 00:49:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id p19-v6so2449151pff.13
        for <git@vger.kernel.org>; Mon, 28 May 2018 21:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vPoL6Yi9BgHrpcW4iGdPa8xZBhTAM7Qr0AChGAxPIQo=;
        b=sMV3plbHXkZZLE3s6UByyYqj0ssuKyyRqRD6DKS6WXhhD4vxCu/QnDmv6UD63OW2q2
         WhPy5OpnmISZzd5rKKe1k5IFSr8YY4pPhEBT4JXcOdpijbgoQH/7L3o3gy9r7YiiM5PJ
         yxl5mYTPX0ws9CaNubN4XAwNyLUMuSEwdBS/qj4UH7avCncTHJ4xVKoId9+Rxke+i468
         2EnMySWtqFzSLB8b0JtNRSKk99WXbuqQyVgqX1O0/nfuc4+lJBSgW8KUuiFd6QoZHVNV
         r8Jf4edYZBl4SsmskuWf6s8qAsvzXJwyLGsNK1NfHf+Nmjy3oLSRotLAiLyyhRUUuIzF
         hWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vPoL6Yi9BgHrpcW4iGdPa8xZBhTAM7Qr0AChGAxPIQo=;
        b=F7SrgEJB3WvvkjuYhkltqpqzZandhws+7KLZtDbpcMcD664D7d5WUo2ZToanbz3Etw
         fKpnnhFL/kC7jxljUgfej4G36baT9XLHlJP526lEN/8G8PVBVewBUkGaTq127ybfnEbV
         Ec4u9mNqxiCR3HbC+BIfC+SDlly0YCZtdfFqgP909sgALfmqYjeghwh+KEjvmtU41TZa
         1l+pQ2X/E6VAfv6u49VTc0IQc47ASYdBCeRSDeyql6em2+xh0GpH6yaL9NyPZKE+qMng
         GvPCqpS2lBatiRh5Bh9hYatmjP3hUJyOpPUaRX8dJp6yZQJQjeSGwndwbyq9c4IeC6YG
         Rjwg==
X-Gm-Message-State: ALKqPwfRW92+znHZtjtP45tYQGAlm13pQv26yInO0tLDr/pjFcCD4fG1
        SzGGMqpFwfR6KXIxE3K5Ms6PAP+SC6Xdw4ZoCTxFXNZy
X-Google-Smtp-Source: ADUXVKKH7bTT8s1UTWM3HfPY04gXp9OP4tdQr7D9WQhYZKcmgQNzlbCyf4Obo97gS9sqUw4nmidCPjtvtEIcVA1K04U=
X-Received: by 2002:a62:ecdb:: with SMTP id e88-v6mr8358234pfm.16.1527569380215;
 Mon, 28 May 2018 21:49:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:bb8b:0:0:0:0 with HTTP; Mon, 28 May 2018 21:49:39
 -0700 (PDT)
In-Reply-To: <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
 <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com> <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
 <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 May 2018 06:49:39 +0200
Message-ID: <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just
 the first
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 May 2018 at 23:45, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>>> +error:       sub/added
>>>> +error:       sub/addedtoo
>>>> +error: Please move or remove them before you switch branches.
>>>>  Aborting
>>>>  EOF
>>>
>>> This shows the typical effect of this series, which (I subjectively
>>> think) gives us a more pleasant end-user experience.
>>
>> Also, very subjectively, I'm torn about this. To me, just one
>> "error/warning/fatal" at the start of the first paragraph feels much
>> better. If we have to somehow mark the second paragraph that "this is
>> also part of the error message" then it's probably better to rephrase.

Would you feel the same about "hint: "? We already do prefix all the
lines there. It seems to we we should probably do the same for "hint: "
as for "warning: ", whatever we decide is right.

> I personally can go either way.  If you prefer less noisy route, we
> could change the function signature of vreportf() to take a prefix
> for the first line and another prefix for the remaining lines and
> pass that through down to the "split and print with prefix" helper.
>
> That way, we can
>
>  - allow callers to align 1st prefix (e.g. "error: ") with the
>    leading indent for the second and subsequent lines by passing the
>    second prefix with appropriate display width.

I suspect this second prefix would always consist of
strlen(first_prefix) spaces? We should be able to construct it on the
fly, without any need for manual counting and human mistakes.

>
>  - allow translators to grow or shrink number of lines a given
>    message takes, and to decide where in the translated string to
>    wrap lines.
>
> Even though step 3/3 may become a bit awkward (the second prefix
> would most likely be only whitespace, and you'd need to write
> something silly like _("\t")), we can still keep the alignment if we
> wanted to.

Thanks both for your comments. I'll see what I can come up with.

Martin
