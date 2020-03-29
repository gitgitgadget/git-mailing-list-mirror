Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A9EC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 16:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A2C20733
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 16:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="onEUXTPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgC2Q1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:27:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51956 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgC2Q1c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 12:27:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5BBB6333C;
        Sun, 29 Mar 2020 12:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/5DBw1BD1dM4
        cLQgxAXl7Ke/MVM=; b=onEUXTPOOtMy+KgUyIj8Hsk5JUNaDsJftSUjaRtvl4zT
        Lk9XCwoyWmcveTRd5X5v4WL6mpuewXIz6OZApXbLzxa3zYEW9SnFDtlAPISG8MS8
        UaI5GX+MSDfCyrgbPpZVYUNIfOR53mnSSQvqZQJ1zn8SgX88TdQLZfPWyL2M7NA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=a6nXHA
        Syn1bEqp0gGIkIpjD7hsQ5U7riptj/fbAz3z4TddvYedyObl+jtiCYIf2/ZNJ8ob
        R6VmfTZJHPrVMrTeyOu3vou+iDwACOP/zFmBK9i7ydWa3JE3lhwlIl0L32/r6irO
        CDufVnpmUcdHZTLLcy9rgUeHspzuMBK62JZYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDC016333B;
        Sun, 29 Mar 2020 12:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49D866333A;
        Sun, 29 Mar 2020 12:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
References: <cover.1585486103.git.martin.agren@gmail.com>
Date:   Sun, 29 Mar 2020 09:27:29 -0700
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 29 Mar 2020 15:18:04 +0200")
Message-ID: <xmqqiminazym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F93041A-71DA-11EA-9CA0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> After this series, user-manual.conf still refers to older docbook-xsl
> versions. The proper fix there might be to actually be a bit more
> aggressive and drop that hunk, making the rendered docs prettier.
> There's some history there, including mentions of texinfo, which is
> outside my comfort zone. I've got work in progress there, but I'd rathe=
r
> submit that separately from these "expected no-op" patches.

It certainly is long overdue to write off these versions as too old
to matter.

Thanks.  Will queue.

