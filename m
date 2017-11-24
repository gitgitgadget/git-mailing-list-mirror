Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51D02036D
	for <e@80x24.org>; Fri, 24 Nov 2017 20:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbdKXU37 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 15:29:59 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:39346 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753666AbdKXU36 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 15:29:58 -0500
Received: by mail-vk0-f66.google.com with SMTP id l189so5374880vkl.6
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 12:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9BwkppJtl8H4X89wl2bGCBSgfMJAaacOmohmslyxVxo=;
        b=KSG5SApGY0qw0WT/fowxcmJ33udDb+CMesVS0jHZNx526iWQ06bSlAYeBOa/gijLfV
         cmrwLD1XxYcXiD139n2aHBNTjj1kZ2rvzy8heffQxqxsnV6g0Wp/9Wn1jhAh+uY4LV1x
         F14QLhaDuxfH/tzuAZWjzY83zR0hFtkJLnbNBuKa1c6a8ne+JfP2MDSA+bI2NPhP+fo9
         UdfhxDSlniqpyf4hSxk2ZqUTrQJHsXmPyIDfCNZaLuxzF0AMvOIu0powNwH0Lz3IvMDS
         R/jT0Qim3Q/ZmHo/gUmi1svJtvPjGs7Rg0nlo+HmJZ47Pzdf/LWQypWmAXVsxNZ7KNXy
         o0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9BwkppJtl8H4X89wl2bGCBSgfMJAaacOmohmslyxVxo=;
        b=RBkTghMnGHBE2ajIdGCT4KIfZC6TCCvM7MxbYvl5KVyJrd2v8MqHzSoWZFLWMawAnE
         rc6KGm2RL8T41eCdO/EaOfffMLITAxQxNkEpvsUPSTZPEpYzVYQ5sFtyykhG2V3Evo82
         GiFfXrsDum+WjrWYgMoCxWcbLBMvQ9QqLnLWw9G6E12+quLjKQ0i4F4wUhzgQFIJUSpt
         sEcUr6EXL3qPWJqpS8om7m6stbF1IbxEF0MBpihm/caauzI/dafCKAjRjtipgxaQAp1l
         xrMra0IHHNDiG6rSu4ps3k0zWk3bZoSDxElazjE8kAcq/CbLTzid+YqqVp6jD0lzv8pk
         cUug==
X-Gm-Message-State: AJaThX7kNj51xpF+poa1bGnTnH8KZxs6zLcKc4TXSXgqlPQ9IiQefrKR
        AMQcEE106k9yFKOqAtF5kswIPaG1cT+Ep6dbVTA=
X-Google-Smtp-Source: AGs4zMZhEYx3b1KxNmIJfQbWZBQrZBvIzY1SCGWQ96+0iVf3e8BHvTIYdwSv1pq9h8dHoB2rTeFdfJ9ZQfnII0QUF6g=
X-Received: by 10.31.96.65 with SMTP id u62mr23091286vkb.68.1511555397889;
 Fri, 24 Nov 2017 12:29:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Fri, 24 Nov 2017 12:29:57 -0800 (PST)
In-Reply-To: <CAPig+cTtT2xLHy6gE9fW9G_KdzGTNEfgwz7NUOUwHxGKOkiKtA@mail.gmail.com>
References: <20171124195901.2581-1-newren@gmail.com> <CAPig+cTtT2xLHy6gE9fW9G_KdzGTNEfgwz7NUOUwHxGKOkiKtA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Nov 2017 12:29:57 -0800
Message-ID: <CABPp-BG+WCrPY3XNHCGK3fLGAO11wMtf1_kn1tuKojRAHSDvDg@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        David Turner <dturner@twitter.com>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 12:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Nov 24, 2017 at 2:59 PM, Elijah Newren <newren@gmail.com> wrote:
>> In commit ae352c7f3 (merge-recursive.c: fix case-changing merge bug,
>> 2014-05-01), it was observed that removing files could be problematic on
>> case insensitive file systems, because we could end up removing files
>> that differed in case only rather than deleting the intended file --
>> something that happened when files were renamed on one branch in a way
>> that differed only in case.  To avoid that problem, that commit added
>> logic to avoid removing files other than the one intended, rejecting the
>> removal if the files differed only in case.
>>
>> Unfortunately, the logic it used didn't fully implement that condition as
>> stated above; instead it merely checked that a case-insensitive lookup of
>> the file that was requested resulted in finding a file in the index at
>> stage 0, not that the file found in the index actually differed in case.
>> Alternatively, one could view the implementation as making an implicit
>> assumption that the file we actually wanted to remove would never appear
>> in the index with a stage of 0, and thus that if we found a file with our
>> lookup, that it had to be a different file (but different in case only).
>>
>> The net result of this implementation is that it can ignore more requests
>> than it should, leaving a file around in the working copy that should
>> have been removed.  Make sure that the file found in the index actually
>> differs in case before silently ignoring the request to remove the file.
>>
>> ---
>
> Missing sign-off.

Whoops!

Signed-off-by: Elijah Newren <newren@gmail.com>
