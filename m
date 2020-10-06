Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9104C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 06:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52EA52065D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 06:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SRy5Ye8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJFGIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 02:08:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63595 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgJFGIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 02:08:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14A8B7EAEC;
        Tue,  6 Oct 2020 02:08:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JosSPNpjBWcb
        KqfS+M6QynL4m+Y=; b=SRy5Ye8EoS2+BrD0ctceAn+/2pUuV+qCkn6l5/RRuKo1
        7HpXNlsvzUmrCxtnp0gUMLeSPANB/xFQDWhUsldTY1Nh3iV7sSxG7Ku3BKmnMnWq
        8TMYPxnYG1yOujKWBxaDiIEcXPdoyLzIg9RMAaTPFWr6zYi7rWI0WMv4HUzfkLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kHo57j
        rnA8Tk65fVXe5JMGpHEHwz15lHqH9C5VaB0iu/PPHXKR4J1Rp8LjlXGYFxpBpMdQ
        RVGG+z/lSaDTPfNfw7hFSbIKcwGZdqhAqPHeR2vpuKrSYnUX7Jj5WnFjz5gUga0m
        0jlym+OxLhjuwIZfkuhPa89Ur7BWiTeijRbBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D4157EAEA;
        Tue,  6 Oct 2020 02:08:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 885FB7EAE8;
        Tue,  6 Oct 2020 02:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
        <CAN0heSrKgNSHKDL07-BWrbF9n6fyWUZVDykdHPCD6CfwgV8QNA@mail.gmail.com>
Date:   Mon, 05 Oct 2020 23:08:30 -0700
In-Reply-To: <CAN0heSrKgNSHKDL07-BWrbF9n6fyWUZVDykdHPCD6CfwgV8QNA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 6 Oct 2020 05:57:02
 +0200")
Message-ID: <xmqqy2kj6g4h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F0A4E96-079A-11EB-8A2E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Minor comments follow.
> ...
> s/used // (without 'g' flag!)


Thanks.
