Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301FE388E69
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149445; cv=none; b=V7FRFQKSnW43xhD7ttAQG0x3SprvRPZw2tjwPURLoNq+wgiMz9Lbrh2zRospWE7ekhudU6M8PwVy93OdQsud7N/z38rjxbDUkGnRrsSu2cJ/FDFxkIMRgNp5fPWO0XEL2wlNd7u7FHeAYGFlx32p8nOx4kyNrR9O1p7JrQSxerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149445; c=relaxed/simple;
	bh=5YN5kCioQB3YStj5+5K06n+jfhN9s+N7BQr0EamkJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQgqz2ZfukU6j88Nhz/h5pEHFAiPOzWc6KP/PIfFYG183bIHhhDMb7HBA2gbk1DCEdvZbHVMQBQ3Z8623VXNIC+HGcg9zrTo1KTJ0Mc12QAuzVhHD52SuUYM/HrOgpBNT3Kb0BY7R06MIE4H8V58X3Sw1AGFdaIsimmZ/VRqxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1LtLA/I; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1LtLA/I"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48541edecf9so13256935e9.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775149434; x=1775754234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mcTohUwmbdzsrhVdQurvQmbwv7NozqBzMR/QuKSL42Y=;
        b=I1LtLA/IB6ozzrh5fR+RmZSLdjKnpWkiO0PqNunrNwJSqQmSY6OtRdHyiAGWWQ8f1R
         2WuJz7mvSW4NimfKtd75E6sUSLZEW/SNvOPNVjIheZZo9mmA0EXWPzBIuBi9/+3uTxXi
         pty+M0E09Fy2RXG/qlwf8DF8PCcc3ILEqeMHj+9u9O7SS4tH3yiSttfMYxCMIR5ge2sE
         mMONyo3JQqJfgFHB0dJfer/7A4qUHku5LnZdZ4yz9fL7FQWcXk042A8EgllC4U+IosSY
         yqBIbQNJrESObYBn0RudoKDTAPn+Ny6abZJxMLfVljP1MnPBwt8OvNiveGE5bo0o4k7r
         Jz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149434; x=1775754234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcTohUwmbdzsrhVdQurvQmbwv7NozqBzMR/QuKSL42Y=;
        b=KtnH4Z7ZHDbUPEEnVd63Y+8/BPWpoF5Smry5E2lCbBtHHHnGZ60pl3vlvLlNtCmzC9
         o92bFbL3vMFLVXHI4eqmKmj8Mlll6VixiqP0VbSYPKR0TCd6dlL+cO/Fet/iFxlkoxyX
         PLikU55nP/FDGQw9VDbNkzTMXcEg3AWghBLvIiWcJnqwlbK/1rNj+fbhzuwxaZt0Sh8x
         txq9y+mOHvHQXNQRH2f41Wf1z3j7QwDEVZOWJrxJgkuvjkufsY/zvgnF95SY6kX3KA8f
         YuIMatmvwPhem1S9KS6T91VEVvGdrjJMvsiIh8ua3Lihgx2M4PIw5fzGob4lbA3qiUSV
         cJqw==
X-Forwarded-Encrypted: i=1; AJvYcCV3fMrc7023IzgZPgkjqceDbmAE1cMwQwPPWbB2G19yiN7MRtshRBdcNImUPFMOTGsK7UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmx3N8fQpiv0IKMz1e1LjMIvgj1yHN9KIrF+1nF7GhMolH02yO
	EIU4hkBn6EslDBJO6AraBtH0i3nlZDsri7HMf3r9B2YUdRJt9/9Vf4rl
X-Gm-Gg: ATEYQzy7Yw7UIh24yKG1KqWDAtaRhOcoiKvSOnkvFl6lMJ9IMAB1TRYFmQ0OL7nhlB/
	pJ2e7+3B2IvlzFMPbuja7TcB1AoE0MVrq7quxOSbOk7peIVOztpMNGHZmsOjIxpurNAgovVMz5b
	pHR8J1Mwv+nRkscYkWzmY4rWH+mIeNOgyj04y3hmKuMrjU0jclBXLb/lZ+3H8ajoLwWzgySiCMk
	apeLx7un8Cwxys8nQ6mx6k43hPdcKnClL2r0k2lcEncIMsKjaMXX5XDNw0rHwJuACiuohQ57mq9
	MXW7oodU/g6D/oo0g/MoX/x8VXD4+LMAZn2amHoT52/EYSa+aMZduRfncY4c5AGRPnb6z2CYgfb
	ezqGf4yxc+mAcprWhP1EvIu0QmiNR2pO3QE+zFYjW5wOR1IGpZro0GpIuYB4aUwtrG/Or7mGvkj
	MQozGSnworcp33nL+4Wuus
X-Received: by 2002:a05:600c:1f11:b0:485:304a:58cd with SMTP id 5b1f17b1804b1-48883569e20mr142217565e9.4.1775149434063;
        Thu, 02 Apr 2026 10:03:54 -0700 (PDT)
Received: from gmail.com ([159.146.41.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm77404025e9.5.2026.04.02.10.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:03:53 -0700 (PDT)
Date: Thu, 2 Apr 2026 20:03:45 +0300
From: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, 
	git@vger.kernel.org, Jeff King <peff@peff.net>, Tian Yuchen <a3205153416@gmail.com>
Subject: Re: [PATCH v3 1/5] refs: add struct repository parameter to
 branchname helpers
Message-ID: <ac6K5UnVdw67Rfpy@gmail.com>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-2-shreyanshpaliwalcmsmn@gmail.com>
 <ac4aZRveWXjOtxgB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac4aZRveWXjOtxgB@pks.im>

Hi,

On Thu, Apr 02, 2026 at 09:27:33AM +0200, Patrick Steinhardt wrote:
>On Sun, Mar 29, 2026 at 03:46:39PM +0530, Shreyansh Paliwal wrote:
>> diff --git a/refs.c b/refs.c
>> index 685a0c247b..5cdc8858c5 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -758,10 +758,10 @@ void copy_branchname(struct strbuf *sb, const char *name,
>>  	strbuf_add(sb, name + used, len - used);
>>  }
>>
>> -int check_branch_ref(struct strbuf *sb, const char *name)
>> +int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
>>  {
>>  	if (startup_info->have_repository)
>> -		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
>> +		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
>>  	else
>>  		strbuf_addstr(sb, name);
>>
>
>I have to agree with Tian's comment on v2, this part here looks wrong. I
>don't think we should depend on `startup_info` here, but we should
>exclusively rely on whether or not the caller has passed in a
>repository. And that will likely require a bit more scrutiny to figure
>out whether there are any callers that shouldn't pass in a repository
>because it's not initialized.
>
>Alternatively, we could go with Tian's suggestion of checking for `repo
>&& repo->gitdir`.
>
>Patrick

This approach actually leads to a bug and segfault in a specific edge
case when running 'git check-ref-format'. The current tests don't cover
this scenario, but they can be extended to catch it.

If GIT_DIR is set to a non-existent path,
'startup_info->have_repository' becomes '0' but 'repo->gitdir' still
holds the invalid path. As a result, the code enters the first condition
and crashes. The case can be tested with this command:

$ git --git-dir='non-existing' check-ref-format --branch @{-1}

Modifying the behavior of 'repo->gitdir' might solve the issue, but I
belive that falls outside the scope of this patch. After a quick search,
I found a prophecy from Peff about the 'startup_info->have_repository':

[1] https://lore.kernel.org/git/20190806124954.GA13649@sigill.intra.peff.net/

Thanks,
Burak Kaan Karaçay
