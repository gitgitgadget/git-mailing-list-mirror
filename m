Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E97346FAD
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151858; cv=none; b=OTGezTHmo/i6O313Fr2VeBz30RGkUySy6UCXmHK3d5ECvxlpd8tQuYRrsKLk3WeAyICWIpxB3P+kmXeBoto0jzKTJBJtJpzk4u9rSMmCz1ZVxj/caX5ZcTWWH0tjJ/KgvEUSxpLmKZv8el6rQa8Pi+EizFPnAl+x0JtiM3huIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151858; c=relaxed/simple;
	bh=YV4GPANzo3ErOvzxKaItemY491AgANWm7q2O3vy+ae0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SfrUb2IZNFDqqcbad6s2ECtr0tyf1EqTGeyv9y21YkMeeUuLjNkvPscxT/UpR0DK2SjWbnp78kSHYvWJ+7ld4y71v2bKIN2PcFs+tnic8RSTU7ter+SuS0ffkSK/MzqTSfb5DRa6skxH9+4MGK+4izZ48tZ6yay9xgqlEIQJJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5TBeYuI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5TBeYuI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-472326ca506so4852529f8f.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784151854; x=1784756654; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0awPu4NG8Beh1KJxE986LQ0wjQWupPPFlGDHR87tqUQ=;
        b=T5TBeYuIUSWGobVjQx1XjiPQGmLkjk4C6Ry3B4sxyVWkdJ5JrGJNmSXRji2N2DrTjn
         /JJQV7Shu1AIbaovMNJbk15nzVIqz34X4PtJDwcupTNlDRp333oKa/OtU0h/qSJXwQGD
         SK+mciMECKh7joNfZmXpfud+/uMglCRVzH0Jk4nWTSDy44sM8s5h3Jj854oafMYKDiAl
         XP6LTKCuL+2HazCqAGND+tM7NZDAu/ZV2cwy7SW7bV2wC+amXB6sxbWm1BEPM/ByyqWC
         Mi6gjUJyXNEX9j1O2g1DVYAbZ8MvQUG/6W2BWiEYepMWvPI1G6xT8sQmBW5uSpOUVhh9
         dByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151854; x=1784756654;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0awPu4NG8Beh1KJxE986LQ0wjQWupPPFlGDHR87tqUQ=;
        b=eAuJy8QsXx6LWFUHw4+a23o33N7zfLx5vjP1yBpbW4lHqWCUiXEGMIAlp0NMzn+nnZ
         91OBz4X8Xfa1zYVw1V2UKN36D+xTbaVgJQnOxWxIDvT+Wv8OElqKZ7t6ypjI4pBo37vU
         jSvGl4Y8sqsUK+xFF33NDB3WBFZMjHQp6hfacc9xQFUQnqo+O8EUmn+diR0mk71KIqka
         jDR5WT6EBdIlZ+280RDwGi8nUvBQk4yZnRg4XB9HGV2z2xW6otaGBOsrc6xad79Eunv2
         LSXp7BUHok2f2xov5tWPy1sr21L3vqwkCp6yOpJpf9NoUPSqhCllCB5IFWQssKOkDV4I
         FhsA==
X-Gm-Message-State: AOJu0YwjQFpLga0GJMv+D3vwmgRvMP/4JGBun3722prjXEG1K2hb7YlZ
	4E4/e83vQFg1BlU2DVdrV3XBtzDRuV1F/5Vd73QD0YWKIyEe7uzX+0zk
X-Gm-Gg: AfdE7cllProZ3aKtGTf/vDH39486j4PUG7PQuiyHIHjNzbK+/lBlHbI36S1GMaHZ67m
	wwF7/Y43nGWoswcQuBlKDyMVKw1FyrV33+f+MjcDQwpzGZX3/60WixRIpP4SYi4hU4TJFCoDfaK
	pV+O6cRX+Ui4LaevNx0IfAMXxSzavd+eGvOY6vPSWl4tYsHRJfRR3RVwRXrtvcb+UWGvsQIQu+y
	MNENJ6jdafAfKNovRTb5lX4aQ5TSDt1bPjPqk5xvu1dhy4qAypie20Vy98siKOQZZHfiNi25gAf
	DEhlCO5zF/LgyF8wCtj1e4Dz+YmHWkHf7p5CPf1XoVpbMnmFcEh6/u6SM5lGI+vjJBWh7PEqUTQ
	mA41MQFbpjDalrWrTxFLEGgFd9HxFEGP/USusYhbpb4enAkKE7XWmI6aus82Ao4zkRfoF+FPCer
	QFDE1LHRJZkAQrj4UBs0bcCl+ahdiLpW4tZG+0r0qFmRMNwMHTIuvDOWbe/OSMFL3i2OhRVNbYt
	Md9/sQCmK88wl8MUc3zYe5YoK5jjISyMh7TXVzVLj9Hj4BPo8yR/bb0sm9AjVlWrPY8088bHVGl
	BQoB7hcbgj59YLhi0q0dCsFlR7heZv3AtKAPUHzPm7cXzx0XoVVy0HALftE=
X-Received: by 2002:adf:f3cb:0:b0:47d:fc44:f4b6 with SMTP id ffacd0b85a97d-47f46340ac8mr8895619f8f.20.1784151853964;
        Wed, 15 Jul 2026 14:44:13 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm19647545f8f.3.2026.07.15.14.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 23:44:11 +0200
Message-Id: <DJZH1PLDC08G.1XTK39BO8YOVS@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <chriscool@tuxfamily.org>, <eric.peijian@gmail.com>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>
Subject: Re: [PATCH GSoC v18 13/13] cat-file: make remote-object-info
 allow-list dynamic
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
 <xmqqcxwonnkx.fsf@gitster.g> <DJZDEE0G6ZRS.2RT8JTQQ6CUXB@gmail.com>
 <xmqqwluwj8of.fsf@gitster.g>
In-Reply-To: <xmqqwluwj8of.fsf@gitster.g>

On Wed Jul 15, 2026 at 10:32 PM CEST, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>>>> 2. Filters the request in fetch_object_info() dropping any option that
>>>>    the server does not advertise.
>>>>
>>>> 3. After the fetching, the options that haven't been dropped are the o=
nes
>>>>    fetched and supported by the server, these supported options are
>>>>    mapped and remote_allowed_atoms is populated with the placeholders.
>>>>
>>>> 4. expand_atom() checks remote_allowed_atoms with the same behaviour a=
s
>>>>    the static allow_list had.
>>>
>>> I am not sure I follow the above entirely.  Could you add a
>>> concrete example to the commit message?
>>>
>>> For instance, if the client wants "%(objectsize) %(objectcolor)" and
>>> the server only supports 'size' but not 'color', the filtering in
>>> step (2) prevents the client from asking about the color, requesting
>>> only the size instead.  When the server says the size is 42, step (3)
>>> uses that to substitute '%(objectsize)'.  Would the end result then
>>> be "42 %(objectcolor)"?
>>
>> You've gotten everything right until the last step, because we have only
>> size from the server there is no data to match %(objectcolor) and the
>> end result is an empty string for %(objeccolor):
>>
>> "42 "
>>
>> Note that %(objectcolor) doesn't exists and it would have die(), the
>> empty string is only for known but unsupported placeholders.
>
> It was not clear there is a distinction between "unknown" and
> "known but unsupported".  The proposed log message needs to be
> clarified to make this distinction obvious.

Sorry, I'll make sure to write it clear next reroll.

>
>>> And if the request is only for "%(objectname)", an empty
>>> object_info_options is given to get_remote_info().
>>
>> Right now 'name' is not part of the protocol as 'type' or 'size' are,
>> 'objectname' is always allowed but only shown if it's present on the
>> format.
>> If the format is only "%(objectname)" then there's nothing to ask the
>> server for.
>>
>> The current code avoids making the request if there's only objectname or
>> nothing supported, but still goes through the connection work. I will
>> add an early return to just output the oid back without any connection.
>
> I think you are heading in the opposite direction.  Rather, when
> only the object name is requested, I was hoping we would pick
> something cheap to retrieve and ask the remote side for it, if
> only to catch a bogus or missing object name.

Looking at send_info() in 'protocol-caps.c', the server only calls
odb_read_object_info() inside the `if (info->size)`. A bare OID without
any requested attribute gets echoed back with no existence check.

We can force "size" when only %(objectname) is requested so the
server validates the OID, and discard the size on the client side.

Because this is a cheap fix, I'll add a NEEDSWORK for the existence
check to be done regardless of the attributes requested.

This can be done on a future series focused on the server side.

>
> Thanks.

Regards,
Pablo

