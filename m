Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A41BD9CE
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675431; cv=none; b=MUKooLIQItshis9Lepuu/e8/4q74DpmvPGlMFM5tLwvviYg0zZLZYWcziHiSC9fcthfddl4NNvZscbey/96K4IA36i7o2K1RmWHaBSaRQ4fxWzeo9XFM4qUo7oOllD13WTbJhBMir0cFn2W2J1PHvFjDcqBx5Z39KBDWmRp8a/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675431; c=relaxed/simple;
	bh=/l73l5mCEBsgBaBUzB5uC5+ilqPw/UocvdzgZDqBJAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FY4K620ZrIysQx7FfXjdvuvrZ6whGSJBmOW7+GyZV8MOOKTZFQEw54UG3ZtMtaq9c7lDdlSwu2/HlznOdWkIGC3pZCcZdaH42Mi/mn505rrExFkAxrsNsDlgNI0+tnRloiiBpQiFpxMu0oJmMvF01soR1FM5hy5wlRZp6hkWL+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4qIJfvH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4qIJfvH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891f625344so4831185e9.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776675429; x=1777280229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=htHoh/Jz6C/oSuz/+EX9vv1PPkk0NWPNmORTwNSPcHc=;
        b=F4qIJfvH/TnJw7U5A9CtzsJJyXEWJ05b6BO39xjATf/I9/rKhw1+yCY6KyCP/ne72v
         wo4RiGSDd8tR6cnfAv3hTbr5kJdkqR7joOM7gNtlccxawrfHH2woMaAyVCpzfbg1vgiu
         TSVjuaXTjLzwL4K3rplaDUiDsQETBGpj8IYW3DpIIYrVIHA7YPP77t5b+uMGOltSdJbo
         9UDsvDGlC5Yb56y+0tbdXvm6bI/9vOBUXuSIWMhxoICfNpYPSL06sZPAvpoVlHwFsxvp
         Ho/GR4N840WvE2ZKVzbbMf1k/RVnBQcfioc/HheziRSdxorILrIP1hr/CidbFD4kHaP5
         gvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675429; x=1777280229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htHoh/Jz6C/oSuz/+EX9vv1PPkk0NWPNmORTwNSPcHc=;
        b=aEoeaPgoYtt2GTsJPf1nzAKSQZnW6nTnOiDSU+W9eD2VbVkbKwOrhZCXyBu1WO0/Wk
         dV3hj7PzJ0dqqBo+kl/m5SU8waM63tqdIhRyglsGmPhuVv4HH2BtDEPb6fH8dZfayD2G
         KJ6HJSx7ohaPF0P7KsM6vhNoSL1Gn2vKOHp6YNgtqWDgbq+afj/l1zNgRx+vo5MN0dCE
         TJ1J0ItvDSJPb2dfJOe+ZySTDVgk/PTelPQmkGIJDErVbdDaiTnffNq9gIdDgV9Gm+Ji
         5S6gzzPnfvCq/UVl/9mXu5KWuUQ/ezlLB/tUsFCnIW/H1lnQV5o6ImbW5q3Mhb+LPfIw
         SE8w==
X-Gm-Message-State: AOJu0YxHE7RwusfN/MZvGEPKDZJFR8o5UpDBBC2wewl/R9KsCObw80dM
	u+pDJnkuSPfIs2rcm9le7ykL10h/iTTwufvfnN1WtkC8+GxDUX1j15+X
X-Gm-Gg: AeBDietjh4VfARDVEa7rbYPtVkQcVvLE0sLVhpmN857qoBydB4y/MXpKXZHXdv3TPtH
	dOkIm8zYj85qH8nO1eTVrQjB9E3YDTh4bNkyP2r9e10SDY8KAshadryxrX2yx/V6JqxmFavpXNs
	zxEPvD+YhNjmMvXAajLay3tH1+eSNz7LmINVIBI1ZlnuwxYA+xWBFXWS2QwBLR+tXPaM8rV0sLD
	Xvn3xBMeBp5lsuLLRQRleSSyN6LTujtSIwrrMUJ27utwNm0LfivZKkDvbudXtt7WkYwbxXe/h7X
	h2rF2liMBKvJlXDfzta8cfIb/SLq6+5IDSmrQQE298CoSRkPZsmMPZI8E59KfpOQ2fgivghrz8W
	hYW4V4Gy04OR5VBiUEl3Vgj0F9/cupAdMzm3sfQxB8UhvdRf17Rfr3dGRs/MTpepEZvdaqNehie
	Lfv/3XA2F8ZCN/IbN0bolXaEzsrRG9Ck8S1yR3SoUfTqBZWDzoVZTN+0VDRvkFoE2rfTiNmpzGE
	TUbPdzRwIMxqg==
X-Received: by 2002:a05:600c:3150:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488fb8b9deamr146918015e9.13.1776675428607;
        Mon, 20 Apr 2026 01:57:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75af76sm85060365e9.13.2026.04.20.01.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 01:57:07 -0700 (PDT)
Message-ID: <491a27af-3ea4-4978-9d51-9c540ad31589@gmail.com>
Date: Mon, 20 Apr 2026 09:57:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
To: Patrick Steinhardt <ps@pks.im>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, toon@iotcl.com,
 karthik.188@gmail.com, justin@parity.io
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
 <aeXZOAtILSr638LG@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aeXZOAtILSr638LG@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/04/2026 08:43, Patrick Steinhardt wrote:
> On Sun, Apr 19, 2026 at 02:18:40PM +0530, Siddharth Asthana wrote:
> 
>>   static struct oidmap missing_objects;
>>   enum missing_action {
>> -	MA_ERROR = 0,    /* fail if any missing objects are encountered */
>> -	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
>> -	MA_PRINT,        /* print ALL missing objects in special section */
>> -	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
>> +	MA_ERROR = 0, /* fail if any missing objects are encountered */
>> +	MA_ALLOW_ANY, /* silently allow ALL missing objects */
>> +	MA_PRINT, /* print ALL missing objects in special section */
>> +	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object info */
>> +	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" prefix */
> 
> Makes me wonder whether we'll eventually also want to have
> `MA_PRINT_INFO_ONLY`.

Perhaps we'd be better to add a "--missing-only" option that limits the 
output to missing objects? That would avoid the problem of 
"--missing=print-only" not really explaining what it does as well.

>> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>> +do
>> +	test_expect_success "rev-list --missing=print-only with missing $obj" '
>> +		oid="$(git rev-parse $obj)" &&
>> +		path=".git/objects/$(test_oid_to_path $oid)" &&
>> +
>> +		# Capture present OIDs before hiding anything.
>> +		git rev-list --objects --no-object-names HEAD ^$obj >present.raw &&
>> +
>> +		mv "$path" "$path.hidden" &&
>> +		test_when_finished "mv $path.hidden $path" &&
>> +
>> +		git rev-list --missing=print-only --objects --no-object-names \
>> +			HEAD >actual &&
>> +
>> +		# Only the missing OID should appear, without the "?" prefix.
>> +		grep "^$oid$" actual &&
>> +
>> +		# Present objects must NOT appear in the output.
>> +		while read present_oid
>> +		do
>> +			! grep "^$present_oid$" actual || return 1
>> +		done <present.raw
> 
> How many present object IDs do we have? I'm a bit worried that we now
> execute grep(1) hundreds of times. Can we maybe do some tricks with
> comm(1) instead?

If we want to verify that it only prints a single oid then

	echo $oid >expect &&
	test_cmp expect actual

would be much simpler more helpful if the test fails

Thanks

Phil
