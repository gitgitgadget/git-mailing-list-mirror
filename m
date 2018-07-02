Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148DF1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeGBT7s (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:59:48 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:37528 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeGBT7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:59:47 -0400
Received: by mail-yb0-f194.google.com with SMTP id r3-v6so5540980ybo.4
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IUuzPb7ir2P3BDHnd4QeDY7UurjkLDVvIbLhMmLZn3k=;
        b=VMdnq6L2lKMCzPG+8zx+BAfj6LfFi/PXQa77H/9VJDns9S9xWDaHTnT0QLHe+1tKlI
         9aEykoPetafj9qhfrlqe5dwfw96LiaV0cPaWjV4zZQzv+ecFCf8SO4wNDMgEFt1gfM99
         l/sabY9efak+D/eIYbzKABwu1N/50ZVRG9P8WgxMoV5vb89s30m2SiZgfCuSgTF8tPZS
         gAz8sPaOERfY1Ir03Np+lB0d1xbTsEV5pU9w+bI1j6Qt09xJSI0YR8DUDmbo6rUcPhsr
         M6eBV+lxfOd9uEiGpAzPwJeOsfg318hnPhf0TJCvMnDzg8+pKNkBF3uOzAlE9hxgVEE+
         mhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IUuzPb7ir2P3BDHnd4QeDY7UurjkLDVvIbLhMmLZn3k=;
        b=smNdPOhavmFETfyV//eH3ql/NF+x2nN5QWy1pCB8PzmdOaykYeDJsk6eVqKSbUGufn
         dSOUo/OF/LGJhQn8hFXJGzCSV0mJhnmL2VZCT9Xh00vZrhQyJXOo3aUTdL5xR9MTZvat
         l0sjXo0KdDh8UXl585SPQP/f4KDaYWw0kt0HwgrDYlfqXO0pdgWLdaHyNBjISYZkk7fq
         IHp7+Ok6ZeIn2h200/mwqNsMDwuY4WKFYyd0wCWSrJAssKYLpzky7UUMsAIYNuPHkYYA
         mlyVmbTZDSQN1cgJ1TeGMhv+qHrhdG/Vx0+Y7rW7HHQJCpnXthiFHxrTNewNTl5mpQ5h
         pUAQ==
X-Gm-Message-State: APt69E1N8ztjaF/3h06i2n3jnVFanFBI8YCZdZLnDfhxtGt/LC0G0bXM
        N7rxmlH2WzeXqOXRhrultTVNCk+KfXTKlJYnvFcloQ==
X-Google-Smtp-Source: AAOMgpe8zqBkHSd66brRzb/X5wajTdzmFMuAc3w0ydOlt8FSTC+0IU8vJK22neUjl1Ukq/VN72R36Ya61BSiXYmVlos=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr12003047ybm.307.1530561586458;
 Mon, 02 Jul 2018 12:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <3d6b38a8-7dbe-0633-5c54-603161ee3fd4@gmx.de>
In-Reply-To: <3d6b38a8-7dbe-0633-5c54-603161ee3fd4@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 12:59:35 -0700
Message-ID: <CAGZ79kYoRziU12hsU4ST90JyxTvMqXSxq-eHnn6jGndzQ_fZ6g@mail.gmail.com>
Subject: Re: Feature request : "git fsck" should show the percentage of
 completeness in step "Checking connectivity:"
To:     toralf.foerster@gmx.de
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 1, 2018 at 9:22 AM Toralf F=C3=B6rster <toralf.foerster@gmx.de>=
 wrote:
>
> as "git fsck" does it already for "Checking objects:"
>
> Is this a valid feature request?

Yes it is. However it is most likely to have the feature incorporated if
it comes in form of a patch.

So clone one of the git.git repositories found at
https://git-blame.blogspot.com/p/git-public-repositories.html
and have a look builtin/fsck.c (Search for "Checking connectivity")
as well as how the progress.{h, c} for its API if needed.

I am not sure if this is an easy thing to add, as knowing the number
of objects before the walk might be hard. How does "Checking objects"
solve that issue?

See Documentation/SubmittingPatches once you have some code
that can be a starter of a discussion. :)

Thanks,
Stefan
