Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D831779A5
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423488; cv=none; b=Ojb+asklr+L7jCs6mUMrpMFufgTJdGTAoJHgu9eBWaLw72rQbPyJbhD9tftF9QLK9Fe3ojf+B1kl0oX2oe1cl4EGW4oFrW7uUVWNJ700gonC5FzuZ7L0RIahIV/S5R4ubPFydi8f7D9JoD8FZkkd9kPSsrFKMEYY+tGlD9aNO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423488; c=relaxed/simple;
	bh=8f0LdXux8lgKgnLkghL+qyav1btNkh5TlZiAFqjw+b4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNeECfCgkS8NEq7yYeb/ThE9hhgv7WC26aKVyXLibuFtml2EKDuv5EAzHDMc1M1BhW/cbCOG2kGaOTuO6qfKetMRFdeHYo98DY0svuLp0fcHN9zSApFRsgguFgRQdeTsjHCW4bBN8dXCvKGCZLjjK8+Wcg6FLlJyQwZg+S5ezw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuL92qzA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuL92qzA"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea2375d8d0so4067404a34.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714423485; x=1715028285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f0LdXux8lgKgnLkghL+qyav1btNkh5TlZiAFqjw+b4=;
        b=iuL92qzA+IYaAdvaRPpmO9w7ONfke9mMZ7/cOT/c7bcHdu13/HlZsJ2YtW81W/Bv/R
         cn8wgY7h0jdk9EkNYW5yzxZOkeMWmUSm8x6dOjY2uRZL5C34qqLXID59hKWhtFGmqVuz
         ZmIVQJRjsHv9aqYxEFCGIxt887EtKZYzO6A8P2RbWAuWpLJLuMrbMsRQ5S01RRcQeuDu
         kPCXNWDk54y+cJDnDE64G7jFoVegOzfrH+YfV7dFSJGgsg8x+zUmZ7BiSVrjClU7WNhM
         tpjEdCJo2KvvglRP7/Z9+uZ99TTLKA4SHhgqpjhD91gnHB2MT+3O9n5x979Vb0dfXamB
         yBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423485; x=1715028285;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f0LdXux8lgKgnLkghL+qyav1btNkh5TlZiAFqjw+b4=;
        b=JT6XtmAfq6hZkylErpvjLQq1psNKri0BbrTolj98VWpag/5epLsiXWV5QV+s0SfOva
         5H66HWqj1C3jA9VXmE8psez15SuqkK4pX4mOlgPHjGnH6VHSMrcWckTAr58FXSOxZm1q
         iZKP17PZ+dKUyfgSXS+cD3c1Xn6HNm1v+mNlgj7XGpgIfFpzvT9jSzAOxt+QEL1AeuDz
         0FMusxhIcUSKDvMJPwKf2xQi4GUtknrd+qspDegq0ocZfF824jfHry+AVRH0AjXgsw+A
         hvGnkuLCvn9ty3eEQAZ+DOYfRA2S3wzjjUZr7zmUFuMe6JBuZNLFk8+nk6JgeJWQTnMs
         j4bA==
X-Forwarded-Encrypted: i=1; AJvYcCVb5gQa3ncr1ijQh3h9CsCYyAlrv1+zl9ZgWGFJOwQS8EohbWPxv+DN5YuWjfRYcglUM22TP5srntzMn0kgUGxrWnoa
X-Gm-Message-State: AOJu0Yze57V+PMGDgJizK6OHuQNq5+hsvUHR8FhRkkp/1rYub+eAIJ8B
	bF7TzHVpfQct4n9R5+Ouh1coyiqqPnkBz4TtPddlGpHeYSvN5pj7FQyM+Orek98H1yCVdYTArN3
	/Q9n8aIXLbDLQACrRoMBhuGvHOqE=
X-Google-Smtp-Source: AGHT+IE+jN/p7nnGbeANNEYX9opS4HcO30WFs96DLntdffIxf+Dy5QErTgaSzEmJRkRB/yMcBWlMqtHd9h6Uy/GU2WY=
X-Received: by 2002:a05:6870:d3c3:b0:239:77fc:b762 with SMTP id
 l3-20020a056870d3c300b0023977fcb762mr13202475oag.45.1714423485270; Mon, 29
 Apr 2024 13:44:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 16:44:44 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <b43e51d0-2814-4800-b8d5-cea5f79ce318@gmail.com>
References: <cover.1714398019.git.ps@pks.im> <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
 <CAOLa=ZTCCgtQiQbm_GU--1+Yq-qYJANzTvRmvVrqNmzchkVevw@mail.gmail.com> <b43e51d0-2814-4800-b8d5-cea5f79ce318@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Apr 2024 16:44:44 -0400
Message-ID: <CAOLa=ZSqtGRVVHma-=XzErVdZ04sY_bGvk8qiabNdYzojS2ZhA@mail.gmail.com>
Subject: Re: [PATCH 3/3] refs: fix segfault in `is_pseudoref()` when ref
 cannot be resolved
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000d5a4690617425267"

--000000000000d5a4690617425267
Content-Type: text/plain; charset="UTF-8"

Hey Phillip,

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 29/04/2024 19:57, Karthik Nayak wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>> via the uninitialized value when calling `is_null_oid()`, which causes
>>>> us to segfault.
>>>>
>>>> It is somewhat questionable in the first place that we declare a ref to
>>>> be a pseudorefe depending on whether it resolves to an object ID or not.
>>>
>>> If I remember rightly Karthik added that check to avoid the files
>>> backend calling a file with a name that matched the pseudoref syntax a
>>> pseudoref when it wasn't actually a pseudoref.
>>
>> Not sure I follow. I think it was strictly done to ensure we don't
>> consider symrefs as pseudorefs [1].
>
> Junio suggested using refs_read_ref_unsafe() to ensure we don't consider
> symrefs as pseudorefs but your patch was already reading the ref to
> ensure it was not some random file whose name matches the pseudoref syntax.
>
> Best Wishes
>
> Phillip

Oh yes. You're absolutely correct. I just didn't understand what you
were referring to :)

--000000000000d5a4690617425267
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4820e6827926cd50_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zd0Jyb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2p2Qy85UFk3WU9SWGNyZ0YwRE1QN3hDQTBBS0s1MwpQa21VeUtsbllx
M2hhMWN2amN4SGxNSDZaaGJoMTlqNmVWaU5Xb3FuUEdIaXZLYzI4R0pLemJYMEFyNmJWdXllClN0
M2QvTk9xdDdmeWIvWkZGbUN1SEgvY0JEZUVxL1V3bkUvb2JJbnF4ODZpSXJYdmxUek1RZENhMnpD
bGpDbUsKdHprcng4cDVJTFprUzAyQ1dUa1M0SFZDbUJHTUdkWjRQTVMxZnltZDA2NE1uRm5rMHhm
RWZoSHBUdWxpU3krRwpFck8yYkhvaE40UmhQTnd5LzJGbi9KVkozZHhLcEE0eTZVNyt5U0JGa2xT
b0ZtZ3dOM0NXc1VMQ1ZqNHlVcDZJCkg0L1hoMlo3T2JiZER4MG5Xb1Z0alkzL2pXRitjUjBKbEhj
VFN6Z1BwdVZ0TURLa1UyeWdwaGYwdlFXOE9JZWMKa25Ua1VSYzBRbkMrbVlxRjB5ZWQ3dXlBSDR1
YmJYVDBBNzZBalRld0pQV0NUMUZ1a21zd3BNdnlpWjM4ODF5RApwTWxxL3ZlclVCV2VDT1RwMnlL
MjFnemh2TmFQOXlabnQxYTdHY1hlakdWL0JVc1R0WkdGS0o5TmJBUGo0dzAzCnFBcStJb2ExV28x
Qmh5VEVjTGRBQkkzVWVWWjhGb3dhZS9PajFMYz0KPWlGcksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d5a4690617425267--
