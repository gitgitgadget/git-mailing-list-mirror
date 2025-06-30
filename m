Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F01BD9CE
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272199; cv=none; b=OSb1RQ9FwfBudRAYvpckLHCgiV2Rfwv4/Fhvx1nMGK1xhJ6F4lmdaeB9zGhhH1Fbmd1Vy9Jwx9vD3c/Vvh0yDdbBOiw4pojwVZoak9nVhpeL8ZiOEl2jO6HdgTLIv6J6ZQjkChaW+1j+/k2ER48S9Sn8q6CfzERabumbqx5XRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272199; c=relaxed/simple;
	bh=ttp+y1kFG7ec/VCAx36s6I11buCjinLU4D2JLicszXE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri+GChM33CqKolVh+pyXGDOQzE852DCG18nLgaoHg4BvrNV4PH96fDs4CPOipFxT9BNnv+++pa5dhBhnED24svPhkTfZRQRcQ1XTchyDtF13RPfkXirJh+xKV6PTOWldmihgb+nUm0WMFCnO3bvvcw3ShrLJdstUYBuTyXmScI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxON5jxF; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxON5jxF"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-531acaddd5eso1073751e0c.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272197; x=1751876997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttp+y1kFG7ec/VCAx36s6I11buCjinLU4D2JLicszXE=;
        b=jxON5jxF3STIb0k8T3ev+USUbhvaJ8b1JQVeTry5fXEM7/pW12yK1x1iW/PW/vR2Hw
         p/1U+vBUZgHVoezGc4x3zWTT6VbV1ZqzD4qETYT8YfY7Fow8ZjRiK9FtDHHynj42Ads3
         R08SqYFiQx/3zdohx/uGAIAkq17WppvWCEfkcBqPc06fn9LQG2NUmRYNzl4cojydch8H
         gRUlq8kfPXkvKFTaxHMUcbvTd0XvKuwGsdgJKkaK6SblwhaJjEWhHpLXkrTOU2s2sOfT
         mFEqXOJYbndhGM++wl+6Qc5JtUyJKbdkdoAWgJPL8cgaDaTfTAyMjvcWTeDBx/JOeo9z
         omwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272197; x=1751876997;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttp+y1kFG7ec/VCAx36s6I11buCjinLU4D2JLicszXE=;
        b=Dh6IIAqCLLAIbsurott/Vr2a6sk+4GK/Gqd0skpkQ3LkUn5FXVeGIhyhbZrypi5nPo
         b1PuaDoBQ2Ccj01DM8X0YLXhMlwgDl4VLMDycTkVvBDqkWDFa3ODskIiiCJ3TusBkhM0
         EKMx+Tse50WNojOqyiymDZYeMwLl1KgxAZhd41hQqf0s9x23Q3g01B1gaOJQMvy2g/pB
         Gz1iujMczr8dM26VlLGG5RuYtDJjeY75StdLg0RG5r/9YjRxxJwsXCfVGUDt7uyl422S
         Qj6nYSM3XAfJTeA5Agw3eAcYI1UpOuz2pe01lhGqQxJp2YOLNajKRqPtRZfh7D/Unowl
         5RLg==
X-Gm-Message-State: AOJu0Yz1xjeZfLxfO85sZKvAukdqTmTHRZHYewybmPhKjU2OTE5s2ZIA
	gCMXOqlWMjwA2/59cOrQ3DVeN2MwiW2Z5KKgFPmRTHdDMqDvAKnnjw1bT3fB63gKAUQ4tG0xMyA
	gjI6q+IIc4J2SWtMhQI4cC1wuz8VMwvM=
X-Gm-Gg: ASbGncsilzAM/LQ7pseBNjejvb9FN2QZXWwT5Ew0+9zJHfd1bgNp4mpvavTcl096tSo
	jku9nCk92Q80fNDrED7A+3ROlkv4r/s8KIHhfPJDcoJKkKaHv45vbr2PnYcrHdYTgNGiFQoHOJi
	p/3ObGvXgaOgPKmOW44ZLDxM4wrmFAKQHasseV9pr2UL/uBt3VYVSeSYDWZbXxHT+ZTJjvrA1w4
	sPsng==
X-Google-Smtp-Source: AGHT+IGxLwzJnRcxdw6Z0fC0/LoHv7hDFYVes7Nv3H2CZ78LRQsS69C9cGMvXx+px8NQpc1m/ZCoQY7ybgF4yhSBOyw=
X-Received: by 2002:a05:6122:4894:b0:530:6dc2:ba97 with SMTP id
 71dfb90a1353d-5330be000c1mr8109428e0c.2.1751272196888; Mon, 30 Jun 2025
 01:29:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jun 2025 04:29:56 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <4xcovwt5f2garsngqtzzcrn7755in4xkq6zxxk5smeo4d2vfp4@l7cqb2lizf65>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
 <qxewasf6rxt6mnbwvfhxarcbvfsn6cnc2jskpddsb5fhxfhpwq@5d727iud7wfp>
 <CAOLa=ZR_ZhjxYgN4pZsjOuC52PZjGMCzLJVZbwGQb=Q9W-0HSQ@mail.gmail.com> <4xcovwt5f2garsngqtzzcrn7755in4xkq6zxxk5smeo4d2vfp4@l7cqb2lizf65>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Jun 2025 04:29:56 -0400
X-Gm-Features: Ac12FXwP6EFNNgP9cAdOVMHLKQNEDxLGPgVvPapltmg6V81PSo5jUclUUXbdapM
Message-ID: <CAOLa=ZTVgEFSES0iv2kLftsDJ27cULo1F1XuJLHURWimuOm5-g@mail.gmail.com>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120 characters
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000033a9bd0638c5d573"

--00000000000033a9bd0638c5d573
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/06/27 01:51AM, Karthik Nayak wrote:
>> Justin Tobler <jltobler@gmail.com> writes:
>>
>> > On 25/06/25 06:43PM, Karthik Nayak wrote:
>> >> As per 'Documentation/CodingGuidelines', we try to keep to at most 80
>> >> characters per line. However, there are often certain cases where we
>> >> extend this for the sake of readability.
>> >>
>> >> Add a maximum limit of 120 characters to the '.editorconfig'. This means
>> >> that if an individual line exceeds 120 characters, the editor will wrap
>> >> that line. This provides a lot wiggle room over the recommended 80
>> >> character limit.
>> >
>>
>> Hello Justin,
>>
>> > I frequently use the format operator in vim to reformat entire blocks of
>> > text and it is commonly configured to use `max_line_length` from an
>> > `.editorconfig` file to know when to wrap lines. Changing the value to
>> > 120 would cause my editor to prefer 120 character lines when
>> > reformatting, which I would personally not like.
>> >
>>
>> It would only wrap lines longer than 120 columns. Currently editorconfig
>> doesn't wrap any line length. So we're essentially saying, any line
>> above 120 is not something we want to accept and hence wrap. This
>> doesn't mean that shorter lines will be combined together. Wouldn't this
>> be better than the current situation?
>
> When `max_line_length` is set in a ".editorconfig" file, in my vim
> editor it overrides the `textwidth` configuration which was already set
> to 80 by default. So changing to 120 would change line wrapping behavior
> for me at least. I could disable using the ".editorconfig", but I would
> prefer to avoid doing that :)
>
> -Justin

Thanks for explaining. So it seems like vim in this case _does_ combine
shorter lines to fit to 120 columns when formatting a block, this is not
something we desire. So let me drop this patch.

- Karthik

--00000000000033a9bd0638c5d573
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 54c3ffb087b5929_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oaVN3SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMk80Qy80eEZZN3E3a2VDTXFGdG1FZHlIaGlFeXZRQwpXWmdCMWRxRmZE
bEJ6SDFLMStUK1hYamNoeklLc2pQSUk1K2pPZ3lKbEJvUlJPSDNIZ2dzeTk5TmZYWXBKa1ZxCkFs
ZGIyREZmUFFkakF4N2FuZi9UanBpcXlzOWRPSi9kQ1cydWg1azNreFFxdmFQS2VnWEVyZ01yckRw
elFlb1IKNnFoaW5lYmNyQmRSbU8rMW91UjVBd3E4WC9VbjdaMVZraEN1Y0tkZkpUcXowdXV3bFZE
MDJVTTRjdDVlU3ZxRwpoMTZhV3RiUnhia1Q1MmZJWklOWDgyVVd6ZHY1OS8xK1JZbFFQUHVNYmdu
M1YrK1NKVXFLeHJldGovT0FkdlF5ClQrRVRjVUZOU3VMaXFaRnViOUh1bVhvajNpVVJmMXhnN2cr
c2hjN1BMY3crTnNTdTM2VjhFKzJYY0J1dkE3SGkKcDNUMURuU2dyeVhYS2N4L2ZQMlBnVytGajE1
YWJmaEQrV2t2dXVROHQ0alh1MjdpWlMrZk80RnFNa0ZGa0FGSQpDTmFhMDhOS2J0TnB3UE1hWjF2
d1NzNFhqWHNWYkdWZmh6Q3VyS3pZZGIrMDJSelY5VnNLem8yNnlCdVhDMEVJClJIcGMxZ2VEV0p1
NkF3ZFBNNmhER3ZPZVFnRmNqd1BSSTFLOEpkTT0KPVJ2R2oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000033a9bd0638c5d573--
