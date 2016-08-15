Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49B31F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 23:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbcHOXKC (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 19:10:02 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33565 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbcHOXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 19:10:00 -0400
Received: by mail-yw0-f195.google.com with SMTP id z8so2859904ywa.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 16:09:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n3QrMHGw/QbI9Sx61z/CLhVsl9wPa1mvai02y6DhZ3Q=;
        b=pGJlwuZuQCamXebf+gmtEuNx/ocTcX+Go0Eyf2MzAPDtEstSOIVnQXznxBXs4H6tB6
         UPOhoBUsiNQMon9trZKG5htEIPAwSj5jBsWl5DqGn0WVEPtqkvCTX+tLVnRX/bGiZ2n2
         MWsDLOz/sMgwfhounFk3TPht46YFbAJ0G3xTmJYOG8IX7u4uGslQxiR7utfQiR8jpLuE
         m+4BfsjE1GQ4wLHAtBrdzG5rhU6tgXH6OAB62xuKid/Oj36HTHhgQlE0YahsHXTxktOG
         U9ehiOYY2CMTIaGD4XAKbGo24ugDOO/DD5TwP1zhU3RVNiS/4LLInrAcayTLMuxExZmt
         jSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n3QrMHGw/QbI9Sx61z/CLhVsl9wPa1mvai02y6DhZ3Q=;
        b=mv4MlbnGiE44Q1oAICzhbW/XNRRO8OBfSdLlYk5YfBSUZDK3LjGK086fcLman+qXjk
         ecR9vWaOPFfWzwPNAArPhRFa1kQb/5ptbvu8wq734C/Irgqu3AFh+ByHZNdjEsOFqiOh
         3uR1faiq4rIpeJbE7yuzOAik5d4jxE4GY8yD4lICeorkpH2Ck3Pemi2MTsqKny3iHO9p
         SNfsKvVz056eEzxHqZ0Qc4g4u0gu6FEz2T3UfHDtqcUxbAhPk9M+63nIG1dqTaZPgE2p
         apOw22FUoZevOJ/qh1rJD5zwlhSz6mbNFLzW2qfHP2hw/+5VIAAI9hGasD5/y/+vVyb2
         +o3w==
X-Gm-Message-State: AEkooutHRX2bnVhLfJmyY95jjJ9sNXC11Q3aKk76pfgAuOmOcj8ix9NVHnjxA4Yyv2CuVMeL9bU60c2cLDN6Uw==
X-Received: by 10.13.249.135 with SMTP id j129mr24057268ywf.267.1471302593720;
 Mon, 15 Aug 2016 16:09:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Mon, 15 Aug 2016 16:09:33 -0700 (PDT)
In-Reply-To: <xmqqwpjihwkz.fsf@gitster.mtv.corp.google.com>
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
 <20160811225946.18381-2-jacob.e.keller@intel.com> <xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoX6AT7tGb5AJr1CSjzAQ67o8QXJFF1LxsV_7E_pF-moA@mail.gmail.com>
 <CA+P7+xq+GTbvzOtVvpu4_rdYYy-hhGZHhpk_ka=KkeU7UmQRew@mail.gmail.com>
 <CAPc5daVmyx+EX8H0yETfO6Vv+A7DqBM5bsqrnJdYzbEhVnA1wQ@mail.gmail.com>
 <CA+P7+xp_sPk6P1qyyDfOgpkXU1GxWPivfSzvveS4PAvGb-=ggQ@mail.gmail.com>
 <xmqqa8gfkpw1.fsf@gitster.mtv.corp.google.com> <CA+P7+xr9RcKQ0uO_F7CtK6nsz83KH0OqpFaBVnzL1jqyP9YfSQ@mail.gmail.com>
 <xmqqwpjihwkz.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Mon, 15 Aug 2016 16:09:33 -0700
Message-ID: <CA+P7+xq7cEjAeW720gtKXm==8rrfOdJu81efJdtEmsXfv7E4Vw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in
 a prefix
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 8:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I will look more into how to do the log version tomorrow, if I am
>> still stuck I will re-work the patches as you suggest here.
>>
>> I am hoping I can find a good solution for how to handle it though.
>
> Thanks, I am hoping the same, too ;-)

Ok, so I found a way that (ab)uses the graph API to enable line-prefix
support. I moved the way we handle diff prefix into the graph callback
handler as well, and I also moved around some code so that the graph
API will work correctly. I found several places that actually broke if
you tried calling the graph API with a null graph, because they would
still try to access the FILE* pointer inside and could lead to a
segfault. This should fix those up as well.

Hopefully this is along the lines of what you were thinking, and it
should allow more advanced calls to a submodule format that shows the
full log if we wanted.

Thanks,
Jake
