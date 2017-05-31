Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF211FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdEaSJQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:09:16 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:36790 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdEaSJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:09:15 -0400
Received: by mail-it0-f52.google.com with SMTP id m47so18373274iti.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Coc6AIHyynNFgFavkeMTgEh6EMYuoeeNX2C+5B6oSYU=;
        b=dyh2ts5Hl/2Czd2dAcRZ3r+GK8JHxTtXM+qFaPt+e8P/FcAzr5f/BhTobdn7Kyc8Ps
         jQdCtkqpicZ+2ekuJbNi0y593vadhOPOWakwjznZxT0iVS7Z+oCVSYr0uVZI+ad9Ugl5
         eSOx7BDDDWDUJ9OkY7DUV1LgqG1KHRkHJGsfSGgoOya9kc70xV4kX97l00284ozCG3OR
         k8gpCohFQtVBbcu+21X8CzlqWqnfeeNWCNOdONzI0N2MMof6sivWadxiTv9gwkMKLwk8
         9lSJBNH/i9oweeK/D4jbdfDb7Xqs7nqs4Zak8/mH0pH93vtt0Q7gQiDiczc6RJQ7H1P4
         RoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Coc6AIHyynNFgFavkeMTgEh6EMYuoeeNX2C+5B6oSYU=;
        b=QfddK6KqEGyc/HqLmDuG7Oh7R4w5ZSBA3mTxn+TIvtDUtqRuC9S5V4mBNJUoJ5jS8j
         fUK4EbxVmQCxkB9mrrYMy3Bjsx7cErFINpKp0sUQiccOpKS3l8nJAWUJ1OhwbZ5OSRpn
         KisT0Pen/sn/82BTketOEeCXAM0Ab21xhsHbY1H4fwr8xmQzHK5+7UKs4aoUzUTaXb/k
         PIUwuWhed6qTKcQ8tYQah1hN+HaMN1vTQJ4G/yZpT6kf25nJktMagBCDT7U2hZ7flfex
         cnY16lzCYj5yznQrzcb7UMlPBYAx54z1MKQvq8FNiaOUb7CMx7DyFmfsiwin3lLS6vba
         Zpag==
X-Gm-Message-State: AODbwcDsX7KLtmD+JGqQEcPn+/Ot7130J+G7l8OlEodtmbs9j+E7eOb2
        j4qOCLVUZsfOtalVE46/wiBU3mt4RsProCk=
X-Received: by 10.36.138.131 with SMTP id v125mr8538121itd.66.1496254154909;
 Wed, 31 May 2017 11:09:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 31 May 2017 11:08:54 -0700 (PDT)
In-Reply-To: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
References: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 May 2017 20:08:54 +0200
Message-ID: <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com>
Subject: Re: bug: `git log --grep ... --invert-grep --author=...` negates /
 ignores --author
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 5:45 PM, Anthony Sottile <asottile@umich.edu> wrote=
:
> Given the following commits:
> ```
> asottile@asottile-VirtualBox:/tmp$ git init test
> Initialized empty Git repository in /tmp/test/.git/
> asottile@asottile-VirtualBox:/tmp$ cd test/
> asottile@asottile-VirtualBox:/tmp/test$
> GIT_COMMITTER_EMAIL=3Dfoo@example.com GIT_AUTHOR_EMAIL=3Dfoo@example.com
> git commit --allow-empty -m "foo"
> [master (root-commit) c9df62b] foo
> asottile@asottile-VirtualBox:/tmp/test$ git commit -m "blah" --allow-empt=
y
> [master 9e3ee9b] blah
> asottile@asottile-VirtualBox:/tmp/test$ git log
> commit 9e3ee9bc1adab2ae8eb1884a8f6237da18dfd27b
> Author: Anthony Sottile <asottile@umich.edu>
> Date:   Wed May 31 08:40:59 2017 -0700
>
>     blah
>
> commit c9df62b93298a247fcfbe24ed4282ccf95448f47
> Author: Anthony Sottile <foo@example.com>
> Date:   Wed May 31 08:40:49 2017 -0700
>
>     foo
> asottile@asottile-VirtualBox:/tmp/test$ git log --grep bar
> --invert-grep --author=3Dfoo
> commit 9e3ee9bc1adab2ae8eb1884a8f6237da18dfd27b
> Author: Anthony Sottile <asottile@umich.edu>
> Date:   Wed May 31 08:40:59 2017 -0700
>
>     blah
>
> commit c9df62b93298a247fcfbe24ed4282ccf95448f47
> Author: Anthony Sottile <foo@example.com>
> Date:   Wed May 31 08:40:49 2017 -0700
>
>     foo
> asottile@asottile-VirtualBox:/tmp/test$ git log --author=3Dfoocommit
> c9df62b93298a247fcfbe24ed4282ccf95448f47
> Author: Anthony Sottile <foo@example.com>
> Date:   Wed May 31 08:40:49 2017 -0700
>
>     foo
> ```
>
> I expect the same output from the last two commands, but the
> `--invert-grep` one seems to match _all_ the commits.
>
> I can try and dig into this if I have time, just trying to get a count
> using this as a workaround
>
> git log --grep ... --invert-grep --format=3D%ce | grep ... | wc -l

I had to squint a bit to see what you were getting at here, which is
pretty simple: When you provide --invert-grep the --author filter is
completely discarded. This is a bug.

I.e. on git.git:

OK:

$ git log --grep=3Dbar --author=3D=C3=86var --pretty=3Dformat:%an -100 orig=
in/pu
|sort|uniq -c|sort -nr
5 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

$ git log --author=3D=C3=86var --pretty=3Dformat:%an -100 origin/pu |sort|u=
niq
-c|sort -nr
100 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

$ git log --grep=3Dbar --invert-grep --author=3D=C3=86var --pretty=3Dformat=
:%an
-100 origin/pu |sort|uniq -c|sort -nr
     78 Junio C Hamano
     14 Jeff King
      2 Andreas Heiduk
      1 Sahil Dua
      1 Rikard Falkeborn
      1 Johannes Sixt
      1 Johannes Schindelin
      1 Ben Peart
      1 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

That last command should only find my commits, but instead --author is
discarded.
