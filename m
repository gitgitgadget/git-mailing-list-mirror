Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451A51F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFCUc1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:32:27 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35392 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfFCUc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:32:27 -0400
Received: by mail-vs1-f67.google.com with SMTP id u124so1541199vsu.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J8BAWu3ulMU1vf09vvQIMwxtPvojeIIIGPZoOZnzxA0=;
        b=RP0Qb5w3nkFDTuMfg0m4PD2FczfeO64kcl75m23nFr2XADMIWbPU7ZthUcGc7gq/DO
         2qUWXYApK2EkKJ2iFNUmI02yrh75sMtuZ3+6+tZ4ewBc8dk1TEywjuYb4AJF7jrTgVp8
         CtP1KUUUBTkEarNQuZSmF1cmQjw2I6scInghWTWwfvmlNWgyepnVe7LePduhwBovACfs
         vSBasObqcl2yqY0dztxKxJkNphOC7BPY7EI6T3LqLNbRpa9l+AJnLUrnBDCIVPmK8lSI
         EqKrgUz098qWApcAiFkdeVtsv+Xcyk3ieRO1tWgrXFaeOu45OzWM2LpPpOEbt103gV2N
         Cpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J8BAWu3ulMU1vf09vvQIMwxtPvojeIIIGPZoOZnzxA0=;
        b=TuFBG2+mpblNp9sGd8i9XRJXvdPi9dzJP1rFCItiVOENhFNosqPgZiPSZK9MxP824d
         iwN2yyk7ihGK9WMPeyldHD+BClYKE6Nm72yicHB41GdNctw5HDkD8ezCREcNMjDmpk7z
         2FF4yNnXJ9WiE0ksG6XMXcKFzH+rSRXaRD9mmxOeA6xYTvxNT+3g5sT8RapSJJ7L5NwG
         tZZLpYklgbLdHlHZ2TwuOHLRUYdLTsZZdC1/m/fffzS4WYI2ntfnKzhGGHKqoxYT12og
         2gsmGoceANNJ/7klcvCAK/eLBCmlJPw0L+ySCLqlf3X4nEK7iivaDvChVe7UsWwKcYfw
         2aQw==
X-Gm-Message-State: APjAAAWWKsQ9KHzoW02NmC0+yUfHGTlaJ7BSp83cEKq2QPQJpZdUEqy0
        +JXxlJHhfdfTYTpKzlWhNSCgf3gKCjQPkF+7jFrwVg==
X-Google-Smtp-Source: APXvYqyS0vyismbo88IiBUN0zQKHcqZyA/KA3vE6LAG0eulRiPim2JzY8Ph7so9DX7y2cOPcBz854FGnhqlSq92/dQg=
X-Received: by 2002:a05:6102:446:: with SMTP id e6mr14578223vsq.175.1559593946002;
 Mon, 03 Jun 2019 13:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190531183651.10067-1-rafa.almas@gmail.com> <CACUQV59ZQ=WLXa4iDw3nSJWnZpiqAYLOuoHKsNWj48uC=+k5KQ@mail.gmail.com>
In-Reply-To: <CACUQV59ZQ=WLXa4iDw3nSJWnZpiqAYLOuoHKsNWj48uC=+k5KQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Jun 2019 13:32:13 -0700
Message-ID: <CABPp-BFfYFj232cHd6_NTkEg1n8AOQ4Abm7ZrnLPWHJEDzUPsg@mail.gmail.com>
Subject: Re: [bug?] clean: Demonstrate failure when used with paths
To:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 3, 2019 at 12:58 PM Rafael Ascens=C3=A3o <rafa.almas@gmail.com>=
 wrote:
>
> I missed this RFC series which fixes this and others issues:
> https://public-inbox.org/git/20180405173446.32372-1-newren@gmail.com
>
> Cheers,
> Rafael Ascens=C3=A3o

Yeah, I've had cleaning that patch series up on my TODO list for quite
some time.

My vague recollection was that Peff pointed out a few things to clean
up in my patches, and also highlighted a few extra adjacent issues in
the surrounding underlying code...and when I started looking into
fixing the additional stuff it was slightly more complex and ugly (and
for some reason I didn't decide to just fix up and submit what I had
but was trying to fix everything in the area).

Also, briefly looking back at the cover letter and thread overview it
looks like no one ever attempted to shed light on the question I asked
in my RFC about what correct behavior was for one special case (i.e.
whether patches 5 & 6 of that series should be kept or whether they
should be dropped and patch 7 should be squashed into earlier
patches).  Anyone have thoughts on that?

Elijah
