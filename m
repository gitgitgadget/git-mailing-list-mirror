Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B831E0FB
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736066; cv=none; b=NpwHXdIyHh6qjT2KqEIcxp0bIUtssmF5YWJylKDSJHTLdV0QuzFol7+Op5QVr9Y6T0ICTWvRr3v0BJW58iHj7eFdW3OE7u9f/ZSFdfNwbt7lYG3hu+8DT0vz7eATRO8Dtp+FssteZPZQ3I1Zyo+p3OfNBqd2D8aRVQncWwkqcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736066; c=relaxed/simple;
	bh=Vl9mt62CWPpnnNG77jXuxXmGabI8ZMPwthtqgAi9j00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tv3KnirCSJUmLJjlDZR5Oehev7PUI/f4zaEDlUxvA+IigAvnRsGbTAK7Zd4DCxEboSfwRQApn8Dzr9qT2CTu2euuoDau6QCKndN9x2bAR29tGzFZxmyXNdh+p2QHtv1IDr5jhRHKys88YmLyS4r1gunFbLOQa2k3qp4I5ZDI/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GymD0YWe; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GymD0YWe"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ee07570deso38605765e9.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 07:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770736063; x=1771340863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VVwMTEzNFNUOt7v3IxAdw73+UDgciuc3NtDd0gB37RM=;
        b=GymD0YWehas7sUz+WJSVMvXhbTRVtpaepSuF4+6j6GFezeV2wjlpc1QHHrO2pcAwhu
         XwdDEngMA6JHsLzR5o5dlCvSqkJHQNi9nhuVwd6V/GSt9CJFt6mqWqHdN4L8if9ZFIYu
         MNFRO1Zq2xNI2e5ONpS902HQmS8P+Nj3pybndort3u1enc7zsOBp8W24OaCY/NcwzjJ2
         cbSd6m3+1ed9bJofiDWLCxEusyBz6Y0Yv0jP/ZMnKgtOcNWeEU/J3CT8Hn1mucukgXO0
         y9mx4/huZzemd4zA5ZZbqW7Nz78mCg23nsXw91YVYpLVDwBJMjG53UAxdazNTsBvOp19
         SnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770736063; x=1771340863;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVwMTEzNFNUOt7v3IxAdw73+UDgciuc3NtDd0gB37RM=;
        b=k/gxofK5a6y8xnqX6ZPGRjReUMBAJ+aL04I9ZrTEH9CVhNqsPzcmcX5ozF+oS5AnhS
         bMNpmHoZ0oID7B+c5KGTT7Vx7n0zS/x7K70l8ipfW9Rw6/+Q5liitbvjBKWazuvVehEg
         pztB159VWy+U7umJBCf11mW6h9AaD4ndpUtxH/naG2KBkyndlIL63JAmzQmcmO3jzgJG
         w+Ii2qfvnQfZpkgrDrOGMrJMMzQ7WmeswxFIDWpmFxEKms5bBBTm/v7EpjZ9DObefdN5
         a+E22LfFoLxEFcR6uSmmO0vx4AXqQU3UhNkxzow8hWWH+d4O+Epe2xlmF/7Fd+5m1ka9
         OSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUbPiG3EK+FNdaAbEgDZ8lSK/VRw5PTMXV9yBD3LVb9LxUA8NWHj+v+WKztvybgjP/pexs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSGuBBcUD0FtCBFc02fbkWmkgyTIiG4i1rSmgAsz7s1zkvc3K
	R/LTJt5W0/zq33Cgh7vd/D8gzR74fGCxcOh6WiDLcLbWqxbhFlBAdKmf
X-Gm-Gg: AZuq6aI5p5gDmy+cMYmX8l1oiEoYJf7AKixPELmnQJavzT/kFCNOGofW78cUfHvYrGm
	15KWfoPY56MSQhm0xShi+HbnadwvvFqxBHmNkDMt+oUOOZnqENtTI4c9u/xuBNvH6QhvaXI2MNI
	DCvBhQughKuz025CaD/QOox/K/2zGiHGvOHybyx92ImC+y7czNEJrjsuw2s765GtYIQDQwNVYxZ
	aJ5AEvIFyjZYHw5If2DDZFGYarYmUh1Tmcndg4QB/7UVV0jqgkybYGolnQf+s486aL79p6oCEGY
	2bV8S4ig8ZajW+m1Vz4pO3xZhKtK43SJ8qAQyJrXPhSvQCxuhmhVLZvufrTddZu/vWwGv3cNiDk
	9288mboLl0i9kz4Gx/PaGRX+fi+JMcT4ioBXM4O+AFpbC4EzyPkwZ6kGpdFkzlsPYEcMgwpDfBC
	j6jrkYVS8MB3r9b+YG2T5pjJQltkIUWnLgXLPhqs+PwQRzkyHUCs337PEaq7sJjSatoOGfcThAT
	XQQWA==
X-Received: by 2002:a05:600c:3512:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-483201e25c4mr231691835e9.13.1770736063087;
        Tue, 10 Feb 2026 07:07:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096c438sm206299455e9.3.2026.02.10.07.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 07:07:42 -0800 (PST)
Message-ID: <0a45d72a-2a11-4363-ad2b-9fabff70bc9f@gmail.com>
Date: Tue, 10 Feb 2026 15:07:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: Bello Caleb Olamide <belkid98@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, toon@iotcl.com,
 christian.couder@gmail.com, usmanakinyemi202@gmail.com,
 kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com,
 phillip.wood@dunelm.org.uk
References: <aYsEpvFwCSHb5DYO@ubuntu>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aYsEpvFwCSHb5DYO@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/02/2026 10:17, Bello Caleb Olamide wrote:

> Initialized empty Git repository in /home/ubuntu/Code/open_source/git/t/trash directory.t4027-diff-submodule/sub/.git/
> [master (root-commit) 4431e0b] submodule
>   Author: A U Thor <author@example.com>
>   1 file changed, 1 insertion(+)
>   create mode 100644 world
> BUG: repository.c:56: trying to read config from wrong repository instance
> Aborted (core dumped)

What does the backtrace show if you load the coredump into gdb? If 
you're using systemd you should be able to run

     coredumpctl gdb

to start gdb on the last coredump (you can list them with "coredumpctl 
list" if you need to select a different one) and then you can run

     bt full

in gdb to get a backtrace.

If you have an actual coredump file then you can just run "gdb 
path/to/coredump"

Thanks

Phillip

> not ok 1 - setup
> #
> # test_tick &&
> # test_create_repo sub &&
> # (
> # cd sub &&
> # echo hello >world &&
> # git add world &&
> # git commit -m submodule
> # ) &&
> #
> # test_tick &&
> # echo frotz >nitfol &&
> # git add nitfol sub &&
> # git commit -m superproject &&
> #
> # (
> # cd sub &&
> # echo goodbye >world &&
> # git add world &&
> # git commit -m "submodule #2"
> # ) &&
> #
> # git -C sub rev-list HEAD >revs &&
> # set x $(cat revs) &&
> # echo ":160000 160000 $3 $ZERO_OID M sub" >expect &&
> # subtip=$3 subprev=$2
> #
> 1..1
> 
> Thanks
> 

