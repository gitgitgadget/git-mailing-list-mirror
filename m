Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7B51F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 05:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeGMGJB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 02:09:01 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45909 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeGMGJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 02:09:01 -0400
Received: by mail-yw0-f196.google.com with SMTP id 139-v6so11334757ywg.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 22:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PglW/z2Vu+DKtsE289Z4gUBTkPV/PwBKnOCOjssdD8E=;
        b=eExOl1hEgj7ikymnerYP+FYAlKc5rhcCpSHLjiHnkq5S2oJm1NSElEd4puw6tfVsZf
         jONqTEyTm9NWBdmZl1OFxnxwCSCiHhQxm96f+d8PPkK3CWK1HTr6nANRlb7PZpRmqRzW
         J94uKaafIGohyIETNoQMoIA906BSq2nPexVtvNX8FqugEUj4FM6qUubaiYbV1Vp5pRT6
         36e8bS610wBhJ+6KOSGT7JJnmi+5FS8oKvCEBIQvUfjewhPI9zeyMyirFWNK4VV/5ZDe
         H8l++E2DAFvSZgm9Tf7s8/9x4uIfEkDk3eNDNhcP4Y3gqvcMcW22HWb9VObAbGV5oNC+
         0t4g==
X-Gm-Message-State: AOUpUlGo+7JfJcdRFPqBipfy6NFJUlSeTt2TfNdMAmmNC3WqJJ5Zz+u/
        1PTVPKr335Il2Dnj9luhZxm67QjO7d9ceG61EKM=
X-Google-Smtp-Source: AAOMgpdm3wLUhIZ8bw1qnstFOOGAy/e1ieBuKVGwItUxlSWyrsr67TJTG0NwnFcXhlZ6Vlr3OKYGSshd9RhPiQS0QAc=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr2614843ywq.120.1531461358802;
 Thu, 12 Jul 2018 22:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqefg8w73c.fsf@gitster-ct.c.googlers.com> <20180712201454.GA6281@sigill.intra.peff.net>
 <xmqq4lh4w6e8.fsf@gitster-ct.c.googlers.com> <xmqqzhywurey.fsf@gitster-ct.c.googlers.com>
 <20180712235156.GA10590@sigill.intra.peff.net>
In-Reply-To: <20180712235156.GA10590@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Jul 2018 01:55:47 -0400
Message-ID: <CAPig+cQXUP-5Rv+p2TuqavG=1HkO0qAZJRvLZcBkg=dB6gdZbw@mail.gmail.com>
Subject: Re: [PATCH] t3404: fix use of "VAR=VAL cmd" with a shell function
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 7:52 PM Jeff King <peff@peff.net> wrote:
> (I do agree that being able to automatically catch these with a linter
> would be worth brain cycles, but I cannot immediately think a of a way
> to do so).

Perhaps something like this[1]?

[1]: https://public-inbox.org/git/20180713055205.32351-1-sunshine@sunshineco.com/T/
