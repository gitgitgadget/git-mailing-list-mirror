Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B74F1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbdJ0R3D (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:29:03 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:52198 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbdJ0R3D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:29:03 -0400
Received: by mail-qk0-f178.google.com with SMTP id 17so9208418qkq.8
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vA7gUAorryuts7ITGFHr27bq9F/T5jf31niOKG8aXvU=;
        b=sHzXHWbs02UTeGKYKfK4pw+EmmLuSdUGbPnEz13uo2gNyrC8AObbSjS1+KE014Ue1y
         kjjKNw2O/eMlVS7RjqaT+PBWW5uVlp2MBileZzz/aoUhOPqM4GuZAL+Yaws1cHnvkDfz
         0lV3GiDf9pGwz2DUKo4c7FxIrW/BTXby2wnPg1uYUeSxZSOz0I2GwyaxOLmPbawxsDrR
         Rg1I3D2X5iuf1OuUT9rmCHfzgXwcI5yqIB7Ye13LIGAb6gluP3VJA4X3XCgqQHtD2wgP
         /4Ss9SdRa5Qegroal4ad2IOmtfMxg1pNqEqxNfLE7cIow+wISEMTMCDIFAPdrD4ap/DN
         L0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vA7gUAorryuts7ITGFHr27bq9F/T5jf31niOKG8aXvU=;
        b=aQWVPmRZMyUcMBEWHwnv0l51CmOJYhPmLdLOT1tfMOgNxUL5HGm0iq/vmGbY2tUF7D
         zFGk5s+PjYMQwloN3WSrdf8yv9Ecs0CLQNsx24QPNBOQ/lU6IR98JhjoISb3rh17l7dB
         FT3jPoqEZ/+l+8yp6ExnU6SvqTSek5PMLzQ3d4DW+0qBaGkqzx9NMpru4EBZ9kPlNAwh
         8wlMVIupVn/A2XcF7IZYhiuRiAoMXn8Q5TJq11WHgnoVDqhiF6tP6KeTQyVsv6pXXdvb
         ly1amu2kMtKw16tuVr2FlvhMhrSfk5lek5v2WRaSsUgCBoICnZ2VXc4UvcAhh1zOHahd
         UT+A==
X-Gm-Message-State: AMCzsaVhsTDALmw9i34cW07JvQveVVa9d7rZKKt9K3F/mXSSlxSOD7At
        QPmy2lc5OsUuJ9o0hG4gtWgJUCHusPkJdnm16Vo2Zw==
X-Google-Smtp-Source: ABhQp+ScQpZlRB/REFDMmnxT8pUKDqoXj/fhUdUNFCSwz9odz832PGEK+sDT0akXvp1dcpoNOlFvpHNro6N82m3aCaM=
X-Received: by 10.55.33.203 with SMTP id f72mr1931747qki.176.1509125341950;
 Fri, 27 Oct 2017 10:29:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 27 Oct 2017 10:29:01 -0700 (PDT)
In-Reply-To: <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
 <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com> <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
 <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
 <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
 <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net> <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
 <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
 <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net> <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
 <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com> <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Oct 2017 10:29:01 -0700
Message-ID: <CAGZ79kZ9EV=qaYyuA3kfuQ04EhLWax52MhtkmGJto2Lommc_SQ@mail.gmail.com>
Subject: Re: [PATCH v3] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 6:03 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
> Get 'GIT_MERGE_VERBOSITY' environment variable only once in
> init_merge_options() and store the pointer to its value for the further check.
> No intervening calls to getenv(), putenv(), setenv() or unsetenv() are done
> between the initial getenv() call and the consequential result pass to strtol()
> as these environment related functions could modify the string pointer returned
> by the initial getenv() call.
>
> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>

This is
Reviewed-by: Stefan Beller <sbeller@google.com>
