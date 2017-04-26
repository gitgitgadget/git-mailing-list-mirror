Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72354207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 13:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3000376AbdDZNTI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 09:19:08 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35341 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1953066AbdDZNTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 09:19:07 -0400
Received: by mail-it0-f48.google.com with SMTP id 70so38287882ita.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3Gu+9Ut9rr98QxSKjFeyHjmGYBk6uwDRwWK1PCVSvOc=;
        b=ra+e+f2B5wiSwpa+5pFtNiCZHOwmTHYHvIZN0rz6gEOcAAPodh+tKbBu5TCSR7375m
         G5yTm7tL/+JNjYHvu9ykKqSIj5gFuLod/y4ipx1ccojvp1vkX60nlQY6YhaqjtvDQWXa
         5er0lHCprE8Tk70wKPABtVJHCJlR6D34dbIruVPaZyAzZAr5TOkZ/t75U24gl2wjlPT3
         6oDmLDON8fodDirHXhpQ1PL5gOJ7lbUXzWBQGxhcHDSO7Sbs/byV5sclhRRNvs0PR+rs
         tG/aObnSW1c3UOyXjoXON2t3BqOD6F2CHOitdmcS8p6O2ihO5mKX8wy2Gr0y1zegtyJ0
         VwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3Gu+9Ut9rr98QxSKjFeyHjmGYBk6uwDRwWK1PCVSvOc=;
        b=l0DerhYGWQmsYB4rSig2ZRVDfvMLRWc4tYvH17jIUPqiBFZC+hMCMjLbaa2WLjD09N
         3ez7sCRX23frQzQ+0TRr1tsAsOw5aZWhRlTxxFm0FLID9L2mT+Kss9ebS3ejGTWRSavV
         MHkfYniSq+nL3ExmCS/hxwCnjddqJq7XQHCypBrSf07xI1isW3eU0coCCvnJhMqvqSOC
         IpQG3tW2Oe1U86EO/uaX/KepVmlh0VE8q4uldm9YppLZ7A+zEoPz5C40a/bwP0bOCW6V
         25w6taEMt8pDa7SkcKI3VSUNDO8FJdsCPrB8bqL80lM7jpAN53FDDi8EI9QCicMdKtUv
         +oZA==
X-Gm-Message-State: AN3rC/4MDsK6+CgsqNYtQBvL+NJojf6M++JWYcBSL6D3EYUZcxgJvKz8
        uEuWfdpxXrrPyTIf5BX1IJ/8cEKG4g==
X-Received: by 10.36.54.129 with SMTP id l123mr10808110itl.50.1493212745048;
 Wed, 26 Apr 2017 06:19:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.88 with HTTP; Wed, 26 Apr 2017 06:18:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704261131500.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
 <cover.1492771484.git.johannes.schindelin@gmx.de> <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
 <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704241226440.3480@virtualbox>
 <xmqqr30hw31s.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704252208520.3480@virtualbox>
 <xmqqvapsszoo.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704261131500.3480@virtualbox>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 26 Apr 2017 22:18:44 +0900
X-Google-Sender-Auth: SOv7cwuC3w4Gz8OJtjq2RpSh32Y
Message-ID: <CAPc5daWzotQZoVQ40pmWrgWSPwrcgqEqAcEbjRcJ-Ev_9a73AA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(in gmail so pardon top posting)

As I said, this series does *not* tighten the existing code anyway, so
it is not like something that used to be accepted are now getting rejected.

Happy?

What I was worried about is actually the other way around, though.


On Wed, Apr 26, 2017 at 6:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Tue, 25 Apr 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > In any case, it is a question unrelated to the work I performed in
>> > this patch series: the raison d'=C3=AAtre of these patches is to allow
>> > timestamps to refer to dates that are currently insanely far in the
>> > future.
>>
>> Yes, but the job of the maintainer is to prevent narrow-focused
>> individual contributors from throwing us into a hole we cannot dig out
>> of by closing the door for plausible future enhancements.
>
> You make it sound as if I made the code stricter in any way, or even
> introduced a check that was not there before.
>
> As I did no such thing, you may want to reword your statement?
>
> Ciao,
> Dscho
