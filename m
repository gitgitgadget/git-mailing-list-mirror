Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8E21F404
	for <e@80x24.org>; Wed,  7 Feb 2018 15:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbeBGPIT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 10:08:19 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34898 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754436AbeBGPIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 10:08:09 -0500
Received: by mail-vk0-f65.google.com with SMTP id n132so725732vke.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+O64kNXbnS/Y2/0cWpN6VyxkXc+sLEIh/cnndPuvfCc=;
        b=uKc6OfQnBlaRLXNaaLa2b/jT5Y0WB23cRbHMbniGFegRBppL804Jx+AQSp8co70L63
         MeFPkmPvszpPIqGL3zQK5TGLU3OHR0SaPWmwi4hK+DPW8EAdEzQxS5PvjYkTFkSGatro
         akbcriR3s8neKdTCwhb3t9K8rvXJrg7PU3PAfYA56y1wGWwYmoH9C0udKHtbhL0oL8le
         tP4bOdLjiU8oBFH0mbSt0RNtQaDb0uUeUzznd/KcinVHNpqojAE5YgjnkiFXFXKJU1BN
         ejGyoZB1oT0EZgZzTpez6yiC+G3bnn+FJuSXa2vBNtbAcSST410h+MhFXfWo+oygZrBD
         JuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+O64kNXbnS/Y2/0cWpN6VyxkXc+sLEIh/cnndPuvfCc=;
        b=K8lOf1ejOnptfO/XGXeg6Z9Xi5jmKkiBCV3cxZxxAKEkcYWK/NFHGK6OcxeqplCw9k
         HhxLak9bNg2xfBQkSyUD69ImncZnaYYQJjENGiR9w5NFokaGPYHlrD3HJ0VsLB3gG8as
         7VAaHt72eC8ZCDn0QbL810T5beioOkDNG1oj+BW+5ny+PT00v58s9diRCI5DooSyT846
         jN08jJvGyeOb/TWVmSV8cCGRjdqLBYEACs9vE42vlYwS5RRnPkGPrF560PGd/TlrHxwb
         yOamMOHe3SiMMJgNFhhSOSYTMSk6sIqEafXJk0sSvAy6a0r7PokI89VVZYx62twy/TeZ
         Qghw==
X-Gm-Message-State: APf1xPDxP6zzPptUbYk8tnIAdW+6bA2HDCHwNy71gUP6CVuUoj+R4F23
        hGQQz2cabZHG4feUFKY+09YQ9DXZMliQypysWYY=
X-Google-Smtp-Source: AH8x225yu3WEzHO2bl7Ou9EKSh9/OSr5biO/L/bKAavW//hPi8xMKCNzUAVH9S51u+9wr6zUrBGufrtkKXq85k8jKOQ=
X-Received: by 10.31.190.79 with SMTP id o76mr4480954vkf.12.1518016087838;
 Wed, 07 Feb 2018 07:08:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 7 Feb 2018 07:08:07 -0800 (PST)
In-Reply-To: <b7f45961-35c8-6e13-646c-9574fb5d56da@gmail.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
 <20180202153212.29746-1-szeder.dev@gmail.com> <b7f45961-35c8-6e13-646c-9574fb5d56da@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 7 Feb 2018 16:08:07 +0100
Message-ID: <CAM0VKj=wmkBNH=psCRztXFrC13RiG1EaSw89Q6LJaNsdJDEFHg@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] commit-graph: implement construct_commit_graph()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 5:06 PM, Derrick Stolee <stolee@gmail.com> wrote:
> On 2/2/2018 10:32 AM, SZEDER G=C3=A1bor wrote:

>> In my git repo, with 9 pack files at the moment, i.e. not that big a
>> repo and not that many pack files:
>>
>>    $ time ./git commit-graph --write --update-head
>>    4df41a3d1cc408b7ad34bea87b51ec4ccbf4b803
>>
>>    real    0m27.550s
>>    user    0m27.113s
>>    sys     0m0.376s
>>
>> In comparison, performing a good old revision walk to gather all the
>> info that is written into the graph file:
>>
>>    $ time git log --all --topo-order --format=3D'%H %T %P %cd' |wc -l
>>    52954
>>
>>    real    0m0.903s
>>    user    0m0.972s
>>    sys     0m0.058s
>
>
> Two reasons this is in here:
>
> (1) It's easier to get the write implemented this way and add the reachab=
le
> closure later (which I do).
>
> (2) For GVFS, we want to add all commits that arrived in a "prefetch pack=
"
> to the graph even if we do not have a ref that points to the commit yet. =
We
> expect many commits to become reachable soon and having them in the graph
> saves a lot of time in merge-base calculations.
>
> So, (1) is for patch simplicity, and (2) is why I want it to be an option=
 in
> the final version. See the --stdin-packs argument later for a way to do t=
his
> incrementally.
>
> I expect almost all users to use the reachable closure method with
> --stdin-commits (and that's how I will integrate automatic updates with
> 'fetch', 'repack', and 'gc' in a later patch).

I see.  I was about to ask about the expected use-cases of the
'--stdin-packs' option, considering how much slower it is to enumerate
all objects in pack files, but run out of time after patch 10.

The run-time using '--stdin-commits' is indeed great:

  $ time { git for-each-ref --format=3D'%(objectname)' refs/heads/ | ./git
    commit-graph --write --update-head --stdin-commits ; }
  82fe9a5cd715ff578f01f7f44e0611d7902d20c8

  real  0m0.985s
  user  0m0.916s
  sys   0m0.024s

Considering the run-time difference, I think in the end it would be a
better default for a plain 'git commit-graph --write' to traverse
history from all refs, and it should enumerate pack files only if
explicitly told so via '--stdin-packs'.

To be clear: I'm not saying that traversing history should already be
the default when introducing construct_commit_graph() and '--write'.  If
enumerating pack files keeps the earlier patches simpler and easier to
review, then by all means stick with it, and only change the
'--stdin-*'-less behavior near the end of the series, when all the
building blocks are already in place (but then mention this in the early
commit messages).


I have also noticed a segfault when feeding non-commit object names to
'--stdin-commits', i.e. when I run the above command without restricting
'git for-each-ref' to branches and it listed object names of tags as
well.

  $ git rev-parse v2.16.1 |./git commit-graph --write --update-head
--stdin-commits
  error: Object eb5fcb24f69e13335cf6a6a1b1d4553fa2b0f202 not a commit
  error: Object eb5fcb24f69e13335cf6a6a1b1d4553fa2b0f202 not a commit
  error: Object eb5fcb24f69e13335cf6a6a1b1d4553fa2b0f202 not a commit
  Segmentation fault

(gdb) bt
#0  __memcpy_avx_unaligned ()
    at ../sysdeps/x86_64/multiarch/memcpy-avx-unaligned.S:126
#1  0x00000000004ea97c in sha1write (f=3D0x356bbf0, buf=3D0x4, count=3D20)
    at csum-file.c:104
#2  0x00000000004d98e1 in write_graph_chunk_data (f=3D0x356bbf0, hash_len=
=3D20,
    commits=3D0x3508de0, nr_commits=3D50615) at commit-graph.c:506
#3  0x00000000004da9ca in construct_commit_graph (
    pack_dir=3D0x8ff360 ".git/objects/pack", pack_indexes=3D0x0, nr_packs=
=3D0,
    commit_hex=3D0x8ff790, nr_commits=3D1) at commit-graph.c:818
#4  0x000000000044184e in graph_write () at builtin/commit-graph.c:149
#5  0x0000000000441a8c in cmd_commit_graph (argc=3D0, argv=3D0x7fffffffe310=
,
    prefix=3D0x0) at builtin/commit-graph.c:224
#6  0x0000000000405a0a in run_builtin (p=3D0x8ad950 <commands+528>, argc=3D=
4,
    argv=3D0x7fffffffe310) at git.c:346
#7  0x0000000000405ce4 in handle_builtin (argc=3D4, argv=3D0x7fffffffe310)
    at git.c:555
#8  0x0000000000405ec8 in run_argv (argcp=3D0x7fffffffe1cc, argv=3D0x7fffff=
ffe1c0)
    at git.c:607
#9  0x0000000000406079 in cmd_main (argc=3D4, argv=3D0x7fffffffe310) at git=
.c:684
#10 0x00000000004a85c8 in main (argc=3D5, argv=3D0x7fffffffe308)
    at common-main.c:43
