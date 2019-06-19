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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A03A1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfFSMm4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 08:42:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37450 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfFSMm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 08:42:56 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so37860046iok.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=olMuD5JJlQo7KBeg5SQ4C2zT0gpFhxka6DRH+KyuaXU=;
        b=Vn9bscQ7qgwd+VzNC4f7EY2eZLz9oGQJOocjLZdKz3bjvFT50mHAycAP/emTvqDbSh
         cB3CfeN3d/VTQnX6q11QMeFrOkoT+yEI8sn5QKPYZ7RfRvwFJUQ5nu33eKcwwauHlnjr
         K5mMY0O7fPpXLbFizap5fKI9RS96b7wmJy4xnVvHvAzsy0Lfok8MtsrPEQYcpS/1ufVM
         NXnFCLfiMOU3v8YjOKnbKNOhZYYVjSglMLBMRWKyowZb2z4HX9QETPIcgtAnhEkbKAya
         rWaObrlNOilSGBzXv9i8nnHszhdWqomp0vt6lGOm7qZUsw2ix9nO3hDeNEFmJWmt0liE
         lIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=olMuD5JJlQo7KBeg5SQ4C2zT0gpFhxka6DRH+KyuaXU=;
        b=awLar/uFZV4Ka02ak7F89c3AFn5UX0QDbDD+16yCitU+Bf5Oxky3KE4RsC+uWmKX+6
         R0qzcwrU4+wkA5MXo4Xt7wfYVa2zL9MUg0L5ksIzW2cCcjn0tSyqWOOjedAGKxi/1yOV
         Vtyxte/qesyzkpxVWchap2GjLVzi7b8bW2QzJyNekmpzn/m2iIJYgBDbZ/mBUjuR3efa
         fT2p4JgT0H9gY+ack7wpKFh+GnLhSF7W89M+7Gl4LHm/xektOqkAI3KKjG/lepHDeJHT
         6WqRzjB3aSIRAQOEyCzw183WDehKWoE6O8TWtKcc8h5H+hDAcp9YW3WqdKlNjLQetcXP
         TVxA==
X-Gm-Message-State: APjAAAXo5klGzXrDvy+SJZmJAqeZJQJoFL6WE483SfRRrr62KQEFLZdB
        UF6tUxVqJUuEMS5roK2+WQNBN7skYSH+IGeivdo=
X-Google-Smtp-Source: APXvYqy0WqhEc0GKwVO0AvtknMUeRctrNgthPLx71MI0hmfRYqIDBlYAGDw9v/iHWC68msNID7qhSVDcfi086CKPDD8=
X-Received: by 2002:a02:13c3:: with SMTP id 186mr8107396jaz.30.1560948175588;
 Wed, 19 Jun 2019 05:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095858.30124-1-pclouds@gmail.com> <a5d2d2e9-a22f-9ab8-f88f-9c8c8520735d@gmail.com>
In-Reply-To: <a5d2d2e9-a22f-9ab8-f88f-9c8c8520735d@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Jun 2019 19:42:29 +0700
Message-ID: <CACsJy8BkAPRQNgMQnCkOy3Wrdaj25uK8g-fQ3okpc3BZ33kzrQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 6:58 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/19/2019 5:58 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > This is probably just my itch. Every time I have to do something with
> > the index, I need to add a little bit code here, a little bit there to
> > get a better "view" of the index.
> >
> > This solves it for me. It allows me to see pretty much everything in th=
e
> > index (except really low detail stuff like pathname compression). It's
> > readable by human, but also easy to parse if you need to do statistics
> > and stuff. You could even do a "diff" between two indexes.
> >
> > I'm not really sure if anybody else finds this useful. Because if not,
> > I guess there's not much point trying to merge it to git.git just for a
> > single user. Maintaining off tree is still a pain for me, but I think
> > I can manage it.
>
> I think we (Microsoft/VFS for Git engineers) would use this tool, as we
> frequently need to diagnose something that went wrong in a user's index.
> Kevin Willford built a tool to search the index and figure out what's
> going on, but I'm not sure it parses all of the new extensions or was
> updated to parse the v5 index.

OK I suggest you try it out and see if it really fits your internal
tools. I wanted to balance between manual inspection and automation so
the output may not be the best for tools. I also try not to freeze the
format for more wiggle room, which would be fine for one-time scripts,
but if you want to have real tools depend on it, we may have to look
harder at the output format and make sure it's good enough for some
time, and have some documentation.

Also, I don't suppose it matters, but just for the record I don't care
at all about --json performance. I suppose Jeff's json writer does not
cache the entire json output in memory, so dumping giant index files
is fine. But some other things, like reading the index with multiple
threads, are also disabled.
--=20
Duy
