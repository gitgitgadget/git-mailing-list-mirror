Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35206E8FDC5
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 02:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjJDCKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 22:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjJDCJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 22:09:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED787AF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 19:09:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso2785159a12.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696385394; x=1696990194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uHFmz8uWmu9DWZXy7/8JjI1sUzdh0ax8/lGYDUqga4=;
        b=dEytUdZJlpKaPcekA9qfPhTofIhSFEiuH+idr7DljSA2hM6tIxw494bgNo3KMVBeXn
         shYHiz15nrq14coZxkYVi0CL0yddjXZHKNXc2otQ7j1IkkSrlEEdUxJKx6dCWb8ZmWnR
         Ps06INxKuD3XB/wUDAMDznJSUW1PrKzyLTZbzJ7qRIf3onKXyd0cYshZVGYxJLgCzioV
         tI2KIXB5H88KkO/+cmLZNq3dxm+iKxPGHnJLKljQg45/ZUwRFOcLJMDKLmDMEFQgMP6w
         oQSdGVCYw9U9V0YX3QsSwhSc4FlCPLoVus14kjS6lNOMOyyLTsMcMsw+01zxoEhUDniL
         zmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696385394; x=1696990194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uHFmz8uWmu9DWZXy7/8JjI1sUzdh0ax8/lGYDUqga4=;
        b=KdyCPhfPGj+Tdp8nsckhviT1pAOwPM53iTa+qK2NJhGMVz5aa6F4+V+a5AiQ+oYXJq
         at1Ne7Gl0HrLONz+NmbqNwTCao9NJmSk4TAg7Ulu4hBdPQawTApxG/WAm04zuZrr5pNW
         I7nkOXMyeQHytmMR7edGpiJD4p50sRJg0XlV1GYPhZ7aP5KT1s6mjkrmmn9RUN84dMEN
         BNQcUv+lH7WupXDTD5hZisFnlHAAAhoBfAJ8F2ysA4tC3cLA9WK9xXkfLt+DfeqF92z/
         QiynUTC1HOkIbhGxCC6q1JqW5GQPgBiP11kDfaRdJ7Q+w8JOEceOOXefLMldId1ubVyl
         4sUw==
X-Gm-Message-State: AOJu0YygJ4lPTHY4pgDhukJORzCJ8rxb9iGQI1bv2IIK+ekOd1tesuTA
        Z4y4zuAJFpdeLjajqOicRN8h8RjpcDVoQCk41Ms=
X-Google-Smtp-Source: AGHT+IF23DL+YIPObXkxOZ1z+ebp360mEJ4uGrE2kSq36o/xxVFMo2Y58uxrla4606G30oYWcu37WxBywBuwxTNhMug=
X-Received: by 2002:aa7:c447:0:b0:52f:736f:b50 with SMTP id
 n7-20020aa7c447000000b0052f736f0b50mr817017edr.18.1696385394288; Tue, 03 Oct
 2023 19:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1591.git.1696193527923.gitgitgadget@gmail.com>
 <pull.1591.v2.git.1696350802820.gitgitgadget@gmail.com> <xmqq4jj7zc5b.fsf@gitster.g>
In-Reply-To: <xmqq4jj7zc5b.fsf@gitster.g>
From:   Javier Mora <cousteaulecommandant@gmail.com>
Date:   Wed, 4 Oct 2023 03:09:42 +0100
Message-ID: <CAH1-q0g_YXxBMJE+ZOv93VMk3c-Evhr6m+387DLMf_j_+u+cOA@mail.gmail.com>
Subject: Re: [PATCH v2] git-status.txt: fix minor asciidoc format issue
To:     Junio C Hamano <gitster@pobox.com>
Cc:     cousteau via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fair enough; I'll update the commit message.  I just thought it still
worked more or less so I left it as is.

El mar, 3 oct 2023 a las 21:25, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> "cousteau via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Javier Mora <cousteaulecommandant@gmail.com>
> >
> > The paragraph below the list of short option combinations
> > isn't correctly formatted, making the result hard to read.
> >
> > Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
> > ---
>
> The above probably no longer describes the situation the patch
> intends to correct, I suspect.  It used to be near-impossible hard
> to read, but at least with them indented they are legible.
>
>         The additional states for submodules are typeset differently
>         from how the states for paths for normal blobs are listed as
>         enumeration.  Format them in the same way for consistency.
>
> or something like that, perhaps.
>
> >  Documentation/git-status.txt | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
> > index b27d127b5e2..48f46eb2047 100644
> > --- a/Documentation/git-status.txt
> > +++ b/Documentation/git-status.txt
> > @@ -246,10 +246,9 @@ U           U    unmerged, both modified
> >
> >  Submodules have more state and instead report
> >
> > -             M    the submodule has a different HEAD than
> > -                  recorded in the index
> > -             m    the submodule has modified content
> > -             ?    the submodule has untracked files
> > +* 'M' =3D the submodule has a different HEAD than recorded in the inde=
x
> > +* 'm' =3D the submodule has modified content
> > +* '?' =3D the submodule has untracked files
> >
> >  since modified content or untracked files in a submodule cannot be add=
ed
> >  via `git add` in the superproject to prepare a commit.
>
> Thanks for making this part of the documentation better.
>
