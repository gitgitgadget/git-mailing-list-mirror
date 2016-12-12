Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0403B209B2
	for <e@80x24.org>; Mon, 12 Dec 2016 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753204AbcLLQaV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 11:30:21 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32912 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbcLLQaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 11:30:20 -0500
Received: by mail-yw0-f196.google.com with SMTP id s68so8186543ywg.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 08:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DkNUWSxsBxLBhIxiXwZ99sHdLchEKnt+bxTBAgufnGA=;
        b=x22O7IDAtZIxe+qr+/nZf0nYb3x3fbmX8o6JvNOAK4FQ46YcXCVQXUwhrYr7+6L2hP
         KssuAuAuc2lkFnIqXGNm2bS78fy7+2hL2PDSlo0EIhRWs1Tat4hg9vJzeAW2KikDoqkx
         xjIaV2fAvzugBoVtiipFVAXgLi4pNV2DNZKQT7hABKLJWOCOuZ/tAEjhiL/mO5tnWU5r
         zo4BJR5ZImOZkOwr564AwI1JX/kAe7EdAfqqjJn+w61jaJZaQQquJTg8OI/Us1SlOM9W
         h7GRwQWuKh1U8Zzvrx5523wgdQxvdQkAc6tiFvPdl5s0aawYd5rmjxBfNZTLhwFRjIr1
         fEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DkNUWSxsBxLBhIxiXwZ99sHdLchEKnt+bxTBAgufnGA=;
        b=TC2Ob3v6ylTzt5fTa6v7NvN+9JZbgAEhaxGPrAnGf69qgt8izs3V7Nl9gMF4ld2/5R
         Lt+mN1aTGzLwpbQyEmot43vWw9FVaNWw3n41LDEQTBEvWa3UB3UtIKZ33Ulkua/SrmFJ
         aJSiEOIrE4nPxgDKPEYwEn8EV7sxZKihDU+d/Zz4osXuH5iXxLymi50+cY3UyrQVp28k
         kcEu4fKXHeQ26+K6UDPd2KoJD0jp+HGZZA8ujtvd+xzPkggmRbPkyuoinh/CVUy+dHeR
         /67lM8si4eL0KDMWnR3+5Nm0NLq7YIiw+AZ7wr26CGhgig705mJRmODMVg/6024FU1nY
         R45Q==
X-Gm-Message-State: AKaTC02eRoDFvybh4oaFWFMgcSrBaOI+ZDi50QemqHFd0BjsAav4+WWk7ca1y3x+tePYH+eKD8Am/Xyue4qxvA==
X-Received: by 10.129.82.214 with SMTP id g205mr87803287ywb.73.1481560219417;
 Mon, 12 Dec 2016 08:30:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Mon, 12 Dec 2016 08:29:49 -0800 (PST)
In-Reply-To: <20161212121548.aj2ptnmrqt67anlc@sigill.intra.peff.net>
References: <20161207153627.1468-1-Karthik.188@gmail.com> <20161207153627.1468-19-Karthik.188@gmail.com>
 <20161209140345.76ybodldmg2lxgbn@sigill.intra.peff.net> <CAOLa=ZSPDLwziGEvyixebAkS2M1JMYidQNHfDbnmYarFCjn80A@mail.gmail.com>
 <20161212121548.aj2ptnmrqt67anlc@sigill.intra.peff.net>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 12 Dec 2016 21:59:49 +0530
Message-ID: <CAOLa=ZT1KN_iw7JzB78hPb-LrY_yaDZk0D+TqY2W9hCOftzumA@mail.gmail.com>
Subject: Re: [PATCH v8 18/19] branch: use ref-filter printing APIs
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 5:45 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 12, 2016 at 04:50:20PM +0530, Karthik Nayak wrote:
>
>> > This caller never stores the return value, and it ends up leaking. So I
>> > wonder if you wanted "static struct strbuf" in the first place (and that
>> > would explain the strbuf_reset() in your function).
>>
>> Ah! Yes this should be 'static struct strbuf' indeed, I blindly copied Junio's
>> suggestion.
>>
>> strbuf_detach() is also a better way to go.
>
> One of the other, though. If it's static, then you _don't_ want to
> detach.
>

Wait. Why not? since it gets added to the strbuf's within
build_format() and that
value is not needed again, why do we need to re-allocate? we can use the same
variable again (i.e by keeping it as static).

I'm sorry, but I didn't get why these two should be mutually exclusive?

-- 
Regards,
Karthik Nayak
