Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834A18C035
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481006; cv=none; b=Au8vBJ6dh8UcepM17xm2/VeirjUEQoTUBvWmyShQv0SEQ8Skpkdlfc4FgNhbYKm1hK7cFLESZwZ6RkdctplLeee3dEXDUaA58q5BkLv4OncsoinVVaszB+xwNpdmXTNa421rs78EWWgbuLT5n1OGhCnuvwmgre/stoBIFGwxRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481006; c=relaxed/simple;
	bh=AIGReduvXU6kGZTW0XtDcmrKKXVX48O2/5v7P95rxkA=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XK0b+YNNo/J0a16F1ldTIT+X5Jv2pZCmQlaysFfKis+m4+QwFHeqTrZyv27cR3x9SwqQ5nWUz03MEDNdHeew307oMe3BIqqUSCVbQvY1cCx282O9J8KA2FX0WJRVmwWF+Xn0kJAwFxUvtjiJtjcBtGev4hm1UZiY6E8kEFw+DFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5LJIVds; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5LJIVds"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c58974ed57so295302185a.2
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481003; x=1745085803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chkISUzMddH5HrwgThBYLHB8WuKF3h+gOD/MeUrvW+c=;
        b=K5LJIVdstkJ+DveADRpfq83zapwq1Wqw695X8v7kSa0a1N6HN6LosNeUvJNW7pYTC3
         +JB61NTUVKdMJOK48XUvl+VSHOqf42t3D3/Am2E449LmyE3YaK8QPYP74r+gFq/2xb0F
         5u7TzVX20ucTbJMsP5BQpgxrH7wOHgRlcye0m4qugNYeyT+mCFtEmMTxsNA5FAs18g/4
         FmZe+4ZbrsKYRdWjL/hk8vb0PyqYF4m0cM4GDHXA4B0TiI+GG9orW9YzIDH6LNorUjLr
         8uhUvrfKFXlweoQEHx2qinDWi26pfbJfrQ3JzpXuRt+MTkXVYdIIrF+Fdy1E5RGNo+3N
         Z4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481003; x=1745085803;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chkISUzMddH5HrwgThBYLHB8WuKF3h+gOD/MeUrvW+c=;
        b=kzfT9m+39vF+S3ljoFQB8wVEORX2R99//IF8J6jyQzyPFT3XwqGnJRZ8zRVcrp5jw9
         OsVL7x9lGg9vGqY6ljRUoVmbea/SJTAb2kyNRzIaCpyI1DKjkzhIf6ePW77fG4owTsed
         tQuumXEEFTU7Bi4SnXpsMaL6Pvn/qP5EQ0pHzl6jrvpDJDJQXMYKhfbEDpNPLRgKbvNm
         j0R/cBQ5wsMgb6qP2qk81M3EwtjDXGUdEsnE1tpRR4/kqqhBQwV8Oq//JX4iRtkcBkm9
         Fwkd2x5Wp3txBqw5crSIiKSyyPbFVFG9TVjXzAKiQ0odAmqOI3bBfKWPT4raDucHTFXE
         2ajw==
X-Forwarded-Encrypted: i=1; AJvYcCV/eTZuAXnlB/KEYt+z1gOIvnIMT7aKAV2DSoSiGhEJsYoWmJasyOTvxliul8Q7R3+eoYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zlWaE84aAa3M26Pk1x69kiUKF955ZTtezcofiS6n74UVC82e
	DKxw1U7eacrM/ooVm+k6ps0jc8cZUNZ2kfTs2WbpdQxB4qXhbb/+1U4QgQ==
X-Gm-Gg: ASbGncsyuFPOgC9oM9pVsaaxOOu0+Qbv/8xbCSNx+vq37mX0Wm4J7elYgVopWC62RLK
	GQcNs//TbmKGyL3yABf5fYViZog7scnj9mZDuYzVo543FC+lODoMrDjuaveCIvh+c8iG7ioNHiM
	doX9FNgJm5rVEqSz14U9PuOecAEIet4ydMfDTcs2CwY/7PmBzTdEZUEhYN1x3BX4dS8TY6/dlVt
	Xyh+/qOFr6Be6/x4CNcKDalAVYMaWbUr5VqHqIbPXgGh5p7VJf5kD31BTpJPrY/gA55d8ulQuNU
	KP1OAqE9ce5VVWdO6H97krLQBwDAg20YDMBRsMlx4vsSfcSiZkCYjQpE1Hce+CmZnn1zmOAggbl
	hzPxkWdYv2UZ+gn3uCUVhFRskAtJQVUEO8v1iBg==
X-Google-Smtp-Source: AGHT+IFNnYDxhViQo76r/N6x0+olVOnlHXOlaSPZIBOukDvnq3s+gNDXr1AEyrUgizI7kc/oRYl7Gw==
X-Received: by 2002:a05:620a:318f:b0:7c7:6543:2018 with SMTP id af79cd13be357-7c7af0c0351mr1194922085a.7.1744481002840;
        Sat, 12 Apr 2025 11:03:22 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:958c:93d:6fef:c9ba:9e64? ([2606:6d00:11:958c:93d:6fef:c9ba:9e64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8942f3csm440620685a.2.2025.04.12.11.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 11:03:22 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2025, #03; Fri, 11)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmscml2zq.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5a257012-39ff-80af-7d65-029ec250a321@gmail.com>
Date: Sat, 12 Apr 2025 14:03:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqmscml2zq.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2025-04-11 à 18:58, Junio C Hamano a écrit :

> * pb/perf-test-fixes (2025-03-28) 2 commits
>   (merged to 'next' on 2025-04-08 at a8aaeee41e)
>  + p9210: fix 'scalar clone' when running from a detached HEAD
>  + p7821: fix test_perf invocation for prereqs
> 
>  "make perf" fixes.
> 
>  Will merge to 'master'.
>  cf. <Z-pD1puYT87YKAd4@pks.im>
>  cf. <Z_TAtJ9LEeHo2AQN@pks.im>
>  source: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>

I actually found a small error in the comment at the top of p7821,
I'll send a new version with a 3rd commit on top.
