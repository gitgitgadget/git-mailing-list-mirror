Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F814207FF
	for <e@80x24.org>; Fri,  5 May 2017 17:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdEERu6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:50:58 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34724 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbdEERu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:50:56 -0400
Received: by mail-pg0-f41.google.com with SMTP id 12so6300791pgc.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X0/UGovSXjN5kE1dGEDrp6+0ta+dsvfj8G0KmvvoCXk=;
        b=qVwAdd2YtpWt7haivI6444KJrwWFIR4gteqR2F9EiuNR+GCH2tOs4BItvEQEeMvmh5
         KSGTpNTnc2+Ac2g4T8yktjlIxn9j+MN1KsFGQ+w3jZqAUmu9MkBRZiGKhBIUL855+KY3
         yI42YvGqMdyzV1VHZFMQlw32aNsBJbEzlh/UT/3QRIlTKrZOFsPWp9y+kI7BwL3aXR3s
         WyBjKYIGSn02BmqoHw0SYJYtis9e4US846GpNVTF/V9iimGrsWz763IV1qWBJwToW4Hr
         RCg4x/X3jWqUF+mqnUmNNRs0b9cd8UlGIC/AX/mtKZ2sFwHb0gAM5dih5lcjpryuDpGv
         Lkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X0/UGovSXjN5kE1dGEDrp6+0ta+dsvfj8G0KmvvoCXk=;
        b=gGdAU1/WlxWC0TWWhb+1SwpQFfZyeGp3y7ghMAiWlGg12vpQNimyk13t6CNZl10NQ/
         H6Cp8rVip8++mN6ckelmFffo5GXL5DQUzvJ6acgX7Z/07lfUhyeRTnzkDKj9Jkr/UcTO
         4jISQgoSDxv8CAUq+Jw/2JUtFOwl0FdGCQaSIVUC+alFo9G5FKWEiwyaQvYS95yQy3ct
         NW3tMTz/vvCB66r8O+cccBLYIkw95VB4Tngde0QkhpEfkKUnkFiNWgkLqRrQWKCpjLdD
         cT6cAnQz67yyP3tYe9U67KIAbB6EBPvaaHfZ/M+qWIHpsKPCfcaDl2SxUmj+19Z7HVRv
         VUfw==
X-Gm-Message-State: AN3rC/5cBt5eNVH5ta/Zm+jrZ8Xe0GXpJLveQFU0mJ9raFs+Vr2QQIDX
        EFzx+VHKa0whq4sJo+ZbkWyMqw81twy+
X-Received: by 10.99.60.81 with SMTP id i17mr4834870pgn.183.1494006656156;
 Fri, 05 May 2017 10:50:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Fri, 5 May 2017 10:50:55 -0700 (PDT)
In-Reply-To: <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com>
References: <20170505052729.7576-1-whydoubt@gmail.com> <20170505052729.7576-3-whydoubt@gmail.com>
 <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 May 2017 10:50:55 -0700
Message-ID: <CAGZ79kZ4k7qVKE7OpSEELorwSx5hUgJksLAeNgVGs0w1JC_Ffg@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] Move textconv_object to be with other textconv methods
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Smith <whydoubt@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff Smith <whydoubt@gmail.com> writes:
>
>> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
>> ---
>>  builtin.h          |  2 --
>>  builtin/blame.c    | 28 ----------------------------
>>  builtin/cat-file.c |  1 +
>>  diff.c             | 23 +++++++++++++++++++++++
>>  diff.h             |  7 +++++++
>>  5 files changed, 31 insertions(+), 30 deletions(-)
>
> This change makes sense regardless of your primary goal of the
> series.  It was not good that one builtin borrowing a helper from
> another.  The common helper should live outside builtin/ as a common
> code, and in this case, diff.[ch] may be an OK place for it.
>

My kneejerk reaction to this is would be:
    Please don't grow diff.[ch] even more. It has
    5k lines which is a lot IMHO. Although it might be
    ok for the compiler and from a logical point of view,
    I'd rather prefer to deal with lots of small files, than
    with such large files. I am undecided if this hints at
    bad tooling on my side or at how I think of code
    and their location.

I guess it is ok for now and in this series, but we may want
to split up diff.[ch] in the future into multiple finer grained files.

Thanks,
Stefan
