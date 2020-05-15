Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C0C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFAE207C4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QFr4pmv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgEOO7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 10:59:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53107 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgEOO67 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 10:58:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC80FD4DB0;
        Fri, 15 May 2020 10:58:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yRaF9/532Xb+X9RSpgWORqzaglI=; b=QFr4pm
        v78v8duugOorhy0Tve5mPCavWoT9AU4EAKBfPCjjAxFd6Z4DMn+dObktfq/SATYu
        4Jh6fQWe/zGezdZo7Mc3yF8UxrsYlY2ipaq00uo0jejsDHhvUk5cnzPsp4313maQ
        wX37xfpw31gS24k3i+JFEzL8QqfgHR6myHsZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v+XsgPJETKIIr3lTd2+AUUtTgueCAbzH
        WqHT0uKq4NBtr+R2RIscg3EKm41DBM4ZtoBspLd3YLhMfJj+LvnS5XdJaorb6UF7
        /SP0lebnrwmaw7FfuZ7rQJeIqT6NzpCGA3QvVsjE9PBYb8mX99Szc7Js+0aWH87E
        PXgvQuLc0Es=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3314D4DAE;
        Fri, 15 May 2020 10:58:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F656D4DAB;
        Fri, 15 May 2020 10:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.27.0 round #1
References: <20200515013328.67388-1-zhiyou.jx@alibaba-inc.com>
Date:   Fri, 15 May 2020 07:58:54 -0700
In-Reply-To: <20200515013328.67388-1-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Fri, 15 May 2020 09:33:28 +0800")
Message-ID: <xmqqd075nt1t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99753324-96BC-11EA-BA9E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <worldhello.net@gmail.com>
>
> Hi,
>
> Git v2.27.0-rc0 has been released, and it's time to start new round of git l10n.
> This time there are 72 updated messages need to be translated since last update:
>
>
>     l10n: git.pot: v2.27.0 round 1 (72 new, 37 removed)
>     
>     Generate po/git.pot from v2.27.0-rc0 for git v2.27.0 l10n round 1.
>     
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in "po/README" file.

Thanks.
