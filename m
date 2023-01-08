Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1215FC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 10:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjAHKHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 05:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHKHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 05:07:36 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B48DE88
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 02:07:35 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id t15so6079882ybq.4
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eW7pJvHjWGognwpf9DgyrchpJ6LrakSQv0E2Gez6Nl4=;
        b=BQ65evHLqc5wJasNi+AVzekObCgFeag5qv8cnhlS653vrLvZTTYIGJ6KnLl7lrX9OQ
         GPWZlSBPsEg/sdnzPTtbEkF7vEBQ00cxbcK8GLhj1FI1AhIi9KivkW96/9QTYDlC8eEC
         OI4D7ooUKULsPArJ/UTlTlkvwFyUiwFaa288jyRgALVQ2hvSwPbRXRsgXdPBk/seTT62
         arW7xwHlDeRcNInjaeCAQ8D9DEvnfxqRxI2ZFaINcb9FcOw49E/dM69MJxyrGy3ju6qZ
         anWfF4uWqRxw/zQfka/lUKUr/7173zGsh9x+WXm5Vrhp9UyIrdLNZxfnTi8wCoKR4Y7c
         S3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW7pJvHjWGognwpf9DgyrchpJ6LrakSQv0E2Gez6Nl4=;
        b=SILgR4LXCv4bb4upxwvh63t7UNBEM5Go+HMiDaiPmWBK6qkmUX8jtjMuwPJHcHF/Yv
         uImtnPsWQm8WTgC4iucxLOSortUP7qTQW708r1v5MvC3X/MRAqCywB+Pr3nOaQ+PjvxE
         zXWFbChTyvljzEw9/6dsXtA1UthHlOp6OkV9QblM3EAvRknj5TIHrVNjFzIQ38VMMoZ1
         zK5aqFRtwXITx9CYU+JBEvlI5Q42WXd/Tlvqkx1539uJ++SInt7/L8d6gXYkxOzIoAnX
         TDtJlS97ODsuM4WLvcEPn3ZPYCjFbLf1aMY1/n+Sx+CKOX3v8+jeHiGx/GBD4MC/4i0p
         hPpQ==
X-Gm-Message-State: AFqh2kq1Njjui1nd3cPs2i8vy86MFhqB+ZcZzuUSVFj9todtqFBZc/99
        gsVoZwGgOBY8JH+8jPXZ3K8oCQTi46QML07e66qPbERDopQ=
X-Google-Smtp-Source: AMrXdXv/cdkq24SACqMlzufxRuQbadE8AsRuKm1oSLGpzp/tPJ2PhK/9Am45X9q+HQYXmGBJ0VB6I5RLNVcIa2eA8LY=
X-Received: by 2002:a25:d113:0:b0:6e7:6e4e:4327 with SMTP id
 i19-20020a25d113000000b006e76e4e4327mr4416784ybg.178.1673172454193; Sun, 08
 Jan 2023 02:07:34 -0800 (PST)
MIME-Version: 1.0
References: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
In-Reply-To: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sun, 8 Jan 2023 13:07:23 +0300
Message-ID: <CA+PPyiGEaJnwtPtD2XwJPWD_M_ze83p7sg33g9Pu24N6VZyjMA@mail.gmail.com>
Subject: Re: Github actions failing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
So I wanted to send the next patch after review.  All the tests pass
when I run them on my PC but I get something like the following error
when I test from my git branch
>
> + git checkout -b signed
> 2283 Switched to a new branch 'signed'
> 2284 + echo 1
> 2285 + git add file
> 2286 + test_tick
> 2287 + test -z set
> 2288 + test_tick=1112912113
> 2289 + GIT_COMMITTER_DATE='1112912113 -0700'
> 2290 + GIT_AUTHOR_DATE='1112912113 -0700'
> 2291 + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2292 + git commit -S -m initial
> 2293 error: cannot run gpg: No such file or directory
> 2294 error: gpg failed to sign the data
> 2295 fatal: failed to write commit object
> 2296 error: last command exited with $?=128
> 2297 not ok 338 - test bare signature atom
>
> What could be wrong?

This is the branch:
https://github.com/nsengiyumva-wilberforce/git/commits/signature10


On Sun, Jan 8, 2023 at 1:02 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Hi,
> So I wanted to send the next patch after review.  All the tests pass
> when I run them on my PC but I get something like the following error
> when I test from my git branch
> >
> > + git checkout -b signed
> > 2283 Switched to a new branch 'signed'
> > 2284 + echo 1
> > 2285 + git add file
> > 2286 + test_tick
> > 2287 + test -z set
> > 2288 + test_tick=1112912113
> > 2289 + GIT_COMMITTER_DATE='1112912113 -0700'
> > 2290 + GIT_AUTHOR_DATE='1112912113 -0700'
> > 2291 + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> > 2292 + git commit -S -m initial
> > 2293 error: cannot run gpg: No such file or directory
> > 2294 error: gpg failed to sign the data
> > 2295 fatal: failed to write commit object
> > 2296 error: last command exited with $?=128
> > 2297 not ok 338 - test bare signature atom
> What could be wrong?
