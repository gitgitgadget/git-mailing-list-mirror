Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205583;
	b=O1I2yrPCPUGxQI70FPu5hvX1nWAo4IImcLgnqrg02hukuqvQ5l6nBpbN5QcXfEtKSW8T
	 AnqvNRct1T3UEu8/i7gsxJG/FNOVAze157SagtX6mjXMSolNEX8GqODfX0z1aO/54F4GU
	 Oaw89Pqe92mV6Sf/iXMcYvyDvI7DcbNiKywCemN1pVbdjOTM889U+xDSLEg8XdVjH96RU
	 U4XUL09DpoeWiKFqCp5ehKUdtCeD+nTe0CTq+GFXAx8E5ovTYV/ONh/5E4xB8H1xXVh+f
	 RPksnr/ynkbfIolPmYoeeAKDBmW0/lFH6WlAf0mfTwWvTOl9TKD4+6KUBDZmd5UKgPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Z+LTy7VR9zcY5ymgLSa54MkJCl2jaaelvDouQb71CVE=;
	b=SrtWlGI2GKBhe5fuILfFa3fFVEpr8Ibp8Qe1H2VIG0/zb2sB3kqusx5f1Mr/uw3+HXFe
	 RoTG9sXMbPwfGb3U4lueaqmziwACO4X0aaERPGUTJdORC3WIiTRB7e5pld/bChoirRmBr
	 k2NhqeHpInP+5h1/gozafn8Nhdtgx0cC32MVDx3ov+Ys9N82dEe6o3CDoKv2ABRxFf1Z3
	 4ocIsN/ik5ECI7WLV6tt+c/+vuQ/cn80ygmUtl3m7JXGrWpFuQ6+anZNtAz9SyFd9Yt/J
	 E4nSI+Q4slK5GGrqnJauDN9P3zla7e432CBN1mi8kVkI8BpJIOPlocpBdyh18lliJ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+sS+Ed9;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CA606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+sS+Ed9
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so633283f8f.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793205581; x=1793810381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z+LTy7VR9zcY5ymgLSa54MkJCl2jaaelvDouQb71CVE=;
        b=K+sS+Ed9a+cat71pgr+ebXxOc22j3Hjcxo++UsnGU8zDk1YEA1vUAg2B2zfZowEufb
         MMYvfkVTVmsVrmeV+pug5c8+C2rVpUMRvG9gzojnmVZ8gxfwqjKHg2Vz/Ju/hDroAvdS
         Ahi96n29Jf8dc4OP+LcR4Q4GVCVWf5s3mszqvhGouCEGjpzNX26Tnr0iIx99Jn/HuA2G
         hF3nxEdgzEOsjRsUXvE63h/tvi7G98gr6Ci6cYOQ+QIsRTzJEWIJ1IyToM0bM945YUur
         lBHBo6Chl46KO7EGP5X8ujSRHTH2LgEW5vvds+Iqz89OoFqR8KTFXTzhbLpDr9YmhlJ8
         15vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205581; x=1793810381;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z+LTy7VR9zcY5ymgLSa54MkJCl2jaaelvDouQb71CVE=;
        b=u/btWR/NgKmwFFMTJkbjSpv/RhqL8If0qJ9UTmf67TsHCwib4wuXTu0ZFyZDeyxHef
         /zOam6vOzXTRV/BN/L33hK4oLxLgdN4abkB2ma/1DI9DCXd+wspiKF1p07JmlzX+bYKS
         FsjSATbFRURxWNdq8wCj1r7i3Eu+2fFmGLBJ6il9a/NFogBvZumPiOEuIdJCLBRge7of
         tP9PkMHaEjBxzGhFA218Yc0xFj52kKbXF5qg10Dncs46XdZIPD4Z5iRaII2os9GhGjcU
         8SIWABuliUJ/aPXd78H7J4Pub/7iPvzAfYujOUvED36cnSOx8MHYsXTCcyQdh/rlsxKR
         snyg==
X-Gm-Message-State: AFq9FYIVhMwSF567sszj/yk+Icha+4KLvHSHUE49cWzrtLSIuPkg+8AE
	G+aHkBRT8UqlJPq5n/ql9dkcXDnt+h95rP2bRNUPEglo5easE7GEt/xs
X-Gm-Gg: AYBFou2xT4tOQNwVZNATzZ95q56jL0gnSzksL5kH3Ml0/ASEORLBBSt+oc8v6yESYpX
	uedVcKPyqoCJm78gYcTm5LCfg7C7ec2rc6W7hLePkbHGacEnUMoGrbxcYsKef9PUMMptwUF7DkB
	5yUaX7mcAvQQNBgRuBNdlXL/UPSZ5sf3nifatihaY0pE9s3WL9esaNb39W9FRWCMqOo78LPsIWc
	amsUk0InRcyy+FfXidRDufg2VPEpbmvmGrLGDb84wvoNgnR6mkA7BCnzDh5nG2WakiSKpqgRnNl
	WsH6gWUuv5Udm8h8Z2b6mqEZmiU9lR3L9Y3I0F9t88YTfjymsL3amsNFEZt9xw5SPikwhd643j3
	ZwVJrBLDW0stn6tC//SHfpkKAEcucanfF9GjKpkLtNVIV/s4hjstwDCuOhsfRUnabg12/kGHi3d
	SyNXqvs7xFfiYIqGrDMU11S7fzFewdA4am9gZI2gK9MrtZrmYwRWkcfnP1FZfDVhP+rsQUPUne8
	fOW2L4bkKmbRSuqoy8C6FZbE+k9qSX07Ky6QMkPtCREVwtyE2AP3nx/yU3rjqiL6ndYDUjtxqvO
	LjFez3C3CdkI+q+7lv7og+1L4QovNjCU/Og/CL7qL3QScH7dqn00IwNGjQ8fuwE31FguCJ1HAvw
	UO78XY1k=
X-Received: by 2002:a05:6000:4a06:b0:48a:f404:695e with SMTP id ffacd0b85a97d-48e5d5cf41cmr7138276f8f.50.1793205580845;
        Wed, 28 Oct 2026 09:39:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm30133799f8f.9.2026.10.28.09.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:39:40 -0700 (PDT)
Message-ID: <0806471f-957a-4f32-ac33-c00c25a46033@gmail.com>
Date: Wed, 28 Oct 2026 16:39:37 +0000
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same
 signal
To: ian4hu <hu2008yinxiang@163.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
 phillip.wood@dunelm.org.uk
References: <3f939144-d4b3-4bc5-aaea-16422450d638@gmail.com>
 <20261028144736.121433-1-hu2008yinxiang@163.com>
Content-Language: en-US
In-Reply-To: <20261028144736.121433-1-hu2008yinxiang@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 14:47, ian4hu wrote:
> 
> If you prefer the thread-level fix, I am happy to build it: a
> git_pthread_create() wrapper that blocks SIGINT/SIGHUP/SIGTERM/
> SIGQUIT around pthread_create()

I think that is probably the safest solution (though it does not help 
for threads created external library code - I'm not sure if we have any 
instances of that). I'd be interested to hear what others think, so I'd 
wait a couple of days to see if anyone else comments before spending 
much time on it.

> - leaving SIGPIPE alone, since it is
> a synchronous signal and blocking it in workers turns deaths into
> EPIPE

Does it? I thought that happened when its disposition is set to SIG_IGN. 
Blocking a signal delays its delivery until it is unblocked, it does not 
ignore the signal.

> - plus a sigaction()-based chain that masks all signals while
> a handler runs.

When I wrote my last email I was thinking about blocking the signal that 
is being handled as sigaction() defers the signal that is being handled 
unless SA_NODEFER is passed. However, sigchain_push_common() sets the 
same handler for all the common signals so it is probably safer to block 
at least those as well as I'm not sure all our handlers are reentrant.

>  I would then drop this patch, or keep it as a
> separate last-resort series if you think the belt and braces are
> worth it.

I'd be inclined to drop it - if we're handling signals in a single 
thread that should avoid the issue.

Thanks

Phillip
