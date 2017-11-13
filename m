Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C021F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdKMWP4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:15:56 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:51521 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdKMWP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:15:56 -0500
Received: by mail-qk0-f175.google.com with SMTP id f63so7273783qke.8
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bl8N02AKw1vl7iW4VggLpL6HhYA6fHWXkUg0/0kHLhg=;
        b=j8NoMIHRjAx50knDU2YviDNPK7TrSNd8g9sh3Me5nq0jvEJrjADZ8p85j6h+OtR5RM
         6NMV6sm9Zosuiqol87iihpWRU2xhVoHuNpja8ZIOOTzKKW1urAtRNDpsewlzTzLZ4bDY
         oerHjgYIyYSh4VbjZFE13dVkM4M/AULSFcYAl+CVeHVwzPX7c1AiteKGSFyhKzGjNf5X
         lQvjB5T2umQB6Dheg6NsTaTjP9Zj27UsuwRy2KwUD7qPMAd/GAd+AoFGKGTTZZX1OOd2
         UVJtaJygnD6MnXPJOSPs6uGiQZnaKR4YKIrvh9wCYQma2xj+voH1rj/RAO8N4hO3MGMV
         HVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bl8N02AKw1vl7iW4VggLpL6HhYA6fHWXkUg0/0kHLhg=;
        b=JSmk//hx+OOEDkAu4fOUamY7peTB0xJ5LQImvuHEWhufu9meE7wf/oM0ATDrmGyoFF
         qFSRqyk8VuFtu5x/TNlAHsPmEKSxHXvXO8VImbml7Y+0kstUEVqRqoLBsf5HK1WabVtS
         M9xHrQjbHownG8sS1RWrnMcJHL+r4vNA6juNFjBRYaQyU0ujHXiqkXqVN160h3hZjnpR
         XNlqbRo5y0IxQQlftdwf11hT8FsCNTM4YayavLBsw6XlCsVF0S3ivtPZL1CUOFUo3Z7o
         t6SDPYK2RvT0JQh9MpQ5qtK4pI3J8lVHWFV2Iz/XfIdCL1vOSA0XJh39gEtaCeeKSiz7
         4rbA==
X-Gm-Message-State: AJaThX7x9eJQJe1zLqRNQkqJeQ9xmvUAnM8p/h291kFYXcna4CRqhxOb
        T8uo3GP7b2SHHG2JZOWEzvsFFnUoVVUfTCHVlWOXoQ==
X-Google-Smtp-Source: AGs4zMZgEu5aDDj0ws1CVxPZl5T3YDD9fjCm+WifToSSbu+TbNCFGEYdH7638Yf3bAKZpEUEkIkx8/1sWqRUP1mtBfk=
X-Received: by 10.55.33.13 with SMTP id h13mr16501797qkh.176.1510611355074;
 Mon, 13 Nov 2017 14:15:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 14:15:54 -0800 (PST)
In-Reply-To: <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com>
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
 <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 14:15:54 -0800
Message-ID: <CAGZ79kZrZckX=xTgTH4cMper6BPAQ-_LT_x721SBEBB+Ks06jw@mail.gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 2:03 PM, Luke Diamand <luke@diamand.org> wrote:
> On 13 November 2017 at 19:51, Luke Diamand <luke@diamand.org> wrote:
>> Hi!
>>
>> I think there may be a regression caused by this change which means
>> that "git fetch origin" doesn't work:
>>
>> commit d0c39a49ccb5dfe7feba4325c3374d99ab123c59 (refs/bisect/bad)
>> Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>> Date:   Wed Aug 23 19:36:59 2017 +0700
>>
>>     revision.c: --all adds HEAD from all worktrees
>>
>> $ git fetch origin
>> fatal: bad object HEAD
>> error: ssh://my_remote_host/reponame did not send all necessary objects
>>
>> I used git bisect to find the problem, and it seems pretty consistent.
>> "git fetch" with the previous revision works fine.
>>
>> FWIW, I've got a lot of git worktrees associated with this repo, so
>> that may be why it's failing. The remote repo is actually a git-p4
>> clone, so HEAD there actually ends up pointing at
>> refs/remote/p4/master.
>>
>> Thanks,
>> Luke
>
> Quite a few of the worktrees have expired - their head revision has
> been GC'd and no longer points to anything sensible
> (gc.worktreePruneExpire). The function other_head_refs() in worktree.c
> bails out if there's an error, which I think is the problem. I wonder
> if it should instead just report something and then keep going.

Also see
https://public-inbox.org/git/CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeB=
rihiw@mail.gmail.com/
