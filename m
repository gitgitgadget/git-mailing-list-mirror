Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46C31F461
	for <e@80x24.org>; Mon, 13 May 2019 22:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfEMWq0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:46:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50423 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEMWq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:46:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E4636C977;
        Mon, 13 May 2019 18:46:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9N7Ni80WTEdn0qiqnI/qyA0EmlU=; b=FkxWn5
        6ZJ7rjL3iwvkcWZw9sXK7s6Tr6Y4caBTr8BRE59G5I4HG1IXcMXufeaJgic78i/V
        Pnr9S6u9V34Urw1mMeS79Dej/gnJH4LdT8HbDUTaRS6QPKnWTOyq7ld+f0v2+/dU
        NGyO8zVp0xeiulx/1XG7/vQBi1lRS6o5r8GBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lzBpY8DH6flsVe5faIp48B19B/c/hZ5w
        lWzNlDYAAY8H9+K0ogzCJfcht9A8vtS1MFt3s0mpjMTzsIK1bZdGQiebrrohgQeR
        yXrOJND4dKFRA2CPs5mQKUMuqRaP6OMYW4V7fIH2guTLBWzZ57lEcLOzqeW1KRqe
        +p1tVGU4kaI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2673B6C976;
        Mon, 13 May 2019 18:46:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 532D36C972;
        Mon, 13 May 2019 18:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: How to exchange rerere/redo resolutions?
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
        <871s17xk79.fsf@evledraar.gmail.com>
        <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
        <d139d79a-f35a-e00c-3790-104146b066c7@iee.org>
Date:   Tue, 14 May 2019 07:46:21 +0900
In-Reply-To: <d139d79a-f35a-e00c-3790-104146b066c7@iee.org> (Philip Oakley's
        message of "Mon, 13 May 2019 23:24:41 +0100")
Message-ID: <xmqqsgti9dmq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEEB9B94-75D0-11E9-BDCC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> Does the contrib/rerere-train.sh actually work?

Yes, but it predates many esoteric things like multiple worktrees.

