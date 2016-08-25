Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADCB1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 20:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757010AbcHYUgF (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 16:36:05 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:36703 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754513AbcHYUgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 16:36:02 -0400
Received: by mail-yb0-f176.google.com with SMTP id e31so20535079ybi.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7UQZzmmIA67PDLp0ByeKqU7DNyUlVS8cudEzugZ1v6c=;
        b=00mj3MJjzb8AGN+NNlDKQkfnUPcgieZ48qzoCuZ1xCvuuMqiC2UceB4ZH3d5Mn/EDd
         R/xQ0d/adW6EOpXf49E7fj5PUQBBeCFghlypoLOiqbWme/pOhAqsdsTqGQ2YtbChlaZ2
         Z4sdKBeCDoW1vdhqgkRwyJzfE0I8rCFIfIIGHy1T8Q3iPXGSY4INIAeVgItVse1s/zL9
         ZU1iZHTM0/wHEL43ASEdblP5nOMFgE2LruFKm0HwHjRF6Sgz24SZlVA4lItNXKjtUlKt
         SGiPjzgpPgUpRcOjpnItv+Gg3kTbFBdunQgQiupEzK87JuygfduELF8dYgsYnKNGtCc7
         GE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7UQZzmmIA67PDLp0ByeKqU7DNyUlVS8cudEzugZ1v6c=;
        b=BH9aRBvhAJ6lcopcyHgOodefg2X0/qNALL0hlKwk65JFzddfLNiRZ4d3VcNao25w4h
         2owAIfsafEtlSCQ4YztZXEeeONuZLPHaGIN/fqnJjVDunzTd0gktlQHybkE7FbDC5Hlu
         2VOBwwicIH7lRdUl5TZdbJFQA3EvMjNgdHqECjL0b0YVwH+01+JTYIO3DuB1j2oZ6Z+r
         3aNnJgy5WSnwjOdC1bIep5LW2jH23hRLBO8U8SAVJTwa9PUZfYBH7QUBljPrl6mZb7Zc
         dPP4PI4icAl4qxHtoTX+KGU6EfNQ9QWKROruHX9aNKB7i70FlgPR0L84UA9b7cAFTNWx
         Jnuw==
X-Gm-Message-State: AEkooutllciIkV2/IuGX5ik8AbwAJ5IRdMpebcVatafDhxr9Mn5mjHOIJS+zwWYpeh60tDOrWTTWNCJ9cuUTtA==
X-Received: by 10.37.110.86 with SMTP id j83mr8420671ybc.136.1472157354581;
 Thu, 25 Aug 2016 13:35:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 25 Aug 2016 13:35:34 -0700 (PDT)
In-Reply-To: <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com> <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 25 Aug 2016 13:35:34 -0700
Message-ID: <CA+P7+xpiHmTBqF1RT8zUd=1g=nKtMiwpH19DyhwLi9ikLQ8t8A@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not so sure about that.  If there is an existing place that is
> buggy, shouldn't we fix that, instead of spreading the same bug
> (assuming that it is a bug in the first place, which I do not have a
> strong opinion on, at least not yet)?
>

I was saying that I'm not sure it is a bug so I sided with preserving
behavior instead.

If it is indeed a bug we should fix it, and I'm trying to determine
whether it actually is a bug here, and what the best solution is.

If there is a bug and we should die, should we also introduce a
"_gently()" variant of these functions and thus fail properly if they
don't work so that we can report an error in producing a diff instead
of die()ing?

Thanks,
Jake
