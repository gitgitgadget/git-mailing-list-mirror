Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B59C20248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfBYUWH (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:22:07 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37022 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBYUWG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:22:06 -0500
Received: by mail-ed1-f49.google.com with SMTP id m12so8710032edv.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ynEXk0SE+WrngTo/yfdXp8XoAovqYPzTUGOmggoNYTQ=;
        b=W2QR+pcnK4mS9r3BhEAWjm3DV+4wWTsY8uOXMuuOmefcQe2J1f9YsDwIyKa0FwKZrF
         nXwVfLB9Gu47GHScH/ZOZZOiRhWJKZ4NXmvDsqb0LRNsiCCsuZcb6ZA2Xfy+ugiakNHF
         /8SWmqWUMoYQ/traNJuL+pPf3j5mdDVOhYNZhCKVNPpPO/oOaUo6aEHgylk1czfYPR/Z
         sHtYR6B0jNNDxOLLdZn40l5bVHOSYnWpeI9bIfXy4FGFZJP6dDSpIDZFwmvS+EK9dVkS
         0/8h4BBgIhEqpb+8BfHsjDILkoLxqqQyPumDQlRSJwnEUYXtXuTM9+XPA/6+rr02rfbz
         5UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ynEXk0SE+WrngTo/yfdXp8XoAovqYPzTUGOmggoNYTQ=;
        b=CT2IAgvrEeRt6WlzrLyWgdrsuB1VBd8cWhGqk6JGtEd2FdJZ7hswQdLmcV3TzQyK3K
         /mBT+PPGeP1DqrhBcqVTJdtPBaVQSoEJaioGS3uQa/2JmS5tbONjj2HMSYbaM/eEWJ+q
         /TuQoybx8IGOyz/q+5grkt6VDItmT2lT3VyYFM7CiBoGTo6PJMtvhqheRwAtiKs/Nt4a
         OsQk0DRLmhmjY+UOubtdAXjaN5O5IHX4V6cyMocURoWb1Hs+09ZF+bR+pnnc433vpsJh
         jwW2I6x1ATFWJf7FXHYBdDYJkp2DV+ewhHQKdMcI/nMIy9Xp64JSIIUU3bMN+/Sn0aVa
         fLxw==
X-Gm-Message-State: AHQUAuZx1s1QhXh3IWqRWFq0U2XWVgXYO4dHRlXHCDiswpi1JnSd/hkb
        J+fjJJRLClre8fB94kvYP/j7GQIUPULmjKhO4Oo=
X-Google-Smtp-Source: AHgI3IaaxvorQPqF66wpAp7zusiL7VSg9SlZls6DWKEZvdQopJhDJst/35AaNTUP2wy1Gsm/4RJOzFSPAxobF4S/YmM=
X-Received: by 2002:a17:906:3d69:: with SMTP id r9mr14389644ejf.92.1551126124691;
 Mon, 25 Feb 2019 12:22:04 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <CAP8UFD1U+4ww8rC=TSjjH+Rt77P9w4YWA9s5yspVZ7GgPpx0pw@mail.gmail.com> <CAL7ArXqrV7qb29i6JvQdeUtLNX9A7WC0-deKMx-_6pQUpaqSJA@mail.gmail.com>
In-Reply-To: <CAL7ArXqrV7qb29i6JvQdeUtLNX9A7WC0-deKMx-_6pQUpaqSJA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Feb 2019 21:21:52 +0100
Message-ID: <CAP8UFD1wK+goi1rKGjABcs01VwYw2kEma95n08H1EWVT4vh6ng@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Mon, Feb 25, 2019 at 12:36 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Hey Christian
>
> On Mon, Feb 25, 2019 at 12:20 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>
> > In addition to what Dscho (alias Johannes Schindelin) wrote, please
> > just send one patch that replaces `test -d`, `test -d` and similar
> > code in only one t/tXXXX-*.sh file. No need to do more than that.
>
> I don't think I quite understood this. Were you asking for replacing
> all `test -X` calls with `test_path_is_*` calls in only one tXXXX-*.sh
> file or `test -d` calls with `test_path_is_dir` in all tXXXX-*.sh? As
> of now, I've changed almost all `test -d` in all relevant tXXXX-*.sh
> files.

First on the micro-project page
(https://git.github.io/SoC-2019-Microprojects/) there is "Please
attempt only ONE microproject. We want quality, not quantity!"

And the description of the micro-project you selected is:

"Find a test script that verifies the presence/absence of
files/directories with =E2=80=98test -(e|f|d|=E2=80=A6)=E2=80=99 and replac=
e them with the
appropriate test_path_is_file, test_path_is_dir, etc. helper
functions."

This asks you to change only 1 test script, that is one t/tXXXX-*.sh file o=
nly.

So yes I am asking for replacing all `test -X` calls with
`test_path_is_*` calls in only one tXXXX-*.sh file.

Thanks,
Christian.
