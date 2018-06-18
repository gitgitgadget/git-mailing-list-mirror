Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0651F403
	for <e@80x24.org>; Mon, 18 Jun 2018 03:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbeFRDlN (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 23:41:13 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:42232 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754562AbeFRDlM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 23:41:12 -0400
Received: by mail-yb0-f175.google.com with SMTP id d123-v6so5470933ybh.9
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 20:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sqM+wv/vPZOGW1mxACX4ehWZ7R6HHKSDIFg0tHPuY1M=;
        b=HEx587YWh7zqufqZLBB/1o6eMoEWea90jVZsIYOqXXkShNJu2nEoqunvLriq4/Q4Pf
         FWqYfv+p4zd5NWGLulbd7TlW86vh1bC7IcWxpBnfBNO7dKyW1t+3QJt2qmCy5FB78BnX
         651r/y5T5hl0qTujF5zcG5j2fa2cmiUhUcx3WuvfXaSETMPS+sabL56Ufkvl+1Kr9qOk
         FB82p4HQrtaI8+wpQuE9xNfBMvLbEMn2zgNjZcy2yFnnXqxgVa40O3RdiYbt5NkZYWxc
         bkpadYLce3kQCmocKjIsQUUHotsFKHtTnQZ7SrZdY+/q2gpXV2czL9EFgFFf4Ma0cyGs
         T2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sqM+wv/vPZOGW1mxACX4ehWZ7R6HHKSDIFg0tHPuY1M=;
        b=EPWCtgpD+VsKk9gcjHLkDweMmUlcXrMVB2WfHLU93taWPJVEsNdMoKbbD8vZkH2/Df
         RPoxFdcz629j02tK/+oFn6tD3UmQOq8HsPGp5ri7styUt2EE+gpDHDYL2eyfuDYiXcvz
         6BidATU1DuUXazCsYQl51eUON0B3Tut9qwwYWA+BdESFKYNpWWdt/LIaHEu05IntVxJk
         M4e80ivWuGRWw7bAeRlWUbq0XAeLx2RlbVUrpC2JmrVrOJkApvjnOYf/K3lmFHT9og3Q
         5xF9iiSOlbRX/q0bVfaqEpdOO/ORh6Un29hQA+CNE/WQJAw2/mUcNdRdC9W5UzX3Utel
         ROag==
X-Gm-Message-State: APt69E2afSSMbw2OASWK9/PHCzN/D0YAxOP3GVS8p1y1DK3kVW/o8G65
        cYtsmGGnb1Bb+pmoZ/kr9HGcoYhBdevXpaSIaXQ=
X-Google-Smtp-Source: ADUXVKI2qq21g5H9I9bLUoGxVSksWjoJy2WYFH6CoP/GvYN6qloimH5MwqlXXyT0x4XfxXF6lrEdGGnhrAomCfUL32Y=
X-Received: by 2002:a25:e6c2:: with SMTP id d185-v6mr5450104ybh.48.1529293272084;
 Sun, 17 Jun 2018 20:41:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:382:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 20:41:11 -0700 (PDT)
From:   Shriramana Sharma <samjnaa@gmail.com>
Date:   Mon, 18 Jun 2018 09:11:11 +0530
Message-ID: <CAH-HCWW2xUqO9HNfzaduXbn1PnwWinVJcTh9AG3Ubmq0LtAQLg@mail.gmail.com>
Subject: need for `git submodule update` over `git pull --recurse-submodules`?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

I've read [this similar question on
superuser](https://superuser.com/questions/852019/git-submodule-foreach-git=
-pull-origin-master-vs-git-pull-recursive-submodules)
but I feel my question is more basic:

From the `git pull` manpage:

    git pull runs git fetch with the given parameters and calls git
merge to merge the retrieved branch heads into the current branch.

    ...

    --[no-]recurse-submodules[=3Dyes|on-demand|no]

    This option controls if new commits of all populated submodules
should be fetched and updated, too.

To keep a cloned repo without submodules up to date I have been using
just `git pull`. From the above it seems that I just need to add
`--recurse-submodules` to pull all submodules as well.

But if so what is the use of `git submodule update --recursive` or
`git submodule update --remote --rebase` or such, which is somewhat
confusing to me I'm sorry to say.

Do I need to execute any `git submodule` commands separately even if I
do `git pull --recurse-submodules`? All I want is to stay in sync with
the cloned repo.

--=20
Shriramana Sharma =E0=AE=B6=E0=AF=8D=E0=AE=B0=E0=AF=80=E0=AE=B0=E0=AE=AE=E0=
=AE=A3=E0=AE=B6=E0=AE=B0=E0=AF=8D=E0=AE=AE=E0=AE=BE =E0=A4=B6=E0=A5=8D=E0=
=A4=B0=E0=A5=80=E0=A4=B0=E0=A4=AE=E0=A4=A3=E0=A4=B6=E0=A4=B0=E0=A5=8D=E0=A4=
=AE=E0=A4=BE =F0=91=80=B0=F0=91=81=86=F0=91=80=AD=F0=91=80=BB=F0=91=80=AD=
=F0=91=80=AB=F0=91=80=A1=F0=91=80=B0=F0=91=80=AD=F0=91=81=86=F0=91=80=AB=F0=
=91=80=B8
