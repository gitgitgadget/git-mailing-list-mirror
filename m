Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911765733E
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386867; cv=none; b=HUirL5HCEI9+Rr3M/wQqSRrOC8j8iJtyKMveJqDCqU7OMLbC1RfA0n6zS/JTUJNHck4nw+BONu0xjziAbclQfPIcf2bgbz/4BNjtLrhedlawps/tEeE2ipr5Ro6YuJLXJ95O71mOtDCaQV1QTVbsoxH4lai/Nqalb6Viwo1fMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386867; c=relaxed/simple;
	bh=S1P9MXKpF7IkmKQ0R9waEIvKhxZnLTBpaDmcKSJAJXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieQ73Lp0i2vJ7Z5yeWFbrb/lnObxniEjGcIF7T03lbBQ7MpLDXccitrAjFa1F5VTVXwbHN5toIvwo3rCEYWtIoHhH968JrwYH4OZcNNZIBPO8O0CKJpNaidA+aGBpHdH4mab4Er9KmYUcHYxJTc/ysWXkR73oyuczfIhAWnr1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9f0AAWM; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9f0AAWM"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66810946e63so3630236d50.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784386865; x=1784991665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AjCM0F24bYlH8VI7lmxFaWC95xVZry4IO4ZS+S6ayPM=;
        b=b9f0AAWMcBMHwewpO/2uJqb4coMVLaqJm7M5NscGAJEwqJ0O8RljgFIiaeldHi3gBP
         sVIEK8Cn3h90V39NzNvVZzGrir4dH3Dc+H8jLReaHctOp6bnmHLBs+wKEWzzwqk5KsHC
         mR3z06OsQaHzbNJ72dkpJM+7X6vcGsRWuwTKBdFwD7oSzM3OBl+k+e4CRB4ODuvdsi8x
         Y1OEzWpHdsAWHgHyjxtqom97T3l7ZfTPyiFjPp9Qwfwol8HmjllJI1aPyvIIG61ewKHR
         jzsziNFm0FrysspsXTxtr4ptf3nWReF+012yhpe5nUohKWB8wrThAW1En+tkzibnIf4u
         kpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784386865; x=1784991665;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AjCM0F24bYlH8VI7lmxFaWC95xVZry4IO4ZS+S6ayPM=;
        b=JetRsxQbqDJqADCXkgXG7fPhvsDPJbt/aw8dL+CXnd6sFlVgtI/45jB3/+WuRfnV5G
         DdQK8E6d4AgyKcHpvUXI9aBPEcXawRal9tvlc5/X1NzPMgHIashyu29QhFWxBBfjV0Ey
         Ngd3t7EglExCaekvpPzx7+Zaops7pzkn6sxwhe84tHvhbVar/80JGXeTIrYE0ifUq2pL
         LPLCBPmxA19vcLgIz2Hdew4aDmHCQc2jdwlt5OU0KId+h2DfEdyxPcMHiajTRmgHNvDN
         g7aO8KvkPU2iACP/xcMLuB8rQs3UIhPryyDGmjDnz6rM5cRzy1Uw6sqBHuT8qPyUwKl0
         ERrw==
X-Gm-Message-State: AOJu0YyHMN4L1GPtjIB2l77wGlY3nzkaH4OEvr5T93C1KBliMPblQi0U
	mkfcsXNQVQR4LDb0KsuZBA+hCkhRlcmq+62CGgHkQn7zXzvbaZrZjVJ5
X-Gm-Gg: AfdE7clA3P1BQsyrOTuQLbGPIizYxvSN8A5c3nMKCE8xluM+hoWtk9lkMm2dxXl2rU7
	OpUiMhccULac4H2GgTnJ/nymYdVrpJF4qtgiQRmoHcjLuBJ7aOLC+KeBSuEPZTDFy52OACsR+QY
	XYnULb9VYIfl8WPFoE9y/12zQMTUaerB7QRaJUReRKttqPn+UKhOYzw5Aow6MXaI8MrwaphuQPo
	49xdvS28itBKaBGfvm8Q5y4U2OjE/47KeR/atGSMr7ync6yFSi66YjxFZLbvGqYo7kYJKdOQ3nJ
	LVb4ulHiBZHG++8X61O1bRWwTMOC2ze19WhlVZ9WcjyxVaYlaveda5Jnui8HQb/cJ8rBpZhejL3
	j88eShDrKJKsnMIcNaITEcIHpD4ECL9UhHmQ+pe+fs+qBHViWt++vuFeNWeqQvsirR/geDRAmg2
	jWbqxySsGRDPFMpYc9bAl5MNs1L5OEg4P5L1H6TBiE8M6jojGxUCsVKLrOrFQln3AfKFTPRKubk
	/KEnHIDlYxpkQJN1hbNX8DdkAWpEjF3
X-Received: by 2002:a05:690e:488b:20b0:664:d37d:5fef with SMTP id 956f58d0204a3-6683bd67e61mr1470457d50.72.1784386865247;
        Sat, 18 Jul 2026 08:01:05 -0700 (PDT)
Received: from [192.168.1.110] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778562524sm44114466d6.13.2026.07.18.08.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 08:01:04 -0700 (PDT)
Message-ID: <c8d443a5-3cfb-4752-8716-cf0d8fadd9d3@gmail.com>
Date: Sat, 18 Jul 2026 11:01:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace2: tolerate failed timestamp formatting
To: Taylor Blau <ttaylorr@openai.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <alpXW5U6sndZtgqV@com-79390>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <alpXW5U6sndZtgqV@com-79390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/2026 12:24 PM, Taylor Blau wrote:
> On Wed, Jul 15, 2026 at 04:12:11PM +0000, Derrick Stolee via GitGitGadget wrote:
>> This change removes all uses of xsnprintf() from the trace2/ directory.
>> There are two uses of xstrdup() that could be considered for removal,
>> but they only die() on out-of-memory errors instead of formatting
>> issues. I chose to leave those in place for now.
> 
> I may be missing some Git for Windows context, but I dug into this a
> little and I'm not sure 'gettimeofday()' is the culprit...
> 
> In my understanding Git for Windows's 'gettext.h' appears[1] to redirect
> the 'vsnprintf()' inside 'xsnprintf()' to 'libintl_vsnprintf()'. In this
> case, we have seven '%' placeholders. Gettext can store only six plus
> its end marker inline, so parsing the seventh causes an allocation
> before any timestamp values are read.
> 
> A failure there would produce the observed -1, after which 'xsnprintf()'
> dies and trace2 can recurse.

With this perspective, the issue is that gettext is doing dynamic
allocation and getting a failure there, which explains the transient
nature. This is an interesting idea, and a more likely "application
side" error. I'm still curious why this is creeping up for the first
time in this burst, since nothing has changed in the application, to
my knowledge. 
> I think that also explains why calling 'snprintf()' directly helps.
> tr2_tbuf.c doesn't include gettext.h, so I think it bypasses libintl. If
> I'm reading compat/mingw.c correctly, 'gettimeofday()' fills tv and
> always returns zero [2], making the zero-initialization unrelated.
> 
> Would it make more sense to fix the xsnprintf()/libintl boundary and
> treat Trace2 reentrancy separately? I still can't explain why the
> allocation failed, so there may be another GfW-specific piece I’m
> missing.

I think that your suggested change has merits and should be pursued.
I'll explore it a bit to confirm.

The other justification I'd like to make in my patch is that the
xsnprintf() calls die() and the trace2 machinery should be die()-free
whenever possible. Solving both possible causes is likely the right
long-term approach.

Thanks,
-Stolee


