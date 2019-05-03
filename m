Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC371F453
	for <e@80x24.org>; Fri,  3 May 2019 10:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfECKWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 06:22:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40480 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfECKWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 06:22:51 -0400
Received: by mail-io1-f68.google.com with SMTP id m9so4763041iok.7
        for <git@vger.kernel.org>; Fri, 03 May 2019 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mvmtvj4ddj6kaWz+MM4oqoKRZtGiSy90Z/uszxlBxyI=;
        b=K3wM/Phpj287SYvNX0KEmBd25e1w/8yw1ihggzViO+wrbSROY0axDy2wgJTiVGi1pk
         DgfAmMVKms17xNIaYa53hzAbYNXbngbClxJzIuN3jOVXTH0AsqaBnI5pUUBYc3d6nCPT
         bkoXy9zkWyl9U2Sdu1rgTH3l/n1mmtU5BzfjUJp2d1t1iBbtVbkXw6ebrxrO2rpjCZMY
         M7W/yJX6an47AXvLOZQLOBnUYQTxHdlrmfnncpow2WZ0J04bZAxvsNx4SgaH2TUmHoRL
         BJM8qCI7eXYpTb3N2eHkyj2ogXq9tg2sTnXq8+tU6MvqqfFlXnpe6P6WG/llgj8EwH7o
         WaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mvmtvj4ddj6kaWz+MM4oqoKRZtGiSy90Z/uszxlBxyI=;
        b=WKnWArxvT0QrfdiwH6kagij36YkFmxo7YMF2MfF/u2nmqTQCv8KdZ+e8sJYDSW6wuu
         XOhMhCf8FBWAhxFuqKaFYazq4gPAm0pXqJEKRkE3+ItciD8XSWSgbFPfYs/8uUxiFF25
         VNmTGX5OIkNHKHB/nI8j26KhfWNPAWvRwe38m9PysReJ5WlfXcXnye+HAO3b9MI1yd+2
         4B6q3hh9YNtwN1M2qqIULfgkcreBV9ht6FD7FC138nggvpXTfogWCGRQpf7lPlzoVRh7
         qBPD+U/z4YAnHjqhAXMqrAsJHgJ9ky/ckumVkNWgKB1q9UMikDn0GZouayXuN/ez4D0B
         p90Q==
X-Gm-Message-State: APjAAAWul+vvwxqRltsqvTSVUkEoK4F6fJfn/sApG0O0Tiw0vzxPxtrN
        XF0IQ3QvpNWvJh01G5eG01ryPO+QczUGq8bAFhWa394p
X-Google-Smtp-Source: APXvYqzMqT5IMNr1k11Jshh0hTK4B3rCE3NYgdQZuF22Zf/n4q7MSH3YWmshC8RgbyU3X9w1nxoKTZPTfZOWlnGP5aY=
X-Received: by 2002:a05:6602:2042:: with SMTP id z2mr5427172iod.282.1556878971069;
 Fri, 03 May 2019 03:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net> <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
 <20190501183638.GF4109@sigill.intra.peff.net> <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com>
 <20190502150701.GA14906@sigill.intra.peff.net> <CACsJy8Dimn9+ogDNEgy3xmLunyX_pStBq=g-1jrf74LsOW1xrA@mail.gmail.com>
 <20190502165802.GA19341@sigill.intra.peff.net> <CACsJy8D7bx46bix_LmGr=xcwsrA=LehXmLmnONLz2w3q6f80vw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905031146490.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905031146490.45@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 May 2019 17:22:24 +0700
Message-ID: <CACsJy8BcBk6Fsfy7o1aBTQAPeH-w+rBwLZrzw4jJ-OM_jhkxMQ@mail.gmail.com>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Aleksey Midenkov <midenok@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 3, 2019 at 4:47 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Fri, 3 May 2019, Duy Nguyen wrote:
>
> > I have a feeling that most operations read the index unlocked,
> > manipulate and only lock before writing things out. So yeah it's
> > probably already racy.
>
> IIRC there is a check for that, so it is not actually racy ;-)

Yeah the update_if_able(), used exclusively for refreshing index. My
feeling was wrong actually. Looking around a bit, I think we do take
the lock, re-read the index, do things, then write.

There may be racy spots still. Looking quickly through some
write_locked_index callsites, difftool.c and checkout-index.c may
leave a gap between loading the index and locking it. Or
refresh_and_write_cache() and a couple others in am.c do not look
exactly race-free.

We probably should provide an API where locking requires re-reading
the index. The version without re-reading has a big fat warning about
danger and stuff.

In any case, i'm getting off topic. I'll stop here.
-- 
Duy
