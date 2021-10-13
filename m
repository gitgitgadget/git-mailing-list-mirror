Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5753BC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2470D60E54
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhJMUZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:25:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58819 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhJMUZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:25:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B326155247;
        Wed, 13 Oct 2021 16:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ooMmbitA/3vEHCy/kyMI90vb+gO/el43SAChWS
        xilU8=; b=F9beGsnOuE+qTMBfw43dYW3Wlpj7JYQdbqWqn0UibHNDAz02fsg/sc
        7FKwM+6MdXU5Bm5+aigc7/4++frNxBVmyJJc/3Cip18gkKZTzbaKwu9zpxLqY9di
        uHJeGU7n58i7sJ2UUo9S/OVyC9PGSUVNBmKtTBEunNFqDNA1BiHSM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82D41155246;
        Wed, 13 Oct 2021 16:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6CBE155245;
        Wed, 13 Oct 2021 16:23:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] remote: use remote_state parameter internally
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <20211013193127.76537-1-chooglen@google.com>
        <20211013193127.76537-3-chooglen@google.com>
Date:   Wed, 13 Oct 2021 13:23:09 -0700
In-Reply-To: <20211013193127.76537-3-chooglen@google.com> (Glen Choo's message
        of "Wed, 13 Oct 2021 12:31:26 -0700")
Message-ID: <xmqqh7dkfzde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6280F086-2C63-11EC-AAAA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> In internal-facing functions, replace the_repository->remote_state with
> a struct remote_state parameter, but do not change external-facing
> functions.

OK.  Quite nice.

