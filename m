Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50CBC2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1C2072A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HNw9/2mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDFXEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:04:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58255 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgDFXEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 19:04:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7B354E6E4;
        Mon,  6 Apr 2020 19:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nIi52IbW/hqsekbqXhwVFsnTJ88=; b=HNw9/2
        mqkphX4+roa+W+oEMmEDmMxNrYUC1rZTLazUQTJdtkWHmanFfW3chzln49BoZa+k
        DbuDyNujWO69Ylkq5OjORp3H0NuCHIUfmZcFZxI6nA2DVTpzGe6E63rCUPVjfTUP
        eFl97KXfsAuqXCaPl2LzL20QA0sgwNCXUlQZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k0lPKdqwz6gZaeDTtCbIZa8HNUmfqbzk
        i3l+7aAh3D9TF3WwPZlAKO9Su5+4oJfXOnhlVsw6TEs3jRxJV65DIYtMg8DfqlI5
        nYggpqGlmKKsaEujwbCFrZHBGE6mWiZxHQddPQKhzsNXJ7PUM8bh9lvKvzCfBJ+/
        FoD/m0PXne4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFB5B4E6E3;
        Mon,  6 Apr 2020 19:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DCA74E6E2;
        Mon,  6 Apr 2020 19:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v12 1/5] help: move list_config_help to builtin/help
References: <20200406224526.256074-1-emilyshaffer@google.com>
        <20200406224526.256074-2-emilyshaffer@google.com>
Date:   Mon, 06 Apr 2020 16:04:36 -0700
In-Reply-To: <20200406224526.256074-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 6 Apr 2020 15:45:22 -0700")
Message-ID: <xmqqimicusfv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCE368F2-785A-11EA-BA38-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Starting in 3ac68a93fd2, help.o began to depend on builtin/branch.o,
> builtin/clean.o, and builtin/config.o. This meant that help.o was
> unusable outside of the context of the main Git executable.

Quite straight-forward.  Thanks for the clean-up.
