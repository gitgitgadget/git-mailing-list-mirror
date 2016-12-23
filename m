Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A071FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 22:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbcLWWXr (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 17:23:47 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35815 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbcLWWXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 17:23:46 -0500
Received: by mail-yw0-f170.google.com with SMTP id v81so32898876ywb.2
        for <git@vger.kernel.org>; Fri, 23 Dec 2016 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6hFyu4u/am+oNJTgOD5gpwBWROOx7Z2nnAy1fZ/kkz4=;
        b=jE9jWcBRbQThxPi+7xrcX74tSjXb2IPuqOqRXM4sduy1bNqZaXknZUsHGUti6Ua5An
         5lVszRyhZpjfy2XKfOjurm6JOfWaREBd4rq5XAFydaoF4FiBd4APxOvRkBw9ei5Vx3Q8
         1+rgQdKqEBybtcwDnOMDNz3J9EhTCmfevTuzloKXuAPGOygXKzk6bp21gUq/iDMnBKkM
         t/Fac43VEJtcmj9WSefhN85bd28xVfPaDF9d1DGoZuyEhTv0fT/vcjnU0dtnCeTKWtE8
         0X2PG37rCEmqwiG3rP6olhO0WuaGsLSbx1Di6RaobgVPrO9S9m+ChPqHOehpiUX5hscw
         gznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6hFyu4u/am+oNJTgOD5gpwBWROOx7Z2nnAy1fZ/kkz4=;
        b=QuxXOjAO+9iFgNgsplqwd3wg/o6b40tr7Me1HZRy4sL6L5qHxPAs15yP7WIeQmKNFF
         yuvFvKSrJGHReJfBuZVM8OGj6OMxgHkpHED67Ej7SW3uZWfNZYU1HOtHa3gm1tqIW1sa
         YYwvpc3mCLsjw+xsOI0OhabIrDziTMB/LOK4pQ25RlTfJ+iAjmH30J3pDDfr05uHGn9Z
         TwAy0Rw6ZbJx0ErbDrjnbBS3yQ8TfVcIFP8VmSnpuycbGq3PYLakT4XPcMmMYsjr+z0l
         Ivcb2kQqTIA3T2N8zTQCGtZ4vSllhpCM82WJM+77Sd9kP3jLa4POceSk0/feGOJ6hOpT
         jdYA==
X-Gm-Message-State: AIkVDXJ89FGV8dQfCA8aTaMT5cPGbM/tIrawLYHyoFEpbhex94m67pHt2cjCUV2BM0Z44aNSQWKgjSbhHg4SCw==
X-Received: by 10.13.254.71 with SMTP id o68mr14311325ywf.318.1482531825391;
 Fri, 23 Dec 2016 14:23:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Fri, 23 Dec 2016 14:23:24 -0800 (PST)
In-Reply-To: <20161223222145.vkf6mjvs5t7ag3od@sigill.intra.peff.net>
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
 <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com> <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com> <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
 <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
 <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net> <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com>
 <xmqq8tr6e46o.fsf@gitster.mtv.corp.google.com> <20161223222145.vkf6mjvs5t7ag3od@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 23 Dec 2016 14:23:24 -0800
Message-ID: <CA+P7+xrMFnW8NCySpMuWWnXBE30RwmOgr-0Xgjaa5i8eDPGGUw@mail.gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 2:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 23, 2016 at 01:17:03PM -0800, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > I guess both you and Michael are in favor of just removing compaction
>> > variant without any renames, so let me prepare a reroll and queue
>> > that instead.  We can flip the default perhaps one release later.
>>
>> -- >8 --
>> Subject: [PATCH] diff: retire "compaction" heuristics
>
> Looks good to me from a cursory read.
>
> Thanks.
>
> -Peff

Same. This is more obviously correct since we didn't have to change a
bunch of references to INDENT_HEURISTIC. I agree that the name does
not make sense now, but if our goal is to make it default with a
disable option, I think that we shouldn't worry too much about the
naming.

Thanks,
Jake
