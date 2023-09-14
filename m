Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBD1EE0213
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 03:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjINDM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjINDM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 23:12:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD9D1BD4
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 20:12:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBAE01EE18;
        Wed, 13 Sep 2023 23:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=HePKCGU05Yh/KVKrcLtFxpRqy0WeT6jMRVi5Nn
        UaC0g=; b=eeufMk8MIyyCGvCawbjAD58VmYHm+mAtDOXH/i8dzQDWhxrMeQIKGf
        sMgNq5CdkE98gzL/RKL6iw9BvbWrcwAVbbACbUr072fgSr7ods2iJcqE+utAAS8s
        +gx7MOkI24ohAzVHFpUchCwDZCBZ1QWJwUidO/5sY+1AfmO688o+k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3FC71EE17;
        Wed, 13 Sep 2023 23:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7110F1EE16;
        Wed, 13 Sep 2023 23:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/6] trailer: teach find_patch_start about --no-divider
In-Reply-To: <owly34zhlcoa.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Wed, 13 Sep 2023 19:19:01 -0700")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <f5f507c4c6c4514af7dca35e307ca68e72435afb.1694240177.git.gitgitgadget@gmail.com>
        <xmqqv8cgvd02.fsf@gitster.g> <owly34zhlcoa.fsf@fine.c.googlers.com>
Date:   Wed, 13 Sep 2023 20:12:46 -0700
Message-ID: <xmqq5y4dla6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 951FA048-52AC-11EE-BB30-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> The real purpose of this function is to find the end of the log
>> message, isn't it?
>
> Indeed.
> ...
> Right! So a better name might be something like
> "find_trailer_search_boundary" with a comment like

Or "find_end_of_log_message()", which we agreed to be the real
purpose of this function ;-)
