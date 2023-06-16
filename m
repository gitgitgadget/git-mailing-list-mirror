Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9119EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 20:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjFPUMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjFPUMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 16:12:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD52D79
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 13:12:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC8DE24B49;
        Fri, 16 Jun 2023 16:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W29rZztO305l7fCSuer0a91Ba7yAUJMswBEl5r
        aU88U=; b=ixMp2B7uV5O0IWktsNPf8zfKcCLUQOPLbGCzb6OdkSFpe/mU0jcVkd
        Vw4jNU+OqH4bVcSVvD+Gv9EgujZjslBg2OkHeh+Lm78E+FyXw6tV6fdFPxeEOuWR
        hbgt6UVC+TEmFO4GMgmiDrUx5cCTACwKaQBzrdROuadrxcTKokNos=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4BE424B48;
        Fri, 16 Jun 2023 16:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8A5F24B45;
        Fri, 16 Jun 2023 16:11:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nadav Goldstein <nadav.goldstein96@gmail.com>
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
        <xmqqjzw3qry6.fsf@gitster.g> <ZIzALOe8GBsNGIhR@ugly>
Date:   Fri, 16 Jun 2023 13:11:58 -0700
In-Reply-To: <ZIzALOe8GBsNGIhR@ugly> (Oswald Buddenhagen's message of "Fri, 16
        Jun 2023 22:03:56 +0200")
Message-ID: <xmqqv8fnrwtt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CF4DF00-0C82-11EE-BAA8-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>Why a new subcommand, not a new option to "push"?  Adding a new
>>subcommand would mean it would be another unfamiliar thing users
>>need to learn, as opposed to a slight variation of what they are
>>already familiar with.
>>
> to be fair, there's also `apply` and not `pop --keep`.

I do not care all that much if that is fair, but I do not think it
is a meaningful comparison.  "stash apply" is merely exposing the
first half (the other half is "stash drop") of a two step operation
that is "stash pop".
