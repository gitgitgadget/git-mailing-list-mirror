Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430623C8BE
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381508; cv=none; b=Q/b9OnjPLcEYijL3BU+3HGNXJVpf12MR1ygeiOHr22zghQ7mM14Feu9cN4ISsMihP7/y5SaFvprZxntmsQAYFXWURTxk64gYvM2DRRlCtjoWdj7H1pAEmvTCeUFyynaADBjUm2433gQ7JhTYfzhMQQQYfQ1H8TiO1h5QpDbjwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381508; c=relaxed/simple;
	bh=BZkScO7dkFxppprpDA0kbfYtmt32Kt7kJNJlNlRvPvk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1P53TwVjGqzg/DIoCRxzD8l4twglQztYv5P+5xMXj+iWXlND1ta6ikouXJTewuHzbeoORJNHMkaCt8geRt6OGh+TWkMBOv4m35AJ8u4FmVpJOpe2Lo0w5zTlQohDealBqQMpNi8txPFkXKFHMH9URbmo4L2tK6qALLeHvjulnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLhRhBWD; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLhRhBWD"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52379e9b7d2so1094391e0c.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741381506; x=1741986306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpYNhQTdltDfzruOVwb0u7ZKE1hReF5kGSTeDqyq04E=;
        b=KLhRhBWD1oveDbxDqSOofHjRnDmSA7DQN4TVJ8cW7mzTmxfkM2Xl3XtRZAOkJGAnbA
         EBfIAEbQOKwTWVfIzTFuR4xyYMuabS3ZPkzX9cqWLe2otEhqwntsBgLB9ezcDfgPzTDj
         YGyLWUFCFFjA0E56xbc2GGqWSkQ9fb0z3pBljF8rCYbIc5thWsH1Me2AHn87nrOHm1Ky
         2K8T/ko1IaMiKBJnIaXbXwGWz9oXRLnWHqqmdKPEhKhUg18q3Q2z9v5IjuYckvvR9GFm
         hmQR4x9v3nPr7G734OsyK8H+6oeQLA/XKaW5ujJHQuhZdAckVv3crHEtNZXdu7H3e741
         8evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381506; x=1741986306;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpYNhQTdltDfzruOVwb0u7ZKE1hReF5kGSTeDqyq04E=;
        b=tyKoPVcbP3qvX5iKOD7QL4Qnlq8IC6fof1w2lt6GE7PuBaWHOEsZ9lHN0bE8dAKYZM
         2scv0CBfxnniZNFwBncEMRq1ep9PGi1UJdtVm1FurlrlYszMtzdf2RDgXOStShCqZe8R
         6A9b0J3fkk6wIT+5SK/K8MjLmVIRUk0FoNJ2ntcVSIyvH8HNmYwMsR8FpV1+wfpOibSd
         A6KWc7qXGpjjsxDUtGEnkxQgxIvKltXQk1HbebaRtQz/W0dSs+rbByqi1myBK8ikOLhb
         uPZ1jSo8Y5IB7dFQ0U94+Tfhqx9iM6HRzIMWfS4X3jA6wjnZ+rITNRZiWUKZVJbWtIIm
         SZTA==
X-Gm-Message-State: AOJu0YywO/KQNi8k15R/vDOErb6e24IeVEzWZbNXfHqDwxiuSVqXz6ZZ
	iv1PbSG2iNK+buXLCclqJhNlCs2y2O0VQw94Y3y8NUFMSKWYQ0DVyOOPNRQMtZFU4wZnpGleAg6
	8Z1mVPnnpRJZgKJK9liBEkywUv3A=
X-Gm-Gg: ASbGncve5K7TKTZCg6t5WqVqb4c9e8VhnW5JwwoF4iPdMIMG9bANaEJgIylDyP8ZisP
	LgeExip5RfeEfQF1p7zqoXKjPIqzCIgIzEkRlHbTQ3qiG+M6J/NwpbCq849pUAPC9okx4+XDBZZ
	7cdYKenxF7YydhARgIf3qmwi7QfHrnjbO1GkfhsY3Kjutzm+f7z8+S6adLQGFE
X-Google-Smtp-Source: AGHT+IEfO7PC23TDyLVwZAQm6R8z47jXNY1DXLF4ftYI6ZhJVw+99X/k1bIIzY5sQYplPhK05rB8BwWYUAmNXjd2gNk=
X-Received: by 2002:a05:6122:1d45:b0:523:c4df:4de3 with SMTP id
 71dfb90a1353d-523e4088cc2mr3982887e0c.5.1741381505891; Fri, 07 Mar 2025
 13:05:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 13:05:05 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq34foefh8.fsf@gitster.g>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net> <xmqq34foefh8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 13:05:05 -0800
X-Gm-Features: AQ5f1JrbXzllaAhV9AGd0aHoNgCkR1bPpAwjMrgMzonjQM1t251pJBRjEQMiyM4
Message-ID: <CAOLa=ZTSb9c=Cb=OEhoXuavKHhamhV4rAQsiJMHVnBEBbtwH3A@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] refs: implement partial reference transaction support
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000013e4a7062fc6fa39"

--00000000000013e4a7062fc6fa39
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Mar 05, 2025 at 06:39:01PM +0100, Karthik Nayak wrote:
>>
>>> @@ -1456,6 +1471,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>>>  					    update->refname,
>>>  					    oid_to_hex(&update->old_oid));
>>>  				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
>>> +
>>> +				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>>> +					strbuf_setlen(err, 0);
>>> +					ret = 0;
>>> +					continue;
>>> +				}
>>> +
>>>  				goto error;
>>>  			}
>>>  		}
>>
>> This new code isn't reachable, since we return in the lines shown in the
>> diff context.
>>
>> Should it have been "ret = REF_TRANSACTION_ERROR"... in the first place?
>> I think the "goto error" was already unreachable, so possibly the error
>> is in an earlier patch. (I didn't look; Coverity flagged this in the
>> final state in 'jch').
>
> Sorry about that.  It shows that I lack the bandwidth necessary to
> go through fine toothed comb on all the topics I queue.  Perhaps I
> should be more selective and queue only the ones I personally had
> enough bandwidth to look over (or have seen clear "I looked each and
> every line of this series with fine toothed comb, put reviewed-by:
> me" messages sent by trusted reviewers) while ignoring others?
>
> I dunno.
>
> Thanks.

Apologies, I see that this was also present in the previous version.
Definitely a miss on my side. I'll see how it was missed in the tests
and add one if necessary!

Thanks!

--00000000000013e4a7062fc6fa39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 28ff3a1c1bb275d7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mTFgzOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFgzREFDQ09iM3pzZ2xIcGZYQWVjc3VvUURaQUlqQQoxeGtGWGxGdEZP
MGJSMDc2OHZMWjdTSlpSV0JLNzcxTmwreHhsSHBBYzlFV05SN3c2Wi9Ecmx0ZFRVYTJ5cjR5Cndm
dTBBeks3R1VHMVMwYVppbUJsOVJhQ3hqOWlYRTdPMkxGV1JrN2J0OWFmV0pkWFJZbDdpUnMwanQv
emhkLy8KNlo5eXc5LzBSZW5Pb1krc2V1NVBsemphYkVZdlBCRGFxZGxQSEh4VlNDbmFEckpNcFdB
d3VrQ0h5aS9ubjl2MgpZeW1sMnp3TVJMYUFHaEsrWjEwZmF4OHJLSCsxNzZkNTB3SGZqYkRzYjVJ
REVHeDFOajdOUjhhU2pYNmxydlAwCmZFdG01OUNxdEswdUhTdEQreFk2bjJUVG5DR05hNWwzeXdk
eXZJYVlWVHA5SERST1gydFBTK1FhOWtpcTUwN0gKWWMxYTV6VjdHRVZxNzZENVdCRE1DQThxMFRL
ZUMrZlBnR3RJcnViZkRMN3VoVVZUaVR6bjM5cVoyb3NuQ3o3NQpyb1Y5OGo4bTFzWm5kb08yUlds
RWV5MDhYTWxsVU1odG05Y0NjbGxYVWs1S2hFMEhGN0tHSUVyeGRUMmVLNENYCitJUFVyQXpBU0dl
Nmd3V29uZUdjU2FTUHhWNDBSa1BMeE5OaFlHVT0KPUo3akMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000013e4a7062fc6fa39--
