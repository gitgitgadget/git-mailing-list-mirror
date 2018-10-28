Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ED901F453
	for <e@80x24.org>; Sun, 28 Oct 2018 20:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJ2FXk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 01:23:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43063 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeJ2FXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 01:23:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so2841692pgv.10
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ywO2y9qe5bRUsbqV8L9AdD92wbtq1pbtCXJTfucsxuE=;
        b=qW7DdfSDh1Wxu01xFR8Ny1SnWfLRBubarkOyu78EeMDxoUO9pKIBKZAOG3pl/Eg2kV
         7Opw8GdF2G0eSLHQR9+jLG4jZ8uGNXs9W4J4vj22iNjgHa2MnF6/dVAePg5Lux89OnAA
         G0BvcaI5suvEV/bwG/gnucQCSX3uzmv7iiAlorXVZVM16ofGdlGLpoEWyfRGMQnjqAzH
         I7rWamko3HsSVrKFabV8bIj97QM7PJGXqU8oNJ27S4lDd/qM8ikpO65f2cBJV9dk8M19
         BgiN2cneN2Qr5QR8zY7yD36SQeK5Mo11PsxYg9h1CrYcnxQYopnMyVOZnEdqA/bAbAn/
         TLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ywO2y9qe5bRUsbqV8L9AdD92wbtq1pbtCXJTfucsxuE=;
        b=diVVNPteiAM2Xp73uFcF/PEvguAbYN8cmDYfmzr5BUtrsR1zVvrX3hmuPQWCTBEuhX
         TXmILaBRi7LINcBSujJy6cGjMwLgiF/9LE7lM36RwAlqQlU9F+u0YlnsgXry1lqhvQWz
         x3S8P7CEmz7yVpTFLRq0FE98OzR5zUkyT9k+UmDcJUTl/KsSKqMHzXvWbXzRpcHjiAic
         JdyN8D3pEPZsgJ3lWxlbnWSgNVtZC+QFFyfoJ57F8965WVakGnToKaXfxwPu6/JMdxYU
         nUagtxAOW0YLokcpLHWmMO2fi5Ix4vzsRImFJdaDXDbTkcqBMFL5OzVHwvoYQWGowxXx
         gQCQ==
X-Gm-Message-State: AGRZ1gKb4TNft+wNBRZqsliFVDgUVv+a5CfVbaU6+0WGrM47pcF7XQR2
        VPG+Ee+z66R95JZr1CQVpNiW2eL5RrrxcrCKINAWXedF
X-Google-Smtp-Source: AJdET5cS8aFtoGfXM9G8yf9JOboXQ7qydMMFw/u0GH2A4kHsjQxp0p3MNf8buSHF9udPjNZpEDz/KMInNnrRGqvCIkM=
X-Received: by 2002:a63:d849:: with SMTP id k9-v6mr11056216pgj.200.1540759074104;
 Sun, 28 Oct 2018 13:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181028153145.25734-1-martin.agren@gmail.com> <CAPig+cR28OBA0rwy=X6XU0cjstAguvUiLU9Zxjvg2X7=UsB5qw@mail.gmail.com>
In-Reply-To: <CAPig+cR28OBA0rwy=X6XU0cjstAguvUiLU9Zxjvg2X7=UsB5qw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 28 Oct 2018 21:37:27 +0100
Message-ID: <CAN0heSpiVUj1LK9RFkJ5VWGVZs=mheYwYjut3YXzMfVYhtU+8A@mail.gmail.com>
Subject: Re: [PATCH] sequencer: clarify intention to break out of loop
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 28 Oct 2018 at 20:01, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Sun, Oct 28, 2018 at 11:32 AM Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
> > [...]
> > Let's be explicit about breaking out of the loop. This helps the
> > compiler grok our intention. As a bonus, it might make it (even) more
> > obvious to human readers that the loop stops at the first space.
>
> This did come up in review[1,2]. I had a hard time understanding the
> loop because it looked idiomatic but wasn't (and we have preconceived
> notions about behavior of things which look idiomatic).
>
> [1]: https://public-inbox.org/git/CAPig+cQbG2s-LrAo9+7C7=3DdXifbWFJ3SzuNa=
-QePHDk7egK=3Djg@mail.gmail.com/
> [2]: https://public-inbox.org/git/CAPig+cRjU6niXpT2FrDWZ0x1HmGf1ojVZj3uk2=
qXEGe-S7i_HQ@mail.gmail.com/

Hmm, I should have been able to dig those up myself. Thanks for the
pointers.

> >                 /* Determine the length of the label */
> > +               for (i =3D 0; i < len; i++) {
> > +                       if (isspace(name[i])) {
> >                                 len =3D i;
> > +                               break;
> > +                       }
> > +               }
> >                 strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name=
);
>
> At least for me, this would be more idiomatic if it was coded like this:
>
>     for (i =3D 0; i < len; i++)
>         if (isspace(name[i]))
>             break;
>     strbuf_addf(..., i, name);
>
> or, perhaps (less concise):
>
>     for (i =3D 0; i < len; i++)
>         if (isspace(name[i]))
>             break;
>     len =3D i;
>     strbuf_addf(..., len, name);

This second one is more true to the original in that it updates `len` to
the new, shorter length. Which actually seems to be needed -- towards
the very end of the function, `len` is used, so the first of these
suggestions would change the behavior.

Thanks a lot for a review. I'll wait for any additional comments and
will try a v2 with your second suggestion.

Martin
