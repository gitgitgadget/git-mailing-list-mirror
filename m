Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C57E1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 20:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbeLQUbA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 15:31:00 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:44079 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeLQUbA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 15:31:00 -0500
Received: by mail-io1-f46.google.com with SMTP id r200so11013789iod.11
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 12:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fez3rzX5aHqxcD3IyXdjBtKjBOJrNyhve4ilodn8d+o=;
        b=AMWrsXS/8SDWY9qta/n+h1KTRJ46/yAUcaCbY0HiLlREOliDaFcsTkD40uysFyyM5B
         uPPJPrMGDDQI3/tOvqrWfwMaypLZHLHIyg7bZBbryAR8b9MFc0DOEWi3Jb37BdRZH0JE
         QtGRxTb3d51uL6zZvE6Q6JgpZp9CMFBArMUawndY3ZOb1zngGG2LORWUaBOogw1Kcmlx
         IcAh4CbthjTlP9GWD86jodjBSgBPQf7XokvEdcyMAE2ILGy4mzy1Fly4mSMGJAoCtgR/
         rX6o6TR0XlEW0Iq+FsNu4K37tvBOU6AfZmh4nIsaD7UPAZoLF5owOi9JDNNpJFJzbrml
         GB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fez3rzX5aHqxcD3IyXdjBtKjBOJrNyhve4ilodn8d+o=;
        b=m8i1jnEmvILwInYeDrBKLYcXUDrqZULrGyxjdQUlKEC0pRz1SeeCe5RCtNotAsQFpN
         E4O3QMZFKC0YfrAJtfAYbExrUfjzIzMs/11jaIPNZP5qdWDdu+txUIc10qp+ueO/yETX
         1mY2UlHdi8UTGOoITeTauBCBI3FugUJPDLAptcLlfzhAR655pY7rYHIbhbWuhL3CJjNA
         zvnZOH0Jcygr0oLfZ33ayTjdaEVL8IKdabaqS9wUNlK2JSICLO6KVLOthwDVqT6LDCn0
         T/N7ZqjLyJDRBx5rz3TQra0oe6zfj6+9vJyOKcH/l0Qfw0VPbsswn35HfOezVoJj9ddl
         cSwg==
X-Gm-Message-State: AA+aEWY7xdylk7GSzgZskQrC7i1TXBHhZHS5fsdS3x+0kr0L5zoeg7TO
        Vqw6CrWrxgBDnUV5BElio+82LslTDP71kp9g6io=
X-Google-Smtp-Source: AFSGD/WLfyG2MUnzYkG8sHdeZTLaBZpqIrcGpH6wvuS7E7D6rCnJrhpeaUZeH/0hgdve4pL73q/WyFpuK0YSvnp0hAM=
X-Received: by 2002:a5e:d910:: with SMTP id n16mr13362895iop.58.1545078658989;
 Mon, 17 Dec 2018 12:30:58 -0800 (PST)
MIME-Version: 1.0
References: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
 <87ftuz208b.fsf@evledraar.gmail.com>
In-Reply-To: <87ftuz208b.fsf@evledraar.gmail.com>
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Mon, 17 Dec 2018 12:30:56 -0800
Message-ID: <CABXAcUwCrJGTQHwbM0Pg59DudZ6vCtZYJT5W=YJVnGGE3Jijew@mail.gmail.com>
Subject: Re: Git blame performance on files with a lot of history
To:     avarab@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 2:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Dec 14 2018, Clement Moyroud wrote:
>
> > My group at work is migrating a CVS repo to Git. The biggest issue we
> > face so far is the performance of git blame, especially compared to
> > CVS on the same file. One file especially causes us trouble: it's a
> > 30k lines file with 25 years of history in 3k+ commits. The complete
> > repo has 200k+ commits over that same period of time.
>
> There's a real-world repo with a shape & size very similar to this that
> has good performance, gcc.git: https://github.com/gcc-mirror/gcc
>
>     $ wc -l ChangeLog
>     20240 ChangeLog
>     $ git log --oneline -- ChangeLog | wc -l
>     2676
>     $ git log --oneline | wc -l
>     165309
>     $ time git blame ChangeLog >/dev/null
>
>     real    0m1.977s
>     user    0m1.909s
>     sys     0m0.069s
>
> Its history began in 1997, and the changes to the ChangeLog file by its
> nature is fairly evenly spread through that period.
>
> So check out that repo to see if you have similar or worse
> performance. Does your work repo show the same problem with a history
> produced with 'git fast-export --anonymize', and if so is that something
> you'd be OK with sharing?

Hi =C3=86var,

I see around 3s here on the GCC repo, but I'm on a VM and the repo is
cloned on an NFS disk, so I'd say it matches :) It's around 45x faster
than my repo, on the same NFS share and VM. So there's definitely
something to improve here on my end (see my reply to Bryan re: repack
in a separate e-mail).

The anonymized export won't work in that case: all file contents are
replaced with 'anonymous blob <n>', so there's no per-line history for
blame to follow. Let me see if I can post-process a non-anonymized
version to keep the relevant data available.

Cheers,

Cl=C3=A9ment
