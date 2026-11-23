Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463340;
	b=XlNWdmpnlIRCaJkOvA39Y3zWXwy+RBABCqXa5/U/gkOBOnmxoXAHzOXpfVyh5DqRX1r0
	 KTlVT/e85xIA7N9PnlaLK6rNeLkSXkPRL77iFQ42B5jm/gURYcIHoehhe4Ese67kqAENM
	 rvmY8EJQtVQlTV9700a1UWCLUVHY1MfVQcjeywpG/8ShN0nNUqDL9NDa6LHDCes2u/09g
	 4CwespJKpYopq0KaxXQBPJSLhjdpItyUZ53XBhcPbMjUI2bbfJMKBW8GWbEGqksGQro5Q
	 B64CMQCdca0h5pXx+mUQ8vuHWrqKvAUdq7bcY6aeuDlZr+SxGdHQYoRJQT/2BpuCdZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uDuyb4O5gVwox3CKO2TC+V5eO7+aUauYsejqsdaNtBE=;
	b=RI9XXcfxzb8NKEv12EzJTwt/dCOat1w2u6gF+T1lNnh26Hz5Tjq+B334bjWS1M06RWx5
	 86Y7GfqqysGvm1BC5JdStpp4/Oclb2WLSkuoUNWLyOuszlvYjx0G4LR0+An0VWNX952xG
	 FpAt5fL/BUOXT/rcvOj69+wIYH03ar990JKp055nWp6e2HMp2cau7h72KxCvaLIW7J3+0
	 P30PcA4aZyvH5CFi4eY7B63nwPU5L+nIFVOSDAJsYlROay1/JtV3dHeZQgxiatDcqSH85
	 zD4T3ozB+u7FTP1tc2WVF2lWdDv4G0nxgdxCaUCDIPHhoTHVEUE4eqXhMn5CBTkgQ/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MkFX89Ej;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B59606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MkFX89Ej
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so2348450e0c.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:48:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795463338; cv=none;
        d=google.com; s=arc-20260327;
        b=Z7wPuIAAEaCtCO17Si0rNsA01+zGuJFyAokOXO+5Bk5T3KiKduWgdOBrTLKV8sYTNI
         QtMbgBVN0OyxhIUmdSfBdGepF73GxUMijk78spO68YUYGMCGBn/NDjDAQvCVSs84BlzN
         Z5f40bwUao20yM7m796wkn3shiIr0ZMc8l4xAGBwGHRzSEwr1HDsfnF/ZFSk+A0cySg3
         Ns1cHNofk5g/JxbiWK5/n1H6dKf6Q9gFnV2py2MFpYZIeIzb56ooztOIOJI9faLBILw/
         oXvr4WHu6MLrbr8VOMcryw/SgjiWdY1VQaQ42N6oEfWvQXm4jLKRULGfnGBpKMTZ/1q5
         S6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uDuyb4O5gVwox3CKO2TC+V5eO7+aUauYsejqsdaNtBE=;
        fh=KhN7yonrYxCuH3jBasxGFq/ooVGXP5N/iNfBIawl6P0=;
        b=WVHEvKAupnwLdsUzoPqV4R3bSH33XFNoDPD7EJDc+eSfBfldDnRFUDIWfnphyntYHU
         Nl/mNW9qfzwBlJ77/q0XLOKxUxnBPzhNtr8V1DStu9Wox22GvDrjuW1qikYSSz8tnvxR
         iv3z6OgniqEIBe4UnlKVpu1veRWZCGo7Lty8G5l7RJI+FxH0puY1oAXiLehtBXIuNH2W
         s0t8KMiZg6rJMGrrfgrV1pIINl1iCXBZBbx+q8EV0rGftcI3Z+6bbg/C4Df6ODSbavny
         8SOLi7tOREwpL6Oau/H3oBeRad6LDJgDw2+DzJDmuVORwG4VeW1d3zqJUPm2DytUT4T7
         TVYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463338; x=1796068138; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDuyb4O5gVwox3CKO2TC+V5eO7+aUauYsejqsdaNtBE=;
        b=MkFX89EjQuu+htUJfssSMsqokNraHeY80g6jUFxyis4ihhjROr3rFFPKDlwsNtCdkT
         wkfXTg2S3zDvE9GuhePCEGzJyM1r+FqDaL0ZuPLqFNzRdOoNKYXIfUlIlCoKuOGpEbm9
         8AXqOYr4Rq43JZB9qRiVlkEs7drxPJF9B1wNhvWLasy6BCj9rldrfvk4K3eOHc0SMpdR
         4u/3oRfl2Rxchpq7y41ywgjPAS3kapRFYj2rg2ZINydsrqq92AcEjgFKgiISYEaEeYNJ
         AKnkILQGqDVVBGBlq8mIZ7rgTDuJnrNnFKE3tcnAt/QjF/pLxUvU059TrdtwLLGiAoP5
         Efow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463338; x=1796068138;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDuyb4O5gVwox3CKO2TC+V5eO7+aUauYsejqsdaNtBE=;
        b=Xbf7wwNQG6b/fSVVbmbqLLdhse85Hspzi2Q3qTfGcfGSdnBQwIOY+7qSoWIsma8bmk
         zZ1ZZ7ESM632FdO6ij2FAt360Xrzb4WXXKclaEK6/Ayub+NU+SJVHaJNPIcV+Kc051/C
         34FDlKuf8LvEFuVyQ+zNpCNA5fB1FKBQ577gGDaAaXAjlrpQexRhMIB3XGkgHI9WlFJA
         HLlEGLVa1ukLp49iX5Q9qlTPWjmPjJ5/xuaOXmnmdTY9LGMQG2b2SweYj6qJhMsN+hJy
         P7yK2h6MEGC4u8QvzgK2LirhcznLXNUP293GqarGwFkX6SXYGHMNqZJwyOUUkB8RZdtA
         B+2A==
X-Forwarded-Encrypted: i=1; AL+hErECFAdtBHHCYLrCQUnhtmJL1+bPeezZG3tF2tfg4MpBPOsg7L9S0jO//9SZN6l9fgUlsJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dUKLuumMApjhnxAlmCI30y/EIs3DhBZCmHn7DMMxhwmlEzntQ
	QXiVG+5Ca5OC2IS7jSVzGmpS8doUhvPe+uO8cK7NLHqU/BzBKwLpFHy15fTgepJ52tVQ+1BfMJj
	9qK+bchHJqWoINTrvLV7VOqmHesNoH1Y=
X-Gm-Gg: AZFdTZdod0zutXNFdaXus250/o00HjEW2cWd4bWFwMmuHCrxOGO7IzOc08K83389Sbw
	fjZZIqFg80PcgQmFJR8cfbJ0EFegqNqbonSAwGJW8Y1HJWPxp07Nfz0yYX67R8kRhLJOPnvtCFb
	m+V2ddGD+iNDLT96D5tz/CXY5EJ3laLW1FECwtb19ASaDGXwsIsPC/0fAA1QuN10rSN4v/wtaiB
	vpuAM3VVa2C1RswI8qNl/pU06xc5YPpKzkLCPB4TqYBykZr4aNKjCyMaArPqeLrFZeRTfj21pdg
	Rvptp4jQ0VnG0YlldWrqSz9b9yM8+DZXvhFPoeffAMj+Ma0X24Kk34y0haeiss0DuHPkWV1ySEi
	0/nu8CBhjqCn67gZz28L+ExzdDvXXEuKkUS/L2U92a1GOaJLndX3oJMGS+8FWCQGl+2MsgiDZ4A
	1fUnVI0jbIMKPRnAf4yjWS3zzYphU=
X-Received: by 2002:a05:6122:d85:b0:5ea:c11b:431a with SMTP id
 71dfb90a1353d-5ee8af32d98mr7201856e0c.9.1795463338500; Mon, 23 Nov 2026
 11:48:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 11:48:57 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <db459a4f-9454-4855-b1c5-c8ffc9b277ce@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-2-b8c3a0ab27e8@gmail.com> <db459a4f-9454-4855-b1c5-c8ffc9b277ce@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 11:48:57 -0800
X-Gm-Features: Aa3M54pFMCGTOqfOHpvKsbHXoHN5sMWYJ3YBbp3UUCNdSDb7ThrBzStPWwx50Ac
Message-ID: <CAOLa=ZR3bYW6KS=80zWcEjzxhD+C=Qt31x0ywdDTets-KG9fDA@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] t9300: make the series B tests self-contained
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000007fc60a0660f6e281"

--0000000000007fc60a0660f6e281
Content-Type: text/plain; charset="UTF-8"

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

[snip]

>> +		test_grep "1234567890 [+]051800" out
>> +	)
>>   '
>>  [ ... snip ... ]
>>
>>   test_expect_success 'B: fail on invalid file path of .gitmodules' '
>> -	cat >input <<-INPUT_END &&
>> -	blob
>> -	mark :1
>> -	data <<EOF
>> -	File contents
>> -	EOF
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>>
>> -	commit refs/heads/badpath
>> -	committer Name <email> $GIT_COMMITTER_DATE
>> -	data <<COMMIT
>> -	Commit Message
>> -	COMMIT
>> -	M 120000 :1 .gitmodules
>> -	INPUT_END
>> +		cat >input <<-INPUT_END &&
>> +		blob
>> +		mark :1
>> +		data <<EOF
>> +		File contents
>> +		EOF
>>
>> -	test_when_finished "git update-ref -d refs/heads/badpath" &&
>> -	test_must_fail git fast-import <input
>> +		commit refs/heads/badpath
>> +		committer Name <email> $GIT_COMMITTER_DATE
>> +		data <<COMMIT
>> +		Commit Message
>> +		COMMIT
>> +		M 120000 :1 .gitmodules
>> +		INPUT_END
>> +
>> +		test_must_fail git fast-import <input
>> +	)
>>   '
>>
>>   ###
>>
>
>
> An --ignore-all-space diff helped me grok that most of this change is
> just the existing test getting their own repository and the test code
> indented to put them within a subshell.
>

Yeah that's probably the best way to review this as most of the changes
are just moving to subshell to ensure we don't have any dependencies.

> I just wonder how much additional time or work this has resulted in 16
> additional repos being created and torn down.
>
> --
> Sivaraam

I haven't actually tested, but moving them to different files also
increases the parallelism of tests plus significant readability
improvements.

--0000000000007fc60a0660f6e281
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2c432e71c3e59cd9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1zRW1LY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meC9yREFDQ0VnRzc0dHhTS01BZXlMQ1JyeitsVHN2aQpadXBXVHFpM0JR
RXI2L25DSk5BTko2YVdsMGNWTE5FeUpGUEVNbjh5SlpFMjNyYnVORUpTbGtYdzlrQVkzdTNPCkln
M0pXWjZWTlFMUDJtVDBDQUJ5NXpCc05yK1VhQTEvUnNJQy9SNGdzak1MWG9LNnFHdEV1MUU3a0Fs
ck5zYXIKVVRybzg0YTdSN3V3Tkt0UkcxMWVUZ1BxNE9IeTNmSjVpc0NYMWhGZGRhL3ZGVmgzWUw4
KzNlTzlTUEpBYytKNApYMXZlNHdqaklVSnBTdUlJbnlxR1FrZWxMdEdMeS9FV0xEMnVObmRTU3hC
R0N4NzhtVWVWSmxzTUJJSDVMNG14ClVoQm9ueFhCTDlWTkhHYURYUTFBQkJsOFpEZUhoWnlBZDM0
VUQvVnowZWRVR0N3M1FZM1BPRjhqM1VNcXRydmwKdUVQUmFqajg3OXNQY0dVZk1HeThiYWI0TXFx
a0xubXRUZUpPY3BmSk5YL3JMM0lxZ2F6dFVvcTV0eHFsM05tSwo1bFArTTlmL1RYM21rYnJyQkc5
MTJ3VkU4eXhETHA3UlRWZUFGV0JIT1ozUHdqdmlBMk8xYnlTZnFBVEo1dVpFCkRsdXRsRlBtRzZ5
a3padUxrbEtDOGV1MDlnQjFRcHlFVHRWRGdtbz0KPTRXdHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007fc60a0660f6e281--
