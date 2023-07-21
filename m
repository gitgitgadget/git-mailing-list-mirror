Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F2DEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGUUOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGUUOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 16:14:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F60E272C
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 13:14:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27E5E30102;
        Fri, 21 Jul 2023 16:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8PFG7LiLhbVen/Y7NqK6yrOgm00SXbVIlhrgLe
        0ky20=; b=hG5rvcyT0Z685Xeir851BN4xEdzAcCcF+li2/hFVCD+ZCN8Gksbim1
        vaK2+P/RKjMDijcGGGol1S4G8nHqeke3Jp3Hc7F3UndIrnXh0ss/ZYHjGrNvDXR/
        4gxXhNJxJz0e205ihvMegjg5wUDT9GaQ0I1opv1y4CYZH+3ZJnqs0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20A9730101;
        Fri, 21 Jul 2023 16:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EF9D300FE;
        Fri, 21 Jul 2023 16:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
        <xmqq351hz5xp.fsf@gitster.g>
        <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
        <xmqq4jlxuiuu.fsf@gitster.g>
Date:   Fri, 21 Jul 2023 13:14:43 -0700
In-Reply-To: <xmqq4jlxuiuu.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        21 Jul 2023 13:09:45 -0700")
Message-ID: <xmqqzg3pt424.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BB2F768-2803-11EE-B593-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This is a good starting point, but we should at least exempt
> OPT_BOOL from this exercise, I would think, because ...

No, no no, that was nonsense.  The literal "yes" fooled me.
There is no need to special-case OPT_BOOL at all.

Sorry for the noise.
