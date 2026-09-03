Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BE4EC65A
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453087; cv=pass; b=dWkY1KdPHb3NzY9hyqQ3M4056UOk4AeT8SeLBpGCOFJPyqLNn2It0d6S3qEdCUm1CZy+A2CbIhWRDaq/KT3xw+0BZhwq6+XoBuPYj25M3b5UKhtDxwgjuGaoI2GyvK7Ipm3P8uwQT7CJtJDI8utU4zILZYJqUvL9tV+q++XkOfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453087; c=relaxed/simple;
	bh=5SxrK5SKB8YNSNU4ZmJLqUuY/cBtNgrt+oxKmWRSFQY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1yXJOLod4w2c2qX+750UQLA7yNd9weFYz4m82NPrnCdVhGBkJ/07fhJKzYsk47dQQ9/aJxK+siQWLw0XHjSMBlwfDL0gVL7e9vuyycNjpU8Fwxajczbwrzdh3ueDSFMe8fUKFekyvZklZbuPZKftCAMXKlUOLiiA4y4G+p2S1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcWsZ/0T; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcWsZ/0T"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c79c9f7b54so26828e0c.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 09:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453085; cv=none;
        d=google.com; s=arc-20260327;
        b=k/LpYL3p1kKIOddu3fWRPTk26YNEPJ0qCA8spfUJjtWEU++iw4fakYiwyqZWlDB09q
         JbVBKAlrGb2fqBWerk/tLT7bqBUukNxk1icDss3ECGQIbuh9y1dRXNbaJh6aNQEyI+NQ
         LJZ0HG2Bt2tguxNOcQHue1HyvHyeP2MrAjsQmKGpWihQzJEi6SrqYEcg4M+Toba3DGiq
         FnhvRxeNsLOcb5YMSPeLyxb886Q8MAmakHcOqIiLQrKF7WmTphxfHPZjEkc8m3500nsn
         LynTu2FAqkOuqvcInykPivEH+bIYg4EZAK00pHGQ8zj20d8bsMh0bTK9tzQXIBR/e0Wu
         P/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Rq00oK6aLtt43qQ18qk8cfvxF9campP8aJC8S+752Ws=;
        fh=Rn9EFvid+bDsg8CskbihT0m5GvhnTPnaZZUMwd/52l4=;
        b=rv07k0KKU/Xfq+Qkt+yFC2NgCbqOygh/72BSuQ5HwNAVlyBVK3/2zOMSjENg6evbTl
         1eX9XSH2c5Li8YKX+ADF0jrKbCwA6jaFz+AuodxSUwWUf23tU3qlN9/if4orMAxsK1ti
         XIwQ/ws8vEdNLuQAR0XqAbKdergSRoE+ZvYmBK91AnPB0XaMP8zeES9aiiOXPAETjVfm
         aj8lxBxCjHl7ndTHjYxWQc97ad2ziQbGsXUPPyjQ+BvYQftyGifaAAmhR413BQ7r4/tA
         UuM5XXWsUXRkM3osXUAYPjFdgIxiOO8uk4bhoZF9Tr4v13BHxfVFFurf75gkA6z4BmuK
         Cdow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788453085; x=1789057885; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rq00oK6aLtt43qQ18qk8cfvxF9campP8aJC8S+752Ws=;
        b=mcWsZ/0Tt+pdU06wY0N6YJibXt40mU8JjQC8lM70IOa1FsrmeaU4jmFzKcUzL2ln+G
         /mRA8NDxC0cdtYssxKpjeawzM2yPL/25YLIHm/l+xqtuJhfjqPvkgnVN9d0pdLdyZHjg
         DJL0cSS6vD2uNs8NoLVx6y+BP8DuYtq3zMPGLlWsZOiruMsRWeKLvNs1t8OEQkL9QgpV
         mmN2o5vIMfRP+p9pkNjjOH/hDCdKBtdNNRq5ouaC+QFQVXF3q4GUJcrtfSoLyaYt0ZP8
         FV93pWY7dKcqd1ybfD+ZmJ/KnaY0LHyguMITcpodRmIqs5XuRwfiELYP3oKDgdHAmG/x
         ZyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453085; x=1789057885;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rq00oK6aLtt43qQ18qk8cfvxF9campP8aJC8S+752Ws=;
        b=fRx7CfGW13qOtHkZRFHx5/e9vbfUfmYDSaGMRWowW2Xsz3YqaAXK61Hx3ygnXF0MaO
         bMAhBWtpvZTwblxFSbLohs1lMLZbQoyv1Ofy4GDadHU8bsa/sV8kRp/gFHFXKELRlW//
         CxQB8fIdn+93QeFstu0Ige1U2/fDGg+ynmOIo5BAzL3yaboJr+0BLqmIeRon4KIsTYlq
         G5MPuqTWUvewTGFcLEAwmL5bIDorM53Xze4N7QqA7H1PXVwXHWKPmUi4jF7nBeP3YJKZ
         qXO71LxD091eCV8WQew7rQ13JvwmOTjbP2QcTGJAFga1fhtjpf/MxaCgG+aTQFkVA5yj
         GvfQ==
X-Gm-Message-State: AFuF++nTg1CexQ+sCC9JYGy/f9sXdQBTV5FF5ujs2Say9KEjTmCD1nPN
	9m+4AZBPwsqtm6MegH9YMUaxP9ElCvKBAJ4ZbgY5yg5QOQAOF6Xf/d1CDpDur+PHc8UWtIIHvo6
	sNRne7grq1tY2I5nbwLZBDVJ9bfgINxQ=
X-Gm-Gg: AYBFou2ES1MUv2K8tzt/pGJh1HA/I6/L77+zSdYObGvS0VjsxWtb12NpCNemdO+0WRE
	X/KsgYx157X3LksRuu8gHcOnAXtkyp0cm3JgDYQGiDUa/wS05YZiH7JoPOEGEviMkSCZdh01DCf
	OEWClLDDcdlTuGCP0EYeNFUWmzXyAAoPXEpDK+JX4QRTYCWfYnQ5s0R/1jGOU9Icd1lZUasaksX
	VPcUyhIify0qWaxkqqjHHCYmuKh3TrIudJdsYjhGP6wi9WSbaBWYGFiQhLRR5occz7xzGdZV4S6
	xkd7yYZvZl60yKEc2xErNehNu4asjiF/csRDzj3sHUUtSWLYNAX8RX/Ld/b6aZ5+rID9uBZM+3U
	erKx0cStDiBXb8OoS8UsrzhBh2P3cM0fL9v8=
X-Received: by 2002:a05:6102:292c:b0:786:724a:4e94 with SMTP id
 ada2fe7eead31-78a1f365f14mr4728314137.11.1788453084804; Thu, 03 Sep 2026
 09:31:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 09:31:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 09:31:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aplF9d5ajwO9AnG9@pks.im>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
 <20260903-758-introduce-hook-v6-2-6283b1fb9b1c@gmail.com> <aplF9d5ajwO9AnG9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Sep 2026 09:31:21 -0700
X-Gm-Features: AcwNN1WXuKo97y2ARjQFN3WQLSFpxVjhr8iG9DC0yG6lzz2QQyUtartZMW0wW4I
Message-ID: <CAOLa=ZS8F2dcUx0iyfXivb57B=bfmRZWvZe5_yab1moOs_eEBQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] receive-pack: drop static variables to track
 report status version
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000d164f1065a96ae7f"

--000000000000d164f1065a96ae7f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 03, 2026 at 11:27:59AM +0200, Karthik Nayak wrote:
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 86933d8d7e..a9a3d21c24 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -2716,10 +2722,12 @@ int cmd_receive_pack(int argc,
>>  				 &push_options);
>>  		delete_tempfile(&pack_lockfile);
>>  		sigchain_push(SIGPIPE, SIG_IGN);
>> -		if (report_status_v2)
>> +		if (version == REPORT_STATUS_V2)
>>  			report_v2(commands, unpack_status);
>> -		else if (report_status)
>> +		else if (version == REPORT_STATUS_V0)
>>  			report(commands, unpack_status);
>> +		else
>> +			BUG("unknown report status version");
>
> Nit: I typically prefer switches when we want to handle enums, even
> though they are more verbose. Please feel free to ignore though, this is
> highly subjective and it's not worth a reroll.
>
> Patrick

I'll add it in, and it'll be part of the reroll (if necessary).

--000000000000d164f1065a96ae7f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fd3c022a824b8405_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWm9OY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXRYQy80amZ2dDlzZWZhVUE4bjFwcHd0VWUzdEs4bgpXMFBZUFFlVVBB
MGpXbkk2RlJFMUhKR3RJb1UrRnBIQlNyNk5OREtIdGNmR0hQOC9pVUNBU0s5dHdkajhsQ3ZECmI1
bXEvUW1OL1o5NWFXZFNVdTc5MEl4dDJEWW9KZzZjODNIVTQ1bnF3amJwSFFhRjIrRHA1OGhDTUVF
U0dPbGMKUldzalZQS0QrZGo0ayttQytZMG1iOExPUGwySllQVTVRUGxoVVRzdXVSR2pNZXRwZjJ3
WFN5eVpNci9jZW1seAo0VVlyZmlMYmpvNEFYY3lEWHQwOTA1Z2h2ZzVUNmpia1I1WjR4OVRYRnRk
YTBubGJiZmpRMzVKbXQ3ejZta0hwCjJkaVVDZGovM3pxbWpWV09renMvekNJOTVBVVplbGFQNlRp
VXplcnovSGl5R1ZvcmJEd29NUktvby9LVW0rNmoKTWtsVVhzdjZEMTZUZmdLQlJHTkhONVdZcklU
S0NQUnh1V091VG1HZ0Y5TGlRbEFWNTVxd0tWRTdxWHVybDZGdwpjYkxWQ3FHdUFPY255WGs1cm1l
NXRCSDMvQlIwTVNzM1JhUFVNSURPUW91anRKQlVDbEpxQmt4ekRlSjFBU2J0CnlMN0tDb0FwTlh0
ZEFsbzA3MWptRnVJYWhOZ0wxNUNESWxjUVN1Zz0KPUYwUkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d164f1065a96ae7f--
