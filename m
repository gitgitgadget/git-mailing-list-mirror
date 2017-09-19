Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 832992047F
	for <e@80x24.org>; Tue, 19 Sep 2017 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdISNpZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 09:45:25 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:50782 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdISNpY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 09:45:24 -0400
Received: by mail-ua0-f170.google.com with SMTP id g34so7310uah.7
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4oHBOIQgPYnKecxl4aG+7uGFpxY0K5i1Mr+ICJOn1Cg=;
        b=F36NjbtnUDeue7LS+CjYy0tbl4P1Y6Ad3h34wcUlPQm6HHsmcrL/OtiCbwI20o138N
         czE/75oC+vbmwcFUm70cOxeGVhAQUS3CTcRIIPLuWF8rBG3UsWcjyT59nnAm4dNZatAu
         /nNMymnB8wWGwgpFh53rNqV8z5MSWJ0Yeyy7rtvqNXfTicDo/CnMGFjliCytCjZx9XW/
         ZiWijoANuv88TwfHW5pcNhyWNp0rf1A2sWM5PM7CJiqqDRmFEbZgki6osV8I1pznbQZv
         uqRfWPNOTlhMhKL+YxLfaiI1VwCUq43TO0KPTNUf5MMbt7btANlpQcpB4aTjqCYe2v+o
         bThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4oHBOIQgPYnKecxl4aG+7uGFpxY0K5i1Mr+ICJOn1Cg=;
        b=aIE2DkOvWa4MvMgyp8mrqlvAsjrZWMVkAAUakv1QTE4jkZ8J6tXeQEzzx5jVsAbDEN
         gVkRUzkTyCG8gnkLXI+SE7JAFh7Y/C9Fd9CrmH93ZlAl13HPEKkL1W+qjCIoSDWdpfbA
         MEiiMC1KtFd3jOtCkhhcD6h/7SeLaAepZI4Iujyerqjr2RZT98lS5UPhsjqOOtfSjn52
         8z1Uco959LSIZVI6w28wSguGqZH1Tzpi2xC5QnNTYjIdj4HHqzzjjMcLc3zPHQAGGese
         yxtMbkYFyZk4Hf25gB6GuMCNpo3LvAACAByAwgZN02SE0hVKjampwyNDTmfyOkI63nxr
         SWYQ==
X-Gm-Message-State: AHPjjUikCao7YIWin4iaodOInxKTfEi0jecNwoAmoQnis49tv5l1xNZw
        K7/iuIzUPjG4bi7LykO2q6KWXTwFoIM1XRijD6o=
X-Google-Smtp-Source: AOwi7QBXIX4EME/rXJl8mAXN0KIGa5oGjsFRffegLB9yfGylzLPbXHl9ATHc32f0foJcLI0Jw+ZLQQnvw0FP8lY3Mrs=
X-Received: by 10.176.95.69 with SMTP id z5mr1305916uah.100.1505828723695;
 Tue, 19 Sep 2017 06:45:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.35.76 with HTTP; Tue, 19 Sep 2017 06:45:23 -0700 (PDT)
In-Reply-To: <CAM0VKjn=KjTHBoubJKbxx7MasJ6wWcUFrCwrvr5oHwUCsfr_Pw@mail.gmail.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com> <5c86b55e-20f6-df8e-b01f-66876c3a5f46@alum.mit.edu>
 <xmqqfubku9iy.fsf@gitster.mtv.corp.google.com> <CAGZ79kYXDhcVXd2C-x6e=o7jYdKqV22DY45c7E2TeuhKLfn26w@mail.gmail.com>
 <dab2d555-7e09-4eb3-19b8-cab085626bbe@alum.mit.edu> <CAM0VKjn=KjTHBoubJKbxx7MasJ6wWcUFrCwrvr5oHwUCsfr_Pw@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 19 Sep 2017 15:45:23 +0200
Message-ID: <CAM0VKjmuyp0pn29s8=diCpA0FPjjFJH-LcxQmOJH6Z-7WZNurA@mail.gmail.com>
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 3:38 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> A bit "futuristic" option along these lines could be something like
> this, using a scoped loop variable in the outer loop to ensure that
> it's executed at most once:
>
>   #define for_each_string_list_item(item,list) \
>       for (int f_e_s_l_i =3D 1; (list)->items && f_e_s_l_i; f_e_s_l_i =3D=
 0) \
>           for (item =3D (list)->items; item < (list)->items + (list)->nr;=
 ++item)
>
> The high number of underscores are an attempt to make reasonably sure
> that the macro's loop variable doesn't shadow any variable in its
> callers or isn't being shadowed in the loop body, which might(?)
> trigger warnings in some compilers.

Well, and a poor attempt at that, because, of course, the loop
variable would still be shadowed in nested for_each_string_list_item
loops...  And our codebase has these loops nested in
entry.c:finish_delayed_checkout().

OTOH, we don't seem to care too much about shadowed variables, since
building with -Wshadow gives 91 warnings in current master...
