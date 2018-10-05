Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2DA1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 23:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJFGLP (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 02:11:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34273 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJFGLP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 02:11:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id q19-v6so13013256edr.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPfTL2IZWjBl4I261p1KMbU5tpnDsxxg8s7LZAiauCE=;
        b=g8lOZY6qcykeTHsemxtO4SSGTl4oK8VKc5ii+Bsk0AhfDXsZumPW6nsJnHe2bengVa
         aHkLcKYfwz3hSnNlEi5jjiGX5c2wbwVQ6k3O4ouOybwMTae+8Ye4+ZjJs8TaXUiW4wy5
         gRpVSHNcBut8aHs72bXbqsudfYZrPHFlAYkufwl3tImOU14lJqPotwm+F8v6us1cqn2n
         VVxWhP+jsSGaM9Qoude/P1dGrzX50/Pei/kIGplHCYaxf8iL5YknjTeCaSJYWoRqqm/c
         /AU+bgJbIVm5Se0JTPhWtrItKWT0116IMZBhNVVMYI/1smRHU7YSQsUa5lIKE2hNNpam
         dZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPfTL2IZWjBl4I261p1KMbU5tpnDsxxg8s7LZAiauCE=;
        b=bMh6jNfPovdeHPxCbB0LJUJctNsLlBMA3hx62/MoN/RlNdNER742wkOFJ/Y2ph+3qH
         bS74i0M2TwMMZTg3z0QcAXdHmZEA3f+2kVgYFQXoDuOr4BI99aO/THIMMXcWdjEIIXZI
         7mmCgGM3So3u1YEmVP5wydAG7QXlUXUw8H694NcqefYOmi45eQjaYAInYYTgPr1/FPkB
         GXK6NU+Ss5evnNkAit+XS+ikGEAbjuY95PpzzjQkSmnVkE4PgDb8omHC4KjivwoWd7cY
         nN7LRgWq19jroHQdyUErK4AqJGJcj+ogqgqsrnlr1vkeW/9N5JWJJhg/lXHdEOAQZIgB
         7pdg==
X-Gm-Message-State: ABuFfogOnElTV2lKJFdNzotzkrKo34oPP1hYIzcDS2nbKMKUAU6NKv/S
        R6dncxOcegFTeXHtZ/0gU51Ke6GE3DHpIclABb4=
X-Google-Smtp-Source: ACcGV62VtPfbeDI3//M/CnWyQqK6UqVrBQ5bBbyU+PExsmXt+ntvIroTwB+p71xppZXeGhztyEvtnlkms5IJBYSeyek=
X-Received: by 2002:a17:906:4e4d:: with SMTP id g13-v6mr13618520ejw.111.1538781020028;
 Fri, 05 Oct 2018 16:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost> <20181005162517.GB11254@sigill.intra.peff.net>
 <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
 <20181005165901.GE11254@sigill.intra.peff.net> <20181005185050.GW23446@localhost>
 <20181005190045.GA17482@sigill.intra.peff.net>
In-Reply-To: <20181005190045.GA17482@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 5 Oct 2018 16:10:08 -0700
Message-ID: <CA+P7+xpRt1j92m9y0pH-XLQ1_HaUZ97D7GEKJYJQCz83y=6x0Q@mail.gmail.com>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 5, 2018 at 12:00 PM Jeff King <peff@peff.net> wrote:
> That's OK, too, assuming people would actually want to use it. I'm also
> OK shipping this (with the "make -j" fix you suggested) and seeing if
> anybody actually complains. I assume there are only a handful of people
> running coccicheck in the first place.
>
> -Peff

Ok. I can go this route if we have consensus on the "break it and see
if someone complains" route.

Regards,
Jake
