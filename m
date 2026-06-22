Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BE45039
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120352; cv=none; b=IFZrr6HJU5yp9x4XqbMiwediCLnjuIbV8UpLVU17LKBYJocS3fZrf1QxnDk5t+vInTwgLwgXkfbbXdJrPxNmSlOD5iNPlWuoYUcpHi+TL3n8akL2W575pTQVgwmfEtj5sojRi5xIYkTJyAGejLTHkj52Hwp74p0VaMmCbcSDNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120352; c=relaxed/simple;
	bh=ssiEeHmERLgxy5Fmf8QrEE4Nwmv4dISdgK0p055uG70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMcAJ9DhfbmUwiKhsnCVzk0S5H3OlPXRWNq9jWKb3accwRwMSIq5ehji8oOPqTPJ1NilweLkYfnA6zeRKpCBwj0mZEmmDCdbdGWkmF6Ph7duKUiF0U2eTeE/Us70QhmgOrIs2dKHjUTPwchD6eUODUA1bnPEwritUDIkbBZ9QHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxF6FfRD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxF6FfRD"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697cd68d7adso133838a12.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782120350; x=1782725150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xKr4UnT2ytOOG9iv5DW//S4zFZznxF+DZPvc8Pbqkg=;
        b=PxF6FfRDb00t2PJztaz4YgFGL1CCNsgbx3IhjRW2XZ1HM6JkzcD/mTNc8HifKF2iil
         qvCgKHxARieMwcV3PUWiLajmrbjpeAfLaOw9BKslie0o7Id7u1kbC7sot3wwyzZGOn49
         wYwkC0cw20SPr1We7phZPlmLbSOMKYnApJLKgGRwTwpRGg366SvB1EU3DDJJyy05TKpM
         thZUfqkSiBjDxAnoFVWbCyK6JWOUgMj0NHPdEbjLXZD5s1bNl8k4+mJO8G11nDYqXTO0
         mc3L04kP6dF7dJfS/BNo/yvbB6JoE7T7kJ0EVE9pe+0BzkVa5OHyuNHFrhT4G19QvCnT
         1Rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782120350; x=1782725150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xKr4UnT2ytOOG9iv5DW//S4zFZznxF+DZPvc8Pbqkg=;
        b=Z1Jszw1moICXroX3lTUk5uKkj2pfSCjrXVdIXImXGDGdMmUyCwgcU02uXmoWqtUuM7
         ujL82h3pLyeo3qr7O6U2qDOE1HwJjqDlTsZV9Gzc/Dcpd8SJF45WYy80aZ2qVaU1LqPE
         hAQRl2O+JMtJwenXuWHufSZfOWMfJTUlbkzLnIlN6HomSW8ukEAWNVHt7woomF/HzmmH
         Rh61pqMnbFhsB3AH1j+wu9/TNtEG3fuW0wce7+FgugOxi8plqZzZuQ0GsXv4NGu7eDAK
         4d3R88smiRW+F2DDvqOTpibwEFFJsC/2gVMCDN+v/gDSHMfrFfUhZ+7QFS9EtS54mpWv
         NODA==
X-Forwarded-Encrypted: i=1; AFNElJ80F5VWgA51SjenbEfHxu+b0JoV8p79kmAxiCgzzhhkWQUCtdL0DYD//3OE1quTj4QS5f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7rRSeOckM9j0ChP83ifoVuj6VkgkawC5cZLWjwmrsveAI/7i
	j8b4B4x4c3FxZ9kJS+9yZ7G5lrhUtz3Uf5FASDZDBV0bffBeIOPhXFBk
X-Gm-Gg: AfdE7ckckiy1QX+jJw9sX1cn1hivrmDKgBwZsKK368Azj6/LfZr/y3JcDeXvNHf3igl
	iERLKyXgu+6D0oRUfTH7/le+dcaKar3OHRBMMtSPzgngWC+YKHyxC9kvLTnFbc5rqMOCaDJpV+0
	brEkLCQMmWDxI611oxWDKg7GbVmgCqS84E6puq2Oi2fCE5ena5QZzUAsH0W+vrMIz8XN09edvQx
	DGXZ/6F/Tav4BXG7rR7d0sjiq0FAU4e/0P4Kz+aXQHi61cpd5oWhMvxQ46gAvZMN+GMCjr1ehDQ
	G6IgTxnbvhCBPRz/nsByAuzMlsmerfF7Vwkw5gD7O1Ag8OHjbLyNAOKRGBfGnjZm1c4RjSxqk8T
	YnWmhSehuFP1GjxHEpcHnXQUDZTB4te6+LUv3XPP2nDcYuzmiZKoc9bkPDGeG4xKQcXKpEPqw4e
	CKJSWHZJSbetlZvDroho7876+DOb2YojjmIem2zxwMNatpFRLKMzFh0Ip64cYemUm7Y5EylhXbp
	prP8Spl
X-Received: by 2002:a05:6402:158f:b0:691:b5aa:5a66 with SMTP id 4fb4d7f45d1cf-69756879ab0mr4916094a12.16.1782120349751;
        Mon, 22 Jun 2026 02:25:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b82ee0bsm2952265a12.6.2026.06.22.02.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 02:25:49 -0700 (PDT)
Message-ID: <64ea35df-bdc9-42bd-ac16-5719c5bc6953@gmail.com>
Date: Mon, 22 Jun 2026 10:25:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
 <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g>
 <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 20/06/2026 10:04, Harald Nordgren wrote:
>>   - Move the @{upstream} of feature2 to the branch that "merged"
>>     feature1 and caused its removal.  Asking feature2@{upstream}
>>     would answer origin/master, which feature1 was removed after
>>     getting merged.
> 
> I think this is a strong option.
> 
> As a side note: I was annoyed before when GitHub didn't re-assign base
> automatically when doing stacked PR's, so merging in the first branch
> caused developers to  merge in the second PR into essentially a dead
> feature branch instead of master, if they forgot to manually change
> it. But I think GitHub has fixed this now so the second PR gets its
> base changed to default branch.
> 
> Two caveats:
> 
> - How to handle recursion: b1 has b2 as upstream and b2 has b3 as
> upstream, and both b2 and b3 have been merged? Not good if it's just
> luck which order the branches get walked, but also we don't want to
> have to do many passes, two passes is not even guaranteed to be
> enough.

I think you only need one pass. For each branch we look at it's upstream 
and if it is in the set of branches we want to delete we

  1 remove it from the set of branches to be deleted
  2 if the upstream of the upstream is in the set of branches to be
    deleted goto 1.

Note that we don't need to create a list of all upstream branches, we 
can handle it within the refs_for_each_branch_ref() callback.

> - What about when b3 has itself as upstream? I guess then we can just
> remove the upstream of b2. Overall, I don't think it's a huge problem
> when a branch gets no upstream, so maybe just warn about it.

Removing the upstream config of branches that are merged shouldn't cause 
too many problems - the user is unlikely to want to rebase a merged 
branch and they're unlikely to have it checked out so "git rebase" and 
"git log @{u}.." probably does not matter.

So maybe we should change the loop above to only keep the upstream 
branch of branches that have not been merged and instead clear the 
upstream config of any merged branches we keep because they are an 
upstream of another branch.

Thanks

Phillip

