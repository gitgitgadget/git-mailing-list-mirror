Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA811F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeGUIGp (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:06:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55606 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeGUIGo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:06:44 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so17595554itl.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rItvHfRoWxqulyExKwsv4NvNLsBNozaaEd2k8lc+mac=;
        b=LDAI/G6KyYDqEm4puYVl6SNOO1TybyO3JCR1Fk0Mlby8u9rQnrEdWqCN7lkv76mlqy
         RCmpF71XHPeZ8sKQiVV7FWmuB4HdG6rmRzDNtcs2oYv0WlM8CNkOV5kr3u7j5RH173lR
         5NcLJBZXrJ+TqZ99Wq85Ig4r9x0Q5p/LZmgDQUVDPMWuV5RVNxU5OYFoT1da+SdyFd/9
         R5yMCbWzulePAsK95WEjR7Sz3p+QzUUKsBkcuPpL4mIm5a/9N9plj+hAnIzPznPrsTep
         RnMV06PIUB8cAjcrS8DqnZAMjlCJhftrsKyHoB3dLI4P+XusytP6SA59hTYDKux15iWq
         2OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rItvHfRoWxqulyExKwsv4NvNLsBNozaaEd2k8lc+mac=;
        b=JCgCFpQHidRCa5m8sJloTaRnljgd2TJUc0Ak6ou6TkAU9r5thaWTDaHKFTutEIdqNC
         P0bfahfrk9t0SfHHD444JVO+a3zN1JVJTkjxchODyHcgPK6KmMJcD08Pwsc2SRyrIojt
         i3+/igEIl23qfli5Y0ogDoKT3eVMw3s6aNSiCKksLTfHdX1M/XBfDK1NziNWyYbuSpKu
         3fBbwDpYj3pcXLZiKGJgnN9zqT/67GeBU0G03bLCwXD1nN3TfoctoVsq8eVN2PRYJWVt
         1l2fumxHmiBA8YLInJskm4zmOoaRQWq+ULwJXwwlBQ0Ne08kvwsCwmTiVgEhYRO+zW4+
         rKww==
X-Gm-Message-State: AOUpUlE1zbJ9U5i3bJDgk7HqHx4RrIHDen1G+9+cRz9tTbHHPBS8r8iW
        vd1cM/QRsxZAJxHt92FGVL1ns/zXgAAraugpx2A=
X-Google-Smtp-Source: AAOMgpd+kCJ0/Qra3hNyp3iPlVo4vrt/tAfmUKYalU/uVB4GilmVNVYMnKjgWhaJDrBx4zTKKtzdO18UgQgl9QyhiN8=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr4057655itf.121.1532157302720;
 Sat, 21 Jul 2018 00:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
 <20180721044711.GA31376@duynguyen.home> <CABPp-BG_kYw1fWvq0YTTic7AV=nYuoKe9E4QMYVN0R_16xPKaw@mail.gmail.com>
In-Reply-To: <CABPp-BG_kYw1fWvq0YTTic7AV=nYuoKe9E4QMYVN0R_16xPKaw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jul 2018 09:14:36 +0200
Message-ID: <CACsJy8AMTdF22oFqJAscsQGgqRv3Xt7kXTTWY3SsKHVPByYnSw@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 8:56 AM Elijah Newren <newren@gmail.com> wrote:
> > -- 8< --
> ...
> > diff --git a/pack-objects.h b/pack-objects.h
> > index 9f977ae800..11890e7217 100644
> > --- a/pack-objects.h
> > +++ b/pack-objects.h
> > @@ -15,7 +15,7 @@
> ...
> > @@ -353,37 +354,26 @@ static inline void oe_set_size(struct packing_data *pack,
> >  static inline unsigned long oe_delta_size(struct packing_data *pack,
> >                                           const struct object_entry *e)
> >  {
> > -       unsigned long size;
> > -
> > -       packing_data_lock(pack);
> > -       if (pack->delta_size)
> > -               size = pack->delta_size[e - pack->objects];
> > +       if (e->delta_size_valid)
> > +               return e->delta_size_;
> >         else
> > -               size = e->delta_size_;
> > -       packing_data_unlock(pack);
> > -       return size;
> > +               return pack->delta_size[e - pack->objects];
>
> Should this last line be wrapped with packing_data_lock/unlock calls?
> (And similarly in oe_set_delta_size when writing to this array?)

No. Data related to "e" alone could be accessed unprotected. This is
what try_delta has been doing (it's "trg_entry" in there). Because we
know that pack->delta_size[e - pack->objects] is for "e" and no other
entry, we can have the same treatment. If we access other entries'
data though like in my new_delta_size_array(), that could be racy.
-- 
Duy
