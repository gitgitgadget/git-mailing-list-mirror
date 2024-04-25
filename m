Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42A155729
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079677; cv=none; b=GLz6j1j1rzc7PcdrzMmDRxtk6JVS+EGPclbJxYwXeXZKSD/to4DCTrkKV38gtWCP50wfeVA5jHNuVrez2Tl4Rs6Shr2W1gwC16LW4nxzZmNPNNQnuH8xr+UHI3H84mh6dNVXd/AcDh0+iY5lCBVYV+UyQAkJYz7GkFDcSbfqpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079677; c=relaxed/simple;
	bh=f4X05n8Ei0LSZrNh1OsKDTtXHKPX66kZeTz4fMR0GRs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sec7zMS2xtv7Nu9dfX4G1Ud2+nIqOaLGIpfod7XssqF4/oP5KSHoJWlqg7Kv3w+4fsChux1eycxRmbxcmhQknQGyuV87jwnTwcj7qtq/1EGx6bSHOz0UkLIxbccaYQA4OrrN2EzfZCNZMT+97dhT0p79t4/U2bxLT9IsrvmOrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljsu9hQG; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljsu9hQG"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c7510d1bacso891895b6e.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714079675; x=1714684475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YDJZfGFpqs7GRiV/x+ZlFO7Rr+ZCZj7Trb0Lrngm9s=;
        b=Ljsu9hQGmzAhNmQG8YEM4BpjRitueSiddZpbmL0Gw1gs3JHxQ812c8tTYl98VELelX
         avWFDUwWZ1E6+aMZlC/Wf/+gzTgnIuaWfTmHdOhSi6iZsNMUEifwqbpjvq075cTWn/7K
         QFCYr7om8sJDc7hag8SvUxhx21aU+ejzNg7qcRljq2mV9Tk3VE8nhDEIYVuDpt1s6ibE
         QtXVuNqZW8ceFiXGqqUI+reUh+Bl5dfJScE4l3i/WlLCcXErAp3CJXCu1ExPw6VXCbuf
         1wRkz11xAcNGOl17aqvgPbctoVHbD2AuDUIZnDvU1bbujQTjdKhDFFJGv1Omn3F7zUta
         HKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079675; x=1714684475;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YDJZfGFpqs7GRiV/x+ZlFO7Rr+ZCZj7Trb0Lrngm9s=;
        b=jXnFxaQvFZ5BjzsQGgvVl6LEUAx7zi//1c3lcI/8f3442RyWFgjFJSDKMyUNWmCvHg
         22qVYwEiQclpjaRCpFe2HFrXvBlAuHo9Ct9F2oeF48tXL4O3Pl9fYNZHeVesaKGnAt7h
         Jfmi3Qmbkqu2pJ0k1JVPf4FLBcgJlGQXZeyzNXpIZGAilpG7aQOhP+kc4gQ8n9i80/FX
         t9NzT/V1gD76OaiCIkT0FOkkuJgfCDQSahwkaXwO9IiPcx9JrJLLHkqrMiccyBrkMouv
         j3GE1Whr7EgOtHfrnplcMwdNoKaiaulyuv5TZUTRT/RGIBPjWLFbHTlRkGkMEX3QVnVA
         RhpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpwbOBtxs2Iun7L69/gaknnr/+sB/x1e/UABcn9li+0r6Z19FnSVzXkCoCn5zycKcO9FIqojv1Hsn4mg03DMoaC1kc
X-Gm-Message-State: AOJu0YxjabOe1w5blqlRlsfhhwwpydqO3QkhJIVBjfFKPVAh45RSlt/i
	MOXPOXrDBErQIt+zHq3xVFlqMeXTeXw09NnT9F9MIv7i0d0pQzOaVDgP00/3FqUK6nqhEN8fQG9
	o/qB6Zb/pgK00hcfcBKfD5ajHZDk=
X-Google-Smtp-Source: AGHT+IFwcuYCnFlIzJM1+JFShkeEuLAzSY14M9vFOl/7ElqAD8pdYyXfHm5Bv5alt7CB2SI1irJ443UpGIMFn2NQQO8=
X-Received: by 2002:a05:6871:2b10:b0:22e:c37c:453d with SMTP id
 dr16-20020a0568712b1000b0022ec37c453dmr693527oac.30.1714079674743; Thu, 25
 Apr 2024 14:14:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Apr 2024 14:14:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4jbpgw32.fsf@gitster.g>
References: <20240412095908.1134387-1-knayak@gitlab.com> <20240423212818.574123-1-knayak@gitlab.com>
 <20240423220308.GC1172807@coredump.intra.peff.net> <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
 <xmqq4jbpgw32.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Apr 2024 14:14:34 -0700
Message-ID: <CAOLa=ZTjwRnqmXRuWpN7o86DZdfOsgZwR7=Gk0A3EG0zSHiCBA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, chris.torek@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000215a680616f246e6"

--000000000000215a680616f246e6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> 2. We change the syntax to something like
>>
>>     symref-update SP <ref> SP <new-ref> [SP (ref <old-target> | oid
>> <old-oid>)] LF
>>
>> this would remove any ambiguity since the user specifies the data type
>> they're providing.
>
> Yup.  Being explicit helps, especially if you are only dealing with
> programs that do not complain "that's too many keystrokes" like
> pesky humans ;-).
>
> When the topic's overall title is to add support for symbolic refs
> to the update-ref command, a natural expectation is that in a far
> enough future everything that can be done with "git symbolic-ref"
> can be done with "git update-ref" and we can, if we wanted to,
> depreate "git symbolic-ref".  Is that really what is going on here?
>
> IOW, we should add support for operation modes other than "--stdin"
> as well, shouldn't we?
>
> Thanks.

That's a good point, I was thinking of something like this too, but
didn't want to bloat this series. Would it make sense to add this
functionality in a follow up series with the cleanup that Patrick
mentioned [1] too?

[1]: https://lore.kernel.org/git/ZidXrdi7hXdAnDhy@tanuki/

--000000000000215a680616f246e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aaabcd9d52b5494d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZcXg3Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlF6Qy85cUsrR1dzL3BrZkdDZEE1Tmo4d3JNU2ZWTQo0R0pCdWI5MmlT
VHVIYklEdDNnNm45dmxsRTVlaVhiV083QUpEYTMzUkliZk5ISjZiNVVkb2wzRnNZcjRKY1h2CnZz
MUxpZU1yVUtlbW9DditieG5LWTN6WUJWbkYxZmxYN0NseG9rNWxWT2xkRXJYbVo1aWxFTGZ0ZGhj
OEtYM3EKNFhHbXk4aitGaEsrdzUxVGpMWFFnUHl0QXl3L3NERUVZWVBOOXVPMVpoeEt6bjJGcmxn
MXpjNmJEdzVqZGlLdwpqeGszTW5TRWREQnZKWFNYRndSNDRXa0JnR2RPcDRkRDJJMlRKTDltd0hO
UzFUbE1UYmZxUERBNlV6dFZvVjVYCjU4WjJyUHpnTEFscUROVGRuQjlxckhCQUJnYW5HU1BMblp3
WXRUV1AwaEUrTmdmZ0k4Mi8vYjZtekZyaklWaUkKV0hBVUg3S3Arc1hubitXTEZTUS9SV2lKM0Yw
VExMUHc3cWViUlRXeEZoclVVaVl0M2orN2Q3MUJqancxSnduOQpMREpWZ0RMMURUN0ZJSUY3UjBh
U0FrOGNtNlVBQTlGVmoxeG9DQ3VmR2VMSGdQRDJab1JDd2IrZlRLWWEyS2g4CnJQUGlnbGlwM05i
SHQ1OGxVRXR4SkQ1Y2pZTzE2cGNsMy9IYWsrWT0KPVVwUDcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000215a680616f246e6--
