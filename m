Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E491F991
	for <e@80x24.org>; Fri,  4 Aug 2017 04:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdHDEVt (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 00:21:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36977 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdHDEVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 00:21:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id p13so688128pfd.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 21:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Ft1niT2jGRaJv9dtj/dPZnR0rkgadfYcRxVzHDKdso=;
        b=eV6rWi3bYiR4C3E5ZAlzoWhdK63ySVof6HSDroQabGyJs6okrC9n2rZI2dD2LYgmI0
         3f0AKzqa0O7uSNEPU0q8sl6qZmP6UcXi6sNJYCs2avdrXaZDSL132/QrQpEDqL730C6e
         CEV/VXJbTK2MwMWfFr0jjWN5ATIahsZ4JPpbCR/pIVyWNI2x5nwZnreA83CKmpoKY/Lx
         oOFbPBEXPpRQ58zfw7KwLWpRkHHE/gqAFEli4RYju6b8sY06c5OZQZpirAR/mm6eyKFL
         GsW1Q3AgQWTwbiSMoU2hsBIHbm6EJYfgFxYe5UN4TfddpHotnTn3K28RRRzg8hnOzp4M
         R9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Ft1niT2jGRaJv9dtj/dPZnR0rkgadfYcRxVzHDKdso=;
        b=CMgoOJ28y9A6xNxTEEmHIAf8svxwVuTFufTn9/AuPqLu7+2vVTrr+g7Vlivxx/hMv+
         VPy3fk86sbHF1JSxm37m4198wnLY9oLpumXdYacv6OQ12L/SE0oNh5zAtPfPfAcWLINz
         s76gzYewjBTl6o0lyVazFgyUB/g+V28hmvMKouVV2D6pq4z7XZT8aoLvgQ1J6oKLwwID
         RX0WPvLSKCw44t/CsHYCUlpUKo9MSdeVwFz9fpRJ335cnDcR6k1w1ncqAiQnvm5KrN/0
         +x7z7aJd+122UK7TbhjkL9yLCeQXwvfKFxMer0ruCpA7+g5Gg+/Sro2mebe+na09Ci6T
         7Jvw==
X-Gm-Message-State: AIVw113UdSQcrxc2d4xG6BUL+snf54JD+E9NRn1suMZizbzzOlS5u883
        r7qL2hqmB0iOBKmSNkRnmuoJB1v4Uw==
X-Received: by 10.84.231.131 with SMTP id g3mr1158480plk.283.1501820508455;
 Thu, 03 Aug 2017 21:21:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Thu, 3 Aug 2017 21:21:47 -0700 (PDT)
In-Reply-To: <20170803192947.7x5tadwb7lxermdk@sigill.intra.peff.net>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
 <20170803192947.7x5tadwb7lxermdk@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 4 Aug 2017 06:21:47 +0200
Message-ID: <CAN0heSpzg4jCMetyhdpQn2Zz7nDhv1X14SLQ26WvnRDe9NYCCg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] tag: only respect `pager.tag` in list-mode
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 August 2017 at 21:29, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 02, 2017 at 09:40:48PM +0200, Martin =C3=85gren wrote:
>
>> This is the third version of my attempt to make `pager tag` useful (v1
>> at [1], v2 at [2]). Thanks to Junio and Peff for comments on v2.
>
> This looks good to me overall. One minor question from the interdiff:
>
>> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
>> index 8b2ffb1aa..9128ec5ac 100755
>> --- a/t/t7006-pager.sh
>> +++ b/t/t7006-pager.sh
>> @@ -162,7 +162,7 @@ test_expect_success TTY 'git tag with no args defaul=
ts to paging' '
>>  test_expect_success TTY 'git tag with no args respects pager.tag' '
>>       # no args implies -l so this should page like -l
>>       rm -f paginated.out &&
>> -     test_terminal git -c pager.tag=3Dno tag &&
>> +     test_terminal git -c pager.tag=3Dfalse tag &&
>>       ! test -e paginated.out
>>  '
>
> These should behave the same, right? So this is just a style/consistency
> fix, not a bugfix?

Right. I realized I was using "false" everywhere else.  It wouldn't have hu=
rt
to exercise the config-parsing a tiny bit differently, but I assume that's
already being done explicitly in some other test, so I went for consistency=
.

Thanks for all the feedback and thoughts throughout the different versions
of this series. It changed quite a bit since v1, so thanks a lot.

Martin
