Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C770C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 18:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354918AbiEDS2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376874AbiEDS2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 14:28:23 -0400
Received: from pb-sasl-trial2.pobox.com (pb-sasl-trial2.pobox.com [64.147.108.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA03F18387
        for <git@vger.kernel.org>; Wed,  4 May 2022 10:58:40 -0700 (PDT)
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 692A72BB7E;
        Wed,  4 May 2022 13:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jO+5oaLsdK8N
        6uEIajTPAlYXCvQ=; b=ekL22Ui/A6fG8xmZc9MNAUS2BahJRgPapGpLERmOImT3
        0luXLIRJgbSsyZtwnjigF8ybvS2heE5nAbEfN2IHVXuyrT+uk4c6lSxMP39Ft3YZ
        HqTo59svhRV2OMNYle0ixL9OEI4L7boGmM8VE8sZzNiQo5bxDsfwsWxLGVeNrQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kvd9Pg
        5f7XsL1nPtnRvHIvEfVSohR7yritlod0hSgLnE9BNm4aKnanMYZaYurx3vmIktO2
        EIhP6XVTTbRlCX45PucOaIOPKTZyYL2l1dQ/tZ3+ktJyAabMv3jQ8oyTKRFzmD53
        yxsWSlzOqJHGPe9NKO4h3pX+ojKck/e/1OIQU=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 55FAC2BB7D;
        Wed,  4 May 2022 13:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B749711D388;
        Wed,  4 May 2022 13:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
References: <20220503132354.9567-1-worldhello.net@gmail.com>
Date:   Wed, 04 May 2022 10:58:37 -0700
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Tue, 3 May 2022 21:23:45 +0800")
Message-ID: <xmqqczgtmb76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3737240-CBD3-11EC-A76A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> =C3=86var and I started discussing this topic (incremental po/git.pot u=
pdate
> and new l10n workflow) on a GitHub issue[^1] a month ago. There are
> several improvements to the l10n workflow:

The vger archive seems to be missing [6/9].  For those who are
wondering from sidelines, it commits a removal of the po/git.pot
file from our tree and comes between [5/9] and [7/9].

I am guessing that the reason why it is placed there is to ensure
bisectability, but I didn't actually check it needs there to be
bisectable, or committing the removal at the end would suffice.

Anyway, this will be part of today's 'seen'.



