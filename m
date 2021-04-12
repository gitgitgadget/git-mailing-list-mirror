Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C953C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7536128E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhDLVta (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhDLVta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:49:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4760C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:49:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so1807123plg.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DPh9ai68BSC4Rl8A+pP7iHhwhympNms+Z3fE8k+fMKw=;
        b=KMHtvWiI5o+67AP0Nq5raUaPG2gKm3qc+88GGc5ssN4Zbkk5pV4e2uiKd02Ywf2fKN
         1GaO7UbplRIctVi2L6c6h/TI6EFrwZQwSQGF5ST7VZ1iFsQjAjgEQZlvdVfE/NIGr9Ux
         Qyz4zv7eKLpMD34maN+0hJAjHJ4DKkbM0+JG5ZqCYj6lrp7KL1rHIVZV3WuZPcKH915b
         N1hBavB3tYmXs4IGDHbTRrorDC7KitXWUtj0hPHWFnjdPMRWaZbJyxBpvaZHhmA6qnvt
         Lnipsg+742UQncDDlf6P+Wr8P3xDI/RhmFE6lDvyZWmVNpbZPMcaDNdXrForvO7U50QP
         y0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DPh9ai68BSC4Rl8A+pP7iHhwhympNms+Z3fE8k+fMKw=;
        b=ovVxwH5rszdhb/iwm0jXMz8++8vhylTVzap6TSLKJh93RCNpx2R7pSdf7sGnGM51QX
         zg4RvrMTYCFFFqgyozMgEXsgSaS9DlfPY2qcP4XLaShJ3Kob/X7j6khjXWvP5BtRShao
         yxNpvBc0I+HIZJz2MF4D7KL87R6F4uFgriepQTRXvHQ8cs2J8fbV7DIPCIck+vjN19v7
         jszZWScg0EdV5MuEjWAXbWk+kdmKsfAzZWSqcX58k21bjDy9IQsFe65P6caeNqB5bDI/
         KHxS5bbqEVxllqrwrpCpAMhcBp0/BcvdB8X3EE3TOYI6JIGEwfYu59DQSz4ecYUpKCiv
         RBnw==
X-Gm-Message-State: AOAM532i2rJqhtqsB7GJRQiYW4o6Zmj4JI/zzie4ZcSOPz7G8R3kktZw
        yvAxsv1tEEsxDGkQRIFiYUM6KgJnba96Mo2yY1qECg==
X-Google-Smtp-Source: ABdhPJzgBT/7iDIo8qQxTEiU0hMxFq+lKQE083TehDLxTEWS2xAoPlHoi1xx56f7gswKGUDKhru4Opw8/sBvTA9IdVU=
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id
 x23-20020a1709028217b02900e62875b1d9mr27841025pln.70.1618264151207; Mon, 12
 Apr 2021 14:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210403090412.GH2271@szeder.dev> <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net> <20210412213653.GH2947267@szeder.dev>
In-Reply-To: <20210412213653.GH2947267@szeder.dev>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 12 Apr 2021 14:49:00 -0700
Message-ID: <CAGyf7-HTCDm_SB5CfQWJWjvuCVYuJ4=h65=zG-N1XTgNRs+j0w@mail.gmail.com>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 2:37 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> And a somewhat related issue: when the server doesn't support filters,
> then 'git clone --filter=3D...' prints a warning and proceeds to clone
> the full repo.  Reading ba95710a3b ({fetch,upload}-pack: support
> filter in protocol v2, 2018-05-03) this seems to be intentional and I
> tend to think that it makes sense (though I managed to overlook that
> warning twice today...  I surely wouldn't have overlooked a hard
> error, but that would perhaps be too harsh in this case, dunno).
> However, the resulting full clone is still marked as partial:
>
>   $ git clone --bare --filter=3Dblob:none https://git.kernel.org/pub/scm/=
git/git.git git-not-really-partial.git
>   Cloning into bare repository 'git-not-really-partial.git'...
>   warning: filtering not recognized by server, ignoring
>   remote: Enumerating objects: 591, done.
>   remote: Counting objects: 100% (591/591), done.
>   remote: Compressing objects: 100% (293/293), done.
>   remote: Total 305662 (delta 372), reused 393 (delta 298), pack-reused 3=
05071
>   Receiving objects: 100% (305662/305662), 96.83 MiB | 2.10 MiB/s, done.
>   Resolving deltas: 100% (228123/228123), done.
>   $ ls -l git-not-really-partial.git/objects/pack/
>   total 107568
>   -r--r--r-- 1 szeder szeder   8559608 Apr 12 21:13 pack-53f3ee0dfeaa8cea=
65c78473cd5904bf5ddfaa20.idx
>   -r--r--r-- 1 szeder szeder 101535430 Apr 12 21:13 pack-53f3ee0dfeaa8cea=
65c78473cd5904bf5ddfaa20.pack
>   -rw------- 1 szeder szeder     49012 Apr 12 21:13 pack-53f3ee0dfeaa8cea=
65c78473cd5904bf5ddfaa20.promisor
>   $ cat git-not-really-partial.git/config
>   [core]
>         repositoryformatversion =3D 1
>         filemode =3D true
>         bare =3D true
>   [remote "origin"]
>         url =3D https://git.kernel.org/pub/scm/git/git.git
>         promisor =3D true
>         partialclonefilter =3D blob:none

I ran into this same surprising behavior recently, too. I was adding
some automated testing to Bitbucket for partial clones and initially
tried to use whether the repository was configured with a partial
clone filter as one of my checks, only to find that even when filters
weren't supported it was still set. The only way I could find to
detect that a partial clone that was requested didn't actually happen
was to parse the git clone output and look for the warning.

>
> I wonder whether this is intentional, or that it is really the desired
> behavior, considering that 'gc/repack/fsck' still treat it as a
> partial clone, and, consequently, are affected by this slowness and
> much higher memory usage, and since the repo now contains a lot more
> objects than expected (all the blobs as well), they are much slower:
>
>   $ /usr/bin/time --format=3Delapsed: %E  max RSS: %Mk git -C git-not-rea=
lly-partial.git/ gc
>   Enumerating objects: 305662, done.
>   Counting objects: 100% (305662/305662), done.
>   Delta compression using up to 4 threads
>   Compressing objects: 100% (75200/75200), done.
>   Writing objects: 100% (305662/305662), done.
>   Total 305662 (delta 228123), reused 305662 (delta 228123), pack-reused =
0
>   Removing duplicate objects: 100% (256/256), done.
>   elapsed: 4:28.96  max RSS: 1985100k
>   # with Peff's patch above:
>   $ /usr/bin/time --format=3Delapsed: %E  max RSS: %Mk /home/szeder/src/g=
it/bin-wrappers/git -C git-not-really-partial.git/ gc
>   Enumerating objects: 305662, done.
>   Counting objects: 100% (305662/305662), done.
>   Delta compression using up to 4 threads
>   Compressing objects: 100% (75200/75200), done.
>   Writing objects: 100% (305662/305662), done.
>   Total 305662 (delta 228123), reused 305662 (delta 228123), pack-reused =
0
>   elapsed: 1:21.83  max RSS: 1959740k
>
