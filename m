Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589F51F404
	for <e@80x24.org>; Mon, 16 Apr 2018 23:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDPXDJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 19:03:09 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34103 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeDPXDI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 19:03:08 -0400
Received: by mail-vk0-f52.google.com with SMTP id a194so9815874vke.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I5yGqWdEWFLnR0hXMtUDmpNqKZG0mpSnRgFebqkfzZY=;
        b=HcO7SzTKI3qMgqya6EsgLX3v+LIQxKaCxPvstwefG1EbqM2nIJT+5y9gjj+sh58vkY
         fBLtyYExpQUIE9p5uUDuvypOk3SMkw12hUmO0S0hT7t6JjkSY0ULcJfdOT2InaQon77U
         jaf197Kh/+dYHMJboI6+e/AH8ngS7q7Svt9v3ZVs6FJDQdOoIBGUIhjTiVHXB5JmdIaz
         cu+xBaT2W1SIptA4BZbdUinbxohrq54rvadVTATBSytEcrxhLrwe8crkuzCGbipQkHty
         mdvNjYkIEfvE+Lwe/AqOdlGVlorevCPzBDsPtggxhqvKBnpHm0dEWt4T/j14+c9cgxc+
         Swjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I5yGqWdEWFLnR0hXMtUDmpNqKZG0mpSnRgFebqkfzZY=;
        b=EIm1jHKYTulAP34yPPzhhcpOIjuPsSjtAakhxaeXCVR959ymswrJtniTH3bZxCVjZp
         4KB4El8+mxDgpUEaRF266y8RAMdyEV0U82fJ2T8MInCm7wiw7efbZkUShpLkrPm+ZBRr
         V/jhYlA+NZwrM9WrybqdA7cZ0GZ+Mu3DOk2lnwEY0BNRJPEukeMcivFniSIahrBMXNi0
         3nQUe/27DqRGOMh6hcSfC9QuEC8g3vnGAEu38X5ocmRo4cII45SD6bTJEgpU/fuo6j5p
         WSMGp/hRNr/a+nqKH1X+TWQgFlEFk6e168qbXnSVgETI1Q6AvYDmlyxtTe/HWGR1GJc9
         NDfw==
X-Gm-Message-State: ALQs6tANhctzT0KVTGiuPIokT/sd9IUZjbGsq0BI++JKpfh4YwzL7Xc+
        IuwSiGX72p+WIR/A4D3HeTRJAw3707nhgudyN3o=
X-Google-Smtp-Source: AIpwx4+XrnGNLVBvkS4YWwHPg3dsudmcMfh8kCW7RNO/NvL35tl9O2vlHoUIaJgKGUceFChvToOj7Kes4HrU2ASBOiM=
X-Received: by 10.31.85.132 with SMTP id j126mr11679799vkb.184.1523919787719;
 Mon, 16 Apr 2018 16:03:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Mon, 16 Apr 2018 16:03:07 -0700 (PDT)
In-Reply-To: <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com> <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Apr 2018 16:03:07 -0700
Message-ID: <CABPp-BHa47a-nH6dZ+LdGuf2XdYTFHyhHVv39dGeuEux10DY_A@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wrote:

> One thing that makes me curious is what happens (and what we want to
> happen) when such a "we already have the changes the side branch
> tries to bring in" path has local (i.e. not yet in the index)
> changes.  For a dirty file that trivially merges (e.g. a path we
> modified since our histories forked, while the other side didn't do
> anything, has local changes in the working tree), we try hard to
> make the merge succeed while keeping the local changes, and we
> should be able to do the same in this case, too.
>
> Your illustration patch that reads from the working tree to compare
> with the contents we are about to write out of course won't cope
> with this case ;-).  If we do things in the index like the approach
> to fix was_tracked(), I suspect that we would just say "as long as
> the index and the HEAD matches, i.e. we are keeping the path as it is
> found in HEAD as the merge result, we do not touch the working tree"
> and leave such a local modification alone.

I could see it going either way (fail early, or succeed because we
don't need to overwrite anything), but my suspicion is also towards
letting the merge succeed.

It looks like my patches need a little more fixing up (the was_dirty()
calls would be mixing both the old and the new index -- it used the
original index via was_tracked(), but used the current index via
cache_file_exists(); it should be more consistent).  I'm fixing that
up, will add this as another testcase to t6046, and will submit a
newer RFC in a day or so.
