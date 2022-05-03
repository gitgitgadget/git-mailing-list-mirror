Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D3C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 14:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiECORW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiECORV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 10:17:21 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 07:13:48 PDT
Received: from hekla.abc.se (hekla.abc.se [158.174.61.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BC0917E1D
        for <git@vger.kernel.org>; Tue,  3 May 2022 07:13:48 -0700 (PDT)
Received: from orm.abc.se (orm.abc.se [158.174.61.226])
        by hekla.abc.se (OpenSMTPD) with ESMTPS id 8b7f33aa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 3 May 2022 16:07:07 +0200 (CEST)
Date:   Tue, 3 May 2022 15:07:06 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Git List <git@vger.kernel.org>
cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?ISO-8859-15?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?ISO-8859-15?Q?Christopher_D=EDaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?ISO-8859-15?Q?Jean-No=EBl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>,
        =?VISCII?Q?Tr=A5n_Ng=F7c_Qu=E2n?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n
 workflow
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
Message-ID: <cb74f3b-c2e9-947f-8f89-f51e79b17825@softwolves.pp.se>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
User-Agent: Alpine 2.25 (BSO 592 2021-09-18)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2022, Jiang Xin wrote:

> Ævar and I started discussing this topic (incremental po/git.pot update
> and new l10n workflow) on a GitHub issue[^1] a month ago. There are
> several improvements to the l10n workflow:

I do agree that checking in git.pot does create a lot of noise, but ther are
other ways of fixing that than deleting the file completely. I am also
translating for dpkg, and there they run "xgettext --add-location=file" to
remove the line numbers from the POT and PO files (requires GNU gettext
0.19; they also use "po4a --porefs=noline" for manual page translations, but
we do not have translation for manual pages for Git, yet). This reduces diff
noise considerably.

I have been doing updates semi-off-line from my laptop for the last few
months, without a proper build environment, and having the history for the
POT file available for diffing has been useful.

> * L10n contributors can start translations at any time, even before the
>  l10n announcing l10n window open. We must have a new l10n workflow,
>  see patch 9/9.

You can always re-generate the POT file locally and not commit it, to update
the PO files. That has not been a problem.

-- 
\\// Peter - http://www.softwolves.pp.se/
