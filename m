Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0F14EC46
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266130; cv=none; b=D32MDMtKYSbNMGVSseQ4xrey44M7im1h483ZSjEPeezvmRS05fO60JBWsNZJogQhP4QCzgTWj9pvr9R2nZCpj7IfYhAbUvJBDe4cDxor0HTkVtwSva1A+zu/VhmqDCpu1QZAh6qkORyK4fXMiFHI4WxBTKIj4wYT2LZZOCebTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266130; c=relaxed/simple;
	bh=GiXhTq5XMlS5bHTxb8Y6lQ5G0YRgtxMOAPiO9Yl6yXU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aysn+yP2/EA2BjejVUWCFeLB8B0tACiiXrw0eM+jEzVAwiojuJhQx1VCN7fhGsj/AT7COpi3KSJaqMfSRXqr4wHEgoIY2J6J1A0NfrpKtyryM6u6viD3YsGo3DB4AM1w6M8CYwIWOIAq4k4h90YKNVepM2LDsju6Yo/nzjCTjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON3syqbM; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON3syqbM"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523de538206so1660745e0c.2
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745266127; x=1745870927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8C5XGuL0sdpTdJqtm6plGW+ETzXSPWuLfv4CZGV0kAA=;
        b=ON3syqbMj5I80BRdqXO4oQXfCVJmv9TYs5ZlfvcnhkzmUz8koqCJMrCXvywgo+7pTh
         2aq7JoFCqpuVazLHefm7AqvE8gFilBfWHqW0kF9i1kGTUhyRjRZ4xS77i6MDRWwx1npg
         EacVhpbcMVpzVtuIb55+Y/ck7nToZCpti2Xd4Gg/gTgArLL+lojuYeTrS2TJoDDqtdgn
         FzMlkWNARq2BPDj5nsInS0CSYNF5baigqlAJiEHsfAqe/gxeYjQIeA+xY4eUEkvMsRTu
         h2yyEHx4wYf7cqSebAgmku9/cEr5c6ShUoKCL9Hs0hcu/yXxmTPrfiIW57wa2d5VOnYu
         Ostw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745266127; x=1745870927;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8C5XGuL0sdpTdJqtm6plGW+ETzXSPWuLfv4CZGV0kAA=;
        b=PA6QVjdJ0d6kLFdw8xZs53SHs50QZLBJ/sJ0f5YZIpT87Mc6JZd4Rm5qwj3IoDYMNa
         7hHUWlSWzZXZQtne7dPn9alaqUlPgNk/GpN3QQ/WDcSYH5cvhKYtq+d/xg35Dnzy351D
         hZ+gjeCvKffgky86xKcyb4janu55cSAdJUF9LJLg5r1AbYL/we2aj1PntBrfi5uzZGI7
         1EWkKK6yxIaW70DbXcpQphMRjTQn2YHQM+GG+UxUrTm+FL+Zg/tWv05euuWbcSj2TzUN
         cipeNmNtmsEQIOml+9amvI7EfMYx/dVdDfFkddUUCTysoIx3U0kODAxZUcZsaW/TFsVt
         gMgA==
X-Gm-Message-State: AOJu0YxdSLf+pGA3H1VTxsTkrdoTKmN1XmJPO5TQ0FEjdC7Yvp3saZcq
	hl6AZaglkbib628/qPROIX3MdUJQ4TuFrIC9qLeFVBR2uS0WE50AyEc1m9iageTjZe/iklgDcnc
	EZ+1FflvszyvGhwPQK9OGm45RDUM=
X-Gm-Gg: ASbGncuFWRTMnWY02B1ynDVnNNV5EGYGP6RonbQ2vXed+iH+Yz3W64lUptQno7V1QLb
	M/pV7+X0VU8rZRHF1HQnOeHKgCDaGIDKj2PRllWRrEniJSRExB9VsHck0s78BfOfXfmylaadMxF
	+wIvWql6TTSLWXqL9xsMcrMhIbNhkFBM2PAzQczKGVVt2XkBQFkNanNycl
X-Google-Smtp-Source: AGHT+IGhdBhV0yc5E80o7myXrq+wnaa5MGJ+SHT5LpkcgOsoffZGXcdJNoHSciz/rB07gyCAcWQds6DTM71ptsW06ME=
X-Received: by 2002:a05:6122:1791:b0:526:483:95fd with SMTP id
 71dfb90a1353d-529255099femr8983496e0c.10.1745266127566; Mon, 21 Apr 2025
 13:08:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Apr 2025 16:08:46 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Apr 2025 16:08:46 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qnt7c9w.fsf@gitster.g>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com> <xmqq8qnt7c9w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Apr 2025 16:08:46 -0400
X-Gm-Features: ATxdqUEfJ3MYydAzwBOv_aTee1pHicJNVpZV9jVPtoL9KlQt_2DuEFK7Ylfrabo
Message-ID: <CAOLa=ZSa-qQzi3iWPF+M5a4EsvGiQFX=2Ca=vzuqwSLWWXSw+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's hdr-check
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000092a77f06334f6fc0"

--00000000000092a77f06334f6fc0
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> "git ls-files" is complaining that there isn't a git
>> repository. Looking at the output of the checkout action (reproduced
>> below) it appears it is extracting a tarball rather than using "git
>> clone" because git is not available. I don't know what the best way to
>> fix that is - I guess we could run "apt-get install git" before
>> calling the checkout action.
>
> Interesting.  The use of actions/checkout@v4 is nothing new in
> Karthik's series and we haven't seen this issue come up.  What's so
> different with this particular series, I have to wonder...
>

So the steps in the GitHub CI are:

  ...
  - uses: actions/checkout@v4 #1
  - run: ci/install-dependencies.sh #2
  ...
  - run: sudo --preserve-env --set-home --user=builder
ci/run-build-and-tests.sh #3
  ...

Step #1, clones the repository, since the `git` executable isn't present
at this step, it uses GitHub's REST API to obtain a tar of the
repository.

Step #2, installs all dependencies, which includes the `git` executable.

Step #3, sets up the build, which includes setting up meson in the meson
job. At this point the `git` executable is present, so within meson
`git.found()` would be true. As such we run 'git ls-files' as part of my
patch series, but since the repository doesn't contain the `.git`
folder, the command fails.

So like Phillip mentioned, we need to ensure that the `git` executable
is present before step #1.

I hope that makes sense.

> Thanks.

--00000000000092a77f06334f6fc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ad57d71cea50dbb0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nR3Bjd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmFIQy85M3M2YncrYXZ6OG56RG5ONGJWdys0RUR6dQptYUFZT2JNWGpB
TEpyQVVHckRydGhoamQ4SXVYQW4zSVpod0t1ZDVaQWcrRU43TTZoZy94eGUrK056OWtqdC9ECjlp
dXRTTmNPTDIvUlVjUmNPdm5TYWlLcE04bjZLOEQ0TThuV0NCc0NlYzR1d2E4OEVHTmQrNUxySkMw
azVQVXUKdmdBRUswUjU1YTF0d0VoTFBkcDZWc2NTdUd5cFd5ZFNIbU9jaEFvQkRpOEFsQ3dYRnoz
c0FSbEFKcFBDL1c1NApyVGFtbUxMaldFYWw0MTVsWjhrT0JyQ3FBcHhVZTJGODM4bWRvWk55bjlF
RG1DdWtpeFZMemFwL21xZWNYODhGCkJDRkxuYUNKN2dIU2h4QlFYQnozVzR0dnFOdVlhaGFTd2Yz
dk1BMmxhK3Q1QnFFa2NhR2FydHBsaU1mT1dRckIKUWgxOGZDZzY3endqZDRoTm5tTlQ1aHVDMWRs
SDZhd1lRQXR1MEZTMWtkWlJWQmVIMmhGZ28zZHNrR3hwbGRBUgp3aVR1V3hSZ0NIVVI4VkNnVUNX
RFpSWW4xUVZjdlNTdHVyTHd1U2ZwbFN5eGhZaGp0d0xoeENBN3BkbS90V1ZiCmlBUU8xNkJlQnZj
b2hDSjl2ZFRmakxBRkExWFJOTlIzcm0xWWw1MD0KPUY3NGgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000092a77f06334f6fc0--
