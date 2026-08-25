Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F53DAAA8
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669044; cv=none; b=h0UbdEulCEAPzHMUIi8ymJLWNr4OYCZLa5W8ipnimQBn3c16tfRa8y/+q4LEEY/v+h8bWcrVM2esjC9FIyFU0Q+Ixwg5Xz0EWcj+N1AAbnqHZk3wRyusCbnTtpzXr4C5B2omYjiUAzTokNM/Zxh23BUSeBoWKLZRE8wCRikqp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669044; c=relaxed/simple;
	bh=CDhBQ26GHLxkQvO9+dbnvm+kyvElDtHINeBQ8QCvgkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EylQoQfnEz3BmvTz68IZTcR+qoomGKbsaqPiQ/T6gznaIIWLUSLgDonaJ7yQaDTM5ToFZEVV8p6iCnv8gYV7GSa2cpt0DtWsDc5FSgBmbt+oE6ci4+F3htY9Sria4xMVx2qd3CBDnCJhFm22vHYf4YwLkW+4nwJ7OoxMc0Zttjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF4aLelk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF4aLelk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998e0916faso28654725e9.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787669041; x=1788273841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=59+UfXjyZLXcTqrgvNT0m/H/2lcPGvb6CNKnj+oSNlQ=;
        b=XF4aLelkaYHVGFyF26bmiS/g4mefLzUliNI3IN/uuCbZwkEr14OOS9CduwwbTpakBD
         3GUdkIwUJsYHrOy0jCw+uC0EjCGy5UkbX2zCCydJIfknpnQ9XVAZnfuEvDjXBMyz6+qn
         zp0CVMTgatoDIOWBC90CqdhzABrcrPVFU5VmLJZR3bntpQXbHhTO+k3PcDvoT4glhJ9i
         NtuQ9BX0is9Dlx/+xMDwRZuOASEdcVstwcVasOEycPyDgn/Zjo+QwAbDier27G+UheGr
         RriLqcMDO9v2yUEoLuox2tRFDzhwjQe78msjgCMgsvhFn2gnQTO05uFPvB4fhEG2duDS
         XGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787669041; x=1788273841;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59+UfXjyZLXcTqrgvNT0m/H/2lcPGvb6CNKnj+oSNlQ=;
        b=aeY2hXwpWmZkjUcT+eFf+/Hm64+4pWEaNhdYosxKqVqIsN6u69viGI7nwpoHoIJOCb
         N53ohP0kfXYG95IWx/YiLproHQWF/AX+z3AY3oYqLo9hyo1wustYGxKCPKsKsF2Us/hY
         gFpPyyW3o8619g4jhOBVy2/b3NFOkrZ/kQzFmKcwZfjLb1muw49Rk4HagbKyrf8/RTKH
         wgQMPkMhLmtf12OVhp9uq7DcFd22zuGqVtMIbeAwaQ0kobPkoKmcP+Nz0JFIyZKXE4GB
         JsGBzEf3MbTWI5DbJHKE9Qv6uwt2Yw4qk1JRjzEj4iC2h7Hzy3J9f5K1dsBXSFlpZJrs
         vpWg==
X-Forwarded-Encrypted: i=1; AHgh+RpCQ2mLNTItEck2ydbJACsRJDc4RHWKcq/hPC8o1vrF5nS4oaerK0I1gzdxGN3Nvs+Iprk=@vger.kernel.org
X-Gm-Message-State: AFuF++lgcfd6p0PYAII2QwPF0hGehpRKKvzgNBCN4uOzbFD52vMbL/BX
	dHRtre7mZW08Zsmx4pgGsCSUVxXcYNpcmiVJpO8YSkMSiM6/vW3997Ef
X-Gm-Gg: AR+sD12McS88XcAhki9CUbMtQfHcdFgw2YAW9NqpyGTyod9nnjsuUnlPipznR4dt/7j
	1T0zKXsqmYaqd8MHyBzdVvuqahyuKdoV2L2Idso3vWJk97WI4srwNSSyOVmxYUY/FfwMaB7tA2X
	h0q74WEhqqZSkUlBmaqb1G4LXoOhitmR/oo0t+QHnPH2t4GQ6oSNyEWesFwj7d1qTHje/YtjRAe
	VeT7X1nMCFUS0+QYMU0ySqTVnQh1ak8KIrAImA1YyAbqtQJ5Ba06dL92ylXgA/eJoxy4bGCtSnY
	XYei1YXpVsEC5ApVyoYAH83jMhz/mw1WBS9ZkJbIqFbGfgFPcRE2tbQRZg7K/6z4xDOu0tAunSr
	H4V+tMeUUSonOMIdi7r6X7+++QovJOADU2aLQgBenFZHvnHbe0sy/CMjvgo13dZnon2VW/ewo4o
	J74DL6rdNnfWf6MZ92rVU/AGbLE3z1BB2edQeh/EkPhDcY3hTjn+TPf1Z7cJMtAmCCi6LWt2pzj
	DyY1dL8acIWgdwIIdzxLH9wnqTCtI5fh9gyasqmr1k=
X-Received: by 2002:a05:600c:628d:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-499c19bd51emr304814025e9.8.1787669041216;
        Tue, 25 Aug 2026 07:44:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d63553d6sm32130695e9.8.2026.08.25.07.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 07:44:00 -0700 (PDT)
Message-ID: <e3e7d23c-ad66-42de-b959-f9f2fae8d16b@gmail.com>
Date: Tue, 25 Aug 2026 15:43:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Subject: [RFC] stash: let the stash stack live in a configurable
 ref
To: Junio C Hamano <gitster@pobox.com>
Cc: Vladimir Sitnikov <sitnikov.vladimir@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
 <91feddb6-0d1b-42af-9942-307b98aa747d@gmail.com> <xmqqfr03sgyu.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqfr03sgyu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2026 15:58, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On a related note I've been meaning to add an option to specify an
>> alternative branch name when creating a stash, so that "git checkout -m"
>> and "git rebase --autostash <upstream> <branch>" can record the branch
>> that we're switching to, rather than the one that's currently checked
>> out when creating stashes.
> 
> Interesting.  I think we have seen ideas floated to allow per-branch
> and per-worktree stashes in the past.  I am not sure how much we
> should rely on the stash message, though.  The more heavily we rely
> on it, the more restricted the end-user messages supplied via the
> '-m' option would become.  If we were to officially support
> per-branch stashes, we may have to adopt a more structured format
> (which could be something simple like "at the end of the message
> after the last ':' is the name of the branch the stash entry
> targets", alongside a tweak to the '-m' option to always append
> ': target-branch' after whatever the user gives as the message).

We add the branch name to the beginning of the user-supplied message in 
create_stash(). If the user supplies the message then we prepend "On 
$branch: ", if the user does not supply a message we use "WIP on $branch 
..." so I think we already have simple structured messages.

Thanks

Phillip


