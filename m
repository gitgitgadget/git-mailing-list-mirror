Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53C520357
	for <e@80x24.org>; Tue, 11 Jul 2017 01:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754957AbdGKBRy (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 21:17:54 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33254 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdGKBRx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 21:17:53 -0400
Received: by mail-pf0-f179.google.com with SMTP id e7so58365231pfk.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qcfmxl2dIEc/Zj0+xlgjRupIFJEe+p3zQxP4WEvmb9c=;
        b=eWuNdByj6qsjfcdxXAehJezymJ/0KeVqHbBtvTtJoCj2EOidhN6B3FCkuXn6m52ooW
         N6elwbezhxHCZUDm/A+BjznBM2XHZ903SgsEeCSUzns+yviuMM9XdMDuYzmwDBdKM1tg
         AE98auczssgJ05s5OGgyQ3QPw+lgWt7xjMa/dqhTaeHZ7crLR0dSSbLNKEDVd2O0bWsm
         KrhnDOn3fakh5WQPI2esOSGf3PJtHBiaisbIMFOvxCHABKBQC2PztJ0EPvnqjjhDoPk0
         p4Bz9lVyEphFgxgRZlTdBzD1IIxgxu9NDLDuSpwqqkLo2elvNGOazA1FR3KXQqeekv6G
         HxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qcfmxl2dIEc/Zj0+xlgjRupIFJEe+p3zQxP4WEvmb9c=;
        b=al0ydC4RCt845ub5Ow2wzXwEOATKgTbCkbkdsUtAsfXN8kq23ALyo8yI7cjyiDQVHw
         r1/WjccMfApuWWGBzZtEjh8DYlCRAybkq7eeCuh6O6OX2jtBOxyAx/W9xGYotg8eVA98
         yv6qBUbq08vsen1o2NJ1zJ8+zqMB5jC6yK0NLRPXvucRyqqsbVkP6LqAP3cqZPQ1St1k
         BQWrEpFo3wkxpCL8OD7KxUDnytlWAgFLzvo+Ct5wAk5fN/UOtSaU/SgOqqMl9O3jYo47
         ApLwqv7dKMVsKiG/I3ccg+vnYOkCHjAfVigWRvWVTJzQ759a9YbcIxr7emLcwcfF0gsh
         AoNw==
X-Gm-Message-State: AIVw112QaW3PNYzl0mdop2ORZG55Ds+rspbxOdL9j1ivA08sL4qRMJB0
        OA19gO6RFO3/Qm13oaoIOwbxmhYulDQ0
X-Received: by 10.84.129.69 with SMTP id 63mr21741101plb.0.1499735872764; Mon,
 10 Jul 2017 18:17:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 10 Jul 2017 18:17:52 -0700 (PDT)
In-Reply-To: <xmqq4luochtv.fsf@gitster.mtv.corp.google.com>
References: <20170706202739.6056-1-sbeller@google.com> <xmqq7ezldlhe.fsf@gitster.mtv.corp.google.com>
 <c9a6f3f0-e338-a200-6b57-48b5d926d31c@gmail.com> <xmqq4luochtv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Jul 2017 18:17:52 -0700
Message-ID: <CAGZ79kbTzZLD5FDidDG8SUrKpgRGvA7f9HAu77w+iW8A8zLMAw@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH] object store classification
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 7, 2017 at 9:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> For more API/state design purity, I wonder if there should be an
>> object_store structure that is passed to each of the object store APIs
>> instead of passing the repository object. The repository object could
>> then contain an instance of the object_store structure.
>>
>> That said, I haven't take a close look at all the code in object.c to
>> see if all the data needed can be cleanly abstracted into an
>> object_store structure.
>
> My gut feeling was it is just the large hashtable that keeps track of
> objects we have seen, but the object replacement/grafts and other
> things may also want to become per-repository.

This is similar to the_index which is referenced by the_repository.
But as we do not have anything like the_object_store already, we are
free to design it, as the required work that needs to be put in is the
same.

With the object replacements/grafts coming up as well as alternates,
we definitely want that to be per repository, the question is if we rather
want

  the_repository -> many object_stores (one for each, alternate, grafts,
      and the usual place at $GIT_DIR/objects
  where the object_store is a hashmap, maybe an additional describing
  string or path.

or

  the_repository -> the_object_store
  but the object store is a complex beast having different hash tables
  for the different alternates.

or

  the_repository -> the_object_store_hash_map
  which is this patch that would try to put any object related to this
  repository into the same hashmap and the hashmap is not special
  for each of the different object locations.


>
>> One concern I have is that the global state refactoring effort will
>> just result in all the global state getting moved into a single
>> (global) repository object thus limiting it's usefulness.
>
> I actually am not worried about it that much, and I say this with
> the background of having done the same "grouping a set of global
> state variables into a single structure and turning them into a
> single default instance" for the_index.  Whether you like it or not,
> the majority of operations do work on the default instance---that
> was why the operations could live with just "a set of global state
> variables" in the first place, and the convenience compatibility
> macros that allow you to operate on the fields of the default
> instance as if they were separate variables have been a huge
> typesaver that also reduces the cognitive burden.  I'd expect that
> the same will hold for the new "repository" and the "object_store"
> abstractions.

Sounds reasonable to expect.

Thanks,
Stefan
