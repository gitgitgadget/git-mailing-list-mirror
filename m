Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF531F453
	for <e@80x24.org>; Tue, 30 Apr 2019 11:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfD3LTY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 07:19:24 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44147 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 07:19:24 -0400
Received: by mail-lj1-f169.google.com with SMTP id c6so5895026lji.11
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2u9qVZXXF6L5YkVLYAWDT9nf8EjTS5/g/VbJF5gEKo=;
        b=DfNmyvfMk7lyzJm2AYtsYZLnjUaRsc+KhTTrq2pcqieWpBiFij2HhnWZcllvoyM/93
         YFrqm4bpoHrJ4jkyyrzGjmy8dDEVNLCEykx/Iv8c1AU+xrtXjKy84DQR56TUyBQhiv0d
         9I77AlUAnksD7MH/PyYyp/NL6HVGh6U9DuZBfGqKtklqP09qDAFaZY9TqisFW8nk3Ml6
         QTPaGqFPtR48Ids64Ca6B4UvGzKKdzTyzi30G3u889Slf1NB0YOM8zkW2Vmlj1KTNAQ+
         EQynp0OWjJ+u2FB79oh204n/M1eFLcRFzZqNa1mLPjHwbP+7OxLszQ+6FGTXDCP7Do+j
         d79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2u9qVZXXF6L5YkVLYAWDT9nf8EjTS5/g/VbJF5gEKo=;
        b=Ur0v6Oj4ZlcfzDHApXZvgIvCJ9RjHW6/7xOA2z4kaMVOa3gnyCYVz+8r7k8fIoFzZ5
         JG/5zbhnt1zaLhzVb60Ov6ryD5ifjcOpPEPIOvPaUGk4yjbSF/y/9BKLYFsCJmYjmBSZ
         JlFe7qCcXJN/oyshsy0gzFs06OPoYVhjqn2VFCw3NCzn3sWbNsKSqzPW0usVjG0VgRRe
         3znayMCAolvUTImKerSDcjO0fMlXEUhP53olZj+PUQbkDhLXnZG4vrgG4PR8xJR6uiZB
         O234DRv/oO5ZAqmHqajPpuO7RzzqA7agdJe/4X36pKyP6SfwvLtkPxeg7eIHMhawzfjc
         jQNQ==
X-Gm-Message-State: APjAAAVjx7h0aUcWIZchDJsfBqAPmlp/CmXmoRg8xqYh1lD0E3QcWVqL
        QHlhb1NbBcU2ouuXj3JzU0+yaFDXhwpvqHHbw5A=
X-Google-Smtp-Source: APXvYqwpG4OiGk6L6IgPKrRoxHlVV82BA2YEsC7YuQA/2Qt3hYg7+CiNqQXkFzR+wHV7wcP16bb99mzYTgHM7sZKem4=
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr3634989ljm.62.1556623162187;
 Tue, 30 Apr 2019 04:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com> <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
In-Reply-To: <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Tue, 30 Apr 2019 14:19:11 +0300
Message-ID: <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 29, 2019 at 2:35 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Apr 29, 2019 at 6:03 PM Aleksey Midenkov <midenok@gmail.com> wrote:
> >
> > Reproduce:
> > ```
> > cat << EOF >> /tmp/check.sh
> > #!/bin/sh
> > git log HEAD~..HEAD | cat
> > # sleep 1
> > EOF
> > chmod +x /tmp/check.sh
> > git rebase -p -x /tmp/check.sh base
> > ```
> > If the `base` is far away enough it fails with "fatal: Unable to
> > create '.../.git/index.lock': File exists." at an arbitrary commit.
>
> I gave it about 2000 commits (from v2.20.1 to master on git.git) to
> rebase. No luck.

Please, try on this repo: git@github.com:tempesta-tech/mariadb

```
git checkout 62a082f573
git rebase -p -x /tmp/check.sh ca7fbcea6c4
```

On Tue, Apr 30, 2019 at 12:10 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
...
>
> Does it work if you pass `-r` instead of `-p`? The latter will be
> deprecated in favor of the former in the upcoming Git v2.22.

It also fails with `-r` but less frequently.

-- 
All the best,

Aleksey Midenkov
@midenok
