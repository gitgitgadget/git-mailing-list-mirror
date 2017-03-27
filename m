Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED2A20966
	for <e@80x24.org>; Mon, 27 Mar 2017 07:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdC0HfZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 03:35:25 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35876 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751931AbdC0HfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 03:35:23 -0400
Received: by mail-it0-f50.google.com with SMTP id e75so11659027itd.1
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=752A16trdW633PuOUJyRvQIKAU8uDOxpyR5kGc9c8IA=;
        b=O0zy+qVIoERushsHSAiXYREsXev6NDKA853rPr4QK5114Q/k/gP4Y1i0vEoZnpIms6
         /OsX3sXQRRzXPmPgEicDbI8HGAjSMe9byFEW2DIw2NSJf444FJgofKNQdq7VHJ+GFRho
         rah9ysXOg2lIFrJsmggXkpZ+jzHKwED42Fbz9LktIk02POt4uyuLl0cdfNylEAkMLW9R
         3EAJtkYhprpCcLHpX+A3YRIJydpWg6n1Mfcl/VUzhEzzrXXbGYu3yGWdrBttEsrdnYu4
         GEJjhLAP9FXxkIe7hJxNogg1ZhqHl8MnEJmBsIHRKtMj9PDeJY6lzOa0Qjiu/waOpAWC
         FLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=752A16trdW633PuOUJyRvQIKAU8uDOxpyR5kGc9c8IA=;
        b=JaNa4wGbK3o7Do7NRTyVf5MBZAfvgAcVJeH9PQVwWpawqXhY59PPYER3PF6aOQpSge
         SZ3IuU+UHkV50qMgsw0odM9JrO1R3thlsbgqYfX2CGtXvpNrlwklsz6BJUaqPHHMLuwh
         9hu4KccXEe2o9idBe8dMx5RFBMK9FmPDUv+s45tjiOji9qCTtExnFO12MbjQhAcASP7G
         NXG3dzYC+Ygfm8cWcQZokP7+ReXEfEVmOn4gb1buUB0NGqfcl8oWCPzp/f9+zUwrgcLl
         VVSXXvBRpEOxvDsGoi5XRMXNc6OSQxsWSC1QDi6b53cGA2mId//dzSje8VL/T5r5yQ2t
         mOCw==
X-Gm-Message-State: AFeK/H3+V1Z3uMUBO8jAdJ2JjZQNoSO3DmmY6e7zZx96lXYnlYieXeMGDoIk30GHBjUBh9rrAcqV63KNhqTd9A==
X-Received: by 10.107.150.201 with SMTP id y192mr22655039iod.33.1490600060257;
 Mon, 27 Mar 2017 00:34:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Mar 2017 00:33:59 -0700 (PDT)
In-Reply-To: <20170327025818.pbm4nwqrfolyto7g@sigill.intra.peff.net>
References: <20170326121654.22035-1-avarab@gmail.com> <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
 <20170326121654.22035-4-avarab@gmail.com> <xmqq60iv4ku2.fsf@gitster.mtv.corp.google.com>
 <20170327025818.pbm4nwqrfolyto7g@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Mar 2017 09:33:59 +0200
Message-ID: <CACBZZX78ppO5M5oGEDxoHxs5VtXpLRf9ivNxmT7bGw_5aQa8qA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rev-parse: match ^{<type>} case-insensitively
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 4:58 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 26, 2017 at 05:36:21PM -0700, Junio C Hamano wrote:
>
>> It's not "potential confusion".  This closes the door for us to
>> introduce "TREE" as a separate object type in the future.
>>
>> If we agree to make a declaration that all typenames are officially
>> spelled in lowercase [*1*] and at the UI level we accept typenames
>> spelled in any case, then we can adopt this change (and then we need
>> to update "cat-file -t" etc. to match it).
>>
>> I do not at all mind to see if the list concensus is to make such a
>> declaration and permanently close the door for typenames that are
>> not lowercase, and after seeing such a concensus I'd gladly
>> appreciate this patch, but I do not want to see a change like this
>> that decides the future of the system, pretending as an innocuous
>> change, sneaked in without making sure that everybody is aware of
>> its implications.
>
> FWIW, I cannot see us ever adding TREE (or Tree) as a separate type.
> It's too confusing for no gain. We'd call it "tree2" or something more
> obvious.
>
> So I don't mind closing that door, but I'm not sure if a partial
> conversion (where some commands are case-insensitive but others aren't
> yet) might not leave us in a more confusing place.
>
> I dunno. I guess I have never wanted to type "^{Tree}" in the first
> place, so I do not personally see the _benefit_. Which makes it easy to
> see even small negatives as a net loss.

I don't either, I think this patch should just be dropped.

As noted in the cover letter[1] I carved this off from the rest of the
series just in case anyone wanted this, either now or in the future.

I originally implemented this for consistency with @{U} because it's
another thing that can be made case-insensitive unambiguously as far
as the rev-parse syntax is concerned, but as you/Junio note here the
tree/blob/object etc. names exist in a lot more places, so just making
this particular thing case insensitive wouldn't make sense, and has
little benefit.

1. <20170326121654.22035-1-avarab@gmail.com>
