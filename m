Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DEFC433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiJCNx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJCNxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 09:53:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B34B9A1
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 06:53:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j16so16706825lfg.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR4xYPj6ZQ7DKY9suBahz4L9dcfI9X07+LLBvuQReu8=;
        b=oRS1URhQDJNLFpwmEaNceOGfEfP2moiTAcYpy2zF8Qa1xioga8LX9FhVBiJe8VXu0Y
         kIu8qZbyH+Qe8kDjtlbXj5O5hPaq1Bl41e52LfdtOn0BBqLM+JUphKDVu/4ovA5SoyPJ
         4QOEx6anJ+tN85JCZnmaOKDl/MV4DdbRoa0iq4E7Jdvowo0vbHDSYI/aSF7RmhDqT71n
         h+oC8nJUQbqc3s+Ms3YEVJtyvA5V6dz/8quRNZrp0AlAajjiibT1Vynhh+IdiYIBqEyE
         3o+6/G5hLgCBtajMrN6DCM15DHIYTdI6lrq9G69mZ6U1sUOyH68gInHuXBlj7QO1nrAj
         /tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR4xYPj6ZQ7DKY9suBahz4L9dcfI9X07+LLBvuQReu8=;
        b=MaZdlfEr9BA96SCJbeOJCP5IibkpTbgpRTjfD6kDGyFPo4FEJ24Ej2aHjsg68QUVhy
         aRIPQDuMPDVJc0YI8tkZsJalg9Yl4E33Ams04VteDKTRlqtSzd/6Jt8SKrblRobl8J/n
         e7p9szyS2SxqwYaqj2SxBbSzLa8UDkzFXhPpuLQr5OklOTqA3DlCQmWQuNfE6071oYgS
         nUufEddrGnRxGyOwWfk07uXOXfV4daNL1kbDa8TlxOzBRqb5w4uaOV8/8iCWEwAUb+9O
         fwxgp978oqHh37zboXGXWHOaheLhc9N549/0tOoN9Q6sqk7h/QrEPDfe6hU7G2T0vyEQ
         IwGw==
X-Gm-Message-State: ACrzQf0WAG5juPa931pQeG2d10pyv6siBCnwlT+dA9VEmd+vQLDOAgyi
        KO2nwsD5Y447yM4t4ElS5u/4rmfK6kxJUl9HXwzXj5WolyI=
X-Google-Smtp-Source: AMsMyM4Rqqqha01XroEQ1mxxFGOYH3+hLzPOjd0aFkA0jrMRQiMekzbfapg/g0RNBrsHzE5tf5tGfIdPmlVvPHnMh4c=
X-Received: by 2002:a05:6512:110c:b0:4a2:4588:6e18 with SMTP id
 l12-20020a056512110c00b004a245886e18mr995235lfg.421.1664805194819; Mon, 03
 Oct 2022 06:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221003084654.183966-1-gitter.spiros@gmail.com> <221003.86o7uttfxg.gmgdl@evledraar.gmail.com>
In-Reply-To: <221003.86o7uttfxg.gmgdl@evledraar.gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Mon, 3 Oct 2022 15:53:06 +0200
Message-ID: <CA+EOSBkp7xUPOa1uJcSi1MBYqUG6r7KQmDjAWDLqLXJwwQ0djA@mail.gmail.com>
Subject: Re: [PATCH] git-reflog.txt: add an EXAMPLES section
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno lun 3 ott 2022 alle ore 11:27 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> ha scritto:
>
>
> On Mon, Oct 03 2022, Elia Pinto wrote:
>
> > This commit adds an "EXAMPLES" section to the git reflog man page.
> > This new section currently provides examples of using git reflog
> > with branches, for which doubts often exist. In this commit we also
> > add a "SEE ALSO" section which refers to further information
> > on git commands or documentation referenced in the git reflog man page.
>
> I think it can be valuable to have an EXAMPLES section, but:
>
> > +EXAMPLES
> > +--------
> > +
> > +`git reflog`::
> > +     Lists entries of reflog of HEAD, starting at `HEAD@{0}`.
> > +
> > +`git reflog HEAD`::
> > +     The same.
> > +
> > +`git reflog show HEAD`::
> > +     The same.
> > +
> > +`git reflog HEAD@{4}`::
> > +     The same, starting at the 4th prior value of HEAD.
> > +
> > +`git reflog master`::
> > +     Lists entries of reflog of `master`.
> > +
> > +`git reflog master@{0}`::
> > +     The same.
> > +
> > +`git reflog master@{now}`::
> > +     The same, show with timestamp.
> > +
> > +`git reflog master@{4.minutes}`::
> > +     The same, starting at master, 4 minutes ago.
> > +
> > +For the branch that is currently checked out, you can omit the name
> > +when you use any of the @{..} notation, so
> > +
> > +`git reflog @{0}`
> > +
> > +`git reflog @{now}`
> > +
> > +are often the easiest ways to view what you did on the current
> > +branch
>
> Most of this really just seems to be duplicating "SPECIFYING REVISIONS",
> and some of it such as "show with timestamp" is ambiguous/misleading. If
> I didn't know how it worked I'd think that it might affect the output
> itself (maybe showing times "relative to now"), but it's just
> gitrevisions syntax.

Thanks a lot, in the meantime.

The examples included are based on an email exchange done here between
a user and a git developer, maybe Junio, I don't remember. The user
found the explanation useful, as he had a hard time understanding how
git-reflog worked with branches. I agree that better could be done,
for example by entering how to recover lost commits, but that was not
the goal at the moment. Later this is something that it is  always
possible to do. It is also true that the examples in practice show
what should already be known with gitrevisions however obviously many
users cannot find the link between the two, I must imagine
>
> > +SEE ALSO
> > +--------
> > +linkgit:gitrevisions[7],
> > +linkgit:git-log[1]
>
> Likewise "SEE ALSO" sections can be really valuable, but they're really
> for "now that you've read the above, maybe this is also useful". It's
> not a "SEE STUFF YOU SAW BEFORE" :)
>
> In this case we link to these in the first and third paragraphs of the
> DESCRIPTION section (respectively), since explaining the revision syntax
> etc. is really core to understanding how this command works.
>
> The "SEE ALSO" section is really more for stuff like (in this case)
> 'git-fsck', 'git-filter-branch', 'git-rev-list' or 'git-stash'. All of
> those commansd have some direct interaction with the 'reflog', but are
> not mentioned in the main prose.
>

Better not to put a "SEE ALSO" then? I personally don't know

>
>
>
>
