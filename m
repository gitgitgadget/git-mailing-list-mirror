Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC3C201A7
	for <e@80x24.org>; Wed, 17 May 2017 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754435AbdEQXDv (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 19:03:51 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34995 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbdEQXDu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 19:03:50 -0400
Received: by mail-pg0-f41.google.com with SMTP id q125so13634289pgq.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E9zKhVRRHmmAl6NnRNv3s9LrRnxcak8Qkj1v0yoYZVQ=;
        b=GQLittyAAC9PGc5nVi0tJO/gJDvZ+FDhXzM89xeuL809ZXLraZs87sks9N6pPgPqqQ
         R6YbWgARVPyBVbhE9Hja440dTps6rqp1PjGPGshEjOYx013LJ+4TpnkENpYIKOFYBbP2
         g+VjRwODrT32fDovRthjZzqea8ROblKHZRyGWLyxG6N/YNH5NrpJz/0PpjAkaXYuVCO7
         1jb0DsJuixAP4ttl1HP1UISFH0fcUR+sI1QQ2FAbAwKbdjIxAIS/YF1cJG8JqYZOaPdD
         mX4ZGW6Wgjwg0NZ2EkboxRNSPOls+IcPTv9AMc4hB09sxQudkoYz1lIfMR6t/su4xnix
         u2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E9zKhVRRHmmAl6NnRNv3s9LrRnxcak8Qkj1v0yoYZVQ=;
        b=bbYT4v/UVfMYf73zOVyNAKfa//eTDNlbPE2fU7aCfiG8/3K5HYaSNJ2ESG0r07G5PO
         9lo95d2kSnOTwLckkr5rF3mvH0dAIv5buHB3sAyiQkmVNue+YZpFRulh53o1f+zjE01+
         ZQvugMPp34JrjMbXUYIKpdrX/EmWT1EDXqK5vTSB9G7CRDCkB8K5D2UPkfgPtjDuWCo3
         bXbvHGg/HbiHxxXPIOc6z4bShyAxPqE9IojFewJa1sjp0nBCng3YNa96q6gCsP5QlAkv
         BeWNKBeGGwqoy5bM9i3RJfx/KDK7x75oJkWS6/uPci9XSqjn2mmSL2l3iicMd98kiQJX
         O0gQ==
X-Gm-Message-State: AODbwcDRZESA3b02DIeEkf6oTpRhYcJldItDGpaRafUnJLOVyELI2inT
        SiCzmBBOf8e+p+07mKXw9bMV4ax+7JgWJe/NQg==
X-Received: by 10.84.241.132 with SMTP id b4mr1093743pll.107.1495062229246;
 Wed, 17 May 2017 16:03:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 16:03:48 -0700 (PDT)
In-Reply-To: <CACBZZX5BrASFemN2VviMjH-AqnxU6veLVmjRdn1iYuA9fgKQog@mail.gmail.com>
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net> <20170516203712.15921-1-avarab@gmail.com>
 <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com> <CACBZZX4Jppr7ht7m444EjW4CDYX5CMvnxtStH4bF=A19TYKcZg@mail.gmail.com>
 <xmqqbmqrwzu1.fsf@gitster.mtv.corp.google.com> <CACBZZX5BrASFemN2VviMjH-AqnxU6veLVmjRdn1iYuA9fgKQog@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 16:03:48 -0700
Message-ID: <CAGZ79kYX8ct4GKDbZxGJmR5kkVrs4zjnaKOaD8Dm8rKx8aPA+Q@mail.gmail.com>
Subject: Re: [PATCH] tests: add an optional test to test git-annex
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Joey Hess <id@joeyh.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 12:33 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, May 17, 2017 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> Well, it is one thing to place git-annex under CI to make sure its
>>>> latest and greatest works together well with our latest and greatest
>>>> (and it may be something we want to see happen), but driving its
>>>> tests from our testsuite sounds like a tail wagging the dog, at
>>>> least to me.
>>>
>>> To me this is just a question of:
>>>
>>> * Is it the case that git-annex tests for a lot of edge cases we don't
>>> test for: Yes, probably. As evidenced by them spotting this
>>> regression, and not us.
>>
>> And I'd encourage them to keep doing so.
>
> The point of this patch is that we can do this more systematically and
> reliably, not have people discover this sort of thing after a major
> release.
>
> I.e. we can be pro-active about this instead of waiting for bug
> reports to roll in.

We can be pro-active without this patch, too. ;)
I guess this makes it just easier for someone out of the Git community to
be proactive in searching for defects.

>
> The utility of this test is that sometime close to release someone
> (e.g. me) can run it, if it fails let's see if it fails on the last
> release version of ours, if so it's probably upstream breakage, or
> like with the 2.13.0 release if it's OK on 2.12.0 it's our bug.
>
> It'll never trip some random tester up since you need to explicitly
> opt-in via EXTERNAL_TESTS=3D1, so honestly I'm a bit puzzled by these
> objections. This incurs no burden on either devs, packagers or users,
> and would have demonstrably detected an issue we'd rather have wanted
> to know about pre-release than post-release as is the case now.

I think this patch could spark a discussion what we expect from our test su=
ite.
Is it a contract that we promise, as in "Here are some blessed workflows,
our users should see and imitate"?

This patch sort of feels like (a) we let others dictate the contract to us
and (b) we choose the easy way out as we do not write enough tests on
our own, so we force downstream to help us out.

I guess it is appropriate to compare this level of testing to other externa=
l
tests, such as cppcheck, travis, coverity. For some of them (travis) we
carry some code with us (.travis), not so for others (coverity would benefi=
t
from [1] that I carry outside of Junios tree). Admittedly these external to=
ols
are all focused on testing, not on building on top of Git, which brings
in other expectations from these tools.

[1] https://github.com/stefanbeller/git/commit/0781fbafb9dd2a995ba62a9af5f7=
581e3cf05359

---
As mentioned in the other thread[2], the idea was floated to have this test=
 or
the downstream project as a submodule, and if you are interested in the tes=
t,
then you would obtain the submodule and run the tests (in there?)
That would have the benefit of less 'uninteresting' glue logic for those wh=
o
are not interested in these tests as gitlinks may be easier to ignore
for a developer
than code. (Less data to fetch, git-grep also doesn't yield results
for the uninteresting
parts as these submodules would be uninitialized).
(The more I talk about this "downstream tests in submodules"
idea, the less convinced I am)

[2] https://public-inbox.org/git/20170517113824.31700-1-avarab@gmail.com/
