Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730A8215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 16:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeD3QyN (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 12:54:13 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34279 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755086AbeD3QyM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 12:54:12 -0400
Received: by mail-vk0-f45.google.com with SMTP id t63-v6so5496998vkb.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VhJsqerjF4r5Kld9hd0PbjkfYy+OzvcstAJmUeCDIhE=;
        b=bcMIWQZ1y5GknVVKsuD12z5ssPHDgxAEol/2K7yQLsV8/T2UpPGOjgGl3hjLTKHdUa
         uLfZ7Ortiws5jc44Isqwr5VPOgRqztGUgpf3Vx3vKDMw+nNgLDfxHWMpTwPlBIHalXQy
         mMj3tFIEWcgdx2DS2p7Uzwqp3yVzPDtN6pMpHVvcVK29emifHYiidDBOGWNEkF8pHklt
         28a6vNFFgUvgQ927EwA5qtdnE2/4WGbfH9An/iMdTCfKsD59rFFy+kWTUPwn+7fhoe3k
         /tcAwZiTkWwwo1g2pDyUYnu/cPo8cjtqO1e1sajj1O6QFd01jHx8BhR75TTEBYcVATZy
         waIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VhJsqerjF4r5Kld9hd0PbjkfYy+OzvcstAJmUeCDIhE=;
        b=gRh1DJbu0Mb3hPrJ7Q7wCIgwHadTd0UOpfKE/aBJ6wgKhAyOhOj8Sb6gz7w699Nyuh
         QmEcleYfeWdbWIF/fPhbo1Ao204/tOxvqBuDjR8xK/yI+ax1woiZF4vPXaxWJT+hQCxR
         TQDqMYzMAzQCF52A6vM9s6IsriLbr8L9XGE8Tcz5188wz2jPFTsK1+AOSPNvgWQuh6/v
         rWeXB6RUS1hkx+vP1Kn/aEaOxBcJ70VfDcZDBmFIZMOlWrGpuXIsaCVve2xlNAULV0Tf
         u4w07PJ7LnHv0vcolbgDcdebSAeS7RuwZdFkVJfu0a1OE6nK3v++KYlTBV7arjOCz+Jo
         z91A==
X-Gm-Message-State: ALQs6tD2ccldK4d8cGNXxDex79xIC782By+rQGBVA3QzXTEo4x3ySWtr
        T81VEKCIvlF748qNKF736pqv+l2g/4yO0uHmhio=
X-Google-Smtp-Source: AB8JxZqQ3H3YwEAazRHCyOzUyxoIIwheJPhAGFlVL6vPI8HmwcnKrqIHBp++/cXvVE7rN6G9dw4Z2L+CL9IzlhWVbBw=
X-Received: by 2002:a1f:aa58:: with SMTP id t85-v6mr9714494vke.118.1525107251371;
 Mon, 30 Apr 2018 09:54:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 30 Apr 2018 09:54:10 -0700 (PDT)
In-Reply-To: <20180430080341.GA28348@esm>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
 <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com> <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
 <20180427183752.GA2799@esm> <CABPp-BHwM1jx2+VTxt7hga7v-E6gvHuxVNPqm-MPRXYe5CDVtA@mail.gmail.com>
 <20180430080341.GA28348@esm>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Apr 2018 09:54:10 -0700
Message-ID: <CABPp-BF3_gkuyS+9QOjoKHidKp=S6LzzyF7MJ06fKah6hE=pDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
To:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eckhard,

On Mon, Apr 30, 2018 at 1:03 AM, Eckhard Maa=C3=9F
<eckhard.s.maass@googlemail.com> wrote:
> On Fri, Apr 27, 2018 at 01:23:20PM -0700, Elijah Newren wrote:
>> I doubt it has ever been discussed before this thread.  But, if you're
>> curious, I'll try to dump a few thoughts.
>
> Thank you, I try to dump some of mine, too. Maybe let me first stress
> that for me copy detection without --find-copies-harder is much more a
> "find content extracted" (like methods being factored out). In a way
> this is nearer to a rename than to a real copy.

Ooh, if you wanted to detect movement of code between files (as blame
does, I think searches for PICKAXE_BLAME_MOVE would point you in the
right direction) and then try to use that during merge to allow
applied changes to move with the code, that would be awesome.
Expensive, and might be a lot of work to wire it all up, but it'd be
very interesting.  I was only discussing DIFF_DETECT_COPY in my
previous email, which was all about duplicating entire files; that's
something I don't see utility in right now for resolving merges.

<snip>
> I admit that a "real" copy would get unnoticed that way. But the
> semantics of such a copy isn't too clear for me either - did I copy the
> other part to make it independent of the other or did I just employ a
> copy and paste tactic? The former does not want the changes, the later
> does. But I am happy catering to the former here.

Right, if you have to assume that the copy was made to make the code
independent, then there's no value for merge resolution to having
detected the copy in the first place.  That has the advantage of
side-stepping the possible new edge and corner cases I mentioned in
the rest of my email, but it means we shouldn't even spend time
detecting copies -- whether whole file (via DIFF_DETECT_COPY) or
individual lines (via PICKAXE_BLAME_COPY and variants).


Elijah
