Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D01520191
	for <e@80x24.org>; Thu,  4 Aug 2016 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201AbcHDAyY (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 20:54:24 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36493 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933127AbcHDAyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 20:54:20 -0400
Received: by mail-io0-f173.google.com with SMTP id b62so259019168iod.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 17:53:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2kU+2QFqQByUavlA6SMrBJMt+HQSRv32cxu5Yl+MKls=;
        b=pGUAsvVvuIALq4ZDcZGIVqyu3aYG9GVIHHWRoao+iwc1nzznsZPOjQXwSRbGl/K2h8
         hb9j1OHuspKGCH7eKKZNhuVBBtwiTzdUXj9VXirwCKxLy2CrmuBpu+0xqivHtBFREov9
         xuaXseDRXLG1klWR5ftKUNQ5JaBMDxt3dvj994rY3beoZhtapGYWEM9f8aIDX+BcBikK
         kOX+w4YHdIWEpdgaR0K9Z4FMH/lyUD1ZdJqAxXZFwkKCzeH+tuecpO73ykuXXuBzEY3/
         PEGiysuvkE5w9q64khxrQT8vVDqcD0/3QwL/HKHFJddvvr9XTW9GCQW9bb+2satFLLal
         mQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2kU+2QFqQByUavlA6SMrBJMt+HQSRv32cxu5Yl+MKls=;
        b=AeBb0GQyTnp9g9FwUkXnVOLDwKXcKEwVnYJI3EMZB2qZoY66mKm7DM++q3Jich+wm8
         pgV1jzYueHSNcIjzVc5DFIg5yWXs3HF/Sjbq1GH3GPVZsn3gBw6YeyDzwfeAWPjwOQM6
         6V2Md153yFj42oLZcyx0OTiKkbO7pq8w9ZZIYocQSqLs41XqfTqyazrZG8eB0aneBANY
         z76p9yMXBnAW9PFZntVtSmRG1Lm718BVaJI4Ts19hLuvbZ3Nr7y0im2SIruKYY7q2MIj
         vH5htY68+lKC4KYf1XxlolYDCDOAh/Cb1bMRpmsCzM3tQnmwksAvWqc0lJOKcjMBLzCJ
         X9Ag==
X-Gm-Message-State: AEkoousjGUoFjxtVK3amWx1k1T69xtgdtml/4PdzDWDY1SY/OoXsWmKbVs0Z5Pl9hnpAi+KUO44iZTt8OlH12w==
X-Received: by 10.107.17.147 with SMTP id 19mr80320778ior.22.1470272036898;
 Wed, 03 Aug 2016 17:53:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.6.212 with HTTP; Wed, 3 Aug 2016 17:53:56 -0700 (PDT)
In-Reply-To: <20160803180820.2raazmsfjavoaogo@sigill.intra.peff.net>
References: <20160803084743.3299-1-judge.packham@gmail.com>
 <alpine.DEB.2.20.1608031621590.107993@virtualbox> <xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com>
 <20160803180820.2raazmsfjavoaogo@sigill.intra.peff.net>
From:	Chris Packham <judge.packham@gmail.com>
Date:	Thu, 4 Aug 2016 12:53:56 +1200
Message-ID: <CAFOYHZB080T51QYLaaJasoaJyBycjTRBrNQ-Gh2fitz-fcS5Sw@mail.gmail.com>
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 4, 2016 at 6:08 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 03, 2016 at 09:08:48AM -0700, Junio C Hamano wrote:
>
>> > However, I could imagine that we actually want this to be more extensible.
>> > After all, all you are doing is to introduce a new rebase -i command that
>> > does nothing else than shelling out to a command.
>>
>> Yup, I tend to agree.
>>
>> Adding "sign" feature (i.e. make it pass -S to "commit [--amend]")
>> may be a good thing, but adding "sign" command to do so is not a
>> great design.
>
> I'm not sure what you mean by "feature" here, but it reminded me of
> Michael's proposal to allow options to todo lines:
>
>   http://public-inbox.org/git/530DA00E.4090402@alum.mit.edu/
>
> which would allow:
>
>   pick -S 1234abcd
>
> If that's what you meant, I think it is a good idea. :)

That would definitely suit me. I see there was some discussion of
which options were sensible to support. --signoff and --reset-author
would be a good start from my point of view. Maybe that's something
that could be build on top of Johannes work.

>
> -Peff
