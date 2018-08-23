Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E011F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbeHWRcq (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 13:32:46 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43359 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbeHWRcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 13:32:46 -0400
Received: by mail-ed1-f42.google.com with SMTP id z27-v6so1385896edb.10
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=Quk9alqrsmD67E37aoo/Ae539ebpX4BcvdsecIkm7Q4=;
        b=MGjpliksCoTpOag2osT7EOLjMki7txIL2/GIn01wqZaRVAo31CHjVACfYDdYqlFOeI
         W4xXR+OqAxFQ0hrVgVg/YqvnePOMDtVjPV58avJ8C79+UshdxGzdOHpr6gnE306/p7nD
         x+EvUR7QADA/7OG1RCNo9EbeQSMbsX4zMVzfL2Mm2wpEByr9Sihj8DCTknSYNoXXeVyC
         h1grJhv8otlM2jFNEb31AXboZlvrHp6sq8C5Em8vIw39u6Hi+qkRRAOhC93JeYm5yT/E
         JikqCXtQ3vqWE4kMcwD4vaiCwJT7+eY+f7mAwsuoig0kTirIpi2oxxNULUGmkKAbyboK
         jykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=Quk9alqrsmD67E37aoo/Ae539ebpX4BcvdsecIkm7Q4=;
        b=d2vOlgc8HYxKu8ADKiZ/yulW/3wMxWHLmDuFEbtjH4dSMJImg8Md/mgShBJ5XN8e+J
         aTn2j3qgCh/IPGr103mK4gLED3rvGkl7wh4lFvxJf3ix7QRBcSKQjuLpo1vwFOMw9O3F
         YcxYx9zSc8MhvTC+2o3S7kjPOw5+w/x0MkEaKCnay1Au0s5MZOcwOPMVw92I4kIWL/JL
         M2/Krim8TqibnacHnzG5cgbiisGekupmoUyP6/l/aMUxiyjGrgAGkRk9p+4XGjJR1FoS
         mtEOxRcslzYWfuTWVZ6KG8ftg+xg7eTLIV4XYYn0SiiBi8wQCY8bTlMI7CDOsC8uC7QG
         HMNg==
X-Gm-Message-State: AOUpUlEOXxm0CQ+CrS+/vzRSPby6WXDc0nG8mriE1VBu1i/SRCSO6DMw
        JzConskjY4DPCPsYdbJLEXpWZY65ANc=
X-Google-Smtp-Source: AA+uWPwKilZA1As57TmNEDHG//oVKo1HuYtSSMjGGV8NU9eyahMkg3ob7LwtUhU969cxEGSR6Esb4A==
X-Received: by 2002:a50:8cd7:: with SMTP id r23-v6mr19487105edr.240.1535032972996;
        Thu, 23 Aug 2018 07:02:52 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id a5-v6sm1970509edr.1.2018.08.23.07.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 07:02:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Questions about the hash function transition
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Thu, 23 Aug 2018 16:02:51 +0200
Message-ID: <878t4xfaes.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wanted to send another series to clarify things in
hash-function-transition.txt, but for some of the issues I don't know
the answer, and I had some questions after giving this another read.

So let's discuss that here first. Quoting from the document (available
at
https://github.com/git/git/blob/v2.19.0-rc0/Documentation/technical/hash-function-transition.txt)

> Git hash function transition
> ============================
>
> Objective
> ---------
> Migrate Git from SHA-1 to a stronger hash function.

Should way say "Migrate Git from SHA-1 to SHA-256" here instead?

Maybe it's overly specific, i.e. really we're also describnig how /any/
hash function transition might happen, but having just read this now
from start to finish it takes us a really long time to mention (and at
first, only offhand) that SHA-256 is the new hash.

> [...]
> Goals
> -----
> 1. The transition to SHA-256 can be done one local repository at a time.
>    a. Requiring no action by any other party.
>    b. A SHA-256 repository can communicate with SHA-1 Git servers
>       (push/fetch).
>    c. Users can use SHA-1 and SHA-256 identifiers for objects
>       interchangeably (see "Object names on the command line", below).
>    d. New signed objects make use of a stronger hash function than
>       SHA-1 for their security guarantees.
> 2. Allow a complete transition away from SHA-1.
>    a. Local metadata for SHA-1 compatibility can be removed from a
>       repository if compatibility with SHA-1 is no longer needed.
> 3. Maintainability throughout the process.
>    a. The object format is kept simple and consistent.
>    b. Creation of a generalized repository conversion tool.
>
> Non-Goals
> ---------
> 1. Add SHA-256 support to Git protocol. This is valuable and the
>    logical next step but it is out of scope for this initial design.

This is a non-goal according to the docs, but now that we have protocol
v2 in git, perhaps we could start specifying or describing how this
protocol extension will work?

> [...]
> 3. Intermixing objects using multiple hash functions in a single
>    repository.

But isn't that the goal now per "Translation table" & writing both SHA-1
and SHA-256 versions of objects?

> [...]
> Pack index
> ~~~~~~~~~~
> Pack index (.idx) files use a new v3 format that supports multiple
> hash functions. They have the following format (all integers are in
> network byte order):
>
> - A header appears at the beginning and consists of the following:
>   - The 4-byte pack index signature: '\377t0c'
>   - 4-byte version number: 3
>   - 4-byte length of the header section, including the signature and
>     version number
>   - 4-byte number of objects contained in the pack
>   - 4-byte number of object formats in this pack index: 2
>   - For each object format:
>     - 4-byte format identifier (e.g., 'sha1' for SHA-1)

So, given that we have 4-byte limit and have decided on SHA-256 are we
just going to call this 'sha2'? That might be confusingly ambiguous
since SHA2 is a standard with more than just SHA-256, maybe 's256', or
maybe we should give this 8 bytes with trailing \0s so we can have
"SHA-1\0\0\0" and "SHA-256\0"?

> [...]
> - The trailer consists of the following:
>   - A copy of the 20-byte SHA-256 checksum at the end of the
>     corresponding packfile.
>
>   - 20-byte SHA-256 checksum of all of the above.

We need to update both of these to 32 byte, right? Or are we planning to
truncate the checksums?

This seems like just a mistake when we did s/NewHash/SHA-256/g, but then
again it was originally "20-byte NewHash checksum" ever since 752414ae43
("technical doc: add a design doc for hash function transition",
2017-09-27), so what do we mean here?

> Loose object index
> ~~~~~~~~~~~~~~~~~~
> A new file $GIT_OBJECT_DIR/loose-object-idx contains information about
> all loose objects. Its format is
>
>   # loose-object-idx
>   (sha256-name SP sha1-name LF)*
>
> where the object names are in hexadecimal format. The file is not
> sorted.
>
> The loose object index is protected against concurrent writes by a
> lock file $GIT_OBJECT_DIR/loose-object-idx.lock. To add a new loose
> object:
>
> 1. Write the loose object to a temporary file, like today.
> 2. Open loose-object-idx.lock with O_CREAT | O_EXCL to acquire the lock.
> 3. Rename the loose object into place.
> 4. Open loose-object-idx with O_APPEND and write the new object
> 5. Unlink loose-object-idx.lock to release the lock.
>
> To remove entries (e.g. in "git pack-refs" or "git-prune"):
>
> 1. Open loose-object-idx.lock with O_CREAT | O_EXCL to acquire the
>    lock.
> 2. Write the new content to loose-object-idx.lock.
> 3. Unlink any loose objects being removed.
> 4. Rename to replace loose-object-idx, releasing the lock.

Do we expect multiple concurrent writers to poll the lock if they can't
aquire it right away? I.e. concurrent "git commit" would block? Has this
overall approach been benchmarked somewhere?

I wonder if some lock-less variant of this would perform
better. E.g. that we'd consult not one, but any
loose-object-{1..Inf}.idx files written in sequence, and we's specify
that each file would contain no more than N mappings.

Then writers could stat() the file to figure out if it has more than N
already by looking at the size (we have fixed-width records). Once we've
filled loose-object-1.idx we start writing to loose-object-2.idx and so
on.

The advantage of this is that writers wouldn't have to block one
another, and could just O_APPEND write to the file(s), although we could
end up with duplicate entries (which readers would need to tolerate).

Then some GC process could look at the set of loose-object-{1..Inf}.idx
files, find one that was at the max size (or slightly above, due to the
O_APPEND race condition), and whose mtime was deemed old enough to be
"safe" (to guard against an hours-long git-commit writing to it),
compact it, and rename a new one in-place, or better yet get rid of it
in favor of a pack).

Maybe I've missed some subtlety where that won't work, I'm just
concerned that something that's writing a lot of objects in parallel
will be slowed down (e.g. the likes of BFG repo cleaner).

> Translation table
> ~~~~~~~~~~~~~~~~~
> The index files support a bidirectional mapping between sha1-names
> and sha256-names. The lookup proceeds similarly to ordinary object
> lookups. For example, to convert a sha1-name to a sha256-name:
>
>  1. Look for the object in idx files. If a match is present in the
>     idx's sorted list of truncated sha1-names, then:
>     a. Read the corresponding entry in the sha1-name order to pack
>        name order mapping.
>     b. Read the corresponding entry in the full sha1-name table to
>        verify we found the right object. If it is, then
>     c. Read the corresponding entry in the full sha256-name table.
>        That is the object's sha256-name.
>  2. Check for a loose object. Read lines from loose-object-idx until
>     we find a match.
>
> Step (1) takes the same amount of time as an ordinary object lookup:
> O(number of packs * log(objects per pack)). Step (2) takes O(number of
> loose objects) time. To maintain good performance it will be necessary
> to keep the number of loose objects low. See the "Loose objects and
> unreachable objects" section below for more details.
>
> Since all operations that make new objects (e.g., "git commit") add
> the new objects to the corresponding index, this mapping is possible
> for all objects in the object store.

Are we going to need a midx version of these mapping files? How does
midx fit into this picture? Perhaps it's too obscure to worry about...

> Reading an object's sha1-content
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> The sha1-content of an object can be read by converting all sha256-names
> its sha256-content references to sha1-names using the translation table.
>
> Fetch
> ~~~~~
> Fetching from a SHA-1 based server requires translating between SHA-1
> and SHA-256 based representations on the fly.
>
> SHA-1s named in the ref advertisement that are present on the client
> can be translated to SHA-256 and looked up as local objects using the
> translation table.
>
> Negotiation proceeds as today. Any "have"s generated locally are
> converted to SHA-1 before being sent to the server, and SHA-1s
> mentioned by the server are converted to SHA-256 when looking them up
> locally.
>
> After negotiation, the server sends a packfile containing the
> requested objects. We convert the packfile to SHA-256 format using
> the following steps:
>
> 1. index-pack: inflate each object in the packfile and compute its
>    SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
>    objects the client has locally. These objects can be looked up
>    using the translation table and their sha1-content read as
>    described above to resolve the deltas.
> 2. topological sort: starting at the "want"s from the negotiation
>    phase, walk through objects in the pack and emit a list of them,
>    excluding blobs, in reverse topologically sorted order, with each
>    object coming later in the list than all objects it references.
>    (This list only contains objects reachable from the "wants". If the
>    pack from the server contained additional extraneous objects, then
>    they will be discarded.)
> 3. convert to sha256: open a new (sha256) packfile. Read the topologically
>    sorted list just generated. For each object, inflate its
>    sha1-content, convert to sha256-content, and write it to the sha256
>    pack. Record the new sha1<->sha256 mapping entry for use in the idx.
> 4. sort: reorder entries in the new pack to match the order of objects
>    in the pack the server generated and include blobs. Write a sha256 idx
>    file
> 5. clean up: remove the SHA-1 based pack file, index, and
>    topologically sorted list obtained from the server in steps 1
>    and 2.

Doesn't this process require us to implement a "fetch quarantine"? Least
we have (e.g. other concurrent fetches) referencing those new SHA-1
objects we've fetched in a pack that we'll remove in step #5?

> [...]
> The user can also explicitly specify which format to use for a
> particular revision specifier and for output, overriding the mode. For
> example:
>
> git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}

How is this going to interact with other peel syntax? I.e. now we have
<object>^{commit} <sha>^{tag} etc. It seems to me we'll need not ^{sha1}
but ^{sha1:<current_type>}, e.g. ^{sha1:commit} or ^{sha1:tag}, with
current ^{} being a synonym for ^{sha1:}.

Or is this expected to be chained, as e.g. <object>^{tag}^{sha256} ?

> Transition plan
> ---------------

One thing that's not covered in this document at all, which I feel is
missing, is how we're going to handle references to old commit IDs in
commit messages, bug trackers etc. once we go through the whole
migration process.

I.e. are users who expect to be able to read old history and "git show
<sha1 I found>" expected to maintain a repository that has a live
sha1<->sha256 mapping forever, or could we be smarter about this and
support some sort of marker in the repository saying "maintain the
mapping up until this point".

Then, along with some v2 protocol extension to transfer such a
historical mapping (and perhaps a default user option to request it)
we'd be guaranteed to be able to read old log messages and "git show"
them, and servers could avoid breaking past URLs without maintaining the
mapping going forward.

One example of this on the server is that on GitLab (I don't know how
GitHub does this) when you reference a commit from e.g a bug, a
refs/keep-around/<sha1> is created, to make sure it doesn't get GC'd.

Those sorts of hosting providers would like to not break *existing*
links, without needing to forever maintain a bidirectional mapping.
