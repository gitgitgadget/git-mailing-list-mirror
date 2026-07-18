Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658237A85A
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366763; cv=none; b=e6qwd/P7TahfcuwBKfXQuSK75TPW8XSNsX8MWA8RtsxyfBdT4qxA9QLMgym5qucRmvsWfcrq8cFeqOI9KUWbsVMKWoc02EWasr/Pk4XcxxhoWUUQOwUqqIJO1Mzi7rqMba5S+BbdAlrdSTjipDnOo0kOqYXyInk7+WrrCM+3B+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366763; c=relaxed/simple;
	bh=4Ozswiu15eTgMSvNxCXNR4hUQ3zkNcjlboYVX6KMcOY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GZ74QTFG3eOQWfF5v0qtUSdWp3geqHLQtNESTIybIwJGLILz6wif4fKTHFt010MFfZWt7yfUNDD9179+46SI0dz8vkJ3/UXAJCdXQkZwdpr8naPSFI29eGp5gCBen+xILwv/VjW9HD7TGgm/JHALJPUnPeW5au0Oyn7ZhwAk/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK7IYFJr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK7IYFJr"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-475881b9a4bso5408083f8f.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366760; x=1784971560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFyRQwjth9S6WtqzMDjXh9ycpBvwYUN39TvkVE544NY=;
        b=IK7IYFJrVoHzGfmBrvO1es1yj3Y8De2PUMS4uausTxMJBxYj/GRUDMyVoErGP0Doqo
         fVV0BlY1OsTjfXE+ytXu/F99k4/tgnhGsbLuSCQizT9mH4Ot8DKKB5X9/Cn2AMPzurwZ
         1H93KkpJR/5Ll11pSaCsP38uwKWHUqA6MexdIx72iRSLA/8w8+y+FGY3JrAPlOzcg1Uf
         ceaeYFiwaE1ulEOwYyNpw5wrV2OXwk3FtouS0SCXqLMAmT8xF44F4YZvHImQ67Yuu18j
         elq8feFCOuyPLbxpHREMZNygXB7S6VDTqEV/m6gP8vvsVPOCwUw117akwscKVUmDi3YW
         P9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366760; x=1784971560;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFyRQwjth9S6WtqzMDjXh9ycpBvwYUN39TvkVE544NY=;
        b=KhvD4tCiagQ4lk4tUpBMFakJkTXmj0GqD/nIVpwk0GJwKyO/MFOg3Ep7YlS7fFLNIm
         20FE+OAX3SRxO3Ess2COOnH+KY00veVOKpYoyLnTKX1rbDCaEI2IAeXUurQiUhwkKBmw
         dJpyFD4aH1W4UrYjj6VgKP5ivO16FOVEF0V5pm/iATx1DI0X2Qwpzc37rfJIyd4v1wfv
         P/10YDCPUftr19YaTC2Lgi0gMKeSNxBlSVtBfRNbf6QABMZJ2ZFZoRSr9PeI5Ht7M51L
         YMjnSKNlW3KSCEgsUvJTGEM3HE1J03O5qlopddEQwcQG1g6opXIyFeaUOHs/i9f8Znwv
         34Bg==
X-Forwarded-Encrypted: i=1; AHgh+RrS8SIH3/R6N+PIbaC1YJ3r5/cgazKs3S6UuNuG3oKrHXlUYq45CI2btA6fS4prUxeeHtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xb2FXc5EThRiOZWoHhQfIy0JInglTzHZpz8jOXFVdoti4Wey
	uL45Oe5PZyIx8wBYpVDC90gZbEEjeflUdIMGyam+Kc2U15EiAxxpwN+x
X-Gm-Gg: AfdE7cluAjyiCNiIm2wFus6voSP6FzkDHuc9+It/gvpM7wC8YqqyvFlr33k5lSTsrNR
	HbQgLyKSxd+4mu3vaaHgYHoHEVfOE4GOIjyEwhPpHA74cZNokjmTZF9QvQiWn/xbeyIpHqs4HeG
	p5HwRJ5hwn5jtFHEsIaJqyfg4JWwfchZv/2WZURNa7mV1dcdyAXRWvEIL2v07j9sTZljg6ZCC1M
	K7if7FJy4FzOyoWWHWzIODUzO1U4n1Fvj0wE+wQw4DGCKaJHdn8gyOREyr46gTHuxhR/2TVTf53
	9lCksE13iJsr+0/z73L/3+dz7IRV7uh/GeKnONkdqwINwo0TcZz3fYXxsKmrMg4vClq01dgaok9
	PCUsEI6Jo0AGuYRdowYga8vEHntjcU262rtbb5Kxvvs3DLCCXucomkEjH7/lGQTjtGMakwmUAvm
	C6kSu4Tfb6tqRx4hkUNL+UiotSmfSWqO2wST8Rqos2jtLCmfKSZ+fB54FZSFvyO2nZUfk=
X-Received: by 2002:a05:600c:a0a:b0:493:ee2b:c876 with SMTP id 5b1f17b1804b1-4954a41302fmr68193995e9.35.1784366760388;
        Sat, 18 Jul 2026 02:26:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a47de7sm111860675e9.7.2026.07.18.02.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 02:25:59 -0700 (PDT)
Message-ID: <9a0b542c-8984-4d73-8e24-00adf6dcd427@gmail.com>
Date: Sat, 18 Jul 2026 10:25:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
 <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> <xmqqpl1q2xw5.fsf@gitster.g>
 <bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com> <xmqqo6h9z7e6.fsf@gitster.g>
 <CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
 <xmqqa4srnwfa.fsf@gitster.g>
 <CAHwyqnVy=4oHBTmtDJ6jX38Kh1aLYYXHR-_12DdiiUxpXZ5kNg@mail.gmail.com>
 <4d150f21-46ea-4bf7-b516-c1763c152b34@gmail.com> <xmqqmrvqhmpp.fsf@gitster.g>
 <CAHwyqnVwDsdvvg6a2BtAYw+hYRdgKvRXwHE+uzAZjherfu5B=Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnVwDsdvvg6a2BtAYw+hYRdgKvRXwHE+uzAZjherfu5B=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2026 09:05, Harald Nordgren wrote:
>> I wonder if the workflow that benefits from this "if exec fails,
>> give up and forget the whole thing" behavior is actually quite
>> different from what we consider the "normal" use of the command?
>> Perhaps the user is not interested in "rebasing" the history at
>> all, but is instead running a check on each and every commit.
>> That is, a more expensive version of:
>>
>>          for commit in $(git rev-list bottom..top)
>>          do
>>                  git reset --hard "$commit" &&
>>                  do the exec command || break
>>          done
>>
>> that just happens to be shorter to type?
>> Sure, that's exactly right.
I think I must be missing something; I had assumed that someone running 
a check on each commit wanted to ensure it passed, and, if not, they 
would want to fix the problem that caused the check to fail. In that 
case I would expect that they would want to amend the failing commit, 
rather than abort the rebase. What's the scenario where one wants to 
check a bunch of commits but not fix the ones that fail?

Thanks

Phillip

