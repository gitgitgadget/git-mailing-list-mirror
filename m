Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93BB20281
	for <e@80x24.org>; Fri, 15 Sep 2017 21:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdIOVdd (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 17:33:33 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:43344 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdIOVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:33:32 -0400
Received: by mail-wm0-f45.google.com with SMTP id a137so4575676wma.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H8mynL8R83KbAQmSVEjEpBj1yELNAiLpvSuC5eVKvqg=;
        b=pX4GiUJp9L/HJJgfh8TSE9nabhV3O7gKg+/z3t6KMVNV8AgK7IfaI3U6mZBU4dr3zT
         XoiJ8KASuWzpGWR3Bnzde1DHPti129TiNZv2g304hi63YDRtgCkhfUnmoDWbdwI0ORqd
         jWH/1shvl38bKSuVfEcb6dx2ye+bRT5pdOJVGysioDaLegFrG22ldqKWlnCzggRfrld8
         7krjMLOsZkobnvF3IlJ7tfziQ/eIHcIHtXT6QPx2Jkyf1o60TOutaIhfNFLbtFKGF0nO
         IoxXj7d629F9hOfG/zyrqwk8FBjhckuJJPXfmJu7T1zRGIYBFy/FxmFj0Xp0Vcrf3y38
         tbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H8mynL8R83KbAQmSVEjEpBj1yELNAiLpvSuC5eVKvqg=;
        b=e4MuAUFcVgB6DHJK+8FPtCDVGswCZ/8tD8iUSdagY9yU4DEPAvZgehpyWohPTym/7l
         gwDkXgKqRSK+zFACorYnS5+/zzOAmSyNAsin7GHF+iziqdp52m2lsTr1GHbjxnYRsVGl
         WyCPyzf30Cd8pQ+emH8vFFs1DEazNqK42SH1HZbx79RMQihfBW7QfGpVECXvw1eaamyt
         F8QH01H1IYshmsqKE0TcwXdMJaGTlGRwDpvFu8/NNdBARWYBPbab8/t/UJjd2Tyx52aU
         75noHV6l+KxT3KPwP3VN/kKs/eSXz1hVRvWBd0qAPOG1EKW9Wt213OWdAI5FzGGEp4uf
         6u2g==
X-Gm-Message-State: AHPjjUjgQObqzBdEw2ovXJNz3rydLdF34ezyqivmGPJVTeWYZMsXEzFa
        u20sVfO/6UWlSyV7vI86nIWfWFO8e2twJGleCVs=
X-Google-Smtp-Source: ADKCNb4WCKHVmV6nPB834Bwu3RHE2BmpguGQ0C9VZbxUGfXkE7l4V5yF6SaeXTAYBMUK64cC4Bwct3MSIQSx3cLWTP0=
X-Received: by 10.80.204.151 with SMTP id q23mr21361428edi.104.1505511210936;
 Fri, 15 Sep 2017 14:33:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.185 with HTTP; Fri, 15 Sep 2017 14:33:10 -0700 (PDT)
In-Reply-To: <SN1PR21MB00145406332AC0133FDD89F7B76C0@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com> <20170908180050.25188-2-kewillf@microsoft.com>
 <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com> <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com> <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
 <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com> <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
 <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com>
 <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
 <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
 <xmqqy3piz1j4.fsf@gitster.mtv.corp.google.com> <SN1PR21MB0014031012AEC69CED27FADFB76F0@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqh8w4y2se.fsf@gitster.mtv.corp.google.com> <SN1PR21MB00145406332AC0133FDD89F7B76C0@SN1PR21MB0014.namprd21.prod.outlook.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 15 Sep 2017 14:33:10 -0700
Message-ID: <CA+P7+xoUmV64Bm2v2pT2yb3S4Pmt52M5Vfwgj+bGyiRsTZr3Ew@mail.gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 10:21 AM, Kevin Willford <kewillf@microsoft.com> wrote:
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Thursday, September 14, 2017 11:00 PM
>>
>> Kevin Willford <kewillf@microsoft.com> writes:
>>
>> > 1. Does this statement, "I only care about the files in this
>> > sparse checkout, and do not concern me with anything else", mean
>> > that git should not change files outside the sparse-checkout whether
>> > that be in the working directory or in the index?  Or does that only
>> > apply to the working directory and the index version of files can
>> > change to whatever git the git command would do without using
>> > sparse?  For example if I am doing a 'git reset HEAD~1'  should the
>> > version in the index of files outside the sparse not be changed or
>> > change to the HEAD~1 version with the skip-worktree bit on?
>>
>> My understanding of the purpose of "sparse checkout" thing is that
>> the user still wants to create correct whole-tree commit even the
>> user does not have the whole-tree checkout.  The object names for
>> blobs recorded in the index that are meant to be included in the
>> next commit MUST be the same as those that would be in the index
>> when the "sparse" feature is not in use.  "reset HEAD~1" should
>> match the index entries to the tree entries in HEAD~1.  So, the
>> latter, I would think, among your two alternatives.
>>
>> IOW, after "git reset HEAD~", if you drop the skip-worktree bit from
>> all index entries, "git diff --cached HEAD" must say "there is no
>> changes".
>>
>> The only difference between the "sparse" and normal would be that,
>> because the "sparse" user does not intend to change anything outside
>> the "sparse" area, these paths outside her "sparse" area would not
>> materialize on the filesystem.  For the next "write-tree" out of the
>> index to still write the correct tree out, the entries outside her
>> "sparse" area in the index MUST match the tree of the commit she
>> started working from.
>>
>
> Makes sense.  And even though the reset might only change entries
> outside the sparse area and the next status will report "nothing to commit,
> working tree clean",  that's okay because the user hasn't changed
> anything in their sparse area and intended to roll back the index to
> whatever they specified in their reset command.
>
>> > 2. How will this work with other git commands like merge, rebase,
>> > cherry-pick, etc.?
>> > 3. What about when there is a merge conflict with a file that is outside
>> > the sparse checkout?
>>
>> I would say, rather than forbidding such a merge, it should let her
>> see and deal with the conflict by dropping the "this is outside the
>> sparse area, so do not bother materializing it to the filesystem"
>> bit, but tell her loudly what it did ("I checked out a half-merged
>> file outside your sparse-checkout area because you'd need it while
>> resolving the conflict").  By doing things that way, the user can
>> decide if she wants to go ahead and complete the merge, even if the
>> conflict is outside the area she is currently interested in, or
>> postpone the merge and continue working on what she has been working
>> on inside the narrowed-down area first.
>>
>> I do not have a strong opinion whether the sparse-checkout
>> configuration file should be adjusted to match when the command must
>> tentatively bust the sparse checkout area; I'd imagine it can be
>> argued either way.
>>
>> Note that "sparse" is not my itch, and I would not be surprised if
>> those who designed it may want it to work differently from my
>> knee-jerk reaction in the previous two paragraphs, and I may even
>> find such an alternative solution preferable.
>>
>> But it is highly unlikely for any sensible solution would violate
>> the basic premise, i.e. "the indexed contents will stay the same as
>> the case without any 'sparse', so the next write-tree will do the
>> right thing".
>
> There was one other case that I thought about while implementing
> this approach and it is when the user creates a file that is outside their
> sparse definition.  From your explanation above I will attempt to
> explain how I think it should work and please correct me if you see
> it working differently.
>
> The user creates a file that is outside the sparse area and it will show
> up as untracked.  No problem here since the untracked are outside the
> scope of using sparse.  Next the user adds the untracked file to the index.
> The skip-worktree bit should be off and stay off since the user could make
> additional changes and want to add them.  Once the user commits the
> newly created file, I could see turning on the skip-worktree bit and
> removing the file from the working tree after the commit but since
> this was a user initiated action and it is sparse "checkout" it makes
> sense to wait until the next "checkout" command which will use the
> sparse definition to clean this file from the working directory and
> turn on the skip-worktree flag.  If the user wants to continue to use
> the new file, they would need to update their sparse-checkout file
> to include the newly created file so that the next checkout will not
> remove it and turn on the flag.


This makes sense to me, but possibly we should warn when a user tries
to do things with files outside the sparse area? Like when adding a
file warn that it already exists?

Maybe users do expect the ability to add new files and those would
want to get automatically pulled into the "sparse" list? Like if a
user adds a completely new file that's never been in the work tree
before...

Thanks,
Jake
