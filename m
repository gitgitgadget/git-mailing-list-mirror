Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890959;
	b=jefbMkONobUV2jVHTep+QzUPDcvvwTBCMjjUuT0QBjz1V224p/jDDOMlM7bB1/kXpzAm
	 sRJ7XcouZsn0jf6lbkcLkJVfsIryeCusZ8H6QVjyoJm5+iFyVJOUgym+Rs/CaaKM1OYvN
	 5bJerrLXQBF6g50PWnSdidVUAe5E3m1lqNdprgt3RcT06L5O5dC9p6RWTdZBEAEJGhm9e
	 AK1sCkNqD90QzWlSwBIH2IQUwhy+Md92C6Aii7Hn5v2Gn2DRloZQkGrDNx9r6tYpq0ktz
	 nrzNmIrbrnX5EDXHMYPBe1B8HY23fwyDwTWROjmGeXG9YGuDVfWolhJTR3bxUHWvHYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DCmT0HUnppTU7Uxj2cNp16KNjYDpB34l9z/DOMnLSQ8=;
	b=G6g23OR/Bf56CvmVG9fG53yRD8ZRS0nKMJDYW6qsu197We3cWLE2FeTtbtcGELkZjeiS
	 wVt7NPsd88oUWfN8gzWIgSUOP4yAYAq1rI8FnQkQqaDceHblv5kO4mfrS48Vc703uivB2
	 eJNkloPJX5jzgsDJvoSdo9JGSjk82iIBLydnOVbv9Jx/ZWHarU0eTJO1sPBlahDBf8c+g
	 zJwvk2/p6B/Z5L1itBCIUTizEYVWx9oo+95K+TKLUkS+jsrSPb40uDe2O7Gh5oSWXAASD
	 mAk97JgpUE3pM3UjChR275dQlei7kmoVj75sGkd4uMDNQ1gIKbN22GVNkAjYkN1gAXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YH9ZbRhX;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2583606D817
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2583606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YH9ZbRhX
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7ce645a1c6aso1141944137.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890958; x=1794495758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCmT0HUnppTU7Uxj2cNp16KNjYDpB34l9z/DOMnLSQ8=;
        b=YH9ZbRhXdXntiPKPnjz3Mc4ehSjZSQ03RX18j0dNZhePDl4fjXi74WQv3vWEDPG6hz
         G8yl+aIa+fQbhcQ5Ukjnk/fUv90r8FeT6GxDyJsJw4CGTwOSrQ2dz+TYA/ZK74RQM+0N
         iDLf4m4Me6oxByn/ra1+VKadCr9XWClRhBIv/2Mrm6LVTu0B/ZTJy+MgbZWFSCaT+e6D
         Dd3dmzINne2R5POnwOMKMhh9nZa+cF1904hl3EprIlHUF0r1VI1YTJNQc5NfMY8KLVjW
         9PeJP06XcQ1VA2qnkNzegcQalgqIuMfBUbHIUxDHV3yBp4cKIv6t8WU13I/V4SJ9FIKZ
         eybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890958; x=1794495758;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCmT0HUnppTU7Uxj2cNp16KNjYDpB34l9z/DOMnLSQ8=;
        b=A5y8YpOi3OQHIqoeh0yrmIvtNh8ynjY8p++mtmjQ9cKx3I6gutz01xq8UC/5rW3gAy
         nJe6RINNsS1+k1xX4CHl4Rk0KN5F9XdKvwADlTHGqkVs8Suzlie58LBiEn9TmTpsfLXd
         WNc2RD1jM4udTwYTUJIgsY4u5PyqTrrgiIv1hHDYL1Lka1s36003kfs1vCmzuPR0tKCz
         oh8E6W3fAGaEFRWvXcInELEwxTFbPpEOEq0l0hW/0a6yfWdrpMMPWUDjFf3RHbQdwnpX
         UuzRHQW5sP7v8bM+6FDnBNvqn0LTcpKnpgZz8JwV0Xz3K+cl17RqXmVuK3NiecvMaWqM
         cB3A==
X-Gm-Message-State: APuU4Z+6wDdn1XdQXeQRcxCt9PXwRno6sWL9HvcSsxOrzu4Bz3Y6u4nX
	l+2SOx3X89JCmIjqIiQv/tU2WzF+VrdIauW0vpgqN7Q7oFm3dHZGHKpY
X-Gm-Gg: AYBFou0BvzmvAJGHVcIabAZzpC8RRCQ/EyejQvvgkamBGY3B+l+CPGw3Q6Vx/Udv4Gx
	vItKpx2o/PG50PjMhprBoKBF3Ej6He7RWSisYiAVtjJ3/pgltZi/cxfR4ykDkp3sl5IQ2yB9iHs
	3TAZj37HwmJrSadJXkLD0JDjhahVffUkV9lbv57AobdECZe1WbtoVQJ9VXlELu7Ln+W5ivAiY2g
	jgL37l+uKOcZNE5GpI3B23QnHyl6GAMlIYUS9eKSKriub+ysopbzgs3W6pc98n4wRZW19hbMRtF
	gxVw0ekgJZf893orAq4hCS7zUQ06Buxdk/ieQMbhnFMB03VZufyz58FOrlYtw2Um4KVOuRCG3+y
	t36YVg0WaSDh3YRkiNK7i9K30pOHao7bthtWWn4FMnM2BC9gowYSKDNHrnnChc7qje/RJkOkhsl
	tta86tuw8cyiJd1jda9C44zF/4EQkqLTfVA4gbuTwu16rOWY0png8+h6BquwaT4a+fSIX2oaCvO
	LGEhQH+qo+t816liL3xecfp0M5XOrNQflCEgZLiGY2SEPQusITJnkoXZlLZpdY31s3HFFqSr+40
	bZ1BhAIA0kVxTAvYplwcdqrUr/Tr86ZqQMCvFmtVdxb6z6euySzzVUMS3yv+TbxIB13aE0JGkDE
	57q63khTP5xghEK6ZV997OlXo6ygJXXgTNM156jRAaks/UwXrrs7VK7eq+UMzkbm9Xdw/lT91Uu
	W1if3ifDBQ/Eeu506q5k/BitfaFdfYSpc0rruqXPcb/GocR3EHZqcIQ9czuwxj+EwZxLAccWJ/d
	w==
X-Received: by 2002:a05:6102:c01:b0:7d0:5688:f507 with SMTP id ada2fe7eead31-7d072c596c4mr9143805137.20.1793890957341;
        Thu, 05 Nov 2026 07:02:37 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488e442sm477361385a.40.2026.11.05.07.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:02:28 -0800 (PST)
Message-ID: <dbdf0592-6819-4063-b62d-22e2d6df1050@gmail.com>
Date: Thu, 5 Nov 2026 10:02:27 -0500
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
Subject: Re: [PATCH] fsmonitor: invalidate untracked cache after losing
 history
From: Derrick Stolee <stolee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, ki.stfu@gmail.com
References: <pull.2295.git.1793806679163.gitgitgadget@gmail.com>
 <xmqqmrroyztr.fsf@gitster.g> <3d62a579-5bf1-4431-8bfc-757c3c873d80@gmail.com>
Content-Language: en-US
In-Reply-To: <3d62a579-5bf1-4431-8bfc-757c3c873d80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 9:08 AM, Derrick Stolee wrote:
> On 11/4/2026 5:52 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>>     A user of an internal monorepo reported this behavior, including an
>>>     AI-assisted powershell script to prove how it worked. I used an agent to
>>>     assist in porting that to a Git test script and a code fix, but then
>>>     applied significant human editing and validation on top to get it up to
>>>     my standards.
>>>     
>>>     Thanks, -Stolee
>>
>> Would this be a viable replacement for ik/fsmonitor-untracked-cache-trivial-response
>>
>>   https://lore.kernel.org/git/pull.2247.git.1791127155614.gitgitgadget@gmail.com/
>>
>> that has been left unreviewed for a month?
> 
> Thank you for pointing me at this. I didn't realize there was already a
> patch working on a fix for this issue.
> 
> Ilia's patch has the stronger approach of trying to preserve as much of
> the untracked cache as possible, which has some performance improvements
> over my change (in the "rare" case of the fsmonitor failing).
> 
> Let me first see if we can take that patch instead of mine. I'll start
> some review over there.
Review complete. We should take Ilia's patch instead of mine. Consider this
patch retracted.

Thanks,
-Stolee

