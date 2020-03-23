Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FE3C43331
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BA220663
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FqPB0bWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgCWUSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:18:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64336 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUSR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:18:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9047B93FF;
        Mon, 23 Mar 2020 16:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t9W6kpaiuATqYIPNueGbSXSMfK4=; b=FqPB0b
        WevCK/vli+e19cn0zXUXq+LMfUywciS8nM3o0fSpv/sI6c+z9P5+UTtGiz/Rb/VY
        dltzf1TM4VbO8pebcF8rM7IQ5BYAbss0hE2gAIFODKTSSSxN7GjDnHnbGrqX3lc+
        UDC0gaB96b3CBFvZ+exC5PYdDIIdNQ5AXVci8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZEomJQi7NTCXB8BdJiQME6QOWg7Jzb82
        3fbmCjHvy6eT49EcA459F+5Y7ahXfcOB6vFeH8oM7YxHHHbSjM38MeQo4RkI5oLe
        gElsrdJwuldafAhPYhZSdsIC07bHojWjmuK7rWeVyScoS+o30EX8Uut6ZvQ/96I9
        /mjHSngkC4o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1360B93FE;
        Mon, 23 Mar 2020 16:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0EF9AB93FB;
        Mon, 23 Mar 2020 16:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, j6t@kdbg.org,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3] test-lib: allow short options to be bundled
References: <7a6a8197dcd58e8690892d03cb904dd1eec5d7c1.1584818457.git.matheus.bernardino@usp.br>
        <cec4bbcc4270914a729a2c65d9c0efc4a45742ce.1584854619.git.matheus.bernardino@usp.br>
Date:   Mon, 23 Mar 2020 13:18:11 -0700
In-Reply-To: <cec4bbcc4270914a729a2c65d9c0efc4a45742ce.1584854619.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Sun, 22 Mar 2020 12:58:57 -0300")
Message-ID: <xmqqv9mu4ygs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C05E17E-6D43-11EA-81C5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>
> Changes since v2:

Queued.  Thanks.
