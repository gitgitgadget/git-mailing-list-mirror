Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21892A1B0
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135704; cv=none; b=o1rwHiBGITl81yduzz3ByrAMS8pbc9KOh0xbMq8x3bCefb/uXlqPdapRrgj9h4YTpudiGSNwqb0VXITPNXN825+GB3eu8OyaXSO8LQe5iJ528Ixln6VPYEBcCrcPlELaPBhJDkSecUCDaRWMOMCtEmx7Se7EGQ8Ccf8p8WHOuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135704; c=relaxed/simple;
	bh=7XciwA1EksOAi5kArXPv8ewMG8B2R4hHuu4tIk7ejZs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZIkkF1diYex31JyqU+JyVqGM1veHbtf3wqQi92u4mTBNS6bnZbG3Dlr0j4TMiRboO4elcy3y4ulQC4msx54gxoa4in6Ip44Denc7B7LrISAR39j89lgSo7nUrr5TdFYN3ptGFWx01cVZnuAK1B+YASR+mLgLicavWsUdYFKDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGfXqG1w; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGfXqG1w"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c61486d3fcso1198095b6e.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714135702; x=1714740502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAl+vFD3SYl7fCfu+ZPBA0IW7Kf3Q4xrAODBCqF66I0=;
        b=iGfXqG1woLjHc4JOlK6KM34i0oAaJ1hWrJvZy+g0sCmlUXwlgMIJIKnCqulWJeTxtx
         xotXvewRiaSeLckYNyClJE9MchLpMfeGNbBuVHR57+T+up8OIKJgu+Oe0g5181ZpQ38G
         5qRBUx9DemrRdVww/P+RyVBlh/lUouTgbUQP21m26iaZ3jiHqjGBJSCw/urAdxhuWPY8
         sd3LalSpb/OgJMXRj0HM1+rmw4lYL/Pf2+L3gP1IDkDNIC2A/10MskaZiznhhJcfTM3q
         iAAETSs90HDWI2TvOxs3u7+lPp1u+g0VyhiAeJ1qjbtPAdgBaqTdDFfk0DvAA76qS59c
         CKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714135702; x=1714740502;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAl+vFD3SYl7fCfu+ZPBA0IW7Kf3Q4xrAODBCqF66I0=;
        b=UqFxWOYMe+dxIzhU3/3URoe67B0L8LuVEfpCgzLdKDGeT/cgPtusdi5v8H0ocpJNHg
         Yp4rLYdoiAyq0M1XxNCUGDEVTs/T0ySNef3vEDj+xOHfF1JRbVsBgcACmq3CkO7sDcFl
         4dCKU4aSU/3yzdAqtVmEXA2TNVvy+EmbzwFs/JI17Wr7XRY2tF6CBuqsfpFm5jkcJdK0
         IhrSSBBtHhwFNbQGixpplMfBJ/LyLYKYKNbTjQup2C7lArQeHTuYoP37zDiCqTKFg23g
         c3P1yJo7EAqwqYFo3lhvB9JzxcGNR/lY8QJM7VCILqrXer6Jepfusp2SLkp1jOJLt5r3
         Q/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUfckPpFurGV7n0vUWAz/QaduH0v23Osljkp9dW7j8pzC2E9HzORD/ACHJnO0FH7eaj5aaDewW/0WAifTtcLKkov2P3
X-Gm-Message-State: AOJu0Yy4Bx3sPX8IftQ9VNjmDn6EJ/PYgo2CoN6xub75aHQKXd2ohY6u
	f5XducAXpXMk/4eqVTlL1HlPMFc/sG6E4hMNlHDB7nlVZAICLHZKT/RhRyarUGMEtW1lJcQvvSP
	mLCnH+iKPRvM4IWgR+LuOJbZvgR4nUA==
X-Google-Smtp-Source: AGHT+IFAA35Ni6QiY1KIisR6xzRZ4FtZDkj44e9aEtq+jkNNNIjkkNXH3AxWZiEYfvV+VWdSdbT3BEDjy+eHWkvsau4=
X-Received: by 2002:a05:6870:c092:b0:23b:8a84:2e66 with SMTP id
 c18-20020a056870c09200b0023b8a842e66mr2356311oad.15.1714135702034; Fri, 26
 Apr 2024 05:48:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Apr 2024 05:48:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcyqdds4b.fsf@gitster.g>
References: <20240412095908.1134387-1-knayak@gitlab.com> <20240423212818.574123-1-knayak@gitlab.com>
 <20240423220308.GC1172807@coredump.intra.peff.net> <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
 <xmqq4jbpgw32.fsf@gitster.g> <CAOLa=ZTjwRnqmXRuWpN7o86DZdfOsgZwR7=Gk0A3EG0zSHiCBA@mail.gmail.com>
 <xmqqcyqdds4b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Apr 2024 05:48:20 -0700
Message-ID: <CAOLa=ZQ=4n5jPii3rZkKjj7rMmxu=3jhRMx9aEsLvr8atbSCQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, chris.torek@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000009dfa080616ff51c4"

--0000000000009dfa080616ff51c4
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> IOW, we should add support for operation modes other than "--stdin"
>>> as well, shouldn't we?
>>>
>>> Thanks.
>>
>> That's a good point, I was thinking of something like this too, but
>> didn't want to bloat this series. Would it make sense to add this
>> functionality in a follow up series with the cleanup that Patrick
>> mentioned [1] too?
>
> Going multi-step is usually a preferred approach but we have to be
> sure that we do not have to retract the way earlier steps gave our
> users when we move to later steps.  "Earlier we said that your
> commands should look like this, but now you have to give your
> commands differently" is absolutely what we want to avoid.
>
> So, "in this iteration, you can use this enhanced feature only via
> the "--stdin" mode, but we promise we will make the same available
> on the command line" is perfectly fine.  You may need to retitle the
> topic to clarify the scope of each iteration, though.
>
> Thansk.

Yeah, will do that. Possibly also some of the commits too, where we
could mention that this is being added to the `--stdin` mode and can be
extended further on.

--0000000000009dfa080616ff51c4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 99bcea2b66093d7e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zcm9wTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2FIREFDRzNzSHRHcmg0RW9MN2s5b2d0Q3ZKbmhmQQpIenlPRUZveEtQ
NGNRZDYxSGg4QnNLZlZnUTRGVFI0L3R4bWsvMVFES01Xc0ZmQnBObjRFekhHS3d0MmJwblk1CnBR
VmlNd0NFNG9EV2IvVHNHbXVwLy9Od3NJTUxWancwRjlWNGc3am5xNEtIc1JiK2NlekMra0d6K0RU
c0tRWHgKeDc5akFxSlBPOTk0bktKQjk0ZnpxNjBWTG1hc0szcTliTW0xMnppbDlBVm1nVU1SWEI3
NU16VVFwemVMSFBGZwpIcjZ0SkR6bFNtYS9YandoNU5rSWJTVEdQRmlwNWFWQm03QVQ0K2djZjlZ
c2sydFFJam1sOUYvd3JJY1NxTENpCjVPQTM2bTVYZWpWZXNYY2h4S0w3M2VBL25JVzVkampFT0Fs
WDB3M0tiNzBIc2lHTDd3SDl3aWJVR2Vkb3Q1eVQKdHE1dHZMaWUyNG9kOGNrZElENXZmSDRaZHJB
MVFqLzZMYjNjYzFZOGl0eDNpUTZRS28vb3BtMmN4bnJteGYrNApDWUFVcHd4c25IOHRFa0JxejFx
NXV4Z2RtdEwzWDhRK0NKQXhpUDJnZk1IRVl2Q1JPRlZQamZxajIvRkxaYkxBCjIxOFVwTjNXd3dU
YTFCeTAwUFByN0RGMERmSzhwbXRZNmExUzMzYz0KPWtoRmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009dfa080616ff51c4--
