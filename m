Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CDF15278E
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645348; cv=none; b=kALasB+I/Rzr3qNWBkr+oKL0z20vIRJHYof3KWksbC6TGcTwrnrp8RDQf5nl7eGElKxyUFY7cEd+F02SVdCc2dYJmFeN4OewKun81JgMEKTBJQLMujW/Pupbeovv8jIKvRLB5AsHPNI3mJ2gEZ/wpy4LlYSunUwGjV0SZ5tqay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645348; c=relaxed/simple;
	bh=1Z2/1mgZjSTmvUaGV6IZcGBzoledMAzCTTKVyMd4rsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpcxvBaQdhawqetPiaiPIe6LSNx36WaQEdMEq3ZhlzuTuT4f4pR3gG5F4G6Zfx1utua5oDRFGQ7f04abnGX4/lMahZ1L82A9i4bdxXEqhSYBedPdBhLtjJbVW1ARqxIacwMbnwH9E9fnwdAl3g4nwtL/HHL48gzzHbS37fOVFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bhldz4BTszRpKH;
	Wed, 16 Jul 2025 07:55:35 +0200 (CEST)
Message-ID: <26cef1b9-1f17-447e-b647-3d32a3984997@kdbg.org>
Date: Wed, 16 Jul 2025 07:55:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Bryan Lee <hi@looping.me>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
 <1AD9A170-8E17-411D-A13B-EA7780CF4D39@gmail.com> <xmqqa555gp1i.fsf@gitster.g>
 <6AEC3113-D687-42E0-B6D0-DF62FA1A9A8B@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <6AEC3113-D687-42E0-B6D0-DF62FA1A9A8B@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.07.25 um 03:39 schrieb Lidong Yan:
> Junio C Hamano <gitster@pobox.com> writes:
>> Lidong Yan <yldhome2d2@gmail.com> writes:
>>> Bryan Lee <hi@looping.me> wrote:
>>>> 2. Or at least document common misconceptions like `pull.autostash` in
>>>> the git-config man page?

>> There always are end-user or third-party defined keys that are not
>> known to us, and we cannot tell if an unknown variable is such a
>> end-user defined one or a typo of a known one.
> 
> For every git_xxx_config(), we could add a register function like
> git_xxx_config_register(), which looks like:

Instead of this complexity, it is most likely a lot easier to fix the
origin of the misconception that `pull.autostash` is the correct
configuration. After all, it isn't even mentioned in the git-config nor
the git-pull man page.

-- Hannes

