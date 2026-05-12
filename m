Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FF3E173D
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598658; cv=none; b=LDwcB3TYKBpeUH6juA0BILdtcT+UD4OfHuPtCYtMM8jS+nCuYt0xLR3stsyDcgNcO0a/i4GMgYoo6beynEMP+2gv9TuXgNXi4bjgrpmcbJaVAqaSJIxD58Jt/lXUmMKc2wJ5FdFHr3mKJOyQQdX2P8Yddfb6g4ZU/QJ3THrLwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598658; c=relaxed/simple;
	bh=x1KgaOTsBelrRBTbJaQ+ZVcAHQqWAieppuLDrG8Gjmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9iDtMyVyQFlFvU416SO39RxJoIDGMdOelACzuqThOCHnQ0iBEkOMUUvH8AC30ZS01/oW/mDIZ2IzMPOktUnzdYxZCLuhEjVLATlvh6UY93se+Hso6xLruta+h9pF3xqokKBIPdticLb4IwhQQxEdvfeG2MafrKI4WWcgqWGyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqstUz+t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqstUz+t"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso48695115e9.2
        for <git@vger.kernel.org>; Tue, 12 May 2026 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778598655; x=1779203455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=exKtaCFuep0PJYqPWe5lPJvaDRoQNBhTba6VhHOOkgc=;
        b=dqstUz+tYL2GUfVPudEAbav/3LYJxi6eoZzqtUl3D2oh+2M0gNXo1vSEGyffuPibaW
         JHwxa25ECcY7iG2u8vPHSHLK6xGlgWmQcqMACJCfJJWobaX9FhQDguVL4YDMOVyVKB/w
         ccBDn+PYuuGUBKwMhJb2ywvhTNIjAwmCDQ8PBaqmKgIu0SIrgJ0PuylT8RxERv2DvwWm
         kS6Fo2IeqG/AhHTwOpWa3W4v1fmdHdzyPW3GRnvJS0Vo19OQLf010wSaRkQC3AUM1VAZ
         QR5EiPsPInOOH3GluYq5JOwXAIDN76OPVuXA0WNksmKckrhlmtQxF9LHYA/e01BVlG3V
         y6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598655; x=1779203455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exKtaCFuep0PJYqPWe5lPJvaDRoQNBhTba6VhHOOkgc=;
        b=g9wrWXCndHTfZnTv7eZGMOKMu05LbtmWRRFM9OdBfaenPirw4nbtt8HAs49T3qunD3
         KjiXhjSffwJi89wcNqWSSMkm5oKf9yizTNTfeWiESodWqxPX+N5lMnaBTQj6V5ghhIP9
         c396Hw5coyo+5exEpgXlr0laHr42+lXvpM/Il37yirlTtX/21m1AwCzqc6td8JhwaQ4f
         YeUd2tno8MoGxop/KCkYgaxU5oIG76+W0eKlsFGkUfPK5sisHY5JOb0QIsDlsfBDktAv
         /hMiKMLi4L5jsIAS/t3CjRZ/FLnKNpCBNr1JNuNHcmpXewfvz39qZbj45mZrKLfrexFo
         vCug==
X-Gm-Message-State: AOJu0YzxxKWGevHyeW0MxI33kJtcRN1/BFMmPHppVq5FBy2f3sqd6ITU
	vFR/flL/d9CB7rjGYQduEwDw+Xv9IezkwjFYBMHNlVSyqPQGefyTpkbR
X-Gm-Gg: Acq92OEjgoviWYVRlkzHQDrSuZHyicMzzOStJq0+cm32ArxDcCHp01Y/4yewmEiH/FM
	XhwNcXtKmvNHrzpdQmVXnh9hnn/1ok40JKUXTEPRUt9DFcNHrpRuz4cZANw9ODbfYZSKnvEECj0
	eUq3Q16ryQEkKC9A7akG9sT8k9l6JkvOT6xZ+GjVW/4FO4YHU3Kn4gq8ojdcvjFom8OfGf/Hooz
	8t2FGMbygNHAGiCNG3hhsdZTfitqNUDsLyo+Ij+JevHcbMko4AaJfdMAE2leHcGJ/Si7DLtmQE/
	9BhxWtwVLeonbYkGAl6pRWnRnFSQbMqOalLVCgda9KLjZP2y2ckEQvzvaAeUXUEzPjmJEje6hj6
	sXLAqNQMMz3hhhX5DzWAM+9mwZnix0ar8tHr+QLuseTYVSxoSHpuc+oazNJUgf608S7aDHtzMtu
	iGEJyvSa3E/pISPorWEeBiKuRIZRJ1ylcgOAmhsX6rvwoZc1tEHgH44W6vk7i/g3yFb9tMgTGeN
	YAUsQ==
X-Received: by 2002:a05:600c:3510:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48e8fe50a02mr45711765e9.8.1778598654812;
        Tue, 12 May 2026 08:10:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7? ([2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f410558sm39778125e9.5.2026.05.12.08.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:10:54 -0700 (PDT)
Message-ID: <5331661b-f0a3-4e70-bd2e-c642337deb8f@gmail.com>
Date: Tue, 12 May 2026 16:10:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
To: Abhinav Gupta <mail@abhinavg.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <20260506023944.90691-1-mail@abhinavg.net>
 <xmqqqznk9ih8.fsf@gitster.g> <0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
 <xmqqv7cu96q4.fsf@gitster.g>
 <63e04828-5895-4deb-a698-5d6f494d23f3@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <63e04828-5895-4deb-a698-5d6f494d23f3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/05/2026 01:15, Abhinav Gupta wrote:
> 
> On Sun, May 10, 2026, at 16:37, Junio C Hamano wrote:
>> it would have failed to work due to the "HEAD" thing, so even though
>> existing versions of Git may have added such local tags to the insn
>> sequence, it would not have been a workable configuration anyway.
> 
> Yeah. One additional data point:
> non-interactive rebase is also broken under this configuration.

I assume you mean that rebase.instructionFormat includes "%d" and 
rebase.updateRefs is true below.

> Given a branch off main~1, it runs into the same issue:
> 
>      $ git checkout -b foo main~1
>      $ git commit --allow-empty -m 'do things'
>      $ git rebase main
>        # ...
>      error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
>      error: invalid line 2: update-ref HEAD
>      You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
>      Or you can abort the rebase with 'git rebase --abort'.
> 
> I'm guessing non-interactive rebase works off the same todo list so that makes sense.

Yes, barring some special cases where we don't support updating refs
	"git rebase <options>"
is essentially
	GIT_SEQUENCE_EDITOR=: git rebase -i <options>

Thanks

Phillip

