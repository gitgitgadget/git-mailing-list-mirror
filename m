Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A1C1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfASSiY (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 13:38:24 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:53812 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfASSiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 13:38:24 -0500
Received: by mail-it1-f171.google.com with SMTP id g85so11345436ita.3
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 10:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CXGIGfjFDHbSwnD/tF3h6zY0o5VyMTCIy28/Vs/3qT4=;
        b=KgVvEGCoAMswTfvfkeRMrV/v4g5dD0oQGlbiZto8gVR+NkQHDpbI5mBAXbgOqK7yHu
         GYORR0qAl2tUKEKYbuzoy3ZSgdXsM3djt3ghiFyrcga609w8FkQKEjP8JYW2mHR47Pa9
         VhlRT9Gb/q3YMcoty1QQJ9vw0xRwpJ+Bk1xmeKvR5zhvsG9Hthd3UHmIKbyoR+lCa4dB
         MRl7QSYnSdRPE8lBpeNmzHV7PGbSiiQnFG3d7prY1M/xaHwEWpl78NKTAOY92dtCEPG9
         4c8zO1/2qqKztBviQKA7uEq3p7h9IX/GQtMDL/JBuX9eF7k/7wQ4UDHGvN7gCvS+g73Q
         U8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=CXGIGfjFDHbSwnD/tF3h6zY0o5VyMTCIy28/Vs/3qT4=;
        b=hrR1nPpSta3rkcNQKA9ip2jks65h7B5ZwQWGOyfQf9j1QPm6yLQpxVr5qInOUhezXc
         79iuKp3niMnB+SOizZixF3S4fTMLWwYzJOY/X9lOKCZNjhC2gmTf5+iRaQL93x/6L15v
         97OPhDxgk/92y9k/pzE4xC73qlqrdGbEWp/mO0Tx7oU7+3peiqgMh9vFLFVPrFb0hMSW
         qVdl5HA4FLnRWoeF6vmL4UzEIol/d41qodBj5nCUbH+ynUgZLPQTBt86kPslnJW9vlRS
         1lpzrKLajHXZTDOL7VM/6O5wHUfoj2t1zZ8GO6cNzWyQxigxSFBGchxgvhLqCeUFyc4V
         kg7g==
X-Gm-Message-State: AJcUukcPTzsrfnWGyJ0gFYpvkFLtn4nNZPB/dqY8VjildenIoJZCY1Bv
        3dSs1X+DkGMJa4yRHsQC2Jd43h+A4Q+Ox/DkIHwTUkkL
X-Google-Smtp-Source: ALg8bN4ttv4mwagVByv/v9ww6DXLgeJMkduJaf4/3Q+8NhPoaTiEH9wFSNcpa81Bx1tm8gWvEBgRxrcKuYxaSldfAPA=
X-Received: by 2002:a02:b46e:: with SMTP id w43mr12901497jaj.94.1547923103021;
 Sat, 19 Jan 2019 10:38:23 -0800 (PST)
MIME-Version: 1.0
References: <CAGTkKagdG=85CVZbumVfXHTx6zgmbD6_PHmzPx4rFpdZ+c22Gg@mail.gmail.com>
In-Reply-To: <CAGTkKagdG=85CVZbumVfXHTx6zgmbD6_PHmzPx4rFpdZ+c22Gg@mail.gmail.com>
From:   Bret Barkelew <bret@corthon.com>
Date:   Sat, 19 Jan 2019 10:38:10 -0800
Message-ID: <CAGTkKahN+bvhhhu+upLNUnMMvmg7fxYqKeYwHAKO3-LZp9rfuw@mail.gmail.com>
Subject: Re: Inconsistent Behavior using 'Reference'
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bump.

We really do need to figure this out. Anyone familiar with the
behavior of =E2=80=9Creference=E2=80=9D?

Thanks!

On Tue, Jan 15, 2019 at 2:24 PM Bret Barkelew <bret@corthon.com> wrote:
>
> The repo/workspace (not the cache, the code we=E2=80=99re going to build)=
 that
> we=E2=80=99re trying to initialize uses several submodules. We=E2=80=99ve=
 notice that
> if we use =E2=80=98clone=E2=80=99 first on the parent repository, then ca=
ll =E2=80=98git
> submodule update --init --recursive --reference <path>=E2=80=99 inside th=
e
> parent repository, the same path is passed to all child and nested
> child repositories.
>
> However, if we call =E2=80=98git clone --recurse-submodules --reference
> <path>=E2=80=99 and try to clone the parent and initialize submodules in =
one
> step, Git tries to append the submodule relative path (relative to the
> parent) to each of the recursive calls, and since the reference repo
> is bare, this fails.
>
> CRITICAL - Cloning repo: https://github.com/Microsoft/mu_tiano_plus.git
> INFO - Cmd to run is: git clone --recurse-submodules --reference
> C:\src2\mu4\mu_basecore https://github.com/Microsoft/mu_tiano_plus.git
> C:\src2\mu4\mu_basecore\Common\TIANO
> INFO - ------------------------------------------------
> INFO - --------------Cmd Output Starting---------------
> INFO - ------------------------------------------------
> INFO - Cloning into 'C:\src2\mu4\mu_basecore\Common\TIANO'...
> Checking out files: 100% (3858/3858), done.
> INFO - Submodule 'CryptoPkg/Library/OpensslLib/openssl'
> (https://github.com/openssl/openssl) registered for path
> 'CryptoPkg/Library/OpensslLib/openssl'
> INFO - fatal: submodule 'CryptoPkg/Library/OpensslLib/openssl' cannot
> add alternate: path
> 'C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLib/openss=
l/'
> does not exist
> INFO - Failed to clone 'CryptoPkg/Library/OpensslLib/openssl'. Retry sche=
duled
> INFO - fatal: submodule 'CryptoPkg/Library/OpensslLib/openssl' cannot
> add alternate: path
> 'C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLib/openss=
l/'
> does not exist
> INFO - Failed to clone 'CryptoPkg/Library/OpensslLib/openssl' a second
> time, aborting
>
> As you can see, the parent path is
> =E2=80=98'C:\src2\mu4\mu_basecore\Common\TIANO=E2=80=99, but when clone i=
nitializes
> the submodule, it updates the =E2=80=98C:\src2\mu4\mu_basecore=E2=80=99 r=
eference to
> =E2=80=98C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLi=
b/openssl/=E2=80=99,
> as though the reference were a full repo and it was checking for the
> submodule repo within the =E2=80=98.git=E2=80=99 directory.
>
> If we do this same thing using a =E2=80=98clone=E2=80=99 first, and =E2=
=80=98submodule update=E2=80=99
> second, the same =E2=80=98C:\src2\mu4\mu_basecore=E2=80=99 reference is p=
assed to all
> submodules (AND nested submodules).
>
> Thoughts? Are these both expected behaviors? Will they be consistent
> in future versions of git?

If we were to converge on one, we would prefer the single path rather
than the inferred path.

>
> Thanks!
>
> - Bret Barkelew
