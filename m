Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E6E2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932577AbdGKTtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:49:46 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35605 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbdGKTtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:49:45 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so1111273pfk.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RQleUrBWj0C3HTIWvjZ5MmvYjFrFm9fDJgu++e92VYw=;
        b=HhhCTptf8sR+Ae7PaLSL+yoqd4OwdXQF3m2prqFV/9ETE0u2OWAG4BQc4+sKHFUe6S
         cyHHQhR5JEGK3yO9DcoVjRPfc7rnkwhdPr+7PFOkBEFZVJ2K++cBzz+tPbZnthf3ZREK
         V9s1dDGXY+Lub4n9mKCB/a8hVtD62+jPvqbX61m5rWKDskprkyHqyJDk8L5gjSSlDBJg
         FuvEDTPt1ozUZIDLeYpbSiWVXaKEEny+TV6QqM2D1R7I9odS86kCoI8FPKMKQQX4qElz
         Pr98dne4sS/Wpc2wEhr+LTG1gFu2aGORZnIjCLJGYGpvvRulUYDvMI+Bp1i7LCHlUdQV
         e+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RQleUrBWj0C3HTIWvjZ5MmvYjFrFm9fDJgu++e92VYw=;
        b=sxgGHjLW90B5wA7t4sW9EMZX/s1k9DB2XN9tuvowM/QlohgynRO9CCts5lZrlyKGeP
         oLlCdb3sckAk7Z4ffO4jPYyMqX8P0KMCSFJV07vR4L9GqLQMoPFmAjFgJed2S2QDdpl4
         7w7wseM+dT9pUT6TfCi25qzZGcvNbAYCOU0SL5xrS6ktfz2PCKudCTut5KO+O3470WgV
         NsRhDOe1yswBYskq2BqTrh9eiw/DgDNO37Bu6r2Uw0vOfe4vr+vCtTtmIqxbHdP3FYAn
         aTidlf5QDyxaNe5Fp4KIclHmTC1qDTqj4P+B9eAli3Q3G9C325kGppmuAzya8+jl4Lk6
         NHaw==
X-Gm-Message-State: AIVw110aYybXxhUA8R7dlfo1p1wpghjQ+JZ43QQJOWFXfsl49EQQe5XJ
        G/9pn8aQFCCTwMfjWW52q4Br1cqudyTX
X-Received: by 10.99.44.206 with SMTP id s197mr74956pgs.116.1499802584458;
 Tue, 11 Jul 2017 12:49:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 11 Jul 2017 12:49:43 -0700 (PDT)
In-Reply-To: <xmqqd1963j84.fsf@gitster.mtv.corp.google.com>
References: <20170706202739.6056-1-sbeller@google.com> <xmqq7ezldlhe.fsf@gitster.mtv.corp.google.com>
 <c9a6f3f0-e338-a200-6b57-48b5d926d31c@gmail.com> <xmqq4luochtv.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbTzZLD5FDidDG8SUrKpgRGvA7f9HAu77w+iW8A8zLMAw@mail.gmail.com>
 <20170711180122.GG161700@google.com> <xmqqd1963j84.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 12:49:43 -0700
Message-ID: <CAGZ79kaCXLtauL5UNT-8gCpzs5A+LU6Ed41+_LdBO7zDyW1Dyg@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH] object store classification
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>>>   the_repository -> the_object_store
>>>   but the object store is a complex beast having different hash tables
>>>   for the different alternates.
>>
>> After looking at the patch and some of the comments here I think that
>> this is probably the best approach with a few tweaks (which may be
>> completely unfounded because I'm not familiar with all the object store
>> code).
>>
>> In an OO world I would envision a single object (let's say 'struct
>> object_store') which is responsible for managing a repository's objects
>> no matter where the individual objects came from (main object store or
>> an alternate for that repository).  And if I understand correctly the
>> single hash table that exists now caches objects like this.
>
> I would say that conceptually an object-store object has an
> interface to answer "give me info on the object I can refer to with
> this object name".

ok.

> At the implementation level, it should have a
> hashtable (lazily populated) for all the objects in a single
> $GIT_OBJECT_DIRECTORY, grafts/replace info, and a set of pointers to
> other object-store instances that are its alternate object stores.

So one repository has one or more object stores?

I would expect that most of the time the question from above
"give me info on the object I can refer to with this object name"
is asked with the additional information: "and I know it is in this
repository", so we rather want to have

  lookup_object(struct *repo, char *name);

instead of

  lookup_object(struct *object_store, char *name);

because the caller most likely would not care if the object
comes from the alternate or from the main object store?
(There may be special cases in e.g. repacking/gc where
we want to instruct the repacker to only repack the main
object store, ignoring any alternates or such, but any other
command would not care, AFAICT)

So we could have the convenience function

    lookup_object(struct *repo, char *name)
    {
        foreach_objectstore(repo, lookup_object_in_single_store, object)
            if (object)
                return object;
        return NULL;
    }

but such code is related to storing objects, that I would prefer to see
it in the object store (object.{h,c}) instead of the repository code.
Also my initial plan was to have all objects (including from any alternate)
in a single hashmap per repository as that seems to be most efficient
assuming all alternates fit into memory.

This whole object store object orientation is only started to not have
the memory pressure from lots of submodule objects polluting the
main object store. When we have its own hashmap for each alternate
our performance would degrade with the number of alternates.
(Assuming the hypothetical worst case of one alternate per object,
then the lookup time would be linear in time given the above function,
I wonder if there are users that heavily use lots of alternates such that
this performance characteristics would be measurable in the code to
be written)

> You'd need to have a mechanism to avoid creating cycles in these
> pointers, of course.

This is another complication with many hashmaps (=object stores).
In the future, is it likely that we would want to drop an alternate
store from within a running process? If so we'd want to have
hashmaps per alternate, otherwise I only see disadvantages
for more than one hashmap (-> more than one object store)
per repository. And with that said, I think we can make a wrapper
struct object_store, that would encapsulate all needed variables.

+       struct object_store {
+               struct object **obj_hash;
+               int nr_objs, obj_hash_size;
+       } objects;

But instead of defining it at the repository, we'd rather define it
in object.h.

Stefan
