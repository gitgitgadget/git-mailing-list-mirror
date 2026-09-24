Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53033C3F4B
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261896; cv=none; b=CHfjyfLf5OK6ONPQ9/FZLNLCRJ9E0IqdX4MpMXa9HUmzZTMjKVF6cxdCtYwH6Ef/oIikCY0Q1o66L6iQEGoxmPCTY/BbjxZ8I/W8fi6nHZfIK3oUrEQ+irwv1PUsBgBLXD4qeRll0G2tEGncFLAQDfhwn6FJQHHOtKLd71xJJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261896; c=relaxed/simple;
	bh=/NK1n99OfoT93QOebhOWEkf7hDyIfSAgNOguDVo4NHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=lbRqjalhM8FLcB8EVm6phuLnOXdnDLjjMgyEZb+VgjBNFsrOjycdkzMOlWDhaUw8+mt2DrBoEYyqXuqgyP0J1wXJXLvQxLaeAhLcgDj+bQFXFaDO+Y0ZNnWMWbozJbfFtYuThuucDR3YkBZ3nA+q3X7svmCg/VpRtsW6WTKnAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRVjWePO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRVjWePO"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba92so1704710a91.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261889; x=1790866689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G0UFSfifzrHn+fi99DITaNHbnFfz92XSexVXD0dwzmA=;
        b=VRVjWePOJhIpzYIpxQqYLI9n1uicawATVXBmU216c8RzN5Z/hOiM+mlIjiJdL7uuID
         DXVA2kMf4RfLv2dE71sEmBkfiPThvQigjwZYBlgL/A+NBM7RyrXIVK7+DkNZzWoOv/3p
         MNXot4a67xh3dK+Err9/nQZXRNYSsU2VbRzdbJNEZkFBtfhtDxLMuIUHu0g5DkZS/Wvs
         iyEGtTl7gaH6E/9oonrw446XilKJ5VewRcYZK7FfCCsqUFw4riq0fqrbND8/6MY766EJ
         tpMHL9zgBJaG42wuoSFaLmYq4puVeJESiypchfIG6vLjCggycqZJ7igboy70cfeiDIcR
         N3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261889; x=1790866689;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0UFSfifzrHn+fi99DITaNHbnFfz92XSexVXD0dwzmA=;
        b=NgV+70kTstMuvy2JPLUGKA4BOnDfivKGK25Zj2xJRVN1L4ZZfOl258CBODe/QeBS4D
         boywKs0iiqZLSGhpMJXR+rHkWM1ydQd1f70Harj4qrLCqKMBjFm0WuaS84lqAbrDYJhQ
         7ZiMyJh2+fEWvbJAxaM6NBgXf5q/ck0IBEQt2q3FRraaqpio+kfp/3/Rf/VU7LiEdIpT
         oGXHC5PlVbccNMsEoxeTCSUkt3HmzbEzEOL/NeFb1t6OKM6/N2XnxDuSxHDcUD8I+jSW
         A6xcr6Vm6AJ2eFN0WEA5ZgZ1EbVNenZ7j+TkAew5KuNnpV3TJq+vWSljW6clXjlBg5An
         nV3Q==
X-Gm-Message-State: AFuF++nO9koyc12NHlAUYQg2ui6tZKbY9m4vTZ4ifP2cDTuKdweXK8hD
	d5JGrl1aYpWkJJhbpx4QLdWyn1PGsj0HNxlAq2vTe3xYhPi4K6TDPiov
X-Gm-Gg: AYBFou2eji4S4hA7T5bjLVPwtIrZ05u5nn+2Tu8n+h9y/gKGMWSZeBZyBtQumujmZ//
	3/mh/L8dxWm9L4bhaSFRs5Re8QOCAGX/C44QvF7Qg3hyYaOC2EZcCBrTWveRL+gcbqOPiJdypDb
	AgUyl89Bs9eTiv5BJC8WhIiT5KMBBlB+6rGIFF+80odRHRg5700z+56lMHFPh61YY8Y0CZ/UqeO
	/Q/WOn9P+ZlM31/JOsnitO0yG/F+6kGs849tYDKTDu82vosD+3Vy2Wg7dpIUoEqRX9s6EsUKLgQ
	ZLAM/4/VCwhQM+OQd8OLOtp0oIJIb7gcAUqOnHKLZcL0qpnheJUiQcYEtRKnPBpVrQjIZVw8PR5
	8Qpa6mEO6++bP5HjGMw26/Hka74CUDKrT1L6GMHQgTmJuEEg0W0MYDspvpbxOkC0qcHvCpyimO3
	l6nHJATC9WNPx4khQE9PEicjCdbNsflmEbCVJtkdMf+y+Eaphex/rp95wTg15L6Y+e+SnwgA/8A
	amB54PfGznJTA==
X-Received: by 2002:a17:90b:48c1:b0:3a0:7d5b:8d55 with SMTP id 98e67ed59e1d1-3a098571114mr2536298a91.8.1790261888683;
        Thu, 24 Sep 2026 07:58:08 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0813318c1sm4119419a91.4.2026.09.24.07.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:58:08 -0700 (PDT)
Message-ID: <067c83e4-7ff9-4e2f-9ca9-2592288bcc93@gmail.com>
Date: Thu, 24 Sep 2026 20:28:05 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] t40*: modernize
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
References: <20260922202152.842793-1-markchucarroll@fastmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <20260922202152.842793-1-markchucarroll@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 01:51, Mark C. Chu-Carroll wrote:
> Changes in v6:
> - Fix rebase error to separate commits correctly.
> 
> - Link to v5: https://lore.kernel.org/git/20260922143119.3313620-1-markchucarroll@fastmail.com/T/#t
>

Just a tip, you might want to use the --in-reply-to to mention the 
message ID of your previous iteration's cover letter. This ensures your 
iterations end up in the same thread. With this, you do not need to 
manually include links to the previous iteration.

Example of such a thread: 
https://lore.kernel.org/git/xmqqecfez7ie.fsf@gitster.g/T/#t

See also, "Sending v2" section of MyFirstContribution

https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

-- 
Sivaraam

