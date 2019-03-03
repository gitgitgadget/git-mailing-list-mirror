Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D3520248
	for <e@80x24.org>; Sun,  3 Mar 2019 19:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCCTdo (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 14:33:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39456 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfCCTdo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 14:33:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so2496522edc.6
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTK8MYmr4A4JGd0AyySR+odNj5dIzk5qTst+hNQxkUQ=;
        b=UFiJxIJrWUrMj7TJmFR+Y3ONTxLcU/CcNI6DuNVavVhxvcOupNNuUhtdt536c74kja
         gYEQcjOn9/Ul67uTfioNPeBQ8oIZiq6rSyci0tmNo4Oy0MQr/OLWeP9BAMB1oqb9tpG4
         IdRZJUKJdYBFdouItVNYD1hM63D6ukS2XOOuSJufiMyHgyiTqoO97sliIKvGgJNzRexj
         jDilZQNjDp31AfhCI7Al6jBnHS4quUtiuVKCgrc+GWhZVEM9Ucja+YXXQIoxodpzVyuD
         fj5Iz0lN8zScOLMrw4eMDZdOVJHPOZ1LW0fBYIOvl3GHp1dMSzF9+g7ckstin73r88lf
         1PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTK8MYmr4A4JGd0AyySR+odNj5dIzk5qTst+hNQxkUQ=;
        b=gvxjAS/XM0WGquXWBJw6jcQ/Ibojp71pj6iBQtNnVAFMd+72cKc7mMlz7ye8Q3iMT+
         a2sU2Na0n4gHZqKO3GmjzBxfeENDdZybOZIEteQUpfmVvRpPV0HlNPJifmFw5HGUFFuj
         tXr6jJEKCEYvGKMttsvLk4QEVwflff5jIXt/6uZua9s/XKfOc1knxz/owk2WrulRV/gY
         +YkEfeUuW0Lh36tHqqk6TIY+3zaIvbuLsaT0AGAhzMeCQDwBD32SySczxfnIMM3pWAus
         PnY4Qivq7Tk9lE4fJKJa3XuCQ+b6K5nfUSw62d5qDgA81jio2OBIkIYLrWSYdciJUurp
         wJ6A==
X-Gm-Message-State: APjAAAUwGqCud3bEVfZGxdNCcx1+q5jCc0/LX3clQ8514Y+Pzp/jF/CM
        TlYXU8iQ8CReqnAuK+UZaolz3X12rVIoZhKjsHw=
X-Google-Smtp-Source: APXvYqzr2uvfgmlzYjsNGFDIOKn5LpEu/urm6o770f70hZXFD94g40g7bP+tS56SpROvb+fYfXNI2G2nieqLP4oli7U=
X-Received: by 2002:a17:906:a402:: with SMTP id l2mr3584053ejz.158.1551641622299;
 Sun, 03 Mar 2019 11:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20190301175024.17337-1-alban.gruin@gmail.com> <20190301175024.17337-5-alban.gruin@gmail.com>
In-Reply-To: <20190301175024.17337-5-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Mar 2019 20:33:30 +0100
Message-ID: <CAP8UFD1HBbOX7wS664vBT8mxjGUJ4rtWYYJJX9RQqhN20-T8uA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_PATCH_4=2F4=5D_name=2Drev=3A_avoid_naming_from_a_re?=
        =?UTF-8?Q?f_if_it=E2=80=99s_not_a_descendant_of_any_commit?=
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 7:11 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> A ref may not be the descendant of all of the commits mentionned in
> stdin.  In this case, we want to avoid naming its parents.

Properly speaking a ref usually just points to a commit. It is not a
parent or a descendant of any commit.

Also if the commit, let's call it C, pointed to by a ref isn't a
descendant of a commit, let's call it C', mentioned on stdin, then C'
isn't a parent of C, though I think we want to avoid naming C' from
the ref.

I think it might be clearer with something like:

"The commit, let's call it C, pointed to by a ref may not be a
descendant of all the commits mentioned on stdin. In this case we want
to avoid naming the commits mentioned on stdin that are not parents of
C using the ref."

Or is there something I misunderstood?
