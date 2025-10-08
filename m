Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C622874F2
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932081; cv=none; b=oz8oz+GfDStPiKBtMfmTseJ3/wWhV/yy6jyz/s061mQwAxBm6/h5JAI0+jB6N9gawUMCXzpi7HyXCZKx1vkFWJWdQ58NmmLrTWxI/H+ZkWXo5TkegxtWOLqngcrbCHOhv1inXttkCN7qxgNOT2DpzfnjMzvbfe7pSrggArqlQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932081; c=relaxed/simple;
	bh=o3taz4YG/tWobc8Qhr8vy65/KgE2jVxlhHJMsznanMc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BwUJha2rvG22uEVx1VlTyo5MkFAHjGw/iMYtLV+VqVo79cXvOPIyhlqN9anv3XsNiuAQ08Y6zRnKbqdcWqSdyDIDmorGJ8KUFT3CmOX2lgrf+DVSIf0OmF47L2gUrAHyHV1sx0GR8qMGtfPPlCQ7nXQjwtR7D312/PwlZ0E4lVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k995Mnk1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k995Mnk1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so70657695e9.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759932077; x=1760536877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJepttgYkMs20zhFnY9rvEXZeEqd87tpdxFQbWv7coo=;
        b=k995Mnk1y2nhZNhyz5BxHjB21mTisYns3PmcP5nklexJpz51nCrr0eiOvRzAdAb0y1
         vlQ5uR06A2Z6BKWFdOzSMwITQ/gxBIRBv9qKJtFp/VrgydgwoPRNxnpfL19FVaA1+2fI
         zmfjnndHssbRFXUEz7rk4HCN44DJMWAZEGqbhqWk0y1NC39IZrDPmBNjzqgqVVj97q79
         7n4kV/fB3icoOmN+qlZwj6NGyETKcBYVa9+ZMO8rZGLroPc28uOQXUXbXcx1x+GqXK17
         /0pLsB3wkEOhokGMN/RWbDMcH7HKlnOWMgsa91x57C+OdrJ1xkw1stbwgwvG69UD7W+K
         qzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759932077; x=1760536877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJepttgYkMs20zhFnY9rvEXZeEqd87tpdxFQbWv7coo=;
        b=kQWEbqVsRfxyGKAoon4wkUm79acZBg/3zxO3hVG3XaCYKdhGnGNrSiRbA6USrhcwvR
         7W99b4EDeeJfQhyMrmpDpek8mTy6rvLfRceskap+5ZA3yd1B8f560cIDRgU7Py312B/J
         aP5jxBWUNmyY5h4Od9dvceLevXZuqJe11RvLXxVJQCId6OmyKlAnDuERVveqGu+jNDmg
         hywHvPeXhdPwU3v3JajAB5xaI4uL0shWZwyKSrKYGAlSdwdz6dRWOeRnBhMPcUDVDvrd
         5QhEWAGmeIiOSXje//AnxEGBEwS0xHSoZhy7KwxU6llxIXOAecJulMg5Ejt1p7yBPKW8
         VKcA==
X-Forwarded-Encrypted: i=1; AJvYcCXow98ZxycBdQIRA36VTOZmxkD/EQsgTCiqEWST45ymOFs/CGSGOHPPMhHWFCJEgLzvv/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0Pyh9aSLQ4igWwk41NNxsxXCKxnga5M2Jq1sGsj/trqNJHdW
	oL4Ni9QPmgJKsjOF0D0SPwzSMQAchYnCuCK/wxJDbsmCWH665G57um8M
X-Gm-Gg: ASbGncvFYUrs53h57IQwX0kJHNq8+Br4IawvwRbwQZp0T3dzkxh7PF7eWgzu15Xi4sP
	RA1RuJq9vv2zQIGQGF5pwmZLULtGfN8JhnHcux95vRmrcypsfNDbvJ6J+mChKEznyPtoSdLEhcS
	w2t6y0Utq/qtomm6g2Ke7NO0Y+fZDdxFdxBCb3dzM3tLmvT338x/rUFXLH4tTn5ZY++RaNdUYVi
	ImagZO7fQzUiIhaevifrrSRny5miVcQhGsQfxB/BUQkx+WXM7g9PD2f4sWymjyaJoYyAkUFDQzp
	QyVrrHKdzxyYcLCry6l0koymM2igWLV+OV1oxHW1GEl9siKk/bThaIW8OAyHC1NdOgkK7do8/uG
	jMw37NedzLHczYcJkg4PQnGJkohqOKXZEc6kucjPDb2a7AeLyGjxKqvdYjvoQWwx3qRFe9rGQy2
	HhcleoEhwiRO5BsAEXSmBDp4c=
X-Google-Smtp-Source: AGHT+IHsjh+A8u7dEoEWIPzBxNRhDy0vXlZEr1cmDnlUc15mPgsYnQFC7T8s3E+hNWk+N6Dbylkh7Q==
X-Received: by 2002:a05:600c:5492:b0:46e:477a:16cc with SMTP id 5b1f17b1804b1-46fa9af84ecmr28873755e9.24.1759932077173;
        Wed, 08 Oct 2025 07:01:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf112fdbsm1296495e9.8.2025.10.08.07.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 07:01:16 -0700 (PDT)
Message-ID: <d9764c7b-8de2-4b54-8c44-a4bd7f5860e8@gmail.com>
Date: Wed, 8 Oct 2025 15:01:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 karthik.188@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
 <9d310bd5-453f-43a4-b477-ba02baa7a664@gmail.com>
Content-Language: en-US
In-Reply-To: <9d310bd5-453f-43a4-b477-ba02baa7a664@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Siddharth

On 02/10/2025 23:20, Siddharth Asthana wrote:
> On 30/09/25 15:35, Phillip Wood wrote:
>> On 27/09/2025 00:08, Siddharth Asthana wrote:
>>> The git replay command currently outputs update commands that must be
>>> piped to git update-ref --stdin to actually update references:
> 
> The actual advantages of the new default aren't about atomicity (that
> already exists), but rather:
> - Eliminating the pipeline for the common case
> - Better ergonomics for users who just want refs updated
> - Simpler server-side automation
> 
> I will rewrite the commit message to accurately reflect this. Elijah
> provided a good suggested structure that captures the real trade-offs
> without false claims.

That's great. I agree that having replay update the refs itself is a 
useful improvement.

>>> +--allow-partial::
>>> +    Allow some ref updates to succeed even if others fail. By default,
>>> +    ref updates are atomic (all succeed or all fail). With this option,
>>> +    failed updates are reported as warnings rather than causing the 
>>> entire
>>> +    command to fail. The command exits with code 0 only if all updates
>>> +    succeed; any failures result in exit code 1. Cannot be used with
>>> +    `--output-commands`.
>>
>> Rather than having two incompatible options perhaps we could have a 
>> single "--update-refs=(yes|print|allow-partial-updates)" argument. I 
>> think the name "--allow-partial" is rather ambiguous as it does not 
>> say what it is allowing to be partial.
> 
> After thinking about this and Elijah's feedback, I am leaning toward
> dropping --allow-partial entirely since I don't have a concrete use case
> for it. That simplifies things to just: default atomic updates vs
> --output-commands for the traditional pipeline.
> 
> Would you still prefer a --update-refs=<mode> style, or is the simpler
> --output-commands flag sufficient given that --allow-partial is going away?

The advantage of --update-refs=<mode> is that it allows for future 
extensions such as adding support for partial in a way that does not 
add conflicting options.

Thanks

Phillip
  >
>>
>>> +static int add_ref_to_transaction(struct ref_transaction *transaction,
>>> +                  const char *refname,
>>> +                  const struct object_id *new_oid,
>>> +                  const struct object_id *old_oid,
>>> +                  struct strbuf *err)
>>> +{
>>> +    return ref_transaction_update(transaction, refname, new_oid, 
>>> old_oid,
>>> +                      NULL, NULL, 0, "git replay", err);
>>> +}
>>
>> I'm not sure this function adds much value. I think it would be better 
>> to instead have a helper function that updates refs or prints the ref 
>> updates so that we do not duplicate that code in the two places below.
> 
> 
> ood point. I will extract a helper like:
> 
>      static int handle_ref_update(int output_commands,
>                                   struct ref_transaction *transaction,
>                                   const char *refname,
>                                   const struct object_id *new_oid,
>                                   const struct object_id *old_oid,
>                                   struct strbuf *err)
> 
> This eliminates the duplication and fixes the over-long lines you pointed
> out at both call sites.
> 
> Thanks!
> 
> 
>>
>>> @@ -434,10 +481,18 @@ int cmd_replay(int argc,
>>>               if (decoration->type == DECORATION_REF_LOCAL &&
>>>                   (contained || strset_contains(update_refs,
>>>                                 decoration->name))) {
>>> -                printf("update %s %s %s\n",
>>> -                       decoration->name,
>>> - oid_to_hex(&last_commit->object.oid),
>>> -                       oid_to_hex(&commit->object.oid));
>>> +                if (output_commands) {
>>> +                    printf("update %s %s %s\n",
>>> +                           decoration->name,
>>> + oid_to_hex(&last_commit->object.oid),
>>> + oid_to_hex(&commit->object.oid));
>>> +                } else if (add_ref_to_transaction(transaction, 
>>> decoration->name,
>>> + &last_commit->object.oid,
>>> +                                  &commit->object.oid,
>>> +                                  &transaction_err) < 0) {
>>> +                    ret = error(_("failed to add ref update to 
>>> transaction: %s"), transaction_err.buf);
>>> +                    goto cleanup;
>>> +                }
>>>               }
>>
>> The lines here are very long due to the indentation, having a separate 
>> function to update the refs or print the ref updates would be much 
>> more readable.
>>
>>>               decoration = decoration->next;
>>>           }
>>> @@ -445,10 +500,33 @@ int cmd_replay(int argc,
>>>         /* In --advance mode, advance the target ref */
>>>       if (result.clean == 1 && advance_name) {
>>> -        printf("update %s %s %s\n",
>>> -               advance_name,
>>> -               oid_to_hex(&last_commit->object.oid),
>>> -               oid_to_hex(&onto->object.oid));
>>> +        if (output_commands) {
>>> +            printf("update %s %s %s\n",
>>> +                   advance_name,
>>> +                   oid_to_hex(&last_commit->object.oid),
>>> +                   oid_to_hex(&onto->object.oid));
>>> +        } else if (add_ref_to_transaction(transaction, advance_name,
>>> +                          &last_commit->object.oid,
>>> +                          &onto->object.oid,
>>> +                          &transaction_err) < 0) {
>>> +            ret = error(_("failed to add ref update to transaction: 
>>> %s"), transaction_err.buf);
>>> +            goto cleanup;
>>> +        }
>>> +    }
>>
>> Putting the code to update the refs or print the ref updates into a 
>> single function would avoid this duplication and over-long lines.
>>
>> Thanks
>>
>> Phillip
>>
>>> +    /* Commit the ref transaction if we have one */
>>> +    if (transaction && result.clean == 1) {
>>> +        if (ref_transaction_commit(transaction, &transaction_err)) {
>>> +            if (allow_partial) {
>>> +                warning(_("some ref updates failed: %s"), 
>>> transaction_err.buf);
>>> + ref_transaction_for_each_rejected_update(transaction,
>>> +                                     print_rejected_update, NULL);
>>> +                ret = 0; /* Set failure even with allow_partial */
>>> +            } else {
>>> +                ret = error(_("failed to update refs: %s"), 
>>> transaction_err.buf);
>>> +                goto cleanup;
>>> +            }
>>> +        }
>>>       }
>>>         merge_finalize(&merge_opt, &result);
>>> @@ -457,9 +535,17 @@ int cmd_replay(int argc,
>>>           strset_clear(update_refs);
>>>           free(update_refs);
>>>       }
>>> -    ret = result.clean;
>>> +
>>> +    /* Handle empty ranges: if no commits were processed, treat as 
>>> success */
>>> +    if (!commits_processed)
>>> +        ret = 1; /* Success - no commits to replay is not an error */
>>> +    else
>>> +        ret = result.clean;
>>>     cleanup:
>>> +    if (transaction)
>>> +        ref_transaction_free(transaction);
>>> +    strbuf_release(&transaction_err);
>>>       release_revisions(&revs);
>>>       free(advance_name);
>>>   diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>>> index 58b3759935..8b4301e227 100755
>>> --- a/t/t3650-replay-basics.sh
>>> +++ b/t/t3650-replay-basics.sh
>>> @@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
>>>   '
>>>     test_expect_success 'using replay to rebase two branches, one on 
>>> top of other' '
>>> -    git replay --onto main topic1..topic2 >result &&
>>> +    git replay --output-commands --onto main topic1..topic2 >result &&
>>>         test_line_count = 1 result &&
>>>   @@ -67,9 +67,30 @@ test_expect_success 'using replay to rebase two 
>>> branches, one on top of other' '
>>>       test_cmp expect result
>>>   '
>>>   +test_expect_success 'using replay with default atomic behavior (no 
>>> output)' '
>>> +    # Create a test branch that wont interfere with others
>>> +    git branch atomic-test topic2 &&
>>> +    git rev-parse atomic-test >atomic-test-old &&
>>> +
>>> +    # Default behavior: atomic ref updates (no output)
>>> +    git replay --onto main topic1..atomic-test >output &&
>>> +    test_must_be_empty output &&
>>> +
>>> +    # Verify the branch was updated
>>> +    git rev-parse atomic-test >atomic-test-new &&
>>> +    ! test_cmp atomic-test-old atomic-test-new &&
>>> +
>>> +    # Verify the history is correct
>>> +    git log --format=%s atomic-test >actual &&
>>> +    test_write_lines E D M L B A >expect &&
>>> +    test_cmp expect actual
>>> +'
>>> +
>>>   test_expect_success 'using replay on bare repo to rebase two 
>>> branches, one on top of other' '
>>> -    git -C bare replay --onto main topic1..topic2 >result-bare &&
>>> -    test_cmp expect result-bare
>>> +    git -C bare replay --output-commands --onto main topic1..topic2 
>>> >result-bare &&
>>> +
>>> +    # The result should match what we got from the regular repo
>>> +    test_cmp result result-bare
>>>   '
>>>     test_expect_success 'using replay to rebase with a conflict' '
>>> @@ -86,7 +107,7 @@ test_expect_success 'using replay to perform basic 
>>> cherry-pick' '
>>>       # 2nd field of result is refs/heads/main vs. refs/heads/topic2
>>>       # 4th field of result is hash for main instead of hash for topic2
>>>   -    git replay --advance main topic1..topic2 >result &&
>>> +    git replay --output-commands --advance main topic1..topic2 
>>> >result &&
>>>         test_line_count = 1 result &&
>>>   @@ -102,7 +123,7 @@ test_expect_success 'using replay to perform 
>>> basic cherry-pick' '
>>>   '
>>>     test_expect_success 'using replay on bare repo to perform basic 
>>> cherry-pick' '
>>> -    git -C bare replay --advance main topic1..topic2 >result-bare &&
>>> +    git -C bare replay --output-commands --advance main 
>>> topic1..topic2 >result-bare &&
>>>       test_cmp expect result-bare
>>>   '
>>>   @@ -115,7 +136,7 @@ test_expect_success 'replay fails when both -- 
>>> advance and --onto are omitted' '
>>>   '
>>>     test_expect_success 'using replay to also rebase a contained 
>>> branch' '
>>> -    git replay --contained --onto main main..topic3 >result &&
>>> +    git replay --output-commands --contained --onto main 
>>> main..topic3 >result &&
>>>         test_line_count = 2 result &&
>>>       cut -f 3 -d " " result >new-branch-tips &&
>>> @@ -139,12 +160,12 @@ test_expect_success 'using replay to also 
>>> rebase a contained branch' '
>>>   '
>>>     test_expect_success 'using replay on bare repo to also rebase a 
>>> contained branch' '
>>> -    git -C bare replay --contained --onto main main..topic3 >result- 
>>> bare &&
>>> +    git -C bare replay --output-commands --contained --onto main 
>>> main..topic3 >result-bare &&
>>>       test_cmp expect result-bare
>>>   '
>>>     test_expect_success 'using replay to rebase multiple divergent 
>>> branches' '
>>> -    git replay --onto main ^topic1 topic2 topic4 >result &&
>>> +    git replay --output-commands --onto main ^topic1 topic2 topic4 
>>> >result &&
>>>         test_line_count = 2 result &&
>>>       cut -f 3 -d " " result >new-branch-tips &&
>>> @@ -168,7 +189,7 @@ test_expect_success 'using replay to rebase 
>>> multiple divergent branches' '
>>>   '
>>>     test_expect_success 'using replay on bare repo to rebase multiple 
>>> divergent branches, including contained ones' '
>>> -    git -C bare replay --contained --onto main ^main topic2 topic3 
>>> topic4 >result &&
>>> +    git -C bare replay --output-commands --contained --onto main 
>>> ^main topic2 topic3 topic4 >result &&
>>>         test_line_count = 4 result &&
>>>       cut -f 3 -d " " result >new-branch-tips &&
>>> @@ -217,4 +238,131 @@ test_expect_success 
>>> 'merge.directoryRenames=false' '
>>>           --onto rename-onto rename-onto..rename-from
>>>   '
>>>   +# Tests for new default atomic behavior and options> > 
>>> +test_expect_success 'replay default behavior should not produce 
>> output when successful' '
>>> +    git replay --onto main topic1..topic3 >output &&
>>> +    test_must_be_empty output
>>> +'
>>> +
>>> +test_expect_success 'replay with --output-commands produces 
>>> traditional output' '
>>> +    git replay --output-commands --onto main topic1..topic3 >output &&
>>> +    test_line_count = 1 output &&
>>> +    grep "^update refs/heads/topic3 " output
>>> +'
>>> +
>>> +test_expect_success 'replay with --allow-partial should not produce 
>>> output when successful' '
>>> +    git replay --allow-partial --onto main topic1..topic3 >output &&
>>> +    test_must_be_empty output
>>> +'
>>> +
>>> +test_expect_success 'replay fails when --output-commands and -- 
>>> allow-partial are used together' '
>>> +    test_must_fail git replay --output-commands --allow-partial -- 
>>> onto main topic1..topic2 2>error &&
>>> +    grep "cannot be used together" error
>>> +'
>>> +
>>> +test_expect_success 'replay with --contained updates multiple 
>>> branches atomically' '
>>> +    # Create fresh test branches based on the original structure
>>> +    # contained-topic1 should be contained within the range to 
>>> contained-topic3
>>> +    git branch contained-base main &&
>>> +    git checkout -b contained-topic1 contained-base &&
>>> +    test_commit ContainedC &&
>>> +    git checkout -b contained-topic3 contained-topic1 &&
>>> +    test_commit ContainedG &&
>>> +    test_commit ContainedH &&
>>> +    git checkout main &&
>>> +
>>> +    # Store original states
>>> +    git rev-parse contained-topic1 >contained-topic1-old &&
>>> +    git rev-parse contained-topic3 >contained-topic3-old &&
>>> +
>>> +    # Use --contained to update multiple branches - this should 
>>> update both
>>> +    git replay --contained --onto main contained-base..contained- 
>>> topic3 &&
>>> +
>>> +    # Verify both branches were updated
>>> +    git rev-parse contained-topic1 >contained-topic1-new &&
>>> +    git rev-parse contained-topic3 >contained-topic3-new &&
>>> +    ! test_cmp contained-topic1-old contained-topic1-new &&
>>> +    ! test_cmp contained-topic3-old contained-topic3-new
>>> +'
>>> +
>>> +test_expect_success 'replay atomic behavior: all refs updated or 
>>> none' '
>>> +    # Store original state
>>> +    git rev-parse topic4 >topic4-old &&
>>> +
>>> +    # Default atomic behavior
>>> +    git replay --onto main main..topic4 &&
>>> +
>>> +    # Verify ref was updated
>>> +    git rev-parse topic4 >topic4-new &&
>>> +    ! test_cmp topic4-old topic4-new &&
>>> +
>>> +    # Verify no partial state
>>> +    git log --format=%s topic4 >actual &&
>>> +    test_write_lines J I M L B A >expect &&
>>> +    test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'replay works correctly with bare repositories' '
>>> +    # Test atomic behavior in bare repo (important for Gitaly)
>>> +    git checkout -b bare-test topic1 &&
>>> +    test_commit BareTest &&
>>> +
>>> +    # Test with bare repo - replay the commits from main..bare-test 
>>> to get the full history
>>> +    git -C bare fetch .. bare-test:bare-test &&
>>> +    git -C bare replay --onto main main..bare-test &&
>>> +
>>> +    # Verify the bare repo was updated correctly (no output)
>>> +    git -C bare log --format=%s bare-test >actual &&
>>> +    test_write_lines BareTest F C M L B A >expect &&
>>> +    test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'replay --allow-partial with no failures 
>>> produces no output' '
>>> +    git checkout -b partial-test topic1 &&
>>> +    test_commit PartialTest &&
>>> +
>>> +    # Should succeed silently even with partial mode
>>> +    git replay --allow-partial --onto main topic1..partial-test 
>>> >output &&
>>> +    test_must_be_empty output
>>> +'
>>> +
>>> +test_expect_success 'replay maintains ref update consistency' '
>>> +    # Test that traditional vs atomic produce equivalent results
>>> +    git checkout -b method1-test topic2 &&
>>> +    git checkout -b method2-test topic2 &&
>>> +
>>> +    # Both methods should update refs to point to the same replayed 
>>> commits
>>> +    git replay --output-commands --onto main topic1..method1-test 
>>> >update-commands &&
>>> +    git update-ref --stdin <update-commands &&
>>> +    git log --format=%s method1-test >traditional-result &&
>>> +
>>> +    # Direct atomic method should produce same commit history
>>> +    git replay --onto main topic1..method2-test &&
>>> +    git log --format=%s method2-test >atomic-result &&
>>> +
>>> +    # Both methods should produce identical commit histories
>>> +    test_cmp traditional-result atomic-result
>>> +'
>>> +
>>> +test_expect_success 'replay error messages are helpful and clear' '
>>> +    # Test that error messages are clear
>>> +    test_must_fail git replay --output-commands --allow-partial -- 
>>> onto main topic1..topic2 2>error &&
>>> +    grep "cannot be used together" error
>>> +'
>>> +
>>> +test_expect_success 'replay with empty range produces no output and 
>>> no changes' '
>>> +    # Create a test branch for empty range testing
>>> +    git checkout -b empty-test topic1 &&
>>> +    git rev-parse empty-test >empty-test-before &&
>>> +
>>> +    # Empty range should succeed but do nothing
>>> +    git replay --onto main empty-test..empty-test >output &&
>>> +    test_must_be_empty output &&
>>> +
>>> +    # Branch should be unchanged
>>> +    git rev-parse empty-test >empty-test-after &&
>>> +    test_cmp empty-test-before empty-test-after
>>> +'
>>> +
>>>   test_done
>>

