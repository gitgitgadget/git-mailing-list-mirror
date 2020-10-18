Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377BC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA6B2226B
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c2N3ejT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgJRURE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:17:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52607 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJRURE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 16:17:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4988FE02F5;
        Sun, 18 Oct 2020 16:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v/6DjBVO4hu3mynBrF86uYIriFI=; b=c2N3ej
        T5ytFYUAcc9z3ikL3yHHxDGcTUitoJSSUhE2Lhnn9V1HaZt5hb4bsc3yJy13bnxs
        OFmJSKr3jwC7zSv7W7xX+CyN4VKSO6okb3UR4ph1WP3M4yi4o3UU7M1N47lmdMgL
        f/BCW5a8npIJWIITVochG+osNO3EOv8bEVD5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P6AiC5npQLEvXZs0s9JOjqESc4trgW7P
        SZasOOQiH00ugqrkIUsKJ4SteftTSDg1vF+oGay6dlBgr6U8ijGk8pWAIx8i9oGE
        zVDFDbSYfR/wSRQ3civeFLjXegLaZJYC7Mdukvtk1BjPqEcde5OpcGPXRsIKv6OA
        /2ZFkjgRDlg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 419DCE02F4;
        Sun, 18 Oct 2020 16:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 840E1E02F2;
        Sun, 18 Oct 2020 16:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Daniel Santos <hello@brighterdan.com>,
        Emir =?utf-8?Q?Sar=C4=B1?= <bitigchi@me.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        pan93412 <pan93412@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [GIT PULL] l10n updates for 2.29.0 round 2
References: <20201018104201.20210-1-worldhello.net@gmail.com>
Date:   Sun, 18 Oct 2020 13:16:57 -0700
In-Reply-To: <20201018104201.20210-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 18 Oct 2020 06:42:01 -0400")
Message-ID: <xmqqft6b70hy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E08977CE-117E-11EB-8D98-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.29.0.

Thanks, will do.
