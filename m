Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39037C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiADU0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiADU0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:26:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D60C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 12:26:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z29so152974233edl.7
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 12:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1Bg1JTwCMy1leSJp0jVmx3CD/3IaCBZt3eYHA6eqbY=;
        b=Sl1J3A3tAsncHGmjCgfVaxbH00eEsGuHTzG1iG2k2lKqP+bYW+2qTs2Yl0R9uvpo+m
         GtKDjfmPwgZ5kPGNRxg5m4Kt7nnx3zh9//uBi24XfKmbMf4pvgo6DTqueggo/2EEkQCE
         tToP6hDE3nRAWWAoInOsNfvfddT13tUErMFtQZV0OkK4uU9J8/dzRmewML1K7ZpYQBya
         AkVlT9lZVOV9UX8jKarsfniJ8uFx5PpATUslplk7h3dxdQ74i0Qcod7gzAqFMuOwm9kW
         hVX6TyU3O77wyjhO+ObXAPGJxP7rl/5+0Wvwr8u8atnPz5lfZNx9gEnEmU7oB/KRkgXU
         x2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1Bg1JTwCMy1leSJp0jVmx3CD/3IaCBZt3eYHA6eqbY=;
        b=6NX7nihL5xptATpw1uGFUQ0KKSU4NGy06Dr8WZP3vhtc0bsiygS79pfS5B/wznFm5o
         wBlZyStH9Omuq/xzBUeZuH1b9wTX7p9+uwr591WS09WlDy+vcqb4ynSkNF2gfEWLh42U
         ZG0mcHanNc9rI+GHKAf9kqcyKtSIesEcvHCxW0YH4GOTO7ora5+Il4/7Z/M6kuvheiKF
         DvgJJnCbYauxtqYMaDkp2GPU2H233hfm96j5V/0u1aP7hj1WYLYApi32TyAV8/sK9/qU
         yCmzXwBCcCZC0sL7rXzrlIoIW+SyebxaQYFpY0WlWJEyH5jsZ3FpIt+2aEMnwUyep4Bi
         mzzw==
X-Gm-Message-State: AOAM531jDu7SMXiGyOWZIe4pijgs0k+749QLS6oKmsS+oBYNQZfGZEjk
        WUqwWnvblJGvXDXDWsRzjXfZ3ewWaH6kV3+EhFI=
X-Google-Smtp-Source: ABdhPJwkZV5vzJ//X+hvWQRSvCk/9LvXXuEjQIgjNCW55gss2XY5exSeMFwK8+6HYFu7/hI3h6DvetLod1NtskdRZlg=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr50373014edd.228.1641327964974;
 Tue, 04 Jan 2022 12:26:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com> <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
 <xmqqy240l8l1.fsf@gitster.g> <d65bf6bf-8f60-31c2-7d01-e57ea6f4a5e3@gmail.com>
In-Reply-To: <d65bf6bf-8f60-31c2-7d01-e57ea6f4a5e3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Jan 2022 12:25:53 -0800
Message-ID: <CABPp-BGSVzEwk83EzhPn3+5jOt5q6=CQ2W_Uz6GfUR=2=AhgNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 11:26 AM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
>
>
> On 12/31/21 4:20 PM, Junio C Hamano wrote:
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> Second, and this item is unrelated to your series but your comment
> >> made me realize it....sparse-checkout unfortunately ignores prefix and
> >> creates a bad .git/info/sparse-checkout file.  For example:
> >> ...
> >> I think the loss of the current working directory will be fixed by the
> >> en/keep-cwd directory (currently in next and marked for merging to
> >> master), but the fact that the wrong paths end up in the
> >> sparse-checkout file is unfortunate.  It basically means that the
> >> `set` and `add` subcommands of `sparse-checkout` can only be safely
> >> run from the toplevel directory.
> >
> > You made it sound as if this is a fundamental limitation, but it
> > sounds more like a bug that needs to be fixed (outside the
> > completion series, of course) to me.
> >
> I can file a bug report if that's the correct way to proceed.

We don't really have a bug tracker.

We often just file an email, and add additional searchable strings
(e.g. #leftoverbits, though that doesn't apply here), and then search
via https://lore.kernel.org/git/.

There is 'git bugreport', but it just generates an email to send to
the mailing list...but we already have the emails in this thread.

There is https://bugs.chromium.org/p/git/issues/list, which is used by
a few folks, but I suspect I'm the only one who has looked at it that
touches sparse-checkout related stuff.

There is https://github.com/git-for-windows/git/issues, but this isn't
Windows specific.  (Sometimes they'll track stuff that isn't windows
specific, but I've seen Dscho close out issues after being reported to
this list.)

I've also kept private files with lists of things to work on.  Doesn't
help anyone else track it.  (Which is why I'll sometimes use one of
the two above trackers instead.)

...not sure if that helps, but that's the basic state of our "bug tracking".
