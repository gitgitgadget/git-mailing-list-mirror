Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C538C438
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398595; cv=pass; b=frVEhORyXNuE36IEwEuK2E7beZK4RqyRxP5NHjg9zHACKB9UqnbigpeoFuRTPB5Pj3WZPYsbXJNYizpaI077HDGvM+I/2aYjd7SVs+WXQhyfsIk7ik6qSMQbONNjYaZVh8/4KqrJuM87QfsduRKWIlf3LX6cYrAqHhltgbGlFts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398595; c=relaxed/simple;
	bh=LoBLaLx+RDSsNVHasfuECHIvFE8CGqzCtin3TiAJr0A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIPzEcmJOaF0u6JXPjhf1Xl1yc0nxM9QdZ8eqGzK6dDkPOkAQVIvZKF1e9bT6I6S7/NNE5JQWJMp+39lQ+u0iESYEvtSueeVouR+Ldu7g9rvPw7EqVYemEp6IGfPXhWMQmMA69YZy2chyzHhSaN3eKh8lW8xGxGZOe8QYAX3Iqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/cuwMAk; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/cuwMAk"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5675d609621so1710517e0c.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773398592; cv=none;
        d=google.com; s=arc-20240605;
        b=VxAss7Z3Icx8ecWpoNRXcFEgA2BDQlGBgsc+FvH4CpEOoLEMnpomo0MrAAG98GCK/M
         MBcLdVs4e8jhdLIbFkWcCgQhypWCEPmOMFJVve6cdlQV3Iw1vb+OvdpAquzpO++ebm08
         othF5rj9zRI0oZb1Fqz1kLmx5xdKCQHEvIW1FZZTxC2C3FVDhkIpb0ixtZSkDe5/gAEn
         yZTGKBXLmYPq3Ik7YuLfBvJs/7uoz/74SvohljmHPrG8i3x46tz+1kaI6iZc/UhB8p++
         Yh9gd/iHnEs/tR/xHcG8y8csx1CV3ynXptXuV/SKv6gXaPwrVn4hEfeQ/OrffyD7GoCb
         GVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9t0zUNDV8bbTzJyz5O1Fo7NDErLgLa3hLW7i4juuI7M=;
        fh=a8cTPv9FfsFwNY0lxcpqyT8SfG/Ns1B554fuWqPTzT8=;
        b=MvCecf3X5joXSMfCKaNXqrooh2EItLgHTWMIpSJx4pUf5Jl4ZQLW1nPzmgJ0bK1g/0
         uQGsMt/Nr+EU/EhxAN8g9lxiESTkPtjUbfeCZVDuHSojkPEVvyInGHr4r/TR5GK2NO86
         HivxIfoQzHhy3IpqKgpVAajkx429tYkyCfohS+ElxN0E+X4IyHcBij3mrcpUDnz3fTkP
         AS4rsADHMAcHGBAQQ4wpUN179crP/rol4OCp4oJaeSQPVCxpEvmGE2/Y6v3Ev7R6vwaK
         7Xd1x7220QJKgYb6aqRWk+69R9V/Xpd3yMDFzBtYXFlmEDVDT3hhfjIIr2y5u7udwL+E
         /K4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773398592; x=1774003392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9t0zUNDV8bbTzJyz5O1Fo7NDErLgLa3hLW7i4juuI7M=;
        b=d/cuwMAkYTnPw8aV7i9RRJKZQkpJ0NF+m3/JwSSnXhEMFJBPtkzCv47QnFwWyjqkpy
         uZi3dW+2IZ+KshCUrsWysIJLuXnIWxpN5ZOPopoR0EELOEmg9hskWkAioEntTDnFyoq7
         ZM/uB7N4W+xOK9GOi+ufFFiAE+97mTV0fWxeiqnJOq8X8LkcK9m5+u0lo9vYH/Yb0vSk
         UJgw7NIYqpoNtnWQ+mz8Br1BjVrTf7yobFhDZDwl9MECSL0TCn3hT0EMExZpwlcwDNft
         vh/Le8j6mwuIsppZxJr4FoOrwStiyYUeMN4A9UoEIzUa4kSayTiUcFZFNCYFSfj9c5l9
         Q9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398592; x=1774003392;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t0zUNDV8bbTzJyz5O1Fo7NDErLgLa3hLW7i4juuI7M=;
        b=pox0twBURUQIOidFhnBui5rRxrNdgM8Hyfm7MpjUJbXj5ZErio+jMTH98/oWg0IXAg
         Drdun1NpplPxheRtzgTz+Z0ufAe1qtxQo7zqeysSqCsRaJ/oGK18QtFJZnFh4ltrP+e/
         X6O24yYwNFwHi5KL6nmVTKishK0ZACwMiTFDXC0g6G91c2FiMXtXGFihBZgTHTyaHgtR
         pII2XytGPj1l+qfcCFgkJOEEH0LfoGpcJtmsbTF2clwT4ngJzIgT63WGwaHuIHHfLHhO
         7b7S07slIkiXmUKJXzWF3+wZruQSpjgqiA3ENLP6S6F+p6IDTt4BJJRuMv35sW1G4utn
         Eq4A==
X-Forwarded-Encrypted: i=1; AJvYcCXUxzL5hj/iJGaTJLa7Ua7cDssEQ7S/xp5bUI42CuDCU5B6J1pmt0ruUfGlNL3RcUdizO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7L820bwM/c4S4kdpIFp5NIO6Y7FKx7qDQY4vUJ6oA+8EahZb
	Y3B1wg7AWzlF097LCX6P3A8rUE8bdDNi2MoQJwix3zEXGlRVxWL3fguksH9IDMAboM0Rsm5FCx9
	ITzVUV1rVTbw45VVtnkA7y54ivEsMaiY=
X-Gm-Gg: ATEYQzx1jry4UTLUi0KULGybqU+5x60IH6U5TjlxXpjbSFjXR5rt3x+1lXrdaoQ1HeT
	BSu+ZC4j+2WC9WvpjM9OiIofurwwYnVfDhPl9x+kOuFXl++ZSAcgH2Fn9goOvTGg0Jrx2FOTli4
	IQICoEm49rJivSGvj34bMGLaMrm3X41ebjNWDg8lSVQ1mCYB1NTWxSz6cgNWDYN3yWEW9QeuZuC
	UP0gUmay1AX+kYks/m3Y/fb6LLpxIQMblcR4OP/Q7lmHXDlqHdRiI2rWY63DvfN2Iz2xqIi4cmI
	0K3Gx6oFusGxnJYYaA78/BfJGzCjj3aD8loJDbFxNw==
X-Received: by 2002:a05:6122:50f:b0:56a:f5d2:286b with SMTP id
 71dfb90a1353d-56b627f9be2mr1122683e0c.5.1773398592450; Fri, 13 Mar 2026
 03:43:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Mar 2026 03:43:11 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Mar 2026 03:43:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOAgETMCb++MnOC9YEN+y0TE9NeVC+-=Zez7UOVY3kt8vv7dRQ@mail.gmail.com>
References: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
 <pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com>
 <xmqqldfwacyw.fsf@gitster.g> <CAOAgETMCb++MnOC9YEN+y0TE9NeVC+-=Zez7UOVY3kt8vv7dRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Mar 2026 03:43:11 -0700
X-Gm-Features: AaiRm53a5TiXXkjS6HF2KuJ80vBE26gEK7_Kd9lWqVcQvgqtxA9GOPwS2YTkU_Q
Message-ID: <CAOLa=ZTJ1u+cyVZyOGQbdOniK+U3CGrYSJRaeecYsT9+D8gWFQ@mail.gmail.com>
Subject: Re: [PATCH v7] unpack-trees: suggest using 'git stash' when checkout fails
To: Arsh Srivastava <arshsrivastava00@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="00000000000026105a064ce58956"

--00000000000026105a064ce58956
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes :
>
>> The first paragraph is a bit of a run-on and has a misplaced "and";
>> I cannot quite read and understand this overly long single sentence.
>> Perhaps the early part can become a bit easier to read with
> punctuations, and cutting the sentence into two, e.g.,
>
> In my future commits I will remember to make it as easy to read as possib=
le.
> With less punctuations and shorter sentences which will in turn make it m=
ore
> concise.
>
>> Also it is misleading to say "previous" error message.  We talk
>> about the current code in the present tense, to highlight what the
>> problem in the current code is.
>
> Understood I will in future not use previous because it is the
> _current_ code.
>
>> You may view it as a weakness (which
>> may motivate this patch to be written).  But I personally am not so
>> sure that adding words to the existing message would necessarily
>> make it more clear.
>
> I understand, git wants people to not explore the available
> change options and help them make logical decisions rather
> than pushing them with some unneeded commands.
>
>> As Documentation/SubmittingPatches says, let's instruct the code to
>> "be like so" in imperative mood.  E.g., "Enhance the error
>> message..." instead of "This patch enhances...".
>
> Understood that makes sense because nevertheless
> it is given that I am writing the changes for this patch only.
>
>> These were already overly long, but the updated one is way too long
>> to be read on end-user's terminal.  The source lines are overly
>> long, too.
>
> That makes total sense.
>
>> to those users who decline the advice, we now show "Please
>> commit...".  That is not what !advice_enabled() should trigger, is
>> it?
>
> Thank you so much for your guidance the advice should not
> trigger to those who have opted not to see.
> My code might have misjudged this paradigm.
>
>> Also "To move you" -> "To move your".
>
> I thought I had fixed this typo. Seems like I didn't.
> I will remember to be more cautious next time.
>
>> Also the advice lost the other possiblity of first committing the
>> work in progress on the original branch before switching, yet the
>> new advice message is quite wordy.
>
> Absolutely correct this commit does narrow the users vision
> for exploring.
>
>> Also, using "for safe merge" when the user is performing a
>> "checkout" might be slightly confusing, even if 'stash pop' involves
>> a merge under the hood.
>
> I don't want to sound like a programmed robot but I absolutely
> agree with the recommendations.
>
>> But as I already said, I think the current text may already strike
>> the right balance between being clear and being concise.
>
> Thank you so much for your valuable guidance.
> If it's possible I want some guidance over the questions written below,
> As it is well stated by you that the current
> text is clear enough.
> Should I still work on this PR from a purely GSoC
> perspective. Or should I start making my proposal or
> still work on this PR until my micro project is merged?
> Because I have already shown I can navigate git project which
> was the goal of micro projects in the first place.
>

From the micro-project information [1] for GSoC we have:

  The coding part of the microproject should be very small (say, 10-30
  minutes). We don=E2=80=99t require that your patch be accepted into the
  =E2=80=9Cmaster=E2=80=9D branch by the time of your formal application; w=
e mostly want
  to see that you have a basic level of competence and especially the
  ability to interact with the other Git developers.

As such and seeing Junio's previous response, I would say that no
further work is required here.

[1]: https://git.github.io/General-Microproject-Information/

[snip]

--00000000000026105a064ce58956
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0107c0602d1ee60_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tejZqNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFMzQy85azNyTWtFOTFnaWpYRjI2VTNCZDBLTktFQwpva2NTSHJBU1Y2
WWl3ZlIzZjVmUTZoNHlMWlpMdVBaN3RaS1NqNDd0YzRUWnhXRytaWjFzbjhlMGx3c2xreHNmCmFS
Rm9yV0JzQ1R3Ukl1aVBIK1NOZnNlQ0l1aFd5RXVnbHEvYnpSUmFRdGpwSlNxWmtMRC9NQ3Ayazl2
VStKa08KTHc1ZjVHU2pyUUhYVEgrOEdZN3VMeGM4VVZXTWdOeW5WQ0QvMWw3b2hWZnVmZzJYR1Uv
cGczVXB2VzdxbDQrdwpPMjAxNVZkV2NqRWpwbnQ2czVXQmo2SEtGd1RiZDJwb0I5K3M5ZEdwbXcz
NDNJRnVweGIvSHk2YkNqek5rckh3ClhXMVVLUGFoYS96c2UxNjczZE9FcHZzTVRObW9oZkY0bDNx
V0kxRnRzUkE5ckFkSytuUEVyYnBPeWE3TjJYczIKS2YxZks1eGE3K1BubVhTWlhjc1NVMW9PdklQ
R2wrTjhwM3Awb0ttdTMvVGpYZG4yVXJSQURzQTJrMlAzMXg1aQowMytDUm1KSEVVZWRNNmZpamZZ
YjRVWlhlS2s3RzRRL0xVdW1iekNQN2Y0M2U0VVNlOXhUWXVzeWhQUkhmaytBCjE5MTl0TURjZTYx
cTV5UTlUVm1nT3NUMmpub3dqajd5N0FnSUllaz0KPW0wc0YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000026105a064ce58956--
