Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D1C1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 17:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAYRUH (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 12:20:07 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:50484 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 12:20:07 -0500
Received: by mail-it1-f171.google.com with SMTP id z7so11638312iti.0
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Pp7fUluFuxFhs3wAG3n9/3Z3jX0iSJ7e5HhjXLUnd1E=;
        b=i2YMswMl0GfKZV9fRmKzyyi2UaP9bvcvaWFE49FBrPhgPly0OVEYwQmCY4xR4B2zii
         mP5zPmOdh+sWss9l6yey9GilupEnyVtw3ZjR5BXQ9sCP9zXdko5OfbmI5sN6mVJNr1Bx
         sytFY0+0GSSX3zOJEJ68Lht8a/kPKpRkJ0bs0Z0KhbEblLB6xCsKMpac0nT+trYVL82d
         rRUeq+I9hjoJ5LDoQ+w+cjgj0v4A9V5Pxp6Fa1RHNcIiEo2MU56k+UuQVqjQ1+FM98l7
         p5MZvg/F72FTCyesKye/PWtOGSCt8mci8OHPishXd74Rfjjri+/byDa69DyNVkxIXQv4
         aR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Pp7fUluFuxFhs3wAG3n9/3Z3jX0iSJ7e5HhjXLUnd1E=;
        b=UC6YmhIMhO1bJ1+i7hXo1sAxzZrQmtSx+NX0WQcGuk8CxOpvw7u6J/mTc1mGZLfYUP
         wiDSMgEMvgLEuyjtCZdd8qCQ+tJuRuu00O9t5ZYGRCPR7eyLskgyz+pCEmiyqH7TgPVf
         M67FH63lLXDrJUxBjBRzB+e6ImuFZ/Cl97/OldHh/+wuIhspaIPG+HS9xLNEGusG3R62
         3dg/tUVW0o7vlhA6kVeDlIjRtBwK4+nNCykObEgCN1ute/WsqOxq2DPqelhtVMtYYEi/
         SrvRD7utugTi8qfDonSQxKC4nAX/tfSCmc9JLCFlh7QPchgQHzenWVCWtQKlghlAz08f
         gESA==
X-Gm-Message-State: AJcUukeDAqUUikbY/IBq9miI5mwd2Q2UAmdCQ0LMGVXDhu1e1tPkn9zC
        taFRIICw/ds5SCIE9aToLrhVhsWIgb5JTUstjkg9Bw==
X-Google-Smtp-Source: ALg8bN52MCbq2JgE18ZcY/CQrgrzWPw3quqQhI1/CcWzvSETk9W5eY/r4GnS289PS+cVNClKqkjDTX/MzI2iNxmhNdk=
X-Received: by 2002:a24:3512:: with SMTP id k18mr4414100ita.83.1548436805965;
 Fri, 25 Jan 2019 09:20:05 -0800 (PST)
MIME-Version: 1.0
References: <CAGTkKagdG=85CVZbumVfXHTx6zgmbD6_PHmzPx4rFpdZ+c22Gg@mail.gmail.com>
 <CAGTkKahN+bvhhhu+upLNUnMMvmg7fxYqKeYwHAKO3-LZp9rfuw@mail.gmail.com>
In-Reply-To: <CAGTkKahN+bvhhhu+upLNUnMMvmg7fxYqKeYwHAKO3-LZp9rfuw@mail.gmail.com>
From:   Bret Barkelew <bret@corthon.com>
Date:   Fri, 25 Jan 2019 09:19:54 -0800
Message-ID: <CAGTkKajuzthVJuhmi9ghNAV9LQoTcUMpbDh0J7y7ePpVw0xW_Q@mail.gmail.com>
Subject: Re: Inconsistent Behavior using 'Reference'
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bump x 2

Still seeking anyone that understands the logic behind how "reference"
works across multiple commands.

Thanks!
- Bret

On Sat, Jan 19, 2019 at 10:38 AM Bret Barkelew <bret@corthon.com> wrote:
>
> Bump.
>
> We really do need to figure this out. Anyone familiar with the
> behavior of =E2=80=9Creference=E2=80=9D?
>
> Thanks!
>
> On Tue, Jan 15, 2019 at 2:24 PM Bret Barkelew <bret@corthon.com> wrote:
> >
> > The repo/workspace (not the cache, the code we=E2=80=99re going to buil=
d) that
> > we=E2=80=99re trying to initialize uses several submodules. We=E2=80=99=
ve notice that
> > if we use =E2=80=98clone=E2=80=99 first on the parent repository, then =
call =E2=80=98git
> > submodule update --init --recursive --reference <path>=E2=80=99 inside =
the
> > parent repository, the same path is passed to all child and nested
> > child repositories.
> >
> > However, if we call =E2=80=98git clone --recurse-submodules --reference
> > <path>=E2=80=99 and try to clone the parent and initialize submodules i=
n one
> > step, Git tries to append the submodule relative path (relative to the
> > parent) to each of the recursive calls, and since the reference repo
> > is bare, this fails.
> >
> > CRITICAL - Cloning repo: https://github.com/Microsoft/mu_tiano_plus.git
> > INFO - Cmd to run is: git clone --recurse-submodules --reference
> > C:\src2\mu4\mu_basecore https://github.com/Microsoft/mu_tiano_plus.git
> > C:\src2\mu4\mu_basecore\Common\TIANO
> > INFO - ------------------------------------------------
> > INFO - --------------Cmd Output Starting---------------
> > INFO - ------------------------------------------------
> > INFO - Cloning into 'C:\src2\mu4\mu_basecore\Common\TIANO'...
> > Checking out files: 100% (3858/3858), done.
> > INFO - Submodule 'CryptoPkg/Library/OpensslLib/openssl'
> > (https://github.com/openssl/openssl) registered for path
> > 'CryptoPkg/Library/OpensslLib/openssl'
> > INFO - fatal: submodule 'CryptoPkg/Library/OpensslLib/openssl' cannot
> > add alternate: path
> > 'C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLib/open=
ssl/'
> > does not exist
> > INFO - Failed to clone 'CryptoPkg/Library/OpensslLib/openssl'. Retry sc=
heduled
> > INFO - fatal: submodule 'CryptoPkg/Library/OpensslLib/openssl' cannot
> > add alternate: path
> > 'C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLib/open=
ssl/'
> > does not exist
> > INFO - Failed to clone 'CryptoPkg/Library/OpensslLib/openssl' a second
> > time, aborting
> >
> > As you can see, the parent path is
> > =E2=80=98'C:\src2\mu4\mu_basecore\Common\TIANO=E2=80=99, but when clone=
 initializes
> > the submodule, it updates the =E2=80=98C:\src2\mu4\mu_basecore=E2=80=99=
 reference to
> > =E2=80=98C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/Openssl=
Lib/openssl/=E2=80=99,
> > as though the reference were a full repo and it was checking for the
> > submodule repo within the =E2=80=98.git=E2=80=99 directory.
> >
> > If we do this same thing using a =E2=80=98clone=E2=80=99 first, and =E2=
=80=98submodule update=E2=80=99
> > second, the same =E2=80=98C:\src2\mu4\mu_basecore=E2=80=99 reference is=
 passed to all
> > submodules (AND nested submodules).
> >
> > Thoughts? Are these both expected behaviors? Will they be consistent
> > in future versions of git?
>
> If we were to converge on one, we would prefer the single path rather
> than the inferred path.
>
> >
> > Thanks!
> >
> > - Bret Barkelew
