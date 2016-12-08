Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81B21FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbcLHS6n (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:58:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35118 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbcLHS6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:58:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so5423665wme.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X+HJ5v3G3xZyKu1bk0/R2oiaVdpHoDUzLFsZLecreRE=;
        b=MF3EYQZxSN+gbirSf4PKdMtkZQQ4ht23UViN7Gp/mfEgMzypvOL82VpgwuE2wC46n0
         L8XWUYG/asCK/UuVrvR8jZXKa17Hs0ewlI/Jee7Wx7qg0T+knIIwC9z0r8PimTovn/Vz
         QfLtC6YRwnFIv5vwdN/Yif8SFfU06nFa5Gm8SC8SuUvxeMTDijUTFvaOAQdYxIB+9XF4
         oXukPpiAmuBBPVONI2Jpis8dbMvXddClKEeNwoDqpzQQBp0eNPBp7+NgqYVP97V8ydx5
         qS9rsBt/9nvJv0w7Ob/zbi6epWSYYQlQg8rIEuzXsA1ZxeN0hxitpnbVi4B10QiQh26z
         hwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X+HJ5v3G3xZyKu1bk0/R2oiaVdpHoDUzLFsZLecreRE=;
        b=WvJvk1UK5wjBZ+T6ZwfZfIlk/erVxDlo6doCHTgEMqoiDG9d1pSazNfEuz1rf7REG7
         qZR+R3ptsPPTE4kHhD1ueDhZkG5gqQ9hlI8KaSPB7+HNOrlJRvgoIIktnXD0OcV6fWrM
         lNutRCNESuxO7LeewGc3PN7GnRO1Mbxo/2bzsenML4BIBACkPreFayhG/eoLWAdcCIQs
         XcrXzWCRBDYLsccUmN0k4gcupT/SU0URdlu7/+mmolGxAhXIYAcx3xZYjQAvFHlW1z1k
         l/c30Ire1h+O3fRzJYn3RVh2ED2X9LFn+T9HiuwueliQ7BiM1FOEE0m7+eQ+F3pP+8yD
         Co6A==
X-Gm-Message-State: AKaTC023uPclppbJZCc+qWezmvIhkH899LHCfy26sPfwVhOSu4kGvlC6ZWtXfZsFzFGNisQfigAZL+5Qf69ATw==
X-Received: by 10.28.220.197 with SMTP id t188mr3407758wmg.57.1481223521132;
 Thu, 08 Dec 2016 10:58:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.145.101 with HTTP; Thu, 8 Dec 2016 10:58:40 -0800 (PST)
In-Reply-To: <20161207160923.7028-3-szeder.dev@gmail.com>
References: <20161207160923.7028-1-szeder.dev@gmail.com> <20161207160923.7028-3-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 8 Dec 2016 19:58:40 +0100
Message-ID: <CAM0VKjk1mnNzQX6LThq1t7keesBz_fjE9x2e0ywsBKSNKP9SCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: add function to parse atoms from a
 nul-terminated string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 5:09 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> ref-filter's parse_ref_filter_atom() function parses an atom between
> the start and end pointers it gets as arguments.  This is fine for two
> of its callers, which process '%(atom)' format specifiers and the end
> pointer comes directly from strchr() looking for the closing ')'.
> However, it's not quite so straightforward for its other two callers,
> which process sort specifiers given as plain nul-terminated strings.
> Especially not for ref_default_sorting(), which has the default
> hard-coded as a string literal, but can't use it directly, because a
> pointer to the end of that string literal is needed as well.
> The next patch will add yet another caller using a string literal.

Oops, that last sentence should be deleted, there is no third patch, sorry.

G=C3=A1bor
