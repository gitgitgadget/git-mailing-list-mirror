Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B24C433DB
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB99A222BB
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JXWv8hZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgISVSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 17:18:36 -0400
Received: from mout.web.de ([217.72.192.78]:51415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgISVSg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 17:18:36 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 17:18:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600550315;
        bh=o1lR8EVN88t7BHc/xIEZ7HgxzRP8iaYHaQ9+nxhr/fg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JXWv8hZVl/a+pRFmorl60dua1Bsg8OthQCnHH/yEhw3iAk76sYcU/MifXnzDFjMOX
         JLT4FXnACEpciUOTqI4Iijm0kLRv4hph1EGFip5YMn+goxyzSNnZTCa7jt0mlC1j9Y
         xRVVST+eKDLXjz17XSadAkiadyVHF57bzy+pbDGE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1kQKoJ3hQu-007193; Sat, 19
 Sep 2020 23:13:27 +0200
Subject: Re: What's cooking in git.git (Sep 2020, #05; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Date:   Sat, 19 Sep 2020 23:13:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jfp4TnQ1LhlpcRskUtc5K/lbwO0rQ6H+heho+Haij7vOfTuuQ7B
 gczB9GzjtMmELulCscIW8R6y2Mv/tMxG43StOWNpP9lyxaI06SPYSwAFH/uEFPCdC6nWUWy
 pU49pLqsffS7oASwO7keXbt80mFVJo4vFIWLQqmB74RIqvm9A8wdvY1lzRY7i4IcmbPogYp
 DfaFnzxp1wNeOSKycUQow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d/cU5b92tNE=:XZf5sCyuiJudA88dXU0YW1
 KI4hCYYesuw3RaHVtXYPePMmQcLP/f7Gy6ijEjux148OlGq9wnWtzmR9Fa8aX6LwYp35mZDkf
 JojF5MAVlcAqQvgkL+vJJOzE77ECP15+J71INy6UWD3ITZGjqZN/sVMkanYhJmOQbZReqtHqG
 KhTg9xWHdDDROEiq7vTjxy1AAMXbRvJGb1R05apnj0ddQfgvXdgqKUlF2/kCxOLq7LyTaQG1H
 +Vajsu/9jZkuUfws0w7S75rMmJkwDgS31i4VufIj7buRSot/FmJmE0nmhQwIBU6E0YkAJrOHJ
 wD2Mx0aNGZ2dqbbGlf1kL95z+eakAiEwrqA0lVCSjuDtb8mIrO71aDvviXHQN2c3nKZuypntJ
 38pz3oHOAv8vr5oqwA1ZhqeIMRLq9xshbvlo3vLDs8unXWhNxsrzNozQ2mm1HPwMXFYJ5WHcY
 eZqH5M0TYgVz7QQZ76iBPGNHeLF/h8g8lUNp1Dk4ogBiLbpO4DL6adNiQKC4nEiJvtZEZF0Uk
 D83o7IVEXCVXhk6fzR4yH/kdWNqDPf7xudns6UxCNh5MCNK3S5RVmw16oVyeWTWCryLD8p48n
 JVma0CRTk8skaXI9POFOcr/wuzOER49UCNNnzWc2KX7X3MZouvuJwxWKofYbcluDbFJh+YkzO
 AWy0eRQ8d0qw0oWq4QT0V5iFXrkeR1JxTQl+rXcXRnAk/v8BzPCfADnpeAmBQNGQsoL8ac83W
 0GqyDQm4pxZ6V+MyURaxD4dD+hSw46l5ZYMYBXa7GycyAIZIt7xv1U9doD4b7Pd8gYvT6uCF8
 h/sU8UJ/KKK+HoWS9b8Fkyi8HuxQDWaRmx5XVRlU0YPdSbbHNadICm9yj5dZ07pd5vCXvlRJ5
 SDVUneTY9r36+dYTLugftv5nhWeL9wuC0m1JrKP4oBuXuVeU6HLKyUzhxO/OXN6m/ypvsCkkn
 O1zn0I9nSoFd+vSY7XfREr3+pMvgoO0SeeUtsZWWPVZ+bUOqWT4mayNpTJJaZfr8rCEWU9ptu
 lD77cW5lPOhiFT1eBSzV6OkCYoGcb2gDnP1teOapOVnR53UV7GHDg44pgBGcK951JWZVwy2pz
 ydVsxJOzSIyWLj2KMOAyDeWa0Ivoytfq1u11MlA0z7G7pUIvphnwPBxWbxv4n4fidzBnnRGW2
 T1OJvt8mUHmRAzse3cY4jzXbA/AInowFTkfQbQMK2SD4i6nZEMNRt0bsa79E//kX2Wod6PZNd
 YqdWrg+aG048JsRd3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.20 um 03:41 schrieb Junio C Hamano:
> * jc/dist-tarball-tweak (2020-09-09) 1 commit
>   (merged to 'next' on 2020-09-10 at 36cbe7ee9e)
>  + Makefile: allow extra tweaking of distribution tarball
>
>  Allow maintainers to tweak $(TAR) invocations done while making
>  distribution tarballs.

Just noticed this one.  It reminds me of an alternative solution for
archives containing both tracked and untracked files gathering dust on
my disk because I didn't see much demand.  It goes the other way and
gives untracked files the same meta data as tracked ones.  Interested?

  archive: read short blobs in archive.c::write_archive_entry()
  archive: add --add-file
  Makefile: use git-archive --add-file

 Documentation/git-archive.txt |   6 ++
 Makefile                      |  41 ++++++------
 archive-tar.c                 |  22 +------
 archive-zip.c                 |  22 ++-----
 archive.c                     | 117 +++++++++++++++++++++++++++++++---
 archive.h                     |   9 ++-
 t/t5000-tar-tree.sh           |  29 +++++++++
 t/t5003-archive-zip.sh        |  28 ++++++++
 8 files changed, 203 insertions(+), 71 deletions(-)

=2D-
2.28.0
