Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AC520451
	for <e@80x24.org>; Wed, 16 Nov 2016 19:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbcKPTSL (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 14:18:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65486 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753147AbcKPTSK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 14:18:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FE524EF4F;
        Wed, 16 Nov 2016 14:18:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L9D0RhbmeUpK5GY6WtJYRBz5lNw=; b=rNedNL
        zVNwPlQYv4OVGS4mryQ+kVEv96TbP9NYYQBctR96pcsKARga632Kj/YrUfj49hIe
        BGmXwCQLHd0auAb4qD9KBSHWxaQjNNVmTfID2t/3OLmef2JkeDDc01+g8H0KdZTR
        wWJAj5H4G76NCVsAGxPc9DZsCx3rTJ7oHkeJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HIyKqNg9aN2vpeAsyBid/w024uJeBZHh
        RUb0EuDLJGKWPBYHdoCYlCIL7mpF1rvfjWdjNGDXljBEWlQcXkLRxGPvTtMcc8Qp
        mapBek6oyKvcVVfIrF0Dd3Gig7AVZLrVrFRWuNzJQ90cEpJOIMXU9lPTSLsd2j4b
        RdN8SWnCZXg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16D324EF4E;
        Wed, 16 Nov 2016 14:18:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 868904EF4C;
        Wed, 16 Nov 2016 14:18:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v4 4/4] submodule_needs_pushing() NEEDSWORK when we can not answer this question
References: <cover.1479308877.git.hvoigt@hvoigt.net>
        <cover.1479308877.git.hvoigt@hvoigt.net>
        <9c95594f73625e06374f323fa5dc7d6487aa0356.1479308877.git.hvoigt@hvoigt.net>
Date:   Wed, 16 Nov 2016 11:18:07 -0800
In-Reply-To: <9c95594f73625e06374f323fa5dc7d6487aa0356.1479308877.git.hvoigt@hvoigt.net>
        (Heiko Voigt's message of "Wed, 16 Nov 2016 16:11:07 +0100")
Message-ID: <xmqqoa1fp72o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6863A118-AC31-11E6-88F0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---

Needs retitle ;-)  Here is what I tentatively queued.

    submodule_needs_pushing(): explain the behaviour when we cannot answer
    
    When we do not have commits that are involved in the update of the
    superproject in our copy of submodule, we cannot tell if the remote
    end needs to acquire these commits to be able to check out the
    superproject tree.  Explain why we answer "no there is no need/point
    in pushing from our submodule repository" in this case.
    
    Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

>  submodule.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index 11391fa..00dd655 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -531,6 +531,17 @@ static int submodule_has_commits(const char *path, struct sha1_array *commits)
>  static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
>  {
>  	if (!submodule_has_commits(path, commits))
> +		/*
> +		 * NOTE: We do consider it safe to return "no" here. The
> +		 * correct answer would be "We do not know" instead of
> +		 * "No push needed", but it is quite hard to change
> +		 * the submodule pointer without having the submodule
> +		 * around. If a user did however change the submodules
> +		 * without having the submodule around, this indicates
> +		 * an expert who knows what they are doing or a
> +		 * maintainer integrating work from other people. In
> +		 * both cases it should be safe to skip this check.
> +		 */
>  		return 0;
>  
>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
