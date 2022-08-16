Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C2C32772
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiHPSzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiHPSzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:55:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BD37C181
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:55:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E65931AC024;
        Tue, 16 Aug 2022 14:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=0yOvNy1X3FsToPHmixMr/BHhL
        izU1lFtOGL7C6H9Qik=; b=QrrNjK1RM+cGWvEmeSDe6ZrdBAso8RWNrqU7UnBE3
        evKMifuEMdoaYfy0mgXTC8A8UqIDe/iNPdGrod21Cp78xW9/OQndPuTLzwwvt+PI
        EDePOSHZbaq/2EVqWZHpkdgJytNS7lEx1Fz08a6+huUnYdCk0JugpWRWC4I4IbSG
        X8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEB0C1AC023;
        Tue, 16 Aug 2022 14:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A27FC1AC022;
        Tue, 16 Aug 2022 14:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2] allow "-" as short-hand for "@{-1}" in "branch -d"
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
        <pull.1315.v2.git.1660669912043.gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 11:55:04 -0700
Message-ID: <xmqqo7wkt3w7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F12A6CE0-1D94-11ED-9DFA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rub=C3=A9n Justo via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: rjusto <rjusto@gmail.com>

Documentation/SubmittingPatches:

    Also notice that a real name is used in the `Signed-off-by`
    trailer. Please don't hide your real name.

>      -    branch: allow "-" as a short-hand for "previous branch"
>      +    allow "-" as short-hand for "@{-1}" in "branch -d"

The "branch:" prefix is lost here, which is not an improvement.  The
"<area>:" prefix is what makes it easier to locate a particular
change in "git shortlog --no-merges v2.37.0..v2.38.0".

As to the implementation, there is nothing to complain about, but as
we already discussed during the reivew of the first iteration, I am
not sure if the goal is sound in the first place.

Thanks.
