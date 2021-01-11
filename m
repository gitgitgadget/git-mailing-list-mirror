Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6844C433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF5722D73
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbhALA0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:26:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61055 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403963AbhAKXQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 18:16:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21D39123E16;
        Mon, 11 Jan 2021 18:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCr9VHS84gAXXub8163NKPlKX+Y=; b=jrPJ7I
        lRim0v4tKIr/RnMf6j4VSmzgkSGNxXhcjF357ClsMSlEi+Mxe3e8ieQn45yO/Ixp
        PTd5GUAeYq7z6VsvwjGv8Cy7u0iyS0LeRYx3s4+xp3x0x2wEndwn7OBvaerliRXG
        WtJ3PZ1MkLf8dACBUwVST8PSEl26JiAdWn6J4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CtnX3KqrwjkWqTyUtNwFiJYKDDZS3XVc
        21q+yXgJ59pGWYG4ka6XD8Fk/CtlzZomd7xykssZQ09fh3pJqGZFmrJG+7khr++5
        KQzX8IGVGMaV38Vnb1kvhRdPihtr8+D1lK15bwa1CeP6VKagbcB6wxwRSOV9c5RL
        8xQCMBKUjt0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19CA0123E15;
        Mon, 11 Jan 2021 18:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 504CA123E14;
        Mon, 11 Jan 2021 18:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/5] fetch: extract writing to FETCH_HEAD
References: <cover.1610027375.git.ps@pks.im> <cover.1610362744.git.ps@pks.im>
        <61dc19a1cab5b03d07c6635496761108d089eb23.1610362744.git.ps@pks.im>
Date:   Mon, 11 Jan 2021 15:16:01 -0800
In-Reply-To: <61dc19a1cab5b03d07c6635496761108d089eb23.1610362744.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 11 Jan 2021 12:05:16 +0100")
Message-ID: <xmqqwnwj5aku.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F97195E2-5462-11EB-94E0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +	switch (fetch_head_status) {
> +		case FETCH_HEAD_NOT_FOR_MERGE:

In our codebase, "switch", "case" and "default:" all begin at the
same column (see the original this was taken from).

Thanks.
