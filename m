Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F30A1F42D
	for <e@80x24.org>; Sat, 31 Mar 2018 04:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeCaELC (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 00:11:02 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38762 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeCaELB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 00:11:01 -0400
Received: by mail-ot0-f196.google.com with SMTP id o9-v6so11119303otj.5
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 21:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rlvSjL9oAg1rjEX3h0OdUqzSy7W1qpsm8GSwkSjdBds=;
        b=kPHMlf/7x3Fcz4DGYRaLVYJu+b4kRTIDUvEYfYKEm9EDk4MPmUbdZEdzMxL2HpgAx/
         lx3ykCtjphfOFlaLbR3/Qn819x4Xrdg6L3oHnUyXd/wI6GfLI+19i/uU448rqdKi52Ny
         C1E+UE+dso4EXdlheSKDwxYGlWVNehd0FhgJm+wLeSqn5vT6DC6GS1H9c6Mr1YA5VJYs
         1UUPO0N/tcwZ1WkxbiamG7JLGgr/ie6GiSwtFxxNqXB9XniIZq+RZIJ/wy9Fn+/8qKyl
         jgT8/mydAW8anXAh2a8mH07xOECG1iHI+btLNNh5qS4kETF645Y9NgFXc3sPc3Mqp88J
         bWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rlvSjL9oAg1rjEX3h0OdUqzSy7W1qpsm8GSwkSjdBds=;
        b=A8RStSO6NE5jYcHuPSCEhT2amY+aoiQNfg0VFiR87Os3hBfEJpD9EbuQQ6ZuXr+OOZ
         EgKO/cvF1NtHP8bzuN5lauLeR7ipJKYzauCziIpSfZ+JUb2DjJYzEiNiqzMwiybBnoL7
         2ZnZ7wAjMJxt2XZ1CGR89PYM8xomS5beTOAbE9FhQsQFCGACZgWto9ODeTZZk/rdcSF7
         6d/bcE0zXkCXQxvubEiv3YbAZ9rfP+ePzXq7sr0+bMA2eyinE1nRvCAwe4x88hPMEODB
         2wIF9UEzdlOWuA1uNp3lgUkgNY6+nBBka3CtMfMsXv7ajb9w808G4UrR6l07piy1kqtV
         mFsg==
X-Gm-Message-State: ALQs6tCMUtiC7wbgMw2GKWTmv4YSYGBXOtp2F2V23Te+iGO/gdnm90ty
        LH6ZqvXJ9PuQRyRQxrKqoLek6eC8GrkX8CWsxok=
X-Google-Smtp-Source: AIpwx4+2/8vajKPzLY1YfQTvCS8m2hi55Z2re8lcQqLp9abd2xP2rWS9+BRtHyNIbW6puPCGTlpmRu6CSQSZnpGF40k=
X-Received: by 2002:a9d:e84:: with SMTP id 4-v6mr911588otj.14.1522469461064;
 Fri, 30 Mar 2018 21:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 21:10:30 -0700 (PDT)
In-Reply-To: <20180330212656.GK14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-14-pclouds@gmail.com> <20180330212656.GK14782@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 06:10:30 +0200
Message-ID: <CACsJy8Cr=uN8d9ZWO=xbyOYbMmS6V3FCdw_tww15d6NHpLMTag@mail.gmail.com>
Subject: Re: [PATCH v7 13/13] pack-objects: reorder members to shrink struct object_entry
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 11:26 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 24, 2018 at 07:33:53AM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> Previous patches leave lots of holes and padding in this struct. This
>> patch reorders the members and shrinks the struct down to 80 bytes
>> (from 136 bytes, before any field shrinking is done) with 16 bits to
>> spare (and a couple more in in_pack_header_size when we really run out
>> of bits).
>
> Out of curiosity, did you count this yourself, or did you double-check
> with a few compilers to make sure they all produce the same result?

I used pahole though only with .o files created by gcc 64-bit. I'll
try the 32-bit version and clang as well.
--=20
Duy
