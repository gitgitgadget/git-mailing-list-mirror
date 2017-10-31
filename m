Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5AB20437
	for <e@80x24.org>; Tue, 31 Oct 2017 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbdJaTQk (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 15:16:40 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:53118 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932874AbdJaTQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 15:16:32 -0400
Received: by mail-qk0-f169.google.com with SMTP id b15so35681qkg.9
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E5h2bmBeWReHcDnoNT2MtaQxzTSxf9sAWgdjU2VnJiE=;
        b=bX1f/8vBZGJEf/dWAcoUq0EDAceSwERl8+FrCPrUCLVEuYw7tVera5B2PcWQRizNPt
         QMqjozahMTp8umMGRsUBc5oftcOCijCo0rK8ofAQsFVSwt80wEtO+8sP10dBGxIzdGTo
         MGgktJsHx0/ry1k7/x7c1/SFmfv4/sETBlUyZ682LjaE9LGMjje1M2pxIOsZAAM6OQLW
         d8eCEDbTc8h3YlKoMXqxoVD51xNrEztZqTpcf0l1tSdERf2ENYtT9E8+Taxufl/wieU4
         muqoybY0Wv5RC/aNHGBScG30dCLE2Ku9zUA4yJn5vU7Shoc0VLiez2S7oTKWzexUF0x4
         ggvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E5h2bmBeWReHcDnoNT2MtaQxzTSxf9sAWgdjU2VnJiE=;
        b=RiqyCajtvoi3ZgrXTH7TejrJ5xRnYk/cWAubdJe3ITIEeEqM9ouwNsZ3bJHxqreGGT
         aah3C816az3VnRXoLOaSut9kgPiFy4eTjSITDZF5TlMVgG8lwRmI+GQupNssoTG/97GS
         N3uAnHn/QwmbfZtLFJ7KOHgxsJgtgLD3cP6k2JUmrif4GngvuAmfjlomt6CRTXy5yLsb
         3mP2gJaBLFEqkicycBsXE2G4LPcr6nXp08zj+izR9XySoZ4RhoYcU/mKCy2DVe1WiCp2
         aNJAjax1BAlI19cbD3pX+ANZeT/i5h0rerpGoDh4kfAbt2MRUSfz8+a9W3YWkh8/x9ML
         MVng==
X-Gm-Message-State: AMCzsaXkMu7/Nr0suV9MW7x8j2o41T/GTAUx0pXrN7UoUqqkG6yMYPV5
        vD9tfPGqeDuGg1S8ZI7i5BuI+j3566Frp092F8E5jOCyK0Y=
X-Google-Smtp-Source: ABhQp+RaHFvoT7gDZLmuif9WASP3BpdfiOd9OwNvvNBfPhio4laJVdzADRVbQ3CPUHaTlKkKBoqdQ6rqCRkmd7PVGYg=
X-Received: by 10.55.111.3 with SMTP id k3mr4271171qkc.332.1509477391361; Tue,
 31 Oct 2017 12:16:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 12:16:30 -0700 (PDT)
In-Reply-To: <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com>
 <20171031003351.22341-7-sbeller@google.com> <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 12:16:30 -0700
Message-ID: <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 11:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
>> index c924c945ba..3d618b2445 100644
>> --- a/Documentation/git-describe.txt
>> +++ b/Documentation/git-describe.txt
>> @@ -3,7 +3,7 @@ git-describe(1)
>>
>>  NAME
>>  ----
>> -git-describe - Describe a commit using the most recent tag reachable from it
>> +git-describe - Describe a commit or blob using the most recent tag reachable from it
>
> If I am not mistaken, this series is about describing a blob as a
> tuple of a recent commit-ish and a path in the tree in it.  Blob
> never reaches anything, so "desribing blob using X reachable from
> it" is a mere nonsense.

Agreed, though the commitish used for the blob description may refer to a tag.

> The original is not great in that it ignores the "--contains" mode
> and referring to "tagged commit" merely as "tag" for brevity, but
> at least it made some sense.

Maybe

  "git-describe - Describe a blob or commit using graph relations"

though that sounds too generic, but it is accurate as all we do is
a heuristic for graph walk ways.


>> @@ -24,6 +24,16 @@ By default (without --all or --tags) `git describe` only shows
>>  annotated tags.  For more information about creating annotated tags
>>  see the -a and -s options to linkgit:git-tag[1].
>>
>> +If the given `<commit-ish>` refers to a blob, it will be described
>
> Perhaps this step should update the SYNOPSIS so that the command
> takes not just commit-ish but a blob too.

That is a good idea, as the --contains would not work for blobs currently.

>  Given the difficulty in
> coming up with the single-liner description of what it does we saw
> above, I suspect that splitting SYNOPSIS out into two very distinct
> operating mode might make it easier to read.
>
>     SYNOPSIS
>     --------
>     [verse]
>     'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
>    +'git describe' [<options>...] <blob>...
>
> Then this additional paragraph can say "When describin a <blob>",
> without using a (technically nonsense) phrase "if <commit-ish>
> refers to a blob", which is never true.
>

ok, do we know about 'blob-ish' as a term?
