Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F993C7EE23
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 23:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBZXwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 18:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBZXwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 18:52:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD1DBD6
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 15:52:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s26so18939229edw.11
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 15:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+piaxST6IvRj14KBjxvp6YJv1buQpySj1eP8v0/edIo=;
        b=oKLxrkFVfOiX+rZ0YY9h7jiEaiV3aj8tYCeNqHjB/zqXfde7nXYgkvq3yHgeU5bOSW
         ZwQRrUfLUfzZgkj9nnLXnDpzewZo7nopc+H3SFF2GAAcUZpJpavDhQ2UbwuyRCiozhx+
         bTmqw41OF0WaqmJI0Gn8tvXJJSgvefW6dVQbhzXFjkcwy8eRLqaMo8WKjFxbACqFJ0Yt
         NNpwkghNg+VhLxP1jIaBxlhjuDjpABDV4zodVO0kdFhU9l5u9Nd5FrzlahATEn8Kb4SI
         FJYqN66dHDU95C1TbxppLHbI4mH/NiiabnBYSU3UNn7veXp20w/knxf58P9cJU/Re+eD
         FLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+piaxST6IvRj14KBjxvp6YJv1buQpySj1eP8v0/edIo=;
        b=lvyuY8P9LvXVg2civOtrP9vQKmBuXxLj2CPiLcY0+qhzqdX9GFhep4D4jiS4uS9xus
         dV4C9dwyI38tq34Cwo2NIcggLFJsIzwiihvXvzBYgS9uQGN1xcx2TCdhvA8dJEPoj2oN
         OE9HAo0qk0rj9lENctahyPjNLBtlTTzN01PHqP8/n5PaUMqEnQYy9KXUznXRijlTXjOu
         mAbCKuiQtne0LgcD2VofRxo62e4lql/ylM6q4BpcvYBn0twjRO13rna8xqF+Y4AD8ox7
         CeMdattC3yJrpzjZ9+lTWQT+p8t8fy4sam9F+qmfrwUpMNxFKZN1a1kEbnoypy3sKnJ0
         g+kw==
X-Gm-Message-State: AO0yUKWFvn783wJft49lPcpOvGBQ9cVgiIvnWWz8PuMyK3lo5vAOP54c
        N5h/eQ6JElY+ru4OSkUMA3d7scae4YmjDLy91G8=
X-Google-Smtp-Source: AK7set8lpGqW7ORrBxtrvXjxwd1Mtzb4RYILLtWOM5KTgTm9yBoeLvgt93Eu5Gm6Lw7doR6smKOjmLAEHuymnVFJSec=
X-Received: by 2002:a17:906:ce59:b0:8b1:7de9:b39b with SMTP id
 se25-20020a170906ce5900b008b17de9b39bmr16059683ejb.1.1677455536049; Sun, 26
 Feb 2023 15:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20230226083347.80519-1-gvivan6@gmail.com> <5575804f-0918-fa7c-7af1-da2f4cf073f7@github.com>
In-Reply-To: <5575804f-0918-fa7c-7af1-da2f4cf073f7@github.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Sun, 26 Feb 2023 16:52:04 -0700
Message-ID: <CADupsJN1zLxokk+Nh9=W9gb7UPFrGaiOJj4FM7zp+u9psPkTnw@mail.gmail.com>
Subject: Re: [RFC][PATCH] GSoC 2023 proposal: more sparse index integration
To:     Victoria Dye <vdye@github.com>
Cc:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please wrap your text to 72 (or up to 80) characters; doing that will mak=
e
> this much easier for reviewers to format their emails. I've re-wrapped li=
nes
> I'm commenting on below.

I wrote it in Word, copied and pasted it, and then sent it to the mailing l=
ist.
However, I will send a revised version that is properly formatted.

> References to other sources (e.g. web links) are usually made with [<N>]
> footnotes. In this case, that might look something like:
>
> "
> Git 2.25.0 introduced a new experimental `git sparse-checkout` command,
> which simplified the existing feature and improved performance for large
> repositories. It allows users to restrict their working directory to only
> the files they care about, allowing them to ensure the developer workflow=
 is
> as fast as possible while maintaining all the benefits of a monorepo. [1]
>
> [1]: https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with=
-sparse-checkout/
> "
>
> Same goes for the other references you've included.

Actually, I had all of the titles in the word document as hyperlinks;
I'll make this
change for the reviewers on the mailing list, but do you recommend changing=
 it
in the final proposal I'm submitting to Google?

> > +## Microproject
> > +
> > +t4121: modernize test style
> > +Status: ready to merge
>
> To expand on the point made by Ashutosh [1], this microproject is not yet
> tracked by Junio's "What's cooking" emails (most recent here: [2]), so it=
 is
> not "ready to merge." "Under review" would be a more appropriate
> description.
> [1] https://lore.kernel.org/git/CACmM78QTptLOvNHs9oE2NNareSNDb+ydGFKr0VHu=
boCBWSZbSw@mail.gmail.com/
> [2] https://lore.kernel.org/git/xmqq1qmeyfps.fsf@gitster.g/

I only put that in as a placeholder because the status is likely to change =
by
the time I submit my proposal. However, I'll change the placeholder to WIP.

>
> > Integration with =E2=80=9Cmv=E2=80=9D
> > Integration with =E2=80=9Creset=E2=80=9D
> > Integration with =E2=80=9Csparse-checkout=E2=80=9D
> > Integration with =E2=80=9Cclean=E2=80=9D
> > Integration with =E2=80=9Cblame=E2=80=9D
>
> Please include mailing list archive links to these series.

I also had these as hyperlinks. However, I will include the link here.

> "Two commands per 175 hours" is what I characterized as "rough
> expectations," but the actual number of commands integrated for the proje=
ct
> will vary based on the complexity of the commands chosen. In a proposal, =
I
> would expect an applicant present their own, more detailed reasoning arou=
nd
> how long various parts of the project will take, rather than simply quoti=
ng
> my high-level estimate.
> I said that "I'd be willing to extend as far as Oct 2 (four weeks) if
> needed", but that's a general statement about my own availability and doe=
s
> not mean that I think such an extension is necessary in this case. The ~3=
60
> hours you mention is too large a margin over the 175 hours allocated for =
the
> project to properly understand your planned availability. I would prefer =
a
> more precise breakdown of the time you actually intend to send on the
> project.

Is it sufficient to assign an approximate time I intend to devote to each s=
tep
in my plan?

Thanks!
