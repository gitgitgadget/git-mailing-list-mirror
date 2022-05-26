Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676A7C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 23:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348434AbiEZXKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 19:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiEZXKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 19:10:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB2E5290
        for <git@vger.kernel.org>; Thu, 26 May 2022 16:10:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1674013910E;
        Thu, 26 May 2022 19:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z6gEvKDDGUBAZKUtqjZ5FqTuVoLMKPtf0R/VGy
        hPDtc=; b=c8t0qmzvnp05CD5Evz/rhSrxFKRHQM8i29QiCz2G3DmPqM03CKAoJW
        8Ezy1bcEFcxqyNgY/rz5LDhyDo+hfjtSKJPj9e6Y51dKv+Bl77xTHkA3i4Uy4xVc
        fQYE14kr2qPfDMPY7CN1HET4NN7lyNeX2m0sQizZHiIDi5t0/Gn7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DED6213910D;
        Thu, 26 May 2022 19:10:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F51413910B;
        Thu, 26 May 2022 19:10:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
References: <xmqqzgj41ya2.fsf@gitster.g>
        <df44b0cd-bba7-19f0-4e45-c0988239cc4d@github.com>
        <xmqq4k1c1a34.fsf@gitster.g>
        <8b57f907-3db1-9fe1-d582-e2d05acbe5ce@github.com>
Date:   Thu, 26 May 2022 16:10:08 -0700
In-Reply-To: <8b57f907-3db1-9fe1-d582-e2d05acbe5ce@github.com> (Victoria Dye's
        message of "Thu, 26 May 2022 11:30:49 -0700")
Message-ID: <xmqqr14fx54f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE10DB42-DD48-11EC-80B8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> If that is the case, then I am OK to merge this to 'next' to cast it
>> in stone, and then the let "rebuild the base" part once die, to be
>> reborn as many "tweak the way things work to (clarify|optimize) X"
>> follow-up topics.
>> 
> I'm not sure 'ab/ci-setup-simplify' would need to "die", more that it would
> be adjusted to rebase on top of an updated 'next' (including
> 'js/ci-github-workflow-markup').

Yeah, that is much closer to what I meant to say.  The one that
wants to build directly on top of 'master' would need to be retired,
because Dscho's series makes quite a lot of overlapping changes, and
it no longer would be "GitHub workflow is built on top of this
rearchitected foundation" anymore.

> That said, a re-sent version focusing on
> its own optimizations/improvements (rather than a comparisons against an IMO
> largely unrelated series) would almost certainly benefit both the series and
> its readers.

Thanks.

