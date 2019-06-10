Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4747C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 10:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfFJKkN (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 06:40:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54491 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389476AbfFJKkN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 06:40:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so7975867wme.4
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oIbBLAzp9MJczqoqhwyleTKeptlMWmmkHS2aWMeElTs=;
        b=IbpEECxsoVyG1KB44gREgDZp5WoIwg4Y6xoOBzyJuJjLVCNEsY1A2Y6tWkRsxgahjn
         kYSYz5LoyBNlp3AQCXnO93pkkRr0Knyz0kgdm1RNz06c9tgj98WaNr7Nchda4VaLP5BM
         KNhkRRGCgViOguZ1ujaFdZMMCNy2bpWDsYxdBuoFgTF+P2TthsyB9O9x1SHG839pO1gI
         PYRY7ugurSXkAsUqiy/EHoZXbWeR7M+EasJ9N38aNyZrEBZe0Z13BWjHyGPCapuYcNkr
         r8Z7lWOIaaP4tgah3WehZABHN9vAYJZFp/NLoDB0BL1UiFw4B8zNCrfOdaQNm+CQ/P3b
         z5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oIbBLAzp9MJczqoqhwyleTKeptlMWmmkHS2aWMeElTs=;
        b=OcSxCuP4/pcZiTfp6lFiNH2F+eXwH7oo0E8qMq6koCq+5QYktWS7AwhbC5/i+f8jB4
         OKY47dbKrZVlUqHHmAO8FqV2H9DYD98wjovYtnvj6PLuH0XzL+OJ5V03EQw1yp0dtzPJ
         EpqVkhg/Aum4TBpH22+u+jGagXo6xzlhTgThVy9x1jUTcjV7Jj+cHl4NhgIbVg2vsLXY
         kkzBN7dF1WbHPni61x4NFIdyl0ojHs0vDd1eGY3f/ZyUvz+iwnVdmcIEkpbTASIbG/am
         tJYcHnp94rQXOjiDVBJQKnaOe/5lUhVsqm/Kgt3KgMtkq6ItfNGeAw8B3wfpYUDM8PDD
         sAUA==
X-Gm-Message-State: APjAAAVoN+zn1gnw2NLORjrHRnZ3gWLH4NksuIOuYEIf+Cj/nzI+VXKr
        CVvyq+TSF+G1f1zgkpjQItc=
X-Google-Smtp-Source: APXvYqzuAVnAVBDVEvcgwSBEXToxCdSiEsnqjYGBlrw9DTWRHuZjrMDXL8mPDEFyHdTTnpsmI1FpCw==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr3308426wmf.139.1560163210523;
        Mon, 10 Jun 2019 03:40:10 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id l1sm10170837wmg.13.2019.06.10.03.40.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:40:10 -0700 (PDT)
Subject: Re: [GSoC][PATCH 2/3] cherry-pick/revert: add --skip option
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com
References: <0659a53e-0712-eb50-f15f-1c6a56fd3213@gmail.com>
 <20190610055719.19572-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2488ef91-b9e5-1836-aeea-2aaf11c3c383@gmail.com>
Date:   Mon, 10 Jun 2019 11:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610055719.19572-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 10/06/2019 06:57, Rohit Ashiwal wrote:
> Hey Phillip
> 
> On Sun, 9 Jun 2019 19:01:35 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Rohit
>>
>> --skip is definitely a useful addition to cherry-pick/revert
>>
>> On 08/06/2019 20:19, Rohit Ashiwal wrote:
>>>
>>> [...]
>>> @@ -2784,6 +2784,29 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
>>>  	return -1;
>>>  }
>>>  
>>> +int sequencer_skip(struct repository *r, struct replay_opts *opts)
>>> +{
>>> +	switch (opts->action) {
>>> +	case REPLAY_REVERT:
>>> +		if (!file_exists(git_path_revert_head(r)))
>>> +			return error(_("no revert in progress"));
>>
>> This error message is slightly misleading. If the user has already
>> committed a conflict resolution then REVERT_HEAD/CHERRY_PICK_HEAD will
>> not exist but it is possible that a cherry-pick/revert is in progress if
>> the user was picking a sequence of commits. It would be nice to give a
>> different error message or maybe just a warning in that case.
>> sequencer_get_last_command() should help with that.

It's actually a bit more complicated as if the cherry-pick failed
because it would have overwriten untracked files then CHERRY_PICK_HEAD
will not exist but we want to be able to skip that pick. So it should
not error out in that case either. (I think you may be able to use the
abort safety file (see rollback_is_safe()) to distinguish the 'failed to
pick case' from the 'user committed a conflict resolution' case.)

> Yes, .git/{REVERT|CHERRY_PICK}_HEAD will not exist in this case, but
> in case of cherry-picking/reverting:
> 
> 1. multiple commits:
>     sequencer dir will exist which will throw out the error listed
>     under `create_seq_dir`

I don't understand. Wont it will error out here? Why would we call
create_seq_dir() for --skip?

> 2. single commit:
>     Then ACTION is already over and there is nothing to do and the
>     error is correct.
> 
>>> +		break;
>>> +	case REPLAY_PICK:
>>> +		if (!file_exists(git_path_cherry_pick_head(r)))
>>> +			return error(_("no cherry-pick in progress"));
>>> +		break;
>>> +	default:
>>> +		BUG("the control must not reach here.");
>>> +	}
>>> +
>>> +	if (rollback_single_pick(r))
>>> +		return error(_("failed to skip the commit"));
>>
>> If rollback_single_pick() sees that HEAD is the null oid then it gives
>> the error "cannot abort from a branch yet to be born". We're not
>> aborting and if we're picking a sequence of commits the skip ought
>> succeed, but it won't at the moment. If we're picking a single commit
>> then the skip should probably fail like abort but with an appropriate
>> message. Admittedly that's all a bit of a corner case.
> 
> Yes, you are right here. We could actually modify the advice there
> to be more like _("cannot perform the specified action, the branch
> is yet to be born") and I think it should suffice this. What do you
> think?

I think it should allow the user to skip if there are more commits to
pick . Just changing the error message does not fix that.

> 
>>> [...]
>>> +test_expect_success 'skip a commit and check if rest of sequence is correct' '
>>> +	pristine_detach initial &&
>>> +	echo e >expect &&
>>> +	cat >expect.log <<-EOF &&
>>> +	OBJID
>>> +	:100644 100644 OBJID OBJID M	foo
>>> +	OBJID
>>> +	:100644 100644 OBJID OBJID M	foo
>>> +	OBJID
>>> +	:100644 100644 OBJID OBJID M	unrelated
>>> +	OBJID
>>> +	:000000 100644 OBJID OBJID A	foo
>>> +	:000000 100644 OBJID OBJID A	unrelated
>>> +	EOF
>>> +	test_must_fail git cherry-pick base..yetanotherpick &&
>>> +	test_must_fail git cherry-pick --skip &&
>>
>> It would be good to check that the cherry-pick has progressed since
>> --skip and didn't just fail without trying to pick another commit.
> 
> The overall test tests that only, if cherry-pick --skip "failed" then
> we won't get 'e' inside of `foo` and `test_cmp expect foo` will also
> fail and if it skipped wrongly then expect.log will not match the
> actual.log and `test_cmp` will fail. Am I missing something here?
> Please tell if so.

You're right that the tests at the end would probably pick up a failure,
but I'm concerned that there could be some obscure corner case we've not
thought of so checking HEAD and the file contents here would be an
additional safety measure. It also makes it easier for someone tracking
down a test failure to see what happened. If they rely only on the test
at the end they need to spend time to understand where the mismatched
contents came from.

Best Wishes

Phillip


>  
>> Best Wishes
>>
>> Phillip
> 
> Thanks
> Rohit
> 

