Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE373189
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189706; cv=none; b=Kehr2LOXpSnMOodek9I4kuaALaEQ2FSh3X1nUCFBCKX3oCoUwiNY2d2tlnMigWteL4+H6AWLD6Tw2ASJynpmluJk+TsXmLDI9Xe0uLntnZwx/GdqpH7MbWU8xoJWUPeLQ/uWs+3vKnGzn5pWF+OfQ1c2wQMJ+0vdPME6ltVEap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189706; c=relaxed/simple;
	bh=9Cb094JIIMa+IFRWkvX+kUSbo4cMvw81Q6HeqFG7vE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gPe3r531A9uwhXpJNTbWPVuS5PzLUU4165gJMaRAHQlhBbgKd4N1cG+OguX/MvZyl/aQx0qQ3cqEi4S/RFHDOIvAAhY7nMsPWtxD3LBBgU/o6XUUNsjchZFHSXiFXF95706U1n+lje0Ehn74GdnrMYAMCX9QagYvtlzKRc8ABU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGBox8eX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGBox8eX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41864cf2f5aso3603585e9.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189703; x=1713794503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aviWnPyZeyunlfAJDdt3aTgdslEcnIj/Ib4UaqdxQbs=;
        b=JGBox8eXCr7jXLfW+dt89ef6KO65E7rX9hpupuMBZ6phj50ha9CD+Vp4NskGg+3Oj8
         Intkl3MZusXs6BrGm9dFetl4EY9X8Ad3bOMQeK3yiotpsNgxqIS/44RRoNAes2/nwb7p
         ray4xBcCBc/5fxTGk2pP5RUah3IS1UdTMLaUmrkT1y/4CoGVnTgJ3fkS+qdSupNyLU2g
         Glae5AfU2Zc+oQWgJQpAgQhS6X5rIgzyYbXQbxasfxNaRYMOq1jR4S8j6mEyJrAYvtF9
         fiZ2JdNTy2SU4lFicubEhQjGNsdeqiFrkuQ7KE6TMYpgPbEYWFeNCNkjH97cuZ4u8MUf
         /07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189703; x=1713794503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aviWnPyZeyunlfAJDdt3aTgdslEcnIj/Ib4UaqdxQbs=;
        b=ksBxA95GCHwOB3HeovQOqKwHQKpzltO1bk6GBKoBPXHT0zR1CJooypiy7o2B3WlVIT
         poCc+5c5aJqMwle4c/zXryd9ZsEH9dU7y2sZS4hGPDiXOI+aIdxRf/cZtF3QFKXPDxv4
         IjGn+zeCweWB+tmIS6F6lApKquf19xAqG6lUwEaftFrkCVo126AVjS/HziNtpfibkKST
         k4AEJrYVkRKb0dgaFhuZEAG+UpxQLs0GtuMJBePYOLROBTAbd+FfoSGUkLcXC5DN1wTW
         X5XEc3LbvDBxpM/1VJij+MfU1EsPvs2Bbhmg4WAo/IWpx63ps8+NYp/g+5jbFJ7317RM
         26vQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+KjKO7haaoGk1zYr4meororjg9XYjU8iHWsNoIf3O1OidX0UVHUi/YDuythz/PIXlvn/SwpBpH9ANQ8PwHXb6ow4
X-Gm-Message-State: AOJu0YzlHLKX3+5ay6eAeucazue/uFr6FD26qupASJbG8E3tHAOgymsB
	7D8WY76zfGAHIbfDBHS+CdjOm7LmVZbYMDmGm41vnhmT5zgwz8iNkHBpDQ==
X-Google-Smtp-Source: AGHT+IETyTv/FueLHFr83l3aQyQ8KdPxc3m+lWsReqUbSzMbNoQymL6hpoH5M6YqCsXIEiT0jeCASA==
X-Received: by 2002:a05:600c:c2:b0:416:c63c:5f74 with SMTP id u2-20020a05600c00c200b00416c63c5f74mr7461348wmm.18.1713189703083;
        Mon, 15 Apr 2024 07:01:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b00417e4add806sm15108280wmo.7.2024.04.15.07.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:01:42 -0700 (PDT)
Message-ID: <bf27ed3a-dc6c-4716-95c6-9e6c60604bd3@gmail.com>
Date: Mon, 15 Apr 2024 15:01:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: prepare-commit-msg hook during rebase
To: Michael J Gruber <git@grubix.eu>, Git List <git@vger.kernel.org>
References: <CAA19uiQip=EsbT8uQCs+98brYSTbOqyHX1ZBhssi4df3dZmZ6Q@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAA19uiQip=EsbT8uQCs+98brYSTbOqyHX1ZBhssi4df3dZmZ6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael

On 15/04/2024 11:36, Michael J Gruber wrote:
> Hi there
> 
> For a while now, I thought I was using prepare-commit-msg hook wrong
> but finally took the time to analyse this further. Per the doc, the
> hook receives the source of the commit message as $2
> (message/template/merge/squash/commit or empty).
> 
> I notice the following with `rebase -i`:
> - When rb applies a patch to be edited/reworded, the hook is called
> with `commit` as the message source.
> - When rb applies a patch merely to be picked, the hook is called with
> `message` as the message source.
> 
> The latter also happens when non-interactive rebase applies commits.
> 
> I find this confusing for two reasons:
> - Whether edit/reword or pick, there is always a commit being applied,
> and it's the source of the message. So why not `commit` in both cases?
> - The doc says that `message` is for inputs from `-m` or `-F`. So,
> certainly this should not apply when the message comes from a picked
> commit.
> 
> Also, I'm not sure whether the claim about `-m` is true, but that's
> another issue; we even might want to distinguish between `-m` and `-F`
> here.
> 
> Does the source `message` during rb pick occur due to an
> implementation detail, maybe since the rewrite to sequencer?

All of the hook behavior in rebase is an accident of the implementation 
and stems from the scripted implementation. I'm not sure if the source 
passed to the hook has changed over time but it is quite possible that 
it has. I agree "commit" would be a more logical source. Personally I'm 
not sure it makes sense to run this hook for ordinary picks, though 
perhaps it makes sense to run it when the message is to be edited. Do 
you have a use for this hook while rebasing or are you just confused by 
the source argument?

Best Wishes

Phillip

> Cheers
> Michael
> 
