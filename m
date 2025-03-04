Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02D2777FB
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111657; cv=none; b=mQJI2Sn1YsF+YPCBsDAIHm98qfy6LP2MFpUMIpUV/43RcB3sFgjzI4FhozmKCSTSoqeUgweTHsnZkm/qvq9ybMBsiOMQHth9bYySl2YGSPtz+o6MlWSwBxYRaL3XBdNGuHr1+Ufq/Ief2zM6NqTAxv6mSTzGvLBlssDp5AxPFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111657; c=relaxed/simple;
	bh=ol+m8yOPveIYSPX+xeSbKMeRnapPATL2EpAjoFY38dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7TU0+yDDsDamywbtudsOvHKHkqxDfDGoXAhI+imcrsgv/Nac0Jat3NTm5UugTXuz1+yuPbFiAmcserKs0H+wMk6SXZdshr9x+Rl2no6uQqGxA6YyQxQeXbtVfeDbN7S7Y9Fc/uoffwaif9JnVtZtTlNhFnkptzEB42+JpBwDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8965f8051so8134636d6.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 10:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111654; x=1741716454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stucvVDNmzit2jqkKSB3Wh3W1yio6jJ/vrK1n0kwTWI=;
        b=imkYmae84GsAPQwB189GIQT+lGOhpEo5dmUdWh92lGMXheuJlHDb2u4+jVAYcv/tQP
         JwNSiKbF8gedqEOrvnTIKfBSnuBBGeaoaMedn0llBMC2vmflQK4pytiAqaht7G9nqsan
         kh40IjIj13Pr7n8qzvwdnCSADV4IogfEeQwtt+NXrR2Wx3n0UHOkALsUfLZ6vGVTHCf7
         y214eGRxEQU+O0elHtm2QNK154s82AYh+A/hcq220QEgVWtyWy0WRLFnACtx5TtWgLAI
         odNEhpp1XcNmqjWL3g/8I7X9BPi84Of/5wCeJ1iRGdTq653lZmuEwo8YKaq7kkecKoYs
         sY/A==
X-Forwarded-Encrypted: i=1; AJvYcCUU2U0vikeYWaKvSqBgJf8np9RfCLUbgJOVcozq0rZazvbOmYX3Jxyx8zoYPCQpiBXHom8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjWSfmV2l2YrrhtGk8sGTakRAekCgs0Abmi3MMjRtawu5i6jC
	I36O7cj/FlHqTjrWvI3Bh3xomJxIRLk31axc9fy5UulTUB2fMlqPCmDGfsz+eIXLVR/kTXtWYnu
	7Y8fmjw3Puomamt3DpuGzQU+MB70=
X-Gm-Gg: ASbGnctfwE7jAZnmWqjF7WxwySBW9WmCikSOfO9/ECmU13pbth3dTsD5KiQJhYSQDYY
	YKpL9vWFzi9UyDOv8X7pW+PtGtnkwQOTEXc+PIFGmBS0aoHjFopWQDE13tpiciTaH2rGyiSag8D
	kdw7BKvyVYgyzwTk2ZgjW8ZT32z0Pu8jSlkmJitTL21DGMNS3WWrRRsEBiUws=
X-Google-Smtp-Source: AGHT+IGiZAIgfc3EcfvuWYTnFvEdd+66ldPbtdZ6QdQSOfzr2n3SFBNM1MZB657bj3RF9h5qaI37vwEetkAoQqWCcZo=
X-Received: by 2002:a05:6214:62d:b0:6e4:29f8:1e9e with SMTP id
 6a1803df08f44-6e8e6c1dc4cmr1642996d6.0.1741111654179; Tue, 04 Mar 2025
 10:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com> <Z8WD2MeHpOH7Ni8A@pks.im>
 <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
 <xmqqldtlt304.fsf@gitster.g> <CAPig+cQ275qBWzaYmMXydiA_8+CTx3FhAAY+o8ro+hD03wzu0g@mail.gmail.com>
 <xmqqcyewr8j7.fsf@gitster.g>
In-Reply-To: <xmqqcyewr8j7.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 4 Mar 2025 13:07:22 -0500
X-Gm-Features: AQ5f1JoWakMOPweaTVEki8JxpYZ7gsCppqVUcMRGcdjtQxPIb0dbdWhd0Nlk5IQ
Message-ID: <CAPig+cS3QZhZ=W2WfM3T3EngaMOSV37KH4Pqp78QHzOAODtenA@mail.gmail.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
To: Junio C Hamano <gitster@pobox.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Tue, Mar 4, 2025 at 7:05=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >> Mahendra Dani <danimahendra0904@gmail.com> writes:
> >> >> >       remove_object() {
> >> >> >               file=3D$(sha1_file "$*") &&
> >> >> > -             test -e "$file" &&
> >> >> > +             test_path_exists "$file" &&
> >> >> >               rm -f "$file"
> >> >> >       } &&
> > That's a good question to ask, but isn't the implied suggestion of
> > dropping "-f" going in the wrong direction? If I'm reading
> > remove_object() correctly, `test -e` is being used as control flow,
> > *not* as an assertion that the file exists.
>
> If sha1_file says the loose object must be at path $file, and the
> call to test -e "$file" returns false, two things happen in this
> function:
>
>  (1) control stops and "rm -f" does not trigger
>  (2) the function returns non-zero status to the caller

True enough. I was misreading `test -e "$file"` as _only_ control flow.

However, it's still not clear to me why this function is making the
`test -e "$file"` assertion in the first place or why the enclosing
test should care, especially since that assertion is only checking
that `git commit` worked correctly, but that's not the intent of this
particular test[1]. So, `test -e "$file"` seems pointless or at least
misleading.

> If you omit the check and say rm "$file" instead, under the same
> scenario, (1) "rm" is attempted, but there is nothing to remove so
> the command returns non-zero status, and (2) the function returns
> that non-zero status to the caller

Yes, I understood the implication of your suggestion, but as mentioned
above, it's not clear (at least to me) why `test -e "$file"` is there
at all since this test is not about checking functionality of `git
commit`.

[1]: d01b8203ec (show-ref: detect dangling refs under --verify as
well, 2017-01-23) doesn't explain why `test -e "$file"` was used.
