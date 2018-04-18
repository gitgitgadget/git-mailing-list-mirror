Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2C71F404
	for <e@80x24.org>; Wed, 18 Apr 2018 17:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbeDRRsH (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 13:48:07 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:41539 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDRRsD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 13:48:03 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 8rBXfhrOzLjjA8rBXfWYLH; Wed, 18 Apr 2018 18:48:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524073681;
        bh=ovgwqCL882eynrjhwAMsLx/fwACJvki+tBX8P/Nkavc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IlDCusQ9pRr6B9BY1uxSY/ARUqdcKDuaqMTBKYu1rrwUIz/2Qxo98dyDyYU3I0wKo
         840ADF7EJ34Sx8azYTAV2q514BlcyQ8gYy94LVvIo/mTlSP5rLopuxM55rJYRDuqH5
         vvDDI+eSeK8St0ZweZg8kV/Ph1yu9MwatX+9bAEQ=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=A9qS8gIqAAAA:8 a=7xxdmIC9VglUy3NB3HUA:9 a=U4B_5xhYNvUYCaFo:21
 a=QW4fklozQOg2AFyi:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=H28RkzuXznr5akrmL4QT:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] ident: don't cache default date
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
 <20180418102236.7183-1-phillip.wood@talktalk.net>
 <87vacoeovh.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <85ecb584-77a7-f818-14c9-1019873d87f9@talktalk.net>
Date:   Wed, 18 Apr 2018 18:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87vacoeovh.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIeYouv8fH+oqWJEjDe8VlU+YQMxrYWWXM/8HYuHMi3RTG50kr95g8AnkUjQ/YKVJt7+OGmsv+aRSXFpMWYHt6Zf/uY27KaP/xYP5R0X+rPpzrJoCfKJ
 w1uLmFidkVJWlNpqfXTreViBUNHx+ZxjaDF1W1IoQQobOJL5iXx65N/EVTeA3O6dFqaZtwstmbnwnFYZ6Kli3J0KBSAMfQK+cWRKQZaXFL4mT+uA4KALECqv
 DH8p/+I1RCjuPlrG8mJQSW6sLg2hMo92p2kX8DKYiceiK/R0EJrJtDCH5QiFsdb3ImT0gNuuaYQg4NvrwaRjdZCAaZ2iIPslSTiRXKpe3ZM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar, thanks for your comments

On 18/04/18 12:27, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 18 2018, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Now that the sequencer commits without forking when the commit message
>> isn't edited all the commits that are picked have the same committer
>> date. If a commit is reworded it's committer date will be a later time
> 
> s/it's/its/

Thanks I'll change it

>> as it is created by running an separate instance of 'git commit'.  If
>> the reworded commit is follow by further picks, those later commits
>> will have an earlier committer date than the reworded one. This is
>> caused by git caching the default date used when GIT_COMMITTER_DATE is
>> not set. Fix this by not caching the date.
>>
>> Users expect commits to have the same author and committer dates when
>> the don't explicitly set them. As the date is now updated each time
>> git_author_info() or git_committer_info() is run it is possible to end
>> up with different author and committer dates. Fix this for
>> 'commit-tree', 'notes' and 'merge' by using a single date in
>> commit_tree_extended() and passing it explicitly to the new functions
>> git_author_info_with_date() and git_committer_info_with_date() when
>> neither the author date nor the committer date are explicitly
>> set. 'commit' always passes the author date to commit_tree_extended()
>> and relied on the date caching to have the same committer and author
>> dates when neither was specified. Fix this by setting
>> GIT_COMMITTER_DATE to be the same as the author date passed to
>> commit_tree_extended().
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> Reported-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>
>> I'm slightly nervous that setting GIT_COMMITTER_DATE in
>> builtin/commit.c will break someone's hook script. Maybe it would be
>> better to add a committer parameter to commit_tree() and
>> commit_tree_extended().
>>
>> This needs some tests. I think we could test that the sequencer gives
>> each commit a new date with 'git rebase -i --exec="sleep 2"
>> --force-rebase @~2' and test the committer dates of the rebased
>> commits. I'm not sure if test -gt can cope with numbers that big
>> though, maybe we'll have to be content with test !=. For 'git commit'
>> I think doing GIT_EDITOR='sleep 2; echo message >"$1"' and checking
>> the committer date and author date will work as the author date is set
>> before the user edits the commit message. I'm not sure how to test
>> callers of commit_tree() though (that's commit-tree, notes and merge)
>> as I've not been able to come up with anything that will guarantee the
>> author and committer dates are different if the code in
>> commit_tree_extended() that ensures they are the same gets broken.
> 
> The behavior you're describing where we end up with later commits in the
> rebase with earlier CommitDate's definitely sounds like a minor
> regression, and yeah we should have tests for this.
> 
> My mental model of this is that we shouldn't be trying at all to adjust
> the CommitDate in a sequence to be the same, and just make it be
> whatever time() returns, except in the case where a date is passed
> explicitly.
> 
> My cursory reading of this RFC patch is that it's definitely an
> improvement because we don't end up with things out of order, but is
> there any reason for why we should be trying to aim to keep this
> "consistent" within a single "git rebase" command by default, as opposed
> to always just writing the current CommitDate at the time we make the
> commit, that sounds like the most intuitive thing to me, and I can't see
> any downsides with that.

It's not trying to keep the date "consistent" within a single rebase
command, each commit created by the sequencer gets a date stamp with the
current time when the commit is created. What it is doing is keeping the
author and committer dates the same for commit/commit-tree/merge/notes
when the user does not specify either of them. While I don't think it
particularly matters that they match (so long as the committer date is
later than the author date), it is what git does at the moment and
someone maybe relying on the current behavior.

Best Wishes

Phillip

> 
> It leaks info about how long it took someone to do the rebase, but so
> what?
> 

