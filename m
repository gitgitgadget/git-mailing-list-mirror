Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4602C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiEWSql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbiEWSqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:46:23 -0400
Received: from pb-sasl-trial21.pobox.com (pb-sasl-trial21.pobox.com [173.228.157.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8F013324D
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:29:39 -0700 (PDT)
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id B396729384;
        Mon, 23 May 2022 14:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yqF+e8phQM35/z2pUleWKWxfOOM=; b=PUufr2
        wuk/UOObf90lR+RsbrS+aLrbxiQsho4kujNPfUi0+zxcLAIzzmA1k5FxI1kHTzV/
        qNTgCHwHebD/M8GkqPNMyAYnqrVZ+/foNHoeiPG4dkPlhVy2dBaEP/De8rbQYbOw
        quofU21A5sfUIov1AZS5iEYA471Fs6UkU2qEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z2Q2EOQ/cZGidGOwMuyhYaH6YrPKYEOz
        vKfomZnIJLyfHUPaJGvc8/v0A3tld38prUKgPArsSylYRIWH9KUgiV8/6sYB2oys
        i5UL49kTqvEf4jo37cgjE//WCb8rLSsKr7qTm5TLk8MnJqElgPVo27QWn5Bu74hg
        vJC+RCC8s/I=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id A5F9429381;
        Mon, 23 May 2022 14:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3CA2018265A;
        Mon, 23 May 2022 14:19:37 -0400 (EDT)
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
Subject: Re: [PATCH v4 0/9] Incremental po/git.pot update and new l10n workflow
References: <20220523012531.4505-1-worldhello.net@gmail.com>
        <20220523152128.26380-1-worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 11:19:36 -0700
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 23 May 2022 23:21:19 +0800")
Message-ID: <xmqqee0kru13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E76BF15A-DAC4-11EC-B111-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Changes since v3:
>
> 1. Remove Junio's s-o-b introduced in v3.
> 2. Reword patch 1/9, 2/9 and 3/9.
> 3. Patch 6/9: should remove "po/git.pot" in "clean" instead of "distclean".

As 5/9 did not reach the list, just like all the previous rounds
missed, I'd squash an equivalent (i.e. removal of po/git.pot) into
6/9 while queuing.

> 4. Patch 8/9: forget to remove "po/git-core.pot".

Will repace.  Thanks.
