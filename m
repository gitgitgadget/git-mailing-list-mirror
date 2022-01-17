Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D955C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 01:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiAQBlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 20:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiAQBlN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 20:41:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92B2C061574
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 17:41:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p27so40176828lfa.1
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 17:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=A2GvizRfFhRAojGAA2J8NyWRmysjZ6Nym2Lz1sy9n9w=;
        b=M6HZ7yiqD4LaRMEEYisTSW9I/BuYV4e73AHTSvtdWTU6ae9rks6fWhx+MZV4/GYTff
         YAuHL00iWhG+8XvDqIxwGAJ+ha1XvD/h54w+z8ujK0THWQ0Ep4/kCNuLdIO7P3xFa1S3
         1ltg4abq58DTqq+WqxfBPY0TUg7F+lzWMxTO8E1jc/i5WCF0oWBmB1NVATn4c8ixt/wR
         OCJtvPbBbMkU+gxg/99BiSDVkneDeK+luNjdtgo1nUvXyAymDyD3K1bPOkEfgUWMsLXB
         l+pL/7ozeEdcMoXfv1Ho6YukxqndKkRI/vWvUcpyrj9Wzue9NmjQxZeS8HEZfusihxgF
         eZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=A2GvizRfFhRAojGAA2J8NyWRmysjZ6Nym2Lz1sy9n9w=;
        b=ITRi1RRWd6pP/LiWddXQ4BW6ty4HM84Ol0pN8BO8SJVkuWiuk6ehwlKpkL3ULYugIv
         QRUCDZ6V/os82/4gYs/qraytzU9h3KReNNRfTZDTWyQyYl9Rc+ZguRuQCnQJ34Aubzdk
         ik6lvAUCBAX6DXOw0NDbM2Jo2nYkWut3ZvPRup4bTzSuXvhU/mnjL0oq4jvgghJNMyqk
         I9v1/XLbr9g999cyJi2RTajgvjGwBnjqrKhenDe+/3sDTf6awDwpb8lNyFomJdq8125h
         ppEAESOmiUBlVsO+u770lcQW7fWtE7JxZE6B3qkfWV6fENvOh3UXVtnu0ZfaSXekNCp/
         R6Xg==
X-Gm-Message-State: AOAM531sE8ivJlV3xtHDiAth1EsVBDCEUpgIkToWfMUsoajgodQnuu/E
        5EHU8pl82W+SYLoHcAZBC+dz2QX2qboEwdHuZDyuDDKaE7M=
X-Google-Smtp-Source: ABdhPJzk86VVR/BZVjiBdptJpmDmPY4c4XkYzMnSmzbYJM7Bh/YtOmjgGNBw+Ioj6wIqEBgqG4y76b0oNFXETkT2VGA=
X-Received: by 2002:a05:6512:32d5:: with SMTP id f21mr4091396lfg.17.1642383671027;
 Sun, 16 Jan 2022 17:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20220111062609.23926-1-worldhello.net@gmail.com>
In-Reply-To: <20220111062609.23926-1-worldhello.net@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 17 Jan 2022 09:40:59 +0800
Message-ID: <CANYiYbH-vzWLDp7+53GOcKoDaHZ61FJ=hHvm3w3FW0gsRZYrtA@mail.gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.35.0 round #1
To:     Git List <git@vger.kernel.org>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 2:26 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> Hi,
>
> Git v2.35.0-rc0 has been released, and it's time to start new round of
> git l10n.  This time there are 126 updated messages need to be translated
> since last update.  Let's start a new round of git l10n based on commit:
>
>     79aed79241 (l10n: git.pot: v2.35.0 round 1 (126 new, 142 removed), 2022-01-11)
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>

In git 2.35 l10n round 1, a space between two words was missing in the
message from "branch.c", and it was fixed by commit 68d924e1de
(branch: missing space fix at line 313, 2022-01-11).  Now with a small
update to "po/git.pot", let's start git 2.35 l10n round 2.

For l10n teams (bg, fr, id, sv, tr and zh_CN) that have already
completed their works on l10n round 1, I made a batch update to fix
it. See commit ee27abd30d (l10n: batch update to fix typo in branch.c,
2022-01-17).

** Please note that the update window will close on Sun, Jan 23, 2022. **

--
Jiang Xin
