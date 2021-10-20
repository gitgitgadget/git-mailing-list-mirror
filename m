Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE569C433FE
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F8A610A1
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhJTOuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:50:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54572 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJTOuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:50:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CEE0157AA6;
        Wed, 20 Oct 2021 10:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+0uS1+UVu/Vg5oa23hCVdK7qa3LHDTmcH1ozAs
        1Ni70=; b=aRUCI/py/z1CDAXcj7BVCLaCA5ks6eobBVURPqXV913BPU6iUIRkLe
        jSF/cyQWbvIF8RaGTGMBjr+u4vUafSlKfUm54/LC+INPJAMNtNrI3NeHIfPdLiv5
        XIopFM7IRWnWqUDidmz+F/BM5XS8N8jlSHlq/WExP4WqH+AuCR2KU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 256D2157AA5;
        Wed, 20 Oct 2021 10:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 250D1157AA4;
        Wed, 20 Oct 2021 10:47:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
References: <xmqqfstdr8b5.fsf@gitster.g>
        <YV5aaD418SyZqS/1@coredump.intra.peff.net>
        <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
        <YV5yi+AejPGO9qOi@nand.local>
        <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
        <YWC49+xCh+zum8Ms@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet>
Date:   Wed, 20 Oct 2021 07:47:52 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 20 Oct 2021 14:27:30 +0200 (CEST)")
Message-ID: <xmqqh7dbrbvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B45F90BE-31B4-11EC-B6F6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No objection. I'd just ask to use `${{github.repository}}` instead of
> hard-coding `peff/git`, and to really not run the workflow unless
> configured. So something like this:
> ...
> Note the `jobs.coverity.if` attribute. This is what will let the entire
> job be skipped unless the secrets are set up.

It would be nice if "the entire job be skipped" did not even make it
appear in the https://github.com/git/git/actions list.

I am assuming that your illustration is using the same trick as
git-l10n jobs, so the result will appear on the page in the same way
as they appear, i.e. with white circle with a 45-degree bar in it?

As long as we do not give outside parties anything stronger than a
read-only access, I have no objection to the plan, either.

Thanks.
