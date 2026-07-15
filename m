Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122745BD60
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130281; cv=none; b=Rj0eNIpypGsDwJLdZ7S3f1+jCJ/3cn5jyJHhhZ3X4aRnNrL4IGIswajwzu5NXVohwnKPOAu0OV8KF9m7mbS+6b8Ppdq6Ml8F1PMC/T7mLkjS109mBH/mkn0D8x649a+RUv9g9583yrPA3rynXHAoQFzO9i+3eCDM7pBwOPkxFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130281; c=relaxed/simple;
	bh=rarNrZxIjC01eWc5YH444loLrZUarapHnGF8l869G4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/lOiKC12+rlSGhrNeOUkbbcb8tmbjA1W+iELJC9dHWa45Z+v1EnwNnLxJWcYzBC4zSp/0v4X0aCXFf0/A8fv2Dk+T3yLnLGd2aUgGIOkGcHCKMsEH6FLPAeSpwM8+3t217d94r2vfzQYyFVii4rtWMzf3pwTYdEpXoJK60v/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG310Ndv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG310Ndv"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so1521319a12.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784130277; x=1784735077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mRdHjgRRls9H6XRnDnFFOzZw+EiZfFQZ7kLK9hDuE8k=;
        b=hG310NdvcSUlzaFE4dLQFajxHMPGINtw0U2FckQ40n03SLlZxtBr3boxMzx01tFy4e
         YicqRmLG7K8H91dr+eUe0gGbWFg7edxw6f6FBugmxxIIDW+YSVwByILYSfbfzwlaWWZo
         oDT6/gGoCCmj6sC8qYlUwDf0jUl2tNGc6jaObLNNeDMWHp6m+BO+tO9gPaaBOCJY31/p
         6IiuC9JwIYV/CulR+XD34oXMrjhnZrtaRCTZ2Xflx3JHrUckcGfMr94pIG6nrMpCt6es
         hfU+m41T3/AIFaCCkDfHg7DFZORb4jTXTvCd9POQ15tupLVKl0vSajXVXzY8S47PMXh+
         gykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784130277; x=1784735077;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRdHjgRRls9H6XRnDnFFOzZw+EiZfFQZ7kLK9hDuE8k=;
        b=I232sALbBRJY+e+foza4UJpOCaRLDjTjST4edXtG9Xwcp0oDRDSm+CLTHXAq4LrRKf
         ctSCaYpMs+i3VcGGPE5OzbECdfW0RNO6eGx661Oz/+JW27z9M4YDQwt+abVkbTetC7Nd
         n1yvBEm2VDhZMDyKUREEaYi/j1tmZoag+MSOkWibIQjjQpeezuNJ0McJfa9pQg3byetL
         vkomsc8ESBZemHQ3v43/O7oFZNKYeTDdRZ60qZJ6b1qCAtXwN5DJ2vZBak8sTFdO8Sk6
         +9+Fgii4rixqXgo7v7zXFl73Adl5v8oSsv0Sca4qetK82NtqxjS6yPtpvqjPC4GVlF8O
         NEUQ==
X-Gm-Message-State: AOJu0YzK8fl99jXJLwA33/rmUbGsou1T6QHOTHdIuSzNReng3QJvkel+
	SKUwHwWvOo56y1kmJxGlTSLN5BDVbgfSDRfipMotWZ4D4cHuUIAv/epm
X-Gm-Gg: AfdE7cl4dp0BcFOUtGgtDBBv4RRmbZVmyL2udmHs4O70ooFV4k3j8UF0CIAr3M68Dco
	/XkqY6Ku6VahJVyJTXp1daMYB0MeUoSqvuDq9lCQ6PK4HtxcQsuZ4pcBsD+GiPgMQb1mvbCNzG6
	EePozWPrDQgipNE6Y3WmDyQnSLyvVg/00RwvjczQ5c0fdOfFtl4koV1q13ucoFb5cIa7pLm/2Hj
	zseTXelhVTd7Fa+dHPYa1AJu6XHWORks9AoCqnb66Jf8VbwlvRdNGYTg0HTs1gbtfowVuqeEKa4
	65r9K2T8UOKHwRpxbLEner21VnQ00JFjTnznYfjm8vWlxJZ95hqYdOTbpFdOLTSf52EDZOwDnFf
	DvntV48JgTlenJaLuW02LOVbUWDB1YWBLBnpaYkJsBsujIDDWBE4F2BiQ5Q0Y1MQ+mgADExEvs1
	tSMgIe8lA7iJAir3as3wDFacbQc2Ntce85wLm2rUVCyCycrK6Di2ku1BOt15uozpf2Q2D1Ei620
	YyHKA==
X-Received: by 2002:a05:6938:a084:10b0:c16:744f:5bec with SMTP id a640c23a62f3a-c16744f7843mr253605866b.0.1784130277549;
        Wed, 15 Jul 2026 08:44:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871265d3sm58446666b.9.2026.07.15.08.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 08:44:37 -0700 (PDT)
Message-ID: <b4cf8f14-1ffa-4395-bc3e-936538574665@gmail.com>
Date: Wed, 15 Jul 2026 16:44:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash! empties
 its target
To: Farid Zakaria <farid.m.zakaria@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
 <xmqqh5m494yh.fsf@gitster.g> <7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>
 <DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Farid

On 13/07/2026 17:30, Farid Zakaria wrote:
> On Mon Jul 13, 2026 at 6:18 AM PDT, Phillip Wood wrote:
>> On 12/07/2026 06:01, Junio C Hamano wrote:
> 
> Thanks for cc'd. I'm not familiar with the workflow (I read the docs)
> but is there an email reply when it's accepted into 'next' that I will
> just look-out for ? I'm not subscribed to the mailing list in general
> otherwise.

There isn't a specific notification for each topic, but the status of 
all topics is in the regular "what's cooking in git.git" email on the list.

>>> So it might make sense for you to coordinate with Phillip, and wait
>>> for his topic to be merged to 'next'.  After that happens, you would
>>> prepare a merge commit of the other branch into f85a7e6620 (Start
>>> Git 2.56 cycle, 2026-07-06) or some other stable point, and rebuild
>>> this patch on top of it.  That way, it will be much less likely that
>>> I'd make stupid and unnecessary mismerges when attempting to
>>> integrate this topic into my tree.
>>
>> That makes sense, assuming no-one has any more comments on
>> 'pw/rebase-drop-notes-with-commit' it should in be 'next' fairly soon.
>>
>> Thanks
>>
>> Phillip
> 
> Phillip,
> 
> Let me know if you have any more comments. I suspect not much will
> changes logic-wise once I rebase it onto 'next'.

I've left some comments on the patch in a separate mail.

> For clarity, is the f85a7e6620 commit the 'next' branch ? I would have
> thought to just rebase ontop of 'next' and I'm a bit confused with this
> commit hash.

In general it is better to base patches directly on top of the topic 
they build on rather than on top of next. Once a topic is merged to next 
it should be stable, whereas the tip of next is periodically rebuilt and 
force-pushed. The tip of pw/rebase-drop-notes-with-commit is currently 
7e70d12417d (sequencer: do not record dropped commits as rewritten, 
2026-07-13) but that will change when Junio picks up v3. I find the 
branch tips in seen and next with

     git show $(git log --merges --format=%H --grep 'pw/.*drop-notes/' \
                -1  origin/seen)^2

> If there is anything else I should be aware of, I would appreciate a CC
> if you can remember :)
Elsewhere you asked about using AI. There are some notes about that in 
Documentation/SubmittingPatches. TLDR it is fine so long as it does not 
conflict with your obligations under the Developer Certificate of Origin.

Thanks

Phillip
