Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3715C1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfFYSAb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 14:00:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54673 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbfFYSA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 14:00:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCEB716BAA1;
        Tue, 25 Jun 2019 14:00:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1k55LUGhTt0aFjEV8KxC7MtKo6I=; b=TudnVb
        rT1mkVhUK0hekmjP9ouoIIJ6xL5fEfqf7iuWdXBd3SVNWfilwalLDfxiMXXJw5Rp
        /IqwrRqP1JYzHfiHtKrf8G/HFl4VIWKXZDRIo1EradBSW9DWP6EyUNZKxzGGouHV
        IenlneIp2N5ZFOibOAcLG4nIXAu3XVlmzPsLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hov+dy4Sri/2fmQ6WMt0gBtv44EAvqSW
        G1Ghcr2TH81uCmVquKFgadfzycuyFBDhi+N5eo+f+VmaarPxFW+TalJxRV9azXdC
        R37hIJipER4+tHpeFuxQ83lqceZjZjdUtKJKEYGKGW8jwXIKS5ProBoo1JdFIskg
        x+EioxRSWXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D10C016BAA0;
        Tue, 25 Jun 2019 14:00:23 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAE7616BA9F;
        Tue, 25 Jun 2019 14:00:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
References: <cover.1560898723.git.matheus.bernardino@usp.br>
        <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
Date:   Tue, 25 Jun 2019 11:00:21 -0700
In-Reply-To: <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Tue, 18 Jun 2019 20:27:43 -0300")
Message-ID: <xmqqimstfsui.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A42DD20-9773-11E9-8CAA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

This hunk, which claims to have 25 lines in the postimage ...

> @@ -44,6 +45,25 @@
>   * dir_iterator_advance() again.
>   */
>  
> +/*
> + * Flags for dir_iterator_begin:
> + *
> + * - DIR_ITERATOR_PEDANTIC: override dir-iterator's default behavior
> + *   in case of an error at dir_iterator_advance(), which is to keep
> + *   looking for a next valid entry. With this flag, resources are freed
> + *   and ITER_ERROR is returned immediately. In both cases, a meaningful
> + *   warning is emitted. Note: ENOENT errors are always ignored so that
> + *   the API users may remove files during iteration.
> + *
> + * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks.
> + *   i.e., linked directories' contents will be iterated over and
> + *   iter->base.st will contain information on the referred files,
> + *   not the symlinks themselves, which is the default behavior.
> + *   Recursive symlinks are skipped with a warning and broken symlinks
> + *   are ignored.
> + */
> +#define DIR_ITERATOR_PEDANTIC (1 << 0)
> +#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
> +
>  struct dir_iterator {
>  	/* The current path: */
>  	struct strbuf path;
> @@ -58,29 +78,38 @@ struct dir_iterator {

... adds 20 lines, making the postimage 26 lines long.

Did you hand edit your patch?  It is OK to do so, as long as you
know what you are doing ;-).  Adjust the length of the postimage on
the @@ ... @@ line to make it consistent with the patch text, and
also make sure a tweak you do here won't make later patches not
apply.
