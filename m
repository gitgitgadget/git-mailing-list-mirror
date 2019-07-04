Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323D81F461
	for <e@80x24.org>; Thu,  4 Jul 2019 05:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfGDFME (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 01:12:04 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:34885 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfGDFME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 01:12:04 -0400
Received: by mail-io1-f49.google.com with SMTP id m24so758319ioo.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 22:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdQUM6fuefq3eC4vlWZ0CrQfV6M0b9wUYJjL9DPdB6I=;
        b=THt+bULAKpXJWKW109N4HZNM5co2fsD0htYu/7lxzCRqbAESEwxSw2vlKOP2j8edKH
         p4UFgkg/tVokRQzoQc8zPeTZULC3oEUS+hWjXT1jbnuns0euttDH3LgUI0/B7JrHpc8u
         kkWYOcUtS/S8sejFltkWkWpJIFsy/IsnFBjq6le5h7dY4v+BaTCDY/lMch71uYQjE64H
         dtSCK1kQ5RUv7idYLVALLeuhmEoEE1+OOxqYlLTL6UHbrgT0WmVxlv93bLqIo+Pa3OBw
         0GDtU+iLX0O0GGK5Ct1q7CLKExP961LyOhQXe4ZCv/8l0QT2qfEsYfhVsyH33oEpROF2
         w2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdQUM6fuefq3eC4vlWZ0CrQfV6M0b9wUYJjL9DPdB6I=;
        b=V12rq1wrb1rEFHvDNfsohwYYePI0qeU8oy+jUKx67181VcpMEcBKi9W65hLpALvqbt
         Rzgs4Gh+uLlIFsVFftrK1WmtrNRajgAAjkPaTVjkSo9KgeKVAPeyuCZrBXs60c8tEv7F
         WEUz/eFqnsc7hO2JWLk3BLMMYWkatHX7T3X5eDPrCKfWhltgy5Ylb3wUwu02Ai8kqcWR
         fEuh2BXQBWXg6HT74/U0QrXSzZ+xndJcvFdES8cUZ5Sdc4Ct8Zs7MMiv0sxWOnkLHd4B
         nuduvZgYYnxYZ2cXRhkps9EJbmYit0pqfqyOY7lU2imy3w/l6VQLnf0k7N1vBk9mkxXx
         N9Zg==
X-Gm-Message-State: APjAAAWxmYoepnKM+yC3rz9Dji1VZPI8cmVWMdXU0odaTjYc2rzR1+TV
        Xkg/PS1780yRiO/sNj0gYQ+hITHq5qMILFzj9JI=
X-Google-Smtp-Source: APXvYqxUk6NGLP+Hjps2xS6LQ0/Ve76zHRuddIvRvyczVpHbXK/z9NQFtmuid4TM+2kzuIOJORSQaTWYFZYhN1qhG/c=
X-Received: by 2002:a02:bb05:: with SMTP id y5mr45591553jan.93.1562217123554;
 Wed, 03 Jul 2019 22:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190618064537.62369-1-carenas@gmail.com> <20190618155326.GA4014@sigill.intra.peff.net>
 <CAPUEspgRnGd4nT3yd2YTGMt8t4qQ=V3GGNeTih3cmjnZHNextw@mail.gmail.com>
 <20190619174841.GB27834@sigill.intra.peff.net> <xmqqtvc3ymux.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvc3ymux.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 3 Jul 2019 22:11:52 -0700
Message-ID: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
Subject: Re: [PATCH 0/2] a few more redundant system include cleanups
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 3, 2019 at 11:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo, no need to rush, but has this happened already?  I do not
> recall seeing an update, and I am wondering if I missed one.

Junio; had yet to send the update, so nothing was missed

Carlo
