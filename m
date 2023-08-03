Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35930EB64DD
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 16:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjHCQVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjHCQVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 12:21:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A453A97
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 09:21:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EA6A1A88AA;
        Thu,  3 Aug 2023 12:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LviFl16sRGY6
        Uw8PclX3J3FVSlOTOvr8xWH2XMgvW2Q=; b=I0pgvSxJmRFeMPAszwRs2RYubzg2
        poLDyxc2pa70XnnCIekQCfkNGpi9vlFZSXJpKusg+u6oZXo4d8KxSkfyHtqwgbIY
        Yyms9WAXnaUGek98ewCJC0IklpmDqoiEAGBWWIOoRABnfo2dNR3n3bs8e3d3PZpF
        jp+59lyYzTVR0Ik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 044661A88A9;
        Thu,  3 Aug 2023 12:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DE1D1A88A8;
        Thu,  3 Aug 2023 12:21:07 -0400 (EDT)
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
Subject: Re: [PATCH 3/3] docs: update when `git bisect visualize` uses `gitk`
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <c872431b608424007f72c69c8526f96d532aaca1.1691058498.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 09:21:06 -0700
In-Reply-To: <c872431b608424007f72c69c8526f96d532aaca1.1691058498.git.gitgitgadget@gmail.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Thu, 03
 Aug 2023
        10:28:18 +0000")
Message-ID: <xmqq35105c7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0173008-3219-11EE-A9DD-C65BE52EC81B-77302942!pb-smtp1.pobox.com
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
>  Documentation/git-bisect.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.tx=
t
> index fbb39fbdf5d..82b1d5ac6c5 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -204,9 +204,9 @@ as an alternative to `visualize`):
>  $ git bisect visualize
>  ------------
> =20
> -If the `DISPLAY` environment variable is not set, 'git log' is used
> -instead.  You can also give command-line options such as `-p` and
> -`--stat`.
> +If none of the environment variables `DISPLAY`, `SESSIONNAME`, `MSYSTE=
M` and
> +`SECURITYSESSIONID` is set, 'git log' is used instead.  You can also g=
ive
> +command-line options such as `-p` and `--stat`.

Good.  Would a casual (read: not working on) Git for Windows user
know if their environment has MSYSTEM variable?  The same question
applies to the other variables with relevant platforms.  I think
folks working in GUI environment of X Window pedigree may be
familiar enough with DISPLAY (but of course I am biased as I have
used such an envionrment in the past) that the original description
is permissible without extra explanation, but among these new ones
some may deserve an additional short description in parentheses,
e.g.

	..., `MSYSTEM` (always set in Git for Windows) and ...

Other than that, this is a very welcome addition.

Thanks.
