Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9813A268
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614613; cv=none; b=iXsargstcHglRxLYeyGm8YT+OgpKsIul3Br1KDuMZYzL/1T298Dk1d2lWR4uetvulDS64Nc1s5UfswU83Pz64tEsFI9EsFRrVSypmMuSqPA8/7Rqv5AFZb3i1WLzYAXMdSYYFHjycJ++Eob5vMRpQ/0ZB4jC1G0fgE6qT/b4MVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614613; c=relaxed/simple;
	bh=KHMymydprm42a3jVRFSSw6MpAza6V04Jo4s+PbPMp60=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJcKAev070g0iZVwSC/c3JGQhXLHRdO2CBOjw0kafNpyeLm00yqnlAUhNxqJ5V6rqFcuPezStxJpIKFWPzdY4VWltLAvNf+iVG84ZUKxxjA+Jed8eryVjikOQDv0y0F3OP3IjtsvW/397VjyCei05eS1aQLT3VTuBoOM2n2/5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaVmksh2; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaVmksh2"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85b07b8a1c3so651293241.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732614611; x=1733219411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHMymydprm42a3jVRFSSw6MpAza6V04Jo4s+PbPMp60=;
        b=NaVmksh2F47W3upVaULMVs3g39N+kT8ZN/PqUOLggu23mCqQwqxy1jYizthP6AfvvX
         AATwaCZFTjCWSTAAxe82iMurjAen5X5jrMoAZXYkh/E1AsKo8vSuYZNA23jMM3qSu+m/
         OKmJg611ClXDm3uVgpfPvcjB2Q4ES0C0i70uTzrmJ097+XiOqk8GrU3Iqe97zaIVQLjB
         MZAEVlKtQGgUbdW5PaloP+idVK1KkmSQ0/Fm4G2YrnQIJSEHoBwYAXdbjPPxs0/qU4TC
         fvMJkqS/iz7wOiqRKV632DzdO0W/AkeSd8EZtg4dLyiLRk0T0hob0rOlYEoGttOQcNk/
         4+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732614611; x=1733219411;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHMymydprm42a3jVRFSSw6MpAza6V04Jo4s+PbPMp60=;
        b=dPK+oH2QxBWZ/eEG07Jca9SMuAQ2CZNv3xe+b264cV6XZ4Qff1mA+xJcKBg/nSZ6OF
         xU5hkZhtFUmCf8fM0tjxhRfBDqNV6arTVpTF0iy7nf8+pUU+tVx1QhVM3+/FUOMHCmLF
         GJja315/v9gXEBLiEo+ZY39797H4MO0Iyqen5Uk+2EXWPQ8qDtqZvwwerCDJ9Kh9IEig
         9TaCfFn7mHnDNUktFSlrGlCfu5g6rFQRwuEef6a1GvqLW9s9sEMGGu9mBOuzSVhkjP/W
         5TGtkDXB9LCJnZZtrVi0ZoVJE908VUb2HwJ6Ty/smg8WMS9iffv64PFaamfHifu5rxM/
         INpw==
X-Gm-Message-State: AOJu0YwFifIFGxtC/ywm/PnCqd1Mp9A7IRlYC1QighPfzWArcddTdwXp
	ekcNxGLHjklvoY5x0399h7BwfvLWs3PUL5ZXmb3v/V6PE2x9NHCttIKLlLqsPnIUqi1LM/TLMW/
	xRh/3g2zm9VjNPTk80jtqT3yF7QU=
X-Gm-Gg: ASbGncuPY+u16ssT/1iGmdcWChfH0HhMCEq/RXSI5/rzpf//qbUdu0l+c6kRD5BPyy8
	+JL+cqs6mVjKqn+uq4UNMdzj6SkYx8g==
X-Google-Smtp-Source: AGHT+IHouoLrBE0NyWSpkJ5SGomJMMkMlDmdflDT7fojpLdBP3fpMW4llVcv91YGUNdGNznrWQPb2AP08Opjz6+8Aqk=
X-Received: by 2002:a05:6102:50a4:b0:4ad:5dcd:2c44 with SMTP id
 ada2fe7eead31-4addcc31533mr16467473137.16.1732614611076; Tue, 26 Nov 2024
 01:50:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Nov 2024 04:50:10 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD0=OycMAaDi_92-Go2Mt4q-s7cfmBaZD_kWBnZsvYpiPA@mail.gmail.com>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
 <CAP8UFD0=OycMAaDi_92-Go2Mt4q-s7cfmBaZD_kWBnZsvYpiPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 04:50:10 -0500
Message-ID: <CAOLa=ZSF6PC0dXGE8JUeeZqQgxgGAMnKJNGNeEMTwhCwN-OXYQ@mail.gmail.com>
Subject: Re: [PATCH] builtin: pass repository to sub commands
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000006d1dc80627cdc693"

--0000000000006d1dc80627cdc693
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Nov 25, 2024 at 3:56=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> In 9b1cb5070f (builtin: add a repository parameter for builtin
>> functions, 2024-09-13) the repository was passed down to all builtin
>> commands. This allowed the repository to be passed down to lower layers
>> without depending on the global `the_repository` variable.
>>
>> Continue this work by also passing down the repository parameter from
>> the command to sub-commands. This will help pass down the repository to
>> other subsystems and cleanup usage of global variables like
>> 'the_repository' and 'the_hash_algo'.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
> Yeah, this is definitely needed to cleanup usage of global variables,
> and looks well done to me. Ack.
>

Thanks for the review.

--0000000000006d1dc80627cdc693
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3f165a388115b9e2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kRm1jOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOG1lQy80a0kwN1M3OVoxekI5ZjU4ajRkMFVibFVlTQpYQkFMbVNRdDlk
NXhtVFZZTkE2aXY1RGJBOHlvVC9XbE90NHo1RHJLcldmWkFKbGdOeFcycXpRa1lxckQwaG5FClZP
azh2WXBKR1R1d2htV3FEWGFmNXBUaWFPc0Q5NEY5cTNIako5NEF0d08xNDNoOXp3S1J0UWRmbXhT
Mlk1dnYKZHJ6NGh3R2ZTQVNDS2xGTlk5bEozQmVmeER4YjFWNlY4aWlFSm8rUitHRUVoVUlCZXdG
akxpcnpkYkFiejVKUQpaM2VJV1VCWFV3RDZkalhCNVRPZmw4YVhxdGlsdGVEbUo1bkl2QStQcUtw
WmIrSHVKa25GWmhRV3hlY0o2SkxIClZYeXhHQmtDbkM4ZXVyVUVlSFM2QnNGRUlBcEE2RUl6NS9v
cFRUdmRrc0M1eVo4amFHeTNQSWRBWU8zOUxHcGoKWC9WekpzTkVEbE0wbWJqYmNoWWNuVWxLa0RE
MzVGdjZiV3hNREtXNUNIeDJBUGtLRU9VWkdUT1VNa0c1MElIaAozUHVJRWtodFl0V2hhcGFKakl6
bFZMZzZqNW8wSXcyQWd3YStXTGM0TjhPNFlMUHFPNGpoc0FSYXZzMmVyRnl4CkhsTU9GN0ozc0Q2
bVcyNWN3ZytIOVhzTEg5dWxjNVpLbmMrbWZNUT0KPW5hNHUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006d1dc80627cdc693--
