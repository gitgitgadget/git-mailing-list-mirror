Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591437;
	b=MeW5pKCXeDW/WPZiLUzXsWZkL8lujPGrszSEm+Xvj2r1xTnuecH3/1fjTdgK02t3ggoc
	 dAE1ExkCrRhjcaVLhiCOVBHZ0QZv1G3Nf21mGZ5mAXEPTNgTaZ0NLudRM8AlYKnXwoh0U
	 0thUqePZPO4AmEVAmP2fc5WBm9a8Jnpcm10/Ql9QdI7w6WIURRuYenFowcLiNGLZfkIT4
	 a/Dzd1DrvrzZ/QCTcYTG1MZCu3zBI6WjhjZxxg/zlw1GcleCWJCkdbKLX9UcAX2MULVb9
	 V2JCoYGdwBckDAO2yJbdmVnqnWID5eh4E5jdJo2Q9aTNweKPGeyqjEpiMKinX7p8iwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=o9srrQcCEXZkyzbzpXsLVPEzLa+z1EVTxvUK/CN93B0=;
	b=MFFCTTsbRVXzMLmPN8FEn0GVY47HaD5EinsecQ+z9VshQmjoGxT4PQsnuZJ+Cyt3oxEz
	 s9jrSVpo5qihhJ3wN/tCD6mlpbwZ4tMJUkVdPc0AY1olyIamz1RhfpJ5K419a3fF60ljV
	 Zv85lKSfQ7yiU0ZWySrAwmgiPlmqxEcKAvsUhlIm/g6HPbCHoAbp71aenZyij31p8Dkf3
	 A4AHA1kze5v15g0FtFll+DURcqsqgf7QHeDU56bzlkHKloJUz/b2WHkWgoZ9E9TZ2BpnC
	 oS/sdKtunBWYLVN9gQiVWwLTNXbI5yjyjZBsXyv8+pJ0GEJWuo8E7L/ozNf5ITqsANg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f1wJmlUE;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BF606A31E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B07BF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f1wJmlUE
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e0d885929so615093f8f.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792591435; x=1793196235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o9srrQcCEXZkyzbzpXsLVPEzLa+z1EVTxvUK/CN93B0=;
        b=f1wJmlUE+7YPk3AjOZHYQM1Cog+q3lfQqvq1wnV65lLsANuyOLn1NLMxyWQNX1Q9r/
         bWE84W7NK5VnJkvtAjy9qXWJGyZ3inwgstHLZZQmpLnl0PSMCRGtUmOY7gyOkUuqdujl
         8xoWsSua+3hCzVjoWzeBpTXUG2NYEO38lRIgufBWXBAncnCV/Tf6WKWfB3RUn3Ltg4Ow
         +3cISM0l2Do0VD2kppAqmP9JhMwYeoYruQsh74j2WZRrvDHWanBorPSzj2N7J5jL2Pks
         FveakK1ltJ6Qp7ZzkonMcXXPbj1s2BHBHNwU3vTwTlhTKCy9G1WCmmUmWB5zWt2cLjo4
         73DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591435; x=1793196235;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o9srrQcCEXZkyzbzpXsLVPEzLa+z1EVTxvUK/CN93B0=;
        b=dugiak9hDQ/kUSkZAgvYj8wQE/9wUEVyKb2q0dpxO15fLsLuYgbas/ztEo+hJX2za0
         +30OXd8eRp91Mgl/+GTMCnrLGSidieOOqiu40kLrAMwrc/jIz5omXzWqqC0djkJcCeUn
         kPTIPTmuT5JrLuDDSZeZXQPjJzOnue1bg0vMEKxiE5HegD9Zmo2FYnvMBp//VxqEYFQl
         bwPo1wPLkdZC0FktQrXcbZUgIJkaXbWG7zx/N+I9UL45uXCouP95HyUMVpaxZECMr2Hd
         8d7xEmOowfQQPJPGP0t5A1JrqsFn9EFNwOyeobmmhgNj71jpCrdIUdAqs5kmWEWx1KTW
         RN6A==
X-Forwarded-Encrypted: i=1; AKwUvBzjpiQCy4RVnLbmNdY1p63M57vKE6kRvmxJVtGwgh+NyhH8Hvdg6djDtei0388rCWS+y8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWJKbasIBTrnMFfRP5S38Akij+OnOTXluQiT19GIe9fZctAu4o
	XU5Egej5+nZSgFXZMcVpEhDwDN5JajuBPeB7A5B7ThkN/FBZYSxMWFps
X-Gm-Gg: AYBFou2ELAvb5pOToG7NyFurKpsmLvMHcnJPhqs4aplCXdpReic+5dk0OSZE6bg5cIE
	yADMqU+m8/2f+qDU/3gS8C9h3dx32YXp9+6hVk/oxYWOMHpjzxXuZ6HbXM8XFTfNE9AgU3T1LdI
	F3uMgWDmMwt0miywKVL+jal4xjjOK7+RwOZG2IEiRj01/Dcjf2WQX4xQNpQe8g+BieZnD6kOvgu
	3rRuEDc8X1D101AkI+z3X0RHPl8GdlcGLnbbmcObH/wU+IFmi4NwL3P8e17DesZiU8wYSX+atJ9
	HPgh8+RfpfIbuHZ8p2mn5McuckqGGWzW3XAv47yfJjq+6u6DrZiVFx0q7As7rWTHChMfPElU/je
	90Ztt4qVlwvouPYTUCEdUg48IGGbtmT0SHX6BKUizA2tbzQi0ZVHTkIbOUz28sOm7zLxps54Vox
	WdiinbNqRqNuKwVeisH8w19O+vVKurXRIh9jiP6WRWvELz+uTSsSrQuza9zgLHva6VzHCvGnfrL
	0SG3gfmuUJzjA/ig5ZsW5M39seDrkeVlaJUGVEhhscIdqqZH2xq2Keh2bSztQn8AysyUf7KHQn2
	Ia1811pcRxGDfd1b4ThyCs4tJu39saylhA==
X-Received: by 2002:a05:600c:8b10:b0:4a1:fe55:88ef with SMTP id 5b1f17b1804b1-4a1fe558af6mr44957475e9.20.1792591434784;
        Wed, 21 Oct 2026 07:03:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25841fe4sm5996914f8f.53.2026.10.21.07.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:03:53 -0700 (PDT)
Message-ID: <43b81ed2-6cc2-409b-be39-fa5b0911f532@gmail.com>
Date: Wed, 21 Oct 2026 15:03:52 +0100
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] worktree: reap ephemeral branches created by
 "worktree add"
To: Jason Newton <nevion@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Cc: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
 <6e2acdc5e2578da4e915fd2ac541a776349fb23e.1792512249.git.gitgitgadget@gmail.com>
 <CAPig+cRsSN9gY405MGsCQzLuxzBKcfHo2Oc8Z4WB-U3BGd6m_Q@mail.gmail.com>
 <CAGou9MgdF_xA+e8YYn8ud8TUSmY3j_q9jbUTy2wLibTz1ObJ7A@mail.gmail.com>
 <CAPig+cRCaSmEULP1JpW3fjiJDR0Lee78puq+KRaXiD9ciX3fvg@mail.gmail.com>
 <CAGou9MirKucUdx8eM-BfqO9sZrDrckwpp9sYDnDVfiqkdZ8wdw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAGou9MirKucUdx8eM-BfqO9sZrDrckwpp9sYDnDVfiqkdZ8wdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2026 09:28, Jason Newton wrote:
> Please focus on reviewing, I use mixed but you shouldn't assume which
> parts are and are not llms.
> 
> What you don't realize by working in a silo for a long time is your
> communication skills to external parties gets reduced with jargon and
> nitpicking ; I have the llms both assume you're wrong and right while
> seeing the undesirable behaviors your stances have to the one that I
> know is correct.  You seem overly sensitive to the usage so far. I
> have no tollerance left to give - so stay on point. You should
> consider several harnesses chose not to even go through PRs and work
> around the functionality like grok build did, patching it in
> externally which is kind of nuts - and replicated.  I think it's
> something you should think about the nature of quite a bit.
> 
> As I mentioned, detached IOWs sucks and you shouldn't have bothered
> mentioning it because it fails hard, though it was noted and evaluated
> in earnest for a bad idea - want to go back to the long but more
> neutral form?

I'm afraid this messages falls far short of the standard of constructive 
discussion that is expected on this list. It is perfectly possible to 
disagree with someone without attacking them or telling them what they 
should or should not be doing.

It is clear that you do not like the current behavior of "git worktree 
add", but replying with a generic list of the differences between a 
branch checkout and a detached HEAD and then attacking the reviewer does 
not explain what problem you are trying to solve and is not going to 
convince anyone that this patch is a good idea.

Thanks

Phillip
> -Jason
> 
> 
> On Wed, Oct 21, 2026 at 1:07 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> On Wed, Oct 21, 2026 at 3:40 AM Jason Newton <nevion@gmail.com> wrote:>
>>> --detach and an ephemeral branch differ while the worktree exists.
>>>
>>> --detach leaves HEAD with no branch, so status, push, rename,
>>> upstream, and symbolic-ref have nothing to name. An ephemeral
>>> branch is a normal refs/heads/ ref for the life of the worktree.
>>> Commits go on it, and another ref can point at them before
>>> "worktree remove" deletes that branch.
>>>
>>> Deleting the branch that "worktree add <path>" creates today
>>> would change the default, so this has to be opt-in. That opt-in
>>> is not --detach: the worktree stays on a branch until removal.
>>>
>>> These worktrees might be minutes or they might go on for months;
>>> either way they should be easy to use and not require flags to assist
>>>   in the majority of common case behaviors, moreover detached feels
>>> ike a degraded halfway state, frequently allowing a gotcha to strike or
>>>   a loss of a safety like a gc based reap.
>>>
>>> "git worktree remove" does not delete whatever branch a worktree
>>> has checked out. It deletes a branch only when this "git worktree
>>> add" created it by DWIM (the final component of <path>) and recorded
>>> that in worktrees/<id>/owned-branch.
>>>
>>> A branch named with -b/-B, a branch that already existed, and a
>>> detached HEAD are not owned and are not removed. A worktree created
>>> by an older Git has no marker, so removing it still leaves its
>>> branch in place.
>>>
>>> "Unconditional" in the commit means that this one owned branch is
>>> deleted even if it has unmerged commits. --keep-branch turns that
>>> off. "git branch <name> <tip>" before removal keeps the commits on
>>> an ordinary branch; only the owned ref is deleted.
>>>
>>> The call that changes is "git worktree add <path>" with no branch,
>>> followed by "git worktree remove". A caller who wants that branch
>>> to outlive the worktree already has a spelling this series does not
>>> touch: "git worktree add -b <name> <path>", or "git worktree add
>>> <path> <existing>". --detach still creates no branch, so it is not
>>> the same state while the worktree exists.
>>>
>>> Ownership is written only when the worktree is created, so I'll confirm
>>> an older worktree still has no marker after an upgrade.  The branch stays.
>>> Upgrading does not mark a worktree you already have so no upgrade
>>> headaches are expected.
>>
>> Feeding a reviewer's comments into an agent and pasting its
>> LLM-generated response into an email is not a good way to convince
>> project stakeholders that the submission has value. If you can't
>> explain its value in concrete terms in your own words, then you're
>> going to have a hard time eliciting any responses or additional
>> reviewer feedback.
> 

