Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757A28488D
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750511; cv=pass; b=iW71Kn/IcBSt1c9tL3Opb9MsKk3qCb/3WZ/AP+nPokLRwC2C+4yhMryLFiD+ou9zT87M4lVMDL8uENOp45BVM6GELsHWBfIc094UOT1lulZ5jYUE9sHSFAGzxOLgaiwr0KhmyeD6coGy1fzUsJ+lMTrSnAjhtMk8iEXKWoQDzD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750511; c=relaxed/simple;
	bh=z5hK9aEdgZ+wfOcSat/x895/V3FBjRomcyC0tV1sHWw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVKn4TXjKPyJu1OGiR2QCYCbzxdQAaOfbNm83S9mcfw91yGHzwwqFUHQxUdBNZOtYELWNHPyqf8LLUmlU4efG1i12c4qz6plUQLBYjjdty1J0wst5RvIzC0ufz7WsoaIp3LHycQTkDrJvB80KVs/Tk+FbhEAHYUcWcDE9KFfbvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooFrH8U7; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooFrH8U7"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56d85881a68so404648e0c.2
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 09:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775750509; cv=none;
        d=google.com; s=arc-20240605;
        b=Et/2yTbn/w22rhTMEszJAG3llBan0GX1c1BT1bOuBH2gr0GEvdO2yT7YUG10ve5uAr
         2tDxGXCWxRPRbour9FBOt+N9/A8c67dN8gGS7T2+SPNatTI3gOLAE92wAO2kDUiOLCB4
         ByLajyWskpDtu8vUDYAmGZgIh1/N2bxsLQ6Utu0wKHwoNanAwV4fflx7xxm28AzXf4lR
         yoF6nc40CodGmm++oMm336pwErVBQTxG6NpSqDSb5LdeMS+qRD2isUmP5tp5yMYZqG/v
         PcBjd0tKlVtkQxRQM8Oc5IUbrwKaDHi/Hu/2xQoDFKq9clh9mIFtcqe/Ba15lz+ZD3NR
         SuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JBlYYUP50GLSn4Stit1emU9EOFW8Cuo5urDfjaPjSTg=;
        fh=Q2e35Rg/BOn5K6EbB3s/OhLDRjxcsTcqQWVV9NtjBwM=;
        b=YoH2k6sqVhOvlKAvyXrmEq0nWfDn8RDA1VcKeSpUkWXAxCfn1pOkUor7KpKWCnkAgZ
         nGXyZMHcTLcMTMvP3khLIefjfIIX54FGUR8cX0el7acR8OZbnVd57lQKg/D4Ejx9rQIM
         9D6r+DBsYCJwUMX6wEpHPo1zE3C1ogrIL70ZZV3VxjS2TmB+SumI5DLBGzS7YRog/Q2r
         0Ve2F4v2wCR9ANZ+7VV3VMRad/v4JjkhtHXrAVHwwwYz/oM+vqnwm7cO64iAQeSx3dQA
         ikvgIXDU6SZmjRzN9OcIbc+DxWJct4Rm0PKBdRbzju1JV9MAuBwDrOrRvdrdwthfmOmZ
         a6ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775750509; x=1776355309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBlYYUP50GLSn4Stit1emU9EOFW8Cuo5urDfjaPjSTg=;
        b=ooFrH8U71B2pkfo1RxbzvSEoP2qv7d0gN8VSJgX7fveiH6G++OkeSw95gfZFNExayp
         bYxpOujElmAgiXY+KhsGYUOPj62ZMb1tNbQS34ztveGWhTfssSC2keJO0gNE6jaJRdnw
         k3N7Kf+yEsd2Gw9rcNRsnz6PIS8R586UFblEELbv/Cup0qwWi/+vXBcnFQ5gPV6tA+Rk
         MCc6ue3A/pDAk/he0wfzDWSrnneGh3SmKT1h19An7G2uhe4VpnEH9RQAa11bROBNRElK
         lJe/7KAYG9NjA1PlNcfpcgK/kqVv1cqgDDcB90OxdnB6Cke8PoanEWWnsqlmAv51pEnU
         iZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750509; x=1776355309;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBlYYUP50GLSn4Stit1emU9EOFW8Cuo5urDfjaPjSTg=;
        b=ieMF1xU3UQp7Cvf2quNdlqvrAmZoge1iP60q7jKT2hfTjvduRgCkA9L7Kp4MWo6q/r
         M5HbBwA69RtF3gDfXTLm6Y4oGzeqRgZoxHo4zWlyAgbjeeczwbTOl6Kwa7TtANoZ3Cmo
         lP8zHIXws4oXtEYitMY2pm8ORB+MBPNc5EUK5/W2gB76zRcfYbFNWOulehrY6YEFbxsZ
         aIvJV0T+HTwRpfqU5G4DImwrGEVvz1TPXWu/YSroAOvPT/vUUioCrfsAAYjG3jFxpBMA
         D99r97Bejt87uUdG5i1K3DWKaEjK4Zo/CnWB+3uIBRl3ewHkLppdntAFd1wjnxJXVddJ
         f8+w==
X-Forwarded-Encrypted: i=1; AJvYcCUuI7Qvhxr6pk6JNkUGJNnG2GNHss85C/m25TQB220wwD/CpOavA8rQGoiAR0vxV3/QFfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fuyWBIT4dgpe5Lj6n5+Fyy6JUe7+SRiv6t++HcsdCivu21Hh
	MdNr6nLJNeoYYXLanz4Ub3hMcuwexybo2edp+DpE5ARXvg6nnRrY3prq01AWF0gMzSfeSakSuGG
	HYXfHlXfaXwKX3dBIBXo3DFLhRgQ/sPaEaQ==
X-Gm-Gg: AeBDieuAIqLRALrAT+EJjdA26WDJVE/jUgc1ZKEc1awiTJHutOUtit+sgYr8VCzgm8D
	6wQG/Rs0cZWWRmZ1kQWqvPaZmGPhAg4dniiXSHlDuugRUGPk6oyS9SpQs9Wl/r41kL/M6Ctyzse
	7i0MHs0LnUWTDqR01ZSISnwsV3+x1LO9rCx3WktogwFPQAHc2/efGBt0yFFm1mnVqHi1RvnqUJU
	51XKKbfAZcYGgekNHxEU+MlgBLOR3cN+6okmwuFl+dfCHRe1pyjsPKoQ3kUvkAvrJ+AftzuNs+B
	MMeDvFUwj9EM47ra79o18nSLSoG302/RfExIaRsuaw==
X-Received: by 2002:a05:6122:134d:b0:56c:d77c:ff83 with SMTP id
 71dfb90a1353d-56f27476b9bmr2421181e0c.5.1775750486139; Thu, 09 Apr 2026
 09:01:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 11:01:24 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 11:01:24 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4ilkw5om.fsf@gitster.g>
References: <pull.2264.v2.git.git.1775668134796.gitgitgadget@gmail.com>
 <pull.2264.v3.git.git.1775714492944.gitgitgadget@gmail.com>
 <CAOLa=ZRo2qWES4XW3UuDxe1Wjew_z7PDy48qQdsjQzD=G8E2ew@mail.gmail.com> <xmqq4ilkw5om.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 11:01:24 -0500
X-Gm-Features: AQROBzBCAKh1PsJmHJj6gePkzcnnXXM3iKVB3yhvXWMu-78t7VeKV82w-lRG32E
Message-ID: <CAOLa=ZSwVbqWCo5PoUtZRx-bW-96tymL6TQp23BrRRrOveFrFg@mail.gmail.com>
Subject: Re: [PATCH v3] repo: add paths.toplevel to repo info
To: Junio C Hamano <gitster@pobox.com>
Cc: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Jayesh Daga <jayeshdaga99@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000eff789064f09205e"

--000000000000eff789064f09205e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Don't we still have to decide how we want to support relative vs
>> absolute paths? [1]
>
> I suspect more than just a few requests to this command yield
> path-valued response, so do we want an independent boolean "if we
> are showing a path, show it in relative (yes) or absolute (no)"
> option, or something?
>

I think there was some ideas around this:

  - Have a default mode and a way to swap it. Perhaps a boolean config
    on the command level
  - Output both the relative and absolute paths. So we'd have
    paths.toplevel.absolute
    paths.toplevel.relative
    or something like that.

Either ways, I think we should finalize the decision first, that way we
don't have to have this discussion with each path-valued option.

>> Also seeing that you're a GSoC candidate and this is part of the project
>> that you've (and other potential contributors) applied for, our
>> recommendation is to not start working on a project before the selection
>> process.
>
> Perhaps I should refrain from commenting on these patches to
> discourage the authors if that is the case.  I am not raising an
> objection, but do you have a pointer to the rationale behind the
> recommendation?

Officially the GSoC rules [1] only say:

  Any work done on the Project prior to acceptance of the Project Proposal
  will not be considered for Evaluations.

So there is no rule stopping a contributor from making such changes, and
ultimately, open source projects benefit from contributions regardless
of the contributor's application status.

However it gets confusing for other contributors who have proposals for
the same topic, since they expect a certain status quo and a moving goal
post makes it a lot harder.

[1]: https://summerofcode.withgoogle.com/rules

--000000000000eff789064f09205e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48b5a0fa76afbb28_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWHpVOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3ZIQy85QXZRVVRFd0tnVUhTTTkxYXpWV1NHM3J4Mwp4cFIxa2t1bU9H
Q3V5aFJTWlpPdnV2eEZEQVpwMWlRNFdTN3hRSWFsekNhaVJpTXc5ckdqOUVaWFBKWFIwUE9CCkI0
UXZwcklibzdHVFNXaDdwUzVJK3QxYjNKSlp0L29Cc1BrTHFjZ2hrQktUZXdPbHEzMEY3aEZjY0Jp
aTk0RlkKNXVLNEdNQ0FWNDBXVnVyZzMvRGgwVnE5Z0JIZURaTWF0YXlDSDJ0RXBudGdyRndRV3p3
TGxNcjJXVXpnZVJsKwp4MWpiSzRDbmxMaWNLRzgveGlUcDFHMVVMQmh6NjB4OXpLOCtSNlBFSVRF
N3RzM2QrdWhSSE9FOGhaRjAvd1o0CmZrN1Z1cmhYOEhzaHhuczN2c282OHd0T0NpZ0UzdC9EYTBB
bEttdDEyWkFBck0rU05UZi9ac0VkOUl2bk9LR0IKbjJOQWlwMVNjZEVsQyt1VUpGS0M3MVFlZ3Zy
YzgwRWdTRWVRYURNdTZkaG84SVNXbW90NjRrN1NWTUNrU21YSQpjSXhCdlEyQUhGcFdSMTNOSjA3
V20wVjlmbkRZWTFsbnhwTGR4SStPaEJGU2U5dm5hMCt5RFpwZ3ZzYlVwREhVCko5TWEyUXNveXNo
Z29sT1NYR0Yvem5CZ0RXWXIwZUc4L3liaTdDOD0KPUQ2QjQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eff789064f09205e--
