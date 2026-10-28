Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181600;
	b=etbJRa5Br8YoVeLalKWUO3yjL3KEAcXnl3jJdF0yyfvuo1UDWKeoNgjEdnm/XsLTZO//
	 8vBRDXbMXtOqioM+Pn3Utf7/flLAOXRmzMHNPZUjPY5QXJjowVqzwsaE/dBUh0TwNzKy5
	 POkWzDK6W3/FurXYfABBtdIUYoqBERnYRHkGCBQ37hM/RsTuS2DQxkBjaL2OCDI6vFl3v
	 /MLRVIAXf5YS7SdNzynPDgegYYVVV95RBBg6EqWG8LTndxMHGEEBrILTsbMCSCW5p2b76
	 h6Pdc1mZSx8tjMTca1txdDeTJVpJbqG1kEeht1+zAS8hfbzcz7ekTZD1W/QNV7JgoDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=2cF0yGZ0DBPCcMkHESbP3rKmeewTuY98n6iFFqGAGfE=;
	b=HJTReJzsqkmVrkRCLGQKfSxP31V8zJr5/88fyn7v9wpQh2NGlEJiiaJR6vdUXxS92LHZ
	 uQ1H7yS+M7XqVjNfWn8kQbA7MxprQ87COaPhqzMVMudxSzCUaXWxYEaw+wMxoexFVcP9M
	 jASsI/o9/s2hPBwGytEe8+b9gnYBn/1D9adKwhut92gn0lajwPJzOtxJqCq1ad8I++VHn
	 AHdtwawXo/5QqfF4kl64yse2t3/AnfNcn4bHh2AIzggb/1Gs8/PiqGVbldUWh+athf4jJ
	 XrBHUNkw5yNyRiD9WWU/PBzXmAwN3sVgPIxo/8WKERGhokOqWwdY+qeyoXTpiu3zPEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lrw1fHVh;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD5606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 10:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DFD5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lrw1fHVh
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1040402c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181599; x=1793786399; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2cF0yGZ0DBPCcMkHESbP3rKmeewTuY98n6iFFqGAGfE=;
        b=Lrw1fHVhxEsDbCaLR1armQOHq0b6AKFS99Mt7bmhYA6sjqwqm6KGzICVXWgz/9g6L+
         KLq+VmFaQ+UOvvfnao8XG6/x9xTFX9lknr+nWAPZhfGIJlkm42mu73OPb0E/y0DNaR3o
         Y8LAsAREeoYFvs7pYcV5XDM1DdjgTjXYrCHTmBmZiU+Q1ywiGfC3zI9BCb+MOTfZ6Zku
         qM2lxPscn1em1yqQuPpVD/pH8R+t0URrRsg55xSExZ3ws9oLuusGKALUw80y2y6briGA
         o376Uixe9vACDdvTvP0hql639ECR/yQcWg+FhSYGe5HvGXKyWatvfGfM3l+Fx8Sb2BI3
         6NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181599; x=1793786399;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cF0yGZ0DBPCcMkHESbP3rKmeewTuY98n6iFFqGAGfE=;
        b=m6hUDDDX7AS1UOjH7c0IBeR6I9DGAdebjz5oUiqr1TfV5HFBdk6VqQnH02mviZ2ban
         dJzymhyirL2xj9Y3/d//FYjaR4N7DH5hXxsGJC6q/RtLGmZgKayiBBZJhXX78y+fQ6KA
         kxdJz1e7SScP9XkgxaAcbF1HwStzAtz2DtkuLkw4MJ81XRNDqi2FBsEOS1uBVpc40dVD
         6EPnBZtguPbUEbIjIHB1mDF067/4b3Mr3j11hWtc6fTESig54pxvgPItf/E7Fiw7/jcT
         X3hMjQ7iJvDT9z1O2fOZGZk/00+j3aoFUmE9zbubqU1tVsXh7F8WwVQVfdAVAxTqmV72
         /+MQ==
X-Gm-Message-State: AFq9FYIWwmN7hw15/RXZ0s4gXwhxxa7oGXrXCbY0OC9ojLCnqL+ay2ac
	zZDv8uQd7WGE2vbvzrl25oXgmqDuTfmW5xnqHqQfnwhdkG1GKmULR2ie
X-Gm-Gg: AYBFou3fxqBcxPtqTg9TpN85vOs74KtLRiW6pB/SZVA/LUy4qu8bQsQm9uhUrAVnZ3i
	L9GwakxkmYl5OOBmVHdItptnus3yFKmAzp8wGnnI+Qz+KiBFociRZ7PDs34UEOeq7XrDt7r6Tmu
	tCp3UziIT8s2cVBPNTJVuvOYnK2oGyyhUFYJZx085KYVyqQYzW0dnbr2aL8b3zKV1/bCj86uQM+
	uSqxJSKK0KzUjV8899Xe4HBcoc1L3JXx/rT0FmQjLJcHFWdNq8QQXwAX7Pu1G4jeJfwH5XmtMwq
	NJkto/b0n4gDbWngR+81IBp+pjWLVoT494TFFIXJA8kIMpdfJSFDQcAhMy1pThLnsCrxpvjRkCk
	xRyL8g4pTLlfKpYrvid96DhoCku9bHmezPZre1geaWrXz7tT9/3ToL33fEs8v8wYjSzu1NIs5gW
	qv0FsxMiOUapsuhIfke8Zfi/msyXS9yP+3FPhN6k2TndzChUiPEgkVevyDmZqF3uoDIx71Zo+3h
	gu4h47ztJH6nDViZl2LJszyOqfEhRkuGQV3wR/JlAbdHonFmS+A9XxDWYn6NkVjdZr0ACaFYPl/
	/V34Vb8TaQS2zEXeJrWlcJU=
X-Received: by 2002:a05:701b:2710:b0:1a0:9d29:c32a with SMTP id a92af1059eb24-1a6cbf7507cmr2220794c88.9.1793181599264;
        Wed, 28 Oct 2026 02:59:59 -0700 (PDT)
Received: from localhost ([117.213.200.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c814aa1sm6961003c88.7.2026.10.28.02.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 02:59:58 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 15:29:47 +0530
Message-Id: <DMGDTKTJT5GV.27BGIN7N0K8T3@gmail.com>
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
Cc: <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH] t/t1467-refs-rename: Use test_must_fail in place of NOT
 operator
X-Mailer: aerc 0.22.0
References: <20261028-refs-rename-test-fail-v1-1-b7458ca62149@gmail.com>
 <xmqqld7iebhj.fsf@gitster.g>
In-Reply-To: <xmqqld7iebhj.fsf@gitster.g>

On Wed Oct 28, 2026 at 9:13 AM IST, Junio C Hamano wrote:
> Hardik Kumar <hardikxk@gmail.com> writes:
>
>> All tests in `t/t1467-refs-rename.sh` use test_must_fail for verifying
>> when a test or command is expected to fail. `test_must_fail` is used for
>> all Git commands.
>
> "all Git commands" that are expected to fail, right?
>
> For two "git" commands that appear immediately before the line you
> touched in the patch, test_must_fail is not used ;-)

Yes of course what I was trying to say here was that based on the
Release Notes the use of `test_must_fail` must be limited to only Git
commands (expected to fail). So the patch is following that principle.

>> The use of the NOT operator is replaced with `test_must_fail` to ensure
>> consistency in the unit tests without any functional changes to the
>> tests themselves.
>
> A more common way for our proposed commit log message phrase the
> above is
>
> 	Replace the "not" (!) operator with `test_must_fail` to ...
>
> More importantly, the use of test_must_fail is *NOT* about
> consistency.  The most important reason why it is the better way to
> write than "! git refs rename ..." is that test_must_fail notices
> and fails loudly if the command line getting tested does not fail in
> a graceful way.  If somebody tries to update the "git refs" command,
> introduces a bug and makes it segfault when=20
>
> 	git refs rename refs/heads/symref refs/heads/renamed
>
> is run, the command line prefixed with '!' will happily say "ah, the
> command crashed and did not succeed, and I am happy", but that is
> not the kind of failing that we want to be happy with.  If you
> prefix the command line with test_must_fail, however, test_must_fail
> would still fail when the "git refs rename" died with segfault or
> otherwise killed by a signal.
>
> Thanks.

Thanks for explaining that! I will update the commit message in v2.

>> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
>> ---
>>  t/t1467-refs-rename.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t1467-refs-rename.sh b/t/t1467-refs-rename.sh
>> index 2b28be75c8..b7d290d05b 100755
>> --- a/t/t1467-refs-rename.sh
>> +++ b/t/t1467-refs-rename.sh
>> @@ -88,7 +88,7 @@ test_expect_success 'rename with symbolic ref fails' '
>>  		A=3D$(git rev-parse A) &&
>>  		git refs create refs/heads/target $A &&
>>  		git symbolic-ref refs/heads/symref refs/heads/target &&
>> -		! git refs rename refs/heads/symref refs/heads/renamed 2>err &&
>> +		test_must_fail git refs rename refs/heads/symref refs/heads/renamed 2=
>err &&
>>  		test_grep "is a symbolic ref, .* not supported" err
>>  	)
>>  '
>>
>> ---
>> base-commit: 37b3475fb530c14109211faca33716a173db61ed
>> change-id: 20261028-refs-rename-test-fail-ec7a8fa74e54


