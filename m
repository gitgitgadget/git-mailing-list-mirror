Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7241F453
	for <e@80x24.org>; Fri,  3 May 2019 05:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfECFmn (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 01:42:43 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39700 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfECFmn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 01:42:43 -0400
Received: by mail-it1-f193.google.com with SMTP id t200so7361624itf.4
        for <git@vger.kernel.org>; Thu, 02 May 2019 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ubz6u3FmxPpJ2ZUe4yYc1CNH97UEpvB3l30GMeOOaF0=;
        b=GHdLf/60Lkpix1qWJL+rpQNfkHhxUzAqdpEazprBaN4MOkxSBjnp/s4d/F5EUAZW/b
         nPn/r+TFpSrwhRoc+Ekiatv4DE1ItgKrHqW9l735/CegAQCnu3gh13CYXSmcLHJmKG/M
         TWHL17l8tHgOYbV25F+YEbEN/EDs22SXqcOZ/Pb35/+qddPkkVUPDqt1bfrMbDqKF2kZ
         ZmUvmMHF+ICFxE7sATYFjCL3Or6Bumq/zby12RYA/ZeiB9VhQSGAXCmxwZULAJ7uuDih
         kFwE0PBkMNjAeHTxjMY90PhabCoY14QjkfJqMMv5zRnpKj0kqnAJB3VtQaNRIuxuGvOD
         wiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ubz6u3FmxPpJ2ZUe4yYc1CNH97UEpvB3l30GMeOOaF0=;
        b=e+KAkkrIzi99f1UvWG/qt2ZuWYo8CHzrLJcHEx2K4Wx4Cd+1aZUkH6s1ktmw1FJEdN
         PajXHWErQAHxQCJpkmD468Ze4l7b+vqwbe0kudoNB/Sp2PMtMrGxaJjISdRfYbSRJ0fx
         lldvmtmaT6sd2XoXRtnyoX1xSFPOGyNboDEtDZIAkODGylMuzYIN+4KLTogOpQTNW10s
         GENYmGiaADtfGnLXj1qH67E2kPOrz2tKqxZyye7ysJ/MzYcIfI8HfIvP9kgVNzF/MyBo
         U8pMh7hlAu53uc4+7+fcFOqeFeETfhveoVULexcFWnVGyfnjbxj8S8jW5l6awUFYVrMJ
         AHoQ==
X-Gm-Message-State: APjAAAVeTBTe5K3de677dMFu3324NM+mqniGJ05e2IWBKmdjtHTgokjt
        e0Mxg6DgUfqLAKKr7oS+p5prKG0nDlFgXpFX7ew=
X-Google-Smtp-Source: APXvYqyl/6lCEqVLNn7HLrgFmOEBLQn61i1e9uT1c0khWccee2jCpFU34DX/prhkaZgSIdUcR+K0frEmGzVQ6JWFYik=
X-Received: by 2002:a02:ba85:: with SMTP id g5mr5553036jao.92.1556862162769;
 Thu, 02 May 2019 22:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net> <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
 <20190501183638.GF4109@sigill.intra.peff.net> <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com>
 <20190502150701.GA14906@sigill.intra.peff.net> <CACsJy8Dimn9+ogDNEgy3xmLunyX_pStBq=g-1jrf74LsOW1xrA@mail.gmail.com>
 <20190502165802.GA19341@sigill.intra.peff.net>
In-Reply-To: <20190502165802.GA19341@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 May 2019 12:42:16 +0700
Message-ID: <CACsJy8AWfARPKczV7nGoBz35cBGsuNBtfh5pCFHvjBSB1_HHWg@mail.gmail.com>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     Jeff King <peff@peff.net>
Cc:     Aleksey Midenkov <midenok@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 2, 2019 at 11:58 PM Jeff King <peff@peff.net> wrote:
> > I might take a stab at the "wait and try to hold the lock again, doing
> > necessary verification after if needed" idea. It sounds like the right
> > way to go and we haven't had problems with refs doing the same thing
> > (have we?).
>
> No, but it's a bit easier with refs because the locking is just
> atomically checking the lease. I.e., after taking the lock we still say
> "we expected the ref to be at oid XYZ, is it still there?". What's the
> equivalent for an index operation?

We could add a second hash that only covers the valuable parts (e.g.
paths, stage index, SHA-1 and probably some ce_flags). This should be
enough to verify if the index is still the same as before (stat info
does not count, the same for other cache data like untracked cache,
cache-tree...).

This will add some overhead of course because we hash more, especially
on large index files. So it will be optional. The hash is stored in an
extension. If you run things in parallel and want this, enable it. If
the extension is not present in the first place, we don't attempt to
wait and retry or anything.
-- 
Duy
