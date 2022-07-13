Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D38C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 16:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiGMQ34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiGMQ3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 12:29:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69C20F44
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 09:29:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87F031B4A66;
        Wed, 13 Jul 2022 12:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XtvwKNZiAw0zmGx/MCn6hkSdxYv1YChg4vLScT
        i7iBM=; b=VBWB3YBj/wdYzBqrQmC8IF9df66h73pzP5bEDLEXeeg7SjwgRzuP7o
        B6KlO1VQnEddMozbuDJsHQm69PDPRPu8SLEcXPLVsO2UAQaHk+xmI3gpkYVxMwLa
        d0foAUX4lkqmBZER8KAOrkwiAEA8DYSck8mQ4Dbsxao4nfxm3hnY4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 809DE1B4A65;
        Wed, 13 Jul 2022 12:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32F261B4A64;
        Wed, 13 Jul 2022 12:29:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jul
 2022, #03; Mon, 11))
References: <xmqqo7xufee7.fsf@gitster.g>
        <kl6lpmia55ys.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 13 Jul 2022 09:29:49 -0700
In-Reply-To: <kl6lpmia55ys.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 12 Jul 2022 15:19:55 -0700")
Message-ID: <xmqq8roxdlhe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03B53304-02C9-11ED-AC7F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I also noted your distaste for the `discovery.*` namespace (fair
> enough). To avoid a reroll-of-the-reroll, I was hoping that we could
> agree on something on-list (thread here [1]) before I send out the next
> version.

I found your idea of adding this new one in the safe.* hierarchy
quite reasonable.  "safe.discoveredBareRepository = yes / no" may be
quote a mouthful, but I do not think I can think of anything better.
