Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856A01FAE3
	for <e@80x24.org>; Wed,  7 Mar 2018 10:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeCGKUX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 05:20:23 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:36271 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbeCGKUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 05:20:21 -0500
Received: by mail-ot0-f176.google.com with SMTP id 108so1568091otv.3
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VA/SB8hja5y9RmMr0YWwnQYJGgMBXS5+mMXWNH59B+Y=;
        b=dHFj+DjI99clwUQgOjffbQPeMTumU94oysQvy6PCkOtQ7ioW0IhxTSi4XYtg4IHx6U
         fAoEuSnCEC50f0SqvcQjbpjkiCPDNx7OeL78oW5K23Z8GmEilOd498sbu8LvlzTKqygD
         Y89yBNCDwqpFfR1YCHANeQwMQvagBL5NUcnNQjeGoURyHxSWjHR0pnXQjbyeKP+dq0ng
         mLnGWfvHxPOGOzm6asQ2iz8amo0iOKJ6COYENMCaSjyDj26mf143bh/bk9SOQ5100Cdi
         Po6gT9GJa4BLekMWFcaCSO24HYC22lTMkGSTP6N1mCqmg6qiUHKrSp4ks6KHI8dy/V7Q
         tqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VA/SB8hja5y9RmMr0YWwnQYJGgMBXS5+mMXWNH59B+Y=;
        b=jmkabvh71sjsyhQRjEgd3r/JzhLGko0OB7pwTLOQYrtfadc32sDkLzKov4FnJaODq+
         6YJUMYaGSHrVefkDQb/vy+LtIu4gjSlaIFf97O8UwcHMcoRpU0KM47xQMysbFlsgyJrs
         TJif6ZCAQEy39rRI9eNCgJfexBLuW0nNUn8Qu0348XX4hQJsO56U52K/53eck4dfIaRY
         ZOhOWFNAJR+NdDyX5XywmRyMt53/qdZLKQZdvqzzEKOYMAcZZcaHKx19xvP4tBnNhrIF
         OzWGFZDyyiLXhSrGUtS5PEoI/4qhFUKWwpViAGsl+IAtcs5/1CqGofefFfcxAcBVgyLH
         RDcw==
X-Gm-Message-State: AElRT7FS2jxgX6p3YrA7dEpVj77nHHhc2O15KhADqgD/p+P9EtiBQmBb
        914Fr5n9psL/Sjp/OpVfZedfC5GMDUjxgKQUeko=
X-Google-Smtp-Source: AG47ELsOYijx9F/8SBsF2J6aKL/0sAX3c3Xc6S2fae/8rOhMlEFNXQcDzndIzHPYddVfLUR6DP8JvKCGL7SScVesrbc=
X-Received: by 10.157.11.4 with SMTP id a4mr15923917ota.65.1520418020734; Wed,
 07 Mar 2018 02:20:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 7 Mar 2018 02:19:50 -0800 (PST)
In-Reply-To: <xmqq1sgx5adl.fsf@gitster-ct.c.googlers.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-3-pclouds@gmail.com> <xmqq1sgx5adl.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Mar 2018 17:19:50 +0700
Message-ID: <CACsJy8BW_EtxQvgL=YrCXCQY7cEWCQxgfkeH=Gd=X=uVYhPJcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] repack: add --keep-pack option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 7, 2018 at 1:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> +--keep-pack=3D<pack name>::
>> +     Ignore the given pack. This is the equivalent of having
>> +     `.keep` file on the pack. Implies `--honor-pack-keep`.
>> +
>
> A few questions I am not sure how I would answer:
>
>  - Do we want to have this listed in the SYNOPSIS section, too?
>
>  - We would want to make the SP in "<pack name>" consistent with
>    the dash in "<missing-action>" in the same document; which way do
>    we make it uniform?

Probably the latter.

>
>  - Is this description clear enough to convey that we allow more
>    than one instance of this option specified, and the pack names
>    accumulate?

If a question is raised, it's probably not clear.

>  - Are there use cases where we want to _ignore_ on-disk ".keep" and
>    only honor the ones given via the "--keep-pack" options?

I can't think of one. These .keep files are originally lock files and
ignoring them sounds like a bad idea. Perhaps we could add
--no-keep-pack later to explicit not keep a pack, ignoring .keep file
if present?

>> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
>> index 38247afbec..553d907d34 100755
>> --- a/t/t7700-repack.sh
>> +++ b/t/t7700-repack.sh
>> @@ -196,5 +196,24 @@ test_expect_success 'objects made unreachable by gr=
afts only are kept' '
>>       git cat-file -t $H1
>>  '
>>
>> +test_expect_success 'repack --keep-pack' '
>> +     test_create_repo keep-pack &&
>> +     (
>> +             cd keep-pack &&
>> +             for cmit in one two three four; do
>> +                     test_commit $cmit &&
>> +                     git repack -d
>> +             done &&
>
> Style: replace "; " before do with LF followed by a few HT.
>
> This 'for' loop would not exit and report error if an early
> test_commit or "git repack -d" fails, would it?

Yeah. I guess I'll just unroll the loop.

>> +             git repack -a -d --keep-pack $KEEP1 --keep-pack $KEEP4 &&
>> +             ls .git/objects/pack/*.pack >new-counts &&
>> +             test_line_count =3D 3 new-counts &&
>> +             git fsck
>
> One important invariant for this new feature is that $KEEP1 and
> $KEEP4 will both appear in new-counts file, no?  Rename new-counts
> to new-pack-list and inspect the contents, not just line count,
> perhaps?

OK
--=20
Duy
