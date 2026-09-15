Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82232391845
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462755; cv=none; b=Xue1MaLDE+Ea1TDnb8nzKyy0bu3NfI140pKzLD3twV5GHXnsgq3A5Xe/rqM04szFp+B6REWBhpc0sR35uqEvPU2bkKqV89+MUY9JKcSJyHyFrbNoOP7x8t+EX1VNI6p72it6KT72uyVUCUMdVwhce+ZPJzt78Rr8DFlLF5uR/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462755; c=relaxed/simple;
	bh=5LF1OfN4oWLHZg6CfLyE9xIcSGnZ73ZWkKsHE3LEI8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8sy+JX24Bwyv0LA7uvF52qkk97Ybh0x6BmvXbD/ufv6knb2nH8LqmlvmvxDhGeSu1eO08vFlFpcUy9/t7eo161b82cpP8mJEntIWLLA7eVWvrTdrhedgZ16MYxHLO3BeLDxu5Ir6dTUXUcuP/DlMQmJp53i1pjcyyRQHTBv/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXn0L+GH; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXn0L+GH"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso2525757a12.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462754; x=1790067554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BJp+/VfHcl4UXI2u+1/dnZaNHfUAZqevJsSMQ9mnBZU=;
        b=HXn0L+GHnJsxdRXEVS/OjSW36q0gN80vTKhxuUjwjJdF1Sxe6GI9QE67j16ywZYzL0
         teH9c/DGjZX7G3YlZgR5xfpYspnrwz9xpATZnS4JNE5hi/tdT7kIepB9XHPfF9uSZnL/
         hYW2mzr+EbSAVH8dyMX714+zEfV4Xhos7B/q0Ot1Feq7AqkYXmoDN1G5gUMk2hIX5rLd
         lapkdsm70cWOax+dNsPHPCq8UloOPxwS8EWGq3Rd3NnK7KNAkgDROt/1oLQPPOLdu6xv
         LTrgGp1qBhkij07MEbA02KuVDSpkbm+Gz3qmEjY5++70sUkSkiIOn0GsLFZzVkROcNTq
         r5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462754; x=1790067554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJp+/VfHcl4UXI2u+1/dnZaNHfUAZqevJsSMQ9mnBZU=;
        b=NNy55tZKX3ea7Qg/T64VwPy2UkBT62TzLOA5DfOZD8YK6ucIinrokAw3J43gOryoy9
         vXbS4Fdbdc51S+ULP4CYF2cwQnoXm+CHfZEjoP9Hx/BYRuQyHfXby1JezSh355FL+CKt
         jSxtDXf/wp3NpZK/Md650W034Eg1j6Z0HfqdgoJz9gsFkcoXn/BBRY2EuIEXbWXBY959
         h7PzTzo5YiM6lvz21Go8kj9aIdJoiU5oWuujCV0CIn5wb4OcdXKMok9t4R7iyPKGGlSS
         Pl5FllT84YYzdvHnWhOGZFR5SQ3R7b1p1iCXI/kZ9vqCC+dhCNTbBXFEJdQ52a1+MGEV
         weHA==
X-Gm-Message-State: AFuF++npbQEuO5I+CCJNqQKBUmk+LUuPzVlGMzRHF2JVies+Y3E8F8Xu
	CPOQcnCJOxQT/MMxpCNW4hVPsMhUtY6NN5HH/GYbAxGv+nGWCNo+9MUY
X-Gm-Gg: AYBFou1JdDonph4Z8Gfh/fAsEWQxQQsd+FmrY1Lz6iA7ejAUaIeMEgoD9TBGrq3Cw60
	/zyXCB6V+C34eytgzwEMIkx09ZfHS96ivVtJvqKOgJQyelwTe6oh2zOpk2z+0VuoT4K2Jh3BxHN
	Y/BSrOQkhhmcSR0T/NpXnLGu1UVGKt+qMJqEV6s+kGWox7tZ7m1aAEeNneFqDds0nE6JSW5xlsY
	/l2H+VZbe7HMHQpzVb6jt6oq73hPTIiZrQBs2exDSvmuWkcWteFzAElTTidXjxfKqwHXZa18sDA
	jFF7vmOm9TMGFZf3AjpFd/B5SYQh1poY9BZsRYrWhmr+R/kSoyes49pc0uxYpCu+dXOXDhQ5MfN
	Sshb2UybFOq9yJ+88SLSGJOWMkDVJsHd8ASWpUwjhPE0wcgO/OBiFQSnU6DTsgvTZSlA+Pm+Nej
	wvr+9GWyJUvWscphEuwywJf5fRurf10RSTkCZzBPsTLKqIohgD0MS808bPpJCMsLN7QP1uRAPVP
	BgfndVJjYnyT8NhPMMxopqy3F6n
X-Received: by 2002:a05:6a21:3383:b0:3d3:adad:f176 with SMTP id adf61e73a8af0-3db40733007mr16741764637.24.1789462753827;
        Tue, 15 Sep 2026 01:59:13 -0700 (PDT)
Received: from localhost ([2600:381:bf13:b4f1:fa05:dff4:a430:6b5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm33864705eec.31.2026.09.15.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:59:13 -0700 (PDT)
Date: Tue, 15 Sep 2026 03:59:09 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/2] object-file: flush transaction packfile before
 migrating objects
Message-ID: <aqkHyXWO4tRwYemS@jtobler--20250820-SHC54>
References: <cover.1789328612.git.jltobler@gmail.com>
 <18a1798d958d7f089614ec588346096c10b0666a.1789328612.git.jltobler@gmail.com>
 <CAOLa=ZRCyowPgMABwsQBYTbW1cEf8PBBSszOEYQ4TKwLVKQfFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRCyowPgMABwsQBYTbW1cEf8PBBSszOEYQ4TKwLVKQfFA@mail.gmail.com>

On 26/09/15 12:46AM, Karthik Nayak wrote:
>Justin Tobler <jltobler@gmail.com> writes:
>> +test_expect_success 'add large file with loose object in batch fsync' '
>> +	test_when_finished "rm -rf batch" &&
>> +	git init batch &&
>> +
>> +	git -C batch config core.bigFileThreshold 5 &&
>
>Nit: we have `test_config` which automatically unsets after the test.
>Perhaps not really needed here, as we drop 'batch' anyways.

Ya, since we are deleting the repo here as part of this test, I don't
think there is much need to cleanup the config right before deleting.
I'll leave it as-is.

>> +	echo foo >batch/1-small &&
>> +	echo foobar >batch/2-large &&
>> +
>> +	git -C batch -c core.fsync=loose-object -c core.fsyncMethod=batch \
>> +		add 1-small 2-large &&
>> +
>> +	# Neither object may be left behind in a temporary location.
>> +	git -C batch cat-file -e :1-small &&
>> +	git -C batch cat-file -e :2-large
>> +'
>>
>
>Looks good.

Thanks for the review,
-Justin
