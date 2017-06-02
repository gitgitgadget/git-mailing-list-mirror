Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E76C2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFBTiw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:38:52 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32880 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBTiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:38:51 -0400
Received: by mail-pf0-f181.google.com with SMTP id e193so56125939pfh.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KS50lMOhamdo/Ezj7+UKAgYuSciDoAN3lZ7D2T2/akA=;
        b=kV3cBRrWFgMEvxPrqtFTYRTjyPQ6PMHWpJtz0+Hsgmc6S+Zgy3+HMo13+dLg9Y0qCL
         64Vvij7JwO603wB+qoQqdruNPvVAh3OBw8PQ8OYdPjY7duwiX3YiRQkzxv3XE68R4il5
         W0qTsaVtgWOY2iX68aUnnU274wY6pcDCaWOpfE/Pm0g8sbT/DjPROeCp1QCa9pY6Ur9P
         RdvnMHL0yI3YqAAVUbXsbvC9BrDIy8Ppu8xNSJEMuNSBVUOnsEAMsRiXzkwqGFcpb9rk
         Y7cI93nVHKMEFr5qALC/y9zfa2+D+N8kZTBzOCzbWXWuh6WueHAMXELtimdj2LPgJDcY
         dyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KS50lMOhamdo/Ezj7+UKAgYuSciDoAN3lZ7D2T2/akA=;
        b=NiJrDJAhNtGoFb3hvuJoZsWuvZk3iJ8w20+YVKOXDUNBVuGQjouFM6Z3HKZnBI+lKn
         2MCdDHu/Q13gcvSGvuJNjYJ04UMhHlhQhENcRHpESYCmGg4mdcjWjQ/0bmLUk3Ehnu+C
         0Wp/z3ptWBxroUz9RWQt+0cJbVW2XxujtoZmVvPRhqIqCy/T8cR89WojqXlOqGDD2X+R
         OcgVbww9cY+okru1ZmDkwmNO1TCN77/HDI3QQO17s0Eh7QoAKYvHWFXmMnvmMTVXtjXl
         vmnpSm+OUSSJ2L83d4iKlgruDN+1J1LJG/qOiN86AZ2lRdwPzY/L/ZB3jMtMcDbg+Ehq
         9gzw==
X-Gm-Message-State: AODbwcCF9pHPTMsMHriZXg3sLDySsH+SO+aO/Q+j6Au0sb2obORiK82j
        a7LLhJe7DP6j9jVhhYPxcA==
X-Received: by 10.98.92.67 with SMTP id q64mr8433218pfb.117.1496432329956;
        Fri, 02 Jun 2017 12:38:49 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id p89sm42789627pfk.67.2017.06.02.12.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:38:48 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [WIP v2 0/2] Modifying pack objects to support --blob-max-bytes
Date:   Fri,  2 Jun 2017 12:38:43 -0700
Message-Id: <cover.1496432147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd-goog
In-Reply-To: <cover.1496361873.git.jonathantanmy@google.com>
References: <cover.1496361873.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a new version addressing Junio's comments.

> Hmph, that statement is a hard to read and agree to.  I thought an
> ignored object that is not going to be packed is one that won't hit
> to_pack?

That is true currently, but will not be the full truth once the 2nd
patch is applied.  I have expanded the commit message to explain the
plan in more detail.

> It would be nice if the name of the parameter hints that this is
> counted in bytes, e.g. "--blob-max-bytes"; 

Done. Originally I wanted to avoid terms like "max" because this
disallowed the user from requesting that even 0-byte blobs not be sent,
but realized that I probably shouldn't bother about that. :-)

> Do we need to future-proof the output format so that we can later
> use 32-byte hash?  The input to pack-objects (i.e. rev-list --objects)
> is hexadecimal text, and it may not be so bad to make this also
> text, e.g. "<hash> SP <length> LF".  That way, you do not have to
> worry about byte order, hash size, or length limited to uint64.

The reason for using binary is for the convenience of the client to
avoid another conversion before storing it to disk (and also network
savings). In a large repo, I think this list will be quite large. I
realized that I didn't mention anything about this in the commit
message, so I have added an explanation.

I think this is sufficiently future-proof in that the format of this
hash matches the format of the hashes used in the objects in the
packfile. As for object size being limited to uint64, I think the
benefits of the space savings (in using binary) outweigh the small risk
that our files will get larger than that before we upgrade our protocol
:-P

>> ++
>> +If pack-objects cannot efficiently determine, for an arbitrary blob,
>> +that no to-be-packed tree has that blob with a filename beginning with
>> +".git" (for example, if bitmaps are used to calculate the objects to be
>> +packed), it will pack all blobs regardless of size.
>> +
> This is a bit hard to understand, at least to me.  Let me step-wise
> deconstruct what I think you are saying.
> 
>  - A blob can appear in multiple trees, and each tree has name
>    (i.e. pathname component) for the blob.
> 
>  - Sometimes we may know _all_ trees that contain a particular
>    blob and hence _all_ names these trees call this blob.  In such a
>    case, we can _prove_ that the blob never is used as ".git<something>"
>    in any tree.
> 
>  - We exclude a blob that is larger than the specified limit, but
>    only when we can prove the above.  If it is possible that the
>    blob might appear as ".git<something>" in some tree, the blob is
>    not omitted no matter its size.
> 
> And this is a very conservative way to avoid omitting something that
> could be one of those control files like ".gitignore".
> 
> Am I following your thought correctly?

We only need to prove for *to-be-packed* trees (the trees that
pack-objects are about to pack in the packfile(s) that it is printing),
but otherwise, you are correct. I was trying to be thorough in saying
that "if we don't have bitmaps, we know if a blob's name starts with
'.git', so we can do filtering by size, but if we have bitmaps, we don't
have any relevant name information" - any rewording suggestions are
appreciated.

> Can this multiplication overflow (hint: st_mult)?

Thanks - used st_mult.

> This sorting is a part of external contract (i.e. "output in hash
> order" is documented), but is it necessary?  Just wondering.

It is convenient for the client because the client can then store it
directly and binary search when accessing it. (Added a note about
convenience to the commit message.)

> You do want to exclude the trailing thing out of the checksum, but
> CSUM_CLOSE would close the fd and that is why you pass 0 here.  OK.
>
> Even though we are in "pack_to_stdout" codepath, I'd prefer to
> consistently use f->fd, not a hardcoded 1 here.  Of course,
> sha1close() would have freed 'f' at this point, so we need to grab
> the return value from the function to learn which fd is connected to
> our original "stdout" at this point.
> 
> Likewise for write_oversized_info(), which probably should just take
> "int fd" as parameter.

Done for write_oversized_info(), although now that we are moving the
invocation of write_oversized_info() out of write_pack_file(), this
might not be so important. (For the rest, I have reverted the code
because we are now printing the excluded hashes before the packfile
instead of after.)

> I do not necessarily think it is a bad idea to show this as trailing
> data after the pack, but when we come to this function, do we have
> enough information to make the "oversize" information appear before
> the pack data if we wanted to?  I have a suspicion that it is easier
> to handle at the receiving end, after the capability exchange
> decides to use this "omit oversized ones" extension, to receive this
> before the packdata begins.  If it is at the end, the receiver needs
> to spawn either unpack-objects or index-objects to cause it write to
> the disk, but when it does so, it has to have a FD open to read from
> their standard output so that the receiver can grab the "remainder"
> that these programs did not process.  "Write to the end of the pack
> stream data to these programs, and process the remainder ourselves"
> is much harder to arrange, I'd suspect.

Yes, we can write at the beginning - done.

> > +/*
> > + * Returns 1 and records this blob in oversized_blobs if the given blob does
> > + * not meet any defined blob size limits.  Blobs that appear as a tree entry
> > + * whose basename begins with ".git" are never considered oversized.
> > + *
> > + * If the tree entry corresponding to the given blob is unknown, pass NULL as
> > + * name. In this case, this function will always return 0 to avoid false
> > + * positives.
> > + */
> > +static int oversized(const unsigned char *sha1, const char *name) {  
>
> Not object_id?

This would require a "(const struct object_id *) sha1" cast in its
caller that potentially violates alignment constraints, as far as I
know, so I used "const unsigned char *" for now. If the object_id
conversion doesn't include this file in the near future, I'll try to
send out a patch for this file.

> When we have two paths to a blob, and the blob is first fed to this
> function with one name that does not begin with ".git", we would
> register it to the hashmap.  And then the other name that begins
> with ".git" is later discovered to point at the same blob, what
> happens?  Would we need to unregister it from the hashmap elsewhere
> in the code?
[snip]
> Ah, is this where the "unregistering" happens?

Yes.

> >  static int add_object_entry(const unsigned char *sha1, enum object_type type,
> > -			    const char *name, int exclude)
> > +			    const char *name, int preferred_base)  
> 
> This belongs to the previous step that renamed "exclude", no?

Yes - done.

Jonathan Tan (2):
  pack-objects: rename want_.* to ignore_.*
  pack-objects: support --blob-max-bytes

 Documentation/git-pack-objects.txt |  19 ++++-
 builtin/pack-objects.c             | 159 ++++++++++++++++++++++++++++++-------
 t/t5300-pack-object.sh             |  71 +++++++++++++++++
 3 files changed, 220 insertions(+), 29 deletions(-)

-- 
2.13.0.506.g27d5fe0cd-goog

