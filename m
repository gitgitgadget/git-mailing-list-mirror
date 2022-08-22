Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB34C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiHVSZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiHVSZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:25:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACAA13FAD
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:25:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71A321478D4;
        Mon, 22 Aug 2022 14:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qOXvBl1ktguQ
        tBENEIxglKhyomPaKCRJuYs3xXuRHnk=; b=R35PAuTZuAbrAJoWT48XnLVQ//8/
        zXVfhOTNACLOktO8O8ujdzshgA/iAeN9jj320Wt2nVRxM13nwCki0QUTdrGrE/Bk
        MqJuT1zpszWxF3V2ipR2YEIpxrBVnBno+5YKvWrHdtw6xPqpoe6BRfowSqZF7EAE
        2UI/I9D9+aYiTNA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 678B31478D2;
        Mon, 22 Aug 2022 14:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5DC91478D1;
        Mon, 22 Aug 2022 14:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        meta@public-inbox.org
Subject: Re: `git patch-id --stable' vs quoted-printable
References: <20220822022503.M873583@dcvr> <xmqqczcsgbvn.fsf@gitster.g>
        <4e3edfa1-9c04-7a63-30ee-65fe6f2de62f@web.de>
        <xmqqmtbwdzbj.fsf@gitster.g> <20220822170114.M247768@dcvr>
Date:   Mon, 22 Aug 2022 11:25:11 -0700
In-Reply-To: <20220822170114.M247768@dcvr> (Eric Wong's message of "Mon, 22
        Aug 2022 17:01:14 +0000")
Message-ID: <xmqqtu64cf08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3053F40-2247-11ED-A497-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I don't think postfix, SpamAssassin, or dovecot strip that..
> ...
> I would expect the blank context lines in the QP version to have
> "=3D20".  I sent this to test@public-inbox.org using
> `git send-email --transfer-encoding=3Dquoted-printable' and it
> confirms the blank context lines having "=3D20" which are missing
> in Ren=C3=A9's messages:
> https://try.public-inbox.org/test/20220822165736.23246-1-e@80x24.org/ra=
w

Yeah, that is a mystery.  Unlike format=3Dflawed, I think CTE-QP was
designed to be reversible without information loss.
