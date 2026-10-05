Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49437F326
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187432; cv=none; b=rjy8QHfrOFaYwmGQhM1jwJP4Dw0qI1AUO6W0Ewix+C4ZhqQ59Qicde6oDIfQE2j9v7pZfi/o570ia4VcxdIsw/5i1Vrf/iTIY/Kb9SoEVAp6sYv6Wg1gNR2I+Dzpz4UrZ9s+1WBT5+2ivf0r5xWcLBodQxMYiU3T5mkOgqZBJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187432; c=relaxed/simple;
	bh=nPYp79zJh0ekTz9ATNhNC0Fitw8vgGdUem9LEkgKMuU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mHJJzhgoi3GdLOl9LM1JpCkYIqFyWgzqfMXpLU4mbE8bHDjcnhF7h4c/XbN0kiQBvGcDMikBf+QMVxDGrv5BvoNbneP0azn6MUCX1TyieHaSqLmhJxDt+kl9tKXfcaJZ7ojfOX57u+53G4mQnaL9Cod81mfqil6MFLKeK6Kq3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALTkYVyG; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALTkYVyG"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so471867a12.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187430; x=1791792230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lxy4eIqwkDt59NjBdrdb0Z7hGhoOi6lljoUwbWc/CKs=;
        b=ALTkYVyGS5QyLbUCAe0bn7qIvo/LzLvomtaUWCv8mfbQfoQMczI4n1F3PNJWDrb6fN
         Nlx8S9o3Ve1nZ6l11J3feVcCHLbLdMcJ5J4ehOcr0sa3+r0TQpQrHYCmIDmKRVGBQ/G4
         bOKIxQNLR4lc14t62+i4Ga8XCGHCKv5aHEQhx980MaOomlOHmbwqIn2Augg8WVROicpk
         Oy+Pmwco5tmMJGxQgPWC8sg3Cnub0kbDGCJK3XxfVEYuwBJ3Vsz0ngb0L6q0lfKDpTNM
         /XTcmxGafHzSJ0DEdRVRAf+YqtNZgBhwII3SvpgWhNeDz2j5xj/Am9cplvYGwy0KJLi5
         s/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187430; x=1791792230;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxy4eIqwkDt59NjBdrdb0Z7hGhoOi6lljoUwbWc/CKs=;
        b=1AjaWtDj0uG/EEr635PbfSggzBUG+C0Nf88JckvLTdgFDKv6kGqFMtjNfXi0NuPS8y
         8T7eMSgxN1bKPqyVK/b06WDaVXNP/zGwm6AJWTlQ2wtSBKB88RIO7PCPTZ4Q2CGGj37P
         39dBcCg+R+XsFHfmKLGZ9hDWvQVcKN3e+HxatkdC1CJmwYuEZdo9nW1l06qCDQ7hlyiS
         zGuCOKV8pQPLy3GujQW5VLxktv7Wp/7TN1JFVFiQZb6BqUQXMQKrMqhAX63+kWfL+3pY
         3kqJHPrSs76HiHdzWP084iUK+ks7cs/uZWcbbDOjuK3KvUFEIspfwByk0c0JO7mJpBvb
         Qe8w==
X-Forwarded-Encrypted: i=1; AKwUvBx8fTl5obg7SFUdAH1E1Ds2CZrUu0DO8vW79VmuDDSJRW1WGAv0Tyw9F/ZcRdVnURHgKDc=@vger.kernel.org
X-Gm-Message-State: AFuF++nCZB/wjRhghwUBpb63YlSGrIfgdvww45GL/GeuTD8HJYY5/T0x
	7afaEnKY0Y4xDDRrm2CNFj+zRneS1LxsqHQJTPfduLbwLur/isg5/Eb2qbzS+Z4M
X-Gm-Gg: AYBFou29WBD0J/htXQOht+jXAtYjgW7I7fKdXKdQxz/nozWKqNkebccJFKWnwaK12v1
	AamnzWn1SwfP6/PCxfnModK3Dbt1XM2RSQnOJUp4Au758damkaCtPjd62CEw9dsOkzi5xOUflno
	NDTqfd5rL2dz3aUTnWKGbeQOoSF6whGwFbaSABvBdwLsEuLO7hCNMayAdymhwwlm5WyGwscvqCw
	4uN9ogPW4FaxtLkdXmIsbPBwbuupKJiPsWE8zpzD+S+T3aARMfPDfAjUvNUyY6jY9jaW8GAbw52
	YrkqyWcCJNiW6g1rwrTbUyICTAwp1Fi5wxKgTTIpOg9YkRr9mWa0hG0qy5cO6wSkVLLFIh1ZZci
	S1r0XF3wnsNjOGmt7C9hxZoX/xhrNP98kQGQWmfojKYFauZiGB7+djavMZC1O7ZYrJnAkmpOhkR
	UO7cNhk/c198L1FM6PLduDPAVHGx5jENclpW9OdEYZScodXJym6GmOp2AWdgYAd+8lW/8Ei/ByO
	JBcyrgF/4jR7x0=
X-Received: by 2002:a05:6a21:e10a:b0:3dd:85a8:4c5f with SMTP id adf61e73a8af0-3e0bd2283damr10047648637.38.1791187430056;
        Mon, 05 Oct 2026 01:03:50 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d8ffc38sm416199a12.15.2026.10.05.01.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 01:03:49 -0700 (PDT)
Message-ID: <74b22ec2-280e-4fca-9f5b-c21a7c12a78f@gmail.com>
Date: Mon, 5 Oct 2026 13:33:46 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 1/7] meson: avoid recompiling HTTP sources several times
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
 <20260924-pks-meson-improvements-v1-1-90b7f79f1c4e@pks.im>
Content-Language: en-US
In-Reply-To: <20260924-pks-meson-improvements-v1-1-90b7f79f1c4e@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 19:39, Patrick Steinhardt wrote:
> We only link curl into a subset of our subcommands. Consequently, as
> both "http.c" and "http-walker.c" depend on curl, we don't compile these
> into "libgit.a" but instead only link those into the commands that
> depend on curl.
> 
> In Meson, we wire these dependencies into the target executables by
> using the `sources:` keyword. But this has the consequence that we're
> recompiling those multiple several times, once for every different

s/multiple several/multiple/

Rest of the patch look good to me.

-- 
Sivaraam

