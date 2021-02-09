Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C972C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3643564E0D
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhBJAKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:10:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60261 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhBIXYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 18:24:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A978E10D75A;
        Tue,  9 Feb 2021 18:23:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KxsrXX+L0vDzLIHDmO+m+bbjoOE=; b=hNvswV
        J4VZvSIZIfToQNCRGtvVvhz6fZb+mf1BpmeR/yb6cX1zJd+OxJh9SVyc8zcdFKoT
        W57pmPxf51gZ34CkzI69IR2BOOjoJG5HP9RYnKsu437VpWUfWvT+tDI1LiwxE57D
        AfCVJCeMsclXlJ2AI34Ivq8lUDWhlzp/75wiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpA/GNUdxj5jnoe+JPLrpJNvWgq8popS
        mk8t9ZMcjH/S8pywHRvAxiDj+AmhRQXVzcq42fXx5qeBe/d7uYAR6licCuQGn5rG
        PwldmPYjNh9Fa5X7grJG53h7QGw7a7w3ICsVaqufeySzCXgp5Cx1DpF7Wae5rTPN
        yZVh5jmI0y4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A20BB10D759;
        Tue,  9 Feb 2021 18:23:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF85C10D756;
        Tue,  9 Feb 2021 18:23:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com
Subject: Re: [PATCH v7] grep: honor sparse-checkout on working tree searches
References: <cover.1599758167.git.matheus.bernardino@usp.br>
        <5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br>
Date:   Tue, 09 Feb 2021 15:23:04 -0800
In-Reply-To: <5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Tue, 9 Feb 2021 18:33:30 -0300")
Message-ID: <xmqqtuqkygfb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C34E1A44-6B2D-11EB-8BBA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> This new version includes only the bug fix for the working tree grep, as
> discussed in [1]. I think there are a couple other patches that could be
> extracted from the previous v6 [2] and sent as standalone topics,
> without the risk of conflicting with the sparse-index work. E.g. the
> unification of the git-grep.txt and config/grep.txt doc files. I'll look
> into that tomorrow.

As mt/rm-sparse-checkout depends on the v6 that you are ejecting
with this patch, I'll stop merging that topic to 'seen' for now.

Thanks for keeping an eye on this one.

