Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E41CA84
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769098; cv=none; b=HpOfFInFw8xRVOULgfvbFj9cgZdmQ3Mg9o8xSIwloK12URmqdEZ4nxRSbhpw8He/1ktWKxXyDcDSXjkd+BeWlDqDydmBjmQBF6XexNl1mA1T1Lli/ACWoANZl0qlnFbRNadbZRjJGTLSIwmqTVlxoCAMel+pameIVbgRUdzaZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769098; c=relaxed/simple;
	bh=TBXe/18dpZe7px65ODpWJdztnLk7YbMGKN6PHtow2jA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qJo/U+gcEn+pWrdkKYir4wU6STZqAS65VOUzNFsZj8S463G1iaOGF7Ozxj5Z0rsNaWLLCCpj9vNVfXEWHcb2fVRZySiI7ZjjAtKcDnslO8KE348Ha83yMLoqsac311E1ShQ1Tipkox9qZTRmVd4Ab/jfoXpk/d3TBSUDngcOHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF1ZQhm/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF1ZQhm/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e80e13abso2788935e9.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709769094; x=1710373894; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQMsy6Q/97LbsfhRzdqnmjhrDeO/i1rXpdCPJ9SQjKs=;
        b=OF1ZQhm/WkwYbtFGKKxfTh88E3Snp7Rt0mJzY+HXsbVN7ZbPsZM4zq8Hbr3d/00azO
         obnNB+kwY6+MkyDM2qxij98wuEm+KauZ+qvAidy96Vzk6nVkI8R64qXyyy4jb8ewefbl
         Eo3zXsrmtK624/wVDxBwyVQCwKDzuYoXqYlSdr0aXjWJpxk5MrqJFjIEGSHEK6NPOZ7p
         NNItNgFOw9qNZbawXc5Pd2VP/KKQh9kP2XA7wnPh77jtSssLVqFZx/bb49utAybZh55S
         j7RvcVNWZ61guthVdodmKw5trjaF1bf+75CdQlkGJS+7slsDv/m281l9PdQTHeWD2bac
         PaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769094; x=1710373894;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQMsy6Q/97LbsfhRzdqnmjhrDeO/i1rXpdCPJ9SQjKs=;
        b=PLDDzj9RG+aNjNvxHz0aBGuUWiJDAv/yLXq5c+f/AgegDfqWLbBPfTkAydOdJDdaRk
         JkQXQcFlHgyvgEJUhiKjivknvzzH+RdGf9xIdwu2oL8eKxXdkE2CXmOOqxKPscSQ+kB+
         PBh3j2Qi3bsvqd36AoMNQbFYTbF/A+xVrQNycOzKWSwBdzsjo48CyotrqhmkUpRH/rUC
         z/vPdA6NxiEy0R8O5/gcgjw3jWdPoJrLx51nc8AOX5x59BD4RG86mG38j9Fds8x4uFJx
         z6q/jblf6Rkze3OxdXdfJICb//8kgFFPLXIogL1jGkYBbzPLPXOP8rrCk44rcNw9SN8c
         f2Fg==
X-Gm-Message-State: AOJu0Yz7S2gV9BiO+E/cHTAr+BLq902kmq7Y6rHfcGqCFZLc8EGcm3FZ
	Jt8aJ1LzwSzRDtWhKo500weviuloQX/rb6wAZWa8U0au9uhHFEpgW5xke4rEZu4=
X-Google-Smtp-Source: AGHT+IEP33y+0nHcij1uCZLcmszA7HlGzvI5pa5953Q3mQeKvQRKTC8YzJ7y/BzRwTJgylI65rGsAw==
X-Received: by 2002:adf:e7c8:0:b0:33b:302:c08 with SMTP id e8-20020adfe7c8000000b0033b03020c08mr11020903wrn.43.1709769094166;
        Wed, 06 Mar 2024 15:51:34 -0800 (PST)
Received: from ?IPV6:2a0d:6fc2:4043:b200:e3b9:8eb:5df9:c0dc? ([2a0d:6fc2:4043:b200:e3b9:8eb:5df9:c0dc])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b00412ea52b102sm705359wmq.34.2024.03.06.15.51.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:51:33 -0800 (PST)
Message-ID: <0d741b90-8307-40cf-b0b3-163203651a57@gmail.com>
Date: Thu, 7 Mar 2024 01:51:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Victor Porton <porton.victor@gmail.com>
Subject: Bug in Git
Autocrypt: addr=porton.victor@gmail.com; keydata=
 xjMEZOOrBhYJKwYBBAHaRw8BAQdA+hStwyhZdwm4hT+azNakoYWDX9HxrZHyIiWEnL6Dcz/N
 J1ZpY3RvciBQb3J0b24gPHBvcnRvbi52aWN0b3JAZ21haWwuY29tPsKJBBMWCAAxFiEETzWE
 FkGWX07H657ywr523wwCDrYFAmTjqwYCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDCvnbfDAIO
 thNnAP4iVDlJffm/rF+1VzXZQvkXX7dq/09Onpn97vmLd34oCwEA1ia66qtessxOTqW3pFTp
 fcXUF5iE2t5uY3DCFsZmUQrOOARk46sHEgorBgEEAZdVAQUBAQdA0H6hs3jIOz01tcCCrvyo
 FgZ/FXAAvFsjDgU6/ut6K3MDAQgHwngEGBYIACAWIQRPNYQWQZZfTsfrnvLCvnbfDAIOtgUC
 ZOOrBwIbDAAKCRDCvnbfDAIOtiA0AP48A0g4+DUzzMY8gs0rfrrosFeDOwQy/9vpuC7gZbmu
 5QEAw/BykABCY/LkxC3PVqyYBZJKqfDx+wgAFHO5s1YKkgM=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Recently updated Ubuntu 23.10:

I tried it several times - the same result.

$ git clone https://github.com/dfinity/motoko
Cloning into 'motoko'...
remote: Enumerating objects: 104759, done.
remote: Counting objects: 100% (5702/5702), done.
remote: Compressing objects: 100% (2333/2333), done.
error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: 
CANCEL (err 8)
error: 1600 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output

