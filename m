Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CF21F404
	for <e@80x24.org>; Tue, 20 Feb 2018 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBTSvC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 13:51:02 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38154 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeBTSvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 13:51:01 -0500
Received: by mail-yb0-f195.google.com with SMTP id p77-v6so2787198yba.5
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z3dBmnsV+TC//m4ouWeSiIUKkFjkbk03SkNLpxPT8fc=;
        b=jrD8PQe81TRqxKkg+TNsxmQUzKf9OorWms5RKZG0yY8yuDqosiusfHBu+RJUj1sJG0
         xJ21slbh91KfESU24h7SIUBmD86BFtIH0aYE5+Bltd7Vix0DpNfT7VTzwfeQcZ+zFwIZ
         YQqWDQFaBJKZJnrxg6JIxl6BZgExPeh+HVsSJlSrEdfIU2yK1pTav9l1DRINB6mAVNgQ
         gIHhROh/Xzgti46LYkJBHNoa0LDeY/1LEHxEPRkMU5YmJ6JEpGGo0q7PPtTSuoq+nWRr
         ljyosbBkHj2Qz7+oxXKoweuGOEVRHyo6Et02h5ttReO79e/sv2mXs3hbl+Fa0NzhPSnJ
         gQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z3dBmnsV+TC//m4ouWeSiIUKkFjkbk03SkNLpxPT8fc=;
        b=kHVxya1ofYG+hXqR5L2z/m1F+c4mZo/HKMZi3pSStDW5JALcJa2lZFaAquGhTFyQ0Z
         igNvD8SukZSH0+KY28sgQ9WMPKBqsD+lKws4tqCt1pHLh2L/6unhYbdQSM3n/5Y5zotJ
         hETGQV+HmLciR2XDYhgoAFzfcbgdY8clQVgUP7LzBx57vBqShcjGg1x3vn1FclwIY6JW
         JReoAVvcMn/1M/svqLN6XgN84VTeiRF/fBs2x8ylmR3BP69fZL14uY18wvFmOA23DvX0
         zq7Mv5fRi04kvneGWYdY0sC/F0n+BRIXGfDpkP65vKseXFJeUaCtqsbCC1afroE8nPfz
         gA+A==
X-Gm-Message-State: APf1xPDerQ2ZujMzL0NoQI3CAMVr+1CqaAb7cjijwbprIX8OnLSCKeXg
        SXNkdj+xjAnmvMBCouBLB1mSby214+9DzlDyn/kooQ==
X-Google-Smtp-Source: AH8x226E63Bg1zbRGdZuNoNgNSjDA0Rv8cdbpbUVYJ6TtHThsDWSK586/YHU9oMESdVeqd9lSpnHX0LE6XeHSxb1Wvo=
X-Received: by 2002:a25:b382:: with SMTP id m2-v6mr551307ybj.334.1519152660400;
 Tue, 20 Feb 2018 10:51:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 10:50:59
 -0800 (PST)
In-Reply-To: <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
 <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 10:50:59 -0800
Message-ID: <CAGZ79kajrwqu2X7BRe8w0W_sa0nosXxspfhbrm0d-ASzxCLn-A@mail.gmail.com>
Subject: Re: [PATCH v2] Fix misconversion of gitsubmodule.txt
To:     marmot1123 <marmot.motoki@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic was the last to touch that file,
(as found via git log origin/master -- Documentation/gitsubmodules.txt),
sorry I did not find this in the review.

Thanks for the patch!
Stefan


On Tue, Feb 20, 2018 at 3:48 AM, marmot1123 <marmot.motoki@gmail.com> wrote=
:
> In the 2nd and 4th paragraph of DESCRIPTION, there ware misconversions `s=
ubmodule=E2=80=99s`.
> It seems non-ASCII apostrophes, so I rewrite ASCII apostrophes.
>
> Signed-off-by: Motoki Seki <marmot.motoki@gmail.com>
> ---
>  Documentation/gitsubmodules.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodule=
s.txt
> index 46cf120f666df..0d59ab4cdfb1c 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -24,7 +24,7 @@ On the filesystem, a submodule usually (but not always =
- see FORMS below)
>  consists of (i) a Git directory located under the `$GIT_DIR/modules/`
>  directory of its superproject, (ii) a working directory inside the
>  superproject's working directory, and a `.git` file at the root of
> -the submodule=E2=80=99s working directory pointing to (i).
> +the submodule's working directory pointing to (i).
>
>  Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
>  and a working directory at `path/to/bar/`, the superproject tracks the
> @@ -33,7 +33,7 @@ in its `.gitmodules` file (see linkgit:gitmodules[5]) o=
f the form
>  `submodule.foo.path =3D path/to/bar`.
>
>  The `gitlink` entry contains the object name of the commit that the
> -superproject expects the submodule=E2=80=99s working directory to be at.
> +superproject expects the submodule's working directory to be at.
>
>  The section `submodule.foo.*` in the `.gitmodules` file gives additional
>  hints to Gits porcelain layer such as where to obtain the submodule via
>
> --
> https://github.com/git/git/pull/459
