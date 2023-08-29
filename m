Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05021C83F12
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbjH2XQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbjH2XQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:16:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E444107
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:16:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A52C1375EC;
        Tue, 29 Aug 2023 19:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MHoWSfmWNdCq7Q3jIAPUgMS2EX673DnMAsMU6T
        sp6aY=; b=Lqm/0Z8hw7PpR8p28T8FHqBMuUf/21CYpKoIqh4G74xny7pNfzpxaP
        lrWaTZ+eU/ZOJUSbLnVbainjRs/foSGsEFkGfW94C5oDne2ggGUV6Hko8cyv/Xf2
        C453niG1JW+J8vwOgdD0TUcdajp+0M9fII9SIuvhoc8mTkc6e1AvI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DB06375EB;
        Tue, 29 Aug 2023 19:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 375CA375E9;
        Tue, 29 Aug 2023 19:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/15] bloom: changed-path Bloom filters v2
References: <20230829221849.562285-1-jonathantanmy@google.com>
Date:   Tue, 29 Aug 2023 16:16:17 -0700
In-Reply-To: <20230829221849.562285-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 29 Aug 2023 15:18:49 -0700")
Message-ID: <xmqqcyz5bfsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EE30B78-46C2-11EE-B2CF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> So I think that we can merge this patch set. An alternative would be
> to wait for me (or someone else) to write such a test, but if it's just
> me that's worried about this situation, it's probably not worth waiting
> just for this.
>
> The other outstanding thing is that Szeder Gabor pointed out that Bloom
> filters are not applied to root commits so some of the tests don't
> test what you would expect [2]. I've updated the tests and pushed the
> results to GitHub [3]. I'm OK with using that version, or the current
> version (in which case I'll resend the updated tests once this version
> is merged).
>
> [2] https://lore.kernel.org/git/20230826150610.GA1928@szeder.dev/
> [3] https://github.com/jonathantanmy/git/tree/changedpath

Thanks for a concise and well thought out summary.

If we know that some tests in the current round is not doing the
right thing, and we already have an updated set of tests to fix
them, I doubt that the topic is so urgent that merging a known to be
incomplete version is preferrable than seeing the hopefully final
version on the list that everybody can agree with.

Thanks.
