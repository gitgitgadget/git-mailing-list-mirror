Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B97C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiG1Ry0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiG1RyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:54:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F1874CEB
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:54:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B920514D7FF;
        Thu, 28 Jul 2022 13:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5hSAdCfHdBD1TVehMVRq90D6tXk/kddjdX9Cph
        /PR40=; b=Pl6RN2xSZOWowhPq9O0sVPLUgMQ7vM0m6Z+4vC9ZoR4IT7O6iyqkbP
        ee55VifqaVJnpAcEHTnDhUx6g5jR+dz37X2448sT9v8TZSunNeKmXUBrlpf8p/Ge
        wCk2Ih/tRLlnYmRiVjg0RWVH3P96RWfKnxWwnZGPgp4cM+rx0BWW4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B08CF14D7FE;
        Thu, 28 Jul 2022 13:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1984D14D7FD;
        Thu, 28 Jul 2022 13:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        larsxschneider@gmail.com, christian.couder@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v2] t/t0021: convert the rot13-filter.pl script to C
References: <cover.1658518769.git.matheus.bernardino@usp.br>
        <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
        <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr>
Date:   Thu, 28 Jul 2022 10:54:21 -0700
In-Reply-To: <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr> (Johannes
        Schindelin's message of "Thu, 28 Jul 2022 18:58:05 +0200 (CEST)")
Message-ID: <xmqqlesdazsi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 502E90F0-0E9E-11ED-8E44-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  - Squashed the two patches together.
>
> I see why this might have been suggested, but it definitely made it more
> challenging for me to review. You see, it is easy to just fly over a patch
> that simply removes the `PERL` prereq, but it is much harder to jump back
> and forth over all of these removals when the `.c` version of the filter
> is added before them and the `.pl` version is removed after them.

Yeah, I tend to agree.

> ...
> Other than that, this looks great!

Yup, thanks for an excellent review.
