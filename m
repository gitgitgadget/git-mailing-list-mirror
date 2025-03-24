Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2EC19CD1B
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844605; cv=none; b=nxNkBg6LHTRc0NabFq1cMzCYMZVxD6E2RyY9Toep1UK9K8PKgz9BzZO8CrWv41WVOTEEsKwhxTJ6DPByiHGlPQ/4DfNhk9h0ET6NFmR/0FvKC9fdtcxqqbMv2gPV4jDKI4Fzio6WQ6000ekQ5Mtg1j4l0J/IoKIxvsxb1dN0C04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844605; c=relaxed/simple;
	bh=79roUXn6Jq+OgvYR1OO09zfi7NrpWnczSuvQlQiEVks=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Glgs7WJfcJCQfmUpDQgnkc7w+6t79AHuZZjgloiOoDQZyGHThpLYRgcjP6uFB1qI+mVJFHzWGzXHq0YztZcTka7Ys0bAeVBAQOtOhNvEDxaVva973ul0Osn0wqR8j8ebmsg8fN3auzOFTR3CCK5LsIKctcVwnIHXcemsShl4XcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoJGwQ9Y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoJGwQ9Y"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso36387035e9.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742844602; x=1743449402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rhlu7k+KY1mPz3ctOY5kVPIvseemZEhz5eH0bgfsFc0=;
        b=HoJGwQ9YJNod8oXrNA9UcTQQ2vSGSZomOa6JV3+X5TGqs28dML5YOd7GlmnmXQUL6n
         cVFNNhSh8mmSRcGsms53sQUg78fiZLAA33K6ZTDij4q4kOAjRpvPzmk0NEhApLRUbrrL
         QWoMZblKbBEiS86z388LbJx1hlo1lrU+VxVcub5HTSeS8WzjkLpRJGE+GQJIzVi4tWJY
         YN8MqsGS+1Y5Mssi0d7PWRQCr9bVzsnQCwD73XNxPa+MU8IIEaJ7Jr3h4EfO3GAjpSla
         3FOKURCD3rE7eYNul7tWiKl+9coRjwk+o4PCKETYECfnLLsKr/kWaExGta8gEbJ14nk6
         EEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742844602; x=1743449402;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhlu7k+KY1mPz3ctOY5kVPIvseemZEhz5eH0bgfsFc0=;
        b=sB5NpunhDAlZiEYaEY1uBNJbQRIstq2Az10TnZDK0+hL/hvKcz5dCbEyC+0+wxEzI1
         m10d6xkMfNuJDXOOJ1BnCAJHO6mMjg6Bs8hRhLz1CvHcSkrnjH73tjvIdxe2C/QwP97E
         +FIg+xf1UlVvBMrfbAgu8wqxFvSl9PHd52Ax9WnxYq59sIxGRbKP/kxWhkUVhHrMLHv6
         h1zhMGFsU3nsuO/fZGBXoaulfZVTCVeMI8ncqmQrYTcxIGBY6uyC7++y8yO0WqF/FB7X
         CllXzKMQtF046agmHAgE7Fun77U0a6tIpk1u8/grQ6mhu1R1rTZRDhdiR3hIOya9S+lM
         i+Ag==
X-Gm-Message-State: AOJu0YwtS092j94AlhM/v1Usoe/AiIl7EEEsDWY3gZKjCj8NgCpxJRCg
	xTp00kq5a9vFm1zPUUXtDMetiC/RE+wW4jgEePg0wvgfy/qZTnqv
X-Gm-Gg: ASbGnctWe2CrSond0OQF2MkiWoz/hMQbexS/LMrekgWuzI3WT0LaJdfTa9tVYH8u5qi
	sO/xFRXqniL6HNUK04Z7w739lPVufYGeFgwyjXBqKVEGqAeba5sYgQSKj+ntO8Yf5Yx3ua/jbn8
	vXYLPFSx3RmrPoDIA1AsWJfQS4EkV7e9YpeuWmJeCVePncK1RLXLxrynLLbHeMsGPe723f25iNA
	2O9K/H9x67B5WbsKSPouAn2h3NOTFmU4y09dhiC0L5xVCXM+YkiYSV7z0uKRioZ7iaLhHni+Enx
	VPFyJbOoioRptiq5gpBDJe2kbTm4PWFju49qm0vUoAUQxfeEvPtK0hoylSOnZDz3nf8Pjz84FiD
	W7A7+W+lxdRmQ+Ig9km/u
X-Google-Smtp-Source: AGHT+IErPcpe9KJ0VMRRnkND48Ye2/yfbgsKRz+8qnsVgagL6PnUQqPDLBD3mkvrS+Ev7lIet+IMyA==
X-Received: by 2002:a05:600c:1d85:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-43d50a218bcmr139748355e9.19.1742844601890;
        Mon, 24 Mar 2025 12:30:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e64casm11753572f8f.73.2025.03.24.12.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:30:01 -0700 (PDT)
Message-ID: <884dc4b3-d470-46f6-b129-c6d20817daf7@gmail.com>
Date: Mon, 24 Mar 2025 19:29:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/3] remote: allow `guess_remote_head()` to suppress
 advice
To: Justin Tobler <jltobler@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, alan@norbauer.com
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
 <20250321231639.180762-2-jltobler@gmail.com>
 <106cecbf-6a7c-46bd-8115-2b5fb06cc9af@gmail.com>
 <3rcpapodk473swxbdgubhuqijvgwe6rz5iqsfykglsmjbanuu7@mh6tvrhyyrx5>
Content-Language: en-US
In-Reply-To: <3rcpapodk473swxbdgubhuqijvgwe6rz5iqsfykglsmjbanuu7@mh6tvrhyyrx5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 24/03/2025 15:21, Justin Tobler wrote:
> On 25/03/24 09:31AM, Phillip Wood wrote:
>> On 21/03/2025 23:16, Justin Tobler wrote:
>>> The `repo_default_branch_name()` invoked through `guess_remote_head()`
>>> is configured to always display the default branch advice message.
>>>
>>> Adapt `guess_remote_head()` to accept flags and convert the `all`
>>> parameter to a flag.
>>
>> This makes sense if we want to convert the boolean argument to a flags
>> argument. However the only callers that do not set `all` when calling this
>> function are in git clone where we don't want to emit the warning. It is
>> probably not worth a re-roll but I wonder if we really need to do this
>> conversion or if we should just hard code guess_remote_head() to be quiet
>> when it calls repo_default_branch_name()
> 
> Good point. We could just rely on the fact that all current
> `guess_remote_head()` callers that do not set `all` also do not want the
> advice to be printed.
> 
> I have a slight preference to keep this as-is and favor the explicit
> configuration, but ultimately I don't feel strongly either way. I am
> open to change in a followup version though. :)

I'm fine either way so lets keep it as-is if you want

Thanks

Phillip

