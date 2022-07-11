Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6724FC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 19:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiGKTIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiGKTIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 15:08:09 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BA63C8CC
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:08:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r136so913146oie.11
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=w4dIaHrYR+biHesLLbWcKwVKb1me20CyNdXau23ABxc=;
        b=Dkm0AYNaV1xfLbeUA+BtjjLYjKwTPCoRD8Sp9yOxm+qdATz8rq+OGYO7UNU0cgIei7
         EfFjfLIWUHpzcozcuT1ncvNtBLj0MNsLmCYuY5lFKkp25KPkaEE1k2b2f6mEPc4W5lzd
         3FqrZ+Un10ZHHlJSgQjMzJ0+rTAqh8w34nixsFCsAl6nwki0XKoI3MWOyKm0P1oZQwK2
         iqWur0Lk7mHpsWPCTMkdERZlLv1q/Pl3stNhg/Yb2/ltJaf6B0hPb2eyzU2zWwm+Heoj
         lx6+Tc0ED7EESTrz2HX1Do+v7i5zkRP48rOxdeEKmK05bFO4Oa9+uS6354+u1K9Cv7ZC
         SkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w4dIaHrYR+biHesLLbWcKwVKb1me20CyNdXau23ABxc=;
        b=Iv1mb2SDJiTy46qzBBit9lhgWQdZi5dNzX4ZgfjRSHvx2nkQcr0pByHR20UgvpxnSd
         cT2s89eaiFM8G/dMlXoHfV9aKRdkIDYy0YG+KEVCPq6eaH0Hz2GTSXObjzmf6HkZr8B2
         oyrgPwABU+i29p135s+tNdiRdUQUsZux67hXLsntawW+FQf5DdJ6/xKNy+NePLZDDmVk
         0DLiQ2YbjGZZLFYSMZsnz0aU+9EYQ2tyO2+DsHOpsKazcNzLN/tbdLDozrNQ6yVvQJlt
         gyuPDunm+BoN3joZgBKor0ttj62BGUY5zs27b7A4IuCqOoeg5zvDfb0ePubadIBZ5oXS
         Gclg==
X-Gm-Message-State: AJIora+zOmuFKEq3IiHH9AwuTjICB15uJxy856f7Ar7LlNk2xOSNiA/4
        NxknNeha7SfwVvzEHHvye6fl0ceqBB7b+cL7golZ5u/Sg1g=
X-Google-Smtp-Source: AGRyM1s7msA88f4Zc7nZn97YPfvA7DeznmA7GWgAp4o/hyTS2ZbGc8M/dnlfX1DHu5zvWs/RDyZ7Lfv0IPc9mibWFBQ=
X-Received: by 2002:a05:6808:14d2:b0:339:de9f:5df1 with SMTP id
 f18-20020a05680814d200b00339de9f5df1mr8058440oiw.93.1657566487843; Mon, 11
 Jul 2022 12:08:07 -0700 (PDT)
MIME-Version: 1.0
From:   Gerriko io <gerriko.iot@gmail.com>
Date:   Mon, 11 Jul 2022 20:07:56 +0100
Message-ID: <CALF=2ANR8PBSU3h_RjakdG6Sh3iUyM6CM8QsxzMMhwtLuAWJqw@mail.gmail.com>
Subject: Local Folder was overwritten by old repository due to reset command
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not everyday you find all your work gone and there's no way of
restoring the work locally.

I am quite dumbfounded as to what has just happened as I was working
with git to try and push changes to GitHub. In the process I was
having some difficulties while learning and was trying out a few
things including reset command. The problem is that when working in
the Linux terminal you are unaware of the changes made to folders and
files.

With this reset command there were no warnings of any overwrites and
the deleted files are not even in my Linux Rubbish bin.

How is this possible - this bypasses all the most fundamental rules of
a computer OS!

Surely there are ways to avoid this especially as default behaviour. I
can assume with flags you might be able but as default there needs
flashing lights for noobs.

BR

Colin.
