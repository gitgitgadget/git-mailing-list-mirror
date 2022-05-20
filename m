Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D19C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiETXTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349077AbiETXTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:19:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F51957A6
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:19:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53B8419DD0B;
        Fri, 20 May 2022 19:19:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lT3T9l1Dbv2ub4h4K2jfzyPnidFiIVbr4B2TYF
        uy4Ac=; b=HfGAJCGTJF4v/gitl9Mu2ARhbnlaqVidNhT/Q1z+RHtWY/+ChU5uge
        o34R2JLcQ+YzTK1i8cRWoewlo8jgMJzL4T1FVBzxcufwGol/awQu4J3RA92OstFl
        scANfja+SniAHlm9AdqYy3Z07SkqDS6qoPeVSlG432jsdvV3l3ARo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F77B19DD0A;
        Fri, 20 May 2022 19:19:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0A6419DD09;
        Fri, 20 May 2022 19:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, jrnieder@gmail.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: [PATCH v4 00/17] cruft packs
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1652915424.git.me@ttaylorr.com>
        <98d9bbe5-1902-0dc4-e41e-33020d0396ad@github.com>
Date:   Fri, 20 May 2022 16:19:15 -0700
In-Reply-To: <98d9bbe5-1902-0dc4-e41e-33020d0396ad@github.com> (Derrick
        Stolee's message of "Wed, 18 May 2022 19:48:37 -0400")
Message-ID: <xmqqa6bbg5cc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44DBF576-D893-11EC-A8D4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>   - updating the `finalize_hashfile()` calls for writing `.mtimes` files
>>     to indicate that they are `FSYNC_COMPONENT_PACK_METADATA`, since the
>>     original version of this series predates the fine-grained fsync
>>     configuration in 2.36.
>
> Good to have this update and not require it to be handled at merge
> time by the maintainer.

Heh, my rerere database is good enough to make it a non-issue ;-)

>> As always, a range-diff is below. Thanks in advance for taking another
>> look!
>
> Looking at the range-diff, I'm happy with this version.

Thanks.  I am tempted to mark the topic as "expecting (hopefully the
final) reroll", to be merged down to 'next' soonish.


