Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19F76047
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495854; cv=none; b=MTKQWA5lAWDt/vQejtY36gVMjhZS5pE0F7tPtVTqlLzVbeAEUiXQpYtoXpM9H8sP/VlRlmvTfoz6jH7YbF0+EwAhuQyNXyh63vrKbeLUDkxwlYKcp8RpFZSa5Hd2cmkxqPKbs1oroumjwYEZMa66SRvZ4C8WmFvoUZnIZ6jzf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495854; c=relaxed/simple;
	bh=+dmyjXVwB2WWPn5NOYBtUS9LHDAEYm/wpfrqXzh6kSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vb4dJaIEkPTl/X6KSs27S7k3BGLNS1dgLyRIcmYuCgZFSM//4jetYuT587ayAFESS5TouAnunHorvbgpT/Rqb9srwcSfC/mGsVhcWSO474rgj599prbzhEDbQrBqLrhMQ+SFj3Ky71X/SD0M7g68Aop2vIrIC9kstyU3QtovIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWjynHue; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWjynHue"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b65a77301so391673f8f.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707495851; x=1708100651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PPgKCpeCXWu24tq71oq7DpzsDP07BAfZNcm3xeaSPkU=;
        b=AWjynHueh8EQSSjKaEgtRqnYFxaYpAY99TZWERW1XvAI25L8JMuqT34MwQ4Hzsncda
         ffoEsRBBMvuQJCf+YuqeozSirYGxDOQ3PczZWWszxBjtPTYT9MZiFTa9EzGWDsadBkrf
         7rCjieEMlCjD2SKFyw6/04h7GO+HHeISEP/BWePnoCJa95T5pY8l1gv/BsfV86aN6e6A
         H4eYzr2TXjqR259BVohL0DxRUOVIabnydv65qRxUviYXio/Gf9SrN5psS8Kse7ygl7tG
         Id2EDMI1fuMkxylLypnLUaOFLWrbicU0ES36RDpBHBzhrKMYoN3b1AQPNUXrOPkau3o2
         QkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495851; x=1708100651;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPgKCpeCXWu24tq71oq7DpzsDP07BAfZNcm3xeaSPkU=;
        b=GEHvta4XhMscb1Fw8oyDAcdwWOWTSxwX6mPtOSea0LWhUSYR3QhGy5JwNa2xr2OLwC
         Xn78wjjiHzBshedepx4eOv7ph6WffMkhF7YP90huojalbMRjbyvhF8jhuzhZsYy1Gynv
         aXHrcILTwC35WmajEacISFrP8w4sK+dI5zDg2qkigkACnVHMwr7k4bQSG1HtUGhFiQKS
         /UCKwo3nG3YJClmL/M3M762z62pe7lDP3JXmMgndOAqrvE/GPEpRf7FnPBm+K56CJ82m
         Hw0l4obrWYBR+nEfyL/ZpoTa8s7QXezB4T/41iTJOqQOHKIPeVmaXZWLgN2N9BTZF7wV
         gPqw==
X-Forwarded-Encrypted: i=1; AJvYcCUE6vv8N5PubATeOCGv9SBMKkeQ4SMrJV+yES96ZP+V/NuLnODO3wyzVj0P8KBfPI6qnystTli9N7cPSo1jrg5IXJ0+
X-Gm-Message-State: AOJu0YyTf2EA+y27XskP7z92nkwF/FJ8dJKJqJC2w0o8V8cYDh2B4P41
	phHM4v1+Fp1GA4fRnoQBYez/FuEwRkVL/87qzv7V3cwtLzuAGi75
X-Google-Smtp-Source: AGHT+IHbbkmPkfEMJ4hjb931nfrwCCv+k8Uj3Fv036+kfelV2PZQeSOOouf/W+LlQPlbY/5FvPxRTg==
X-Received: by 2002:adf:e702:0:b0:33b:4ec0:8159 with SMTP id c2-20020adfe702000000b0033b4ec08159mr1680946wrm.33.1707495850738;
        Fri, 09 Feb 2024 08:24:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYzAmtnEo5FWB5v28fMcD6enI3qU9X6v6Ds9dOq6kIctFgxhZOABeCCEy7G1xR/DjFfRV0HyMb5Wygjrhlrz2LHY91
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id bq29-20020a5d5a1d000000b0033b65818667sm1717435wrb.76.2024.02.09.08.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:24:10 -0800 (PST)
Message-ID: <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
Date: Fri, 9 Feb 2024 16:24:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Interactive rebase: using "pick" for merge commits
Content-Language: en-US
To: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stefan

On 09/02/2024 15:52, Stefan Haller wrote:
> When I do an interactive rebase, and manually enter a "pick" with the
> commit hash of a merge commit, I get the following confusing error message:
> 
> error: commit fa1afe1 is a merge but no -m option was given.
> hint: Could not execute the todo command
> hint:
> hint:     pick fa1afe1 some subject
> hint:
> hint: It has been rescheduled; [rest of message snipped]
> 
> This error message makes it sound like I could somehow add "-m1" after
> the "pick" to make it work (which is actually what I would like to be
> able to do). I had to go read the source code to find out that that's
> not the case, and the error message only comes from the fact that the
> code is shared with the cherry-pick and revert commands, which do have
> the -m option.

Oh, that's unfortunate - we should really reject the todo list when we 
parse it at the start of the rebase if it is going to try and "pick" a 
merge.

> Is it crazy to want pick to work like this? Should it be supported?

It causes problems trying to maintain the topology. In the past there 
was a "--preserve-merges" option that allowed one to "pick" merges but 
it broke if the user edited the todo list. The "--rebase-merges" option 
was introduced with the "label", "reset" and "merge" todo list 
instructions to allow the user to control the topology.

Best Wishes

Phillip
