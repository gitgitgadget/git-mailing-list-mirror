Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD801F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 05:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeFBFB7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 01:01:59 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:45261 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeFBFB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 01:01:58 -0400
Received: by mail-oi0-f44.google.com with SMTP id b130-v6so24185259oif.12
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=75cXvo16/vsuKIK3v0SDe0Yu3Vy5PU8kHHDPrQzRVlU=;
        b=EO8cw5yhwN+1k6v91Pt5VbRINw9E+wZXNfgivw8NkQ+R62NNubTqyvKl1z4kma/7i1
         t0Mbapk0AMTWL3M+tOXKCs0TiF0bZMu2bOZpYTyMCHTeVqn7RlbaU5dtO/6deyoKVm0N
         YktEiTHeGyFVvkJmDz1HAxqyeY+s2gfUWzL3S8nLHR1PFtFr07oFLbHALfImvxn0FFJb
         YIq4wnwZ7AtpEVz4VbNE2fplZ46bAweTW76qeFVAqCzan1I5LTc84H6+4BJzX6ajTKHZ
         fnXqEP0W2h+WfQTbCgb5nFJ78uIzzklmSbUjx3LE3XU11cCf0g6VLRKPei2j0QDWYW9x
         DZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=75cXvo16/vsuKIK3v0SDe0Yu3Vy5PU8kHHDPrQzRVlU=;
        b=C99w7Sy3g0p810crZb1jkcrv5MybzCsKUAuiG/nGuUk5GjtimCLwMvGfWL7Rff7zl6
         e9UUUpK2h9HJrNFvF4pg4HE3yYb/2lB9UMoE3xvVqdsLpxYmjrwvFyW1q0miYCrLKosv
         21sfouDn5s27m3EAhFMT2GhFwXovFDutnv1ogNyRoLb25ma71qCTghNFWe0g3VF0olqc
         Obc90GN2yEqTRBfDIi4CnFnIoHmu3AEBP8K4clziQPAFCHpAnXjR7QV8TNhSp2xpo5lF
         8ZLjzT/LC8pUJ+CLEGFO+VAZQUDjPVJJG2vljmMMVgwsCg5QdNPxuDmZYGTX5Hn0GKMq
         Q7aA==
X-Gm-Message-State: APt69E1Mpuz/5ck5/4k+sgMlepWPpzPBHTl/w3TFlvqCvhGvJoZICw8o
        vZda+8fhSTSPbhGiXOz2e4IEqpzqDNPgVgaUTis=
X-Google-Smtp-Source: ADUXVKIVnDQVwzAeo80HLSnnN6z9/8Q3T960ZOt6ORetgAg5mVRe+zJ0xXmuwz+7b4TGoZgYNSb4tcS4UYWote5DDDw=
X-Received: by 2002:aca:5144:: with SMTP id f65-v6mr7690587oib.32.1527915718055;
 Fri, 01 Jun 2018 22:01:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 22:01:27 -0700 (PDT)
In-Reply-To: <CAGZ79kbOKPgBPJpoez7S5k7Y6L-+ncjcAvs3MaADLT1z_dv3+A@mail.gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com> <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
 <CAGZ79kbOKPgBPJpoez7S5k7Y6L-+ncjcAvs3MaADLT1z_dv3+A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 07:01:27 +0200
Message-ID: <CACsJy8A4mAuq0rCdvR+JmY7Ghcy4nqVvyQEUNC=7JUY_x+PTYA@mail.gmail.com>
Subject: Re: [PATCH/RFC/BUG] unpack-trees.c: do not use "the_index"
To:     Stefan Beller <sbeller@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 8:51 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Jun 1, 2018 at 11:34 AM, Elijah Newren <newren@gmail.com> wrote:
>
>>> +/* Do not use the_index here, you probably want o->src_index */
>>> +#define the_index the_index_should_not_be_used here
>>
>> Good call.
>
> Is the space instead of the underscore between the last two words intentional?

Unintentional. I wanted gcc to show this phrase when a developer
accidentally uses the_index here (it's basically
"the_index_should_not_be_used_here is not declared blah blah"). Two
words would cause a different syntax error.
-- 
Duy
