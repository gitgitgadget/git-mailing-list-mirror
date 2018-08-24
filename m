Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231991F404
	for <e@80x24.org>; Fri, 24 Aug 2018 01:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHXFT2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 01:19:28 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39543 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHXFT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 01:19:27 -0400
Received: by mail-pf1-f174.google.com with SMTP id j8-v6so3734144pff.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MtO0ZB1x949y4iqB+kgZfbfjWgz569nVd0v12eoIZpg=;
        b=laqo4ndvJhrh6tmbF/j8TZdscQ0/1jwg3qSPvKQxUBCQ4Ncj+kDR4ALTGDsnEfr8fB
         OAME7GspIsRSYkqSY9M344Jevr/riQ+4j3d4bZwaGDhezGAo6e5X+o3TqIdfZy6Jajy+
         3z23y8qns8pIInaL0D9DG2SwRm8yXiOLjdQsOd8yGRyfoWHLtDj1mxOgRgtT+0UN6AH/
         eBFIWdoOWsCC+MHC9PNRQeK3Vm6vLex3ErRZ38T8mL0jdp6iDYuGtp6GZAJugrTiWXeC
         3XKD4y7CoscMqvtaMvtCzTKJ+6celzjNhmdKbL2dKVJpU1h3Wnwbn9RmZvTOGBiTwlo9
         +ArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MtO0ZB1x949y4iqB+kgZfbfjWgz569nVd0v12eoIZpg=;
        b=CEsItDVScRtEReXUjAwPOqPUxuZohJCNhyLfqkAkufHSAtty2TYabHjpqwk2qdun7w
         slfuwUQExj8bXDnrnuEPeeDnheK5I9K6mUH+wEPGeVLS3ETFbi3E76r8jsbm7rV4Otl8
         cSh0Yzd5OqdhulfBjo6wsRtKvxQAskqJkHNle6YEkjPjG7cI0uglaLPa3wR1FFJi2LdZ
         hpswzz650dwaCT7SHp264SXS6Duxn5U01reZp7VDGcfhByANyNo1eKlapruKy8SNiJiE
         Uae7HEWhkqpLOVIainU5YZkHHZT9IA/TCfOaRF9re2skq7G6vTlLFaQcyfKvvcbRA6BP
         XH3A==
X-Gm-Message-State: AOUpUlFUDeh0uvhcRVc6jCid0Whklw1cNu//Eg8la1SFtbR2uYQDlg+z
        Ie2XZbTcBVZFHhhY0g90p68=
X-Google-Smtp-Source: AA+uWPzXa3rdWjFkkF3NMjvi/+7tB4CkJImYuKoUi+vCNozZsQRc853X5YpYsYCfHJ5fDTTRhm0yqQ==
X-Received: by 2002:a63:3587:: with SMTP id c129-v6mr31424553pga.290.1535075225595;
        Thu, 23 Aug 2018 18:47:05 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t12-v6sm7159468pgg.72.2018.08.23.18.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 18:47:04 -0700 (PDT)
Date:   Thu, 23 Aug 2018 18:47:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180824014703.GE99542@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t4xfaes.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> I wanted to send another series to clarify things in
> hash-function-transition.txt, but for some of the issues I don't know
> the answer, and I had some questions after giving this another read.

Thanks for looking it over!  Let's go. :)

[...]
>> Objective
>> ---------
>> Migrate Git from SHA-1 to a stronger hash function.
>
> Should way say "Migrate Git from SHA-1 to SHA-256" here instead?
>
> Maybe it's overly specific, i.e. really we're also describnig how /any/
> hash function transition might happen, but having just read this now
> from start to finish it takes us a really long time to mention (and at
> first, only offhand) that SHA-256 is the new hash.

Well, the objective really is to migrate to a stronger hash function,
and that we chose SHA-256 is part of the details of how we chose to do
that.  So I think this would be a misleading change.

You can tell that I'm not just trying to justify after the fact
because the initial version of the design doc at [*] already uses this
wording, and that version assumed that the hash function was going to
be SHA-256.

[*] https://public-inbox.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com/

[...]
>> Non-Goals
>> ---------
>> 1. Add SHA-256 support to Git protocol. This is valuable and the
>>    logical next step but it is out of scope for this initial design.
>
> This is a non-goal according to the docs, but now that we have protocol
> v2 in git, perhaps we could start specifying or describing how this
> protocol extension will work?

Yes, that would be great!  But I suspect it's cleanest to do so in a
separate doc.  That would allow clarifying this part, by pointing to
the protocol doc.

[...]
>> 3. Intermixing objects using multiple hash functions in a single
>>    repository.
>
> But isn't that the goal now per "Translation table" & writing both SHA-1
> and SHA-256 versions of objects?

No, we don't write both versions of objects.  The translation records
both names of an object.

[...]
>>   - For each object format:
>>     - 4-byte format identifier (e.g., 'sha1' for SHA-1)
>
> So, given that we have 4-byte limit and have decided on SHA-256 are we
> just going to call this 'sha2'?

Good question.  'sha2' sounds fine to me.  If we want to do
SHA-512/256 later, say, we'd just have to come up with a name for that
at that point (and it doesn't have to be ASCII).

>                                 That might be confusingly ambiguous

This is a binary format.  Are you really worried that people are going
to misinterpret the magic numbers it contains?

> since SHA2 is a standard with more than just SHA-256, maybe 's256', or
> maybe we should give this 8 bytes with trailing \0s so we can have
> "SHA-1\0\0\0" and "SHA-256\0"?

For what it's worth, if that's the alternative, I'd rather have four
random bytes.

[...]
>> The loose object index is protected against concurrent writes by a
>> lock file $GIT_OBJECT_DIR/loose-object-idx.lock. To add a new loose
>> object:
>>
>> 1. Write the loose object to a temporary file, like today.
>> 2. Open loose-object-idx.lock with O_CREAT | O_EXCL to acquire the lock.
>> 3. Rename the loose object into place.
>> 4. Open loose-object-idx with O_APPEND and write the new object
>> 5. Unlink loose-object-idx.lock to release the lock.
>>
>> To remove entries (e.g. in "git pack-refs" or "git-prune"):
>>
>> 1. Open loose-object-idx.lock with O_CREAT | O_EXCL to acquire the
>>    lock.
>> 2. Write the new content to loose-object-idx.lock.
>> 3. Unlink any loose objects being removed.
>> 4. Rename to replace loose-object-idx, releasing the lock.
>
> Do we expect multiple concurrent writers to poll the lock if they can't
> aquire it right away? I.e. concurrent "git commit" would block? Has this
> overall approach been benchmarked somewhere?

Git doesn't support concurrent "git commit" today.

My feeling is that if loose object writing becomes a performance
problem, we should switch to writing packfiles instead (as "git
receive-pack" already does).  So when there's a choice between better
performance of writing loose objects and simplicity, I lean toward
simplicity (though that's not absolute, there are definitely tradeoffs
to be made).

Earlier discussion about this had sharded loose object indices for
each xy/ subdir.  It was more complicated, for not much gain.

[...]
> Maybe I've missed some subtlety where that won't work, I'm just
> concerned that something that's writing a lot of objects in parallel
> will be slowed down (e.g. the likes of BFG repo cleaner).

BFG repo cleaner is an application like fast-import that is a good fit
for writing packs, not loose objects.

[...]
>> Since all operations that make new objects (e.g., "git commit") add
>> the new objects to the corresponding index, this mapping is possible
>> for all objects in the object store.
>
> Are we going to need a midx version of these mapping files? How does
> midx fit into this picture? Perhaps it's too obscure to worry about...

That's a great question!  I think the simplest answer is to have a
midx only for the primary object format and fall back to using
ordinary idx files for the others.

The midx format already has a field for hash function (thanks,
Derrick!).

[...]
>> 5. clean up: remove the SHA-1 based pack file, index, and
>>    topologically sorted list obtained from the server in steps 1
>>    and 2.
>
> Doesn't this process require us to implement a "fetch quarantine"? Least
> we have (e.g. other concurrent fetches) referencing those new SHA-1
> objects we've fetched in a pack that we'll remove in step #5?

During a fetch today, objects aren't accessible until the
corresponding .idx file has been put in place.

[...]
>> The user can also explicitly specify which format to use for a
>> particular revision specifier and for output, overriding the mode. For
>> example:
>>
>> git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
>
> How is this going to interact with other peel syntax? I.e. now we have
> <object>^{commit} <sha>^{tag} etc. It seems to me we'll need not ^{sha1}
> but ^{sha1:<current_type>}, e.g. ^{sha1:commit} or ^{sha1:tag}, with
> current ^{} being a synonym for ^{sha1:}.
>
> Or is this expected to be chained, as e.g. <object>^{tag}^{sha256} ?

Great question.  The latter (well, <hexdigits>^{sha256}^{tag}, not the
other way around).

>> Transition plan
>> ---------------
>
> One thing that's not covered in this document at all, which I feel is
> missing, is how we're going to handle references to old commit IDs in
> commit messages, bug trackers etc. once we go through the whole
> migration process.
>
> I.e. are users who expect to be able to read old history and "git show
> <sha1 I found>" expected to maintain a repository that has a live
> sha1<->sha256 mapping forever, or could we be smarter about this and
> support some sort of marker in the repository saying "maintain the
> mapping up until this point".

That's a good question, too.  My feeling is that such a selective
mapping could be invented later and would want to work differently
than this design.  The important thing with this design is that the
information is not lost, so the door to implementing that is not
closed.

As a brief strawman of what I mean, I wouldn't be surprised if
projects want to distribute a simple signed flat sha1<->sha256 mapping
table for commits from "before the SHA-256 era", and Git could learn
to consume that.

Thanks,
Jonathan
