Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A0120756
	for <e@80x24.org>; Sun, 15 Jan 2017 08:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbdAOINV (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 03:13:21 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35240 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdAOINU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 03:13:20 -0500
Received: by mail-io0-f195.google.com with SMTP id m98so9750913iod.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 00:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U5rb3rNHBWUDDNcfh9Z0ewESC9B8QwuXHQNziSgwgqA=;
        b=L0iaaDntDB3isZGyvdigNdO6GZkXKRVCU5hpnbgFj4JbaDjF5fS6E4brXnpsV+ns5Y
         gRI9kDK8/wOUue7E61KeOs2oQnom3hhA15Hb9Azx8Mdbgatmnkf/AWgLeGVNSAIl4CU3
         Aa6LXh7hsVgGzdLAxFUBG5jqn7IHeiFHI5NJhRa7IpbXDU4XoY2ZYHqP3+9smCv8FN7D
         /nxckFb4716SCnM5ucHzwaBjuDxerUfNcA/ZS0wRWVedFZ9vnGj43CoFjlXvUvqKTPBC
         f8had73DvMoqOi62DYcVv9pyA6cR0sPBU1KkfFUKxzpKSs9no53YP6TzuihPoN7RGzhn
         s7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U5rb3rNHBWUDDNcfh9Z0ewESC9B8QwuXHQNziSgwgqA=;
        b=gIzn8wWhf4K7upZqJPY4E12+A8gHzfierA1K2dT3VPt0cM61y5sf18AOafKC6jQqmD
         or/6Dtb17YmIZTIh9v1Ed/0fU4GqJ+TkNi31CFBavEx81hl7qlzmU2Ixg7n1bZbK1JxC
         fn3cYeMUNPfd+bhHGF24SniBvvTGEQcIlJTydmPWcmi/vX/ciRcTJiqWwqG6YX7WXyKW
         wptyKmDiImzUZHTSmEMBq0JWBuaC1D5WDks5JG28fDDITUikmAD9ldjgKlmgzexSI2aF
         FXz/wkZHtXeQe8HKEwyllorWSONNdCus+3HW+xm4YHIOEVXX52xTBsACe/VNNx0Gfoi0
         kO0g==
X-Gm-Message-State: AIkVDXKg8eJzfQ0Duu6wGGTOILQIhO6uK/DpxBppsGvEYR3ThW6uiK8PaEZraiPMbEIyQPCzmOOyijIXb8iLOQ==
X-Received: by 10.107.16.14 with SMTP id y14mr24921867ioi.164.1484467999627;
 Sun, 15 Jan 2017 00:13:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.133.208 with HTTP; Sun, 15 Jan 2017 00:13:19 -0800 (PST)
In-Reply-To: <xmqqr345cacz.fsf@gitster.mtv.corp.google.com>
References: <20170113175801.39468-1-gitter.spiros@gmail.com>
 <20170113175801.39468-2-gitter.spiros@gmail.com> <20170113183309.GA28002@google.com>
 <CA+EOSBm_ciQ-7bXuzn4Ba7Q5qqihaYH3Sdkkv+0M0VKWbhk=7w@mail.gmail.com> <xmqqr345cacz.fsf@gitster.mtv.corp.google.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Sun, 15 Jan 2017 09:13:19 +0100
Message-ID: <CA+EOSB=4-TKpi6mr-yVbwRsFrVzE=vo4Y9Qm3VMm7pn=UB1_hQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] builtin/commit.c: switch to xstrfmt(), instead of snprintf,
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-01-15 3:42 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Ok. I agree. But  is it strictly necessary to resend for this ?
>
> FWIW, the attacched is what I queued locally, after complaining
> "both have the same title?  They need to be explained better."
>
> In any case, I sense that 2/2 will be redone using strbuf, from the
> looks of what is discussed in a subthread nearby?

Yes, it seems to me correct, I resend the patch 2/2 based on the review

thank you all
>
> Thanks.
>
> commit 8d7aa4ba6a00b3ff69261e88b4842c0df5662125
> Author: Elia Pinto <gitter.spiros@gmail.com>
> Date:   Fri Jan 13 17:58:00 2017 +0000
>
>     builtin/commit.c: remove the PATH_MAX limitation via dynamic allocation
>
>     Remove the PATH_MAX limitation from the environment setting that
>     points to a filename by switching to dynamic allocation.
>
>     As a side effect of this change, we also reduce the snprintf()
>     calls, that may silently truncate results if the programmer is not
>     careful.
>
>     Helped-by: Junio C Hamano <gitster@pobox.com>
>     Helped-by: Jeff King <peff@peff.net>
>     Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> commit 2a7e328877982557d921a398af9442093290c613
> Author: Elia Pinto <gitter.spiros@gmail.com>
> Date:   Fri Jan 13 17:58:01 2017 +0000
>
>     builtin/commit.c: switch to xstrfmt(), instead of snprintf()
>
>     Switch to dynamic allocation with xstrfmt(), so we can avoid dealing
>     with magic numbers in the code and reduce the cognitive burden from
>     the programmers.  The original code is correct, but programmers no
>     longer have to count bytes needed for static allocation to know that.
>
>     As a side effect of this change, we also reduce the snprintf()
>     calls, that may silently truncate results if the programmer is not
>     careful.
>
>     Helped-by: Junio C Hamano <gitster@pobox.com>
>     Helped-by: Jeff King <peff@peff.net>
>     Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
