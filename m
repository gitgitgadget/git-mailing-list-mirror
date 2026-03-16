Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073C192D97
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659003; cv=none; b=YeByoHLpCk6Q1HmHGYaiEVvmf+cJm0xb9S/SXD2fG52ylPXXwXtetBmCri7eMI+K2CBjMYMDonNgI0HvedqEM+RHPRKW0mP8yHgMSSC2ApY/2OPuhy4UWcblbcgE5CcAkRmg1ELgW4SruwrOn0R0CC0DwV5cFkXZjlItNSz5VTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659003; c=relaxed/simple;
	bh=L1kTZgRAhipoyo4IeBD8hNnGsYYQwZgzLS6dVKGSlmI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=a5OxtAb/26awiuyG9YdtHQr2/FGX2piOaVz1WCwaaNkPx0VCAkkQ5rM+c7RPhmZryjfT32An8ZzDBSlHLDUO/v4meFkHd2eMnLIIcoZIs/IvAtfFw9RdGFN3+57b+sBKxFjKEaGECfDK9XMig6sCV10BmGBqw8FGLDCMo/azXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0DdjCIT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0DdjCIT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48529c325f0so31604315e9.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773659001; x=1774263801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rL9BaB7/ZYPtP82bIdCFXyNuq/2HadqA+jIiXKoyVB8=;
        b=H0DdjCITXBV3IUq6OnD8NkYZmTobhSk45zJT65rQBAsxoGf2Hjfo+K2CABdJqCjJ7J
         tz256fob2FK+uwl44qrjqNMmDED9m2uJBfu2XNrw4U9EvC4tYHB7giJdM36gImeit5od
         WBGBVErPuSCeHMTT229N3dLObCxoTpN+/AYMOrJyKmMO2o3Ny15VhQfC+z5/oYWOXi5H
         dEXtOUdqcsHlzbIeWEBriuBV9KSx5h3Eli+TZdk4eKdYzr777Y5eD0yK5FG2gXYFEqzw
         pH0ailLapSJTu3CorlCOOoEc7QOp18abr9/RhG07bTCDSEVZadWqkjJ/4m5GSpmGIZBg
         RBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659001; x=1774263801;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL9BaB7/ZYPtP82bIdCFXyNuq/2HadqA+jIiXKoyVB8=;
        b=c3zF5y3NXoJpBjuTIQfnpH/CzazEixKQhSc2UJrnLU7ktOgCdzAMgqzg7sGshZIGWO
         nr8Y/DJZzr5UAfUILXed1dThKkwHnb5dQeNJWz00kZevIpCOKTVFnZRehW4Df5RrOrWP
         NKfaeoNa3Vc1yCqEUtdLdJwtAYPlP8mDi7ldCD87SXrBRZWQ1q0oMDG/2I2/6Y+Kan30
         /As30nRAi61wm7pZNFz6VkGu/qs8Wy7/R7IZR9KERA7pYM3M6psOd9or1blNIPJe8y0/
         DliTdGbYO38Rc4ff/mvhky7eIqg2TCqH1z6Tqh7E4yG+A/uY2H5SkHKD6sM+jOhS8BXf
         fRjw==
X-Gm-Message-State: AOJu0YxEX0E/1XOpY8FWga8CC141ArbuZvIMdDLfzwvHKS+nuvgJJIFK
	LFW36irzBf6cWmZxoi2FtBpNjvbX61vJHstGf3/D8Bf8XqfW5Yg+26oEoIRB7Q==
X-Gm-Gg: ATEYQzxYlYUX858DcNXBCuOVNIfQ/tKnDU6JUr4sJXoakXSSFZ2GBqOUGd8B6kghzMz
	iEyV/ihUsSPOpHnSBFUgsZF8jrirY3p5TjJ+RBpJ1FzrR24SSFGndA7F36nJHifRc2SkCn5v2RJ
	44hd8XqfvR21IQ6jcadVE39Bs5Ae+5ANlLPlkgtq1CY+wjbk6FXtPJwkp5zvJvfHsXTHqoQcsD4
	a/IVLt8R7aT7/Jf6KZZE60ZldAlIlA4Fu4GuPXg69Hz++bGmQmy6gOJRO6zFN9NkRnGkrIoLyTz
	ux4EnMQTQzkHm9C3fNVvlXcbOduCMOHWiUCURtcM1dOLqHb2p1+bM95rWTWg1xWsKSURPT0jYT2
	XRqkRxEftLsD6/Y9FdmBwUHzz7CecMsKsegqua5mejKk9H4uCOc+F8lxeV0GqRfwUs75s//UhSV
	mZ1gJGSP73iVcVZuWUEgk3BhWQm1gYCVv7Hu5yFYX9xTURWeLevrPtXgCxPgtiu4TrIUesSELxL
	dGfTQ==
X-Received: by 2002:a05:600c:1f8b:b0:485:3bb5:92cf with SMTP id 5b1f17b1804b1-485566cfb97mr223518615e9.12.1773659000678;
        Mon, 16 Mar 2026 04:03:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855725572csm180023825e9.2.2026.03.16.04.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:03:20 -0700 (PDT)
Message-ID: <82a8a222-b18a-405f-9a9c-92c6e0c05591@gmail.com>
Date: Mon, 16 Mar 2026 11:03:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: cherry-pick: add --show-current-patch
To: Florian Best <best@univention.de>, phillip.wood@dunelm.org.uk
References: <43529695-5987-486a-bdff-46f573868c4c@univention.de>
 <2d818389-6456-4b75-8a29-3167fc3c885f@gmail.com>
 <f2bf231a-2b18-4f1c-9cbc-2b94f669839f@univention.de>
Content-Language: en-US
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <f2bf231a-2b18-4f1c-9cbc-2b94f669839f@univention.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Florian

On 11/03/2026 19:42, Florian Best wrote:
> Hi Phillip,
> 
> thank you!
> Your reasoning makes sense, and therefore --show-current-patch is 
> probably a bad idea.
> I simply oversaw that complex sentence in the --help/manpage:
> 
>  >          2. The CHERRY_PICK_HEAD ref is set to point at the commit 
> that introduced the change that is difficult to apply.
> 
> Maybe adding "git show CHERRY_PICK_HEAD" to the Examples section of the 
> manpage improves finding it.

That sounds reasonable, are you interested in contributing a patch?

Thanks

Phillip

> Best regards
> Florian
> 
> Am 11.03.26 um 20:30 schrieb Phillip Wood:
>> Hi Florian
>>
>> On 11/03/2026 18:30, Florian Best wrote:
>>> Hello,
>>>
>>> When running `git cherry-pick` over a range of commits, the command 
>>> may stop due to conflicts. At that point Git reports the conflict but 
>>> does not provide an easy way to see which commit is currently being 
>>> cherry- picked or what patch is being applied.
>>>
>>> `git rebase` provides a helpful option for this situation:
>>>
>>> `git rebase --show-current-patch`
>>>
>>> This prints the patch of the commit that is currently being applied. 
>>> I believe a similar feature would be useful for `git cherry-pick`.
>>
>> That option exists for rebase because it originally applied a series 
>> of patches rather than performing a 3-way merge like cherry-pick and 
>> so there was no other way of seeing which commit was being processed. 
>> With cherry-pick you can use
>>
>>     git show CHERRY_PICK_HEAD
>>
>> which allows you to add any of the options that you'd use when showing 
>> a commit. That is more flexible than a "--show-current-patch" option 
>> because you can restrict the diff to the path that you are interested 
>> in, or show a word-diff etc. When reverting you can use REVERT_HEAD 
>> and when rebasing you can use REBASE_HEAD to see the commit being 
>> picked. I did wonder if the documentation could be improved but for 
>> cherry-pick it mentions CHERRY_PICK_HEAD in the description section at 
>> the top of the page.
>>
>> Thanks
>>
>> Phillip
>>
>>> Currently, when a conflict occurs during a range cherry-pick (e.g. 
>>> `git cherry-pick A..B`), there is no straightforward command to show 
>>> the patch of the commit being applied. While it is possible to 
>>> inspect `.git/CHERRY_PICK_HEAD`and run something like:
>>>
>>> `git show $(cat .git/CHERRY_PICK_HEAD)`
>>>
>>> this is not very discoverable and requires manual steps.
>>>
>>>
>>> Proposed feature
>>>
>>> Add a command:
>>>
>>> `git cherry-pick --show-current-patch`
>>>
>>> which would display the patch of the commit currently being applied 
>>> during an in-progress cherry-pick operation (similar to `git rebase 
>>> -- show-current-patch`).
>>>
>>> Behavior could be:
>>>
>>>   * If a cherry-pick is in progress, show the patch corresponding to 
>>> `CHERRY_PICK_HEAD`.
>>>   * If no cherry-pick is in progress, report an appropriate error.
>>>
>>>
>>> Motivation
>>>
>>> This would help users:
>>>
>>>   * understand which commit caused the conflict
>>>   * review the exact changes being applied
>>>   * debug large range cherry-picks more easily
>>>
>>> It would also provide feature parity with `git rebase`.
>>>
>>> Best regards
>>> Florian
>>>
>>
> 

