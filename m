Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6913C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA5861C4B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 17:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhGFR5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54737 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhGFR5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 13:57:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 865C6D0DDA;
        Tue,  6 Jul 2021 13:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sg6Af7OhTvWVuooDMxI30CGWKqw72Ailytcqf7
        0BFZI=; b=FsOEEermqm0ycOgxrh4Utj9fGfcnQQ2fDtYoxFlwiOhS8a9FaiGDXp
        H7ioS35XlsxCKB04ZFV3+hxRXpTJLQL7RxrxkClpmaWnIcJY2UPXQuw7zcnhTfWC
        wKuJLoJzMzmLq/3+v0fNI3xwpYy/vlzV9Ag+40GCU6cQM9OaZPrgk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78FDAD0DD7;
        Tue,  6 Jul 2021 13:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDA0DD0DD6;
        Tue,  6 Jul 2021 13:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys
 using ssh-keygen
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
        <xmqqzguzlc03.fsf@gitster.g>
        <fffd8c26-f3a7-b074-f4ba-e8552ca1d7cc@gigacodes.de>
Date:   Tue, 06 Jul 2021 10:55:10 -0700
In-Reply-To: <fffd8c26-f3a7-b074-f4ba-e8552ca1d7cc@gigacodes.de> (Fabian
        Stelzer's message of "Tue, 6 Jul 2021 17:45:41 +0200")
Message-ID: <xmqq5yxnl43l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ED097B8-DE83-11EB-89D8-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>> One thing that is unclear is how the 'allowed-signers' is expected
>> to be maintained in the larger picture.  Who decides which keys
>> ...
>> Thanks for working on it.
> Glad to hear that :)

Thanks for explaining your thoughts (omitted).  When I say "this is
unclear" in my response to a patch, I expect that unclear-ness will
be shared by other readers of the code, the doc and/or the log
message, so please make sure an updated patch will reduce the need
to ask the same question by future readers.

> I tried to keep the style with the existing code but the IDE sometimes
> has its own idea.

Documentation/CodingGuidelines and Documentation/SubmittingPatches
would hopefully help (if not, please ask and/or suggest clarification
on these documents).

Thanks.
