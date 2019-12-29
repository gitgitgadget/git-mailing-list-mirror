Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9395C2D0D1
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 22:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF84620748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 22:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYDUbGkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL2W14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 17:27:56 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:42118 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfL2W14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 17:27:56 -0500
Received: by mail-io1-f43.google.com with SMTP id n11so23335108iom.9
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ClXNTs4g7BYyh8+39pJ+sBVotYhxOnYbMmCUvYa92F8=;
        b=gYDUbGkGehr+ofHtzZkFb6jViJpZzk3u7APHANxFGxYccjN+HjcqPddLDGuzIlNwp7
         bMfu+kqV7f5m8ck7mwsBYHM8/Sy3BP9QYWU6Y1qPrQUL2dFQ/7WsbBLnIp5pg8EqcQGQ
         gOhryWDim1WO96QdqyZ3BKenxfqclsjKfIawx6Qp6stvdY6VuWPNM8F20ZhJnjNit2Dq
         oIyzvr1oY7BSYyz7Se1MSBtoFQxz0gkb76MaJQzxB4G7HmLcahIuj+gvDjcMbnz2gZFd
         IkBMr1bhBmnq3u+gKc2HOIF93CA56GV6JMY4qBRVp26oZnfPR5nMSwjJ0dofDagm75zH
         /m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ClXNTs4g7BYyh8+39pJ+sBVotYhxOnYbMmCUvYa92F8=;
        b=U9ERFOaDjQ7H3nugYD5zkhb+08N+uqnJJSRvJ7idu1JTtUJN1dXDDBNanj0pBdpxwo
         HvI2fnGX6zdXe6+JfQSmotVaKZWrb72d3EC15Pr3XzGYwuKkPOKSpb37lH0GAMA9EBC4
         1cKIjjVxbYMOlfjMXzEJI7096O2G73cWv9QMtQCgXAW0XHYf/l4bLYrYjT+7nOBXZ7Fz
         gGkdegLiCJnINksj9iP0DG2hdgXC1qoGZPjV5Ivk0wxySmjRjgfQF5y19bIVrZQKv1HX
         G9BojrGialGXlgEEyfB+hOBgMjETnRUpnQKAsSuzmmNT95uHRAKz3/PQrMTVMNsqjrx1
         8iRA==
X-Gm-Message-State: APjAAAUPwYrn4SZD55iu7oTzGvwJjCbh7dDnUWWZgEy6tRVZZhi1/5MG
        +GaPf3zuw5KTeU1i0xIrbF9TkPkjf+n6B1jwI6Gvf6us
X-Google-Smtp-Source: APXvYqxn/2mO8sK4SyPlbJDkL5DgDSifsA93S4H5MwdwMzicrmX3QVO33zoc8caghZZM8B6MEHuxZQBkymRHxWDb3Ts=
X-Received: by 2002:a5e:c205:: with SMTP id v5mr42447913iop.41.1577658475595;
 Sun, 29 Dec 2019 14:27:55 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 29 Dec 2019 17:25:06 -0500
Message-ID: <CAH8yC8kwsnnvmo2Oyx-NDN17KGWTgDB+_CwNqsqJQWWe47sf3Q@mail.gmail.com>
Subject: Autotools version
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm trying to build 2.24.1 from sources. It is failing on an old
Fedora machine with the error:

    Autoconf 2.59 or higher is required

The irony of Autootools checking version numbers is not lost on me
considering I only run configure, make and make install.

Would it be possible to drop the Autotools version back to earlier
versions of Git?

Jeff
