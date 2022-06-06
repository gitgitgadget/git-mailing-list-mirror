Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC0C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 16:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbiFFQgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiFFQgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 12:36:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875361EAEF
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 09:36:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DE5318ECAB;
        Mon,  6 Jun 2022 12:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ric8GJAALeb04JFPfoG8kSGwSIkrUkjS6hgax6
        pdimQ=; b=b4Szlb8iiHfZxNzuHyMorX2j0DeufY5xZU6GtzTYO7PVVKNADaIwfy
        e7Hq9+bD4RWoOES5yIk2DTMBn6Id3R096VJ0jEHBOWG5JuGeJ8kUc3/h67zj9dA4
        a0QetvYxJGRTPePoxlXlr3K1BxHU3n2PhlaRjCYpfhzfbrkxKU2b0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0638C18ECAA;
        Mon,  6 Jun 2022 12:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7CD3F18ECA2;
        Mon,  6 Jun 2022 12:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <YppSl4rOvVciLuXE@nand.local>
        <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com>
Date:   Mon, 06 Jun 2022 09:36:04 -0700
In-Reply-To: <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com> (Phillip Wood's
        message of "Sat, 4 Jun 2022 16:28:39 +0100")
Message-ID: <xmqqr141agwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2B7D5E8-E5B6-11EC-8385-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Instead of using 'label' and 'exec' I'd prefer a new todo list command
> ('update-ref' or 'update-branch'?) used in place of 'label' that takes
> a branch name and updates the branch ref at the end of the
> rebase. That would make it easy to do all the updates in a single
> transaction as you suggested.

Sounds like a good approach.
