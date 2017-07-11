Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEF32035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755878AbdGKWCL (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:02:11 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32867 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbdGKWCK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:02:10 -0400
Received: by mail-pg0-f49.google.com with SMTP id k14so2596677pgr.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fAaLrD6CAEFAJPwIR3YGZsHub/pP6YUtqk6iElcpmk4=;
        b=oHD5+QTVAaIWYzzqn5LI4yLOsSqKDfpGOS1UzIxqYM7S6VoDzrHBVtHeYoRjTbZmIc
         scgYryiL8gOXxsw167xilOR54z9Asc0ZCnJLoDyFzJfWmdtf/JY98N3dAYormBY4pArG
         TOmvC/rlLJUK0gM/cPM8bW2qfxHUVKSrtK+zhGKU6Lt7A5TtGXEpoDq3r7e7GRtFpq9f
         6BMDVTVSok5JKSjXSwbM2gW9XGtnM6PUlDeppOxaoP+m5cZviFXpRoXsrCkmH5xZNw5v
         A5JAtNFf1sxc3KUetspp9ECPVMmn19eOwqOCBZLFF7b4Ln2MgeliydulOagUJ8axqHZH
         yWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fAaLrD6CAEFAJPwIR3YGZsHub/pP6YUtqk6iElcpmk4=;
        b=gjquB/WF47L7pA3csQpdw2LoqBVaSo0/Bvi9jCH623eG0giFRzGgd3+Vp6hRLLPyZO
         y5Cd4/0rm7qrs70GVZlj4TSfxIJGP8+i7DpK88RyZllrtlwt5IGw9+y1iIfsZCINNjyF
         q8E45H4wGELn4NVVW6WIBbxixbOF+YQzFPYwn7w92gVLZJpZw0Q+2l9+1zZXcNmBPMj7
         bT5Zri/961uTjzMN1VTS0VJiHagHQca14l9yNV/LqF6FqEzwkByTAPTNJmtag3s7h8cj
         pdAsWI7G9s00nEWUKj2KL+Y+vcgqHLdDqNAjEpq7oTqIFyp1B85VN/JJwCL3nY1ExjYB
         ht6w==
X-Gm-Message-State: AIVw112gG76l/jHQlyGivlZf3Q/AY/dFDF7PFd/7sNNE0ewSOB7yI2Nl
        3jkstgngCmj5zraP8djuZiZpyaP50mYB
X-Received: by 10.84.217.148 with SMTP id p20mr592762pli.148.1499810529932;
 Tue, 11 Jul 2017 15:02:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.129.65 with HTTP; Tue, 11 Jul 2017 15:02:09 -0700 (PDT)
In-Reply-To: <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com> <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 15:02:09 -0700
Message-ID: <CAGZ79kZ8i0Xqp2Yft19JKzPFMUdbzEDNJ01zER9RoM8ZzKPu8A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 12:48 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Currently, Git does not support repos with very large numbers of blobs
> or repos that wish to minimize manipulation of certain blobs (for
> example, because they are very large) very well, even if the user
> operates mostly on part of the repo, because Git is designed on the
> assumption that every blob referenced by a tree object is available
> somewhere in the repo storage.
>
> As a first step to reducing this problem, introduce the concept of
> promised blobs. Each Git repo can contain a list of promised blobs and
> their sizes at $GIT_DIR/objects/promisedblob. This patch contains
> functions to query them; functions for creating and modifying that file
> will be introduced in later patches.
>
> A repository that is missing a blob but has that blob promised is not
> considered to be in error, so also teach fsck this.

Here I wondered what this file looks like, in a later patch you
add documentation:

  +objects/promisedblob::
  +       This file records the sha1 object names and sizes of promised
  +       blobs.
  +

but that leaves more fundamental questions:
* Is that a list of sha1s, separated by LF? (CRLF? How would Windows
  users interact with it, are they supposed to ever modify this file?)
* Similar to .git/packed-refs, would we want to have a first line
  that has some sort of comment?
* In the first question I assumed a linear list, will that be a sorted list,
  or do we want to have some fancy data structure here?
  (critbit tree, bloom filter)
* is the contents in ASCII or binary? (What are the separators?)
* In the future I presume we'd want to quickly answer "Is X in the
  promised blobs list?" so would it be possible (in the future) to
  improve the searching e.g. binary search?
* ... I'll read on to see my questions answered, but I'd guess
  others would prefer to see it in the docs. :)


> + * A mmap-ed byte array of size (missing_blob_nr * ENTRY_SIZE). Each
> + * ENTRY_SIZE-sized entry consists of the SHA-1 of the promised blob and its
> + * 64-bit size in network byte order. The entries are sorted in ascending SHA-1
> + * order.

This seems to be the answer to the docs. :)
So binary representation, the size variable takes a fixed amount, such
that the n-th element in the file is at n * ENTRY_SIZE.


> +       if (st.st_size % ENTRY_SIZE) {
> +               die("Size of %s is not a multiple of %d", filename, ENTRY_SIZE);
> +       }

So it looks as if the file format is an array of ENTRY_SIZE.

Similar to other files, would we want to prefix the file with
a 4 letter magic number and a version number?

> +       prepare_promised_blobs();
> +       result = sha1_entry_pos(promised_blobs, ENTRY_SIZE, 0, 0,
> +                               promised_blob_nr, promised_blob_nr, oid->hash);

IIRC, this is a binary search.

> +int for_each_promised_blob(each_promised_blob_fn cb, void *data)
> +{
> +       struct object_id oid;
> +       int i, r;
> +
> +       prepare_promised_blobs();
> +       for (i = 0; i < promised_blob_nr; i++) {
> +               memcpy(oid.hash, &promised_blobs[i * ENTRY_SIZE],
> +                      GIT_SHA1_RAWSZ);
> +               r = cb(&oid, data);
> +               if (r)
> +                       return r;
> +       }
> +       return 0;
> +}
> diff --git a/promised-blob.h b/promised-blob.h
> new file mode 100644
> index 000000000..a303ea1ff
> --- /dev/null
> +++ b/promised-blob.h
> @@ -0,0 +1,14 @@
> +#ifndef PROMISED_BLOB_H
> +#define PROMISED_BLOB_H
> +
> +/*
> + * Returns 1 if oid is the name of a promised blob. If size is not NULL, also
> + * returns its size.
> + */
> +extern int is_promised_blob(const struct object_id *oid,
> +                           unsigned long *size);
> +
> +typedef int each_promised_blob_fn(const struct object_id *oid, void *data);
> +int for_each_promised_blob(each_promised_blob_fn, void *);
> +
> +#endif
> diff --git a/t/t3907-promised-blob.sh b/t/t3907-promised-blob.sh
> new file mode 100755
> index 000000000..827072004
> --- /dev/null
> +++ b/t/t3907-promised-blob.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +
> +test_description='promised blobs'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'fsck fails on missing blobs' '
> +       rm -rf repo &&

We should not need to delete the repo here, this is the first test?

> +       rm repo/.git/objects/$(echo $HASH | cut -c1-2)/$(echo $HASH | cut -c3-40) &&

Later down the road, do we want to have a
(plumbing) command to move an object from
standard blob to promised blob (as of now I'd think
it would perform this rm call as well as an insert into
the promised blobs file) ?
(Well, we'd also have to think about how to get objects
out of a pack)

With such a command you can easily write your own custom
filter to free up blobs again.


> +       test_must_fail git -C repo fsck

    test_i18n_grep missing out ?

maybe, too? (Maybe that is already tested elsewhere,
so no need for it)


> +'
> +
> +test_expect_success '...but succeeds if it is a promised blob' '
> +       printf "%s%016x" "$HASH" "$(wc -c <repo/1.t)" |
> +               hex_pack >repo/.git/objects/promisedblob &&
> +       git -C repo fsck
> +'
> +
> +test_expect_success '...but fails again with GIT_IGNORE_PROMISED_BLOBS' '
> +       GIT_IGNORE_PROMISED_BLOBS=1 test_must_fail git -C repo fsck &&
> +       unset GIT_IGNORE_PROMISED_BLOBS
> +'

This patch makes sense, so far.

Thanks,
Stefan
