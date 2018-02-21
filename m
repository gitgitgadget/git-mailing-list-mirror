Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA5C1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 14:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935433AbeBUON1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 09:13:27 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:46501 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933018AbeBUONY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 09:13:24 -0500
Received: by mail-qt0-f173.google.com with SMTP id u6so2010982qtg.13
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 06:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=utPQFLJ4Lk08yKnQvGrZ5A/zpZrnccv4Nes/T+Vn6uU=;
        b=Xv+q7/11bFDuKyMYYRDLWLRwMtuMezQ61XTt3WUVCHQ6ayVRLl1+evROfLQbFfkTdU
         f7Zjzv7656pqnsd2VNYC0eyzjsvwkmpt7abHsb0ROR8TBxqFc225rla3ouOoFFYehTLm
         G2yqe2iCUJheIHzuiHsDiB90RHmnV5mD4G5GoInv6rzbkjzHoHbymaq8lmFpckyB3le3
         75gBrWF7xSIFnVv6+SXpdj3fqRKhpnBh0QJXa3VDM+DA3lOd2xvWXPpBeZRoIzP1/IjC
         LxUywYPbjtF1jQrO2JQUwO9tZRVC0ex25dGowQhFezzGiKjGXNqlRpZriis37s9wBuR9
         kxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=utPQFLJ4Lk08yKnQvGrZ5A/zpZrnccv4Nes/T+Vn6uU=;
        b=qDjx8VaiqBhga2fVC7g71VIBJd/XwbZtfhzLgLoRn0XxRfkw5avStEAQhb21F+3VJv
         FR2uG+laJIFsqi8sTBaQWYEM+NZKF48iWxD0B8gLqbZycxZc3mGOWt1YO+IV7qr4vfTu
         mk9oWS6wCRzg8MHtvS5jrQZMUaMcK0x4DcIuUoKPQMvAZpomi1iokNk93pFb+i5HdetD
         kMJgtWBYZdY65bkTWPmUDPpcRu0eMdfkSkk+wLbSmpuFOiU6VNB+ZiJhEafAzocdO32Y
         +DM1FyxHJdNIMweqmoZDF+aN195hSswrBPaWiyj9tchZEuv3LaaUCC6/dWBublQeJ1Rv
         2YhQ==
X-Gm-Message-State: APf1xPCEsPdZYZLahjmwKITKak5c9HakLQvVdfqUIQPUHyWtCS6xUa7c
        ewyOhYEKvA2kOlJCnWfi5Bk=
X-Google-Smtp-Source: AH8x227gal2VTKa/vy/pKHYl4Cc44pk3wwV4uTJXjNmsY0BdIP4Y6W1nxmszxAI0MpMoB5HoaMwF7g==
X-Received: by 10.200.82.76 with SMTP id y12mr5597939qtn.75.1519222403796;
        Wed, 21 Feb 2018 06:13:23 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 42sm1595724qte.13.2018.02.21.06.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2018 06:13:23 -0800 (PST)
Subject: Re: Question about get_cached_commit_buffer()
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
 <20180220225726.GA17496@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
Date:   Wed, 21 Feb 2018 09:13:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220225726.GA17496@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2018 5:57 PM, Jeff King wrote:
> On Tue, Feb 20, 2018 at 05:12:50PM -0500, Derrick Stolee wrote:
>
>> In rev-list, the "--header" option outputs a value and expects the buffer to
>> be cached. It outputs the header info only if get_cached_commit_buffer()
>> returns a non-null buffer, giving incorrect output. If it called
>> get_commit_buffer() instead, it would immediately call
>> get_cached_commit_buffer() and on failure actually load the buffer.
>>
>> This has not been a problem before, since the buffer was always loaded at
>> some point for each commit (and saved because of the save_commit_buffer
>> global).
>>
>> I propose to make get_cached_commit_buffer() static to commit.c and convert
>> all callers to get_commit_buffer(). Is there any reason to _not_ do this? It
>> seems that there is no functional or performance change.
> That helper was added in 152ff1cceb (provide helpers to access the
> commit buffer, 2014-06-10). I think interesting part is the final
> paragraph:
>
>        Note that we also need to add a "get_cached" variant which
>        returns NULL when we do not have a cached buffer. At first
>        glance this seems to defeat the purpose of "get", which is
>        to always provide a return value. However, some log code
>        paths actually use the NULL-ness of commit->buffer as a
>        boolean flag to decide whether to try printing the
>        commit. At least for now, we want to continue supporting
>        that use.
>
> So I think a conversion to get_commit_buffer() would break the callers
> that use the boolean nature for something useful. Unfortunately the
> author did not enumerate exactly what those uses are, so we'll have to
> dig. :)
>
> My guess is that it has to do with showing some commits twice, since we
> would normally have the buffer available the first time we hit the
> commit, and then free it in finish_commit().
>
> If we blame that rev-list line (and then walk back over a bunch of
> uninteresting commits via parent re-blaming), it comes from 3131b71301
> (Add "--show-all" revision walker flag for debugging, 2008-02-09).

Thanks for doing this digging. I appreciate the breadcrumbs, too, so I 
can do a better job of digging next time.

> So there it is. It does show commits multiple times, but suppresses the
> verbose header after the first showing. If we do something like this:
>
>    git rev-list --show-all --pretty --boundary c93150cfb0^-
>
> you'll see some boundary commits that _don't_ have their pretty headers
> shown. And with your proposed patch, we'd show them again. To keep the
> same behavior we need to store that "we've already seen this" boolean
> somewhere else (e.g., in an object flag; possibly SEEN, but that might
> run afoul of other logic).

What confuses me about this behavior is that the OID is still shown on 
the repeat (and in the case of `git log --oneline` will not actually 
have a line break between two short-OIDs). I don't believe this behavior 
is something to preserve.

You are right that we definitely don't want to show the full content twice.

> It looks like the call in log-tree comes from the same commit, and
> serves the same purpose.
>
> Aside from storing the boolean "did we show it" in another way, the
> other option is to simply change the behavior and accept that we might
> pretty-print the commit twice. This is a backwards-incompatible change,
> but I'm not sure if anybody would care. According to that commit,
> --show-all was added explicitly for debugging, and it has never been
> documented.  I couldn't find any reference to people actually using it
> on the list (a grep of the whole archive turns up 32 messages, most of
> which are just it appearing in context; the only person mentioning its
> actual use was Linus in 2008.

Unless I am misunderstanding, the current behavior on a repeated commit 
is already incorrect: some amount of output occurs before checking the 
buffer, so the output includes repeated records but with formatting that 
violates the expectation. By doing the simple change of swapping 
get_cached_commit_buffer() with get_commit_buffer(), we correct that 
format violation but have duplicate copies.

The most-correct thing to do (in my opinion) is to put the requirement 
of "no repeats" into the revision walk logic and stop having the 
formatting methods expect them. Then, however we change this boolean 
setting of "we have seen this before" it will not require the formatting 
methods to change.

I can start working on a patch to move the duplicate-removal logic into 
revision.c instead of these three callers:

builtin/rev-list.c:     if (revs->verbose_header && 
get_cached_commit_buffer(commit, NULL)) {
log-tree.c:     if (!get_cached_commit_buffer(commit, NULL))
object.c:                       if (!get_cached_commit_buffer(commit, 
NULL)) {

But this caller seems pretty important in pretty.c:

         /*
          * Otherwise, we still want to munge the encoding header in the
          * result, which will be done by modifying the buffer. If we
          * are using a fresh copy, we can reuse it. But if we are using
          * the cached copy from get_commit_buffer, we need to duplicate it
          * to avoid munging the cached copy.
          */
         if (msg == get_cached_commit_buffer(commit, NULL))
                 out = xstrdup(msg);
         else
                 out = (char *)msg

Thanks,
-Stolee
