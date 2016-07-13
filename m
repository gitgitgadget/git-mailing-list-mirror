Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B75F20196
	for <e@80x24.org>; Wed, 13 Jul 2016 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbcGMRyk (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:54:40 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37903 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbcGMRyj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:54:39 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so80841123wme.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 10:54:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z+PYugX/FHWTAz08jaBdbbbLbXg2JjTECTpYKTbDvWE=;
        b=O6KbJG8LBQtNIuhQ0uWHb6ACS0UYSI/81WlWfTtLVWTyhIrHmX1jSWW+HP2ESWUmvB
         N2qNQrHKVCvB+tLc+VLqHYPyn0gTnag+Nr3n5olcBzqc8ZClwajErXJp+OzboKirIIBt
         oxJQBu3eQmf64zYs+r51fgo4BrnBmdqQJmPtXOToogrRWLlBjey4jq/QKM+AzA4oAPyT
         ZfgfgEnD1OOC2cdTivUw4FZAtVvPZ3w4ZI4sPBbP8qO8gg0JR78xKdUdYkzyQv7A2hzP
         hTYGEfFYqPtPS+8N4QCm8QLIz9Q1mSZyF5U7zao/FTHiagg2+8YGtqNCGQFRMi37jp2y
         BzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z+PYugX/FHWTAz08jaBdbbbLbXg2JjTECTpYKTbDvWE=;
        b=CMnUA3k1oSNOdTH3dUx/EzoHm+hbRDCxjrpl1kZ9jyBrvjVCYh8QRLiYwnPUP0F9Hh
         p8a4Phh3nSymIiRUADU4qIU21J5IEBEp92OwhZwWL66tJdm7sBE217dZUqJW5po+PhFn
         KxctMqiAMwE6PqafelI3+ER63EWz8n7ngSDeC6hyMbLJDk3DrfMwEV+wSPGnNaauJWG4
         hhvrSEt5r/pmOhWL3uiE46gEqJRYhS+AYWUUHYqwUvzHzKGYjTzDxpZgL9S/9HEnCqM3
         KV84Q1e9oRq2+QEO/Q78PvGmdlTS7ga9rJSGAQN3Z6+VQNRGehy5h0RKPMZq0vKBUZWm
         N6ww==
X-Gm-Message-State: ALyK8tIKh8a0bMINGj3AR7kk/hVwslN2B2CkywZA5jeEuR5HIHWY3fHYWJri6RLC0E3uLdOlTvnub8X6mqeIOg==
X-Received: by 10.28.129.208 with SMTP id c199mr26923835wmd.79.1468432468773;
 Wed, 13 Jul 2016 10:54:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.151.134 with HTTP; Wed, 13 Jul 2016 10:54:28 -0700 (PDT)
In-Reply-To: <CACsJy8DHd44MnFUkJwh9n0JK5J5P6kER0kgopX0UrS=ROo_URQ@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
 <20160711172254.13439-9-chriscool@tuxfamily.org> <CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com>
 <CAP8UFD01MiMnz6qNGYa9WEjZ_EOy-hBqO4gGKGyxUc71aOyp4w@mail.gmail.com>
 <CACsJy8CEimmc=W=bNcLw+TP0tGRPCL5rr3uNeFMJ=Ms9HkyABw@mail.gmail.com>
 <CAP8UFD2pes3MD9FNBtvLYS5785aJoGPz00Fj+fHjy03j0aKjFg@mail.gmail.com> <CACsJy8DHd44MnFUkJwh9n0JK5J5P6kER0kgopX0UrS=ROo_URQ@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 13 Jul 2016 19:54:28 +0200
Message-ID: <CAP8UFD1=TLG=04BhjGWRa=M+8=4QGcrH3aj4VB8kb5pjXPHm8w@mail.gmail.com>
Subject: Re: [RFC/PATCH 8/8] read-cache: unlink old sharedindex files
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 5:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jul 12, 2016 at 9:45 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Tue, Jul 12, 2016 at 5:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>
>>> No. People could create an index file anywhere in theory. So you don't
>>> know how many index files there are.
>>
>> Maybe when an index file is created, its path and its sharedindex file
>> could be appended into a log file.
>> We could check this log file to see if we can remove sharedindex files.
>> We would need to remove the entries in this log file for the indexes
>> that are no longer there.
>>
>> Or instead of one log file we could have a file for each index file in
>> a special directory called for example "indexinfo".
>> So we could just delete the file if its related index is no longer there.
>
> New files will require locking so people don't append at the same
> time.

If we create a new file for each index file with a name that depends
on the index path (for example maybe the sha1 of the index path) then
as many index files with the same path are not possible we should be
safe.

> And maybe another new host of problems. I think we can just go
> with the garbage collection way that we have done for unreachable
> objects.
>
> Your indexinfo idea looks very close to multiple locking, an index
> would lock the shared index it's linked to, preventing it from being
> removed. For single locking, we can just create a file named $X.lock,
> but for multiple locks, maybe we can go with
> $X.lock-$index_trailing_sha1. Will it work? I don't know. Just
> thinking out loud.

Isn't is possible that the same index (so with the same trailing sha1)
be created in two different places?

>>> It really depends. If the shared part is too small for old indexes, we
>>> might as well unsplit them. In practice though, the only long-term
>>> index file is $GIT_DIR/index. If we don't delete old shared index
>>> files too close to their creation time, temp index files will go away.
>>
>> We could treat $GIT_DIR/index specially so that if there are no temp
>> index files, there should be nothing in "indexinfo".
>
> No, temp index files are needed. And it will  be hard to treat
> $GIT_DIR/index specially because updating it involves a temp index:
> you first prepare a new index in $GIT_DIR/index.lock.

If the new index is always prepared in $GIT_DIR/index.lock, then there
is no problem in the first place because when my original patch calls
clean_shared_index_files() the $GIT_DIR/index.lock is taken. Or maybe
I am missing something?

> If everything
> goes well, you atomically rename it to $GIT_DIR/index. You may be able
> to treat $GIT_DIR/index.lock special too, but that's starting to get
> out of hand.
