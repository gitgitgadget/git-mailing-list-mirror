Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE64B1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 13:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfAVNe2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 08:34:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44699 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfAVNe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 08:34:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so20562136lji.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ML0or9qb3G5X19EeetMhS18OeJHyxZILlEAxjm0f9GA=;
        b=SVcMOk6MCBOS47jmHDm8DWvxdyPo97qpi7LBHd6d5DG3HB6SmO+jCrUA8xY00yNYua
         Oin9h0lcIA9mQKduoG826M/cFHRFB1UqHjoyNX6Um8fIu0yT8VMb4zttHrxtNdNQGiVI
         1YXtwd78nHXIjOqwgHbgPIjELAm/ql6qgRro9CHKBUJksN2TmbkEGvkIy1KF8pJZOs1N
         kMusDX/9VGfK1t3seY4oCxbrYkdV0tpsnetXbB+oQEpldIbZehtz2TVukgpcdTa2iDMI
         WQQqRb15tnJ43xl5D73aDNsKv7vDZU8PRPJO29lM9Bo6ixngkzbZdDoQxfhkuOL5cS60
         7OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ML0or9qb3G5X19EeetMhS18OeJHyxZILlEAxjm0f9GA=;
        b=f800HOCjoEOSmH45NKcPr0ZbWcz8ydT4AxnuaslsTleX9JPbPX9ZRABizZwX0S/K1E
         DmLmNLS25eJEa1Xf0/MQ3gvYDrwFOg0MG3b1QOTbY385bJOzSKZ/4JSqskXNhyr24oOk
         SNpAhLe+rYUOmXdJEh4bOWqHEGdsxwp7fZwUM6oozG11GAQRgEdxjkUZt8FrnTzKCBGQ
         yxpLm2NFabRtvtF9G3pMsvxyFOm3tIb23rsJKc+pBqPysScVDEaG2x9nUwkocWwfR61w
         iVA7Oh6vZpTMP3Ppm0X7ebM1pzgnoeFUE5sbXSEIwe2uAypeoov6h8WsaVP8WSonLdnD
         vAFw==
X-Gm-Message-State: AJcUukfIGN55ehg7TciDGI/6L6Fdju8psNdBLPOwJ6v+jk+i/YadPruq
        Bt/lh/nU95wywP5+rAqWDSeGOSafeReuF0KQR6xsGg==
X-Google-Smtp-Source: ALg8bN4StqGp+MfDBjZKrOhenoocQ7WPX0Ts9PbfCUs8hiyuEGUJtDShpJM2G3zktGzN7+3Wv3zLDaxgb8rCbL1PUuM=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr20169335lji.30.1548164065811;
 Tue, 22 Jan 2019 05:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20190115193112.GE4886@sigill.intra.peff.net> <20190117063114.1901775-1-martin.agren@gmail.com>
 <20190122070725.GA28555@sigill.intra.peff.net>
In-Reply-To: <20190122070725.GA28555@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 22 Jan 2019 14:34:12 +0100
Message-ID: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] setup: do not use invalid `repository_format`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 Jan 2019 at 08:07, Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 17, 2019 at 07:31:14AM +0100, Martin =C3=85gren wrote:
>
> > Something like the below on top of this series (then rebased). (The las=
t
> > hunk below is a revert of this patch.)
>
> Yes, that's exactly what I had in mind. Usually our clear() functions
> put the struct back into some default state from which it can be used
> gain. But the state after clear() here (without the patch below) is
> something that nobody is ever expected to look at.

> > So in particular, why doesn't `clear...()` and the error path in
> > `read_...()` impose sane, usable defaults? My first concern is that it
> > means we need to make a stronger promise, which might then be hard to
> > back away from, if we want to. Maybe we'll never want to...
>
> I'm not too worried about that personally. I think the more likely
> problem is that the API is misunderstood and misused. ;)

Heh. Agreed. :-)

> Now if your next question is: "does any caller misuse this as more than
> looking at the repo format", I don't know the answer for sure. That
> would be worth poking at (or perhaps having just poked yourself, you
> might have an idea already).

Not really. I've stumbled around a little, but I'll need to do that some
more.

> For the record, I can live with it either way. There are so many funky
> little setup corner cases in the code already, and we don't even really
> have a real-world case to dissect at this point. So the right thing may
> also just be to finish this patch series as quickly as possible and move
> on to something more useful. :)

I rebased the "something like this?" into this series yesterday and I
think the end result is better, but also that the way there is clearer,
mostly because this patch is then gone. I wanted to double-check it
tonight and submit it. I'll do that tonight.

Thank you for your comments. They're really helpful.


Martin
