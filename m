Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC4AC433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 04:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJIElJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 00:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIElI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 00:41:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7322BE0
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 21:41:05 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2106165C89;
        Sun,  9 Oct 2022 00:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MbOie4QpjfRe
        /8cf8bzKGHqqfOMvin2rC8DdRFshvwQ=; b=O8BhtCmjHQu6MiBXYu0BrwxmUlH1
        9Q63s+iJtrBNfaNIU5z0Tk4RaokfV+qsyM8XRHL2q1VneXi5zKVHUOktZ8DbEyZT
        BBJPKMiZojZFDMaBvRAYWaofFDjuwm7OXAtQ0wvJDfrosVj1LqzZz8FCmVF6PRKq
        GKtc1Yt8zaruqrY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98791165C88;
        Sun,  9 Oct 2022 00:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE701165C87;
        Sun,  9 Oct 2022 00:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
        <CAPig+cQHw_VjbA2_HaZJj3Q0v8C6uUukr40vXFuizx4M_04XFA@mail.gmail.com>
Date:   Sat, 08 Oct 2022 21:41:02 -0700
In-Reply-To: <CAPig+cQHw_VjbA2_HaZJj3Q0v8C6uUukr40vXFuizx4M_04XFA@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 8 Oct 2022 00:54:36 -0400")
Message-ID: <xmqqr0zha9sx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 950C3214-478C-11ED-82F3-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> With his recent documentation-normalization work, I suspect =C3=86var w=
ould
> appreciate an update to the synopsis, as well:
>
>     SYNOPSIS
>     --------
>     [verse]
>     'git symbolic-ref' [-m <reason>] <name> <ref>
>    -'git symbolic-ref' [-q] [--short] <name>
>    +'git symbolic-ref' [-q] [--short] [--no-recurse] <name>
>     'git symbolic-ref' --delete [-q] <name>
>
> or something similar (i.e. plain [--recurse] or composite
> [--[no-]-recurse] or [--recurse | --no-recurse]).

Yeah, that looks good.

I checked the in-code usage that used [<options>] (hence I didn't
have to do anything new), but apparently forgot about the doc.

As there is (and there will ever be) no configuration knob for this
plumbing command to make the non-recursive behaviour the default, I
think listing [--no-recurse] alone, not [--[no-]recurse], would be
the right thing to do in the documentation.

Thanks.
