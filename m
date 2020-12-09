Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F754C19425
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F0023CD5
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbgLIU1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:27:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51455 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388466AbgLIU1K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:27:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F6C8110743;
        Wed,  9 Dec 2020 15:26:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7SaaI8QKYdJvvQSVeTFpRqc00uM=; b=bjbVYP
        ++gMhW2gA0V27eYnOVhETK5wT2nfkbh43v+g49FWYlQjbfrYWjCOjCO32TWICOlC
        Ls+FSdY/Qf2wuwnsOrKyrXCfnO/32ZIh6y9Z9iZ1INWN6usCrVydJkSdEil2oO5j
        dl5Ib78Cws3VxH3OeDI4cWjC9/G+DM7IkC/1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=so53I97WK2e8tQQqfWNrjc8/8HMaolrJ
        l7oHpNpwkNUyVWCDFXlwtnkA4Qvlgai4VdO0VvIGNgadNCG5e0kg+11Szxvs/WyS
        zg8v9rtelH9k8C/V1jDlzSaFmN4yBObhqaE+qMcZRI2UvoKh1zL9Rl5JQp5Wd4tm
        Ax+Y0DCDEuA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18014110742;
        Wed,  9 Dec 2020 15:26:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B67E0110741;
        Wed,  9 Dec 2020 15:26:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Julien Richard via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julien Richard <jairbubbles@hotmail.com>,
        Julien Richard <julien.richard@ubisoft.com>
Subject: Re: [PATCH] doc: 'T' status code for git status
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
        <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
Date:   Wed, 09 Dec 2020 12:26:19 -0800
In-Reply-To: <X9ELRf7s9sBcs9CD@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 9 Dec 2020 12:37:09 -0500")
Message-ID: <xmqqsg8e20b8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC851330-3A5C-11EB-9D7E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wonder if we need a little more, though. The list here:
>
>> --- a/Documentation/git-status.txt
>> +++ b/Documentation/git-status.txt
>> @@ -197,6 +197,7 @@ codes can be interpreted as follows:
>>  * 'R' = renamed
>>  * 'C' = copied
>>  * 'U' = updated but unmerged
>> +* 'T' = type changed
>>  
>>  Ignored files are not listed, unless `--ignored` option is in effect,
>>  in which case `XY` are `!!`.
>
> is followed by a table showing the meaning of those entries in each
> slot. Should there be some "T" entries there, too?
>
> I think it could basically show up anywhere that "M" could.

Meaning something like the patch attached at the end, perhaps?

> It is correctly documented in the diff manpage. There we define it as
> "change in the type of the file". I'm not sure if that's really making
> anything clearer than "type changed". ;)
>
> Perhaps "type changed (e.g., a symbolic link becoming a file)" would be
> more descriptive, but I'm not sure it's necessary. (And if so, it
> probably would be better placed in the diff documentation).

Sitting next to existing copied, renamed, and updated-but-unmerged,
the extra explanation in parentheses looks a bit out of place.  It
does make sense to have it described in the diff documentation, but
I think it already is covered adequately over there.

Another thing I noticed while looking at the context is that
"updated but" is misleading.  You might be in the middle of a merge,
and the path may have been modified in their history as well as
somewhere in your history, but the change in your history may be far
in the past that you do not even care or remember.  As far as you
are concerned, you didn't update it (e.g. relative to HEAD) at all.
It simply is "unmerged"---if you take a look at the conflicted
contents, saved it and then perhaps "git add" it, you may now be
able to call the path "updated", but at that point it is no longer
"unmerged".

Thanks.


A few things about the attached.

 - it drops "updated but" from the explanation of 'U' in the list.

 - after that, everything in the list becomes a single-word, so
   instead of "type changed", it invents a verb "type-change" and
   uses its pp. form when adding an entry for 'T'.

 - it updates the table to add 'T' next to 'M'.

 - "work tree changed since index" in the table was awkward; it
   rephrases it to "modified in work tree relative to index",
   because (1) these entries are not talking about the working tree
   as a whole; it is one path in the working tree changing its
   type. and (2) using "changed" and "updated" for the same 'M' in
   different context was unnecessarily confusing.  Instead, it uses
   'modified', which appears in the list before the table.
 
 - The "not updated" line was using a leading "\t"ab, and that is
   why the preimage appears unaligned; the patch updates the line to
   use 8 spaces (i.e. ' ' for X and 7 spaces to align).

 Documentation/git-status.txt | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git c/Documentation/git-status.txt w/Documentation/git-status.txt
index 7731b45f07..2e4b761ecc 100644
--- c/Documentation/git-status.txt
+++ w/Documentation/git-status.txt
@@ -196,7 +196,8 @@ codes can be interpreted as follows:
 * 'D' = deleted
 * 'R' = renamed
 * 'C' = copied
-* 'U' = updated but unmerged
+* 'U' = unmerged
+* 'T' = type-changed
 
 Ignored files are not listed, unless `--ignored` option is in effect,
 in which case `XY` are `!!`.
@@ -204,15 +205,17 @@ in which case `XY` are `!!`.
 ....
 X          Y     Meaning
 -------------------------------------------------
-	 [AMD]   not updated
-M        [ MD]   updated in index
-A        [ MD]   added to index
+        [AMTD]   not changed
+M       [ MTD]   modified in index
+T       [ MTD]   type-changed in index
+A       [ MTD]   added to index
 D                deleted from index
-R        [ MD]   renamed in index
-C        [ MD]   copied in index
-[MARC]           index and work tree matches
-[ MARC]     M    work tree changed since index
-[ MARC]     D    deleted in work tree
+R       [ MTD]   renamed in index
+C       [ MTD]   copied in index
+[MTARC]          index and work tree matches
+[ MTARC]    M    modified in work tree relative to index
+[ MTARC]    T    type-changed in work tree relative to index
+[ MTARC]    D    deleted in work tree
 [ D]        R    renamed in work tree
 [ D]        C    copied in work tree
 -------------------------------------------------
