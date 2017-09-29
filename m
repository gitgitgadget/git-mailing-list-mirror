Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B7420A2A
	for <e@80x24.org>; Fri, 29 Sep 2017 21:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdI2VLB (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 17:11:01 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:45942 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdI2VLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 17:11:00 -0400
Received: by mail-qk0-f170.google.com with SMTP id c67so237394qkg.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T63PZTkhmWHWjtdhoKiPJVvUd3ZBmSktHZWLmX5Zknw=;
        b=arHqkslBDWGvB0N2oCGHSTgGmfofjbWQHerr7YVxSEBIc2OGaOGiM2abb8cmPPj6ob
         GhpYksUmKncMbJm6/thCOG2JFv7YAabWvMrZKoyyJerQS6T0m7vFOzC9LeEcdyjm+v1M
         M+3kji0WwaRUxX9ANNyhh/T3pYFPyTE2Hq7S9ONWxY9rwC4J6j/2ZToND3goBiRdJaXN
         fvR+LhfTu5ybPWqP0OUf7wp2EI6LxYj6BameXa2Fc3DXIAqQOS/19Go6BEvNsx0ez7zM
         UXAmC1G3dzQ/MvhZRmT5j4+wRgvV6RS1PrlTpW4NHQRIS2the55M6InXmBSeA7LE4ji6
         krGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T63PZTkhmWHWjtdhoKiPJVvUd3ZBmSktHZWLmX5Zknw=;
        b=TLCtMpDAxKm6quC++Yxgd2iPNu8LuHOSHK9+UiSx53Ev7VatZSOf5uFqR3J6BvPu/3
         zQ8dIoVnBaqclmk7eRVvlvV6jfMk6oY67SHUUnrqSwWeOPFC7YklC7uaRII1hlI7UxKu
         bMHeWpcHt/Z1MzbKdDxs+5iM65vCMHeKjWnHnUedtbRfPB/WuZRSdMnF4RJDvZEZT4aA
         QyywQGMahT6tTrn9KgZwGAntctG6XF2akdyoyhQd0YTEcB6MjI9CFOGXMaA9HRhqW5rA
         1ZSxdWCMeSuWEB2R+SQ4q7fHHvzoPDXPDaeUMLgk4r1INt9vBgYAF2ktke6OUgK17/V6
         1nbQ==
X-Gm-Message-State: AMCzsaVhS1buaqqNquqZGyL9QWS+TPzet1h55ff7uy657FsUuKwtvviO
        4lt5wz5K7poiDqhkEZ5gtH+Tb9oUZUv8p3vjFd4=
X-Google-Smtp-Source: AOwi7QBh6/KgsQ1u11hzGf2fBI8/Ed8nk78WRHIhEuW9dY6IZBjnxv2mp1dDKuFYXs63sXFH4emJ27+igs1gquVmrl4=
X-Received: by 10.55.98.214 with SMTP id w205mr4892510qkb.355.1506719459575;
 Fri, 29 Sep 2017 14:10:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.33.161 with HTTP; Fri, 29 Sep 2017 14:10:58 -0700 (PDT)
In-Reply-To: <1ffcb7a7-6ffe-c98e-66a1-c3d392f76077@gmx.net>
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
 <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <1ffcb7a7-6ffe-c98e-66a1-c3d392f76077@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 30 Sep 2017 02:40:58 +0530
Message-ID: <CAFZEwPPikNjVDmif0izfwYUqywDO5N2RLf0UF7pZ6qSQyT3q6w@mail.gmail.com>
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Sat, Sep 30, 2017 at 12:24 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> Hi Pranit,
>
> On 09/29/2017 08:49 AM, Pranit Bauva wrote:
> > It has been a long time since this series appeared on the mailing list.
> > The previous version v15[1] is now split into many parts and I am
> > sending the first part right now, will focus on getting this merged and
> > then send out the next part.
>
> That's a good idea!
>
> I just reviewed your series by assuming I did the v15 review well (it
> took quite some time at least)... so I just diff'ed the v15 and the v16
> patches. I am totally fine with it!

Thanks for having the patience of waiting for it and reviewing it again.

Regards,
Pranit Bauva
www.bauva.com
