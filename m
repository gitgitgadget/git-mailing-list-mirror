Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787958;
	b=RdeImg3cgi0scOOiqASBYuPGF5zsfYsxgA4EbCrnvz66EVleRT76TZcgew+HIRyQRvXu
	 MqQv7oSnn3ml5tgLhcU1k81TG5jgt2wVvxUmC06qc5Smg4gX8DK8xKZ8slFNScFCHeVlU
	 BBV6nhIvmBcogcMKa0d5fGz/irkciL2eF/7mQOSWa3koQAythdcJLaT1hJIoxD1brZjEN
	 U3kIiuFCICpbTUt5msDcVTx1I135GxwsCCiD0wrHwhVcxDK1m3rB6oqaGT2xXUuGSJDEk
	 ILB1wwAVlk0dnWz4UQWlAUtFooTXNyxqSgg5oKWl47EsMUKQRnRWxZ8W7g+3QRxddlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zzCjbOku17tAzASZsN2+oZSKiwjhlUZcXkUuyMvLq4s=;
	b=q/VYr6P/Zblx/gA0h7v32EqrjCWF1iJ38xeNwxQe5djAkUQISN3kVMBfs/0/nvvm5WFs
	 Gm8ePsoLLt7WVXu1wl2P4CRkzX2RE3n7f3oRnYRpN/FGoUBv1kuqtxOsBPOXKfwsx6SC5
	 ce+dc9Dk7Ct89zBljQ+KMzBf/rFojkqEyCzpQpExN0K01vHMxxk/jduLloJ8hqpoQi9dl
	 3EyeqfbJ+fI4Bn8s7V19fHOH/Gp3YFSAazmBuf+NqEBCElncfltR65pnGei4mq9EHYCoK
	 k5u3hNV09t/FMusmOi0QDpIQtYAkFZKbVnJ2TkMERvurbqpSIxhF9Mf39i4AMqLEvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9F2yrrc;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F9606A324
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21F9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9F2yrrc
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so5833885b3a.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795787957; x=1796392757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzCjbOku17tAzASZsN2+oZSKiwjhlUZcXkUuyMvLq4s=;
        b=m9F2yrrcPMd7IXHbGTphOO7jvRHpPYZqany6IGPTACTe9Yug+GTfwGSEq4d5heQXAw
         Jf3X9EAyD5WpSMqKxND9ad1f6dZeKZwj3WMo54nK61pdwjEVu37vpJ3gCo8lVlqrHrUD
         3DT/kpTjA8ZQSEiuyMZ8Mx/84L9DOnFtMIpaWkxQSzCrgNsZxb+QoEC7sM8QVZ7TG+ul
         AXxY7vnOCkSgfPkjuqX8GTsIRtENqhvIMehdLIdewUWF7ufzy1CUt/ld2QLIU7+8nNp1
         5uigWMNvy8wTj2yFPcQd73P9BX+VKNBAIo8wyuOF0Pn3+GqXhaTUvtpd0cU3dT5WEg2i
         Bvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787957; x=1796392757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzCjbOku17tAzASZsN2+oZSKiwjhlUZcXkUuyMvLq4s=;
        b=kW2rkolU0kzYxkdsMleidsEWxvfqiE1jxGPMkl247UhWkA1xK3+F0kS7syG2OEKThh
         7dhsKAjdW6eCKyop/8Nk0dcZf6NhknFdh8NG8qYzrxn/b+H1ZzQm0S5Qmz/5lLoRVfJy
         cKqY1nNIpBfNAHuelB3lgl5vk7W7fzbEoezXK6f34MKGu+sI9LJLlswU8ktr5p6PpIKZ
         pU+SVckY4RLKjokHQLFeMy7oTZnITa6LLIVLktOAODtNcKsDtIDc3A2927Y8yHWeACcr
         24mMvaES6gBLbuhK5cw+UFcrC4LgFLuSVZNey+cTU1JS5IJxgoVmcwScF/zn87ctDo7D
         cvbQ==
X-Gm-Message-State: APuU4Z+Cs+Qox/WhyLEuWwytJb08gdsBGYNYAfdckS5jGYY5yKW7DeVr
	vLwx+KkdDBK0i2GQAOvSDKmUGIQlX/6cMSNwJmFE6RnB0sd4Iett5We/31yNnQ==
X-Gm-Gg: AZFdTZdUPJqdJCVQghy0n6CKY3PeNZhpOnEHIA0Pxuumzfi4LpvuTSWpbuDXyyzXY8t
	ZW9QWwspL5tmMEFRvsyqNJFS+qCNB4aszdb10ZTIN1BlwMgX/UOu5Catqz+dwNz3tJHVVFTqwDt
	PPu6wARHRiusEucwzefWjWUgwhcKMuXYciyMQtsem+VWNIAUVGrp1IIXPnWA5hCIaG/TCgBmN1W
	JhUwYVmeTaPeai9CCtOIc3c1wwpzSIAnbudIq0YZz3nhscV67RrLXgOrgp4dM/2rUTbZhAmhaCp
	g91CSTQcRdrUjXLH4uVZuFQwruo1A+cBKPVP5m/WW07ukSrIU9Mq/Usy54cDcZFt3r5VWr2HRta
	4NJJxrFleWEbrS84JSzGg2tlSq1LVJ8cJouwAcM8uaPElumBe9l8B1SVK9largh+ydwHlh+9o+P
	f1v8aOf0gxXado4RHuh5oT6TC/7FLPlKxUGd5rlOYS+IWzupRM7kfHMGNQvfLpSTKiJiQOB10Fg
	qTDl9RZaZIEABFkKkSHkgVwcSmxcy4C7SXLEI0HK1rk2GRf3/ERir4R2tpKMg2+QpiAmIjuvJnJ
	e8OCEhuRlfS0KWhxwd57TWXpz0CTc5Hbp2DUezRbC7UM3W73D3SBoOqwM51PP3or8WRa7XvEdmp
	6oy35nw==
X-Received: by 2002:a05:6a00:1708:b0:874:706d:856a with SMTP id d2e1a72fcca58-8c87c388460mr21385173b3a.27.1795787956966;
        Fri, 27 Nov 2026 05:59:16 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:ed80:6181:83b:1d91:a768? ([2406:7400:12b:ed80:6181:83b:1d91:a768])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bff6sm12573494b3a.3.2026.11.27.05.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:59:16 -0800 (PST)
Message-ID: <d10dd696-789c-4c0c-ab6a-ee71f29ecb92@gmail.com>
Date: Fri, 27 Nov 2026 19:29:12 +0530
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
Subject: Re: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
 <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
 <xmqqpkw0rp8i.fsf@gitster.g> <781ae43f-7831-4aa7-a7a0-aee069950eac@gmail.com>
 <xmqq8q2g1x21.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqq8q2g1x21.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/26 01:51, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> That's a good catch. I suppose setting the have_expensive_lock_ variable
>> before writing the pid to the file, the issue should be sufficiently
>> averted. That's because release_expensive_lock_ would proceed with
>> removal of the directory even if we fail to write the pid file.
>> ...
>> I'm not sure if we need to go down the rabbit hold of fixing those too
>> without actually facing those issues. I suppose it may be better to get
>> the jobs running with a version of the patch that includes the above
>> changes and look into further changes as we notice any more issues. I
>> would love to hear your thoughts.
> 
> If we open ourselves to a possible deadlock, then it will be a serious
> regression.  If our locking is leaky or buggy and allows multiple
> processes to run simultaneously, that is the same as the status quo, so
> as long as we kill the deadlock this proposed version introduces in the
> updated version, I will be happy.
>

Okay. I'll try to send a v3 with another variant of this which tries to 
avoid deadlocks as much as possible by using a different mechanism for 
the locking. I suppose we may have to trade-off on the "only one test 
runs" guarantee as a consequence.

-- 
Sivaraam

