Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC4C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiFHSJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiFHSJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 14:09:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AA140D7
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 11:09:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y15so15498203qtx.4
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aMOs4qMFuAjoyCgPykm1aWZTERK0xGRYC+6EJHjeXHE=;
        b=MA1r583RETQ3WwJ2AGldfw4grHwe7TO1WWomWtwxiBCisH/pDbmQfo4CNMem+UCd3o
         PAIfvlYNx4mX9bOTsjn68AEaOkLyngsAixpxjjbgTnuC1J66+6wbU4I0+FK1pacvtNBL
         KI4H0cDMiiUeSVmAzqRPPBJvz7VOMAXk2C8Yo4YFjUAts/cmYaZ/e581zskLUZKey+0n
         UhyIZLDJhoUsvZDArqeSqRSkV2bqVInN8FqplrkVZ+vohSuqYP6SOb4T+++LR+91pkf/
         WEuER2HXdW2Dmv+4D1j14Aqk6AfCHEuF0UzWBK5Qxg24PkHs09ox6Zrua/Q+mph5BRHR
         T9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aMOs4qMFuAjoyCgPykm1aWZTERK0xGRYC+6EJHjeXHE=;
        b=VCL5f2GC1WCzGMwJcXoggNCrBnJ5sxkEVHtldMuwnmTqodoySbwYW0D1K+/eozzUVH
         0Fuj3mR9/cOqeqxIaQRb+IiURMlaiBxT3lN9+O3vQNwo8JjaXJ+L4n9HHKERYHfXd8jJ
         qjcdeGIKle+gbMaEk9G8rJxK3mlHRzUmspRR1jtyzJ7IfFnJx4kRY28rO6DV2zGoflRY
         b+7gvKlymulWfdgEUv9hGN/Najk4tnSvkS42IcXcM1PEeMEE0sQZd7SHfuipaakwzoWh
         7TpqL9mz9mGb+zPBjaVPqI3W+BaYQ2HGInIH8WqSvk9QeCWhbwu0rx0xauPDgfUZD8GA
         BmkA==
X-Gm-Message-State: AOAM533mr3iFBzS2RijW0K0Sf5ASV/LAojnqqzX2qbTZ5/Mdp9EGMGoU
        ou367O/iBF7TY/LYD1+w99Bl
X-Google-Smtp-Source: ABdhPJyPCIoEce4qZOHAPFSASzfgiOEOuTCyrjaL4IZvnBRsnvf4HN1UPetmiLPETwF8JUESKRGqYA==
X-Received: by 2002:ac8:590b:0:b0:305:35:9f6a with SMTP id 11-20020ac8590b000000b0030500359f6amr4159267qty.122.1654711743903;
        Wed, 08 Jun 2022 11:09:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90ef:16b:eb19:f653? ([2600:1700:e72:80a0:90ef:16b:eb19:f653])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006a6a3f1548bsm12310859qkp.54.2022.06.08.11.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 11:09:03 -0700 (PDT)
Message-ID: <34264915-8a37-62db-f954-0b5297639b34@github.com>
Date:   Wed, 8 Jun 2022 14:09:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/7] rebase: update branches in multi-part topic
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <ac135ece-a901-5868-f28c-2161d7a62e97@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ac135ece-a901-5868-f28c-2161d7a62e97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2022 10:32 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 07/06/2022 21:42, Derrick Stolee via GitGitGadget wrote:
>> [...]
>> As an example, here is my in-progress bundle URI RFC split into subtopics as
>> they appear during the TODO list of a git rebase -i --update-refs:
>>
>> pick 2d966282ff3 docs: document bundle URI standard
>> pick 31396e9171a remote-curl: add 'get' capability
>> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
>> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
>> pick 6adaf842684 fetch: add --bundle-uri option
>> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
>> label for-update-refs/refs/heads/bundle-redo/fetch
>> [...] update-refs
>> [...]
>> Based on some of the discussion, it seemed like one way to do this would be
>> to have an 'update-ref ' command that would take the place of these 'label'
>> commands. However, this would require two things that make it a bit awkward:
>>
>>   1. We would need to replicate the storage of those positions during the
>>      rebase. 'label' already does this pretty well. I've added the
>>      "for-update-refs/" label to help here.
> 
> I'm afraid I don't think that using a label with a name constructed from
> a magic prefix and the full refname is a good user interface.
> 
> (i) Having labels behave differently based on their name is confusing.

The label commands do as advertised, but the 'update-refs' command does
something with the set of refs based on their names, yes. We would need to
store this information during the rebase _somewhere_, and refs/rewritten/
seems natural.
 
> (ii) The length of the label string is cumbersome for users. Rebase already
> has a reputation for being unfriendly and hard to use, this will not improve
> that. "update-ref bundle-redo/fetch" is much simpler.

I agree that your proposed replacement for "label for-update-refs/..." would
look cleaner. I don't think that that is enough to justify hiding information
from the user.

> (iii) It means that we no longer store the oid of each branch when creating> the todo list and so cannot check if it is safe to update it at the end of the
> rebase (just using the current value of the branch ref at the end of a long
> running operation like rebase is not sufficient to be safe).

The operation we are doing necessarily requires a force-update, since we are
modifying history. The safety you are caring about here is about the case where
the user modifies one of these refs between the initial 'git rebase --update-refs'
and the final 'git rebase --continue' that actually writes the refs. You want to
prevent that final update from succeeding because another change to those refs
could be lost.

I'm less concerned about this case, because the user is requesting that we
update the refs pointing to this set of commits. But, I'm glad you brought it
up.

One way to prevent this situation would be to extend the idea of "what branch
is being rebased?" (REBASE_HEAD) to "which branches are being rewritten?"
(REBASE_HEADS?). If the worktree kept the full list somewhere in the $GIT_DIR,
then other Git commands could notice that those refs are currently being
overwritten and those updates should fail (similarly to how we currently fail
to update a branch being rebased). This ties into your later point:

>>   2. If we want to close out all of the refs as the rebase is finishing, then
>>      that "step" becomes invisible to the user (and a bit more complicated to
>>      insert). Thus, the 'update-refs' step performs this action. If the user
>>      wants to do things after that step, then they can do so by editing the
>>      TODO list.
> 
> I'm not sure what the use case is for making the update-refs step visible to
> the user - it seems to be added complexity for them to deal with. We don't do
> that for the branch that is being rebased so why do we need to do it for the
> other branches? As for the implementation we could just update the branches
> at the end of the loop in pick_commits() where we update the branch and run the
> post-rewrite hook etc. there is no need for an entry in the todo list.

I concede that allowing the user to move the 'update-refs' command around is
not super important.

The biggest concern I originally had with this idea was that there was no
connection between the "--update-refs" option in the first "git rebase"
command and the final "git rebase --continue" command. That is, other than
which refs are in refs/rewritten/*.

HOWEVER, using refs/rewritten/* is likely buggy: if we had two rebases
happening at the same time (operating on a disjoint set of refs), then how
do we differentiate which refs make sense for us to update as we complete
this rebase?

So, I'm coming to the conclusion that using refs/rewritten/* is problematic
and I should use something closer to REBASE_HEAD as a way to describe which
refs are being updated. In that context, your 'update-ref <ref>' command
makes a lot more sense. The user can decide to move those around _or_ remove
them; it won't change their protection under "REBASE_HEADS" but would
prevent them from being rewritten.

While I think on this, I'll send my branch_checked_out() patches in a
separate thread, since those have grown in complexity since this version.

Thanks,
-Stolee
