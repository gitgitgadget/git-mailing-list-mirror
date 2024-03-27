Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FFB12F376
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543566; cv=none; b=QjShH+tMf5X5ExQ/+N502BtqqTHaklFAJTGqkw6oh0qxQNy+cUSBzHXZF+jOFaqAb/pIE9B0ANJkAafCewONPy9c/GYUdbw6ZNoyU5MqtPkR2U3LCE0uztvn8RZyMzzgEQLWcoC8qW9IBqFMevNev3fFLk0wXRCWh93iK/vn+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543566; c=relaxed/simple;
	bh=V5X4KHDQ86JMCck+45YVoR5DrLBnFL8rZam5MqVWkWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQYcaBeFeH/S/p3qiRf6/flhjg7QmglkQBuy+HRjQ1yZyTNDUtCN/tda/yhE74JjxxYrkbIh3OwK62d63qKqi6CDWnVuv4gronvWDDjOZ8FAo1Pk873uqN71npLhMq0MRqfCLoevv7s55KULAivBK3vJxaULN3w7SFK/ZamrSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkuNoL7V; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkuNoL7V"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4a393b699fso134936966b.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711543563; x=1712148363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5X4KHDQ86JMCck+45YVoR5DrLBnFL8rZam5MqVWkWU=;
        b=TkuNoL7V0H4kuPcj59AsmhxNilZp6JaTOOrtILueZVg5J9v2dbUVxJpWzq11xb7QNB
         LA5q0YGmCec1uh4CeLGfd1XPzBx/z/YZrYZC6SHVE8fPfyG6/klkzI3ziaYPK1YPEYSD
         6g5+6POijj6ZM0EwFYrlccLqqJdDfemvCdG65xd/lViFcd0R4FbGxaSLTanQTnbACX5G
         xKQnBHMXo9odLsVsdkAcDKMpqN1CNLSAXqW/N38o63jwKf0+wVrZ0At4a1ycMaF7wiu5
         SQ1qU7pYz6bzR+fKfw6wWnbzDy6SffgpJxgGZPaVAj+9ClkF2FjjkWpt72bw1SE4EmVn
         CuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543563; x=1712148363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5X4KHDQ86JMCck+45YVoR5DrLBnFL8rZam5MqVWkWU=;
        b=nFu2JJHNLHN8t5q3wFOnnLBNNvgRpYE4y5NZ5sNPCPlgn3tLNJGzg1N3LmuEp7fnqz
         e8G0h50EdzgMi/niw11rJPfWMZ9WabaYB2Q33uzRAkZBtzXS5cKaFgavx9DqM+d9Lp9f
         d9UN27goSJeSFV7Akyp8OC+S6g2Vzsap1acSd+oTxDUg8Rj/2ixAtAFRjgxpIuwQLyL+
         uY3mPYjeYZLvcnGnVtyYT4n8ZA0FGbFniCeizu95eZCWCoqnvSOb4fxroDvUZQ9emwT4
         QrW0N1LN3dJJLkKo/kVSEHWLKRmBq3VnHnrvUyUWKIARt1Qy+q/94hCtcKzAP2eKuVsI
         H+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWw/71s5KOy05ahjk9G1GrmnGOzp5ctCvRPRN5716z8U+t/n5IxIxahxMkyGN9hwYVfbmqrtNXRFRQF0pIdrgMnn+EC
X-Gm-Message-State: AOJu0YzMWbLtsVgminow1sLru1TZV+p4lxrNCnZhqDRhn/WAGXuRWvES
	8p0JvtAI7BlSCgN7J+jh4Wa6UXjWkXCMirj8GXmvNGcUOFaxgy4e3wAQbk+QrupBh87eqXJd4Za
	5OF3HfvGXM4ohdZp2TqVAuTD0pXo=
X-Google-Smtp-Source: AGHT+IGVakcQ9X4CzDlhJTPpbriRZ18z3pemaYBhJw+l9+glf/cedk0arBni4eNqxcT8ouqs5EenObKz/8TnbgKGUR0=
X-Received: by 2002:a17:906:a890:b0:a47:134d:2fc8 with SMTP id
 ha16-20020a170906a89000b00a47134d2fc8mr3749718ejb.10.1711543563243; Wed, 27
 Mar 2024 05:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net> <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net> <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
 <20240315081041.GA1753560@coredump.intra.peff.net> <xmqq8r247igg.fsf@gitster.g>
 <20240327074655.GA831122@coredump.intra.peff.net> <20240327081922.GA830163@coredump.intra.peff.net>
In-Reply-To: <20240327081922.GA830163@coredump.intra.peff.net>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 27 Mar 2024 05:45:51 -0700
Message-ID: <CAPx1Gvcms2Ssik5RNPp90kq1L1QmTcDxO4-j-L98hrhquDP6zA@mail.gmail.com>
Subject: Re: [PATCH 17/16] config: add core.commentString
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Dragan Simic <dsimic@manjaro.org>, Manlio Perillo <manlio.perillo@gmail.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Assuming the implementation continues as suggested, I'll mention
here that I really like this note:

On Wed, Mar 27, 2024 at 1:19=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> +Note that these two variables are aliases of each other, and in modern
> +versions of Git you are free to use a string (e.g., `//` or `=E2=81=91=
=E2=81=95=E2=81=91`) with
> +`commentChar`. Versions of Git prior to v2.45.0 will ignore
> +`commentString` but will reject a value of `commentChar` that consists
> +of more than a single ASCII byte. If you plan to use your config with
> +older and newer versions of Git, you may want to specify both:

One of the big things I think is missing from existing Git documentation
(and would, alas, be a huge effort to provide) is backwards-compatibility
notes. People are often stuck with old versions of software, at least
during initial bringup, for a variety of reasons, and such notes can
be quite helpful.

Examples of modern systems that have extensive notes include
Python, where the documentation often says "new in 3.7" or
whatever, and Go, where the automatically-built documentation
notes which version of Go introduced some new function.

I'm not exactly volunteering here for the heavy lifting though. :-)

Chris
