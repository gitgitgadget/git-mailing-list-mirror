Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2149202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 19:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936760AbdKPTeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 14:34:20 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:42028 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934962AbdKPTeO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 14:34:14 -0500
Received: by mail-qt0-f172.google.com with SMTP id 31so341832qtz.9
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 11:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MgpfV5157Gh0aGFqD3EwvCBqgiUpic4LUApPaMyeGXo=;
        b=PyuojGviitYqdy027+K6sPGBT2IhldP8WSqCJRtEjvY7UwpG4VLjfFW+n23Axmv+so
         hI0vocd5uW6xFWNI2zwblYL97FxLnVsHiG4MxdYZKhDiHHwrO/LLSyZ4Ze67YtozM3ZR
         npmPRi2kNHt7zFnld+cRmxCNJb8cznbr88/XWwnXeGsEPF//2ApuYnN0SAGEf6cmXGEe
         h4la8MCe4vBKmvOgXoD5GLFSiWV5Utym2kvzUF9KcuP9VEtGzdy5xqVlpmwMbqBpUT+w
         fVZxWl3lj8uY7zsbAWFab5N6IhjNdaL2ykrgu7qvywV0SZ9DdVFO8cxcixsHF4n6Wh6t
         +y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MgpfV5157Gh0aGFqD3EwvCBqgiUpic4LUApPaMyeGXo=;
        b=URRQCEqcYNOGm0x67KGsS76Lj9c8XKtjb5zjQc63FvNcyyF5LQlFs/p1QVebWYgLzL
         aX2lhmzjgfOtiJlh0CpwZnMx2w3tF75wYfYqZRPT/WzZBBpcaSEqzFqfgoKi/MwmOltY
         hLnr66uTS/v9RDtqoa/+ekxgMrYx4qPO0L4KoCw1qwt2p+LSM/d5E+ynhhuvpJYsosw3
         9NveR3Ie47A1S4DS/t00tKhVnhssyXFmL3YQj961iNBP2QjwtVwWoF1rulfuswK1somE
         Ipp7hH3Yqd16TRnkWyN1GwaGue6FNZcQzP1d1N2LPA0/x21NFMpuAY95puLD/OEW7Z5d
         99SQ==
X-Gm-Message-State: AJaThX6ASDa8I+kN96lmJLyJ00GTPEZ7KLw9fbGOqFdFNmlXGLPoTVJ/
        DuU6fRI1VwY7j6CR5WIWvNdIQce3ydYcOrkPIaZDaw==
X-Google-Smtp-Source: AGs4zMaYHMU27vF4J6uLD0KeHaiIBddsFNqmH8/VG+1QEAyokxv5vtmnAaz0a3lMauI8Kt8QS98iopC65wDfJBWZQWg=
X-Received: by 10.200.36.86 with SMTP id d22mr4504305qtd.140.1510860852875;
 Thu, 16 Nov 2017 11:34:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.203 with HTTP; Thu, 16 Nov 2017 11:34:12 -0800 (PST)
In-Reply-To: <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com>
References: <20171116020039.17810-1-sbeller@google.com> <20171116020039.17810-8-sbeller@google.com>
 <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Nov 2017 11:34:12 -0800
Message-ID: <CAGZ79kaGGUJSGG6OdfaTepDrvGBGFd17paBNNYuQt7t8XnDfHw@mail.gmail.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I am not sure if "And if there is ..." is adding much value here (I
> do not think it is even technically correct for that matter).  If
> there are more than one tag that point at the commit the user is
> interested in, we use one of the tags, as tags conceptually sit at a
> higher level.  And we use a heuristic to use one or the other tag to
> make up a name for the commit, so the same commit can have two valid
> names. ---So what?  Neither of these two valid names is "ambigous";
> the commit object the user wanted to name _is_ correctly identified
> (I would assume that we are not discussing a hash collision).
>
> Lucikly, if we remove "And if...precisely", the logic still flows
> nicely, if not more, to the next paragraph.

fixed.

>> When describing a blob, we want to describe the blob from a higher layer
>> as well, which is a tuple of (commit, deep/path) as the tree objects
>> involved are rather uninteresting.  The same blob can be referenced by
>> multiple commits, so how we decide which commit to use?  This patch
>> implements a rather naive approach on this: As there are no back pointers
>> from blobs to commits in which the blob occurs, we'll start walking from
>> any tips available, listing the blobs in-order of the commit and once we
>
> Is "any tips" still the case?  I was wondering why you start your
> traversal at HEAD and nothing else in this iteration.  There seems
> to be no mention of this design decision in the documentation and no
> justification in the log.

fixed the text. The design decision to reverse walk HEAD is tied to
your observation below:

> The reversing may improve the chance of an older commit to be chosen
> rather than the newer one, but it does not even guarantee to show the
> "introduction".

This is what I realized when we started walking all refs including reflog.
The introduction can only be found when we take the commit-parents
into account and look at the diffs. I noticed you started
origin/jc/diff-blobfind
which may be helpful to find the introduction correctly, which I'll play around
with that and see if I can get that working.

> What this guarantees is that a long history will be traversed fully
> before we start considering which commit has the blob of interest, I
> am afraid.  Is this a sensible trade-off?

I am not fully convinced all descriptions are in recent history, but I
tend to agree that most are, so probably the trade off is a wash.
