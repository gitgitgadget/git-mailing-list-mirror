Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566D52018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbcGMPRb (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:17:31 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37246 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcGMPR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:17:26 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so45978164ith.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:17:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HQqnuPdcFpU8kA93MtbIcHLUIL4uzQ1vSpE7PcupCBs=;
        b=c7nr8cl9D79kuTYopJ/OkzEKa/EmZhOvc2OcXbrDnupp7/K7cL2m820K4u3NSXtsD0
         U6HQGqJNKBr6RuUdC+Vs5dxCTYzjMWZAUgHAQPE8myGKiyeykujNxolmWgqSDBADnGnd
         80hfPLy7BekwzxlJ05vnBf/1WN3YqwRARSFaLJVBA2U63bJVTTGgaiI+YvmwylGo9rZa
         O6pixU3unk40TzN0S/vpHo4EkVxOdgNhgysyTJsflX7B3aa2d/CZlO0Qgl0Rbyem+Yoc
         IoYvuhHvwAGdNRvD7UZ6IFwnHlLqM9C09NzYlQQtJ8rjllZX8H7tAR93/2J9yRjj7RKS
         JGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HQqnuPdcFpU8kA93MtbIcHLUIL4uzQ1vSpE7PcupCBs=;
        b=K7yYfdJdMFh0rT0nOypxta/LqVcTFbewhkeNkRBijq4kZ4rFArRgjb+DmfoR3+39BO
         fyB0dno4lb+CPVd/4UcM6p0hM8hwO/ClqkfrZFapznPtXnpU2saPlFxJ51qAOfVAc+dF
         iDYkJuEEhRsX2L36uXqUygKKWSHa8mXFwDWr1hCAvoWAcmOhO9vYQd5YYl6P2lqx+g1M
         tJAWcCbX96v1d9lIOTyMw4G7C6TFjYP+zCP02XL7R+JqVRq4ZedV8rcwhBpSlpn7S9cS
         L4jvPvH0SyPIeSxulGsWeWtufKf87yGzL4ptqetatf5MnzhRTE0ai7rN9UagStWqOlXr
         9+7g==
X-Gm-Message-State: ALyK8tJCXlEU2St/eQhrPtUCtVzQdsNnrRby3wokt7EkEfcBRTDz5xCTnGASrnGCiDgJNyFHoeG0NJ2BoPjO1A==
X-Received: by 10.36.208.71 with SMTP id m68mr9835785itg.63.1468423015110;
 Wed, 13 Jul 2016 08:16:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 13 Jul 2016 08:16:25 -0700 (PDT)
In-Reply-To: <CAP8UFD2pes3MD9FNBtvLYS5785aJoGPz00Fj+fHjy03j0aKjFg@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
 <20160711172254.13439-9-chriscool@tuxfamily.org> <CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com>
 <CAP8UFD01MiMnz6qNGYa9WEjZ_EOy-hBqO4gGKGyxUc71aOyp4w@mail.gmail.com>
 <CACsJy8CEimmc=W=bNcLw+TP0tGRPCL5rr3uNeFMJ=Ms9HkyABw@mail.gmail.com> <CAP8UFD2pes3MD9FNBtvLYS5785aJoGPz00Fj+fHjy03j0aKjFg@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 17:16:25 +0200
Message-ID: <CACsJy8DHd44MnFUkJwh9n0JK5J5P6kER0kgopX0UrS=ROo_URQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 8/8] read-cache: unlink old sharedindex files
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 9:45 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jul 12, 2016 at 5:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> No. People could create an index file anywhere in theory. So you don't
>> know how many index files there are.
>
> Maybe when an index file is created, its path and its sharedindex file
> could be appended into a log file.
> We could check this log file to see if we can remove sharedindex files.
> We would need to remove the entries in this log file for the indexes
> that are no longer there.
>
> Or instead of one log file we could have a file for each index file in
> a special directory called for example "indexinfo".
> So we could just delete the file if its related index is no longer there.

New files will require locking so people don't append at the same
time. And maybe another new host of problems. I think we can just go
with the garbage collection way that we have done for unreachable
objects.

Your indexinfo idea looks very close to multiple locking, an index
would lock the shared index it's linked to, preventing it from being
removed. For single locking, we can just create a file named $X.lock,
but for multiple locks, maybe we can go with
$X.lock-$index_trailing_sha1. Will it work? I don't know. Just
thinking out loud.

>> It really depends. If the shared part is too small for old indexes, we
>> might as well unsplit them. In practice though, the only long-term
>> index file is $GIT_DIR/index. If we don't delete old shared index
>> files too close to their creation time, temp index files will go away.
>
> We could treat $GIT_DIR/index specially so that if there are no temp
> index files, there should be nothing in "indexinfo".

No, temp index files are needed. And it will  be hard to treat
$GIT_DIR/index specially because updating it involves a temp index:
you first prepare a new index in $GIT_DIR/index.lock. If everything
goes well, you atomically rename it to $GIT_DIR/index. You may be able
to treat $GIT_DIR/index.lock special too, but that's starting to get
out of hand.
-- 
Duy
