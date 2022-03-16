Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB329C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbiCPUWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiCPUWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:22:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9C53F8B1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:21:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AAF1179665;
        Wed, 16 Mar 2022 16:21:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NHK+PaF6zIat2f5TKRcZHyShwGXvbj3cfkRWnq
        4fILw=; b=bENALEqMzySf4pdQn9t46smxk5SDN3r35uty5p/UbrL2u8vHGBSDmJ
        bSM4dpLtMRUkPB+3M/DlDqcZijtEAw2ivxkRqtb0r7tMDkZk3qNi7Rz1lLtC7OAk
        iPKtnV+4fCfBwVyRmElCPwe9hvwb8X/NgCRoyDkzPPJpxn+FwtBV4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03F43179664;
        Wed, 16 Mar 2022 16:21:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD43F179663;
        Wed, 16 Mar 2022 16:21:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/3] Fix use of 'cache_bottom' in sparse index
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 13:21:26 -0700
In-Reply-To: <pull.1179.git.1647461522.gitgitgadget@gmail.com> (Victoria Dye
        via GitGitGadget's message of "Wed, 16 Mar 2022 20:11:59 +0000")
Message-ID: <xmqq5yodlkc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8B42286-A566-11EC-924A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...
> To fix this, the 'cache_bottom' advancement is reinstated in
> 'mark_ce_used(...)', and instead it is disabled in 'unpack_callback(...)' if
> the tree in question is a sparse directory. This corrects both the
> non-"cache diff" cases and the 'unpack_index_entry(...)' cases while
> preventing the double-advancement 17a1bb570b originally intended to avoid
> (patch [2/3]).

;-).
