Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DB31F99C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990262; cv=none; b=HlFGpI+e5gLHXHDuwqclCmkW6UTA6GLmO9i9CaLnPG26Tn3VG12v311b1G+PXx7oUxMbXzVw7w4HHYGj14yMQiLipY6KwWsTULi2C7hGzRw/t7jk+6ACyIj4TwPaaQa1YpGQYPkzlzAS72zx/432kVuR4F/0zlvS5uL3bgiXq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990262; c=relaxed/simple;
	bh=kowHBgOby2mzvqrn5rqjG5vT3VkLnjmErms9enNRIJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdrwEBI8k2jW3/EOxaLBQ1uoAv2TIdL1vGah2X/zVoNQj2pkvIOaJ8vZeeSTjjF+MlbkWyOAtDIVzYwrXdofWlWCAej8hTnHXjum0ct3SG4k3X1tV24G3O3oB3rxf5LIyMvap1uhVDsz/zehsRX9UGxeeQpHZostxpTPwLT7Z9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LROWraDM; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LROWraDM"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35b2c599f43so5203431eec.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791990256; x=1792595056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPjr1By/uOLljGFgKU31RSwNKFE41dipIjP7TVykMRA=;
        b=LROWraDMpXjz5Qj57ttzBa+Vpw3guoM6R7jifktAaCNDf2+0zThy0e1cIfMNewO9KF
         RfA5DxOZRtnsBGZRnHTp1vfmIjJw1sYJlLZcHl+GB0HehI/124Hes7kjyj/Ythkkv1CJ
         viC135u8ws4OquJ3/rcv2cSpSmpc7wMZEHBMPeMEj80xXOf27OOJrynv2XQXDTNe48Zf
         koN6e1FLQvaX9Noh6oAVl7n1yA6uEaLQj+io/J1wV5QuixH3qvstPx4RKqD7Uyl7+c8W
         KJQ/cjhLe0FWdEiNoQtnUCY9UaJgTWvPdUud9MuZdcjFyIJxyh89TP1AQooflzB32O43
         1Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791990256; x=1792595056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPjr1By/uOLljGFgKU31RSwNKFE41dipIjP7TVykMRA=;
        b=eZ7zgwgrFZkUWaBP9Q944Z3hRnvYDa5EnB+bGf2WGJVpCVP7/ojQ+bkYp4INk4Qdqh
         lFWJIE0Sus3aazLYZL7++PCraTShhHVUWJlOFzs9p62l6g97Q8h0KiIj9UhXyRD30eDP
         SlMMUzpNng/tFWQqZj0BPi2YjUtCrbVOAQd21sJeKSwxH2mKErgMvP8ObPsHaibGKk7y
         UcpuoTV/CSeICqjVEDIwplooPQEdPEktuCcZSytZsB0/1C1A/KpYHDX+fmszu3XD2JkD
         /10ABRNjV42jgM+mehBhVluoYcxwBVrqp10ild3rrcEvvGNYl2TT05d5zvzNNwXHREdt
         7/wA==
X-Gm-Message-State: AFq9FYK9CeZtxC5VVXl3iZ1ezPMSncR04AyurHc/rwp2ioV/QpqdcgAL
	EbScckebYhGNXBEIXMJMPPOAwd8t561FFl5GFET5L2SLxGfU9XtHyrZC
X-Gm-Gg: AYBFou2lC+UOeL09SsCZbJA1CHA31chHqmNHBny9AnU7EimAFqDlcV4RPjUTEp5UfDw
	iVdiRi7f4jVbY2kb6CV5A+RBXwlkkf5pesuCaVGepIz1YY9DkvtkLTp6quDccWLS3+OgebPuL7m
	eLQH6CRahJu4+ZScGMt32PuJAN+sh/p2HWdv2m8TXznTNL7+Phqd4EQCfMXK4bCLKhF74Rbyzrz
	Z6DI7B9p/FDRdjup0ryPSnAanOY1d3PmVIclXFTLO70OMNIOmNVTfGHHHpkrtrbLvLhej/o2xGJ
	XdrFVhtaF0u4tuXPuRZxjVkRI8gLfgeLiplb2AuvYaCzWrUYGWXag/SoWpylo+Cwpdx2/CajIub
	Au6mmhqXmDEQy8pcan/dr9LfUHt3+IVdoRCKJ+8EUbgRGBEy/cxNcrdmRQmmM69B6JvEGk0yxxw
	XxOY9GtvsxzpdG00igngqRLO/r30ddn20QLB2CYirVrloj7yilUSjZIRPWO6ZlXgIP63WwDcMLv
	88qG9hKgsh7zow=
X-Received: by 2002:a05:7301:77cb:b0:356:b370:a0ee with SMTP id 5a478bee46e88-356b370a395mr19267488eec.20.1791990255445;
        Wed, 14 Oct 2026 08:04:15 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm59010725eec.10.2026.10.14.08.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:04:15 -0700 (PDT)
Message-ID: <3888af48-339f-4b6a-ae84-88d0ad9caf07@gmail.com>
Date: Wed, 14 Oct 2026 20:34:09 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] t5004: skip SHA-1-only test in SHA-256 repository
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Todd Zullinger <tmz@pobox.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-1-04c24e1f480d@pks.im>
 <20261014090746.GA1341124@coredump.intra.peff.net> <as9a0znMFrbOm5s1@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <as9a0znMFrbOm5s1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/26 16:04, Patrick Steinhardt wrote:
> On Wed, Oct 14, 2026 at 05:07:46AM -0400, Jeff King wrote:
>> On Wed, Oct 14, 2026 at 10:30:27AM +0200, Patrick Steinhardt wrote:
>>
>>> We're about to fix that typo in the next commit, but this will also
>>> uncover that the above test case is broken when running in SHA-256
>>> repositories. The extracted objects are SHA-1 objects, so extracting
>>> them into a SHA-256 repository is not going to yield anything good. So
>>> once we fix the Fedora-based job to enable breaking changes, which will
>>> make tests use SHA-256 by default, the test will break.
>>>
>>> Fix this issue by adding the SHA1 prerequisite.
>>
>> Does that mean we'll basically never run the test once Git 3.0 shifts to
>> sha256 by default? I guess we'll have a sha1 ci job (like we have sha256
>> today), but would that job actually hit all the other prereqs?
>>
>> If we instead teach it to use its own repo, independent of the defaults,
>> then we could run it everywhere (that allows all of the other prereqs).
>>

That indeed sounds like a good idea.

I also wonder, though. How many CI jobs actually satisfy the 
prerequisite after the change? From a quick look and guessing via the 
time it took the t5004 jobs to run[1] it seems only the macOS jobs and 
on AlmaLinux 8 jobs run the test. The linux jobs don't seem to run it. I 
suppose this is expected behaviour.

I wonder if it is worth mentioning in the commit message or not. FWIW, 
the "not a lot of jobs even exercise this." in the commit message made 
me want to confirm if this job runs at all after the change.

[1]: https://github.com/git/git/actions/runs/38526140649?pr=2445

-- 
Sivaraam

