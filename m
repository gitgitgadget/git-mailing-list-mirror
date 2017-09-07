Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E2020286
	for <e@80x24.org>; Thu,  7 Sep 2017 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755857AbdIGUiy (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 16:38:54 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34019 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755608AbdIGUiw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 16:38:52 -0400
Received: by mail-yw0-f177.google.com with SMTP id r85so2467727ywg.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BQvpQW6tM3Cpbl1VMH/+Tf/RxhacuvyagFmI7fUl1so=;
        b=qmSfV+zsFFT+DpPfKDBsjBtPVcjPXt50OCP4FxXQSKN5gWgOiqhFk9pAovrDpSe0WS
         yK6wmnPnWk9jZSNR8NvKCmMRr0DWDCQPDVXs3cZDJ7M9Lop6YRSJSfayhzKkoH7pjaAY
         moAMhNzMX7slSv5KFGi9vOVTOqsL0GjJ9kUhdzeyMvIB4XrnFKEXj64SpVxYV/DDz4s5
         CcWANw7hbMT72byhZHnWv175fxMd17hRAA4fREDnP8dPElGyTPcwFfqpI9cYawUaV+XI
         rdWcLtNji6z6PeGprqvT0TrnNUs/SfIdGmnM43j3+zKa0fOwyIPAG6CmGpdyraP+PgHG
         ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BQvpQW6tM3Cpbl1VMH/+Tf/RxhacuvyagFmI7fUl1so=;
        b=BlxgmPpOuGpJjEI0cd/h/xC5uLto3VOAaTxBIrqDZnV/4QEF2mxOJKe1jeVD4HS1DP
         RUJP1gdkoCGAYorF/l+k4OlKDxTOP2GvWEuYX9j+NP67H27WzOlMA0n4CWTEahE0diQg
         k7sc8jN8uEEaJwSey9HtSeCcrVgVl/iwFmXBkd/LLBBiMzdIWOlDE/oFpJ8d3pAXL/lp
         21DfcwbQwyAGm1ehj/SyjAqWSt1sSCVUnzw4pNv+QraqKKV2p4pbKO4f5WDHAULY7byP
         4lYJq4MigeUHduE+omI0N+ZEOoNygz/+ocATuXtMgoG/Bnbf1db2/8jNEo2J3rDUF9/Q
         MEDQ==
X-Gm-Message-State: AHPjjUg/NzqXefndySFRGcbE++VfSIIPzuqli0FfzPJ43R0qAj7fD8MK
        dYtADXr3K7Gqure84Gm4DNJh4CWBo7HL
X-Google-Smtp-Source: ADKCNb6WL8Xn6GWLTp/txyFsqA0ek817Njbs3sWinFrN1LffGeNwEOXP1T9jp6mIcYRomx4PFx9nLyjVescK2aewP6w=
X-Received: by 10.129.69.34 with SMTP id s34mr547668ywa.29.1504816731653; Thu,
 07 Sep 2017 13:38:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Thu, 7 Sep 2017 13:38:51 -0700 (PDT)
In-Reply-To: <20170907091734.nsdpo2dpcgvf2zna@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net> <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
 <20170907091734.nsdpo2dpcgvf2zna@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Sep 2017 13:38:51 -0700
Message-ID: <CAGZ79kahVcKY3mJdZAP3jWCBY58VbCTHCfaonTgP7TDYrV+jag@mail.gmail.com>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false positives
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 2:17 AM, Jeff King <peff@peff.net> wrote:
>> After having a sneak peak at the implementation
>> it is O(1) in runtime for each added element, and the
>> space complexity is O(well).
>
> I'm not sure if your "well" is "this does well" or "well, it could be
> quite a lot". :)

Both actually. When I wrote it I thought the phonetic interpretation
was way too funny, but nobody can hear subtle humor on mailing
lists. :)

If UNLEAK is used correctly, then it sounds more like
"this does well (and we cannot do better anyway)".

> It certainly has the potential to grow the heap without bound (since
> after all, it's whole point is to make a giant list of variables that
> are going out of scope). But in practice we'd sprinkle this over a
> handful of variables just before program exit (and remember that it's
> copying only what's on the stack already; so pointers get copied, not
> whole heap-allocated blocks).
>
> Plus it does nothing at all when not compiled with leak-checking. So I'm
> not too worried about the extra memory usage or performance.

me neither.

Thanks for starting this series (I am really happy about this solution)!
Stefan
