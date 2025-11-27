Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A22DA75A
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271493; cv=none; b=QEBRvgUSAkaY5ajxU06RI9UCar05qKgCkPuWLr+U0d+WMf4llaN3PUIUCdePun4iLIfSSARVZlv+fQBEtu+Uk3n4tQjpx2pe6uEBn/ZJJnDQdMvMpQyDrPwloGClPjY9kPWMKa5NkMgNwePywaOs52uKjg1DLYx4FeH/SODPKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271493; c=relaxed/simple;
	bh=np/yfKeN4+VvYz9fpCtnUfKkCdH+bY+yU8DAOLy0O7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEcE50BpVtSnF9KT/osmJyEQcFXnPEB1dXEn5gN6aae2KXNc3goz3tg1wI3iVt7AYb7Tdn9d5tLLWiY48fLm5gUsV6/DLA1AIZHJCW+tuwhRJt4EmH2yXrWuRMNArf+K1Tfw9L8prVzbgIRbMwGSIWN5OFr+t+53ObSF19czbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C51Rz9Oz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C51Rz9Oz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e239baecso16051265ad.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 11:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764271491; x=1764876291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjLx5uKNQt4plgDHjV+Nn/kW46Feqp76lTM9YTxtOFY=;
        b=C51Rz9OzY6VfEMpe7HQr1j7Wd2kIldWO8zyvWIzWOCgZL2cxXEW74QrXH4tBqcwGuA
         91HoNA+t//icoyxNsKhfqqeI/oA4zmmGwT8X9JzNt7fV5WKXtWc4B02ywdtdLGtfebos
         1cfe+4e9IeP2aTCMseTMLvZQG1sX9zDLgNDPc219Cro1h7hwYhIN6sxaNlgb6XNxbpZD
         S5CSlFvYjgBKco+MbremXv/KlYqlyyjkgALl6NHn/g4dFuMCIc52asFlTbYVy0rXLTCf
         /VVdtP14gyR4nNIKvz2Lnn6KHO39u9dc3fZgZ2VzzTCRurxoPlbISHsF1ASLSmmWQiul
         xCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271491; x=1764876291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjLx5uKNQt4plgDHjV+Nn/kW46Feqp76lTM9YTxtOFY=;
        b=GKRqNThGIg1eqNEtPeQLycZ2yHqCTbYoDxj9Bo0QzLqczOIG7QEIyHh/QIcNEq0rvZ
         j5gkBqtSPt0oska5AfARMBl35QuRm52jJSu+R4ydT69mebI+Usr7bORO/v98IC+uKm3i
         It1lMivZW4Jhv5IZ/ECMPqMoTBXjHy9iQX9oXBGNOgqFlP1rC9JFCHnfvpG6uD5TGBmt
         SRtaYmQOlXM+f82r5GsWnSgE0Qo/x2y5RjW6tNPciSQKSxJtt9XZXaYEmnfHJFXHoaMp
         c2m0aQ5CwjEbahUE1iQ7nJeyNZ5GTvbTETkLHNbKm34lNY33jIEbfj7kW5cuVc0mH0w1
         eFag==
X-Forwarded-Encrypted: i=1; AJvYcCUwlpbxNtdZfHxQapepXDlxFElhnes5mkjTUr/kCt2svrT+OOuMdVu5JvjTaQUL4o5oU30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucGQduvOc/r5NeA3yewOsbmtxyVBFcFXacImzE+71VUNfPk2x
	gAA5udjgO1kJ7s3glbqo109rHqX9DSLN38+UZW/lGmEvFuKi0mloyEbj
X-Gm-Gg: ASbGncvb+nd5C4T4dKDBaZPbYn8ATX5vKqwKSV3LzF3Hh5CMk0WRajN5bFkdD147Pxw
	VVIkwFwgSRQAxvrgI8libiqtRbmwUbRn873aedK+zjpukRE7kEvb7HIosUPmGWkBZcb9OLrB96q
	JOrTIpykkTRCuXFGkLCIRSSPGnbTkDNB9K/Rt0FpqrGo3QYjd7xOyOvvhY6GYVYK2jUkRigBToE
	AonJ2aiHmiZ70yPq2BHKIXqwn1QTxySVepHH0tJld9O7/ucxF4fXTYNcYoFgy3c/f8P1XMLPi4T
	UsTSTWV28mgE16kCpvcqYIaRwd7RDft4vsxlNDRp+Yc+HBP//jqwED0EuC95gjXIxt6rMO2V+yh
	hWFppvuC9J5s7atbdd0INs70wdTS8fmntiJopObmRZMy0IiPBpMIt1n3olcNHC05ylGnMrcPS7r
	j57L3M520qRHAk09sNGKdacp/WYSmCS5Gs3N9VMBR+4Kpxp3FFD0dKM0O6fEySpi+qYRRdEkDc2
	SYZoDBtmP7s6UW8A6Nl/KdNB7si9BRexA==
X-Google-Smtp-Source: AGHT+IEAMPjyNbuUrZnPQHDWfm9Su3CGjMpDtk8ANpL9sC1Tg3Iz35O2uFeloIRGtlPSSKkadoNNvA==
X-Received: by 2002:a17:903:b87:b0:298:5fde:5a77 with SMTP id d9443c01a7336-29b6bfd5a15mr222838635ad.22.1764271490925;
        Thu, 27 Nov 2025 11:24:50 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:a4fb:44b4:6c24:a31a? ([2409:40e3:30a4:b776:a4fb:44b4:6c24:a31a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce4415bcsm24452345ad.27.2025.11.27.11.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 11:24:50 -0800 (PST)
Message-ID: <20b34c44-a04e-4632-b69a-586ac7c97aa4@gmail.com>
Date: Fri, 28 Nov 2025 00:54:43 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
 <38b51e19-7939-4a5e-8ad0-2d8168bc0fac@gmail.com>
 <bc974d63-b3f1-4ef9-8fc5-e7e719b6ae89@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <bc974d63-b3f1-4ef9-8fc5-e7e719b6ae89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 27/11/25 21:51, Phillip Wood wrote:
> Hi Siddharth
>
> On 26/11/2025 19:39, Siddharth Asthana wrote:
>>
>> The realistic use case is reverting commits from a branch where those 
>> commits already exist. For example:
>>
>>      git replay --revert main~3..main
>>
>> This would revert the last 3 commits on main, creating revert commits 
>> on top of main.
>
> We want to be able to revert an arbitary range of commits. That means 
> we need to give --revert a branch name to update in addition to the 
> range of commits to revert. The following example would update "main", 
> reverting all the commits from the branch "feature"
>
>     git replay --revert main main..feature


Makes sense. I will restructure --revert to take a branch argument, 
making it a proper mode alongside --onto and --advance:

     git replay --revert <branch> <revision-range>

This keeps the syntax consistent with the other modes.

Thanks,
Siddharth



>
> Thanks
>
> Phillip
>
