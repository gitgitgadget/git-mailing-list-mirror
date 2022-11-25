Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5097C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 06:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKYGHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 01:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKYGHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 01:07:12 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CEA1FCF4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 22:07:10 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id b73so3960284yba.4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 22:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnSPtwj9itLCx7C9vn80UcxQFavcPZ/hoPWWPM/pR6A=;
        b=Fb2if+2FNI30wD8ZKCNyHMzB1yT+W9cmj6Y3HMQfZ5IVWGlL8ofAXc16tF10zx0sfM
         r+fCbX2ROeiXb15SFeF+sOPgPKOaNDstzun3jFVIGB39LOKLjxlv/HGE+UGRKBVNcZdv
         h3CSyn7ieiQvXIVc2jVzQSpJuBKcJ37opxtviOf+JyF0+ao6buDi9eSddiIcy9Y4AIbf
         dHRp5mnB200Z98kFwrFkgGL8PnzFDnn/d50hE3u3bURCnAUilODcwPksbEyacgxm1HGf
         eooFgzj3+7y29fsNRMVSjGxML5fuVE+PppzluUAJ7C0MseZNEA+8+zHARJ74IJLAKNfd
         Ij+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnSPtwj9itLCx7C9vn80UcxQFavcPZ/hoPWWPM/pR6A=;
        b=iGi/q5hCknpDokLgKibSf3SeKxd5hQrUsk/+wrjPTop+zs6MoBHahpC+t35aBOL3Zj
         VwNuVFqLH6qoVocuvaWT+hMXXcYiDwjK8+W64Mw0fZhRWNfw6huN0dkrLXjgXBkhUWbe
         DciAT9xqivJHvt/3rB4XSR/0f45HSaNZU8BfCSHpvqiCcGrMnspF+HfiYHas38UaTq2c
         Ga/2zDij6e8fg0C26C+321MZLpuML6X3BHGx6fUUzqYvoopR8qATjMtd5TOR+xA3h9pR
         bUi1lVM6gNlIY7xJS0Blk1JQK1BWq5DjrCxMYFjyuhHwrfuQg+slsupVbPBespX0rTuD
         nrhw==
X-Gm-Message-State: ANoB5pkRG+HVZUPAKV1JpRSoBC322ZJZkvTljEASEXxYo7bbQSODaVT/
        ZtCcuGjGNIYcIucFH1HCKwTQs4q3BQ3dBEtCLYuqWD/demtFtECOHoA=
X-Google-Smtp-Source: AA0mqf5CcF9OqShDSwfURftsUz4OPvBI8ifa3gNgw/XbzJHGW5doGz4hvLqXg1+ucyEwbfMBWXtGU5XUmXEVlFr1C6g=
X-Received: by 2002:a25:7450:0:b0:6ee:8d5a:3bca with SMTP id
 p77-20020a257450000000b006ee8d5a3bcamr14775756ybc.300.1669356429702; Thu, 24
 Nov 2022 22:07:09 -0800 (PST)
MIME-Version: 1.0
References: <CACtGy4i7Jv+UyjwKOLsMOQwUO81=o98AA5SNwi+=xUB76ehD_g@mail.gmail.com>
In-Reply-To: <CACtGy4i7Jv+UyjwKOLsMOQwUO81=o98AA5SNwi+=xUB76ehD_g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 25 Nov 2022 14:06:58 +0800
Message-ID: <CAOLTT8QF6gqYJf79VQOFn64YD+tew2R2MxjOArm8LZJXC6YbJw@mail.gmail.com>
Subject: Re: git download
To:     Vasilij Demyanov <qvasic@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Vasilij Demyanov <qvasic@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B 01:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello everybody!
>
> I have a need to get just one file from a repository, it would be
> useful to have a command something like this:
>
> git download repo_url branch_or_commit path/to/file
>
> Or maybe there is something like this, I just haven't found it in the doc=
s?
>

If the git server support partial-clone (uploadpack.allowFilter),
maybe you can use this way:

    git clone --depth=3D1 --single-branch --branch=3Dmain --no-checkout
--filter=3Dblob:none
git@github.com:derrickstolee/sparse-checkout-example.git
    cd sparse-checkout-example
    git sparse-checkout set --no-cone "/README.md"
    git checkout main

it will only download single commit, multiple tree, and one blob.

If the server supports fetch any objects
(uploadpack.allowAnySHA1InWant) and you already know the
file's SHA1, there is a kind of black magic here:

    git init repo
    cd repo
    git remote add origin <repo>
    git -c fetch.negotiationAlgorithm=3Dnoop fetch force --no-tags
--no-write-fetch-head --filter=3Dblob:none --stdin
    <blob-oid>

You will get only one blob, "git cat-file -p <blob-oid>" to view the
contents of this file.

Note these two performance maybe not better than git archive or some
file pages support by git server
directly such as
https://raw.githubusercontent.com/derrickstolee/sparse-checkout-example/mai=
n/README.md

> Best regards,
> Vasyl

--
ZheNing Hu
