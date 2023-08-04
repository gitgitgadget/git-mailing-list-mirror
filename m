Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D36DC001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 04:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjHDEcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjHDEcV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 00:32:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A3420F
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 21:32:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABA6019F9B2;
        Fri,  4 Aug 2023 00:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0tkKPnQBI25s
        tcvDUCzIL1iCqqkjHVsydpECDbVW15Q=; b=eEram/S+TcFQEGG9Y1m28flaxHq2
        vbAdauHSIoU51Haa5huUqYNZdM1aSyu/GLouqSnwrWHmVFSF7NOEIw2+b59tkiBH
        41+/AduOh7DZxIhUo+5kd6tmPrUCmvlBj5Fk9Nfg+DT7T6xSX8MPdRYW86seg41r
        0iNajoynu3j8enc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1EA119F9B1;
        Fri,  4 Aug 2023 00:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F55219F9B0;
        Fri,  4 Aug 2023 00:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH v2 3/3] docs: update when `git bisect visualize` uses
 `gitk`
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
        <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 21:32:15 -0700
In-Reply-To: <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Fri, 04
 Aug 2023
        04:08:44 +0000")
Message-ID: <xmqqfs4z2zsg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3E61BE6-327F-11EE-B3F0-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> This check has involved more environment variables than just `DISPLAY` =
since
> 508e84a790 (bisect view: check for MinGW32 and MacOSX in addition to X1=
1,
> 2008-02-14), so let's update the documentation accordingly.
>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  Documentation/git-bisect.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.tx=
t
> index fbb39fbdf5d..bec8d2abb22 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -204,9 +204,14 @@ as an alternative to `visualize`):
>  $ git bisect visualize
>  ------------
> =20
> -If the `DISPLAY` environment variable is not set, 'git log' is used
> -instead.  You can also give command-line options such as `-p` and
> -`--stat`.
> +Git detects a graphical environment through various environment variab=
les:
> +`DISPLAY`, which is set in X Window System environments on Unix system=
s.
> +`SESSIONNAME`, which is set under Cygwin in interactive desktop sessio=
ns.
> +`MSYSTEM`, which is set under Msys2 and Git for Windows.
> +`SECURITYSESSIONID`, which is set on macOS in interactive desktop sess=
ions.

Great.

> +If none of these environment variables is set, 'git log' is used inste=
ad.
> +You can also give command-line options such as `-p` and `--stat`.

Micronit.  I think "is set" want to be "are set", as "none" in "none
of these" is used for "not any" [*].

> =20
>  ------------
>  $ git bisect visualize --stat


[Reference]

* https://www.merriam-webster.com/video/is-none-singular-or-plural
