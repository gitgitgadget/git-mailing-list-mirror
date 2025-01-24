Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D323B0
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716762; cv=none; b=YJAQJhu2TIVPSBgJGwDLrEIS9jzFx/3a+++agX/cq++YGbZySNYHFE6MVgxUKHM+2Xzk6ff6dUOarkTFVEtDWGIM7DK8ttMixLNZPN6za9xLIviqM/s8F+/sBa1x3jgqXvHRNaT+s+PLkgVCsF7Hni1gvomKEsN+XWNyzttxUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716762; c=relaxed/simple;
	bh=Q1YYN2xoDKTYadsUQOgyPeFVww0kRdBCVZm4AE87zhs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJecadUqsj7mXSaWXQRzUCnfhpIOD2WN8mikAJT0EpKOw24sBlzoLqkmf18gLBnwQGUU6chCq9+nQBHz4PpSOTP4GGZ4htACvG8gzbuMRAWGWuzPpEz3N545XCu7qWvfCswFMlP0yKWDcVWJhE9yXAuZ1+GVAzrSuZCCN20kB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5ycI7tZ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ycI7tZ"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51640f7bbd3so611920e0c.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 03:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737716760; x=1738321560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fe34y+uGUbQs+L7JNxtQaQM/f+fYg+ux6TyhR5t1zZk=;
        b=H5ycI7tZky0q2JulW4pEoJCbZSM8twZn0TBN5RyZxkU8lknqxxeoqs+2JN3gB/VZr6
         E+xiviApml3Z4EVRbxui/AI4yKWsHpFlFTh3MjEtL7i6jAkReyetJ8JDgFFQTpDzsSut
         7vj+nVKX7KulmlFrml+iAJK/6PMfd01jgJ5WTwWLu+5VF9UZS20D9Ey3eglVCmvdjQwg
         rmBwfqrs6yhmuAfjUh4SaZgqND7SbnYPlISHsyn+oCufTaAxR6PnwO3IUVPUueIrTi6y
         t+Nw7bwUmVS0ZYaBHoK90JayiOxzyg8H1mHcxf6M2B+eTZKp8jm7R1Oq9UTlskjimU0z
         U9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737716760; x=1738321560;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe34y+uGUbQs+L7JNxtQaQM/f+fYg+ux6TyhR5t1zZk=;
        b=EGDXv1Gx41LgmQyuLqHnv7nr+6nYEVDlMXYPxp7uqMsfOjH8nmUBY2aQLipBg2rq69
         HCJGFb0lvmglLNkpIwaIeKUa9w7b2s6+utAgiaIoySiosh1FDBnrai+8chfJPPulcUMj
         wlP+SObVJuEDi7e0bH0HO93J7wiRNVcKuc0THJVp6k8N7m+RxtjfBH0Nf0M6sRefa3YI
         Nxbd+pJ2dTb3Uj9tX5/gx6x5Jbmq3Afk06C5U6YZOCsUSSfZsuzC9NgXLwHYh34n5I14
         hsUDjPCWSTmxHXP/FszPhQzf9TKKF0Klej0Cb/DyMilzhIHiRmRNCcsCKvGLS+k3s60H
         TtLw==
X-Gm-Message-State: AOJu0Yyy0ngc759Z9h7LCqwDf4jAqLkiPRMg6VpO7jX5x6Y9Nj1J8QHv
	F8BWrpWBVG1P8t/DwczTfGfNbxmA3PO9+lxi/L9NqtaczRwCorBNw/8BAY84Grs9ZrWvKmIwqAA
	wGwfM9Vu5osTm2IS+ZP6EmXYmYfs=
X-Gm-Gg: ASbGncuevnsRrIP5MA1RtV+VqeNPMi4aNswwf+8KzqrTZz1oL0aROJKgQByU60tC1b4
	xtLcZRbJXAZ258g59BqdCEMJ2lLXoMpZw7ldyrDiiDyP5tQ1kX9X8+KBx6+Djyy8Bw2xvvdP8aE
	zKmsXSQsR8X5RpBQHCJ3vL
X-Google-Smtp-Source: AGHT+IGwWT/t8GNgjQhdy2tp4uepE8P3Q1447+DtLGu+M81/nujn72QBokOQJlA8gJnTXlu4Mxf2qxsTElG1JeEoW14=
X-Received: by 2002:a05:6122:4011:b0:51b:b750:8303 with SMTP id
 71dfb90a1353d-51d5b39ad50mr25344461e0c.11.1737716759901; Fri, 24 Jan 2025
 03:05:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jan 2025 03:05:59 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z5KAUo4FeG2M1mIa@pks.im>
References: <xmqqwmetgdgm.fsf@gitster.g> <CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
 <CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
 <xmqqldv1tpgp.fsf@gitster.g> <Z5KAUo4FeG2M1mIa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jan 2025 03:05:59 -0800
X-Gm-Features: AWEUYZnDBjpA_lK_k4LPAqXk3pfLvV6c1u8nGrjvPpkYtTrQBMH3V0XQAdgAdRs
Message-ID: <CAOLa=ZSotvEPgOyU0FnZBpNwnpjhBk4-PXk5rc=cQZuToUmVDw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000031d290062c71b6a5"

--00000000000031d290062c71b6a5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 23, 2025 at 09:22:30AM -0800, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > Karthik Nayak <karthik.188@gmail.com> writes:
>> >
>> >> Junio C Hamano <gitster@pobox.com> writes:
>> >>
>> >>> * kn/reflog-migration-fix (2025-01-15) 1 commit
>> >>>   (merged to 'next' on 2025-01-16 at ae8f9ce9a0)
>> >>>  + reftable: write correct max_update_index to header
>> >>>  (this branch is used by kn/reflog-migration-fix-followup.)
>> >>> ...
>> >> This seems to be breaking on 'next'.
>> > ...
>> > reproduces the issue. I haven't found the root cause yet, but will
>> > mostly call it a day and get back to this tomorrow.
>>
>> We have a handful of topics related to refs subsystem in flight,
>> and I am a bit lost here.
>>
>> (1) kn/reflog-migration-fix (the above) was done as a "fix" for the
>>     issue reported by brian in
>>     https://lore.kernel.org/all/Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net/
>>
>> (2) You mention that (1) is broken in the message I am responding
>>     to.  There is no known fix yet, so (1) needs to wait in 'next'
>>     until it gets fixed.
>>
>> (3) kn/reflog-migration-fix-followup is a code clean-up for (1); it
>>     has to wait for (2) as well.
>>
>> (4) kn/reflog-symref-fix is a fix for a different bug the commit
>>     that introduced the bug (1) addresses.  It can proceed
>>     independently from the other topics.
>>
>> (5) ps/reflog-migration-with-logall-fix is another fix for a
>>    different bug introduced by the same series whose bugs are
>>    addressed by (1) and (4).  It can proceed independently from the
>>    other topics.
>>
>> The above is my current understanding; did I miss any other relevant
>> topics that are related to these efforts, and/or did I misunderstand
>> the dependencies among them?
>>
>> If I am not misunderstanding the current status of these topics,
>> I'll be marking (4) and (5) for 'next'; I am undecided for (3).
>
> Karthik has meanwhile sent a v2 [1] of the broken patch in (1) that
> fixes the issue discovered in (2). Given that (1) has already been in
> next, (2) probably needs to be rerolled to be a patch on top of what we
> already have in next.
>
> Other than that yes, I think (4) and (5) can be merged independently of
> (1) to (3).
>
> Patrick
>
> [1]: <20250123135613.748916-1-karthik.188@gmail.com>

This seems right, just providing another set of eyes here.

Thanks!

--00000000000031d290062c71b6a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 25f7c1588b40db4e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lVGRBa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2JXQy85aS9LaGtzRU54NHd3UTBoVGZwR2lHOVk4cQoraXhlUHZ6eU9Z
Tmc2bzJMWFhuM1hGN21UZnU0MVFsd0t1ZTVzeVVYanIwV1Y0QUlLTnlHUUZIQW9SaFJDQ0tSClZ6
Q3hadDJwOXVVYzFNY1l3Q1pHSHoxbnA5MjhPTzI5ZndIN0NRb2lmbmdZZ1VKKzg2SElOWFp0ZkZL
ak5FTDQKeVdEQ0RybjFnSGphRXRma1ZGRjNFekd6dnV4SVRZM1IySXVYQW9TS2E1ZVBpcDJFZThj
YVR6bkdCaHdtNngzQgpYaUZvbGF4akJxUjJ4U2xOMVkwMjlzZEV5ZGFTUnFOWHVBK24rTkpHK2kv
U01JQTg5YUZNMjhyUlFxQy96VEp5CmgxWStsTlc4NVg4Z0FtSytWMnBJOWxSUlhpb3ZXYUl4WEcr
d2xXNytveG03MDFGbFk5WjNSRzVSL3JrMDdldkgKY0EwcTRBcCtoQ01kR1NERHIwZU1IRjJFWlpN
QXBYWk1SYXFTVTF4ZSsxVXJpNmsyem1pV2hnUFBNQlVsdTEzTApNWlBBNTVsSGE2Uy9sNzJpeWYv
enFnRWlqblMvTmhCMWRMUXAxY3BRclhjT21vUnVaSUNFUnJkU2ZUd0lhK05QCjdCVXQ2RzJDaFA3
bThTN0VwOERxc3ZLbUVIWEp3cUJGbCswelVxaz0KPXZpSksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000031d290062c71b6a5--
