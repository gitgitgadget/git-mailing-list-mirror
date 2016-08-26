Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B141FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbcHZNkz (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:40:55 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38130 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbcHZNky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:40:54 -0400
Received: by mail-it0-f48.google.com with SMTP id g62so8917378ith.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HukHq73R2HF8k6bJq658OzSj59+MCNjDywcNLb359IY=;
        b=xaXt8kL+JBz4FzPrp+dUWh4kVWUufbbEiPsk7A5Orf6TpLSBpMiVEcAKllpMQlvh8V
         3pdXF06IMhvQAoubCgFsyS2LUp/EE9NBugaWUMkPBy9cW38lbHZEpOieJqjOs061bx/G
         ZhbZUcf8nlsJEFoHRHvT36K6BwGZfHC8BIuhBekzTx5iRWCdl2vpveMW4dLkBkyjz9iD
         wx9/l4cPDlsu5V5W1LO58JpM5QnxHHCwBoONfN05ddY48nd3h5nbNp7RGTc807qN+nu9
         M9epcA6ki+gCueMKPiKAmsN/TEmHz5BH3TkZdBOAVg+hQRyNKu4W8PhaFXjchkXuR6GH
         Ofuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HukHq73R2HF8k6bJq658OzSj59+MCNjDywcNLb359IY=;
        b=Lx7SYJL+kyUgEPV3k5WX2ECC9+4NHSDf3IdSuoCF8UTMsTrw9DpTpEuBey82QcTX4y
         3zHhRhgVX3/w1ni0ZVH7lCg1mWkub+FH2tBXsA7xKu8HeWdVABsvGGq3DDr1L/a6obBm
         U1bZtKcOR26/KqO9hMTuXodw3N7kYICzw7uKtlrm0eaJ0QvBuOEM4ptvzV2l9pfjOFVY
         2PLlp1P68TP2HSO3xu3fkR15jTZCtZxvB2kJ2XS9EDZWccxL04sVGza3pVpb0sauuMHm
         Jjd3OxzgeONPnLiKDMiNzj43KtM+1NK8GTFJhCxiwQvLP3nrCDMnF43i0SL/F+4U2UG6
         0qZg==
X-Gm-Message-State: AEkoous7Yzz6SxlzC3Ybw5apQKqa1CmwsLzA7W9aoAq0xZHWZWzDOWqToBq8oe6ZS3+JvMILSnAOe5/qaRjBGA==
X-Received: by 10.36.3.76 with SMTP id e73mr12470349ite.42.1472218497485; Fri,
 26 Aug 2016 06:34:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Fri, 26 Aug 2016 06:34:27 -0700 (PDT)
In-Reply-To: <xmqq60qoojf7.fsf@gitster.mtv.corp.google.com>
References: <20160822123502.3521-1-pclouds@gmail.com> <xmqq7fb6rupa.fsf@gitster.mtv.corp.google.com>
 <CACsJy8AnDoh-CZp8oa21YHcM3sxoTJZiK7fP+ecNyqd0-DBZAA@mail.gmail.com> <xmqq60qoojf7.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 26 Aug 2016 20:34:27 +0700
Message-ID: <CACsJy8CKH35T-Vtdsds6Q8RUbO-UxJ7CROeLGjf_-QaXMw-awQ@mail.gmail.com>
Subject: Re: [PATCH] checkout: swap the order of ambiguity check for :/ syntax
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Aug 24, 2016 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>>
>>>> It's not wonderful, but it's in line with how git-checkout stops carin=
g
>>>> about ambiguity after the first argument can be resolved as a ref
>>>> (there's even a test for it, t2010.6).
>>>
>>> But that is justifiable because checkout can only ever take one
>>> revision.  What follows, if there are any, must be paths, and more
>>> importantly, it would be perfectly reasonable if some of them were
>>> missing in the working tree ("ow, I accidentally removed that file,
>>> I need to resurrect it from the index").  Does the same justification
>>> apply to this change?
>>
>> I think there is a misunderstanding. My "after" is in "after the first
>> argument can be resolved, check if it exists in worktree too, if so
>> it's ambiguous and bail". This is usually how we detect ambiguation.
>> But git-checkout does not do the "check if it exists..." clause.
>
> Hmph.  The "case 4" in the function you touched says
>
>          * case 4: git checkout <something> <paths>
>          *
>          *   The first argument must not be ambiguous.
>          *   - If it's *only* a reference, treat it like case (1).
>          *   - If it's only a path, treat it like case (2).
>          *   - else: fail.
>
> Did we break it recently?

I was driven by testing and did not read the code carefully (but on
the other hand, ambiguation plus dwim is never a pleasant read). Near
the end of this function we have

        if (!has_dash_dash) {/* case (3).(d) -> (1) */
                /*
                 * Do not complain the most common case
                 *      git checkout branch
                 * even if there happen to be a file called 'branch';
                 * it would be extremely annoying.
                 */
                if (argc)
                        verify_non_filename(NULL, arg);

argc =3D=3D 0 would be case 3d, argc !=3D 0 is case 4 and "touch abc; git
checkout :/abc def" does complain about :/abc being ambiguous. So no
we haven't broken anything yet, but I do with my patch. If I want to
make a special case for :/ to speed it up, I need to be careful about
this (and I probably need a test too because it's not detected).

While at there, verify_non_filename() in this function (and
check_filename() too) should pass the right prefix in argument 1, not
NULL, I think. I'll need to do some digging to see why they are NULL
in the first place though.
--=20
Duy
