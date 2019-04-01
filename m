Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA2920248
	for <e@80x24.org>; Mon,  1 Apr 2019 13:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfDAN41 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 09:56:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36924 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfDAN40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 09:56:26 -0400
Received: by mail-it1-f195.google.com with SMTP id u65so15352731itc.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9B6FEI3PpBJ1AvnPPNMXzA/glIWarkda40ZYRxEuYvM=;
        b=I0L/Sx+A9pvqgzqwnnKiIkRaOvqLEb5DZEFSDCysOMfpcq5QnYVeKutF+olrnJRj+p
         LksHduzO5E3cQsvhVoOJIjxw5ug4Y6REXfy675kctBOfe5+7gMBfyubX5ii5TacgyMUL
         gdRqZGH+pCA1N+NmxSpKIfxD7IESCJJq3UOjlq/6okNh3ax/vJhgRQup+CPXmaYBMQje
         BsZWCfoD0vNNV+sJcYmoeIvwYU0YwlcmPd62TU7AM4ljrvgEJ4kJwr0MqGz4fheuDE/S
         2bkrpXLapiT7BNHyCqJl8XLcGbgL0FnL7gS2b/rD6cDlHfi1AuICHcYCjhml36796Cc2
         KWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9B6FEI3PpBJ1AvnPPNMXzA/glIWarkda40ZYRxEuYvM=;
        b=Uhov9qfE5s7iFTDhHTb2ZxCQ7m2Erm2pTPJqv/8jud5bt0NXLGeR1xD+huvEBN6TTF
         0QN1PbORijswCuadJIjID4WDhS12Kx/sbb9wbWYnyixmBK+R3uiy9nvSf+XV+hZkp2co
         zeUgwdoQxD+kyHV3Qb+y5nDZBlEbuSnHDhTWQFkaKA9zT6Zq9o/j2n2L2vFyP6k3RkGy
         TZR80YJC3tadfxvObHU9idYYGhojAXe6Gq81DazuLz8O9OvTJC98oppSIwidX1po83R6
         M+qjSKq8087Y9LXvLFPXsVSXU7WzK+upTEPASMvoiD2+QUbNhZmeHNSkZt+wfYOnOdQw
         au9Q==
X-Gm-Message-State: APjAAAXBkpWxFZxEH0JljJM6QyIZYwzuI1L1lcMYDjN0gjqEeh6q1eOu
        SUpLjmMkQXjjPtF2/xist7WyBBwk2jEmG5Tr2HAl/g==
X-Google-Smtp-Source: APXvYqz5xLG2V4prS6sXeOtP3EnQzl/AjTEBHOQGoaxHwCQySKdQXrdMUtFFeHm1PoP7KMBiQI8LB0OhdjobzBE/zgo=
X-Received: by 2002:a24:4755:: with SMTP id t82mr14350648itb.72.1554126985913;
 Mon, 01 Apr 2019 06:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br> <20190331181635.GU32487@hank.intra.tgummerer.com>
In-Reply-To: <20190331181635.GU32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 1 Apr 2019 10:56:14 -0300
Message-ID: <CAHd-oW63ysav-xgL4txuwMTtu+EPi5W82SOoKFpgfPz9eKz0Nw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 0/7] clone: dir-iterator refactoring with tests
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 31, 2019 at 3:16 PM Thomas Gummerer <t.gummerer@gmail.com> wrot=
e:
>
> On 03/30, Matheus Tavares wrote:
> > This patchset contains:
> > - a replacement of explicit recursive dir iteration at
> >   copy_or_link_directory for the dir-iterator API;
> > - some refactoring and behaviour changes at local clone, mainly to
> >   take care of symlinks and hidden files at .git/objects; and
> > - tests for this type of files
>
> Thanks.  I read through the series, and only found a few minor nits.
>
> One note on the cover letter, as I'm not sure I mentioned this before.
> But as the series progresses and there are less changes in individual
> patches, it is useful to include a 'range-diff', so reviewers can
> quickly see what changed in the series.  This is especially useful if
> they can still remember the last iteration, so they don't necessarily
> have to re-read the whole series.
>
> This can be added using the '--range-diff' option in 'git
> format-patch'.

Thanks! I think you've said it earlier, but I forgot to use. I will
include it in v6! Thanks for remembering me about it.

> > Changes since v4:
> > - Improved and fixed errors at messages from patches 1, 3, 5, 6 and 7.
> > - At first patch:
> >   - Simplified construction, changing a multi-line cat for an echo.
> >   - Removed unnecessary subshells.
> >   - Disabled gc.auto, just to make sure we don't get any undesired
> >     behaviour for this test
> >   - Removed the first section of a sed command ("s!/..\$!/X!;")
> >     that converts SHA-1s to fixed strings. No SHA-1 seemed to
> >     be changed by this section and neither it seemed to be used
> >     after the command.
> > - At second patch, removed linkat() usage, which is  POSIX.1-2008
> >   and may not be supported in all platforms git is being built.
> >   Now the same effect is achieved using real_pathdup() + link().
> >
> > v4: https://public-inbox.org/git/20190322232237.13293-1-matheus.bernard=
ino@usp.br/
> >
> > Matheus Tavares (6):
> >   clone: better handle symlinked files at .git/objects/
> >   dir-iterator: add flags parameter to dir_iterator_begin
> >   clone: copy hidden paths at local clone
> >   clone: extract function from copy_or_link_directory
> >   clone: use dir-iterator to avoid explicit dir traversal
> >   clone: replace strcmp by fspathcmp
> >
> > =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason (1):
> >   clone: test for our behavior on odd objects/* content
> >
> >  builtin/clone.c            |  75 ++++++++++++---------
> >  dir-iterator.c             |  28 +++++++-
> >  dir-iterator.h             |  39 +++++++++--
> >  refs/files-backend.c       |   2 +-
> >  t/t5604-clone-reference.sh | 133 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 235 insertions(+), 42 deletions(-)
> >
> > --
> > 2.20.1
> >
