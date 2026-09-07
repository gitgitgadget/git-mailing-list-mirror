Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715EE503BE1
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799219; cv=none; b=nWplE97vt1k87Lw7SXRGiDT9qfdx1L95n3QpLWxrAbqUPwXuIjQbk0RWYIO82+IbJYeJehzh43Vf7sDTg1ueHMSZHe22MZI+5KyrzDqjUteuZSkqHw9h9GyaklFZa85/+Ubfq2m+o8JtDhf9lhSbT+RDUjJUh/tXmfojpL4d+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799219; c=relaxed/simple;
	bh=5IEexpfBSjlvQg8i2nPprRqFGB3qfZmbxT9+4Et5JR0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hgXt6lrc9Pb8BoOx4MBxNahotwto/JveNg/wJ68o1JBfO+wqGMJ0S97uzfzO1DXu22zcKsMHPdzmFDLBx3QAMx8Hehgbz6YI/yhepumknan0FXwL9O4j26xffdGyIfL6FMr93PL01svuzH4wOi2dPWK19voW++PMkvBI28k47ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4Hi4MoW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4Hi4MoW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b965570d7so44153045e9.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799215; x=1789404015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CL9HAbVSTVW6uTMkcR68EUpz/Keymit6V8WOy6YLHOU=;
        b=M4Hi4MoWfUjNsHHMev0tkRkPkdgYvdhOuXPtC65UX0VJbaIpbkSi3ZJcjecEA2g4Um
         2mF6y46zktanjvj/o0tXDwzZMVLePKBCEuj04Wf4HI+QQZ3E0bsO6T4TnhAuT5gnZfWK
         BafU0vQL+mIREa/zduUPH5iz/5uqgYy2Y1Z0e1R6+8M0J4xVTZXsDO5J69XBtYpZUrhP
         VX5lRPlpvGnXOp9/im027IIXPIO1R8D13kVB4X/Wc3jiASdqE/WbuvQilRRL1pL+vAsf
         A22aYkCZ/9UtHgCR3dMt0WqWnZtjMUdXG2ahYui9TA2K/fwK3Dchz2O/4YcsN+EBAgsj
         at7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799215; x=1789404015;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CL9HAbVSTVW6uTMkcR68EUpz/Keymit6V8WOy6YLHOU=;
        b=KrYxm5OZxpZi8me0dS8bDltjhjfy+5g1S7CJ/or3GJimFKtDTq+/5s8cRZbah9U/y0
         owk68YPul4u5UOXTArLOmwY5Be51fe3/Ou5m83t5zrLwpwfU8nEXfuZ8TzXB5vWnaVsy
         zNguE+SzwOdzpGZcWShmtWnJATl0NRwtW6fIWIjfAt15E+jlsckOJkSDLwtcC/owJEyF
         +k91UtU6JyRCKWMIrYUnwjv3iAWm55qa88OPPM9aIEbole02lgUHfRtcu+FafAHy/d9G
         HC4SetLsqsYRpk3I4Zs+tnflbOGzHk273cblBTCBosXl7xOCq/Jmj38rXqlixoFAeoCG
         0fbg==
X-Gm-Message-State: AFuF++nQNfml4i5qtmFt02ssp3Qqtb2qq+y+BFRb+i8NH2ZI7zWQBArF
	vF7DCRXZIcc9I23sSPgzb+cxvLLaWdc6SOMUHowBEtFiZUhwWwTVeH6b
X-Gm-Gg: AYBFou1Rk+yj4DZKh8z51gRVlia1MkMNrCFW3wnh++zS80lSG/o4ffYAqt356j+WuT2
	YnuMGkYHuLqXYaUShxGWOOEcLn4eNey8HZOSq2w4y34HWqzzrvWkiX8ZzOXUEhK5XgvC5ZDR4lo
	uEF65fNzFRByIzNKTQJMxAtYm96hiK/N4qnhjQvYoGK35736r/xFu8D04hDnjoLZ+oMek6XG9LG
	BONHcZZBbVpV7uBEyR7dRz7yQfNKYJXR7qfRxIKO1sxy7GlifxvoilzaEQYqEuMiLZ7RCMfriLn
	I19quPqj8rmLqFEYW+eLhD2jp5zn0g2qDZK8fDRZh1QFSsUDo2Su77fbLleOyGP8zjWnDHOft3/
	cvIB7OYpgY6lCXlZ+TQXUlg9LDco6Gs4WciXiUlizIsh4bhGN29kz5CNzDh1kePTAc5QiwEJkD1
	kMoTrBKyNgIQUQLOFdzvBX8INJtMcmnkLVv/zGITpZhS+CNcPrvO/lYtyIWKRGAogCkToQLJhrC
	xhgIMaj0k8Ep6Dlj/j1B8hHjwLRbjLGFeusGUmNoZ8=
X-Received: by 2002:a05:600c:8b05:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49cf824e751mr255724845e9.9.1788799215330;
        Mon, 07 Sep 2026 09:40:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce554d52esm290949505e9.3.2026.09.07.09.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 09:40:14 -0700 (PDT)
Message-ID: <1e9f7b72-9f77-46e9-950e-df60b5a0539f@gmail.com>
Date: Mon, 7 Sep 2026 17:40:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence is
 done
To: Thomas Bachem <mail@thomasbachem.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com,
 johannes.schindelin@gmx.de
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
 <d09ef622-1398-4e38-8a04-8542e7347a98@gmail.com>
 <CAA0xjto++XQ6SZVfr5hWq2+CzeBsqSmTOLq_5UvL5s-0HDzaxw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAA0xjto++XQ6SZVfr5hWq2+CzeBsqSmTOLq_5UvL5s-0HDzaxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 07/09/2026 17:36, Thomas Bachem wrote:
> 
>> Anyway this change is at the end of pick_commits(), just before we
>> finish so looks like the right place to call run_auto_maintenance()
> 
> Patrick would rather have one exit shared by both rebase backends. In
> my reply to him I've proposed moving the call out of the sequencer
> into builtin/rebase.c and builtin/revert.c, the way am.c leaves it to
> rebase.c today. Say if you'd rather keep it here.

That works for we and means we don't have to sprinkle calls to 
run_auto_maintenance() around to accommodate the different code paths 
for single and multiple picks.
>> It is a shame the single pick variants of "git cherry-pick" and "git
>> revert" do not share the same code path as the multiple pick variants.
>> continue_single_pick() runs "git commit" without calling
>> run_git_commit() which is also unfortunate, but means that we could just
>> rely and "git commit" to call run_auto_maintenance() for us.
> 
> That works until the next patch, which turns auto maintenance off in
> every command the sequencer spawns, this "git commit" included. So
> somebody has to run it afterwards. With the call in builtin/revert.c,
> cherry-pick does that itself once the continue returns.

Sounds good

Thanks

Phillip

> 
>> Do we want to assert that we don't run auto maintenance up to this point?
> 
> Yes, I'll add that, and the next patch will extend this test instead
> of adding its own.
> 
>> Using test_grep here would mean we get some useful test output if there
>> are not matches in the file. Without that test_line_count just says the
>> line count didn't match and prints an empty file.
> 
> Will do.
> 
> Thanks,
> Thomas

