Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BC21F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeCUQHh (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:07:37 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35788 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeCUQHe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:07:34 -0400
Received: by mail-ot0-f179.google.com with SMTP id r30-v6so6153455otr.2
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ogOHNUqvoYkQbVRIBdfVrG2z7tvCsdkvVwLV9GSJO6E=;
        b=KRRKLrmFgsDC4384WApiX2cA2QizhredMZak//+Al2E2HgalIRUW34en3twgdXgtxN
         R3+UYLtctlxGhBHXi7t+rM9AZ3dfo+GA4X6/GGSWKOoQ5AGp5u28BUyNKd/gKRIGOO5o
         VSYT/opWFI0kAjFQhCdYhz3nJZpEbkeo8IYyYnEpii8yHoLtgu5GdBOG0vecPwJi7y2k
         bjPwJ7q2lQ8BBFPN8AuBPbFkbk053Uy78Qo8pOScZZy9SjcOTxvpyK6IYwrCHncWB51I
         4d+FFE7Bp07YVtz+GMmpVMEdxmpWP7sdIWZ+hO4a/BaekDYJEP6eWTNnFsN+vZrAcR1Y
         5lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ogOHNUqvoYkQbVRIBdfVrG2z7tvCsdkvVwLV9GSJO6E=;
        b=paGW6UCch5jdoZOmtzVIVmIkpvcxxn61YIsIHCgVW/iOwsCUewzZHPik953ErFc211
         +IOpeTCJlZrWNTOUPFaJ5HvjNli3u3GRVCD/JaZPOTroFx7ufC+E1dBWrGjl5CHuc10f
         Sbke4SDM7SvSITmDTXblMb7W13hTb33Q3Ny1QTIdUld+WlSlHZsb/x9oIbORaAgUtCbz
         PUiHdkORUcFbUUX543khjX+YV7CWvAcGFORiWdwubmMxQeqHqjLNq9RXKYpM82Jm1gpL
         uQo8HAN0bDrKvC5iuk4PFow757P3RAJGMzEtLcKuf7dnz3XmKCINw3wJQ6uEzejkIE6N
         53Pg==
X-Gm-Message-State: AElRT7Fp0bdWWTAUuZWkYejkXU4IzvVWG/qEWp+wXIiDZqKEjyAp+Wsq
        e4q8sF/3H9f7z48QV0fW4eMDeIHTqY14aSPXSao=
X-Google-Smtp-Source: AIpwx49rwMFfaEkDK5mSrjkpjirj85sJz22Ua4g8IhkyHLLJ7QEyoYU61kxvX9vZivGo4L9bfa9Ul9sSMFntRd5miFg=
X-Received: by 2002:a9d:550b:: with SMTP id l11-v6mr4809318oth.356.1521648453696;
 Wed, 21 Mar 2018 09:07:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 21 Mar 2018 09:07:02 -0700 (PDT)
In-Reply-To: <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net> <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
 <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 21 Mar 2018 17:07:02 +0100
Message-ID: <CACsJy8A7k0d8wB_XWhvaaTXespg2y6G+Ab4b27Dc3iKY2Zjujw@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 4:22 AM, Dakota Hawkins
<dakota@dakotahawkins.com> wrote:
> Thinking about this a little more, I'm now attracted to the idea that
> its .gitignore that's weird.
>
> As I understand it, .gitignore stops recursion when there's a
> directory match (`somedir/`) but also explicitly allows nested
> .gitnore file _as well as_ exclusion (`!*.txt`).
>
> So, in the following (contrived) example, the user doesn't get what they want:
>
>     repo/
>     |- .git/
>     |- .gitignore               # /ignore-most/
>     |- ignore-most/
>     |  |- .gitignore            # !*.txt
>     |  |- please_ignore.png
>     |  |- dont_ignore_me.txt
>
> `repo/ignore-most/dont_ignore_me.txt` is still ignored, despite what
> seems like the obvious intention of the user.

Don't get me started on this. I voiced this problem a couple times.
Attempted to fix it once which made it to rc cycles and caused lots of
regressions. I haven't taken another stab since.

> Maybe a unified "best-practices" would first-and-foremost recommend
> against matching directories at all (makes sense, git doesn't manage
> directories). In the above example, changing `/ignore-most/` to
> `/ignore-most/*` has the "desired" effect.

I think it's actually more intuitive to think "ignore recursively"
(with the trailing slash) These things make sense to you once you know
exactly _how_ the matching machinery works. But normal users don't
know that. It's probably better that we add recursive matching support
in gitattributes. Then both gitignore/gitattr are more or less
consistent again and also easy to use (most of the times)
-- 
Duy
