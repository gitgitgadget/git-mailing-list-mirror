Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601A31F576
	for <e@80x24.org>; Tue, 30 Jan 2018 10:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeA3KWt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 05:22:49 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45455 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeA3KWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 05:22:48 -0500
Received: by mail-oi0-f67.google.com with SMTP id c189so6692491oib.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MNDvudeeH+LNaYu+XJK4NYz6DfcWGiWY1idK1Gw5Tto=;
        b=LJrseOpGkQwWbABbEagwoWQDtMa0/o7jUeG6xB5ZDglW5EYrN9x9F08F5mG+y2jVDW
         Z0that84v3FROM52rC1n8k4xlTo2Q5EGaG1Fad/o5hrrlUHQmKaRk7+UOaaU7kBFhRt7
         KFzBLjZRZxoJb/Oqbo4m5RkBnPn2puGKhzrfKSsq53qbMGmlluJC17DJ2V0uNahLgAQs
         tH5KR8OB0IKR6uIwEuCQIN6EuW2K7C1+WNeSwb0RJI9nNwPFGC8tCfE78fFkomCYdJyi
         M8rlTLCw6+sqKuc1/TE4POF4tpO3gNwsEZeqvDPyaXV/gEN4t2ftJj6umALaLmJUxLow
         SU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MNDvudeeH+LNaYu+XJK4NYz6DfcWGiWY1idK1Gw5Tto=;
        b=liKxuQfJtNhiY393GJlFSivCsu/m8ZfhkyUi7Akl5Pq6BCkY6z4JJEX2jQnNDeTWUA
         gIhlCBv43s72w5Otqu0G40mJ3sNEhEQHsELc+LAM/V/84Nu/wx+IxMWZyjPgyiC4eeut
         ljHKcnhKHs7w7bnr6x2Y67N+L2hRgNv7CyWCo6EIKfSTQFa2r70is73UggLz7+NobXXs
         Yd0y5tXzeec8Nlvp186/vd5pi//KNTcFabEy8KHeJ552bDUt2n+OxGgni4mWWSQovdgl
         VBoMnJfIc5WnGB3Wv11HELw8aCCL4GRNKFu/cmN99koyGACysmFm4gDD0HdxHMHJjxLp
         2Wyw==
X-Gm-Message-State: AKwxytfznq7XeGPcQdjV3+g8MMZmoQ21w+sh7hacJ3RnrZTCbZ/Cmj12
        5vvgKLr8Sf2U1DB6QsyGSXhwxd+BRtxSXlfyKEk=
X-Google-Smtp-Source: AH8x22647p4+J9jZP4avTtbGjcdwKhaqheerMOzHdi1/+jbnd0G6bIrXL+2WqslF311WEyC/hGFujpDIuTWFgfIwNxQ=
X-Received: by 10.84.78.139 with SMTP id c11mr19617894oiy.297.1517307767453;
 Tue, 30 Jan 2018 02:22:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 30 Jan 2018 02:22:17 -0800 (PST)
In-Reply-To: <20180127164735.GA23478@sigill.intra.peff.net>
References: <20180122123154.8301-1-pclouds@gmail.com> <20180125115927.16196-1-pclouds@gmail.com>
 <20180125115927.16196-3-pclouds@gmail.com> <20180127164735.GA23478@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Jan 2018 17:22:17 +0700
Message-ID: <CACsJy8B_LzT1UqPmFg72SbQ9c_c5U6y+Yjv+UMFBz+vaXeE0AQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] format-patch: reduce patch diffstat width to 72
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 11:47 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 25, 2018 at 06:59:27PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
>> index 9f563db20a..1e62333b46 100755
>> --- a/t/t4052-stat-output.sh
>> +++ b/t/t4052-stat-output.sh
>> @@ -60,7 +60,7 @@ do
>>               test_cmp expect actual
>>       '
>>  done <<\EOF
>> -format-patch -1 --stdout
>> +format-patch --stat=3D80 -1 --stdout
>>  diff HEAD^ HEAD --stat
>>  show --stat
>>  log -1 --stat
>
> This hunk confused me. I think what is going on is this:
>
>   - we have a loop that runs the same test on several commands
>
>   - that loop expects format-patch, diff, etc, to have the same output
>
>   - now that format-patch differs from the other commands in its default
>     length, we need to use a manual --stat-width to get identical output
>
> It seems like that kind of nullifies the point of some of the tests in
> the loop, though, since they are meant to check the behavior without
> --stat.
>
> OTOH, I think that case is tested later (in the other tests you
> adjusted). So I guess these tests are just covering the "name vs bar
> length" part?

My bad. My thought was.. "Hmm.. I would need to take format-patch out
out the loop since it won't match exactly 80 columns anymore. That's a
lot of work. Hey how about using this opportunity to test that --stat=3D
can still override default settings?" I didn't realize the follow
tests in that loop set stat width. I'll take format-patch out of the
loop and deal with it separately.
--=20
Duy
