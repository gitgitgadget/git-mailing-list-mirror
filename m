Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068935EDA0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470627; cv=none; b=gaMBp4cS6TeWtVGWknAWUqbPdOxVhw7hl+Kjnh2V21lVUQzhCqR8kBVGQbh+XyqHInI4DAouE1h1VtNLKW10xss4pJd1YmxAGxqOL3xHlIeWBoNil7UB8nPg3i80V8+QkJJDIu544kH8xDHTZqxwTlwVO9lwW8jy0hQnCzrIr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470627; c=relaxed/simple;
	bh=vhdqrXoxsrS5vE4/LYXX8TIELiJ24FUsbnZbmQhoLKI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou4zUASItNzp/zIzyp0XHKpTCEPBySQjlYo9qeDOlP89grJUWPM2OecEXmWMuppPYHHWCN5R9omjzaUVHANKyl01SWFpRkjTR72vgGVLN8bwjx64xJskPICW2AlHRjTFeP7oQSiP61nkqlPtEoJQglNKGw/XEIkxEs02x2PBURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaNzNAHq; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaNzNAHq"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-941275fece4so191042241.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768470625; x=1769075425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwO2H3qBvKLcx5E0Xq274ZLAl+Jxq+wp0fnmDuwkHys=;
        b=BaNzNAHqpcHGvvpCHHhayjnuVMicHTBTYVPcY1hmofhb9tv0Ne2FPEP5jq90RwInnl
         JgJ7ggznk82PaqiAsHrLre3EJWSX1+VHOGHMl2aYqzAigj9KXxdARJzP41PLGyKLbt1B
         thIOhAxU7VpFG6KwyhKqTM6lGRjVqmMNpjPuEoPGxBXPY8nDoJ0esGeUunsf4UWIoEET
         o+7dGtKRFGPcv1tWGWZ2aqV5CSbHj4PcscY36+s+H1SnghML20IdaeDescZzaFx0jCNx
         MWx9NiJhiNxSsStRz/BEtt1Wj0/7Ku7zQ149jsusYmbETsuRlsbz5PM+davhJuW+UyDk
         xZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470625; x=1769075425;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwO2H3qBvKLcx5E0Xq274ZLAl+Jxq+wp0fnmDuwkHys=;
        b=j6GQbTPsKhtcm2xaOzB5bUrV++JgqhrrUIzhkfMAINmtkNpRTmZf3yWrgp0rMLFeis
         w1ub2L1RDmIMUGrUVWredL+jT8A8vSWRItC5U6U+flT2g6Fhj213dJsX03GVyeygePW2
         BetgbP6J4ZNw3D5ALFfefx6BmIRd6ot56I5+A7CmEOB2k1Ld0afCZ5oQiO9rb7Z1aY7B
         EaNz9vHMGDhEvAk990b2OaHKtMd/UdxYyEyZV78cELNRvFYgQSWE9TqQpnhb+8PMu6gZ
         lt08iMlAsPlHTwi5Ok13owYspibFPN8Pr5MnynhsbS2j0Ho/MX/m4f4JSzWnGHG7n0EN
         ipbw==
X-Gm-Message-State: AOJu0YxrQ1hGMdXgmUIfF1u5HubAATrQdg0eHoMpMojtBE/KsEyBlrq1
	W4aQSc4G4OpfQUwpjCevvO+cO7syKeQa96ZBmpTXI1GL5LVxmR/fkdfIAWjf9ggbYSEzwoYbJ2P
	k9SZoUXxWFR7BEBIevOTt749SczlijAA=
X-Gm-Gg: AY/fxX4iJ5cqIYyCxps+BeQfu9PSh/BEbK/ItjPAgG9fcENXjM8Smg4GmQ/AAfAXoZi
	yYVSqg8ckMT7sMFgqh2VZw9NAfoQYsJN0bort+QAXotQDxtAkqnlKt8yLI6r5zW8Ai3DcaQxse6
	Zh1vzsaZUcIal+ZzpQvsoWWVO4o+bVx9wx800vjYZ5wdpX+xygaFtubGmfhRpYye8xVF6PzdiVA
	5ZE10Sht2HB9xxfFfktXe2003poYvL5XOdATzVM/CC4YC2/+zsxFnWsDstuy2h9fx2SQA==
X-Received: by 2002:a05:6102:1612:b0:5ee:a1e5:6504 with SMTP id
 ada2fe7eead31-5f17f65c006mr2148430137.36.1768470625113; Thu, 15 Jan 2026
 01:50:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 01:50:24 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 01:50:24 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwm1kf7gr.fsf@gitster.g>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-1-f5f8b173c501@gmail.com>
 <xmqqwm1kf7gr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 01:50:24 -0800
X-Gm-Features: AZwV_Qh3jsxL7cCCwohoAGd1-lyEpLhhRBkDZcawSNFMzqZfL8sU7KSqP3ueug8
Message-ID: <CAOLa=ZQfjb1OfHJp6MVkbs=5Wey4Gp6t-jmEQSrojOsp=ge-Jw@mail.gmail.com>
Subject: Re: [PATCH 1/6] refs: remove unused header
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, newren@gmail.com
Content-Type: multipart/mixed; boundary="00000000000067f90706486a2717"

--00000000000067f90706486a2717
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Some of the headers in 'refs.c' are no longer required, let's remove
>> them.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs.c | 2 --
>>  1 file changed, 2 deletions(-)
>
> One thing to note is that The resulting file refs.c still includes
> hook.h and because of that, the removal of run-command.h from here
> has no effect.
>

Good point, let me modify the commit message to explain this better.
Perhaps:

-->8--

refs: drop unnecessary header includes

The 'sigchain.h' header isn't being used and can be removed.

Similarly, 'run-command.h' serves no direct purpose here. While it gets
pulled in transitively through 'hook.h', we can still drop the explicit
include for clarity.

>> diff --git a/refs.c b/refs.c
>> index e06e0cb072..965b232a06 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -15,7 +15,6 @@
>>  #include "iterator.h"
>>  #include "refs.h"
>>  #include "refs/refs-internal.h"
>> -#include "run-command.h"
>>  #include "hook.h"
>>  #include "object-name.h"
>>  #include "odb.h"
>> @@ -26,7 +25,6 @@
>>  #include "strvec.h"
>>  #include "repo-settings.h"
>>  #include "setup.h"
>> -#include "sigchain.h"
>>  #include "date.h"
>>  #include "commit.h"
>>  #include "wildmatch.h"

--00000000000067f90706486a2717
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4808a3464d733b44_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sb3VGNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWNzREFDajNOSER4aXVSTzBNdGR3UTdnQTUyUjJrRQozSm1qc0NTK0NB
V0NFTGl5eEEwZ2Y3eTAxYytxMi81aUs3TkZIVHhDc0lKS2p5ak9DVEtIbnRidlhlTW51WXlXClg2
QkNMUkF4YjduL1BUZ2lnR3RvamZhUHdxRi91V3Q5Mno3UlY4WHluS2t4UyswSjNpWjFUbjVrMzFG
dXVsMGgKRVNaenJ5VW4ycDkxeksrT0xsRmVNaGRuR1JRSUs2WlZOSTZQV1lQSUdMdkVzbkIwSFBD
Vy9JRzNZa3hVKzJzago1QUZQOEdwZmVFYkRxMmdYSVliZzNqdXJZYitHOU1ZVHFXdHBEdVBrS3c0
WWxieldSUHZud2ZUd0JTbS9Vam1UCmxhVnpWNENDMGxleEF1UmRZcXNObmZ4dnNoVGpXckZxU1RK
NnlubkZmVmoxWW9odWN2SHlYTjVia0d5QmVaczcKQUltZjcyZDh1Y3JjTng3QjE5SzhsemlJNDhq
TTRLa0ltdit5K1Q0cXRNQ3FPNzMvRk9UQWZ1ZWdxb3o0aE5oVQpnUnNpUWpwbnVVOUVWY0FGL3R6
SkhMVDNhTGplVXh0SmZjY0JybHdwNXhsbjZYbldvZHpxOHdaUEp2d3llM1l0CiswSjY1M3l3eVc0
QzlrVVBoTlM5SmxySUhTdEhtK1R1MlVrOVpBYz0KPS9BRkoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000067f90706486a2717--
