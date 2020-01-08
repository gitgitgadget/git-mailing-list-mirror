Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB1C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6312120692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iFSLY6R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgAHVGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:06:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55691 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAHVGU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 16:06:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC8973DC8B;
        Wed,  8 Jan 2020 16:06:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oce1lDeLdGPygslgqDFYmhPh1BE=; b=iFSLY6
        R49dcYyCOtw7Osq4iwCqAVCu4AdRDT3NNFKTqvEcIiCXzBT0E5eKb1uaf49ymKPk
        YRRbdCv1tCDmoYiMtpwpWcINwG+pZqQO54Dtwzs8y9qiA+Y5Nns5CXVVWizwzB1Q
        yDFGZnst4IYxB0QN+LNAOiVhGdCN8esLPWeLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YU1+jZecmdpNxNkYHaCnfUzEdw5ejgEP
        Zol0wr7gezuhTA37s/sm1T4Q74XPxtOfeJR2jDuDtSMe6gfFx0niM6P66QpdY5b/
        6pjl44Z8KCs+PraHOY1QTrS0uMphm1xFFnmC9EnkkCZfn9iA67VIk391aFS/vGBg
        JL9d+U9DBAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3E7B3DC8A;
        Wed,  8 Jan 2020 16:06:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AD993DC89;
        Wed,  8 Jan 2020 16:06:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Graph horizontal fix
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
        <xmqq5zhl3jrm.fsf@gitster-ct.c.googlers.com>
        <c69afbe7-3a9c-0619-594f-f5ba980ae7b8@gmail.com>
Date:   Wed, 08 Jan 2020 13:06:15 -0800
In-Reply-To: <c69afbe7-3a9c-0619-594f-f5ba980ae7b8@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Jan 2020 15:05:50 -0500")
Message-ID: <xmqqk1611wvs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6077266-325A-11EA-9A86-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I guess I was incomplete in my first example. The full horizontal behavior
> before 0f0f389f was
> ...
> This change brings the horizontal lines back.

Ah, I see.  That was what you meant by regression-and-fix.

Thanks.
