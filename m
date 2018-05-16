Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456C71F406
	for <e@80x24.org>; Wed, 16 May 2018 16:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750935AbeEPQlH (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 12:41:07 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36428 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeEPQlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 12:41:06 -0400
Received: by mail-yw0-f194.google.com with SMTP id l15-v6so427851ywk.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PnVMJ6oAgksCie67I0Q+ZVq4GBEcB2ttMdroPfb5JJg=;
        b=UNTq3oTybNgjlqUzNkKxHa4n0QopZshweTPwe3NCE+RGsHb1Oyx2RGaCT88q1/DwvK
         eOgorOw3+fyJ8o/X5L6ac0h2m+xQNvJR7lHiwa2hYbEmxfzNLR9EjOMjXNBZIwRJJ0hB
         zx0xtACOL02jSEtDXUX4qCwFSSFXUYw5KkU+gzQUBJqAs98h9xAxbAMiCVexKQKiIya6
         5/rKTM8jfaYwMZE+y4+flWvCq6xTMQ+mM2xmGnI5vw8LZZglQ7ZFHDN9fvLesyrU0Qtk
         02NZeCHkO6xBK9bDlY+4OgBlml7uy4QjJDJDmILaY/DjKG3TYXMRHLP1qwrw2lwcxBAT
         gF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PnVMJ6oAgksCie67I0Q+ZVq4GBEcB2ttMdroPfb5JJg=;
        b=aQff3tpJW6CTLhHQ+H/7x55M7peWPEXLS3FHuKPy6c7ZzqeqXuOAbvTa7IxraiWLqz
         7FcwpapZDoouJJDPeq+eAtQ42ucBq3JgVJPu2cw4tSv4Fiz0ztIoqXH4I4e/gUTe4//Z
         C9EerUHqUzXFH0107mc6nh7QY6WluR+nw4aXVwvLX0eAJTfUTBcrndKDf9ztdqfGcubr
         AtYJWWQSPV1mb9g9U66JMOJ+HUw/jvXzgrFteOCFJFEG0qkuVZErNE1O5wdIFx+uHpfc
         TPVh4ZUNkaF2E1IIBHjlXjzhHC60m1shJFX47vdv/qPqqcAx0yglGX9JgYVnawbhyORW
         3g2Q==
X-Gm-Message-State: ALKqPwenDV4f4JJ8IK8TM5cfk2OtnEwYxHu3UFAnk2SwBHZhOaGRkeMt
        NTXWUk83PGZ1kySUL2NDcqdnBvLm+C0/JkgdfWADr6UcmlY=
X-Google-Smtp-Source: AB8JxZoE0AqRBPy+Blk82WK4YE4ZsSHrIxgiJeyv/i7kqxsoj/0m4hKPh9YWf2yj/7ouCCUamBPXFjB+NyGqiOPXzAI=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr869365ywa.340.1526488865676;
 Wed, 16 May 2018 09:41:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Wed, 16 May 2018 09:41:04
 -0700 (PDT)
In-Reply-To: <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com> <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 May 2018 09:41:04 -0700
Message-ID: <CAGZ79kYBykcbzKxc_FHiL6dt=jkmK2Khe-e5aSxFephe=RsBFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] merge: setup `opts` later in `checkout_fast_forward()`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Jonathan Tan for a side discussion on anchoring.

On Wed, May 16, 2018 at 9:30 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
>
> This patch is best viewed using something like this (note the tab!):
> --color-moved --anchored=3D"      trees[nr_trees] =3D parse_tree_indirect=
"

Heh! Having a "is best viewed" paragraph is the new shiny thing in
commit messages as 'git log origin/pu --grep "is best viewed"' tells me.

Regarding the anchoring, I wonder if we can improve it by ignoring
whitespaces or just looking for substrings, or by allowing regexes or ...

Thanks,
Stefan
