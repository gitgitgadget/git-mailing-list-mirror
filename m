Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251451F453
	for <e@80x24.org>; Mon, 22 Oct 2018 17:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeJWCHW (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 22:07:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37209 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJWCHV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 22:07:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id c15-v6so5767443eds.4
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kKqw6kkD9ehq7/J62RpBu0V7H+ijtuNaH7R/kCqaH/Q=;
        b=pHgLexx0x3OLDGGVoLiRecmZt8bXsUpntUn2EHR2IuquefPUZoi/7gqL3p/daAj5Q8
         YCx/Ta66rP9wg8lGRVzV/wPu/Hxb2tBygde2XlIiVjSYpiBtKlnnGxe7vpRu8Rmmul1P
         x1CWz2rEkp80NHVTtG4g+BEinODCBVR8LJc3PjmIMZd2ZHyZl4mA8jhsWwYbr0QuHWyU
         LEM6+aROdWaCRyz21//CsKGEnXDCzAw3gwzUgOFRpzbJen+s/kNDgy/Mtl9ijor6aYVy
         +Bt3y9AucPCCEA/wHQ7MqyH9hwJh1JpdqC1R0UQhWe6sOQmF8nOWv82TtVdMAqcosYqW
         8Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKqw6kkD9ehq7/J62RpBu0V7H+ijtuNaH7R/kCqaH/Q=;
        b=CfrgPrUTpw2MRy1/gpAO46ZY2xMo+N8rfcG+U95iR9O3qmNGVjhp+8q66J6Fxp34YE
         R/7uLdwzpAxLyptsQFkbZPLJPfmWUynPfhaNb6AJRLdqLaufkexmTq++Q3tlXb2aa8Gq
         Va2UUBTZfGkVEd/rds8WiPb2zKHK/3sOk0m0qmW9AMCDiRz/VKA+L5eiIPsybwhSx4kt
         uE8M9PhRUj7qaIGqpKaCwzBUYP56d/m8nRYEBCJ48DkLDZWuw5mVeZ+V1elZP/LDmeKd
         pVcHyR2cxjT157HcOdKGZxue+J4Osn6f6JokcuYZCzRtikxqEkPitW0BvPqYKz7npdu5
         lM/g==
X-Gm-Message-State: ABuFfointlbeD+s+5GMo2XOwjIVsM8hHVi2ts97QT+tCURnN6tVjb2Y9
        bAvTYA8PPizvb8lXw80RxHs=
X-Google-Smtp-Source: ACcGV618FiSs5paDxi/AHGAwFdrCI+S/4qF+SPicHTYrzhJNTY4HdnNVhzcm5Tl68sb958xkyWE9/w==
X-Received: by 2002:a50:af22:: with SMTP id g31-v6mr13261634edd.106.1540229979082;
        Mon, 22 Oct 2018 10:39:39 -0700 (PDT)
Received: from szeder.dev (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id a40-v6sm14585260edd.61.2018.10.22.10.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 10:39:38 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:39:35 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19]
 Bring more repository handles into our code base]
Message-ID: <20181022173935.GG30222@szeder.dev>
References: <20181016233550.251311-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 04:35:31PM -0700, Stefan Beller wrote:
> the last patch (applying the semantic patches) has been omitted as that
> would produce a lot of merge conflicts. Without that patch, this merges
> cleanly to next.
> 
> As for when to apply the semantic patches, I wondered if we would prefer a dirty merge
> (created via "make coccicheck && git apply contrib/coccinelle/the_repository.cocci.patch")
> of the semantic patches, or if we'd actually trickle in the changes over some time?

>     This series takes another approach as it doesn't change the signature of
>     functions, but introduces new functions that can deal with arbitrary 
>     repositories, keeping the old function signature around using a shallow wrapper.
>     
>     Additionally each patch adds a semantic patch, that would port from the old to
>     the new function. These semantic patches are all applied in the very last patch,
>     but we could omit applying the last patch if it causes too many merge conflicts
>     and trickl in the semantic patches over time when there are no merge conflicts.

I don't really like how this or the previous RFC patch series deal
with semantic patches (or how some past patch series dealt with them,
for that matter), for various reasons:

  - Applying the transformations from several semantic patches in one
    single patch makes it harder to review it, because we won't know
    which change came from which semantic patch.
    
    For comparison, see the patch series adding hasheq()/oideq(),
    merged in 769af0fd9e (Merge branch 'jk/cocci', 2018-09-17), in
    particular the four "convert <this> to <that>" patches.

  - 'make coccicheck' won't run clean (and the static analysis build
    job on Travis CI will fail) for all commits following adding the
    new semantic patches but before applying the resulting
    transformations.

  - These semantic patches interact badly with 'pu' and 'next',
    because those integration branches can contain topic branches
    adding new code that should be transformed by these semanic
    patches.  Consequently, 'make coccicheck' won't run clean and the
    static analysis build job will fail until all those topics reach
    'master', and the remaining transformations are applied on top.
    
    This was (and still is!) an issue with the hasheq()/oideq() series
    as well: that series was added on 2018-08-28, and the static
    analysis build job is red on 'pu' ever since.  See the follow-up
    patch e43d2dcce1 (more oideq/hasheq conversions, 2018-10-02), and
    one more follow-up will be necessary after the builtin stash topic
    is merged to 'master'.

    This makes it harder to review other patch series.

  - Is it really necessary to carry these semantic patches in-tree?
    Let me ellaborate.  There are basically two main use cases for
    semantic patches:

      - To avoid undesirable code patterns, e.g. we should not use
        sha1_to_hex(oid.hash) or strbuf_addf(&sb, "fixed string"), but
        use oid_to_hex(&oid) or strbuf_addstr(&sb, "fixed string")
        instead.  Note that in these cases we don't remove the
        functions sha1_to_hex() or strbuf_addf(), because there are
        good reasons to use them in other scenarios.

        Our semantic patches under 'contrib/coccinelle/' fall into
        this category, and we have 'make coccicheck' and the static
        analysis build job on Travis CI to catch these undesirable
        code patterns preferably early, and to prevent them from
        entering our codebase.

      - To perform one-off code transformations, e.g. to modify a
        function's name and/or signature and convert all its
        callsites; see e.g. commits abef9020e3 (sha1_file: convert
        sha1_object_info* to object_id, 2018-03-12) and b4f5aca40e
        (sha1_file: convert read_sha1_file to struct object_id,
        2018-03-12).

        As far as I understand this patch series falls into this
        category: once the conversion is complete the old functions
        will be removed.  After that there will be no use for these
        semanic patches.

        Having said that, it's certainly easier to double-check the
        resulting transformations when one can apply the semantic
        patches locally, and doing so is easier when the semantic
        patches are in tree than when they must be copy-pasted from a
        commit message.

OK, that was already long.  Now, can we do better?

How about introducing the concept of "pending" semantic patches,
stored in 'contrib/coccinelle/<name>.pending.cocci' files, modifying
'make coccicheck' to skip them, and adding the new 'make
coccicheck-pending' target to make it convenient to apply them, e.g.
something like the simple patch at the end.

So the process would go something like this:

  - A new semantic patch should be added as "pending", e.g. to the
    file 'the_repository.pending.cocci', together with the resulting
    transformations in the same commit.

    This way neither 'make coccicheck' nor the static analysis build
    job would complain in the topic branch or in the two integration
    branches.  And if they do complain, then we would know right away
    that they complain because of a well-established semantic patch.
    Yet, anyone interested could run 'make coccicheck-pending' to see
    where are we heading.

  - The author of the "pending" semanting patch should then keep an
    eye on already cooking topics: whether any of them contain new
    code that should be transformed, and how they progress to
    'master', and sending followup patch(es) with the remaining
    transformations when applicable.
    
    Futhermore, the author should also pay attention to any new topics
    that branch off after the "pending" semantic patch, and whether
    any of them introduce code to be transformed, warning their
    authors as necessary.

  - Finally, after all the dust settled, the dev should follow up with
    a patch to:
    
      - promote the "penging" patch to '<name>.cocci', if its purpose
        is to avoid undesirable code patterns in the future, or
    
      - remove the semantic patch, if it was used in a one-off
        transformation.

Thoughts?


  -- >8 --

Subject: [PATCH] coccinelle: add support for "pending" semantic patches

(should add a 'contrib/coccinelle/README' to explain what
'.pending.cocci' means)

---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d18ab0fe78..67a4441f39 100644
--- a/Makefile
+++ b/Makefile
@@ -2728,9 +2728,11 @@ endif
 	then \
 		echo '    ' SPATCH result: $@; \
 	fi
-coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
+coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
 
-.PHONY: coccicheck
+coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
+
+.PHONY: coccicheck coccicheck-pending
 
 ### Installation rules
 
-- 
2.19.1.681.g6bd79da3f5



