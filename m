Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151F81F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeKLWiN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:38:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40283 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeKLWiN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:38:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so14638wrt.7
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 04:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OiDIajLiXe9tLZynkaRBCpTUaVPRccGomUoLv9eArP0=;
        b=HOGVeOo0NDfhUPhtcVSqisXyp1v32PyP2WmfgoF6LXFQuBl83WGNxm9bSIUeRe88mX
         anpofPrTdw2m2vKaNBuE8I2WlLJ2Wkf2WHOHFKtnTd0cQ1k03DBeLdhbWd4BYN4WAWbd
         KR1rRh1BtmPf6XFPL0WiLqrazPUvG/coKIHJismqyWxCUE+bHVp/Tl47uJu3k9GCpUJX
         5YkP5SFhuc/mhtVR7fgRymfxg7Xrz1Y8k7UJ2XaNPWrE/ZfJYivepBICJWvcPzbsCCk3
         h1+YRP6Z9h4sunpkDJkCQyAuhl3c3OW7m9HJknv5V2wi6x7gSxai3NuyEVhn84Avi/6i
         g2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OiDIajLiXe9tLZynkaRBCpTUaVPRccGomUoLv9eArP0=;
        b=ZDuFIYToDP6wK+TymIyQ7sokqWuNWG/ZHB0Nqg22gQiW9GG1iotz+ncjYDMwaV2TtO
         uDhj2tk8VSAKiBrLIDt5EvPRaN9hXrrN18bY+v1mG4dMv7+GN/CS5ivHM6Qu7sEtb+Rn
         3EuGAOeJYMm8xLM+F806oIsfbR4lOoHpCR4s7yBvSx2u0tM4w0CUskP7/d/csR/2ZNLv
         xOMithy0snQ0Gr3jejzzhbgHhvIzprVsWrMK8Ik6xew1FS/o0zry1YT/qPaTkf8gq/7Y
         RwgGnKiX6dBtM4dxAeHYFIvILTcQbWlSyyPlTgRYgsNkYJ5DxTvgFSuelsOvHHYg8MHK
         /BHw==
X-Gm-Message-State: AGRZ1gIScJSNHCxsA/jKCqBSyuiMOLNOP44IMRAV6ls1DDy/zwBMnmJj
        N+QpOZYN6Rn9FqAdEuY/Zq8=
X-Google-Smtp-Source: AJdET5fr8f8xeD2W0NIetRT8Pg87Sr49JOupgJUguBOKYUXsfYcSf17K2GH9kiugnyI7spw7QK9UnQ==
X-Received: by 2002:a5d:558a:: with SMTP id i10-v6mr844735wrv.38.1542026703819;
        Mon, 12 Nov 2018 04:45:03 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id t187-v6sm7421134wmt.45.2018.11.12.04.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 04:45:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <875zxa6xzp.fsf@evledraar.gmail.com>
        <20181111095254.30473-1-pclouds@gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
        <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv>
        <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
        <87o9au39s7.fsf@evledraar.gmail.com>
        <xmqqk1li1thy.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqk1li1thy.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 12 Nov 2018 13:45:01 +0100
Message-ID: <87in1231o2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> What I'd add to your list is:
>>
>> * Some projects (I've seen this in the wild) add e.g. *.mp3 or whatever
>>   else usually doesn't belong in the repo as a "soft ignore". This is
>>   something we've never recommended, but have implicitly supported since
>>   the only caveats are a) you need a one-off "git add -f" and then
>>   they're tracked b) them being missing from "status" before being
>>   tracked c) the issue under discussion here.
>
> Or only selected "*.o" (vendor supplied binary blob) kept tracked
> while everything else is built from the source.
>
> I do not know who you are referring to "we" in your sentence, but as
> far as I am concerned, it has been and still is a BCP recommendation
> on this list to deal with a case like that.

I mean that this use-case of having a "soft" ignore by carrying it
across the "git add" barrier with a one-off "-f" isn't something
explicitly documented, and apparently not something many
expect. I.e. you / Matthieu have mentioned .gitignore in the past for
only-generated *.o use-case.

But it also does get used for "mostly we don't want this file, but
sometimes we do" use-case, so that's something we need to deal with in
practice. Like many workflows in git it's not something that was forseen
or intended, but does happen in the wild.
