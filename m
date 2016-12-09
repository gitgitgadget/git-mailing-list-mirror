Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFCF91FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbcLIXwW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:52:22 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33313 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbcLIXwV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:52:21 -0500
Received: by mail-qk0-f173.google.com with SMTP id x190so33531716qkb.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 15:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Y4G6BK5ihvHcsw1K2hrb3tCff1Cg+FMl/be7nOGcis=;
        b=SCyZVCb7m8U4GvMkTqeyqdX6IfYzse7DGDfM0bppBmkatQ7Qt/yC2mtFp+agKH2fI6
         PnOhSt3t1k+tDMTtVkRq2aRK1+clNeHs+/DdjGuF5zltZX+kWNI6INdfSVr0isRyiXsc
         7Nk9vHlPCc+TSIUJRr6SwL/65XWdj83nPT/K488cdV0mXOf7/vtXI5LV8BCNnVwv72rM
         SZL/ZCUgKCoFcaeDDUJU1Iy/wMq8+XMeyisFSS4GbVdR7w4NIPhnP/36M0bu2YftMuBp
         2S4f0t114LVXY/EjdDLMS7RSGhTt4oJZ0e9wvphpYcMbsSsXWRDwP0sSScMEm9FlWaUL
         1DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Y4G6BK5ihvHcsw1K2hrb3tCff1Cg+FMl/be7nOGcis=;
        b=GbHbuyknCfwZdOTgjExuBOVRubq8ijv6ZnB3kf7gQ/fD99ot1OuPOYCBmPfEPrP7ag
         HgYUVxdetq2h1SQ1jjBO8n5XhOvzjH3v6iGFELAkXYyE9WsXCybpR6PYP9ohwA2BEnUm
         7XNEBlv7MfxBtlJVaNO6mPE4Ua2JvQXKM2uzUzNPTyCXqCy3y9k/yYrKL/LpF3SWpKsu
         0okW5gVmgWl5E+RyfepSu+OC06h0+kDvHS6g4YyAO6Ib+pnbbEXSaM8ZL9xOF4O9K9ej
         FlMzfCiMPTX3GmazSTHcPNgOFwRC3Hx4eZl1xJmL1b6CQ4/D0Jqj+r8pSQz1oE4jgfDi
         ZUNg==
X-Gm-Message-State: AKaTC01Ea0ekbAsy6quP1eQHycbrel1y6vitkSBQ6r9XVra4ImScw9qZxkPrzyu2oWivk92vHNoz2qcAOgF0mvqs
X-Received: by 10.233.216.7 with SMTP id u7mr16322736qkf.220.1481327540970;
 Fri, 09 Dec 2016 15:52:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 9 Dec 2016 15:52:20 -0800 (PST)
In-Reply-To: <xmqqwpf8pt0g.fsf@gitster.mtv.corp.google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com> <1481223550-65277-13-git-send-email-bmwill@google.com>
 <xmqqwpf8pt0g.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Dec 2016 15:52:20 -0800
Message-ID: <CAGZ79ka0P0rKF8QH3V0jC-O19eT0oaE+fJLGifbfmm3jC_SijA@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] pathspec: create parse_long_magic function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> Factor out the logic responsible for parsing long magic into its own
>> function.  As well as hoist the prefix check logic outside of the inner
>> loop as there isn't anything that needs to be done after matching
>> "prefix:".
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>
> These refactoring changes look like they are all going in the good
> direction.  Stefan's :(attr:<attribute spec>)path" changes however
> have severe conflicts (e.g. the topic already does something similar
> to this step and calls the factored-out function eat_long_magic()).
>
> My gut feeling is that we probably should ask Stefan's series to be
> rebased on top of this series that cleans up pathspec implementation,
> once it stabilizes.

Very much so.

Jonathan Nieder mentioned off list that he prefers to see that
series rerolled without mutexes if possible. That is possible by
creating the questions "struct attr_check" before preloading the
index and then using the read only questions in the threaded code,
to obtain answers fast; also no need for a mutex.

I did not look into that yet, though. So I think you could discard that
series (again) until I find time to either redo the series or
resend it with a proper explanation on why the approach above
is not feasible.

>  We could probably go the other way around, but
> logically it makes more sense to build "pathspec can also match
> using attributes information" on top of a refactored codebase.
>
> Thoughts?

Please let the refactoring in in favor of the attr series.
