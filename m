Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BD520248
	for <e@80x24.org>; Mon,  4 Mar 2019 19:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfCDTwY (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 14:52:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43300 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDTwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 14:52:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id z20so5406392ljj.10
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 11:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obgvMBOdlKlhB5BqiaKhEcCeNvZ0Gakp/t0oVaaKgP4=;
        b=e+8jzVg3vXjPcCy6zM/1151A0N2GcMaylaXX/9+0HpO3WD0jjaDNuR0kJbUpZf7SGy
         0vByNmxBCOjx5yDIv9YWXa29flk2PVPh0sGdbw8Rj5SjGGYwNBauS0C+FMD6wIm3k2Vh
         tOVRMEmT1fmsKbtl7FOtKgzpih/DxKexvh2LTSqmpNl4psqGU3lcIrSpzHO/afY7Z0gS
         KN7II5X2234P6Hq0WsrbfA+vQIxHCRfI42O62PJA3C0C6beJSVf70RpPNRo3gxF1Bcvk
         Glmp00MZGa9uIRvGj7Ye9meF9A71gnFP85wb38B1Kve9drn+0McxdCotcKQBjbMtYFx1
         4srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obgvMBOdlKlhB5BqiaKhEcCeNvZ0Gakp/t0oVaaKgP4=;
        b=UUe9xaArDz9/2CTRg82VkY6Gwp+D/T7B/pq3n5zI3eWBi7OyUV/5j7ht7bShpmZpi4
         45PjYO69wOsqNnWDzb9OKQl5Z/H7ns/edSybw6xti1foptSEccHm03ZLy00FnRRqfUyZ
         dbtwbYtgwfT46whEAyM7crrSEFeEcGlSuYaLkpL8kAbukmP+z7TMqcm1ywiLiuG+1yq/
         +IQlZg/QbHQ814AD4LXRYYEyFZXKPm0Ko5MvL9sdQZYkNEKbjMy2pBizHvzqz4EX74Hd
         HjFxTza1px0xO6hkuYCvRANiHzuDGOg/czBtoMB3nrawnJKvrmY2l/cM6Fd+o3GvJZx5
         3Y5w==
X-Gm-Message-State: APjAAAXJGsxiHRL0bJJt/3n7Rcs42KOqYY2Rv0DRIl53nhc0DKtLBND3
        79dj5sS572RBOYvBTtH0ZU8uvmr5vMKucXQwOlw=
X-Google-Smtp-Source: APXvYqwdEbNvTWdK915Kveay3GuMnPVNXnbJVWsFogMcnx+mKFON2IJbkr8jMXDdjQ9YuxzJIwHkKo6eJ6ucIGKK784=
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr11349629lji.155.1551729141551;
 Mon, 04 Mar 2019 11:52:21 -0800 (PST)
MIME-Version: 1.0
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
 <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com> <D9CFD250-26D4-4D1F-B0CD-01E24E8606D9@gmail.com>
 <D4829D84-9192-4C7A-8487-0374DAFC324A@gmail.com> <C678086A-93E9-4F0B-AAAA-FBBBC27F2BFC@gmail.com>
 <CAJ145vUChd7+5QkmJsOK3bzZsudWfzZYp5wHZDzoq8SKSv0g0A@mail.gmail.com> <95defc95-c558-3487-d418-e65f7db5dda5@orcon.net.nz>
In-Reply-To: <95defc95-c558-3487-d418-e65f7db5dda5@orcon.net.nz>
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
Date:   Mon, 4 Mar 2019 13:52:10 -0600
Message-ID: <CAJ145vUOYcMvozYtWx2QJOWCSGw__-Cs3w_sxKhwwtHFQt-qHA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] Add alias option to git branch
To:     Phil Sainty <psainty@orcon.net.nz>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 1:34 PM Phil Sainty <psainty@orcon.net.nz> wrote:
>
> 5/03/19 5:23 AM, Kenneth Cochran wrote:
> > Adding Phil for comments
>
> Thank you for following this up, Kenneth.  I'll do some testing with
> your patch sometime soon.

Thanks! Any feedback is appreciated.

>
> I've realised that the last version of my script that I posted to the
> mailing list was buggy, and that in wanting to hold off sending another
> version for a little while in case I found more bugs, I in fact failed
> to send a fixed version at all.
>
> This is probably not relevant to your patches; but just in case,
> the up to date code for that script is here:
>
> https://stackoverflow.com/a/23532744/324105

This stack overflow post was actually what led me to the git mailing
list in the first place :)

>
> and the fixes since v1.11 were:
>
> * Change incorrect uses of git show-ref, introduced by v1.10 (including
>   effective regression of v1.08), to use git symbolic-ref instead.
>
> * Fix the option handling for '--', and added it to the help text.
>
>
> -Phil

On Mon, Mar 4, 2019 at 1:34 PM Phil Sainty <psainty@orcon.net.nz> wrote:
>
> 5/03/19 5:23 AM, Kenneth Cochran wrote:
> > Adding Phil for comments
>
> Thank you for following this up, Kenneth.  I'll do some testing with
> your patch sometime soon.
>
> I've realised that the last version of my script that I posted to the
> mailing list was buggy, and that in wanting to hold off sending another
> version for a little while in case I found more bugs, I in fact failed
> to send a fixed version at all.
>
> This is probably not relevant to your patches; but just in case,
> the up to date code for that script is here:
>
> https://stackoverflow.com/a/23532744/324105
>
> and the fixes since v1.11 were:
>
> * Change incorrect uses of git show-ref, introduced by v1.10 (including
>   effective regression of v1.08), to use git symbolic-ref instead.
>
> * Fix the option handling for '--', and added it to the help text.
>
>
> -Phil
