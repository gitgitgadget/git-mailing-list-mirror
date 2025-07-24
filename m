Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D92DFA46
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366940; cv=none; b=EGsmyQmZRb/UTFscaJ7Nr9H62jyRKaFUiytSkN/8J0N0aNcwSVv0sT0FyQYjKWkx7LvCUD9oyycuhL6mgxkob5KEwRK492iFflrBDuS4dgjghzseZVOJekMe0fsuEuK7xzi1iqcjt1BInRS6CeouElRgzbFCGAe62j+TJvE3RWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366940; c=relaxed/simple;
	bh=rXS00JbxX7mSm9a8ZSJ6qozQVKrl5AM/EGeZXtSxEQk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VSxW1hAwfys9sslRd0kW28E5yBqz2cv8ODDQt0JLYpzWfPn564A4a3X/cW1iB3lfEEn5G351AKe6yYrLCtgh9S4vv+QQ7Fuz0CEitYzM9Gb+w6wj4847lLzGyeREg1x5aAjaVW5qdcqdq5og4Zj6jsY/xqqJYpkQOhDaQy+jY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEGuZi3i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEGuZi3i"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54700a463so699000f8f.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753366937; x=1753971737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjDNDJNo4lW4XbAtHW4bLnqLLWTXEiWVRxHFnpA3aoc=;
        b=YEGuZi3i+u8zlDfkNV89Ogf2OwGirHFDNaNs1VQAjbc3xcjhBz7TdG4Zwf5pqKb/oj
         6qSSox82bHYorrzi5+fyhtLVthHKeT1IDCpgUVn9GOhwLPD7VtmLF2qz4htlhHi0fkKT
         FQe67EP4Z4RdzU+dt7TcDPHgor/2rtQJADBsIKOrOvfdGjuYy2NTuiv1CldhiiNNPrBI
         fmXWcCoUWOdN4oOT8ZW1emoMHcBy6HT8d8nOcE/OJo/M5EnPge9KrPGD9I0I7BbEGpZ+
         Q0WUQJRGInaO3K7sgGrd5t7cvU1LisfoATgU1Gd8Yv1DD4Ksl8wj99jP4OjlUEhCU02q
         5ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366937; x=1753971737;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjDNDJNo4lW4XbAtHW4bLnqLLWTXEiWVRxHFnpA3aoc=;
        b=NjUQkuAzgtRZDQf+TLXAa+ALKtzbOyf7KGY9BiB4ywzTOjmlc/r3exLHPAKB8v/pJy
         tMKNUfH6kJqQZFlxLW0lRoSypMSUYTzXALrBzfPjnHynlHE2eJCSEU8+Q5UU8smSbLIk
         AHkMyHoW607QUBfVLqLNQv2xHUOaHBRTHSv4QBys0tymiSlJW6TYT9pAV3gU230J1dDL
         +4VIYqC9hmQ6MiEsxsPTXQSWD7QOBQYPMOE8h4sF7ln1qebdIjMRFxyw8L1hrUhIEU/q
         6Nfzh/Vj5szdVOomQl1Z47vy2pjNOjmk8be675udatD+WmOM5+EletfOi1YtRKW0y780
         TLgA==
X-Gm-Message-State: AOJu0YxGmeCiSIDgWRpaARLtmmi0OXOrHn8O5JEK0foglyDu6MOg7tLY
	3QEs2+0RTGvoQw2702uoe5akl0n979fDz7KCJ7xSsWz1AOkUbfvoc32i
X-Gm-Gg: ASbGncvIsJF+DkKRLKu6j7LHc9vamTZly3REIHdS9Q929Ku2Rdz6WgDwO2bMw7/X26x
	s4iS2RiOvc5ekgUGoQK18Ne1MtldXRGy7vwOTfbtCctthPsiCoBfgmfFPmqHxAP16Jy+43zfA6d
	UMOmXAKi3zAgZRqYvMTgBS5gxaAb6bESfHkN33pj87T0uWq53qdN8fNurFaEJD+FRN/67KHBDUR
	WnvtNdhL30381F6g5Yn2qhefe7G1Cy0h/Gx2ICKptA5ZwfEKkLOWysXQl9065szcv/bkDGjGyv2
	DGle78kcwUZMLD0yq/8ihHuq4CDNLHbIP2UMHf0vjx4hA9p9wLKTU0oI/X0sqCbWuk+AzJjxcfS
	WJFkAP5tpRvyCxlFsXqRKidiZXahhigXQ8HBbcUf6NWwN/2sqz3s9XUhW8k7BKSnw02GvU4Z/iB
	Bl
X-Google-Smtp-Source: AGHT+IGIeE8dg/WzmJUQogGZpkbz0pAqBIhPImxUNdQion/edc+pw+h1bQNOVPEkmxdlMP/2UVruJA==
X-Received: by 2002:a05:6000:26c1:b0:3b6:5d0d:9826 with SMTP id ffacd0b85a97d-3b77135fb36mr2298265f8f.21.1753366936935;
        Thu, 24 Jul 2025 07:22:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4d91sm23162825e9.23.2025.07.24.07.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:22:16 -0700 (PDT)
Message-ID: <9dc4331e-7c0d-4cc5-980e-a151853725b6@gmail.com>
Date: Thu, 24 Jul 2025 15:22:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase: write script before initializing state
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?=C3=98ystein_Walle?=
 <oystwa@gmail.com>
Cc: git@vger.kernel.org
References: <xmqqfrf6qkyy.fsf@gitster.g>
 <20250711203615.9982-1-oystwa@gmail.com> <xmqqple6zaga.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqple6zaga.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/07/2025 22:25, Junio C Hamano wrote:
> Øystein Walle <oystwa@gmail.com> writes:
> 
>> If rebase.instructionFormat is invalid the repository is left in a
>> strange state when the interactive rebase fails. `git status` outputs
>> both the same as it would have in the normal case *and* something
>> related to the interactive rebase:
>>
>>      $ git -c rebase.instructionFormat=blah rebase -i
>>      fatal: invalid --pretty format: blah
>>      $ git status
>>      On branch master
>>      Your branch is ahead of 'upstream/master' by 1 commit.
>>        (use "git push" to publish your local commits)
>>
>>      git-rebase-todo is missing.
>>      No commands done.
>>      No commands remaining.
>>      You are currently editing a commit while rebasing branch 'master' on '8db3019401'.
>>        (use "git commit --amend" to amend the current commit)
>>        (use "git rebase --continue" once you are satisfied with your changes)
>>
>> get_commit_format() calls die() on failure so we cannot handle the error
>> gracefully. By attempting to write the rebase script before initializing
>> the state this bad state can be avoided.
>>
>> Signed-off-by: Øystein Walle <oystwa@gmail.com>
>> ---
>> So sorry for the delay. I saw that the signoff was missing, then saw
>> Phillip's review, decided to think about it and then life happened in
>> the mean time...
> 
> No need to be sorry.  Life happens, indeed.
> 
>> This patch is identical to the first one except it has the missing
>> signoff and a few typos in the commit message corrected. Phillip's
>> suggestions are noted and appreciated but unfortunately I am unable to
>> work on the at the moment. And I do think my patch is at least an
>> improvement albeit perhaps less thorough than it could have been.
> 
> Well, as long as we are making a step in the right direction, such a
> partial improvement gives us a better foundation for somebody else
> to further build on.

I don't think this is a better (or worse) foundation for future 
improvement as solving this when the user passes '--autostash' needs a 
different approach. When that option is given we create the state 
directory earlier so moving when we call init_basic_state() has no effect.

>  It does not look like that this patch would
> make it harder to later give us a more thorough solution.

I agree with this. I don't think this change makes fixing the 
'--autostash' case harder, but fixing that case makes this change 
redundant.
> Thanks for working on the topic.

Yes, thank you Øystein

Phillip

>>   builtin/rebase.c             | 42 ++++++++++++++++++------------------
>>   t/t3415-rebase-autosquash.sh | 10 +++++++++
>>   2 files changed, 31 insertions(+), 21 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 2e8c4ee678..8139816417 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -293,15 +293,6 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>>   				&revisions, &shortrevisions))
>>   		goto cleanup;
>>   
>> -	if (init_basic_state(&replay,
>> -			     opts->head_name ? opts->head_name : "detached HEAD",
>> -			     opts->onto, &opts->orig_head->object.oid))
>> -		goto cleanup;
>> -
>> -	if (!opts->upstream && opts->squash_onto)
>> -		write_file(path_squash_onto(), "%s\n",
>> -			   oid_to_hex(opts->squash_onto));
>> -
>>   	strvec_pushl(&make_script_args, "", revisions, NULL);
>>   	if (opts->restrict_revision)
>>   		strvec_pushf(&make_script_args, "^%s",
>> @@ -310,21 +301,30 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>>   	ret = sequencer_make_script(the_repository, &todo_list.buf,
>>   				    make_script_args.nr, make_script_args.v,
>>   				    flags);
>> -
>> -	if (ret)
>> +	if (ret) {
>>   		error(_("could not generate todo list"));
>> -	else {
>> -		discard_index(the_repository->index);
>> -		if (todo_list_parse_insn_buffer(the_repository, &replay,
>> -						todo_list.buf.buf, &todo_list))
>> -			BUG("unusable todo list");
>> -
>> -		ret = complete_action(the_repository, &replay, flags,
>> -			shortrevisions, opts->onto_name, opts->onto,
>> -			&opts->orig_head->object.oid, &opts->exec,
>> -			opts->autosquash, opts->update_refs, &todo_list);
>> +		goto cleanup;
>>   	}
>>   
>> +	if (init_basic_state(&replay,
>> +			     opts->head_name ? opts->head_name : "detached HEAD",
>> +			     opts->onto, &opts->orig_head->object.oid))
>> +		goto cleanup;
>> +
>> +	if (!opts->upstream && opts->squash_onto)
>> +		write_file(path_squash_onto(), "%s\n",
>> +			   oid_to_hex(opts->squash_onto));
>> +
>> +	discard_index(the_repository->index);
>> +	if (todo_list_parse_insn_buffer(the_repository, &replay,
>> +					todo_list.buf.buf, &todo_list))
>> +		BUG("unusable todo list");
>> +
>> +	ret = complete_action(the_repository, &replay, flags,
>> +		shortrevisions, opts->onto_name, opts->onto,
>> +		&opts->orig_head->object.oid, &opts->exec,
>> +		opts->autosquash, opts->update_refs, &todo_list);
>> +
>>   cleanup:
>>   	replay_opts_release(&replay);
>>   	free(revisions);
>> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
>> index 26b42a526a..5d093e3a7a 100755
>> --- a/t/t3415-rebase-autosquash.sh
>> +++ b/t/t3415-rebase-autosquash.sh
>> @@ -394,6 +394,16 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
>>   	)
>>   '
>>   
>> +test_expect_success 'autosquash with invalid custom instructionFormat' '
>> +	git reset --hard base &&
>> +	test_commit invalid-instructionFormat-test &&
>> +	(
>> +		test_must_fail git -c rebase.instructionFormat=blah \
>> +			rebase --autosquash  --force-rebase -i HEAD^ &&
>> +		test_path_is_missing .git/rebase-merge
>> +	)
>> +'
>> +
>>   set_backup_editor () {
>>   	write_script backup-editor.sh <<-\EOF
>>   	cp "$1" .git/backup-"$(basename "$1")"

