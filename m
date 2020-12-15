Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,BODY_EMPTY,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69918C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A51D22CBB
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLOVIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:08:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60892 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgLOVIF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:08:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 261479D4B4;
        Tue, 15 Dec 2020 16:07:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uoq1oCgLlTqpdDX/iUbLy7J1Wic=; b=PLDGnv
        jQf7VBPPPS9g0k9nuZmXKRSQ3tbmxT54tNwpeyOmuL2K5iaHYCHEDJibyuLjVedf
        zZSVLrgHZ6qn3yGH3o3tvdrDdZsZSin2ZkAtQOyvla+fA7g06g31MhRv/zWI1aJK
        B/6iMiQU8+1WAOqtZpcruOgW/S5XgU5Z70bTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZAVbGdhWkjuExhW3pquYi9nLBhyg92vJ
        eedPCE+aZxHaaNsJuaziur76X4WunrJUHLffo6XkOSR8MuemT8g4QtgDht7IIRpb
        jjTeb4fy5hvm7fAc9re6P7uYyXa0HoBdxd9kWXySBuclRV8TLmJNRVbZWd/Ujq4/
        1pnxaaLzyRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AAD49D4B3;
        Tue, 15 Dec 2020 16:07:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D46C9D4AF;
        Tue, 15 Dec 2020 16:07:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
        <xmqqeejraiw7.fsf@gitster.c.googlers.com>
        <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
        <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>
Date:   Tue, 15 Dec 2020 13:07:21 -0800
In-Reply-To: <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 15 Dec 2020 08:21:37 -0800")
Message-ID: <xmqq4kkm93sm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 8653CD9A-3F19-11EB-8CB0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

