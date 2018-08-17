Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD5B1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 15:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHQSW7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:22:59 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:39455 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeHQSW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:22:59 -0400
Received: by mail-it0-f54.google.com with SMTP id g141-v6so12204376ita.4
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z3EOatfapvV6XSUUcxfWFNJhuLi/NafY58D9QZxk7tc=;
        b=ZosQewdCX7apsbJ00I3ix28unxrHignbz3tUbZ5vk1Ur6ErxvXcqrwr9O2r9XfMeCC
         w0/WS4dx+eDdDTOZB36zhIh5FKoB4wZL13nptRoiz4PNTtAyT+Eq1rx+L0kF15CtT9vc
         i8NrAn4Zv7AgOlZLR6WdF6bbyuKGwmiOeUAlr9C0uCJdBY0ZobY9gh5SM3LTVx2jqYVc
         LfuWfnOZAPDnny/T49sJIJDhocI5R1MGQP1LdXh8jEqEcbIjATv8a9lv6SOvVrSaR8Mm
         uJFFH7HcKRECCN9yMAL5Kh0dEo3uVCsSJBdmn8HVj+5vQh4+4F4Xz0Vv5dr3c2jeC8pi
         Qs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z3EOatfapvV6XSUUcxfWFNJhuLi/NafY58D9QZxk7tc=;
        b=FDyv6ZzAQAfao1R962PU/6IyAcTQd8duDKrlI0QNtUi+ymUjnQHOHDveu+ste5O8Or
         QnQAR/MN6/7W0SIzmmPWGn+uwy8TYh3Avb0GJQm7eFqpQXRgbLAz5KgJv4t7oePjTgDR
         Q5UjI2X+/nWU8WdEkhbllwRd4JzDLZjaT0pWe7ON6hlSvhc/LqReTJM/bY1OW6Et4ffj
         xT8ofzst2jaESBLjqlapgspIaWpmeAmUpcWd4wIOj0FZAl9KDozg+klypIuklrLncB3M
         ZfLF8PUXOPwTTn3M25IJn89qCq4nebKLOhr1kEjmZWNXWkyea3Lf/vhQYFh/PmdCWrFL
         4JTA==
X-Gm-Message-State: AOUpUlGWioEirxVd41q37iW74lyUgTjFfrHZwyfOQhoUMPXGkAAWmSYH
        o9i4gEAfQlKM7Bz6lIwVybVfp1ySuKK0Sk3N7J0=
X-Google-Smtp-Source: AA+uWPxik7rzwt3+eyuSCRPNTacKdJ9n3FMvpgKwksaHjRs1vecBHJ4aJnIu+aCKDWG8jc8beohNIgwWBzuhTmz4cSo=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr31623002jam.61.1534519152822;
 Fri, 17 Aug 2018 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net> <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com> <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
In-Reply-To: <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 17:18:46 +0200
Message-ID: <CACsJy8CukvQcEY-EmyE7iB2sMwbTSaM_bqGOE0G82FV3Om64kw@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 10:42 PM Stefan Beller <sbeller@google.com> wrote:
> =C3=86var specifically pointed out that we might want to hear from you an=
d Duy
> if you want to attend a conference and if so how we can make that happen
> (by choosing location/time/setting appropriately) IIUC.

Since my name shows up... I'm with Elijah on the travel resistance
thing (and am probably even lazier than him). I guess I will remain
the mystery in the git circle.
--=20
Duy
