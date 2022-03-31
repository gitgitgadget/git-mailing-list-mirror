Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80086C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350429AbiCaBuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiCaBt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:49:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959C488BD
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:48:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C11317F1A7;
        Wed, 30 Mar 2022 21:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OHRldoMLlFK4bWcQK1ltqvizF1InS/H+d5A43K
        Czk7o=; b=RHBvJvIVG+ddcw7PGG2v1+43Jj0D4bJ2BC3xGB6jvgCIp2htpAlEIn
        LyGn1f4vA0iFPsJzQdgqVvi8/Zab8aT1cnfZZokrywHigUo5X1drvVy+NUJAbHy9
        USKIEkNnGjq4NEliodU7ciAUK9jdmgYaQNKaDblsirWdQoHGZMTkU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 240F917F1A6;
        Wed, 30 Mar 2022 21:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CDB617F196;
        Wed, 30 Mar 2022 21:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/4] Importing and exporting stashes to refs
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220329214941.2018609-1-sandals@crustytoothpaste.net>
Date:   Wed, 30 Mar 2022 18:48:06 -0700
In-Reply-To: <20220329214941.2018609-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 29 Mar 2022 21:49:37 +0000")
Message-ID: <xmqqo81m51ux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CEA89D4-B094-11EC-8984-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> brian m. carlson (4):
>   object-name: make get_oid quietly return an error
>   builtin/stash: factor out revision parsing into a function
>   builtin/stash: provide a way to export stashes to a ref
>   builtin/stash: provide a way to import stashes from a ref
>
>  Documentation/git-stash.txt |  29 +++-
>  builtin/stash.c             | 324 ++++++++++++++++++++++++++++++++++--
>  cache.h                     |   1 +
>  object-name.c               |   6 +-
>  t/t3903-stash.sh            |  52 ++++++
>  5 files changed, 397 insertions(+), 15 deletions(-)

Merged to 'seen', t3903 seems to have a handful of breakages.
e.g. https://github.com/git/git/runs/5763421702?check_suite_focus=true

Thanks.
