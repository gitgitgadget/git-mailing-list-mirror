Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC061F463
	for <e@80x24.org>; Wed, 11 Sep 2019 10:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfIKKaD (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 06:30:03 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45686 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfIKKaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 06:30:03 -0400
Received: by mail-lf1-f45.google.com with SMTP id r134so15994835lff.12
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0Iz5cuzYpzgX6MHQMLFGh+0XyNvEAJNGvl52aT9GOg=;
        b=RJKnayCDoK3mK4XaNjs6pfWExUkJYerfAmwz36dudBinzlJUmt8egF+cVMUkAIEPR9
         vkUadS53zAvYQjaH53Rt0Wh8fH3XJfCJcPQRcPgVuAprP99KpsFpw6GJo5GhLGy4pQGe
         eKzmdguDm1d4x/ejNJAWG80+nOBvEEUWtonD95lzlF5smVLEoPSiEEkoZn9nbbwoTgOd
         j/9hgic+MJNAnlB/20f1BhAu9l55ig4xk9lJZoZ3n+l+pqUUtUDmlwM5JHtR5upyuP1e
         40ZhyudKBvUYAv829NvZ0jq5Jjm8QJCRnovnN81SSBg399jhoxR+Ogo7Xxt84TCzn0cR
         GCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0Iz5cuzYpzgX6MHQMLFGh+0XyNvEAJNGvl52aT9GOg=;
        b=ggIze1teY6MUu9lN2R4rvewxm4lvD/WQXrI4Du4f8Kw554oDdeOLT3gMhsxwzwMJfV
         mzjaAh/1XN0915mh57o4OyazsbTptkM6JOlw2T9POvTdlQaARpS3qM903nzT2DQCmPVf
         Cr2130rhzs60xhmxcPrSAyjVV/6auXLTVANdYNE0CDt+U1ziW5cH9PVahOd5VOmE5R5O
         BBiZ8cavBXVWodCrSHRTjjyEq3ID1Ly9nX3x6LtaPYWkU3v5FL6hJ6LtmvJlppW+7mf/
         eHLvuU501o7p5hZIwVsaA+sddEoeXI+fqU6++pl1CvgfprjHEKUmGhnMYVICxecZJiwI
         ZwZw==
X-Gm-Message-State: APjAAAWgoERFzKV2AWkVvDFZn7ueojj8rAiyBM4b5LzSbOOHwaXmFl49
        y1f3ixlXjIE0ZAu0cDgKoAsPr0TimTW039jdRgg=
X-Google-Smtp-Source: APXvYqycWo/EAXgyhAX70DQGfP+4iu9gVwnJnDxweO2vY87HBVy5HA4FH4lFHqbmYqYTytnujjIAVphKbeZ38VCJreA=
X-Received: by 2002:ac2:44c8:: with SMTP id d8mr1200245lfm.101.1568197801359;
 Wed, 11 Sep 2019 03:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com> <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
 <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com> <8a726eea-f461-db90-7e36-70b708ff8915@kdbg.org>
 <CAKPyHN3+Sr2QJGR7Sw02x0A9OXshVUQofqH=ShXDivmqP5X7vw@mail.gmail.com> <20190910085446.GB32239@gmail.com>
In-Reply-To: <20190910085446.GB32239@gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 11 Sep 2019 12:27:30 +0200
Message-ID: <CAGr--=Jdj+kJmV7z3vhYW+s129+0+KgbNYw8NFPmSASRYMTdbg@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

I'm hoping this will be merged, even without changing the radio
selectors to a checkbox(?). The patch from Bert resolves the issue I
raised about wanting the hotkey.
What do you think?

Birger
