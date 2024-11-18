Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B318EFDE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943032; cv=none; b=dW0e+l3AyFrus6byU7cdFQdp80Om35aXLdmRcrkJQRbddkH+VXt/zuBfOV97rFTc5r8i7qZ+Kh50UqqL5JsdRkDdcsx4cwIq/fiaGUkUMApgQ1mAOg+EytURKPDuOVC1IAf+audA7LsbHeW0xZLcL1jCHEcm9Dy/9ppKB72H7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943032; c=relaxed/simple;
	bh=lDpxUd08KJO5wz/1+wBS2IdP3hw8TlHKnvPS9QbkNSk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpoILS/pwyz/OvAi5PeSz7b95Ffr75xZzWMg59P86oFzqJcPjayZlUXxgNC5JuBfu5KBaOO58ckHTnB+7baf/ZP99Lwr+gIyrYNb9cc9SqkS72SAlbLE9JhU/POWmurAJpvv+pJahLdO9FwmGS5vzd90NVdhZu8ZlqRmew0BTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx8DRzEJ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx8DRzEJ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51473420805so1533956e0c.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731943030; x=1732547830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/U9rd9B+yVof+1jbiWp+W6kzmacSx0ays4X4YGORvzw=;
        b=Sx8DRzEJtN/iRG16GQ9v/W4ciRRScGj95mXv/0+0mhe/shDkB9w7ldg41ucMA8ybZ7
         VpPZJJ2LHHJHEa6KJ4zYL5hBOPrQrM14vZtA512DQiu6ec9eD5mpUwTNqVNbpdEoZ3gx
         yrznT1wNc9Xru8rxWkOayRZBXDO5Yr1O8CrKo4Iu+ebtVUDcJE/SLgFtwxmn1ZiHM6k8
         ea+FJgK/xWeFlJ/n4/2t8LGKGwerWwGbgbjXtiW1meRht4o2Z07rlnAwKEFDkaMYCGA5
         jXcLmlAzNvLHQRzNaOeVcoNCBQuor3fUI0FQvkyF/GepKMj3BVJbbA85c4aIteiYml2K
         s/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943030; x=1732547830;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/U9rd9B+yVof+1jbiWp+W6kzmacSx0ays4X4YGORvzw=;
        b=hSQzLRcd+t39S51plX5fgB+O2qMtQWPFY2hQajyhR0tq6hFCnckupjywAh2LBx7gsP
         c8VMH6Fb66+19AhmRs18vZniPros6t5o/jfhtvNZtR2Kr3X9Zxb61VXbWbRhxQvyMKng
         a+2vZ0CD082IvPtihTZjPznNZ0waa4DR8p1IiTiFguHHf9sS1x33qvtCsiipkn8gbjGc
         TyUH+GhnzGaCAEXv/HUbXOkTkBg+iPiHZwPz0rFwf/vONGpKFunNO5fvTfcj+wBuCeyt
         hHMEw7+FO6wXJZGHCasFwLrtlGJrA1bFr4HKg6EnAwzho9X49p6EU12jDg6wefL1UhOG
         xcng==
X-Gm-Message-State: AOJu0Yzc+oiDXOLGOHnTehvYPC9fleW32Ax/IlELGh6Wo0dsNp/ZMCf/
	kSUrJJgXqrDGhKtvHGYN15a3Ii8jTX5kIrHvNaw4Qr/g/C6TW2p6dwDM5egAT2pBah8usmpkqx0
	ogwM5XOnHlNRZGrUdqXmUZV7DyM8=
X-Google-Smtp-Source: AGHT+IGTF2eD8IzKxvhoh2oGZ0PY/hh5b1yvZ+OeUoQaSE6G+wS/ZGwydd4lz5wMQ+4mql1H72b6f3Nzdcki9kw2rJA=
X-Received: by 2002:a05:6122:1787:b0:50d:85d7:d94b with SMTP id
 71dfb90a1353d-514786d3b56mr9909929e0c.11.1731943029828; Mon, 18 Nov 2024
 07:17:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 07:17:09 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZziU3wmP0pigGRRr@ArchLinux>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-1-761f8a2c7775@gmail.com>
 <ZziU3wmP0pigGRRr@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 07:17:09 -0800
Message-ID: <CAOLa=ZQ=+ex1SaRJ9-XuCTMoRrfdgXDMyjvRkTLZUfahTfFhnQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] builtin: pass repository to sub commands
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000108d2506273169f9"

--000000000000108d2506273169f9
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Fri, Nov 15, 2024 at 02:42:14PM +0100, Karthik Nayak wrote:
>
> [snip]
>
>> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
>> index 5250913d99eba18a28878d3904cb7b2399670d02..e5b1fe287e3ec94f0d8a3a99adb68842d52992f6 100644
>> --- a/t/helper/test-parse-options.c
>> +++ b/t/helper/test-parse-options.c
>> @@ -1,8 +1,11 @@
>> +#define USE_THE_REPOSITORY_VARIABLE
>> +
>>  #include "test-tool.h"
>>  #include "parse-options.h"
>>  #include "strbuf.h"
>>  #include "string-list.h"
>>  #include "trace2.h"
>> +#include "repository.h"
>>
>>  static int boolean = 0;
>>  static int integer = 0;
>> @@ -282,14 +285,16 @@ int cmd__parse_options_flags(int argc, const char **argv)
>>  	return parse_options_flags__cmd(argc, argv, test_flags);
>>  }
>>
>> -static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED)
>> +static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED,
>> +		      struct repository *repo UNUSED)
>>  {
>>  	printf("fn: subcmd_one\n");
>>  	print_args(argc, argv);
>>  	return 0;
>>  }
>>
>> -static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED)
>> +static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED,
>> +		      struct repository *repo UNUSED)
>>  {
>>  	printf("fn: subcmd_two\n");
>>  	print_args(argc, argv);
>> @@ -319,7 +324,7 @@ static int parse_subcommand__cmd(int argc, const char **argv,
>>
>>  	printf("opt: %d\n", opt);
>>
>> -	return fn(argc, argv, NULL);
>> +	return fn(argc, argv, NULL, the_repository);
>
> Do we need to pass the real "the_repository" variable here. From my
> understanding, we could just pass `NULL` to avoid including the
> "repository.h" and the macro. However, I am not familiar with the
> "test-tool" helper. It my comment was wrong, please ignore.
>

We don't _need_ to. The test should work with NULL too. Let me modify
this, thanks!

> Thanks,
> Jialuo

--000000000000108d2506273169f9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 76550702ff818e4e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1duUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meU9iQy80OVAveElrUUtuaVl6bVlUV2UzcWRySGtoTQpZMHFjeXlEVFFD
ZnlVRDZRUXZLSDlyb1lkQXEwQXNPK2hmOUpqSFZVbEhPNVFRazk0d0tJVHYwd084ODBlRW5NCksz
OEROazl6dXRrMlN1L1dkM21lN2lucVhpZFBNWXN2aXVmTVRwbFYyRW1naWVheE9GTlVXT0w1TnQz
T0UzM0UKNnFrOWFnblJxbFBnTTcwZGtaZVdMV3Z5STViMEx4MzU3Z0dHaGNERitOaHV3N3dpZHN2
ZFJncWNZL0N6ajV4cQpIcnJxaHF6RFlWTytrU25MY2h2ZTQ5dFZ2bHhXdVlDYk1ITlk4NVZWVnB4
WDF5VzVZd3oxcExwK1l0YWZUNGZTClpmQVV6RFZIUnRIb2JLaTRtUmZlMmk3SVhTZW9HenVGd3Y4
MTQ5SkJXYVFkaWlhdURNekpUdzNrRDFQUUF1WVAKZnF1dzE0TlJ4SGFONXR6Mm9JZHVTSUdYeUMx
WmdxbnlUdHRjWkF3bEFiMGVxNzJqTHRUdVl3b1J5QmNQR0tLYgpadFhRbUppcTVZQU9iN2NKY2FD
VzRRdURLcmltMm00TlpnaU9Tc0NoZ1RoQW9hWTBkWlRPMFJhd3IrWm45NC9DCjNYQ3llVEhYVy9U
ZUl2VC9PMi9lcUg2SWRFaFdlaEVpRmdMYkJ3Yz0KPVdTUGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000108d2506273169f9--
