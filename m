Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05FC1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeDJTM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:12:57 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:44966 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeDJTM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:12:56 -0400
Received: by mail-yb0-f173.google.com with SMTP id m185-v6so4692753ybm.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2qSaBeawMwh6EWx8cLGYV0C/E52BDKjeE+dS/j188kg=;
        b=Lrpk5FGIUy5te7AC/1uFwn+tzeTMWYy7g/wUE1ghT1QLEdOKk8VIZx6gtAEdPJKdTO
         DJNVB9/CtsmCUEuskgCqYh9Y8N93kUOP9e2P5hPJ72YB2E0cf2OfcSxn9xiuwLeP0L7+
         aZGtY2sh3a3dkoATp0WcRUgxr47z9DkVFFZMRGjQ6Z9rOj4dOk8WEyne4d3E8ECdRWac
         puMmgv6T9Ax2VmDriJZEqa5hfmm78IodRd2RIi1AP7JPO/BPpn6zlWptD0ZVj7WbJHIf
         bwlCYiuSD3ivLT4ogn1hG/er2X+h87zEp1HlaedI+4llKfe+xZyS2tXjw1ZNY3zdi+U5
         nfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2qSaBeawMwh6EWx8cLGYV0C/E52BDKjeE+dS/j188kg=;
        b=AsRWqHtalTyiE3+kMBDwgP/6htIOrO9Uy9+rqqzOJxzNK4akPzb+XW3QJPiq8jSxdA
         amOhNT1TM7AM2lN7/Z73PBvdR+yIcIfttgxg0qiviMV8Q5SUA102t+2kQ6PjSrljqlki
         gXQe8cXG1QX0ycxFQkd1+7JSznZjRz5ASLxhaEMMAGRnuAk6oeS91AXSlRofytM3DlRk
         vVl52dSwQ6ehO+KPiVz4D17FoC1FcUYw1a/vB0aBpwn8NXu9WW3nLIzufTTAOmADress
         UNATljj26MrLwj2wyk3CsXcCIlSB8HXsdDLCdK38jvFf856oIZZQRNrsNcXUnFmSQKsg
         NWVQ==
X-Gm-Message-State: ALQs6tDNhICTkDMsXxX2n+4ZmhDpBsxp84gAI9SR7+jjIk9MGkiUGoxx
        ym+jS2GNYvpOmLpYj/fhsYwa3ZvwoAzu7pCkNvf3R1/J
X-Google-Smtp-Source: AIpwx4+Xmt6ZqQ1zoRB40QC26sZhypY/6owvOPYDhOu+CWzPQzdyjW/w6yhuu2O6piMTU3cyeHCwLc2UUo8ARK+UJjw=
X-Received: by 2002:a25:8e0e:: with SMTP id p14-v6mr689227ybl.352.1523387575846;
 Tue, 10 Apr 2018 12:12:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 12:12:55
 -0700 (PDT)
In-Reply-To: <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com> <98394864-ece6-5112-0274-b2399087f207@gmail.com>
 <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
 <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com> <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 12:12:55 -0700
Message-ID: <CAGZ79kb8_B659WOo0fLWtebX65jetHe=mfNQaHf21udNUM8m_w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 5:57 AM, Derrick Stolee <stolee@gmail.com> wrote:
> On 4/9/2018 6:08 PM, Junio C Hamano wrote:
>>
>>
>> I guess we'd want a final cleaned-up round after all ;-)  Thanks.
>
>
> v8 sent [1]. Thanks.
>
> -Stolee

I gave the series another read and think it is ready.

Stefan
