Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E03D4111
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925144; cv=none; b=oxcZtwvN/EJAVPfdxwr8yo1Uqd72SiANfDtCxveKEUrX245yB96LQXtMqFWro8iQICyzp8YE9juCMtfl6UQXKtCtykhTNEeE/YXixJ4gUlqUjseNm9NUkWl9fnzxcE+jLTBo/TUUJmqW3w4BYkUDS1WYZXLnmlV3wwUoqR7GN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925144; c=relaxed/simple;
	bh=9ULd1JeKlfjGSzBcmqc9CriLzXZfV4I3i4hWq1kj0S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkVzyidSdH6K2XLyELc1itCgnQsOffTvBpBDPJUaiuvThgOrG3ADougLTCRrxkRhplIlj2wlmvyPFfLaGq4Vcxy1Y2uVsACi0SbnVdpk+CGIUCBOzv90uaYr6TB9Tln/3T4hK0y5YPLEPDB0+2Cd/YGfGcLS+5Vt0QfdzyEc4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoBVf5pu; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoBVf5pu"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5062fc5d86aso4931391cf.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773925142; x=1774529942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miqGi23S3IRdYPITokY6hfOiq6ZCKv2F4WiI3fg7HjM=;
        b=DoBVf5pubV023hvnuf7ozde8JSdDfqpuEPgDOLi3fx2GC9Ri/yJoqvbANxLGIO4SNZ
         h1MsAOjFkG0CKH+MCcfcChEtNnWs5KuH4UtrhjNCLmed6xYLILvlp8Mp4IHOOOrjRFuu
         eiW8mUIqoT9f3Xes6sPA9QCyiZA6huxue/tgj84NBeY1H169NVbbb5Gc0vsfOgcyNoU5
         0ABRWApG4L8zNDh967OfNAR/24MiOZTopgAYRq6E2Qu/irKMOQYeaSw40s1SGg86zZRm
         E1plJ2bO1iQDB/W+PwsdpdQ+FfZUXS0ZBzVnCI5auJmgPWLYGuI05shQLK5XWZf26bsN
         0uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773925142; x=1774529942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miqGi23S3IRdYPITokY6hfOiq6ZCKv2F4WiI3fg7HjM=;
        b=HqyD/EoaaHAa8m+YI+C0aOjKDQpAGKK92rrImAOX8ku7Lyk46q66E/tjoz+Ma0UAYT
         ii/WkevV/CeeuONghPYPlPFxz/TzQRyxmF3ldgcUsgKbzKzDaHjXKAFmnIGyRzJNWnO3
         RFOFOIjiDen3rfe9SHxOUT7G1wVNdSQhMrsZxAnuwuP5dbaNzsUA5hOrmZaVEw+bB2Rx
         TJTdwa300Un5vd1hkPXfCJydRm1dAG/LclNCjFlIDtVRusszlKZc4hoqcpN2l+IhLIl8
         4J0QzDnT2lQHuL7Jcywan+FOEWG8ebKUDu+NcP0ZyQwmQPDSgOWYxIkDwWHWNjMtQUSu
         assw==
X-Gm-Message-State: AOJu0Yzgr0rVMlazLeSpyqG0h2adQ5YSlpwncYFQ3Yx7+lFalDu7pPSb
	Tt7ePZ2LrarzY2WMTLVYQV1p+6ukn05cH46lh05ehRDIjuQ3EiTNJoA4ossOfQ==
X-Gm-Gg: ATEYQzwYSODQneAGFdNrhfwUlcHAVZ1QLd4ma/GEz0YOLng/CZ5aIhsoSBDzK3CNP4V
	HyAxX16fOvZl2Sjpp096dOmPZcCWjEZ7z2YpKfA3Sup2rTWUSqeYU8Fxiu0ksHJ/bHzIleEGZih
	YkOcEy0R0S+D4ZJpcS/rCuaUVwVF7wmNkdtuk9TCaltqiSr8TQbZQ+EtwitabmJmFDKM0By/PPS
	sr4YtRpQyvAmd7uUUe4uVa9KSgx9paMRbaekKpTEdVPfWPgogredZ14il0/xzK8fApdHC/8ECVO
	IQQ/tr2EUe7jkM2PDA/Fy4ALCSaCSnTxZ2jOExLofdcc1N9EBXxb+JcSvH/QYCjfxaw88D8p1Ky
	Ecdvm+OyxQKquorDqcw65nF7f+yAPi6u39lNES7UEJxubT2gwlQPsQrMYe8XeqWA3E6dNGmYf7c
	xTF4+GbscFScQHRGZHCasJSvhki2pY03fuaRewYGs45+LKf+22pzUi3VgJ1Q9ls9ndK+LDug==
X-Received: by 2002:ac8:570b:0:b0:509:1339:3dbb with SMTP id d75a77b69052e-50b148943b2mr94643581cf.48.1773925142279;
        Thu, 19 Mar 2026 05:59:02 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b1359871fsm46476961cf.19.2026.03.19.05.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 05:59:01 -0700 (PDT)
Message-ID: <29ec9e5f-ad14-4a87-92f9-a3ffa4077f69@gmail.com>
Date: Thu, 19 Mar 2026 08:59:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] backfill: accept revision arguments
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <abvH29wYAFzk6V0F@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <abvH29wYAFzk6V0F@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/2026 5:54 AM, Patrick Steinhardt wrote:
> I think especially blaming is a bit of a sore spot -- downloading blobs
> one by one simply doesn't cut it there. I wonder whether we can easily
> use the backfill mechanism to fetch blobs automatically in git-blame(1)
> so that the user doesn't need to know about git-backfill(1) at all?

I've thought about this a bit, and I'm not sure that we want to run
'git backfill' directly. Instead, it would be nice if we did a "staged"
algorithm for 'git blame':

1. Walk commits according to the pathspec to collect the commits that
   changed the path.

2. Collect the list of blob OIDs that will be needed for computing diffs
   for the line-tracking algorithm.

3. In batches, download groups of missing blobs and then process them
   for line-tracking diffs. (Stop if all lines are blamed; continue to
   next batch if more lines are needed.)

This would be a significant rewrite of the blame algorithm, though. I
briefly considered this approach about a year ago and decided it would
be easier to start with 'git backfill' and see whether that satisfies
most needs.

The biggest reason to maybe avoid 'git backfill HEAD -- <path>' before
_every_ blame operation is that this will add overhead on repeated
calls that may be obnoxious in its own way. Maybe doing an opt-in
'git blame --backfill <path>' would make it easier for users to opt-in
when they want to.

Thanks,
-Stolee

