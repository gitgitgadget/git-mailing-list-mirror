Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3722C1FAE2
	for <e@80x24.org>; Tue, 20 Feb 2018 16:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeBTQnD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 11:43:03 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41784 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbeBTQnB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 11:43:01 -0500
Received: by mail-wr0-f175.google.com with SMTP id f14so11790960wre.8
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 08:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B7TkyBZ0uu43OKhZg0GDHZ+tD46D5MJ+BXVG9V69H6k=;
        b=Yvl/2W7y0HwPipA2gPXIDn0xTEUKHtieZiRNOL7phc1fdUSC1BKhLADQiMbbXz94IC
         PgWGXa4hINFEk4cvtGTWEIETFH5ft89kCdyp7D2Fj8+Sb27XVFJj3vzmEvvZ+Al6dWlF
         TB4BYNfXXHJ54CmkCHSw5ALigC9i4g2VeqhrRneh+DVgNx++Zl/VDD/3t/6BNrWYU7LG
         vVtTk3FE2nvFhkRRzu4fRegjEczaWLtmDIkdB4TShSy5O1NXFDzTuGVJKTscwOc36YAh
         5UrdC1pNVbjd8VvSOYkUQhsNkUzYEldbsTkfpHR/AjfAwgA1Vp+JPPkwKLeif8yCpSgL
         SQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B7TkyBZ0uu43OKhZg0GDHZ+tD46D5MJ+BXVG9V69H6k=;
        b=j/h2wGQRRiOThpfPkuO/gmwk+KscETPwMpAK4L37N1ceshYTbdOXuBGxBkjdmBEDtT
         tFIxkLHZ2Sj5VgFgxwaFv6hTCxWJsHYn0cMmKY8SuJBHxh2yHEeueVUkVo/xI2AKMgVf
         CFrhHVlZLJWlTGS51VD68Qsw2Hes8O7s8IiFk5a8CesZ+tG4ENwC+oPfD4T5SKpwdPQY
         98HzrnzL1eEXO/2lBy1cSOpuwgPIJ4xI6ToBvvjF850lTSANZiA55aq+IyQrhNuVUePh
         uLPVoH6stR2+uvnjbXPJgyDa+6kUdV3ECqfMylmmFoh1PDWVkkK1gKM/Q3yg4UnwftKW
         xbmA==
X-Gm-Message-State: APf1xPCokYO8dPlp7lHB3bLiSWr4EfQ0jncSsFwd24kOyF43Kyok2hd+
        zkl0ypWNL6D6CfJM4x5l0hiE4VZZLNv38SxFKP4=
X-Google-Smtp-Source: AH8x224JyNf8bUSbwNV/tJxqWbni7qn6Brev7lgIxzNL9//G6nFsHNDcRPsAG5j6Vio0aOxaf9buuqOZ4W47O2IykJM=
X-Received: by 10.223.199.69 with SMTP id b5mr230354wrh.212.1519144980035;
 Tue, 20 Feb 2018 08:43:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.195.200 with HTTP; Tue, 20 Feb 2018 08:42:39 -0800 (PST)
In-Reply-To: <CAE1pOi00dRYGgLbvep=pC1azAqc+qX=K1+iM-SZycygZyMBg6w@mail.gmail.com>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <007901d3a9d2$2edd7cd0$8c987670$@nexbridge.com> <CAE1pOi00dRYGgLbvep=pC1azAqc+qX=K1+iM-SZycygZyMBg6w@mail.gmail.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Tue, 20 Feb 2018 08:42:39 -0800
Message-ID: <CAE1pOi1FMbdrgpN44BN3MxXoMLA=osPSFiLLHN-FEYABb=NPzA@mail.gmail.com>
Subject: Re: Git should preserve modification times at least on request
To:     Git Users <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Peter Backes <rtc@helen.plasma.xg8.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 3:22 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> Aside from exactly which modification times should be used (which I
> would love to have a bit more control over as well), something else
> I'd like to see is that, when switching between branches, files that
> are the same on both branches should not have their modification time
> changed.

As Junio pointed out to me, Git actually already does what I want when
switching branches. To verify, I switched between 5 branches after
setting a specific timestamp on a particular file, and it did not
change throughout the process. Now I'm left wondering when this
changed or whether my memory is faulty. I could have sworn this did
not work previously. :-)
