Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659B2C433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 00:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiEEAYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 20:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiEEAYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 20:24:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B114D9E5
        for <git@vger.kernel.org>; Wed,  4 May 2022 17:20:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 16so3660568lju.13
        for <git@vger.kernel.org>; Wed, 04 May 2022 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kPc5VWiHQIgTsAopw0ZtMiSu6twpvitMhEWRO7rCS4=;
        b=ppyQ1mcREdhuMvYkspfk3Q9V5wLM4ULwNYJMstRfL0/RpBbggIlr0+Vd8BOo2M1sH3
         KOKMJGExT3YveTDJC034pAiU9a8OGv6rRJoJsBjfDOwKjSuPLsxoKm+k6bJaVMnfAykZ
         yZlOqD/mJxQ29b3b2GYWJ0tSDWPObbz1S+4n2hYLJxIBxSUS4oIAdokHMJ7pHNDnL4Z8
         PyexvTsca5AH0o1VWFFX6aVdY0OSjBah86ewCJka/1r7U1aojIdDZ3vB0MrfU1tKQCGA
         +Xjkno6S9RhTO3pLMm4/WQlPfYFFsIkHGsmGKhUYyzzgUth5qAI+XuVY4qv/tCNPfva5
         U07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kPc5VWiHQIgTsAopw0ZtMiSu6twpvitMhEWRO7rCS4=;
        b=niGzBXwbNVZm2gkMJGjZs4e6S4b9oM+CDBC7ZfGuD31tWDbwQy/uu7Z6UJ7+hNmMCy
         jnCjZe3kG0x4G+WN9Y9/DiXVfScUEDH80uzBwnZi2kxjOxjV0DOzHxLacXs6gklTUYli
         /jLIbyN28keqEEwLnBkt8o0IEo0Ne30MJqpF/pnHTWs07nHUZ0rqfRLDNpI77A5nQXo5
         ux/tv2ks4t1dtYF/8cFI5MySABODHAKsKlzXSGjrEGv3ru2WC0kwB+mEI1RfFbWoPr31
         VcQO7lL7y8/qGY/ERMiTI5H0cLUQB0NZ5mh/PcfPYpZGXDVKTdmFpSDhbDaaviV5RMeM
         ofgQ==
X-Gm-Message-State: AOAM5323VQSCCAafdEob9GlGDclDBtKTQuf/LlsJCNn9NtQUCGD5x8m9
        kAEKZELgWa+ZRMUysJACsGsYwKNvZo+SEk9ndtk=
X-Google-Smtp-Source: ABdhPJyAuzMRvG5p8tbolEM6rRzYCqKzesv0ws+L52xWe6w2+Z7TqAxhJQpCv0uT350/yrOqJ1poMjAymbtOYpONlNQ=
X-Received: by 2002:a2e:b8c2:0:b0:250:61c6:8398 with SMTP id
 s2-20020a2eb8c2000000b0025061c68398mr7937331ljp.378.1651710025648; Wed, 04
 May 2022 17:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <xmqqtua5nz61.fsf@gitster.g> <YnKS1zIr0YAUJ6N4@acer>
In-Reply-To: <YnKS1zIr0YAUJ6N4@acer>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 5 May 2022 08:20:13 +0800
Message-ID: <CANYiYbFDm+aYE9avabnffcTNR4HT6rv77bQiWbAWSzzxeFxUxw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
To:     Daniel Santos <dacs.git@brilhante.top>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 11:03 PM Daniel Santos <dacs.git@brilhante.top> wrote:
>
> I haven't applied the patches and, for me, the prior workflow has no
> issues.
>
> Improving the po files in order to not have the 'diff noise' is
> something that I consider ok, but still, I also don't see problems
> with how it is now. So, it is the only thing that I consider an
> improvement, from what I have read.

A new git clone of git.git is about 150MB in size, while the "po/"
history occupies 28MB. By removing the location line numbers,
the size can be reduced from 28MB to 6MB.

See: https://lore.kernel.org/git/20220504124121.12683-1-worldhello.net@gmail.com/

--
Jiang Xin
