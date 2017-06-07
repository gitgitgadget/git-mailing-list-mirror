Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C301F8CF
	for <e@80x24.org>; Wed,  7 Jun 2017 00:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdFGAfQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 20:35:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34571 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdFGAfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 20:35:15 -0400
Received: by mail-io0-f195.google.com with SMTP id a96so123535ioj.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 17:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2s2BCwT+O2ZuEHK7m7fSZmP3Y+4mbuIZBEN1WuYLeRM=;
        b=CrVu6ixl95PcfNP97pzhnACjTMjysR1UQk/EiLCqHSNDSePIEODxqCGplPI62WzQ4k
         OXOXDparQ+sjc0SYT8c1xubfC73lfZ0Ry8Altmx8pxNkqCUojWVBovcTf92PXehaf4kB
         0hmMTD/7WaPim6vf2yEo3/EELhfrq90ozGaEmLsrtyfZSWqnorKrrUYiI2QsUI0maexH
         KQhaAU4o8hNx39/3+ncu3JbV68WwhBZgAtz+bfjbTYW2fQcT3VwCBgCEc5Sa5XhQXGoM
         0oGMzBIkwTULg89H90qIYvkzCiTuarYptNs+RtkuOtTibprihdyaAOua3ZTWxf/mil7P
         vg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2s2BCwT+O2ZuEHK7m7fSZmP3Y+4mbuIZBEN1WuYLeRM=;
        b=Ui1OoL7nkow9OFXiutcHRzc3tY+jal9eJKAxr/hzi2ZzGckoAspPAGNIjm02ExnRll
         faWiB0A2apWvifibQ6EDRZHIlF+8LML8JthnmkBu/VXMxeLdK//jHWXx8dg3iQVCb8BJ
         Ml/UeU+ydjalH/4/3/ZANg3/Xi0lXRCvxWy4d/sBT2iYMlVX5QyD0fvMN8uymsXCU28V
         1cItO6fS0S3Xp40Uzx1FEUzcISFOO3vPKEaBoAdgC82jDWfnIofnmUIOshXnfhMXIHEp
         9GsRk+6oksOBDHhTiqXg6r5T5Z33pZwQHhBw9rESZrplk9sqqqNTAfalTGOuegaYJ+XK
         Vv9A==
X-Gm-Message-State: AODbwcCjLncOakaTyHBETXQAZU+RGFyKfJOFbRr3bnttZYwtSVYWcrlv
        zejMWA1uGOTDLBDkiKUiTq91nTzevw==
X-Received: by 10.107.201.206 with SMTP id z197mr33348185iof.85.1496795714510;
 Tue, 06 Jun 2017 17:35:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Tue, 6 Jun 2017 17:34:33 -0700 (PDT)
In-Reply-To: <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com> <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox> <20170602175455.GA30988@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706070008440.171564@virtualbox> <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 6 Jun 2017 20:34:33 -0400
Message-ID: <CAJZjrdX-Xfe=JUHtv69m9KRJrd5xAZmfECwYLH_fy-gjEBZhYw@mail.gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests for
 console output
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 6:45 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jun 6, 2017 at 3:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> 4) we still have the problem that there is no cryptography expert among
>> those who in the Git project are listened to
>
> I can assure you that Jonathan listened to crypto experts. It just did not
> happen on the mailing list, which is sad regarding openness and transparency.

In the interest of openness and transparency, perhaps a blue doc
should be put together to outline and document the hash function that
succeeds SHA1, and the rationales for doing so? It would, ideally,
cite (preferably by including, and not just linking to) any
discussions with crypto experts that have chimed in off-list (given
said experts' consent for any such communication to be publicized,
naturally).

If I'm not mistaken, the only such doc behind the transition right now
is the Git hash function transition document, which covers the
technical barriers to replacing SHA1, but not why we might choose X to
replace SHA1.
