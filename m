Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7573AC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B6C20643
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F14j+zDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgERUWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:22:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58900 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgERUWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:22:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1BFD4B5AE;
        Mon, 18 May 2020 16:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K8Pn2WCe9Bdx
        qnXl54PVcqA9Fkg=; b=F14j+zDIh/Vj5465u2sz9LS+MK3SmspONhPwW3QP9jnf
        0BoV9aINc0Ltnr0qz/mlReXDhfO7BkKd8TAoQcwvQd9FcbxMyxBtm1LGr7UCjVpl
        v1GUjqBUqcQO33XCA9QST/qGSDZfl9jXKrh+PeTGdoQzVAiK1wQRquVCOleQAZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ioDhcn
        cqRHMKQSfTBzBZlL8O/5TJlRFy0DN9bxoyIHhY+TKxyVHwohGulj3YlJZwXCZ4p3
        85c4SlmehrEMFEWdjamQu0YPmSbfWsgd/RR6AvR9s6+m/GKOiJrEk87nBBGhfjEl
        141RgLU39CglwgWuaDzWB/2qYe7HuvOQpWkUs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D79144B5AD;
        Mon, 18 May 2020 16:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6860D4B5AC;
        Mon, 18 May 2020 16:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH 7/7] rev-list-options.txt
References: <cover.1589739920.git.martin.agren@gmail.com>
        <acfca5465e822eaa6f0ddf85a01f7855d3dfb7d1.1589739920.git.martin.agren@gmail.com>
        <34870e5f-8e61-4af8-1050-43bfbe30d8f9@gmail.com>
        <CAN0heSo_Y2Esp8X_amPXKaGaOVbP5rnJAyXiuUuW5BFSmwzhwA@mail.gmail.com>
Date:   Mon, 18 May 2020 13:22:15 -0700
In-Reply-To: <CAN0heSo_Y2Esp8X_amPXKaGaOVbP5rnJAyXiuUuW5BFSmwzhwA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 18 May 2020 20:37:14
 +0200")
Message-ID: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4436C1DA-9945-11EA-A2FC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> I currently have the commit message below for my patch plus your fixup.
> ...

I've queued 1, 3, 4, 5, and 6 in the meantime.  Todd gave us a
replacement for 2, which I also took.

Thanks.
