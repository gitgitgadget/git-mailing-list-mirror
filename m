Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC2520305
	for <e@80x24.org>; Sat, 20 Apr 2019 01:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDTBBz (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 21:01:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43829 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTBBy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 21:01:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id i14so6956899qtr.10
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X8KWCFBI0nr/DU+ceQ8szpZs43ob/Iqc7uYmKgm6II4=;
        b=LaENJx1QyV4Hk9IvE81Amfc4S6np1GLsRp73bj9tEfY6fC6WwWdxdrqQJZj7oUs+gt
         eMnqKUtFXZwbmAupYYhvcJgyj4kxSsaYlQpfa2nAu/wI3wPAatgUel8A5d2M5KSIWwjx
         q3Z3jAHf325lxRoda5WI8Htzrx3i6H+E8bDcSbTQrrxLtuPsPzAjZgs1LpDFqQIhc58C
         RCsiGLYhCkj9Mx8hiUoaFhT2Q85ZtRIwP1AaFCNzUuya2mhM4iJgXcEa5prnd8e8JtYg
         cGrwDGyprO2cCEFGHcW0XEhgZwg7fTlXSjDfoyJLj4Rsq+tO0y56+txyWslswIy1i4r8
         7Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X8KWCFBI0nr/DU+ceQ8szpZs43ob/Iqc7uYmKgm6II4=;
        b=qUtG7HQFF6ERvdMgRvyqbijnMYA4nM8qoveg093x24PrgrYf+A0hEDxEsQoJvyAnPY
         mO6PqB7rlGuiyLIelaLZcNTTLBnBGlx4VsfAIFfPcDf9AjBAUCV90qh6Zwd+JwR/J3Rv
         ImXvSv3mrz255JX/ZATeJzlb6NedXvrR+vwy4jmSmViNfztjLaUPw4Rd8gaNxHckumK4
         zEbnqP8ryODGWUr53XwEW+GYgBP1IwUvArM1HR6biDutPz8yXoq7HQHWzU5scF4uNCuz
         p9DgaDk/pjwle85KwhvZ/bhMwXgzRTSY/7mLfKbHvYBo8hZ6ofrmYlwwIT0kJpEUoB2e
         kSYQ==
X-Gm-Message-State: APjAAAXbuzB3dfQgTjdQ1+lVtwgLgrq9zn1uHUrRG8yzbDMo38Jut3ll
        oOYVujjyaEac6R0vGn80LuU=
X-Google-Smtp-Source: APXvYqw926QRlr5ST9xMVqpw4EZCecixdr9yHwuSge1NEHR11C2Ptq9hItsiluRwKTKI3HgqPrGCLA==
X-Received: by 2002:a0c:98fc:: with SMTP id g57mr5815591qvd.143.1555722113492;
        Fri, 19 Apr 2019 18:01:53 -0700 (PDT)
Received: from [10.0.1.4] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id d17sm2811262qko.93.2019.04.19.18.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 18:01:52 -0700 (PDT)
Subject: Re: [PATCH] t5304: add a test for pruning with bitmaps
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <49e2aa9b-ff22-a8d1-ba72-1c881ff5fab4@gmail.com>
 <20190418194953.GA15249@sigill.intra.peff.net>
 <20190418200827.GB15249@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ba16afb4-25c1-8148-602e-130b0e17fc89@gmail.com>
Date:   Fri, 19 Apr 2019 21:01:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190418200827.GB15249@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2019 4:08 PM, Jeff King wrote:
> On Thu, Apr 18, 2019 at 03:49:53PM -0400, Jeff King wrote:
>> I dunno. I guess it does not hurt to at least to at least make sure this
>> code is running in the normal suite. I don't think that will find the
>> more interesting regressions, but at least saves us the from the most
>> egregious ones ("oops, the whole thing segfaults because somebody
>> changed the API" kinds of things).

That's the level of coverage I was hoping to see. I won't be picky if
the OBJ_TAG case isn't hit or something.

> So here's a test. This goes on top of jk/prune-optim (which is also
> already in master).

[snip]

> +test_expect_success 'trivial prune with bitmaps enabled' '
> +	git repack -adb &&
> +	blob=$(echo bitmap-unreachable-blob | git hash-object -w --stdin) &&
> +	git prune --expire=now &&
> +	git cat-file -e HEAD &&
> +	test_must_fail git cat-file -e $blob
> +'
> +
>  test_done

This test does cover the 'mark_object_seen()' method, which I tested by
removing the "!" in the "if (!obj) die();" condition.

However, my first inclination was to remove the line

	obj->flags |= SEEN;

from the method, and I found that it still worked! This was confusing,
so I looked for places where the SEEN flag was added during bitmap walks,
and it turns out that the objects are marked as SEEN by prepare_bitmap_walk().

This means that we can remove a lot of the implementation from reachable.c
and have the same effect (and drop an iteration through the objects). See the
diff below.

Thoughts?
-Stolee

-->8--

diff --git a/reachable.c b/reachable.c
index 0d00a91de4..7d2762d47f 100644
--- a/reachable.c
+++ b/reachable.c
@@ -159,39 +159,6 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
                                      FOR_EACH_OBJECT_LOCAL_ONLY);
 }

-static void *lookup_object_by_type(struct repository *r,
-                                  const struct object_id *oid,
-                                  enum object_type type)
-{
-       switch (type) {
-       case OBJ_COMMIT:
-               return lookup_commit(r, oid);
-       case OBJ_TREE:
-               return lookup_tree(r, oid);
-       case OBJ_TAG:
-               return lookup_tag(r, oid);
-       case OBJ_BLOB:
-               return lookup_blob(r, oid);
-       default:
-               die("BUG: unknown object type %d", type);
-       }
-}
-
-static int mark_object_seen(const struct object_id *oid,
-                            enum object_type type,
-                            int exclude,
-                            uint32_t name_hash,
-                            struct packed_git *found_pack,
-                            off_t found_offset)
-{
-       struct object *obj = lookup_object_by_type(the_repository, oid, type);
-       if (!obj)
-               die("unable to create object '%s'", oid_to_hex(oid));
-
-       obj->flags |= SEEN;
-       return 0;
-}
-
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
                            timestamp_t mark_recent, struct progress *progress)
 {
@@ -225,7 +192,10 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,

        bitmap_git = prepare_bitmap_walk(revs);
        if (bitmap_git) {
-               traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
+               /*
+                * reachable objects are marked as SEEN
+                * by prepare_bitmap_walk(revs).
+                */
                free_bitmap_index(bitmap_git);
                return;
        }
