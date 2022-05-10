Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D990AC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiEJX00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiEJX0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:26:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289438BC0
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:26:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AACB18E0AF;
        Tue, 10 May 2022 19:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vmsFzLz1eQhRA8w38fSXViUCTqDS/X+Q+CZPFN
        m9NbQ=; b=I2Im3pLp/aLATsY5Ezl0cuO3B1ZOD/j1VC/iO/OgH2I7E8koKFiEou
        D4C5YUSIXDDjPRo9MexOg7DqTIdwycqhO7N3hKWiRW8NCqPqNeS4h61crchwtNC0
        i4ibO2Aznml+xdLvt0aeE2WOgG1mYd7Zq3mPysedpEXqEu63e95TU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8414018E0AE;
        Tue, 10 May 2022 19:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 233B318E0AC;
        Tue, 10 May 2022 19:25:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 3/3] t0034: add negative tests and allow git init to
 mostly work under sudo
References: <20220507163508.78459-1-carenas@gmail.com>
        <20220510174616.18629-1-carenas@gmail.com>
        <20220510174616.18629-4-carenas@gmail.com>
        <xmqqczgl56fi.fsf@gitster.g>
Date:   Tue, 10 May 2022 16:25:57 -0700
In-Reply-To: <xmqqczgl56fi.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        10 May 2022 16:11:45 -0700")
Message-ID: <xmqq4k1x55ru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C831892-D0B8-11EC-BA3E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK, so 
>
> 	root/ is owned by 'root',
> 	root/r is owned by the tester, and
> 	root/p is owned by 'root'.

One thing I forgot.  In these three patches, I didn't see anything
that required root/ to be owned by 'root'.  So perhaps we can lose
the "chown root root" in the earlier test.
