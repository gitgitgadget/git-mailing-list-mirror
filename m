Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7505C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 20:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeCNUxi (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 16:53:38 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:40967 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNUxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 16:53:37 -0400
Received: by mail-pf0-f179.google.com with SMTP id f80so1937344pfa.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPtrZ274KjgNoeGJtGmfacRYWJnr0MTBbIHwoFHn9FQ=;
        b=ZasA6YMbCAt4pLduG+wbIRKZdMH0TgMKsExadKYAtZnaoH20Z5O8LRoeh8hKfy1ONf
         V7qBaASy3VGVv6Ddj7ISccq31t9qaugtvn/78xGx4uxwGg+n5tNcYictEk8NhXzt1tY1
         c3wS6l5IKUWo/mpkE68StcsLjD4TzzFClSN/S/EgahoXQydJDucnP5ncht4Hkd1cr7uR
         DO/1w2WAQTT3+kNzA11Mi2ifSzQrsWPPq5mz7JCG2kSkPq4tYXeJhimMpkT1nYP3S5gT
         TxpuplTKQ+3idnGiumazVUjTsb2mB7AuLmQkrYQ3hNXneOoXrzxIsnUNoXFbIfeGn7gv
         lKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPtrZ274KjgNoeGJtGmfacRYWJnr0MTBbIHwoFHn9FQ=;
        b=L91fbIkML224jB2UN8/OoFX+MfJP0/k6FHM5A7mvrr9q74hj2pgwfkmjQoULb9bZIn
         sww/1uYLsm/U4EWCDUsvok/q7HZhArcBo4fvYIWXH/Nn6neTy11SnA4q5iWHrpzFh29T
         H70YPvqQFYg55OmTgjy+pyNr/UCm9N2vxUwKOjuI4dDr/awnaH1XlLBfCEePXl1oQ4L0
         /IggDNRAom1WXQ6XV9awPfg0dPN54QnjQixXBr9tuGmKcG1qlgu7Z8R1heSqgHN4ULok
         JobACc1M0COAHVPMssSzryXuANyA1D/gYumBiznBmEyw9DcOLe3PQ8JsWzI86VqycXNL
         PrOQ==
X-Gm-Message-State: AElRT7E/R4BhXeSOskzsyW4piByb19UbDwJbK57381YRhW7V3Onb3KNS
        jChgBEV6e47zyWcI28BUBcQ=
X-Google-Smtp-Source: AG47ELtwn5VDQ7Z4+VMRXwwgadrGEz9z4Htdv4dwWwyb8wYPM8uAE4290sy+mCGntHyaSNydDb/SKw==
X-Received: by 10.101.69.66 with SMTP id x2mr4787611pgr.438.1521060816405;
        Wed, 14 Mar 2018 13:53:36 -0700 (PDT)
Received: from mucjfgnsf2.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id c62sm7380357pfk.127.2018.03.14.13.53.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 13:53:35 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to debug a "git merge"?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <ddde09e9-0524-23f8-3585-ac00c2ec7f45@gmail.com>
Date:   Wed, 14 Mar 2018 21:53:31 +0100
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77D50EDA-6262-4288-B6E7-87BE63EFB54F@gmail.com>
References: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com> <ddde09e9-0524-23f8-3585-ac00c2ec7f45@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Mar 2018, at 18:02, Derrick Stolee <stolee@gmail.com> wrote:
>=20
> On 3/14/2018 12:56 PM, Lars Schneider wrote:
>> Hi,
>>=20
>> I am investigating a Git merge (a86dd40fe) in which an older version =
of
>> a file won over the newer version. I try to understand why this is =
the
>> case. I can reproduce the merge with the following commands:
>> $ git checkout -b test a02fa3303
>> $ GIT_MERGE_VERBOSITY=3D5 git merge --verbose c1b82995c
>>=20
>> The merge actually generates a merge conflict but not for my
>> problematic file. The common ancestor of the two parents (merge base)
>> is b91161554.
>>=20
>> The merge graph is not pretty (the committers don't have a clean
>> branching scheme) but I cannot spot a problem between the merge =
commit
>> and the common ancestor:
>> $ git log --graph --oneline a86dd40fe
>=20
> Have you tried `git log --graph --oneline --simplify-merges -- path` =
to see what changes and merges involved the file? I find that view to be =
very helpful (while the default history simplification can hide things). =
In particular, if there was a change that was reverted in one side and =
not another, we could find out.

Thanks for this tip! Unfortunately, this only confirms my current view:

### First parent
$ git log --graph --oneline --simplify-merges a02fa3303 -- =
path/to/problem
* 4e47a10c7 <-- old version
* 01f01f61c=20

### Second parent
$ git log --graph --oneline --simplify-merges c1b82995c -- =
path/to/problem
* 590e52ed1 <-- new version
* 8e598828d=20
* ad4e9034b=20
* 4e47a10c7=20
* 01f01f61c=20

### Merge
$ git log --graph --oneline --simplify-merges a86dd40fe -- =
path/to/problem
*   a86dd40fe <-- old version ?!?! That's the problem!
|\
| * 590e52ed1 <-- new version
| * 8e598828d
| * ad4e9034b
|/
* 4e47a10c7 <-- old version
* 01f01f61c


> You could also use the "A...B" to check your two commits for merging, =
and maybe add "--boundary".

$ git diff --boundary a02fa3303...c1b82995c -- path/to/problem

This looks like the correct diff. The "new version" is mark as =
+/add/green in the diff.

Does this make any sense to you?

Thank you,
Lars=
