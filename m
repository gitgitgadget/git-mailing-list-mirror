Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA2C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiAGXZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 18:25:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52341 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiAGXZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 18:25:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F885110CF3;
        Fri,  7 Jan 2022 18:25:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y5f2CYP8M69Q
        kZuyaYqX14wk7tfoPYlEgphwxopZEyU=; b=Uyb1PnR4e3ViCPZvOhQqoMIAEpZe
        meqWzrMrZ8W8X4fTKZytEteRqFPjwLi224MzroV4MBG7+KwaifsWKH389By4c1M/
        oFKWBYcC4kwuedudRSmybBcLme5FL6aNPO9hJr3L+SM4aSd+MKlrpMyXHNt3C1E1
        2MthDx5EB5exlG4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06E46110CF2;
        Fri,  7 Jan 2022 18:25:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68552110CE5;
        Fri,  7 Jan 2022 18:25:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for
 CHERI/Arm's Morello
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
        <xmqqczl4bhmo.fsf@gitster.g>
        <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de>
Date:   Fri, 07 Jan 2022 15:25:17 -0800
In-Reply-To: <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Jan 2022 13:16:53 +0100")
Message-ID: <xmqq1r1j5dsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 136F4B18-7011-11EC-A78B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Subject: [PATCH] apply: use strsets to track symlinks
>
> Symlink changes are tracked in a string_list, with the util pointer
> value indicating whether a symlink is kept or removed.  Using fake
> pointer values requires awkward casts.  Use one strset for each type of
> change instead to simplify and shorten the code.
>
> Original-patch-by: Jessica Clarke <jrtc27@jrtc27.com>

This may be recording a misleading credit.  The original patch
certainly was a good input to make us realize that we have a
problem, but has no contribution to the final code.

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
