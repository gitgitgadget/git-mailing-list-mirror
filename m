Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039FC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDDC206D5
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQyh6rcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAZREI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:04:08 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:44102 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAZREI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 12:04:08 -0500
Received: by mail-qv1-f44.google.com with SMTP id n8so3405499qvg.11
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vZJzG+iHJ3q3jdZxLP9xzzc9hHlRQmRE9bYaFFFGd10=;
        b=KQyh6rcHy71P5gfQKES1lS8ujveTnXYxje2GZDNuCQqNuA5MeLcMY0pEfkInRLhCUA
         QDgz2lEUkZVkalDYqhuEOhx3coJJbXXMnqCcCw/vy1nOqkQkRltyzsvv9U7tHJIZLCkZ
         5JKmSb8CDdNukJ9Ba9UR0jjziQhuDiCfqbAnEmxEVouXRVygQ6QV5OC+dNeaO1+sH9dg
         tehWR91M88eiczFvFDclUGPlS9QwLggp1CmZChaYBaS3vN8wu5MGEUZWip8Zxk8APwJt
         UabCyReIe+g4Wi9OOqtq15s3xoOzzGbid4CmDLz/KX748qIrDzfLJ0xg8/74HcVambmR
         eK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vZJzG+iHJ3q3jdZxLP9xzzc9hHlRQmRE9bYaFFFGd10=;
        b=mwD2X+/Drc6qmNzNl7a2Fn/mVnyQg5/Gz4X1dNdVnPXMPs9zaSIOo210Geo6TZ/lcH
         VUEoWpD3uBkiHvDNxmO2KtE6eRuiFDD8hWd5XEJ2QBzIHSPlekv2OSfOqgzAh/gu4iDp
         x6/Rrh7c83tPmo7QBYaNlH75ADy498tvsGzWsT2DG2/DWJ5/S6wO8HgVliZhARu/Hosa
         pIcs0actAJe7H9R5r6YNUmJv3fCiSunGYezXS7acnITx4J0a4KMsbZBVsoia2NNKfmrT
         9NRrv42CV0oVBJFRSRwthTGrK0jkXOtsB33KGsFFzE6d7syAI77WjX568C+dPbbKoJYD
         1Lyw==
X-Gm-Message-State: APjAAAUHRjGJbyx8phduOX7h1eFbDMv4VjfazzIdBkvV3Q22eaaiXoNA
        UDGVxXeJOM+PnBh3Z+JAXllmc2yxQBMl8i+Uo/c=
X-Google-Smtp-Source: APXvYqzABl8THelug9ieZ521rqMUJxNtHU1UrPzvT5cun0sUU/fX7nJOf1BpMxcxWVto4YXFRNudyScMccruTJNKL8c=
X-Received: by 2002:a05:6214:11ab:: with SMTP id u11mr12664506qvv.193.1580058247392;
 Sun, 26 Jan 2020 09:04:07 -0800 (PST)
MIME-Version: 1.0
From:   abhishek kumar <abhishekkumar8222@gmail.com>
Date:   Sun, 26 Jan 2020 22:33:22 +0530
Message-ID: <CAHk66ftG_XRLBrfDtKERKcZyB-UOOcOnh=aV19+5PEXZFWMYvA@mail.gmail.com>
Subject: Re: Question about private repository
To:     deepakpaliwal2013@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Deepak,

The queries you have related to GitHub [1], a company that provides
hosting for software development version control rather than Git [2],
which is a version control system. It's a rather common mistake. As
for the answer to your questions:
1. Yes, but I cannot find any relevant resources for it. Revoking
access does not alter commit history and your email should still be
visible, thereby GitHub could show the username and contributions.
2. Yes, as per the criteria detailed on Github's help page. [3]

Please redirect any further queries to the Github community and support.

Regards
Abhishek

[1]: https://en.wikipedia.org/wiki/GitHub
[2]: https://en.wikipedia.org/wiki/Git
[3]: https://help.github.com/en/github/setting-up-and-managing-your-github-profile/why-are-my-contributions-not-showing-up-on-my-profile
