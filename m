Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390BDC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386207AbiEEWNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 18:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386206AbiEEWNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 18:13:09 -0400
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 15:09:12 PDT
Received: from forward501p.mail.yandex.net (forward501p.mail.yandex.net [77.88.28.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72B5DE4A
        for <git@vger.kernel.org>; Thu,  5 May 2022 15:09:12 -0700 (PDT)
Received: from vla1-0c91d72e5963.qloud-c.yandex.net (vla1-0c91d72e5963.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3a21:0:640:c91:d72e])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 5977B62134DA;
        Fri,  6 May 2022 01:01:06 +0300 (MSK)
Received: from vla5-47b3f4751bc4.qloud-c.yandex.net (vla5-47b3f4751bc4.qloud-c.yandex.net [2a02:6b8:c18:3508:0:640:47b3:f475])
        by vla1-0c91d72e5963.qloud-c.yandex.net (mxback/Yandex) with ESMTP id fX8Lzvpwcv-14faoW8L;
        Fri, 06 May 2022 01:01:06 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brilhante.top; s=mail; t=1651788066;
        bh=7cZmUc5ByrQuHKaoRXwjCeumZSv0gdoXggiarJCo/E8=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=JMkTIyMfTjSSWe1amNmEkCJNvRA+tp/ckdv17APLtGmWqAev+b/mfFOaAP4hS8KVL
         mCXJWGDxGpWhcEqzqY9QIY4owAdlX2Kzwz7VbOrpaMPrnAAsLxmg4YH01SYXfvmp0+
         OqgWkH16AWzohsu2rShD9OSbPhtkHFlejElY4X/s=
Authentication-Results: vla1-0c91d72e5963.qloud-c.yandex.net; dkim=pass header.i=@brilhante.top
Received: by vla5-47b3f4751bc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id hppNr1etv2-13Mi903T;
        Fri, 06 May 2022 01:01:03 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Thu, 5 May 2022 23:00:10 +0100
From:   Daniel Santos <dacs.git@brilhante.top>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?B?RMOtYXo=?= <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
Message-ID: <YnRI6u+dV5GNHoD9@acer>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <xmqqtua5nz61.fsf@gitster.g>
 <YnKS1zIr0YAUJ6N4@acer>
 <CANYiYbFDm+aYE9avabnffcTNR4HT6rv77bQiWbAWSzzxeFxUxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYiYbFDm+aYE9avabnffcTNR4HT6rv77bQiWbAWSzzxeFxUxw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 05, 2022 at 08:20:13AM +0800, Jiang Xin wrote:
> 
> A new git clone of git.git is about 150MB in size, while the "po/"
> history occupies 28MB. By removing the location line numbers,
> the size can be reduced from 28MB to 6MB.
> 
> See: https://lore.kernel.org/git/20220504124121.12683-1-worldhello.net@gmail.com/

That is an improvement of size only for few people. On GNU/Linux
install of git by most users is done through packages, and most git
users of other OS, also will not receive this improvement.

Have you considered how the removal of these lines from the po files
will affect the quality of the translation work?

For new translator, not having these lines might make them less prone
to understand po files usage in C?
And probably make them contribute less to i18n C code?

Has these implementation upgrade better benefits than counter effects?

It is worth discussing this.

Also, I don't believe Github issue is the proper way to discuss about
this in the beginning. It cannot be expected to make everyone on board
with this modification of workflowm being discussed on a web service
website obscure issue, that needs login. We have a mailing list that
is to be used for this purpose.

I feel less part of this community, with important issues happening on
Github issues.
