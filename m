Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131051F404
	for <e@80x24.org>; Wed, 18 Apr 2018 05:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeDRFXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 01:23:25 -0400
Received: from mail.javad.com ([54.86.164.124]:54149 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753141AbeDRFXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 01:23:24 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id BFA3C3FF48;
        Wed, 18 Apr 2018 05:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524029003;
        bh=h8Z4fMVBoU2CXdoIvkrCUMwosuIeMqFvxWsBTUYzUxc=; l=5977;
        h=Received:From:To:Subject;
        b=VId5VIEBZjnzIPEJazxJma/6xz91FTm/3RUFjBC19OpoZw2K6ndz9lAJY2ceAl3YB
         vkiGLRO4AgfiYAWOiNVxblfJmTKU08phAog7HuYO77oVOzUQvrGEbHk05HaZv9SB0j
         lovSUqaV4pfzQGSh93BHq2fcbqIVIKcJFpO7978c=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f8fYu-0002tt-2C; Wed, 18 Apr 2018 08:23:20 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <87tvsj6rn2.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <871sfm737e.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8oh51jm.fsf@javad.com>
        <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
        <87sh810ym4.fsf@javad.com>
        <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
Date:   Wed, 18 Apr 2018 08:23:20 +0300
Message-ID: <87a7u12ilz.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Apr 11, 2018 at 10:42 PM, Sergey Organov <sorganov@gmail.com> wrote:
>> Hi Jacob,
>>
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>> On Wed, Apr 11, 2018 at 6:13 AM, Sergey Organov <sorganov@gmail.com> wrote:
>>>> It was rather --recreate-merges just a few weeks ago, and I've seen
>>>> nobody actually commented either in favor or against the
>>>> --rebase-merges.
>>>>
>>>> git rebase --rebase-merges
>>>>
>>>
>>> I'm going to jump in here and say that *I* prefer --rebase-merges, as
>>> it clearly mentions merge commits (which is the thing that changes).
>>
>> OK, thanks, it's fair and the first argument in favor of --rebase-merges
>> I see.
>>
>
> I'd be ok with "--keep-merges" also. I don't like the idea of
> "flatten" as it, to me, means that anyone who wants to understand the
> option without prior knowledge must immediately read the man page or
> they will be confused. Something like "--rebase-merges" at least my
> coworkers got it instantly. The same could be said for "--keep-merges"
> too, but so far no one I asked said the immediately understood
> "--no-flatten".

If they got --rebase-merges instantly, they should already have known
what "rebase" and "merge" mean. If so, they are likely Git users that
are already familiar with "git rebase" and thus at least heard about a
buddy called --preserve-merges. If it's the case indeed, the outcome
you've got was rather predictable, me thinks.

Now, what are the consequences?

When pleasing maximum number of users of --preserve-merges (and probably
--recreate-merges) is number one target of design, while the rest of
issues are secondary, being in favor of --rebase-merges, --keep-merges,
or --<whatever>-merges is only natural indeed.

However, I don't believe meeting user expectations should be the number
one criteria of a good design. Sound technical design should come first,
and meeting user expectations, provided they don't contradict the
design, only second. That's how Git was born, that's how it should
continue to evolve. Going in reverse direction, from user expectations
to design, will give us Bzr, not Git.

In discussing of these patch series though I rather see care for user
expectations or preferences being used as an excuse for questionable
design all the time. That's what actually bothers me much more than
choosing particular names for particular options.

Narrowing back to the topic, don't you see, honestly, that there is
something wrong with:

git rebase --rebase-merges

that is supposedly easy to understand even without referring to the
manual, yet when you do happen to refer to the manual, you suddenly
realize it's not that easy to understand:

--rebase-merges[=(rebase-cousins|no-rebase-cousins)]
	Rebase merge commits instead of flattening the history by replaying
	merges. Merge conflict resolutions or manual amendments to merge
	commits are not rebased automatically, but have to be applied
	manually.

???

Please read the description. Actually read as if you never knew what's
all this about.

Why does it use "flattening the history" that is supposedly hard to
understand to explain "--rebase-merges" that is supposedly easy to
understand? How comes? And if it's actually a good explanation, why
didn't author just call the option --no-flatten-history, to match its
description?

Next, what is "replaying merges", exactly? That's explaining one term
with another that has not being explained and sounds being even more
vague.

Further, "Merge conflict resolutions or manual amendments to merge
commits are not rebased automatically, but have to be applied manually."
is mutually exclusive with "Rebase merge commits", making all this even
more messy. A merge commit is just content with multiple parents, and
`git rebase`, by definition, reapplies the changes the content
introduces. Any "amendments" or "resolutions" that could have been
happening (or not) when that commit was being created are entirely
irrelevant.

Further yet it goes with:

"By default, or when `no-rebase-cousins` was specified, commits which do
not have `<upstream>` as direct ancestor will keep their original branch
point."

Really? What does it actually mean? What is "commit branch point",
exactly? What "direct ancestor" means in this context, exactly? Provided
even when I do know what the option actually does, the description looks
wrong, how it could explain anything?

Having all this right here in the patch series, you guys try to convince
me that it should not be fixed? That it meets user expectations? You
know what? I, as a user, have somewhat higher expectations.

Below is my final attempt at actually defining a sane alternative. If
you still find this approach inferior, please feel free to ignore it. I
added "history" at the end of original --no-flatten, as a courtesy to
user expectations, as you seem to prefer more verbose names:

----------

--flatten-history
	Flatten rebased history by reapplying non-merge commits only.
        This is the default.

--no-flatten-history[=<options>]
	Do not flatten rebased history. When this option is specified,
	the original shape of the history being rebased will be
	preserved. <options> is comma-separated list of supported
	options.

The following options are supported:

'merge-heads' - perform a merge of rebased merge heads instead of
rebasing original merge commits. Only commit messages will be taken from
original merge commits in this mode.

'rebase-cousins' - commits which do not have <upstream> as
direct ancestor will not keep their original branch point.

------------

In fact I think that 'rebase-cousins' should be removed as making no
sense, but I've borrowed it from the original anyway, to show how the
concept of this option itself works to support multiple additional
options.

-- Sergey
