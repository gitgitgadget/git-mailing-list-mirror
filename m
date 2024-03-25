Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2721763F3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391111; cv=none; b=Vzv/bNleIIHp5Id/q/j6yiyavi3RYyXDLybm0Sj1cmfv4FJFT2kRFOmuo2Q1Knr5hgA9YJK2euMvW8SL8bGOk22hyaRrK4AKwGuJ9IrfFKsGHgccfla9Y2cg9XoW9aS+jTknN4aBBvR1c9A3OAvN+dQ4iPmkDCmisJQwyo4o1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391111; c=relaxed/simple;
	bh=xL9TR3laOQi6XIuFdJ/xIg7HjoFXE0YbzxQCeYFBh9c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=L4olQbLzlU6R0zWPNB42etpydf0mV9hXidpdEULfw7QHxa1uQ0BCvhGMyLN+MPkA3SjPytMFza3WQe4T+TXFEPgteiPE2mteLl9Mv0LxQBGBPNKQuf5dRLDpp6tjsIup3kN1+L9QgYf8XLQk/Gkz1mA1TCJN5pcPEQAXs40E9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN1sGbwm; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN1sGbwm"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e6db4dfd7aso566540a34.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391109; x=1711995909; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xL9TR3laOQi6XIuFdJ/xIg7HjoFXE0YbzxQCeYFBh9c=;
        b=AN1sGbwmeMdhqCuhvblyq+RMcX0hCqmijG2x1tdsDXMHyoTGOz6lNV2YhVShD/p33Q
         mDnDhmbb4u+l+9v8SuzICk8jMhxWLKmp2gsJtkdHc/wXFemskZZi5akBeg7ReSwzjfYO
         LjiHHqm5+GktkiF1dIXQftLqy+GpU+yFAFvyy+dkRVtV4GUo2b7PfkCgvKVY43jFoZcl
         yIjizb3VOR2dNNYXxP6EvprravIIocMHhqC+QbBzjXn6BFfT8Ewdi4utcq6rQomnG3Xa
         39K2DbTRHAt3meOFTwob7MwqTE5z/niBsEWiAtjL3hn6NCyxuZ5csO2zFcV12VPdyOKo
         M5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391109; x=1711995909;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xL9TR3laOQi6XIuFdJ/xIg7HjoFXE0YbzxQCeYFBh9c=;
        b=fPk+2HUKgVvgnPA/buj0jrRTvCDAMMs1MABsFzf5JQziGhlBBmQDHl2HVxMqTu2J/w
         Fydd2kGrW0D9RhdMXcqC/jyaXyF/mqOFQhRbNUqQkKFDYLpFDgoSN7YDueSAROrIwLBw
         TL1GlwZGzMUW+Z/Z9L6h/z0+g0+jze8XffuEmxIrS5lCCgNOuCayc1iyt69haevZoeyP
         MqrsCtoXdQ/dF12IWZkL4INYfz1+1eSHIwniOw6HSVH6BtwytLYI7iqQ5k8ByWkjXE+i
         zxJo5yHe5l3F3d4xb2FvQvJUNeusN+aJRg7wYgbMI6C08lsTp2TsKOaF9mQjlphZILCa
         p8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWOp+VaNe5p7JY0ZrcdPvLpDmin8dIdNYo9ORadOv42ieq1qNeLIVKRcmQTDo4TQnBjS2QRkQL+U3h4Oxv+bW+6Du6X
X-Gm-Message-State: AOJu0Yw8hnQmZT40hh9evg9sdRzpTj53zlyzPgr2tvD3JNjJLBp6E7V3
	0M/gjrswSijhBh8v8e8D0pLhDiWrljMhlrO5zQsqow5MkOzM7gakt2hEqjg9diOiB5fhIHp/Xiw
	JiC8n/V5PGbDR3y6GyZaYqrN+s4iczgA1dkY=
X-Google-Smtp-Source: AGHT+IFOb+JsqNb/NKYP/oVAQh9gxQmg5wuhAC7hDLTf0z3keoNT6YZqLof8CKDEzFLRg3lxdxRdlD0Hq1UnWOyFFc4=
X-Received: by 2002:a05:6870:b4ab:b0:21f:412a:87a8 with SMTP id
 y43-20020a056870b4ab00b0021f412a87a8mr8778025oap.41.1711391108850; Mon, 25
 Mar 2024 11:25:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Mar 2024 11:25:07 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Mar 2024 11:25:07 -0700
Message-ID: <CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
Subject: Re: [GSoC] Microproject help
To: vk <g@vkabc.me>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001d82860614804b7b"

--0000000000001d82860614804b7b
Content-Type: text/plain; charset="UTF-8"

vk <g@vkabc.me> writes:

Hello!

> Hello all,
>
> I'm Vk and I work as a software engineer. I am interested in
> contributing to git repository. Apologies for the late start as I only
> stumbled upon GSoC recently and git project interested me as I use it
> everyday at work and it would be meaningful for me to contribute to it.
> Even if I am not chosen, it will be great if I can start learning to
> contribute to git open source.
>
> For the microproject, I have looked into the lists for 2024 and it seems
> that all the projects have been taken except for `Replace a
> run_command*() call by direct calls to C functions`. However, it seems
> that the issue has been solved. The command I ran to search throughout
> the repo is `git grep 'run_command*('` and the search result returns
> run_command functions which I assume are essential.
>

When I ran the same, I saw around 135 results. Are you saying that
they're all essential?

For e.g. In `builtin/gc.c:maintenance_task_pack_refs`, shouldn't you be
able to replace the `run_command`?

>
> If there is any low hanging fruits that you can suggest to me for the
> microproject, that will be great. I will also be searching throughout
> the mailing list to see if there are any potential microproject to work
> on.
>
> Best Regards,
> Vk

I also see the other microprojects are still applicable, since most of
them have multiple occurrences throughout the code.

Wish you the best.
- Karthik

--0000000000001d82860614804b7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2b6599e00b7e0de_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZQndZRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1V0Qy80NkhtNnhQK29kZWoxekRRV1h0dWk5blZXawo0VHg2bWdqYkJz
UUxRZVZzaDF3QW5ZUDcxMFg5K0d3SkVxR2wrZWFKUTZKdWo5Yjl3R2VFeEltcGJnQk1kdC96Cmd5
b05KakVBKzJ3WWFYZ0xiWkxWMUk2RHdzRUN1OHN3MnRaVXFOV1VjUGREd1B5SUxtRlhLdHBMeWJk
T0lTMlEKRVQ5WHp1VUVvMXdTSDFUQnFyREp3dW8wK2xpMXFROUNTWHlBcDF4V08wK1hXL09TM29H
bUl3MWxOSHQzdWl6Two1TDFwVVhuTUVCOEZVT0NwM1lGc1JhaGVFZ1FwRTh2bkQvK0hZVUVlMWZV
VDNaTGZUVXNrYkMzSFJXMnhWajFSCnB4L0lXMm9EVW1ZNEJKTzJrdXZwSDhocVNxSnlSY29yUmRn
SlQvR1RPOWNZOVNjQjhFK0dkQlRQT2N2OEdhRzkKdEFSQjloZzJDZDgwaWwzY3dhRGsya2pwZFZN
VHgzS1Y4MFoxVnVYZkRheEtSdUtCMit0Y2pQanVXMWhKdXMzRwoxNHpMQjI0TDlueFhKQmZWRTE1
Si82M1FuUEtpbGErZG1HM2VZK3NzQjFlVHNwYlpXLzFSMzZBU2VWUkN5OGpJCisrYmJFeHhOZ1pJ
a1hwc3ZMZmRuYkJibXdveGpUa0ZqVHRSQ2dVYz0KPWdXOC8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001d82860614804b7b--
