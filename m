Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C18208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 07:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbdIGH0k (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 03:26:40 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:51605 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751055AbdIGH0j (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2017 03:26:39 -0400
X-AuditID: 12074413-38bff70000007929-f7-59b0f4ad35a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.27.31017.DA4F0B95; Thu,  7 Sep 2017 03:26:37 -0400 (EDT)
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v877QaIV012082
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 7 Sep 2017 03:26:37 -0400
Received: by mail-it0-f53.google.com with SMTP id o200so2211856itg.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 00:26:37 -0700 (PDT)
X-Gm-Message-State: AHPjjUjUgD9ItJ62YIhbdRWV+tUT2jVuK6i68tpB+uRYkCet1SZqKDJI
        IfECdcQfi1C8R2OL/oGAnDuNQl3+KQ==
X-Google-Smtp-Source: ADKCNb7GUOdBF/2Eebo0CXE3SFgdkXbdJtsPVw7Ec02bZlk3Oiv5xKEjfS6x9XGb3wVEubvTY6EtZOnYVipOM8FkyPk=
X-Received: by 10.36.241.15 with SMTP id c15mr2492322iti.153.1504769196382;
 Thu, 07 Sep 2017 00:26:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.13.17 with HTTP; Thu, 7 Sep 2017 00:26:35 -0700 (PDT)
In-Reply-To: <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
References: <20170904200504.15249-1-t.gummerer@gmail.com> <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 7 Sep 2017 09:26:35 +0200
X-Gmail-Original-Message-ID: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
Message-ID: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
Subject: Re: [PATCH] refs: make sure we never pass NULL to hashcpy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqLvuy4ZIg4tHmSy6rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJXxbrVdwTe5ikkd5xkbGD+IdzFyckgImEjcetPA2MXIxSEksINJ
        on3GGnYI5yGTxIxDK1ghnD5GidbvrSwQLfkSm3e2sUHYRRI7XuxngrCLJdY1doPFeQUEJU7O
        fAJWLyQgJ/Fqww1GCNtD4uC2hewgNqeAtURXyy02iHiGxPadM8Bq2AR0JRb1NIPNZBFQkTjw
        5Ao7xPxEiTuHN7NDzA+QOHnyOJgtLOAkseHpZzBbREBNYmLbIRaQo5kFZjFKPLy3FmwQs4Cm
        ROv23+wTGEVmIblvFpLUAkamVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSmlmxgh
        4S28g3HXSblDjAIcjEo8vAn/10cKsSaWFVfmHmKU5GBSEuW9rAYU4kvKT6nMSCzOiC8qzUkt
        PsQowcGsJMJ76NOGSCHelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv
        ls9AjYJFqempFWmZOSUIaSYOTpDhPEDDj4PU8BYXJOYWZ6ZD5E8x2nNcuHPpDxPHgT23gOSm
        m3eB5IbvD/4wCbHk5eelSonzdoDcJADSllGaBzcZlrpeMYoDPSrMexBkOA8w7cHNfgW0lglo
        bclzsLUliQgpqQbG8q/MHcXrLjRx/7ilvsVuoaHEbZm2SYeuCq2Q6uM2zPN3OfZ2RnNP+g4h
        6RYvI7l9S7/zNFoYH1dawye7LcKZQ/HllJSGOcaRG4+0fY6IEam2WSh87ve34F2LfOJfLjrw
        OeHqs8wjzHLPKj5qm6rdvuTwUE5o/5UndwQ9X/s+3PR0orqN1ExbJZbijERDLeai4kQAetUh
        NzgDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> gcc on arch linux (version 7.1.1) warns that a NULL argument is passed
>> as the second parameter of memcpy.
>> [...]
>
> It is hugely annoying to see a halfway-intelligent compiler forces
> you to add such pointless asserts.
>
> The only way the compiler could error on this is by inferring the
> fact that new_sha1/old_sha1 could be NULL by looking at the callsite
> in ref_transaction_update() where these are used as conditionals to
> set HAVE_NEW/HAVE_OLD that are passed.  Even if the compiler were
> doing the whole-program analysis, the other two callsites of the
> function pass the address of oid.hash[] in an oid structure so it
> should know these won't be NULL.
>
> [...]
>
> I wonder if REF_HAVE_NEW/REF_HAVE_OLD are really needed in these
> codepaths, though.  Perhaps we can instead declare !!new_sha1 means
> we have the new side and rewrite the above part to
>
>         if (new_sha1)
>                 hashcpy(update->new_oid.hash, new_sha1);
>
> without an extra and totally pointless assert()?

The ultimate reason for those flags is that `struct ref_update` embeds
`new_oid` and `old_oid` directly in the struct, so there is no way to
set it to "NULL". (The `is_null_sha1` value is used for a different
purpose.) So those flags keep track of whether the corresponding value
is specified or absent.

Four of the five callers of `ref_transaction_add_update()` are
constructing a new `ref_update` from an old one. They currently don't
have to look into `flags`; they just pass it on (possibly changing a
bit or two). Implementing your proposal would oblige those callers to
change from something like

> new_update = ref_transaction_add_update(
>         transaction, "HEAD",
>         update->flags | REF_LOG_ONLY | REF_NODEREF,
>         update->new_oid.hash, update->old_oid.hash,
>         update->msg);

to

> new_update = ref_transaction_add_update(
>         transaction, "HEAD",
>         update->flags | REF_LOG_ONLY | REF_NODEREF,
>         (update->flags & REF_HAVE_NEW) ? update->new_oid.hash : NULL,
>         (update->flags & REF_HAVE_OLD) ? update->old_oid.hash : NULL,
>         update->msg);

It's not the end of the world, but it's annoying.
`ref_transaction_add_update()` was meant to be a low-level,
low-overhead way of allocating a `struct ref_update` and add it to a
transaction.

Another solution (also annoying, but maybe a tad less so) would be to
change the one iffy caller, `ref_transaction_update()`, to pass in a
pointer to the null OID for `new_sha1` and `old_sha1` when the
corresponding flags are turned off. That value would never be looked
at, but it would hopefully reassure gcc.

I did just realize one thing: `ref_transaction_update()` takes `flags`
as an argument and alters it using

>         flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);

Perhaps gcc is *more* intelligent than we give it credit for, and is
actually worried that the `flags` argument passed in by the caller
might *already* have one of these bits set. In that case
`ref_transaction_add_update()` would indeed be called incorrectly.
Does the warning go away if you change that line to

>         if (new_sha1)
>                 flags |=REF_HAVE_NEW;
>         else
>                 flags &= ~REF_HAVE_NEW;
>         if (old_sha1)
>                 flags |=REF_HAVE_OLD;
>         else
>                 flags &= ~REF_HAVE_OLD;

? This might be a nice change to have anyway, to isolate
`ref_transaction_update()` from mistakes by its callers. For that
matter, one might want to be even more selective about what bits are
allowed in the `flags` argument to `ref_transaction_update()`'s
callers:

>         flags &= REF_ALLOWED_FLAGS; /* value would need to be determined */

Michael
