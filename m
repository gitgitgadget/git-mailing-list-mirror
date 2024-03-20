Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F55CA1
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904065; cv=none; b=eLv7o+MHTD2btvaZUKhugh+jeHUidamkdljwinb6XvaQlsf9LR51zeN9Sks5E9Vf+kD8kIBZnwWCRmydlyzK22JAgwXQBeTJ4Wmbukhe4a3sWp1ho3RX4MVT/R2WAmIfRUXqy8PBlFC6RnIU6CSCGbbWMGr3wHrvx4KG4Iz0UDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904065; c=relaxed/simple;
	bh=fXvhk5EiJqgL4/GPbg/aCK4suZ6ypDeWK8hvAMB7gbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmooQeg2FNHguM0P/n++c4pO9nrXGvNQo1J+n6qiJT10Ti4XPq5FNny0cizyCbEXw7uST3UgBRu2/6vpvbEJpGeqX9ExfMmiqLw0I7nx66FUzyLiWvZbDOUTnc673C9PzbUzvU4IwNIAg2UjB6p/ObcijBSuy0suoHYPK6AKP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789e6ceaff1so50260385a.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710904062; x=1711508862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXvhk5EiJqgL4/GPbg/aCK4suZ6ypDeWK8hvAMB7gbQ=;
        b=U8INp3d90A/Hr5BBMsOtYcYHPyF6E5rFydkLwtP8Ubw+Iq2tRgpWP8gdy8mOC6QY1r
         tidYj1DjoaqziUobNpc5YocqW4qUP6KlJXA6QVYGcF5Acfv8kD1hUF8SHcaB8NkDPqR+
         8f20p8RNDqTkSl8BIhpFiepyuQDCDgVkXjn+VSjV7Lwhp45XTg6+mN5NICZe45UN5UIB
         IAd5V8VhUWw9K3MdOh1G8fCEuoKgxt4sucnvE67QFDbsyrJD75NBRjD+DcpBocj8czFa
         O7mMy8Tih3zAT/c2gHpOIWsW761wNsDnefSs5xKoXl3B8PElW1CA4WaxN5hWYdl/Vcbp
         M/1g==
X-Forwarded-Encrypted: i=1; AJvYcCU6U1quATofjLOVVWgMwiIhP/r187yPwwrUeqwlUmXvxdmufE0iBnlAit8+1m7433J38UrbYS2DMFN4vtJMGm+hHst/
X-Gm-Message-State: AOJu0YycTM+zquh/HqhBXcGus0qIef0W/ewVXgZlBlLwr+uJP3HLNEmo
	JIKn632ygJxlwLQms4/Lkby/ELEgn69wx0iZqa1msstidmbA0CphS39Em6DFeIYvWFMiXjh+Qpn
	GFNNGj2yIbZBTZbGiIiDy+cfkWD4=
X-Google-Smtp-Source: AGHT+IEgW0BQwllq7Gd7RlCGwvv2YpBJTlcrgyupOK93uTXp/DHI5GgNKXtEjw3GgMin0p79LPKtmtaSuvJr9YASfPM=
X-Received: by 2002:a05:6214:400a:b0:691:3d91:80bb with SMTP id
 kd10-20020a056214400a00b006913d9180bbmr5600954qvb.11.1710904062362; Tue, 19
 Mar 2024 20:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309181828.45496-1-ignacio@iencinas.com> <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
 <xmqqa5mulycz.fsf@gitster.g> <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
 <20240320001934.GA903718@coredump.intra.peff.net> <CAPig+cT9QxRZhZyZV=Txt1VfqzDZX=gDbXvFg1nO=rjeMFaBeQ@mail.gmail.com>
In-Reply-To: <CAPig+cT9QxRZhZyZV=Txt1VfqzDZX=gDbXvFg1nO=rjeMFaBeQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Mar 2024 23:07:31 -0400
Message-ID: <CAPig+cS_hCOnAuwRd_dY5h37-wgHCk2tjS7asm2Dm_p=s41X3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:49=E2=80=AFPM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> On Tue, Mar 19, 2024 at 8:19=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> > Some care may need to be taken for error handling, though. For "git var
> > GIT_HOSTNAME" it is OK to exit non-zero, but "git var -l" should not
> > bail on a system where gethostname() doesn't work (it is still not clea=
r
> > to me if that is a real case to worry about or not).
>
> Ports to oddball platforms should probably be providing a
> gethostname() in "compat/" anyhow, just as is done for Windows in
> "compat/mingw.c".

Ignore my mumbo jumbo response. You are, of course, correct that the
implementation of `git var -l` needs to be done with care so that it
doesn't bail if gethostname() fails; that's true regardless of whether
or not a platform-specific "compat/" implementation is part of the
mix.
