Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032471F453
	for <e@80x24.org>; Thu,  2 May 2019 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBRY4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 13:24:56 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:55458 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEBRY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 13:24:56 -0400
Received: by mail-it1-f176.google.com with SMTP id i131so4699427itf.5
        for <git@vger.kernel.org>; Thu, 02 May 2019 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTDf7VF9NPSyjfxnmCvEIkmspoarBXUF544BQjMUl9M=;
        b=CU4UVeWS87MXWytvFysSPBBzAwfjdddCWeEW+PAyDGQCby/lIWSX+LbuxiQZPoalFo
         3M2Qp+jqTqvk6HVoas4vKK6vPaXDHE5+L7MG7JUKSREEI6kEvi7MljiCXSjHHR4svcu2
         pPLI/CHYNqcNUktf7txklQzyKy+WWqYUh9plDRyOMGQWNThaVYfQF+a2hZsqI/60sNMr
         9z7TaJhKhxIeDdNnll+pJBgVcq5/Wc17lQJIdsC1DtPzbKa87Q6pIpKvhW792mUMeV9B
         GhNMEnqHAdt2XT0as756EkqEw11Zj8q+EXUap+r26a4G6EqbTn4ZOmYb+IUg//5C+WyT
         V15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTDf7VF9NPSyjfxnmCvEIkmspoarBXUF544BQjMUl9M=;
        b=oo/wYNKZsYfK360hipImXhachAGocnZIk/Bc5Y+VhYIxcjcEnNf/pjaSxBVlUoSpQq
         IDC4UdAt/LXr5H2+NBzYh5QOU9u2T4VQ4USnl9c/Efbddo7sbCfkoKGd5fX0wMT4spkz
         kFuxCLkc3xn/wa5uw28VhRDfp35cQs+uG768KLReM4HeTwm7O7H0GqfFDAr3LHkBoZt0
         02MdKvJ5aY6fzBI9gL7r6fk5VLFDZpHKUm6Qh3rnZyPgfyPobMblov7UvMijleN1BZ3g
         2Cns8eXMtsu52nxmj/iR1KrjFFc/f86UrU0PsB0X//LwOqYo6KzvwPYFNPBPSc67DQWI
         U3Gw==
X-Gm-Message-State: APjAAAUXnpn6L2bucnm6vz2+cnXfanp6HieVNwQzCOrqtiJYxvobY90Y
        9o5S0X5LLYutsLRJBi8i8naqVlWFCaY+WBrJcaM=
X-Google-Smtp-Source: APXvYqw32gphEpAk1fB3tlHAo/ijhfKf9b1JmuMOFE4S92wTa5iHbTGKv5eB1TkL7Re4AEpLh/XlhRVzdPGb03xqHbI=
X-Received: by 2002:a24:478a:: with SMTP id t132mr3275806itb.123.1556817895490;
 Thu, 02 May 2019 10:24:55 -0700 (PDT)
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
Date:   Fri, 3 May 2019 00:24:29 +0700
Message-ID: <CACsJy8D7bx46bix_LmGr=xcwsrA=LehXmLmnONLz2w3q6f80vw@mail.gmail.com>
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

That's something for me to find out :)

> I think it is more common with the index to take the lock, then while
> holding it read it in fresh (possibly dumping old results), manipulate
> the result, and then write it out. For callers which make sure to
> get a fresh view _after_ taking the lock, they should be OK if taking
> the lock is delayed.
>
> I guess arguably any callers that aren't that careful are already
> broken, since it is a race; any delay-and-retry _could_ have happened as
> "we were too slow to see the initial lock".

I have a feeling that most operations read the index unlocked,
manipulate and only lock before writing things out. So yeah it's
probably already racy.

We could use the trailing SHA-1 to determine if the index has not
changed since last time, but then refresh-only updates would be
considered valuable while it's not. Full index comparison is way too
expensive (at least with giant repos) to even consider. I think I
start to see why nobody has done this...
-- 
Duy
