Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164E2C0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHEXFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 19:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEXFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 19:05:02 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94621735
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 16:05:01 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A44C194775;
        Sat,  5 Aug 2023 19:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=LLh5sSCMhxWb71QkVXJfhdT9b
        3GeoFp01Xm6tKpFkes=; b=EJlfB5XRTgsSJfwcWug9jgczqAwyaOR1Mx4OmqbJF
        ujNYoBr7OsF1MabnLUn97sKmCvK60HdHBjrIeTy8DG26RbMFqo5cf9HlTHoYRqIQ
        FEpVTFDe6q0rK59RIuK4yyPBjqxhk1AlJRootTWaJWnc0w2TysDQ6AqHsyAp8x2j
        FU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92416194774;
        Sat,  5 Aug 2023 19:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 083E2194773;
        Sat,  5 Aug 2023 19:04:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 8/8] parse-options: simplify usage_padding()
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
        <xmqq351hz5xp.fsf@gitster.g>
        <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
        <xmqq4jlxuiuu.fsf@gitster.g>
        <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
        <a3a93950-9a0c-d68c-a32a-06c83819d72b@web.de>
Date:   Sat, 05 Aug 2023 16:04:56 -0700
Message-ID: <xmqqo7jljdk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F8BDCF6-33E4-11EE-A35A-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> c512643e67 (short help: allow a gap smaller than USAGE_GAP, 2023-07-18)
> effectively did away with the two-space gap between options and their
> description; one space is enough now.

My intention was "we strongly prefer two or more, but on a rare
occasion where the leading strong is long and can afford to give us
only one, we take it instead of breaking the line", but stepping
back and thinking about it again, you are absolutely right.  I just
shrunk the minimum gap from 2 to 1.
