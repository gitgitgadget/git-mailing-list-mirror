Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20371C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjHKVqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjHKVqb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:46:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1400271B
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:46:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1051A1A6BD0;
        Fri, 11 Aug 2023 17:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QdKIx2VIZ9T7HIZzQaXIs/GwwUvvlH/xEDqxiv
        WFT8k=; b=GuWD5+QsLHjo6sAXRkEM9QDELYiny8xxiPci5GuWNrHHlkj2VdnKGX
        gWBtyeQ8HktD3jHzdWREspV4LInlGHCoXjan+JUAh6jyDjofNYKJY2Ec/1J4IsPr
        qCIjgKQsX1QRIjCrlcWBVtYQR1sO9pPIAJKZhlgz7teTRnd0gdI7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08A791A6BCF;
        Fri, 11 Aug 2023 17:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70B401A6BCD;
        Fri, 11 Aug 2023 17:46:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mun Johl <Mun.Johl@wdc.com>
Cc:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "fatal: Not a git repository" issued during 'make' from source
 code
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
        <xmqqr0o9qpon.fsf@gitster.g>
        <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
        <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
Date:   Fri, 11 Aug 2023 14:46:29 -0700
In-Reply-To: <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        (Mun Johl's message of "Fri, 11 Aug 2023 21:15:22 +0000")
Message-ID: <xmqqv8dlp80a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88172B4A-3890-11EE-91C0-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mun Johl <Mun.Johl@wdc.com> writes:

> Due to some "security precautions", I am unable to use 'git clone
> https://git.kernel.org/pub/scm/git/git.git' to download the source
> code.  But I can try to figure out a workaround for that if that
> is my only option at this point to successfully compile git.

If building from tarball extract fails with "not a git repository"
there is something very wrong with what you are doing, and we do not
know what it is.

Most likely cause new folks fail to build from the source is lack of
necessary development libraries and packages that need to be
installed in their build environment, but I am reasonably certain
that if a tarball extract build is failing due to their environment,
build in a clone of the source repository would fail for exactly the
same reason.
