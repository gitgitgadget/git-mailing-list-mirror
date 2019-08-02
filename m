Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33211F731
	for <e@80x24.org>; Fri,  2 Aug 2019 10:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405208AbfHBJoP (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:44:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41151 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391632AbfHBJnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:43:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so35768100pff.8
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AABoQpZ1uluEAYbjcX9/x7SZFP9bElR+nLUXqC9p40o=;
        b=VpWQh1Bqd1x1RAoGMbrk0PxAZ/BjVeg/pRKjb0hb8k4OCZr+4U7zEriEi4FOU8aVgX
         OQuuy+VXbEFndxGqLqxZIgQosXVvuHw5TuJvQaA8c+vt1W8eJ5Pyu66LUCL2+kqHW825
         H5CQkPpYeLTX7R9EmRtgBBRPSR7KC8fmD47LvFUg3a/IFYp5XJ13M3p15ewSpSSBm5+F
         UDMYne57v3TUICeH5WFVJB1l/TJT0psVszTJFfzt5FHIaiQBcPLbdoopzX2Wqr616rlx
         tEKeguqEYYwYXn2eptlWiWcMorUZejyQWcw4InfD0e+SmpN1pec6r44h/jtXG1Vq8pjT
         zwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AABoQpZ1uluEAYbjcX9/x7SZFP9bElR+nLUXqC9p40o=;
        b=Pi8VD7u1VvJpZl8awEX+8b1NllclfPhwfWWlVp99cdtFm2DUQNjX2ZRD+M4BrOu+G0
         WAF9tpf2S8B2uSsEA6/+F6NQ8YYIlWbzSOciAmjR5tGdDcuvINjWBg8AzmB+PqWgzoIw
         l9seB80ThHvyLx9SEBRML9Moxtl03KF8twtgyMLVdO0lDg56WJQQLQSJjFrItcrbv5m5
         bNgxf61fdJfrusv8gkdxh2Es8fFau7kvEaDPYnspeSnldMCv9nOGa9j4j7VXPZVuEcU1
         EXAW1XbR7Tx+oW+m0XHWemJ3KDnR84cwoT5eREv3ZpNK1+FP5IBZWxSIZOIRFnr27EcK
         oTbQ==
X-Gm-Message-State: APjAAAVOJ2P3zhy3GV6jr9pIaqzvGdeXGRfVBNpejLknHkHOUV80grbe
        FFeV5aEM2t/eE4ttfG96pGvkvdWBpY1sF8Ls1Io=
X-Google-Smtp-Source: APXvYqxRNorlWpWpZvx+3TeNOuuo5COpn2ABeNibEizxK9qXpFp54unaJtmA66fEg/LdtNbExAbc1n5jT3MIukmtILQ=
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr3421608pjt.108.1564738992799;
 Fri, 02 Aug 2019 02:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563490164.git.steadmon@google.com> <cover.1564695892.git.steadmon@google.com>
 <f0476b2b1e1e1f1d528b94523e86f210ccbd7dab.1564695893.git.steadmon@google.com>
In-Reply-To: <f0476b2b1e1e1f1d528b94523e86f210ccbd7dab.1564695893.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 2 Aug 2019 11:43:00 +0200
Message-ID: <CAN0heSpyS6T-T8ueZc6L_zrgLrutf6P_pNYe=KJ+SpF+ycgfmA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] t7503: verify proper hook execution
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2 Aug 2019 at 00:20, Josh Steadmon <steadmon@google.com> wrote:
>
> t7503 did not verify that the expected hooks actually ran during
> testing. Fix that by making the hook scripts write their $0 into a file
> so that we can compare actual execution vs. expected execution.

It could be argued that this test is perfectly fine as long as there is
just one hook to choose from, and as long as we're fine with failing
tests being a bit non-obvious to debug.  Since we'll soon have two hooks
to choose from in this test, we really want to make sure that we're
executing the right one, not just "at least one". (No need to reroll,
this is just me thinking out loud.)


Martin
