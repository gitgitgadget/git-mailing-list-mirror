Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775121F404
	for <e@80x24.org>; Mon, 13 Aug 2018 14:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeHMRUT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 13:20:19 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45820 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbeHMRUT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 13:20:19 -0400
Received: by mail-ua1-f65.google.com with SMTP id k8-v6so9397541uaq.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tvqpSpJ7wj9YQyAM9ZrYFfy75G0+Ixu4re9BoQAT58k=;
        b=PmeHwssGq6FpExcj0kalPZcDjkcPcpQ7VAF4C0VqXi7NcwHsSujeaxWgU35ZgDsF1i
         4iOle/vsL8Bectk91kUQ6lrRvo0C+9xZneI6fF8vhEisPl7AhdaDIy6+B81i3vJTEXzT
         eWFf+0brboVS+x9C3rb/yPMza9L5Av1WU72SKxZGzqOlUAoDqmsMkfPw65fnTVew4C5B
         szkLzNVs3J/UP8zVSe/DTWvuo8lnogD/TEC/vShwuJpjQbEv7/ogM6kPIlRQfylq6WB6
         WceptffdSAVdIvaDAjjTIsefoukp58VhyNw2aZ+lSSLIusVNmLLw1WHJ2hvWKxMUDI+x
         F2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tvqpSpJ7wj9YQyAM9ZrYFfy75G0+Ixu4re9BoQAT58k=;
        b=Iy9vZhwBbQpyTUSyLK8xAe2GrAlZh8IJjy5HnqbgHMbPqe5MYHZBapdsxEgZFguxMZ
         emRlJ1ScRP+89nmre+1jTzfNHHfSI+TT6VGAg2ut+Ldx2/6DpDUgZa3LG+m/2l9ayjqX
         lhkvS6kbBmEzoogllmqltjRG6BCr9ZtU9wnbduyfNJ11iM4xrMhzdP5kyircGNEgUNrC
         00v1VabgCDUdLVI5TjRbBcLXGjDOLzR4omd0Y1jf51qC/ALlTY5ZbOX3AokzzlMJxBsa
         UATb1opx8LOwViskrdWg8/Bg2WawWXP/Po4/OQt9xUcJD6pBp1B4PK5o9GGdO4xJnoY/
         GHzw==
X-Gm-Message-State: AOUpUlHf/M8mBdPwf4l3Fs3qKcPjAxkyChGkeTNIKsX/j9/38qa49sfT
        VG/Dm0u1Nra5tZYAe9mqMuP+ce3eLQFlmMbEWWE=
X-Google-Smtp-Source: AA+uWPxrkU4o5ejVUbQS+0mrTOcLUlN93LR1lXDonH2bUEATXMOrt4BerxUxaY+vED5tXDXU8zVrHkkZV4Iykrm4LBE=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr11756916uac.154.1534171066384;
 Mon, 13 Aug 2018 07:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wscc=TKnWc+Dtq6U=EFZKWEd-0afwFD+mmfR53rA9Ts9toDA@mail.gmail.com>
In-Reply-To: <CA+wscc=TKnWc+Dtq6U=EFZKWEd-0afwFD+mmfR53rA9Ts9toDA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Aug 2018 07:37:34 -0700
Message-ID: <CABPp-BHkD0Va_Mm+sFDyBH3gwCuR6UD-b3C07YcdS1x3QCzsRQ@mail.gmail.com>
Subject: Re: Bug? Interactive rebase with reword after conflict
To:     daniel.voros@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Aug 13, 2018 at 5:26 AM D=C3=A1niel V=C3=B6r=C3=B6s <daniel.voros@g=
mail.com> wrote:
> Hey All,
>
> I'm seeing some weird behavior when doing interactive rebase of a
> single commit with reword if there's a conflict. The rebased commit
> gets "squashed" into the target commit and is not a child of that.

This was previously reported by "ch <cr@onlinehome.de>"[1] and fixed
in commit a9279c678588 ("sequencer: do not squash 'reword' commits
when we hit conflicts", 2018-06-19).  This commit is part of current
master, but has not yet made it into a release. So, sadly, we don't
have a version you can update to to get the fix, unless you want to
build from source and either cherry-pick the change (it applles
cleanly to 2.18.0) or build a current version of master.  However, it
should be part of 2.19 when that comes out.

[1] https://public-inbox.org/git/8e28202a-8646-53e8-8c22-389d61791c70@onlin=
ehome.de/

> I've asked this question in the git-users group first a few weeks ago,
> but got no explanation:
> https://groups.google.com/forum/?fromgroups#!topic/git-users/1X15nAts3mg
>
> Please refer to the link above for detailed repro steps (reproducible
> with 2.18.0).

Thanks for reporting, and sorry we don't have an immediate solution
for you.  It's coming, though.

Elijah
