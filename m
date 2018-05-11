Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451B91F406
	for <e@80x24.org>; Fri, 11 May 2018 00:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeEKAEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 20:04:24 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35299 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKAEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 20:04:23 -0400
Received: by mail-ua0-f194.google.com with SMTP id a2-v6so2491130uak.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FwAAaxV4DJ/VdpCi5uvfRoxfFKIkzyr81C7+u9Km+D4=;
        b=JVFfxJF+vC4tAjRCmlCRLt59Q/A16v3YI7/eW8H9wDExP4gn0A201uv7ssI32W1r2Y
         7Pehm7nIsausYOVM9BUq8bHiyc2fcAgDMVcPsfZG2pW/0/68vfwLWmFXfC5Wcx25UfUs
         SpEkYqKteBf1gm6/DTRmjwoFlae5zpA5Aj623BLErtv/kKtFaXwdSqfqqmfHSdbUfb9b
         AcG6qZ/NrMnG8Xi9dOqxSjwhZzzP9kZHt/xsjDTonNGx/HWa/4eV/wMewQe3Iz7eqbO4
         14oVbu5JTUfNFH9N7mNA3RfbAr7ecTBAwmwStW8dpAmSJg38rZD/X07x9XIosYBUG7we
         jP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FwAAaxV4DJ/VdpCi5uvfRoxfFKIkzyr81C7+u9Km+D4=;
        b=r2CiUzMNrSjC4sW+CQDVGi7sKI3dt6I0brklOHQuvSQdYOmpIFfVcxZeWAhup5+DyM
         z01o5J3K9EKAVuI7SJhGDqLzW6ykctf5kIe3wxGZsmwBEq/rVRHLT08sHmSDyfK2O/nE
         9uTBEGBH3/ipq+7WyIDQw8liaoTzruBiTrd6HWeFPFUcnWjegiMzvvJ8BEoJW3bAo6Ry
         H93JQm9H5KX52hK6BHTYmZXtHww5XWcwDOFxbgFoTiAkMgoSlhEq1csfUzQMh2j8rmHo
         1R6FHDX5SpyDP0yzUE4lAYPedUEiGmJVXWZ6wsSRqZj1ar/MGra5lgb8jM1ZL48kAs1t
         SIlg==
X-Gm-Message-State: ALKqPwfT8RSiA4/bm2xndkxM1LOvxCjcBekiI9bUC+NJDyvEuyrfQZSN
        qdAQZ7U7Mg/hCjfr6hNyEVfDz4Lqaiv/tV5srGdtjA==
X-Google-Smtp-Source: AB8JxZrSf/bdUwWOx+wc/QUBfEpeoUa9Ns62ceOcvOfrT8v0BLrcg60TUm1iyl0Zd8zNSPA7UMbyJzbamZpjKvj+f1o=
X-Received: by 2002:ab0:5a30:: with SMTP id l45-v6mr2602077uad.79.1525997062382;
 Thu, 10 May 2018 17:04:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 10 May 2018 17:04:21 -0700 (PDT)
In-Reply-To: <20180510211917.138518-1-sbeller@google.com>
References: <CANw0+A_T5zDUUWznYBe0m9fkSODPnfQaK1yJKPPawHTxi9+9BQ@mail.gmail.com>
 <20180510211917.138518-1-sbeller@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 May 2018 17:04:21 -0700
Message-ID: <CABPp-BFPaOxokRoiVnAB+KRMt6=NihmjRH+exS_NbGMbdj+k4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Submodule merging: i18n, verbosity
To:     Stefan Beller <sbeller@google.com>
Cc:     leif.middelschulte@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 2:19 PM, Stefan Beller <sbeller@google.com> wrote:
> Leif wrote:
>> Sure, let me know what to use instead and I=E2=80=99ll update and resubm=
it the patch.
>> Sure, but `MERGE_WARNING` prefixes all the messages with "Failed to
>> merge submodule=E2=80=9C.
>
> I thought about replying and coming up with good reasons, but I wrote som=
e
> patches instead.
>
> They can also be found at https://github.com/stefanbeller/git/tree/submod=
ule_i18n_verbose
>
> I think these would be a good foundation for your patch as well, as you c=
an use the
> output() function for the desired cases.
>
> Feel free to take these patches as part of your series or adapt
> (or be inspired by) as needed.

This is awesome.  In addition to the good reasons you gave, switching
merge_submodule() to use output() was one of several things on my todo
list since I think it'd be needed for remerge-diffs
(https://bugs.chromium.org/p/git/issues/detail?id=3D12) and might be
useful for merges in bare repos; thanks for tackling it.

Patches look good to me.  Having Leif's patch on top of these two
would be great.

Elijah
