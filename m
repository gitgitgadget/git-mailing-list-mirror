Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADDDC43457
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C87F2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="N++wmCzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbgJJW4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:22 -0400
Received: from mout.web.de ([212.227.17.12]:53069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731529AbgJJTd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602358403;
        bh=ht/59yOKtBWuynfyoZ1ezGSKTcer32ItmnzYJfoABO4=;
        h=X-UI-Sender-Class:From:Subject:To:References:Date:In-Reply-To;
        b=N++wmCzm8ZTgJsZvr+XvaIXSR7ZihwC5xGYx/rlKo+v6j5vmcVQPczd3bVv9mua2x
         8Dj11zRl6tI4opnqY8ZsDA/k1rR0vBpqgzf6FN273kxpg7F1hk4kB8xxL+rcGLdl9/
         QhbC7n0RTZxx0211olbTJ+ZgHAFK2RcfKdN4SkXw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MY6sm-1kw0AG03cm-00UuiI; Sat, 10
 Oct 2020 18:45:16 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [ANNOUNCE] Git v2.29.0-rc1
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7drzv1bn.fsf@gitster.c.googlers.com>
Message-ID: <ce8f482f-9a78-6867-38ae-601bcc2c9f66@web.de>
Date:   Sat, 10 Oct 2020 18:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq7drzv1bn.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bwqhwq3McYxiMBrF64rrfqqYO0XN2QzCKpQel9GTQD19zppDpyD
 mrd0gAp+AdC2kZDfAue+mOcyaNpR466bc+PvNYzU+cD321NIethFb6Lc5/Vmvon00mWVg9z
 WwfdBCrfoKj+4yZ8rfqmdTND7NX3N1d5pA+oNimJndIcUDMwqf9ZZH4wgqTJwS4KZoNUdNo
 caM8Pb3Re8aAvLPYbkiSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/QrgSTVwDaM=:sJfh8i+nTsciGFxRy3VISK
 jMM7IEbMIyDxwimqNunzX+wkoKSMkLPprPDaYSY+OnDK4NhWuS7J8ZY61bGLZx6zqVBbLVbyI
 BrK3yLOIQNi5YaXgmRWxUwXj7UAw7yF7NUEh4fEcYfSbW3XUU/NM3a9wG2Wm9PGwtx95nTWzr
 SXYhwOI6+VigtDZqotIcWyJ65/HxDpKgUD45U5FrmZeD08UpeGQewKpfP7c8Qqe/c03Qy5b7g
 H7XWYweZWLYpIBL/Rngz8m7kC1BOkXzl5M8Thosn0tfJWUHBPbWk+ES0cE0KZTqrJmLvjt8Bd
 xkXuZ17/iwlDk4H0SO6LQAdOHHjvJEcB/ZaZdg37+o3N6YCdC/c4CsoyqniqRPSlJOkKSJHoA
 kEqErvbu+eKKAj7plPOLk7qOJOEaDAZL1/Q8JbmIpUSHDpsN+76TC1j3za9A8d/V/0pNHBHet
 PH80+6v1/qa162hMqL3in7M543CUnkEn2OkGID0mliJ7kwXv0pQdeFgVGhPQpi2/4tkbXUmO1
 agl5sjr5Y6vrF+xkCXxAE5Gw2MZGWNIFabSnI1gryNT3Z5PhpwTs0T8gnSjpNr8o/3Cmc7WzH
 0nKHIsDzmkTaiNSXnwvApXkFsVX4DJJUM8wq2eKZCgu80MB2zl04VsneWx26AldS3im2tSORK
 0fR0vSN1/Z3Se5D52AjtIBXzA6b9dPEHJoJP5VmPe/K0VZiho/67eYCfqSpIe9Hs+/dJ4HkzQ
 vZCos9EE0JMEi+Q6JnSB8nZouVjLyQiEyMK6zZ6LfEhdy8tSiXtKqMjs5A1PYslg+LfAtdn8p
 W9cUoZzAq05oPsPZD0m/EmIhhGC7OuvfIDHY5j9yzePec8xzB1U0pE6EKCvJCFbmC7Px/V6li
 S3JQcQtjzNn7Jl+fvAnHvyny9jWiCFWzk3Q/V0wqGj8/n73l7dlAMIRMZSIwXgtdf0un/19MJ
 +AMuWQOwLoIvOUayPLHTRqw62e8bqvNBICsQsRp+1/xiSO/cm2jamSr8IDNQ+AnRD/P8mMi2t
 2QuefVjmHJZeRokbLoCd+Ci+dO3MwRNest8LW3CUChV3eqtSPZjcjzgq9ovZou1sXpGeg4PDY
 eE5Lp6K+8oiHNWavq9bk7xRLLGKulaak8MmztRep7ESHsFvLvRt7u6xendwTtU9qdvx69F3/g
 5YJB0joZv8KaEd7vtj6KqQPpLy2ERK9ohhXjrGH5Yc5GERWtVxoCCQCXSFiME+Ehurrz4iE8W
 KFXUreXmyvmyoUCiP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.10.20 um 17:58 schrieb Junio C Hamano:
>  * "git archive" learns the "--add-file" option to include untracked
>    files into a snapshot from a tree-ish.

>       archive: read short blobs in archive.c::write_archive_entry()
>       archive: add --add-file
>       Makefile: use git-archive --add-file

Oh, this feature landed quickly, with little discussion.  I dropped the
ball while being distracted by other things and working on supporting
other use cases, like dist-doc and artifacts-tar.

The option --add-file in rc1 is peculiar in that it captures the value
of --prefix at the time of left-to-right parsing.  I don't know any
other option that does that.  It gives users a way to craft in-archive
paths, but simply adding them with their original path (just normalized
to use slashes as directory separators) would probably suffice.

The option serves a niche use case, so this weirdness might be bearable,
but I wouldn't have expected it to be merged without debate.  Perhaps
we want to slap an "experimental" label on it?

We can create the dist-doc tars easily without --add-file and tar(1);
patch forthcoming.

We could do the same for artifacts-tar, but that would generate a huge
archive due to the many hardlinks for dash aliases that are flattened
into copies.  Implementing hardlink support might be worthwhile anyway
and we would not even have to make it optional.  This target doesn't use
TAR_DIST_EXTRA_OPTS, so this is a separate topic anyway, though.

Ren=C3=A9
