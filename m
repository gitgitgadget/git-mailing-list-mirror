Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA2C04A95
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 01:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiI2Bui (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 21:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiI2BuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 21:50:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCBB7C5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 18:49:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 823D81A9ECE;
        Wed, 28 Sep 2022 21:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y3fLQVLvI4JPIaUevh2givfJd14Zp89y610gqG
        8weSo=; b=xUUNVJ0Z6CH/r4t031PU+Ltx+iIzMskWscbKJFK4Ue08a0SIPSLBTi
        Svm8aw83/y9XRT3O2A9nSZ4v+1ybfopdDBiuvpkfT3WK+t0Cor0Gvj9WmddgjGhX
        dgbnHWv2nBqfGq/DL2rkSZASkux82IT9fgRwCJ1NRDk0Wtbb5uUBM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AD191A9ECD;
        Wed, 28 Sep 2022 21:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 335C21A9ECB;
        Wed, 28 Sep 2022 21:49:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] merge-ort: return early when failing to write a
 blob
References: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
        <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com>
        <bfc71a2d8adfbf9b899a47d469fe2343e4703ff7.1664350162.git.gitgitgadget@gmail.com>
        <xmqqleq3zea3.fsf@gitster.g>
        <CABPp-BFML-7osm-UUpXHf9exzUk0iktDWwm4tKu7ggv68SgJ_w@mail.gmail.com>
Date:   Wed, 28 Sep 2022 18:49:31 -0700
In-Reply-To: <CABPp-BFML-7osm-UUpXHf9exzUk0iktDWwm4tKu7ggv68SgJ_w@mail.gmail.com>
        (Elijah Newren's message of "Wed, 28 Sep 2022 18:36:33 -0700")
Message-ID: <xmqqwn9nospg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F68B7A28-3F98-11ED-B7C6-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> To me the description of the issue looks reasonable to me.  Any
>> comments, Elijah?
>
> Looks good to me!

Excellent.  Thanks, both.
