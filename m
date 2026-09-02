Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD8472F66
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348234; cv=pass; b=UZZHqVfa5EFKVcgfWRhCroM3csRnZhJRummk5vG+dKMfQUphBU8y2yAKlx9mQGq0LBx0aDyd5lo70wRN/b+fQDJuMhkJTJlqenz4cew222p5F/AGoZIvw0bev5WjV430y1G6dMuXw/g1sYkRfY2fhUs6cl6IaeBkR+r7QXxRvOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348234; c=relaxed/simple;
	bh=o5n1yHSX1apReWk9WFIqeYFQETujppP2AraU1fJWVEY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+0ulZVR4/vk7ZDfevf8D3B2N0n1ICVVsGCwVcOKYSx+Yb+p1jKLlpTXfR17MRgPC908iWWMAfm7w9TZq3TD3imxh8yCSx5llEETzOsUMOrnTiIyJ0+iCpgZwPQ77iImEIBA6fk6WQZFfFUgwZ1YFPQyz5Ay+MAHlJonBboLmCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5tFVpeX; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5tFVpeX"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-783fffcfb96so762509137.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 04:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788348230; cv=none;
        d=google.com; s=arc-20260327;
        b=Fqspj0k144tdHyortaYxaYVZCjhIszC9TMF3J8zWfb3eOdaWyHZrT2uZOsg+VYNmls
         jsAEdJTizkRccptgLWUz5vyrrJ26mmUxHTWZ+5VxbHztwHqHt9iD1+k3zXn6Pe7ywIEV
         y8N1fZ7bDtTma+wdLIxIHDhJvNyg3FSu/CwD51LziRGt5bec+KAEKgPHaf58or6HM+dg
         uVVA8gTiI/Perz7NkySo9sO8tZq7QiQdK0sDHOx7/e7iK6Rc0jkM9pXdGUxnVJsm9czv
         gyKfPm3O27NBHq9jY60RfzuMxhOLjo5gPW9MW6HSlLx2SrQ4SC9sZBht92xw+BfPHwI+
         YWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Rup8x5pej3Rrg9D+HqWOYXywpsyciLUTyMSL95rU/K4=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=BNsxGkgs3wuaItgmaQJtLncvM+RZpTBvS1C/smll6tHHztSCBr4Ov1ZQGWTV6iN4fz
         aNGXBGEef18XLvV1X20c/S00JrvvKpvSxD3qOejTBlo13o5Tul124nXh2zVb2Nn137+G
         //hT+VvnPSNWnM3yK7HFZtv+qbfK8FZZ4R8E7B0IUUhh7dg02uUTQzqp260lWhSKgBeD
         YvMrMq5OfJlrzgDrMgq/CcStntvBioJLm4omeLbcFLaR2H4sbNF7mdYoO26Ul3ZhKewG
         XN+Q4GhK7z4DNTObMidNAK2CREo0aU5elv/aIwAfw9FfAJ6dmtITq0CPE2iXojgAyJxk
         HO4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348230; x=1788953030; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rup8x5pej3Rrg9D+HqWOYXywpsyciLUTyMSL95rU/K4=;
        b=a5tFVpeXdRBAvr08LvaHVF6FiehV9hxmi7CBwoaEWmBEMIuWgSTROrQh7MHAGAnKwI
         SVSca3UPmMF7RCnz+k24QONgC9Sd3xQJ4/eZE05OQSLQJ7XFHx47WUyvzTaj5RKppWli
         7OYX3MnIjNAnWKWbuGvqE+ZzTFzFrnkCo4gXf1hpb5yrBNRWmiNPHhHLsz34IkLvAE9V
         bnlrVgMkhhCjVwVy+NDyh0KxOHC0R3HOYYBY23rvtiVdXT1behH5k5tYEXgE8yl5wiNV
         00VepRLubZVCBBEVD4DZAST1AnOHQ5yE1BC66ts8XnCUA9t05eeA8LWvvoi484kGmxfh
         9fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348230; x=1788953030;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rup8x5pej3Rrg9D+HqWOYXywpsyciLUTyMSL95rU/K4=;
        b=TDvjjQfK2WsI86NHO8CVf3GtZ96B59sTtGdyiFx17B1Jhuim7yojLVPlGOsHPPjXTc
         eDwONy1VlPadH3JT6JGgUSYTBggEra7zkhtE2x1aHWpj3wTEoXPiG3zracfD2HfNgqJq
         PAQQDtmeDGm9KHgZLkhdz8asTUr5s2d/dqLRJQXjig2XTJgdnSLKxVhK3XkHOb/PnFwW
         l2h9ZtYCHhnC66KMANUmdYVMXYXy+S85il/K1oj/3mmndXpdKlf8vborQ9ausgTaR64r
         k3In8KQNCWrfHAPfEHxT6RWieJSqrbETyQR1RZYOi3qkR2BCPwtNm0RZ6HUqDS6xsjTH
         5pKg==
X-Gm-Message-State: AFuF++mmGQBlhgBcMgjdENVmKfMiW4TcNdtRTGYlFXsKF4Nert9qtLSs
	YptA99zpxMkl7gtApOO/FTDMdvKuZDiBXjkzdl6zAi/yktNms9oXryMiadvsIqvQyTSqnswaHxL
	w5VnFkfXm7uSWA7Rz0iNJH2CY68GE8Fs=
X-Gm-Gg: AYBFou0I8/QTOgO7K2GtDIeepMGx4Zuwp6xy1MVye3BW95MbsfxmGuX2CU8HMhb/ne2
	0IJwCY3oyEBvMi7Q4zIrFDwu1BMbINy2btmHG5sxYYF1Iz5W/qj39/3n5w+ijyrfuuOpm+HffbC
	Mj9B4XQyesIdf7Q3YD+4A8GdOcyUXZbgQ2sltLuJ/crbE1jFkJt79r8QSozlRVqnrTh4PiD5HQR
	GO1rj1PwEkEKd6GLQUsh+NXeQdY2dmDIdU2peiuoFaQk3FujjJsrLLEw/kn0wMBTstUP+JqEGh5
	Au8G2V4EwcVWlyv3ik6LYQRf79p3EyUJwLg3PVHLQRGW0MymLF4OArf1UghZxpXLLbR7177pvVv
	/O6qubOQYEitMVYypkd4WBfAcJh0sgY+JoLU=
X-Received: by 2002:a05:6102:4243:b0:786:e7a0:603e with SMTP id
 ada2fe7eead31-78a1f233cb6mr1596928137.7.1788348229992; Wed, 02 Sep 2026
 04:23:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 04:23:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 04:23:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjahszxt.fsf@gitster.g>
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
 <20260901-758-introduce-hook-v5-2-35cdc6be3cc1@gmail.com> <xmqqbjahszxt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Sep 2026 04:23:49 -0700
X-Gm-Features: AcwNN1XW8__At4T2lBA1xbR6YkrF7LdLeL90t_qYqErwEJn3ipavwBZ6IHg1rg0
Message-ID: <CAOLa=ZQavuPbk-2XAGoGxKkq4y0+x2VBQ+r64ZnAL2O3MjtvBw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] receive-pack: move message generation to separate function
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000fbe5ee065a7e4453"

--000000000000fbe5ee065a7e4453
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
r>> After git-receive-pack(1) has committed the reference updates, we call
>> either `report()` or `report_v2()` to report to the client which of the
>> references we have updated successfully and which updates have failed.
>> The only difference between those two functions is that the latter also
>> knows to provide a more detailed report about how exactly a given
>> reference was updated.
>
> I am torn between praising "bool detailed_report" and frowning on
> it.  As the above describes, the difference in behaviour between
> report() and report_v2() is if they emit details of per-command
> update status, so in that sense, the word "detail" in the name of
> the parameter that controls how much details the shared helper
> function gives sounds very much appropriate.  On the other hand, the
> difference in purpose in these two functions is which version of the
> receive-pack protocol they speak, and "This parameter controls how
> much detail the report contains" may tempt careless developers into
> adding random new pieces of information and break existing clients.
> It may be more honest to give it a name that hints that it is about
> the protocol version.
>
> Using
>
>     enum report_version {
> 	receive_pack_report_v0,
> 	receive_pack_report_v2,
>     };
>
> might allow future extension, but it may be overkill.  I dunno.

I think your reasoning does make sense and while the code is _okay_ and
this is probably an overkill like you mentioned, it does draw the
differentiation being a protocol level change rather than a mere boolean
which either protocol could use. Let me add it in if I re-roll.

--000000000000fbe5ee065a7e4453
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 93b0a3238c4c9baa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWUIwTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVM1REFDVXVwQVNLMWs5Zk5FWVNpa2pzQlhnbjVlUgpoMUJIYmVwWDRC
TG9XYTJYeHo4cmJuWUxqSE5HVGQ2YXJhdWhaMy9yL21TbG1HZTNRSEI0a01FVDNlTVBUR29rCmRH
bWgwTStqejJDVlo3bU9OMGtXdkhhMHh2N0pzNzk4WjF2ZCtBQTJ4MkNxQ1BzangxVUhxNzJqNXdt
cTdQQWMKZlR0ZURvdWUycmpYcmJRVEhFNEN5QTJ3ekxUazJodXdSVUdQUXBMYWdSTUhIUVpSbjMz
Q0dabXV2akpaVWRxMQp2bitJb1kvQ1Z2KzFzWXI5b2IvQjJJVmdFa3JpcS9IY1RMQ3lBVGFzRTgy
QTdNelN4NDJXOFdzT3E4RVZrTFoyCkI4QTBPa2FtYy81bXRSMmZlUW5jOXVSSFc4dXJCejYwTU42
K203ZGRlR3kxY05uakxNQWxqU3F0b3lNRXRVc2YKV2w3MGU4NDkrclRFLzcyYWVGQWpmMThrbEYz
WUlSRy9DVTRmU0NFMkkwSlZiQWRYNFJZajJ3MFhaSmRNQzB2WAp3SnczcVlFOHBNTFlNRWNYVDlt
M2R4N2xMNDFvMURRSjY4UjNpcWtweXByQjJLd0Y5MmdNeHUzdVFaZkZGcHlCCmQzcFhRTHNRQ0ty
aDhxSHFCc1VnT1BNanNMZ1V4Zm5oMVN6c2Q3MD0KPUluREcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fbe5ee065a7e4453--
