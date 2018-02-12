Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2599C1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933105AbeBLJ5F (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:57:05 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35664 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeBLJ5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:57:04 -0500
Received: by mail-ot0-f173.google.com with SMTP id a2so13501431otf.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XeY5+UctLk3vO/T0ghDO6Qm6nCbf1NxqA+kYdKxnBLM=;
        b=Xj6Mh3hX4CYjRm835cR4wis6NtKcETosAYXT1h2BaTO5jCUr/h20fBpqrkJAIvVv/X
         4JBlGrfoX4o0zv1k07ugyTrPVAK65L+0VXUqtyAmTusIy7ZAhNad9mXasOYRTYLOx8Sx
         2NDDZsyTp19VudO9xZjCHjvasDOkd6wTk6hfSTKuloo5eIji9ZFHJjqFIQNWZvuddfeN
         Vwtmy/i/I5ZF6Q2kx8HZApSrH4MfO6TkkL6Ax/rNRxknH2XxgtIVQpyb+WKkBEa6Gl1a
         rYu7Ft+7m3kcW55KdbGOp0qBsXjTXHdXumPxyTcZAfgQkwlEmaN/CYeauOZBtlmblu1O
         TAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XeY5+UctLk3vO/T0ghDO6Qm6nCbf1NxqA+kYdKxnBLM=;
        b=cdBBEsUcqfcidwaI7UK97rJyMhNOh9Tw+3WZhccZ+cJ/p7q7y060cj1m8KiZ5o5JOg
         4fAhdrcyf6LcuW9W2PXRiDXU/7mMRDCzd4Hm0EovYzPDwKkzzKgA28AI1KYC9/BvO+Hu
         uKSEJYP2Yp5RED/XRrVIECXg6YCKhsaSOjiqyUqbf14hb90yWDNRj+3MHUjt/8Gjylfp
         eAnclKhmZL2AlMYvQrjJAZzC2jDy2XGpT9/U2njXaw1yHnxCOVoVMUQfiZMvjyfxloDf
         fFNjyekg4VvgajxRhqd0wGBtA+ZuvssVYosaSVy0R5Ej6l7OQGGYdWlh8XXtNKHdhB4s
         m0kw==
X-Gm-Message-State: APf1xPCN2p7A9WNAnjC2Fs2eEbr5zLuhPB3F44anNDbkvSNjs/5CLMtS
        uiZAurBanW70T6A4RmmBkeXTqEbSu/LZiBeaDHo=
X-Google-Smtp-Source: AH8x2274EsSZWTqZ4WgBPlP3jf0YDX4pcMIAo7hdphcCzdyRbTfHvvJ4nPBu7qt+W2MEQ8vnxPT64HsSutWvIiyX3cc=
X-Received: by 10.157.64.140 with SMTP id n12mr8508942ote.151.1518429424013;
 Mon, 12 Feb 2018 01:57:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 12 Feb 2018 01:56:33 -0800 (PST)
In-Reply-To: <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
 <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
 <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
 <20180206021313.GA26323@sigill.intra.peff.net> <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Feb 2018 16:56:33 +0700
Message-ID: <CACsJy8BjFex==2UQV6-k4_rTnBijJOzBAOmtNmZopc87U19Jmg@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 3:05 AM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> On 6 February 2018 at 03:13, Jeff King <peff@peff.net> wrote:
>> On Mon, Feb 05, 2018 at 08:28:10PM +0700, Duy Nguyen wrote:
>>> I learned SANITIZE=3Dleak today! It not only catches this but also "dst=
".
>>>
>>> Jeff is there any ongoing effort to make the test suite pass with
>>> SANITIZE=3Dleak? My t2038 passed, so I went ahead with the full test
>>> suite and saw so many failures. I did see in your original mails that
>>> you focused on t0000 and t0001 only..
>>
>> Yeah, I did those two scripts to try to prove to myself that the
>> approach was good. But I haven't really pushed it any further.
>>
>> Martin =C3=85gren (cc'd) did some follow-up work, but I think we still h=
ave a
>> long way to go.
>
> Agreed. :-)

Should we mark the test files that pass SANITIZE=3Dleak and run as a sub
testsuite? This way we can start growing it until it covers everything
(unlikely) and make sure people don't break what's already passed.

Of course I don't expect everybody to run this new make target with
SANITIZE=3Dleak. Travis can do that for us and hopefully have some way
to tell git@vger about new breakages.
--=20
Duy
