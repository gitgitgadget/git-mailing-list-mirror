Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516902;
	b=jSVwGsHva/iBUy/uvs/Ovyw8bmv2zVQt82eCgcbJZA/V5sg+3mNe76TTVsD6fkg62Fxs
	 kwvRjNHkzR6ne5/t0+1jT0Q0rX/v1Ywt3wX0fOWNg9Ejx3r+TXSj2B4xoL3eRTqSIfZG3
	 wI7wdNc7IIqA878kG9xUZW20hCz1pCaM+gewKGw7bHLuy3yRQx8EMCTemwI/t059+uZVR
	 Yjf3VTrQQAd0fG5FpXGqO6/4/DqYyiGgz8eoJJVxT39xcIcL9T3eZqN4MaWIqU+wgdFSa
	 cxKdTbp5H366GSo0fw8RUTncY0y4d2iZ7BPTvbIkHMxjKat3tuDKV/6zgb1lHfWWXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sRmGQSPxbDeSAW2p1O2ckNyEfhMMjWfK+EaI4mtGIjE=;
	b=AUTlMwjzuXb0oJfDccecNNpQys8yxW07N/qviRaNqQf8HaXeo1lOLsLf1tGjYI34d3Yd
	 HjtpMUOZO5KgyKgd4oldEykHXIs3sdXiR3z/haau71G2j6Vw9PIZ38N3jMROi3XTqSn5P
	 ob3F4hLYg09bhZBGeDmxizwqnsnKEWYxr3JgfoXIYpKoIxTcNJGHFmKPpaYlIiBF1IxI9
	 v5jHP7G79CmWdP0JhrqpFc4cKM/bB7kARqCm+7ts5R9y4eR8V3WjZokYX2l8F2VKFrBSA
	 1idCrrGLr+r6ANkbo3RXed1b4bK7lsyVkuTUYHggOadlWDg4ZjnmmuZ0em7siNY3Tbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSC7ePsA;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60403606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60403606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSC7ePsA
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso52660845e9.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795516901; x=1796121701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sRmGQSPxbDeSAW2p1O2ckNyEfhMMjWfK+EaI4mtGIjE=;
        b=rSC7ePsA/opetvWTFaHFEUYeFcmWESWGtfmH7xwLKHGHXKNqm9RMIUiu8z5Z6icvnV
         j6y3foXnHNBiG0pNc0uMoQf+Qlq1lpoZw1BZ5rW3Ec4ZKr2A9E82IFjI7ZLOgIFgL2L8
         KRTgpbpJx7W14BGIY2pv8+Ia29ULal4raB6uWUK0u5Bb+L7vy+gCZb9HDigWDnd/yTAu
         vsb0olXDTMwGkgKsbD8MTUM50j4V/yeoARX7iL89+R7NylBtYAYPvKNpeT/5MDzyOA3D
         eREaGRzdZqA7xB11uRkwOYnIpFwn5Vxa4w1hERaaIJ6Hmxxd1TboDzjfGiOrrYwGjxVI
         BV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516901; x=1796121701;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sRmGQSPxbDeSAW2p1O2ckNyEfhMMjWfK+EaI4mtGIjE=;
        b=2L/RLdSTU8/UShAd4BFHb8BIYXHBcmoQHq6mFbY49HhCxhppIbzSzLRzQ8m6Pwg2UC
         cNYo77o22lr08NN+xcqk/T8WHxMnYgus6m+lhoKrz6Xtv+r3RgPb1hOq2euWeR9eWPn+
         9WMFBqab7TS49u59iGv1UH8sBhqMSkIrHS6cCkftItGtxlAiiSvD1dmw8JZ8kSFbAP1t
         OqBf/pxsY4aJLfqIIUImt12h9ExlSposAlZHugfz4uCKYO8XktZyd3WP/KlKz5NBhrBE
         CKiSrlIzNNRAP1UrjktbSy4J3dSthrsb9POMeDY52ycoSmbNYM5nKz1W6qoLUbWpCOFd
         eGYw==
X-Forwarded-Encrypted: i=1; AL+hErE7KVgAklAwzggsIEc6bI6/89IZ1rD+Dpjo3sOPW80a3BM8GHAZyL/0ySEIBaEeOixTIrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VFkyuzpuAoz9CUM0x4eAxQdfI85noMUNqLSu5idsn8GiuyRwW
	7TzAnGHPSFI2c46JLojRvcSWWO63rwmQ2b1feFq6939B4yQlbX7j2PMe
X-Gm-Gg: AZFdTZdUR4VWLd08WQ5jqt6d7mkTDTDKDrqusEwyw/juUNA9ZBR7+GpBF6Yqhr57CXP
	hFNeMb7Aj/27AW4AxEN0HKcOo/KbzxvQTo0v8aARByu09tOCNOScKSzvRs8gPEivA85YXng7D03
	UuVi47qoChFnRh4pmQReJPS3iqAbkiegUD8104TVyOOy9mcODbmmC6PQ3lt7fwyURBE6YcGbOUr
	SIRBE3ZfLtda4pzocsW1LLDp9kH/gIRdnkBnsjGQnWuW138jzd/kDcviRdlQDKhxCUfUzfZfhG1
	Ry7qzBl0HxKprkSusH8UJb7ZC72O6H16xuhLbiHvZxDnKznCNAnJuKdDwWOyN6pNCrWmXVfMsqt
	dYFmlztVr2sYsE3V9x5eammhNHVoXRZvqS1X7a5u6sKnhbQr/hX5YK0c0dJ81wzawLokp2VkoVT
	N+xcM3KkH0E6oR1+AwCPNRLmfmsxcjDYCEk5/TMwb/6Fnu3QssWYuWOBHkBGA+uDKzV6/3FIhxS
	c+lFP21+nKsX2jhY6CHu+NGK18kKRAkE0OjbKDBFNNE+T1kmw9R0uxZYlwWc9N7Ck924vWsH1NO
	GHVxrI7MFQ53s1KzCrkNAZsbsZVeG3oSCupfqdDAbxFRthJW0uSmd+ykIyOYOTijTqBJyMIG1xa
	Lmf9Eivs=
X-Received: by 2002:a05:600c:154c:b0:4a2:1364:252a with SMTP id 5b1f17b1804b1-4bb887c28a8mr291847625e9.3.1795516900572;
        Tue, 24 Nov 2026 02:41:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm480438355e9.3.2026.11.24.02.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:41:39 -0800 (PST)
Message-ID: <6d20285a-f8ec-4dbd-bc23-a97f42ec9260@gmail.com>
Date: Tue, 24 Nov 2026 10:41:31 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: reset saved HEAD OID when picking onto an
 unborn branch
To: Wonseok Oh <wonseok_oh@korea.ac.kr>, phillip.wood@dunelm.org.uk
Cc: Wonseok Oh via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
 <27abe897-cba1-4561-816a-875c064ab8c0@gmail.com>
 <CAD2pp5sZ29TT6JHwA88XTC3dymjrtAbKmy-gyyZ1oiA2pEomxA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD2pp5sZ29TT6JHwA88XTC3dymjrtAbKmy-gyyZ1oiA2pEomxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wonseck

On 24/11/2026 02:33, Wonseok Oh wrote:
> 
>> I had a hard time parsing the second half of that sentence.
>> sequencer_rollback() expects us to have saved the null OID when HEAD
>> points to an unborn branch, but instead we save some random junk because
>> we haven't initialized the 'head' variable. The use of an uninitialized
>> variable comes from 0f974e2124 (cherry-pick: allow to pick to unborn
>> branches, 2016-06-06). Before that commit we refused to cherry-pick onto
>> an unborn branch and so did not use 'head' unless it was initialized.
> 
> Thanks for the review and for digging into the history.
> I'll reword the commit message along these lines
> and mention 0f974e2124 in the updated patch.

That's great

> 
>> I see that rollback_is_safe() expects to see a null OID when picking
>> onto an unborn branch, but update_abort_safety_file() writes an empty
>> file in that case. We should be consistent about the way we represent an
>> unborn branch in the state files. Arguably an empty file is a better way
>> of representing an unborn branch because there is no OID.
> 
> Along with the reworded commit message,
> should the updated patch also save an empty ".git/sequencer/head" on
> an unborn branch,
> to align with update_abort_safety_file()?
> If so, I'm happy to include that change.

Thinking about it some more, older versions of git are expecting to read 
a null OID in both cases, so we should standardize on that.

Thanks

Phillip

> 
> Thanks
> Wonseok Oh
> 
> 2026년 11월 23일 (월) 오후 11:32, Phillip Wood <phillip.wood123@gmail.com>님이 작성:
>>
>> Hi Wonseok
>>
>> Thanks for working on this. I think that as an immediate fix for the use
>> of an uninitialized variable the patch looks good, but I'm not sure the
>> behavior of cherry-pick and revert onto an unborn branch makes much sense.
>>
>> On 21/11/2026 06:30, Wonseok Oh via GitGitGadget wrote:
>>> From: Wonseok Oh <marinelay7@gmail.com>
>>>
>>> When picking multiple commits, "git cherry-pick" stores the current HEAD
>>> in .git/sequencer/head for "--abort" to return to. If the branch is
>>> unborn, repo_get_oid() fails and leaves the object ID uninitialized,
>>> but sequencer_pick_revisions() saves it anyway instead of clearing it
>>> to the null OID that sequencer_rollback() checks for to report
>>> "cannot abort from a branch yet to be born".
>>
>> I had a hard time parsing the second half of that sentence.
>> sequencer_rollback() expects us to have saved the null OID when HEAD
>> points to an unborn branch, but instead we save some random junk because
>> we haven't initialized the 'head' variable. The use of an uninitialized
>> variable comes from 0f974e2124 (cherry-pick: allow to pick to unborn
>> branches, 2016-06-06). Before that commit we refused to cherry-pick onto
>> an unborn branch and so did not use 'head' unless it was initialized.
>>
>> It is rather strange that when sequencer_rollback() rejects an unborn
>> branch it refuses to remove the sequencer state so that it is impossible
>> to abort a multi-pick cherry-pick started on an unborn branch. It is
>> also strange that we will try and revert a single commit onto an unborn
>> branch but not multiple commits. 7acaaac275 (revert: allow single-pick
>> in the middle of cherry-pick sequence, 2011-12-10) inserted a separate
>> code path for single picks before the check for an unborn branch, so
>> prior that commit we refused to cherry-pick and revert onto an unborn
>> branch regardless of the number of commits. Going further back in
>> history, the check for an unborn branch was introduced by 04d3d3cfc4
>> (revert: Save data for continuing after conflict resolution,
>> 2011-08-04). The commit message does not mention a reason for
>> introducing that check and therefore changing the behavior but I assume
>> it was to avoid having to support aborting to an unborn branch.
>>
>> It would be nice to either remove the check for an unborn branch when
>> reverting multiple commits, or move the check so that it covers single
>> picks as well. It would also be good to allow the user to abort when
>> cherry-picking onto a unborn branch. Those changes don't need to be part
>> of this series though, they can always come later.
>>
>> I see that rollback_is_safe() expects to see a null OID when picking
>> onto an unborn branch, but update_abort_safety_file() writes an empty
>> file in that case. We should be consistent about the way we represent an
>> unborn branch in the state files. Arguably an empty file is a better way
>> of representing an unborn branch because there is no OID.
>>
>> Thanks
>>
>> Phillip
>>
>>> As a result, "--abort" errors out with "Could not parse object" in my
>>> master build, while in Debian's 2.47.3 build the uninitialized memory
>>> happened to hold the last picked commit's OID and moved the new branch
>>> there.
>>>
>>> Clear the object ID to the null OID when HEAD cannot be resolved, and
>>> add a test.
>>>
>>> Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
>>> ---
>>>       sequencer: reset saved HEAD OID when picking onto an unborn branch
>>>
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2317%2Fmarinelay%2Fcherry-pick-unborn-abort-v1
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2317/marinelay/cherry-pick-unborn-abort-v1
>>> Pull-Request: https://github.com/gitgitgadget/git/pull/2317
>>>
>>>    sequencer.c                     |  9 ++++++---
>>>    t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
>>>    2 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 4a1c0e70b8..20bfe00ba3 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -5788,9 +5788,12 @@ int sequencer_pick_revisions(struct repository *r,
>>>                goto out;
>>>        }
>>>
>>> -     if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
>>> -             res = error(_("can't revert as initial commit"));
>>> -             goto out;
>>> +     if (repo_get_oid(r, "HEAD", &oid)) {
>>> +             if (opts->action == REPLAY_REVERT) {
>>> +                     res = error(_("can't revert as initial commit"));
>>> +                     goto out;
>>> +             }
>>> +             oidclr(&oid, r->hash_algo);
>>>        }
>>>
>>>        if (save_head(oid_to_hex(&oid))) {
>>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
>>> index 9400ddfc45..75004bba0c 100755
>>> --- a/t/t3510-cherry-pick-sequence.sh
>>> +++ b/t/t3510-cherry-pick-sequence.sh
>>> @@ -269,6 +269,16 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
>>>        test_cmp expect advice
>>>    '
>>>
>>> +test_expect_success 'cannot abort a cherry-pick sequence on a new history' '
>>> +     pristine_detach initial &&
>>> +     git checkout --orphan new_disconnected_seq &&
>>> +     git reset --hard &&
>>> +     test_must_fail git cherry-pick base..anotherpick &&
>>> +     test_must_fail git cherry-pick --abort 2>advice &&
>>> +     test_grep "cannot abort from a branch yet to be born" advice &&
>>> +     test_must_fail git rev-parse --verify HEAD
>>> +'
>>> +
>>>    test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
>>>        test_when_finished "rm unrelated" &&
>>>        pristine_detach initial &&
>>>
>>> base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
>>

