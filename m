Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF871F403
	for <e@80x24.org>; Tue, 19 Jun 2018 10:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756792AbeFSKAK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 06:00:10 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:8118 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755946AbeFSKAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 06:00:09 -0400
Received: from [192.168.2.201] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id VDQjfydipdJAeVDQjfsKlw; Tue, 19 Jun 2018 11:00:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529402407;
        bh=C9YhAu9KnmGkXeSgGiCmbOAKyEPgAU8WpLkafc40Y0s=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hRwmXfks3GJocY558ZfqizxMFKOS676FTH9r+IGWiMHVNPzKZH7uLG6FCxFTBO+WD
         sB2tyTr/Ek5YD4CdXoFCXA2YG9pT1MHEWSHTXxbnj6Tph0NtWf7CUpxHwbFYKGaT0B
         bj26k0XzNg6IGKrSBSDsUziptq6YPDohqvMB2XpQ=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=TMirj38UOsJWyIoQ-0QA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: do not squash 'reword' commits when wehit
 conflicts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        git@vger.kernel.org, gitster@pobox.com
References: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com>
 <20180617053703.19856-1-newren@gmail.com>
 <d62d834a-58dd-590a-cf71-028220323bf9@talktalk.net>
 <nycvar.QRO.7.76.6.1806172048270.77@tvgsbejvaqbjf.bet>
 <0ead1e75-98e9-8357-3e8d-2ff2f3cc5cc0@talktalk.net>
 <nycvar.QRO.7.76.6.1806182326420.77@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <0fd91415-e88b-3cce-a77e-d1108d44b55d@talktalk.net>
Date:   Tue, 19 Jun 2018 11:00:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1806182326420.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH3VCs8NWh9c/FrD86UMUG4BPrEaJUOM26D46J1P41yvgk6zxy7peBvuF7pdNF5tWQ217+VN1veg7GXZeCq//AsmTCT48rqOTAT3a9u3dpGZ+6mX02UO
 GM5tEp0AkqAkWeVLarg2tSNlt4SkF8U0royz4zhh9zV+PVGZ9l81Vga9TBqjSCIUe/neK1HwUooLO64w2SubcB//MTYx641SHc7KE9S1Os5xIo6U0kBT3DIG
 fRKwgNsPdm8/EIc626uF3Yt1R9QOrv6du8BD8EXNR33xb2FVyN+q1ZyplI3Pf6Zo1f8GYOrIX9kbF0w/wJ13o1WQTxmg1YEk8oueSA54ovBh2WGRTk5qyYbU
 XemUbAuGYwSRKE3eO0CvAmT9Jqavng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 18/06/18 22:42, Johannes Schindelin wrote:
> 
> Hi Phillip,
> 
> On Mon, 18 Jun 2018, Phillip Wood wrote:
> 
>> On 17/06/18 20:28, Johannes Schindelin wrote:
>>>
>>> On Sun, 17 Jun 2018, Phillip Wood wrote:
>>>
>>>> On 17/06/18 06:37, Elijah Newren wrote:
>>>>> Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper
>>>>> builtin", 2017-02-09), when a commit marked as 'reword' in an
>>>>> interactive rebase has conflicts and fails to apply, when the rebase
>>>>> is resumed that commit will be squashed into its parent with its
>>>>> commit message taken.
>>>>>
>>>>> The issue can be understood better by looking at commit 56dc3ab04b
>>>>> ("sequencer (rebase -i): implement the 'edit' command", 2017-01-02),
>>>>> which introduced error_with_patch() for the edit command.  For the
>>>>> edit command, it needs to stop the rebase whether or not the patch
>>>>> applies cleanly.  If the patch does apply cleanly, then when it
>>>>> resumes it knows it needs to amend all changes into the previous
>>>>> commit.  If it does not apply cleanly, then the changes should not
>>>>> be amended.  Thus, it passes !res (success of applying the 'edit'
>>>>> commit) to error_with_patch() for the to_amend flag.
>>>>>
>>>>> The problematic line of code actually came from commit 04efc8b57c
>>>>> ("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
>>>>> Note that to get to this point in the code:
>>>>>    * !!res (i.e. patch application failed)
>>>>>    * item->command < TODO_SQUASH
>>>>>    * item->command != TODO_EDIT
>>>>>    * !is_fixup(item->command) [i.e. not squash or fixup]
>>>>> So that means this can only be a failed patch application that is
>>>>> either a pick, revert, or reword.  For any of those cases we want a
>>>>> new commit, so we should not set the to_amend flag.
>>>>
>>>> Unfortunately I'm not sure it's that simple. Looking and do_pick()
>>>> sometimes reword amends HEAD and sometimes it does not. In the
>>>> "normal" case then the commit is picked and committed with '--edit'.
>>>> However when fast-forwarding the code fast forwards to the commit to
>>>> be reworded and then amends it. If the root commit is being reworded
>>>> it takes the same code path. While these cases cannot fail with
>>>> conflicts, it is possible for the user to cancel the commit or for
>>>> them to fail due to collisions with untracked files.
>>>>
>>>> If I remember correctly the shell version always picks the commit and
>>>> then calls 'git commit --amend' afterwards which is less efficient
>>>> but consistent.
>>>>
>>>> I'm afraid I don't have a simple solution for fixing this, as
>>>> currently pick_commits() does not know if the commit was called with
>>>> AMEND_MSG, I guess that means adding some kind of flag for do_pick()
>>>> to set.
>>>
>>> Oh, you're right, the fast-forwarding path would pose a problem. I
>>> think there is an easy way to resolve this, though: in the case that
>>> we do want to amend the to-be-reworded commit, we simply have to see
>>> whether HEAD points to the very same commit mentioned in the `reword`
>>> command:
>>
>> That's clever, I think to get it to work for rewording the root commit,
>> it will need to do something like comparing HEAD to squash-onto as well.
> 
> .... because squash-onto is a fresh, empty root commit (to be "amended"
> when a non-root commit is to be picked as a new root commit). Good point.
> 
>>> -- snip --
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 2dad7041960..99d33d4e063 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -3691,10 +3691,22 @@ static int pick_commits(struct todo_list
>>> *todo_list, struct replay_opts *opts)
>>>                                         intend_to_amend();
>>>                                 return error_failed_squash(item->commit, opts,
>>>                                         item->arg_len, item->arg);
>>> -                       } else if (res && is_rebase_i(opts) && item->commit)
>>> +                       } else if (res && is_rebase_i(opts) && item->commit) {
>>> +                               int to_amend = 0;
>>> +
>>> +                               if (item->command == TODO_REWORD) {
>>> +                                       struct object_id head;
>>> +
>>> +                                       if (!get_oid("HEAD", &head) &&
>>> +					    !oidcmp(&item->commit->object.oid,
>>> +                                                   &head))
>>> +                                               to_amend = 1;
> 
> This would now become
> 
> 					if (!get_oid("HEAD", &head) &&
> 					    (!oidcmp(&item->commit->object.oid,
> 						     &head) ||
> 					     (opts->have_squash_onto &&
> 					      !oidcmp(&opts->squash_onto,
> 						      &head))))
> 						to_amend = 1;
> 
> This is awfully indented, so a better idea would probably be to avoid the
> extra block just to declare `head`:
> 
> 
> -                       } else if (res && is_rebase_i(opts) && item->commit)
> +                       } else if (res && is_rebase_i(opts) && item->commit) {
> +                               int to_amend = 0;
> +                               struct object_id oid;
> +
> +				/*
> +				 * If we fast-forwarded already, or if we
> +				 * are about to create a new root commit,
> +				 * we definitely want to amend, otherwise
> +				 * we do not.
> +				 */
> +                               if (item->command == TODO_REWORD &&
> +				    !get_oid("HEAD", &oid) &&
> +				    (!oidcmp(&item->commit->object.oid, &oid) ||
> +				     (opts->have_squash_onto &&
> +				      !oidcmp(&opts->squash_onto, &head))))
> +					to_amend = 1;
> +
>                                 return res | error_with_patch(item->commit,
>                                         item->arg, item->arg_len, opts, res,
> -                                       item->command == TODO_REWORD);
> +                                       to_amend);
> +                       }
>                 } else if (item->command == TODO_EXEC) {
> 
> 
> What do you think?

Looks good

> And: could you perchance add a regression test for a failing pick onto
> squash-onto (I am desperately in need of sleeping, otherwise I would do it
> myself)? Something that executes `reset [new root]` and then `pick abcdef`
> where abcdef would overwrite an untracked file should trigger this
> relatively easily.

Done, I'm just waiting on travis to check everything before sending this
afternoon

Best Wishes

Phillip

> Thanks,
> Dscho
> 

