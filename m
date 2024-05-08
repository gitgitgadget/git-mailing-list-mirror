Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA54372
	for <git@vger.kernel.org>; Wed,  8 May 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140900; cv=none; b=Fh/t+5PlObegE0VBGhkhjibEU5HO0I6QXBJm/Twxjjn4r2UBhZZhm+Hin7aQFZp7sM6Qld9dXy2zFS6BF19ecJ5GVYbMC5uMMFtGSl/kfRZ3fSqdWI9CJ77cQmMpg+BtQBVfWfLIMty/1D/Fywx0i8mAaPJUtkzdjuOuZn80vZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140900; c=relaxed/simple;
	bh=hWAbppQCb4qVj14ZLKmERKYIsP2GDO6WAMKgSBJCVPQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LD4wrl4UJzp4v8LknxVLVfdv+oKRmiolMTIZ8TooYi2CEfLbc3AJaF96f4fEdg2sRaFZFoR8xxy1f9YXsMb4HKHfi+jhmrMgreewjQYg4z8Ky5mymDzrhPTGl6rwuvBmTzV0+rJPhmcDrDOBaaN5CTJZAvIgXOZ1eRPwY/8SWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEA0Vg19; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEA0Vg19"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23f59d71d10so1988731fac.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 21:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715140898; x=1715745698; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvc8B0Zh5sMtCiNrWhYpt+vBhrsWanPS2GYCz5gz1DU=;
        b=OEA0Vg19ONg/h0vLTEhU1hatOV6hxPUqylKT2HWF4+DCr5IbTTn9jRma8Dmnx9UE7P
         jdYoP/zwUozsLADXcTvYLXxB3Q4TQmkmtPQfmTR8nrrsYVRoqjJtyGT+qLE5f4m+GvaO
         CS5+8EBu7vib/h1SVmW9Hsg2rgTZrG8Dh+6f8zUVBfuf9CbF62lEdk04lUb/fnWKH/5z
         S5j0oY2kCgQIkjGl5HE0lFL6VrbhP8YWekXlDqXt3Oz3+mN6+UPtuORJRZU0t1aRPiKj
         tpqqvSE5mD68hWXYPIehYAlqsuOhnDur32B8bFiwMdN96QTz0RjfYcjR3AYYtzIx35fZ
         WR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140898; x=1715745698;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fvc8B0Zh5sMtCiNrWhYpt+vBhrsWanPS2GYCz5gz1DU=;
        b=ZaGOiy6fUZHzuqxoUStNHQGqiTar1KMCCfjXIwjJ4Q2R00lROlwkiP8ki1KKH6DDfv
         3mAaoxzTasif1DcQXGF8+u9DvyilEgmbhg70UlhSsGA7ngonXugkIZLJsKH9P6bhD7Fa
         AWUurgWRZ6P+CYIXKgcC4pQYooxhhtZ0WyDHmyKCiB/GfoJUlfp62Xru505/2JY7U0TH
         XkW7RbxnDPWE0e3eikLGVgz1HxFUXQpQOS78Iq1K4BM/CZkXIuP2vLbjDXzYqJlTF/QC
         bKQ/XiG6PaMcfGxHZkLA0dOICj/YdYz0QHNi3B6NBTm+23x0Hmnxftkt6Z9D6LatC61N
         f/mg==
X-Gm-Message-State: AOJu0Yy7txtPM4xcnTnzgu55yDAzOotgMn3WLqJO0soAy3FAsEFWyvBr
	WPSilstN2ovGObZsljrK5+n7nlyKXhRN8ScEpsFFRHt8GDSeshmMgLFnGA==
X-Google-Smtp-Source: AGHT+IEGOXpNNrEBe6U5cx2+JDt8FAcKwL7KrBIB12sEBkTNhSf1HoK3vUDo4UoUk+KKKT1BV2/4aQ==
X-Received: by 2002:a05:6870:548c:b0:21f:1705:d5b0 with SMTP id 586e51a60fabf-24098cdd3bfmr1787116fac.52.1715140897937;
        Tue, 07 May 2024 21:01:37 -0700 (PDT)
Received: from [192.168.208.48] ([106.51.24.133])
        by smtp.gmail.com with ESMTPSA id w11-20020aa7858b000000b006eceb4cb828sm10190974pfn.180.2024.05.07.21.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 21:01:37 -0700 (PDT)
Message-ID: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>
Date: Wed, 8 May 2024 09:31:32 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>,
 Jialuo She <shejialuo@gmail.com>,
 Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt
 <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Welcoming our 2024 contributors and thanking our applicants
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

As you may be aware, the results for GSoC 2024 have been officially 
announced[1]. We have 3 contributors contributing to Git this year[2]. 
They are as follows:


   - Chandra Pratap

     Project: Move and improve reftable tests in the unit
              testing framework
     Mentors: Christian Couder and Patrick Steinhardt


   - Ghanshyam Thakkar

     Project: Move existing tests to a unit testing framework
     Mentors: Christian Couder and Kaartic Sivaraam


   - Jialuo She

     Project: Implement consistency check for refs
     Mentors: Patrick Steinhardt and Karthik Nayak


Let us welcome them and wish them a good summer of contributing to Git 
via GSoC!

Thank you to all the contibutors who applied to Git this year! It was 
tough to choose from multiple potential contributors who all were good 
in their own respect. Hoping to see you around continuing your 
contributions to the Git community in some way :-)


[[ References ]]

[1]: 
https://opensource.googleblog.com/2024/05/google-summer-of-code-2024-accepted-contributors-announced.html
[2]: https://summerofcode.withgoogle.com/programs/2024/organizations/git


--
Sivaraam
