Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C602DFA40
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496985; cv=none; b=Ho9x59O6MxtgjJVAzMuyf/mqqC6fSisV7PJExDR6kI2IZj2UDfiaWppBaZBRnZEIJ3LkCCcZm393B06h2NoVy5gKb7DzQodJHlJ0UM2GwympobO+7tCoUh5jhm68gqL8T8D/g1iyNIm9blm1c9EgWEwflwb3OQMTAkTBwjAsXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496985; c=relaxed/simple;
	bh=GvVtnM7VZwn44AhzwPdKs89ccWvVwyYTEjPiatGHQCY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O3Sz8uc0IRAju8I0jLzwSOn6YlrduoIoBS4HD6erkTn4GPe0IRXQuNs+EWsSE9r7/edCdjjUyqttrd7EX7Aaxq7VHHT/0RjiORNZ0NbmWjBdBRaDgq7LSAzlrkMte17ypS8gvZKr10lsevp/8VcVu+y7fFg8bgzgWh0toZob3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2MCejVc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2MCejVc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so5686055b3a.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763496983; x=1764101783; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngw+gsOavGO8yvC0PWFtWJXeXf7kqR34bXnNUcvM+rY=;
        b=E2MCejVcbv+1Fwhq13p4TuQzdHYFu7N1GtNhjvAOZ6XbF/8zPcHXoepw8Hc/s3DaA/
         5a0CZvwTEiEgAiwiRic/OIVJBelqiDGSSQflzWRyJSQDTzk/EdGoge39AXcwLkJhKfqI
         JGdAZAKb6BRXzVJa5gqW0NdaH/KGXgCgaqPDUEIoeGI7Ji5lPv8U1Bpd/s9tkh2lh6Ep
         9+TNz7bwVJcrCmvlt9DVB8weLeb/78EUFwA8TA2VJz1CKBOka4tzh96XxY+BDrxOyOCY
         yp8s2bq/4OhM3V20vphpsGYOzurYG9GrfeF0RQqdazsXd25QDcaHBGsF1/GGCDmUfKvw
         tLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763496983; x=1764101783;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ngw+gsOavGO8yvC0PWFtWJXeXf7kqR34bXnNUcvM+rY=;
        b=k8rx6AOau9Em8SbGtWiLS9sxcXD0JnZxmOAz2HrPQ5Ld/kJIp/DWXW9nk7LuO0A8tA
         BRhvPeNdjL/PWzw6kgH63mjRwMXIiArtlm1oabSEntoKatxh3VaULGQOhH2QTzWhJVh/
         /xjw/dLtJpOUolU4LD/sZysZY1H9ffRkmE9gEKZ950+9OV7iMpCFw7yQus8bBL4vztXm
         7XXYSj+66SosocDIJ5CJBT07h4HpGFa2YYQQ0Zc4exkWZ8zS+OMOjUFRYLDnLh+Xrk+3
         n+eB1f3844IDehpmjqP+1hgLiCEiEV0aVkJ6hyv/OyQJxWrm+6Tb7jL4FwIC8ZrcCFRw
         GKIA==
X-Gm-Message-State: AOJu0YzxCj4sDaUXdqnXEbY2aMgycBLi4nRLGnLB+5Z3lKb6i+hLeUrt
	b/sbHllinONohbaz94RZev135kBOXq9meVkSxONPmVqYc5Er+kwqoFWo
X-Gm-Gg: ASbGncsa6Lbc5hlWDLf/El6ji0NE0+aqw/yKcgx0wIW+kx4Yr7dhfplydaplzLNqTWb
	IazINSkjJQ0cqvwdhyFNmSnoV+yn9KEvmFjcnR9fhA/VmSFtNHeClRuwys/56GNwwywtz8PjKr3
	H6yAlwZXQAwFqih+v+1YPOd3QeRbQyg9EfXKc7nhipfsmfI/lo0l16FJUM1+UksCVS7QvPFV5FJ
	MjWpFrQQQ8Cji7SKzUjPVkPnWsq2lQ+Qv/Pwb4pqxEyCdkiCEJVunkZ7ihCAPtQQvPQ21FoIxnn
	TOAXcrxfc92rPYbpXBC768ukjL2WTzh2k4akuy40JoKZGh4iOS91IK+q1EmyrFQS/NfMBi9CbBW
	DxHFMQnhAWcjZFgAh1aPT15pQfpJIcNcecZTHUncYBjQlgyZgGRuyh5pPq16/V0pfzYlM8OtemF
	Aro8KMd4EJFAUKMw93CLQ2XdN0o5kXJrAZf7i/ZlgYO2gHGgVV319/oNBEvJGm2OvPSlFCFVWX+
	Ly/yQkqQw==
X-Google-Smtp-Source: AGHT+IGGoLHXx/viXaFrw3GulCL4BKTVS7fvbOOqq2EJxWDU4Wyym9jxFLoFkqFi0HYDKOocI9uPug==
X-Received: by 2002:a05:7022:986:b0:119:e569:fba6 with SMTP id a92af1059eb24-11c8d9723c2mr77011c88.21.1763496983193;
        Tue, 18 Nov 2025 12:16:23 -0800 (PST)
Received: from smtpclient.apple (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm65095530c88.8.2025.11.18.12.16.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2025 12:16:22 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v4 2/2] repo: add --all to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqh5usiizp.fsf@gitster.g>
Date: Tue, 18 Nov 2025 17:16:09 -0300
Cc: git@vger.kernel.org,
 sunshine@sunshineco.com,
 ps@pks.im,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <DA3814BC-D6A5-4EF1-9A2B-9687D1B6C26A@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251117151844.14802-1-lucasseikioshiro@gmail.com>
 <20251117151844.14802-3-lucasseikioshiro@gmail.com>
 <xmqqh5usiizp.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


>> + for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
>> 
> I am not sure if "unsigned long i" is the type you want here.  I do
> not mind, and actually I prefer, a simple platform natural "int i"
> for something simple like this [*], but I know other people prefer to
> use "size_t" to work with ARRAY_SIZE() these days.

Yeah, I also thought it an unsigned long feels out of place, but I
was only following ARRAY_SIZE. Actually, I was trying to avoid a
warning. In this case we have very few `repo_info_field`s and any
int type would work here...

I'll replace it by size_t, then.

>    Side note: The reason they insist using size_t here is that
>        "-Wsign-compare" makes the compiler complain.  But I would
>        say that it only shows what a misguided feature
>        -Wsign-compare warning is, especially given that the
>        compiler perfectly well knows how big repo_info_fields[]
>        array is and the iteration cannot do any harm if done with a
>        signed integer smaller than size_t

Perhaps if ARRAY_SIZE(repo_info_fields) is bigger than the maximum
limit of the integer type, which would overflow and this for would
loop forever. But, obviously this wouldn't happen here.

> This would work, but the symmetry between a list of keys vs the
> "--all" option is lost.
> 
> I'd rather see something like the following after a #leftoverbits
> clean-up commit:
> 
> if (all_keys && argc)
> die(_("--all and <key> cannot be used together"));
> 
> if (all_keys)
> return print_all_fields(repo, format);
> else
> return print_fields(argc, argv, repo, format);

I'll change it in v5.

> Again, this would work for now, but maybe "git repo info --keys"
> that emits these would be easier to manage.  This can be left to
> #leftoverbits of course.

I can't see a use for it other than these tests. What about writing
a helper inside t/helpers for that?

> But then we have seem to have seen too many #leftoverbits material,
> you might want to handle some or all of them in this series in a
> reroll?  I am starting to become undecided.

I agree with all of them, but I think they were too much for this
series... I also think that after git-repo-structure being added to
repo.c I think that it deserves a patchset only for refactoring.

But I'll send a v5 containing the changes directly related to this
series.

Thanks again. I'll send a v5 soon.

