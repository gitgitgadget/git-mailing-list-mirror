Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012328;
	b=un+LbTuv1a/258CezNwL+Hw6nomBfdlSwyb622H4yXYJdO1FCDlh4w4s5nJCIHhnYXJ1
	 FvZWr/uYzuLNc+VHV1pgiECeCKxqE06zLi5SKfeP8eZZl+cbbR/krrZW1FjNAUaoUiI9N
	 +C45od2FaG+BWQ9HyKG3dN2b0DuDkUWqXBhFCWhy+hb5PBeqrlC4nbKkpZrhUVq/dMkz8
	 av3+PwJkFmL9WSdeIZMSd/7r5BNAwk3683/OBy1Wo8AbT9LKQpWWpniJXxP1Mlhp9rHy8
	 xa1b+wJ4ILjMeugN5KR04d8makZQq4srx/oj3Q4Zza3+XqfhML5Yw6TushN+leHh/Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GqTN+NP54vXNAWDNlS0F69mEIYJibC9gHhup20cNaSc=;
	b=UF79icoGL1h9Am8STIhNmY2c7kSiR/LRVXwme4KjslEtjbhvzxgngSoyP+t+zCLg8XCb
	 w2S6XsWYlFvfncdICaFAe3bx7kKw9s8Bn4X3d+Dz9KL9TfkGSZ9T1/EDsztjvepzJspnq
	 ioLlQy2bUrRVYeiXZrM8Jx4cjNo/m2WWhJQVJOy5SQ2mzkq20myQcqooodLcesb6SljSX
	 1LvZ7bVFqHC5WHF1K+YzUjeYSxqibw55bgljNnJIvLTtTRyC7IHLaEvTRYyGOU7QQyLv8
	 qOmTk7g5DNQqRWUS6FWuBB+Q+3BAINipbCuAU1CYSyMvKXPxCRfxlJOqztBq7Nr30Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hjXQGnFC;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5C606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B5C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hjXQGnFC
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso2126031f8f.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012326; x=1793617126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqTN+NP54vXNAWDNlS0F69mEIYJibC9gHhup20cNaSc=;
        b=hjXQGnFCiWggrFKbtQaLTGFmIMTCMrjhlFNoosl5Ctx4Ayui+5VpoMFjkrfKUeqfeb
         fWsZZT5nbT3eswC+0SkIxWMCMLBw972uxNs2pz6AbZJkUEEvar2uAiThY0o9Zq+f+g/e
         ysms2qNwOZEHJaGXpuHICgLHrlrviP5/SEfeMTXrXv6V1M3a6mHB0URYmE/L7rBMMHlp
         c31Nv+W0vje4aYHDYC2w8mqkIobuy1Uttezfm0Tg9cgSQ1Yhx75BkogXWlu1pRxciFcG
         Z3xiCErCjLh+Hte/9OiwcEfIzY0TP1oK6K+WobRhUTs9pZpMj2X41q6ozGwDHdID4zzh
         P2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012326; x=1793617126;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqTN+NP54vXNAWDNlS0F69mEIYJibC9gHhup20cNaSc=;
        b=OjQcyBzsNCQl38pl+J/nWg1Wuu/HjticL+blM3pOSedDi5+G6f9biyDT/Ordn/YU1S
         vXXTyS2svodwk1QC7RoBZPBQZYv+cUJMkdQFrh2iChuY9kVA5N3qJn4BQjk5kL5zpxOf
         5UHIdb5X3Fpkbao+7czlmt+BoinYS25q5Eh7t+rxYVZAnxZBUuw35YgF4L9GATmFqzVE
         FU5FkARq3YobEi7cbZx+7bCf3JqgtKzY2yE66tTyNe0EV4ZjsTLN+Ikd7TpcG+7wWr+K
         Gdtz7uoEHmQmAP3C+OJxGrUGujIXaSSu0mnbqnVxCLRucs/F6HzmQwp+zolO5U8Gvt2c
         jjUA==
X-Forwarded-Encrypted: i=1; AKwUvBz7DwEvSVt3ydHG3NtFlT+Ji+eNYPsATUe/L+OOU6wOwJzm4Kzl19DGUdi29hCFw/qXkIw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDR9IXbI1J2+a9OezT+3YbsN/fjA3B2QD9xrYfbUfivBzKYN13
	zH8FoSWXWnIM5O0pNT7P7GPrQkhgD+d/aIGdTiR81WTec9Oi9GW7FKEL
X-Gm-Gg: AYBFou0SlLWbZrnozTCIJXjvB0rZcYBcSC7OxHWfZc8cFLWw4IndbBs/g03D0YwkYQW
	67/zUZzT76Oso4CSm/3QDC1BBOjsiwJPpdGvgB4WF8uwapk1+NBvNJzSw0GDs96vJrt0DcehUIX
	p3ObjXm/p72ibji5foSoiuaNS06OdHZ3Lndr+1jcQ7+FMiL3PWUFDZk1I/I5UgVyGtxmb3x54WL
	OYVMaWOuME9EnJRBnHl9mx7O/q8vk6IaeOO1lzCTrXtqDWGxNIS6AK+RcHSGCatacf2l+CsHlO7
	iyTyMig8XiZ1fnjB4GlL8+ZjITAibiEiTrxh2visntaC88bFKA2MjSRjhNebb+iSD6y//Dz4XSX
	tZQFjPnkSAWDVsywaCmIkmzzwFNS8L0JDW6NqSCKYaczAK2XZJ6avYaT24w24sBsVZGxIdMBISC
	p1ypVeayaMaD92C49hFnSsc5LfE+Zfqyelu8lhUSU6hmQYG3Irk4OZFcf+/1WqRkzEF7aq6K9Vs
	gbtsMvUfGwCoSCNkQMSKA38N3lUDoJHHEMa91vSLH+ofZqlYg7opxYzfXjjBW7IpVBNFc+Rj3iS
	ty77dDDdzp4dWZQ/8vXCs4oHTpShQfKlyr7/PqGn0qMLeWpbwuSpKBw=
X-Received: by 2002:a05:6000:40dc:b0:48e:1b11:7ee5 with SMTP id ffacd0b85a97d-48e3eb9a1d5mr11490868f8f.11.1793012326227;
        Mon, 26 Oct 2026 03:58:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm16432817f8f.27.2026.10.26.03.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:58:45 -0700 (PDT)
Message-ID: <235e7dcd-2d29-47e4-b68f-9b02f80085dd@gmail.com>
Date: Mon, 26 Oct 2026 10:58:44 +0000
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
Subject: Re: [PATCH] sequencer: refuse to revert shallow boundary commits by
 default
To: Junio C Hamano <gitster@pobox.com>
Cc: Nakul V S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Nakul V S <vsnakul@gmail.com>
References: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
 <7179f371-a709-476f-8e94-807d7b62ce6e@gmail.com> <xmqqqzhina26.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqqzhina26.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2026 20:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 21/10/2026 11:09, Nakul V S via GitGitGadget wrote:
>>
>> Thanks for working on this, it is a useful and timely improvement as
>> there was some discussion about improving the behavior of git with
>> regard to shallow boundaries at the recent git merge conference. I
>> wonder if it would be better to refuse to cherry-pick and rebase a
>> shallow boundary commit as well. Do you know of a sensible use for
>> reverting a shallow boundary or is the new option added out of caution
>> in case someone wants it?
> 
> Very good point.
> 
> The next natural question is where the modification should go if we
> want to make sure we protect these shallow boundaries not just from
> revert but also from "cherry-pick", "rebase", and possibly "commit
> --amend".  Is sequencer.c:do_pick_commit() the right place to cover
> all of them?  If not, would it make sense to have a helper function
> that different code paths to protect shallow boundaries from these
> operations can call, and add the first call to that helper funcion
> to the location this patch adds new code to?

 From the user's point of view, I think do_pick_commit() is a bit late 
to error out. It would be nicer to refuse to add a shallow commit to the 
todo list in the first place which means we'd need a helper function 
that's called from sequencer_make_script(), make_script_with_merges(), 
single_pick() and sequencer_pick_revisions(). That is a bit of a pain 
but would make for a better UI.

Thanks

Phillip

