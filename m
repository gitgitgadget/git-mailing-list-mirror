Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3244920437
	for <e@80x24.org>; Wed, 11 Oct 2017 05:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756951AbdJKFC2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 01:02:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754212AbdJKFC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 01:02:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E6D4A0C49;
        Wed, 11 Oct 2017 01:02:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BtPkj8kk8dWkSt6M48/P8QFglik=; b=e+uz2o
        phBpxqlwDjhwG4jaDayPQdwqeL0sjSG0/AOh6NFjOlzxA4rbk/E24idVnQrcs3Jw
        4B5+2mR2tQtjejNqDWR8N23bdV3H+fDfoHu7uZ2Pp86orosQNZjzucPBk2C/DcmG
        08Tvz4rJ+p9GgAE5em0FRJLZBOLpGWjCsuu8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ujdMDIEjl0WdgXAhnkvahbNk4wZW9pCB
        6+2pZfs90EyCyMfNr2Ra9H6BpB7n4MhQkLhmx+r/VtTLxDhw62099sFxisWFomBA
        TaODt2WWeMIndwlv8CiRm3mJHGFf7l18PuNsaSyK6Zaqutzi4CJU8mGuoFUQJ640
        zyAICE15VVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46C53A0C48;
        Wed, 11 Oct 2017 01:02:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB744A0C47;
        Wed, 11 Oct 2017 01:02:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing list <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH] checkout doc: clarify command line args for "checkout paths" mode
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
        <20170930143258.GA20886@alpha.vpn.ikke.info>
        <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
        <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1710010603340.17338@localhost.localdomain>
        <xmqqtvzis87i.fsf@gitster.mtv.corp.google.com>
        <xmqqefqao1av.fsf_-_@gitster.mtv.corp.google.com>
        <20171011032240.GZ19555@aiede.mtv.corp.google.com>
Date:   Wed, 11 Oct 2017 14:02:24 +0900
In-Reply-To: <20171011032240.GZ19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 10 Oct 2017 20:22:40 -0700")
Message-ID: <xmqqzi8ymg4f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F8BA56E-AE41-11E7-8C13-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +'git checkout' [<tree-ish>] [--] <pathspec>...
>> -'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
>> +'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
> ...
> Even for this particular form, the current file is inconsistent about
> whether to call the arguments '<paths>...' or '<pathspec>...'.
> "<paths>..." is even more strange when I think about it for a moment,
> since it is the plural of the plural of path --- i.e., it implies that
> each argument names multiple paths.  Why does this patch use
> <pathspec> for the --no-patch case and <paths> for the --patch case?

No particular reason, other than "the original had <paths>, which
was inherited by the line that was minimally modified, while the
line I typed anew has more preferrable <pathspec>" ;-)

>>  DESCRIPTION
>>  -----------
>> @@ -78,20 +79,13 @@ be used to detach HEAD at the tip of the branch (`git checkout
>>  +
>>  Omitting <branch> detaches HEAD at the tip of the current branch.
>>  
>> +'git checkout' [<tree-ish>] [--] <pathspec>...::
>> +	Restore modified or deleted paths in the working tree by
>> +	replacing with their original contents from the index, or
>> +	the contents from a named <tree-ish> (most often a
>
> This sentence is hard to read:
>
> - "Restore ... in" reads oddly, as though this is an art conservation
>   project that takes place in the working tree.  Is the intent that
>   the command will bring the content of those paths back to the
>   working tree, or something else?

The "restore" was taken from the sentence that was buried in the
paragraph removed by this patch.  I think the original used the
word, fully intending to evoke "an art conservation project"
connotation---after all, the user made a mess in the working tree
and a known-to-be-good copy stored in the index or tree is used to
restore the working tree copy.

> To fix that, it could say
>
> 	Replace matching paths in the working tree with content
> 	from the index or the named tree (most often a commit).  The
> 	<tree-ish> argument can be used to specify a specific tree,
> 	commit, or tag that will be used to update the entries for
> 	matching paths in the index before updating the working tree.

It could (and it was what my earlier draft said), but I found it
less clear than necessary.  It does not matter the data goes from
tree-ish to index and then to the working tree, and a more important
thing is to say both are updated from the tree-ish, for example.

> ... aha, now I see the next paragraph where this text came from.  I
> still think I like my example text based on the first paragraph
> better. :)

And I already said the reason why I started from that and improved
it.

>> @@ -101,6 +95,14 @@ specific side of the merge can be checked out of the index by
>>  using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
>>  file can be discarded to re-create the original conflicted merge result.
>>  
>> +'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
>> +	This is similar to the "check out paths to the working tree
>> +	from either the index or from a tree-ish" mode described
>> +	above, but lets you use the interactive interface to show
>> +	the "diff" output and choose which hunks to use in the
>> +	result.
>
> s/use/apply/, perhaps.

That might sound technically more accurate, but when we consider
that this application is done in reverse, it is probably not such a
good idea to say "apply" here.  The user chooses which one to use,
and the way it is "used" is by applying the hunk in reverse.
"choose the preimage of which hunks to use in the result" may be
more technically accurate, but it is a mouthful.  I dunno.

The interactive UI explains it by saying

	Discard this hunk from worktree?

which is probably the easiest explanation.

> The options section explains --patch again.  Maybe that should point
> back to here to avoid some duplication.

here is another attempt, this time to avoid "Restore" and <paths>...


 Documentation/git-checkout.txt | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d6399c0af8..088266e7e9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
+'git checkout' [<tree-ish>] [--] <pathspec>...
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -78,20 +79,13 @@ be used to detach HEAD at the tip of the branch (`git checkout
 +
 Omitting <branch> detaches HEAD at the tip of the current branch.
 
-'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
+'git checkout' [<tree-ish>] [--] <pathspec>...::
 
-	When <paths> or `--patch` are given, 'git checkout' does *not*
-	switch branches.  It updates the named paths in the working tree
-	from the index file or from a named <tree-ish> (most often a
-	commit).  In this case, the `-b` and `--track` options are
-	meaningless and giving either of them results in an error.  The
-	<tree-ish> argument can be used to specify a specific tree-ish
-	(i.e.  commit, tag or tree) to update the index for the given
-	paths before updating the working tree.
-+
-'git checkout' with <paths> or `--patch` is used to restore modified or
-deleted paths to their original contents from the index or replace paths
-with the contents from a named <tree-ish> (most often a commit-ish).
+	Overwrite paths in the working tree by replacing with the
+	contents in the index or in the <tree-ish> (most often a
+	commit).  When a <tree-ish> is given, the paths that
+	match the <pathspec> are updated both in the index and in
+	the working tree.
 +
 The index may contain unmerged entries because of a previous failed merge.
 By default, if you try to check out such an entry from the index, the
@@ -101,6 +95,14 @@ specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
+	This is similar to the "check out paths to the working tree
+	from either the index or from a tree-ish" mode described
+	above, but lets you use the interactive interface to show
+	the "diff" output and choose which hunks to use in the
+	result.  See below for the descriptoin of `--patch` option.
+
+
 OPTIONS
 -------
 -q::
