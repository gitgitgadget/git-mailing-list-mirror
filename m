Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1131F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965586AbeBMTXG (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:23:06 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:44562 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeBMTXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:23:05 -0500
Received: by mail-yw0-f178.google.com with SMTP id y65so1873419ywg.11
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+5WrPJNOigj3pjUoUOJC/ZpdQx96iUq7aD8ILhQUdIg=;
        b=T9pddz0qgqiA06LeiPbhiNLJ3j8teARGM4/9S+wAcKU/ePzOkaZwGSG4XNZu9l8yD/
         egOGXYojr3WXoUFBrEuH4NJuCITTuWxrctAQM5vh6TzjUPbhPxZy0CGZpcuE1qbXhvM4
         qhaWiOY9c/W/lET3QW+AzbdCNi73kIXzSk6q1D8iUGiJ8a7z0lEJNH6wpehdxoUMYZiD
         3s27ndovysROFlaCRiAgCdCNNEH/hdfEdOpVpszxtfugN2ohzjXWW01KSLPnQ/j9bh+a
         H1AE+KBTxjOxD4CyM7B6z33ACZfEA/AR7363EkpKt4sMtxj3dn/2zpy3Adk7P1RkB2dJ
         gsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+5WrPJNOigj3pjUoUOJC/ZpdQx96iUq7aD8ILhQUdIg=;
        b=lxRKnEutphUmwWiI/hGWpvMHxKJbz3jhizt4O5TcXsv0sZRzkPlOri5oxgimIXYk4f
         ucJ1T9+2bz1VzfDQR38NaDKXmoO1fe5LVEiNgbSSUnKdCPpOhP0v9qwxsB9GMiplV4I1
         WjO3cFCeb7qoO/V7F2ajy+VYeFSD/FiHRJr1kxHIFJykc5GCfS3mpWRBhp1k7gHH46th
         O068SoLodMjneZnDruF5W1Jezaljq1DiDl/6+qSe9okOICdngLQvVcxZtzDx/Uja25a9
         nCLE+18a5pGCkw5EiNEbEdgQi+Y5ubjy4US2Zt0Ty7DE4/O+jT8dxXhj0CphEzRC3SIR
         fGyg==
X-Gm-Message-State: APf1xPA4scdzkotdEhA+UKxx3YvZmvHfKLOHsqNqamR0ysYuO8qFuS/W
        vEo/E5hWk6sc6UqX/Qru+bnnT7R6NLWlY/FipWlOuQ==
X-Google-Smtp-Source: AH8x224pNdxb8FJEJbGb/Q20l7DiEG+zxCPnFvkVzZx7A0++VsEhdTy2VbLpcRqanpM2Qfp+G4mWKYBSZCbdazNw2c4=
X-Received: by 10.37.180.65 with SMTP id c1mr1570572ybg.438.1518549784805;
 Tue, 13 Feb 2018 11:23:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 11:23:04 -0800 (PST)
In-Reply-To: <xmqq7ergra2y.fsf@gitster-ct.c.googlers.com>
References: <20180213012241.187007-1-sbeller@google.com> <20180213114903.GA21015@ash>
 <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
 <CAGZ79kbmAkN5EpW1hzW-FFdR74c-qXJc5aKZX0ff9bU0gxMRqQ@mail.gmail.com> <xmqq7ergra2y.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 11:23:04 -0800
Message-ID: <CAGZ79kZOq+_NOOabBUtPJ_zKNb_vdais70F6VzVFoSn5B5A4fQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Oh, that is an interesting perspective. Here is how I arrived at the opposite
>> conclusion initially: Searching for 'ignore_env' shows that we care about it
>> as well for the index and graft paths, which are not the object store, hence
>> it would be better kept in the repository. (The alternative would be to
>> duplicate it into the raw object store, but I do not like data duplication)
>>
>> But maybe it is better to duplicate this one bit instead of passing through
>> a larger scoped object.
>
> If a larger scoped repository refers to a smaller scoped
> object-store, is there still a need to duplicate that bit, instead
> of referring to the bit the smaller scoped one has when asking about
> the bit in the larger scoped one?

No (in theory). But in practice it may be worthwhile:

    "What's the value of this ref?"

    "Oh let me check the ignore_env bit that happens
    to live in the object store first."

would be super confusing to me.

> I am not sure if these "do not look at environment variables" is an
> attribute of these entities---it sounds more like an attribute for
> each invocation of an operation, i.e. "I want to learn where the
> index is but would ignore GIT_INDEX environment for this particular
> query." and "What's the value of this ref?  Please honor the
> common-dir environment during this query".

That sounds like we want to have a configset struct eventually.

For now the ignore_env bit lives in the repository, as that helps
when working with submodules, when reading its comments.
Unfortunately 359efeffc1 (repository: introduce the repository
object, 2017-06-22) did not reason about the existence of the ignore_env
flag in its commit message.

> So from that point of view, it may not matter where the "bit" lives,
> among repository, object-store, or ref-store.

It matters on the scale of confusing the developer?

Stefan
