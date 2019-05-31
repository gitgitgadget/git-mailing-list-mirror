Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773F31F462
	for <e@80x24.org>; Fri, 31 May 2019 17:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEaRep (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 13:34:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58915 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfEaRep (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 13:34:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66CC167228;
        Fri, 31 May 2019 13:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/t7rePp+IQHWI5IZ0DhdDYGRYvk=; b=O/baDw
        IRMeziVCRHNbp+JvhJpFxBi9/09FWPNVJnyGJXk48uFRflXfXMnOlOLqUJm+TS29
        0QS4lAo4GaPc8SlxGbEx1ZM7zYiY6PwxTcpqPr4hhZ94XI8tj33/P54hPYlfpBa9
        BJEKcntHv5od3QwdlgndpmywENs1McKZc7lSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q6utWm6zYEqxRuZ2E5xYcyl8IkSWSYDq
        TRPLHWYmiEzLkaUs935b8r2AS9+bb5mlKbt/Nf/oPIeZJtuF0NFlprCMA62YkBha
        u8NihBe4OwPRqrx2P4ZPHd0DkF72/1fUioATlieX6ds1FdF8T14r4+URU9zQqX1A
        O7wQukfNLtI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 605F167227;
        Fri, 31 May 2019 13:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8857867226;
        Fri, 31 May 2019 13:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet>
Date:   Fri, 31 May 2019 10:34:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 31 May 2019 14:42:30 +0200 (CEST)")
Message-ID: <xmqq5zpqwms1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EA08740-83CA-11E9-ABFA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 30 May 2019, Junio C Hamano wrote:
>
>> * bb/unicode-12.1-reiwa (2019-05-29) 1 commit
>>   (merged to 'next' on 2019-05-30 at 016465335c)
>>  + unicode: update the width tables to Unicode 12.1
>> <<
>> * bb/unicode-12.1-reiwa (2019-05-29) 1 commit
>>  - unicode: update the width tables to Unicode 12.1
>> >>
>>
>>  Update to Unicode 12.1 width table.
>>
>>  Will cook in 'next'.
>
> I would actually be in favor of merging this before v2.22.0. It's not like
> this is a feature we need to perfect, we just integrate upstream changes.

It is not really an import of "upstream change", when it is
expressed in a form of a table that we invent and let our code read.

The patch coalesces two entries that describe two ranges with
1-codepoint gap into one entry that eliminates the gap in the table,
and I did also read the code that uses the table and I am reasonably
certain that there won't be any bug introduced by this change [*1*],
so in that sense "cook in 'next'" is being overly conservative.

	Side note: *1* if the patch were to extend one end of the
	range so that these two entries describe adjacent two ranges
	without any gap, and if the code that uses the table had a
	bug that gets triggered when given two ranges that do not
	have any gap between them, then without such careful
	inspection, we may have said "this is just upstream changes,
	let's fast-track it" and caused regression.

But I am marking it as such, not due to conservativeness, but mostly
out of principle.  Once we start saying "this is trivial enough, so
let's merge straight to 'master'" for one topic, it will lead to
others jumping up and down saying "that other topic is also
trivially correct" to swamp me, and mistakes are bound to happen.

In other words, as I said in "What's cooking" report one issue ago,
the criteria is no longer "this is obviously correct"---it is "this
is obvious and trivial fix for a regression".

>> * ab/hash-object-doc (2019-05-28) 1 commit
>>  - hash-object doc: stop mentioning git-cvsimport
>>
>>  Doc update.
>>
>>  Will merge to 'next'.
>
> Similarly, I think it would not hurt to merge this before v2.22.0.

Likewise.

More importantly, the above is only is 1/3 of the topic, and while I
am in agreement with the reviewer(s) who were negative on the other
two, we haven't heard a response/rebuttal.

>> * ew/server-info-remove-crufts (2019-05-28) 1 commit
>>   (merged to 'next' on 2019-05-29 at 655ba18f30)
>>  + server-info: do not list unlinked packs
>>
>>  "git update-server-info" used to leave stale packfiles in its
>>  output, which has been corrected.
>>
>>  Will cook in 'next'.
>
> I do dream of the day when we can just get rid of the entire non-smart
> HTTP stuff.

;-)

>> * jk/HEAD-symref-in-xfer-namespaces (2019-05-28) 1 commit
>>   (merged to 'next' on 2019-05-29 at c2cfe38955)
>>  + upload-pack: strip namespace from symref data
>>
>>  The server side support for "git fetch" used to show incorrect
>>  value for the HEAD symbolic ref when the namespace feature is in
>>  use, which has been corrected.
>>
>>  Will cook in 'next'.
>
> This is an older regression, so it should probably be kept in `next` for
> now.

I do not think it is even a regression.  Back when I did the "symref
target in capability", I was aware of, but did not bother being
careful not to break, the "separate namespace" stuff ;-).  I think
it was broken from day one.

>> * mm/p4-unshelve-windows-fix (2019-05-28) 1 commit
>>  - p4 unshelve: fix "Not a valid object name HEAD0" on Windows
>>
>>  The command line to invoke a "git cat-file" command from inside
>>  "git p4" was not properly quoted to protect a caret and running a
>>  broken command on Windows, which has been corrected.
>>
>>  Will merge to 'next'.
>
> Same here, this is a super old regression, and it will not hurt to cook it
> a bit longer.

Also, as (I think) you saw my "git grep", we may want to correct all
the problems with the same root, and the above solve only one of the
two.

>> * po/git-help-on-git-itself (2019-05-16) 2 commits
>>  - Doc: git.txt: remove backticks from link and add git-scm.com/docs
>>  - git.c: show usage for accessing the git(1) help page
>>
>>  "git help git" was hard to discover (well, at least for some
>>  people).
>>
>>  Will merge to 'next'.
>
> I guess it would not hurt anybody (and get a bit more exposure) if it was
> merged before v2.22.0, but it does not fix a problem introduced in this
> cycle, so...

Yeah, I think you already know this but my stance towards these
"would never hurt to merge even in -rc period" topics is to merge
them soon after the final.

>> * ba/clone-remote-submodules (2019-05-28) 1 commit
>>   (merged to 'next' on 2019-05-29 at 71972f94c2)
>>  + clone: add `--remote-submodules` flag
>>
>>  "git clone --recurse-submodules" learned to set up the submodules
>>  to ignore commit object names recorded in the superproject gitlink
>>  and instead use the commits that happen to be at the tip of the
>>  remote-tracking branches from the get-go, by passing the new
>>  "--remote-submodules" option.
>>
>>  Will cook in 'next'.
>
> Are we really sure that this is a good option name? With that description,
> I would have expected `--recurse-submodules=follow-tips` or some such.
>
> In other words, I would have been in favor of keeping this in `pu` for a
> little while longer. But it's already in `next`...

As far as I am concerned, ones in 'next' that is not meant to be
fast-tracked to 'master' during the -rc period are like only in
`pu`.  Soon after the final, when 'next' is rewound, any of them can
be kicked out to give it a fresh start, and it is a good time to
think and nominate which ones to boot and reboot, like you just did.

As to your question, I do not have a strong opinion either way.
Input from folks more invested in submodules, and especially from
those who want to use submodules in non-traditional ways, would be
most welcome.  To me, it feels that the "ignore what gitlink entries
say, and use the commits that happen to be pointed at by refs of a
clone of the submodule you happen to follow" is not really a good
match to the way "gitlink" based Git submodules are designed to be
used, but that mode of the operation is not wrong per-se (it was
just that we did not design the system to support well).

>> * ds/close-object-store (2019-05-28) 3 commits
>>  - packfile: rename close_all_packs to close_object_store
>>  - packfile: close commit-graph in close_all_packs
>>  - commit-graph: use raw_object_store when closing
>>  (this branch uses ds/commit-graph-write-refactor.)
>>
>>  The commit-graph file is now part of the "files that the runtime
>>  may keep open file descriptors on, all of which would need to be
>>  closed when done with the object store", and the file descriptor to
>>  an existing commit-graph file now is closed before "gc" finializes
>>  a new instance to replace it.
>>
>>  Waiting on ds/commit-graph-write-refactor to stabilize.
>
> FWIW I backported this to Git for Windows, as the underlying bug would
> prevent an auto gc from working as intended (iff the commit graph feature
> is turned on, of course).

Yes, I can see how a system that does not allow filesystem
operations on a still-open file would need these three patches.  How
ready is the underlying topic?  IIRC there were a few internal API
details still to be reworked?

Thanks for your thoughtful comments.
