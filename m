Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49297C77B60
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 23:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjD3Xoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 19:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjD3Xon (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 19:44:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A56A6
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 16:44:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-392116ae103so889775b6e.0
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682898281; x=1685490281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB8uGnbyRbKcmN/VH/4kV+GKKs/cgX2ZBfT8rTQrVUI=;
        b=gF0LHkjoDlz6OMJfnn4DJnuakNJqN18X/7PkDinir+cTmudJpRcVSDYJv1EVmj37hJ
         3paLhgf96AUek9ofSyj/MegI7I7IkJkXOxK/rEdtZMOvAMvZd5sbNYfetp0ZWAlfFWmh
         F6giK3aBwHjEjvjIudmIGV67lVh6CLzu8S06ESvyBCxHJFqp6mARhSbuG8bAl9hkV+2j
         XLyU0MNiGuk/Azm042vXzfp69KvaC7WnwJNyX9InluXS93+qaHtZTqdsrjy90mSOFoFM
         Z/o65zFPSnRpkhIjLnBu6u0SVLymLHhT7u0fAResk3EnIrLx9UFC47vkWQQm8ezKAXhF
         SC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682898281; x=1685490281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CB8uGnbyRbKcmN/VH/4kV+GKKs/cgX2ZBfT8rTQrVUI=;
        b=Un2Oxm9SGWb1xvatkEE0c5heYOI/DhfUVmWzHzwsSA8IuRR90oqg0UzLYaVerHptig
         CXJzsUtPkHsreZAA0uHFFj5fYdBcX4r1Ik2ZcYdXjWpKonBQ2pq4it4PLfz21oESYQCG
         +ZXcOqcdPLHnYchTdfOeoAT/U/q/1lkYrOkTmKmvWo6L/UL7cn8KTXTnV9pmwxC406Mw
         Ctjsbc6FdtKrl41kfwzJQTGF0hSgqUDcIEK0z+Quji23wee5+DaUWXYoP1Ahs95YWrIz
         2d5DpB+e1NB7bIjmuq597sHNY3uAtgdHjXzOtRdyO9kvWp3YdqDvk+knk/MusJglxXMX
         j9xg==
X-Gm-Message-State: AC+VfDxB/UTnKtPucfa5SoQj2dqfhHCWcBY2RE0EM9RsLNJS28WkDm1B
        pRweiOHLEA128HWQ1zBsPBaWKim1z8paePYt3XNj/7ZM
X-Google-Smtp-Source: ACHHUZ5so8MMSxsEY2SQGMn7L3jTx0jBoZYY31OV8l9Y5ZFUYzlcpvHlYidP8vFzKC6ImKohXHWzaAEVafhuImGOGS0=
X-Received: by 2002:aca:911:0:b0:38e:2135:698b with SMTP id
 17-20020aca0911000000b0038e2135698bmr5747576oij.19.1682898281619; Sun, 30 Apr
 2023 16:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
 <20230428042221.871095-1-alexhenrie24@gmail.com> <20230430131943.4ag5gawuxkvuywlv@tb-raspi4>
In-Reply-To: <20230430131943.4ag5gawuxkvuywlv@tb-raspi4>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 30 Apr 2023 17:43:00 -0600
Message-ID: <CAMMLpeS7Cf5JbgtLMY5XCPdhSLgtyZEMt2xLdRpfD=Yj+uvz2g@mail.gmail.com>
Subject: Re: [PATCH v2] docs: rewrite the documentation of the text and eol attributes
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2023 at 7:19=E2=80=AFAM Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>
> On Thu, Apr 27, 2023 at 10:22:21PM -0600, Alex Henrie wrote:

> > -This attribute enables and controls end-of-line normalization.  When a
>
> Hm, not only, I think. The terminologie is probably not very well specifi=
ed.
> I would say that it "controls end-of-line conversion".
> There are 2 type of conversions, from CRLF into LF and LF into CRLF.
> The CRLF -> LF conversion happens only at `git commit`
> (strictly speaking already at `git add`) and is called normalization.
> Because in Git a "normalized" file has LF in the repo (and index).
> The term normalize has even been add to 2 commands:
>
> `git add --renormalize .`
> inspired by
> `git merge -Xrenormalize`

Yes, we should probably be consistent about using the word "normalize"
to refer to conversion to LF and the word "convert" to refer to
conversion to CRLF or conversion in general. That would also allow us
to use the word "normalize" for emphasis without wondering whether to
add "if necessary", because normalization certainly does not imply
conversion if the file is already normalized.

> > -Note that setting `core.autocrlf` to `true` or `input` overrides
> > -`core.eol` (see the definitions of those options in
> > -linkgit:git-config[1]).
>
> Looking with fresh eyes: I am not sure if like this historical construct.
> First we say the the "core.eol" sets the line endings (if not defined in
> the attribute) and the we say that core.autcrlf overrides core.eol
>
> This is mainly due to historically resons.
> I think that things goes like this:
> When text or text=3Dauto (and Git identifies the file as text),
> and the eol attribute is not set, then:
> core.autocrlf=3Dtrue gives CRLF
> core.autocrlf=3Dinput give LF
> core.autocrlf=3Dfalse looks at core.eol:
> core.eol=3Dclrf gives CRLF
> core.eol=3Dlf give LF
> core.eol unset gives the platform default

Yes, core.autocrlf takes precedence over core.eol. That's explained in
the git-config documentation and doesn't need to be explained again in
the attribute documentation. However, in the documentation for
unspecified `eol`, I did make sure to name `eol`, core.autocrlf, and
core.eol in order of precedence.

> > +file is added to the index, even if it has CRLF line endings in the
> > +working directory, the file is stored in the index with LF line ending=
s.
> > +Conversely, when the file is copied from the index to the working
> "copied" is not an ideal word here:
> We may specify a filter and/or an encoding as well.
> Would "transferred and possibly filtered/encoded" be better ?

Although "transferred and possibly filtered/encoded" might be
technically more accurate, it is a mouthful. For readability, it would
be better to keep the documentation concise. It's clear in this
sentence that "copy" does not mean a byte-for-byte copy (because the
line endings may be changed), which leaves open the possibility that
the file may be transformed in other ways during checkout.

> > +     When `text` is set to "auto", Git decides by itself whether the f=
ile
> > +     is text or binary.  If it is text and the file was not already in
> > +     Git with CRLF endings, line endings are converted on checkin and
> > +     checkout as described above.  Otherwise, no conversion is done on
> > +     checkin or checkout.
>
> Side note: We previously talked about files. path is better.

It depends: When talking about applying the attribute to a path, path
is better, but the actual transformation happens on the file contents.
The file is what's text or binary and the file is what's transformed;
the path is always text and never transformed.

Thanks for the feedback. I will send a v3 that takes into account your
feedback and Junio's.

-Alex
