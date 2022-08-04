Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A1C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 19:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiHDTaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiHDTad (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 15:30:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7E13E0C
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 12:30:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 672BB1541B8;
        Thu,  4 Aug 2022 15:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z5lVTr+pSMHX
        VAvhfHM8KIQk4QG9qa9FwdFS4pv8xxE=; b=YYUXGGB8pra6kmsz4EDc+rlcfIRF
        n6X7r/l6rKDzQo8kcZ+UzT7/dQjXOUPh1MdVPsrsFANBpE8tuiSCtDDdqPeSC9v/
        u3ptWHaDOz6iileH0YZf4CuRz5f9fpgh+o2aK5SuPdv1pKpFfrdgdfZ2m2ggONER
        l4/JDkvJGNXiRA0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D3001541B7;
        Thu,  4 Aug 2022 15:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF8081541B6;
        Thu,  4 Aug 2022 15:30:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 07/10] docs: move protocol-related docs to man section 5
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-07.10-cfd1b0afb53-20220802T125258Z-avarab@gmail.com>
        <xmqqbkt1cohu.fsf@gitster.g>
        <220804.867d3ot1gt.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Aug 2022 12:30:28 -0700
In-Reply-To: <220804.867d3ot1gt.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Aug 2022 18:29:39 +0200")
Message-ID: <xmqqles34xij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E63EEE68-142B-11ED-8F86-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I tried to address all your other concerns in the just-sent v8, but I
> don't think there's any rename fix-up here, but maybe I'm missing
> something. These files are all being moved to their new
> gitprotocol-*.txt homes (and weren't moved in preceding commits).

Sorry, I thought it was rather obvious from what I wrote in my
review for the step before this one.

This is an "oops" fix-up buried in other changes in 07/10 that fixes
the duplicated entry made in the previous step.

> diff --git a/command-list.txt b/command-list.txt
> index 44e244a76f6..ed859fdd798 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -210,7 +210,6 @@ gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide
>  gitformat-bundle                        developerinterfaces
> -gitformat-bundle                        developerinterfaces
>  gitformat-commit-graph                  developerinterfaces
>  gitglossary                             guide
>  githooks                                userinterfaces
