Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB6FC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiCHANO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiCHANN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:13:13 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD64537BF4
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:11:51 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B9F4193969;
        Mon,  7 Mar 2022 19:11:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zPHy4f/NVzaiLcVJLcwQcxfQSvIsQ67kgJ2yMs
        j0f3Q=; b=imTiQeRL4VQ1x2CcPw/PRrU2P4+HR0/f7O/w4807R5TIF6XLFcfPwY
        9hGYoW/D2TzyxtKrI++t9LfAELsOIwSYsgUFpGJQZPCXAREKW72yZS/KjftzWSaC
        3keRcZpsPIIgXZDXSuJEDchiZjCed999oOY+ZpEgd4t2qEm3D17Fs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81EA0193968;
        Mon,  7 Mar 2022 19:11:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB937193967;
        Mon,  7 Mar 2022 19:11:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 09/10] fetch: fetch unpopulated, changed submodules
References: <20220224100842.95827-1-chooglen@google.com>
        <20220304005757.70107-1-chooglen@google.com>
        <20220304005757.70107-10-chooglen@google.com>
        <xmqqsfry4f3z.fsf@gitster.g>
        <kl6l7d99494p.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqk0d9w91r.fsf@gitster.g>
        <kl6ly21p2q00.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 07 Mar 2022 16:11:36 -0800
In-Reply-To: <kl6ly21p2q00.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 04 Mar 2022 16:37:51 -0800")
Message-ID: <xmqqzgm1pakn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 526BFC94-9E74-11EC-83C4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> Or am I oversimplifying the problem?
>
> I don't think you are oversimplifying. Now that I look at it again, it
> really _does_ seem trivial. Doing this refactor saves me the headache of
> explaining why we need a single <.super_oid, .path> tuple, and saves
> readers the headache of figuring out if I'm right.
>
> I'll try it and see if it really makes things simpler or not.

Thanks.
