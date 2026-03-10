Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2101279DCA
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177028; cv=pass; b=Mur0YAaxuVssDhPM8uEDFEyd3fRFdg4Gd96S6LtsfQJdjxF0lsUDSQ9MnnSYEl+IhV/7AQfltGilRNOqZfuAw3BFq/K0LNZYkKlAe8Hiu66mWqtR6sGQ2iWbhP+mW3pe2YzS2ebmXkdqVWOjAqxZ8uwXjPaFxfgpXLVAN7QW/6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177028; c=relaxed/simple;
	bh=/D8LXRmXW9C7mig88RMPATqhtldMmO1sa3TMrRvQqds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scnT3OdWIagTTI7ZCexdiWbXH2CAdJ+22HNQreBYoaGQkc+uXHDxbZmrnKCb/WUIqjnocv6J8cviDHPvErqUoYw29kAYZygzIE5D7G6340D2lfmKQPdNm5RGeYRvsJEaMdjJBp09A5MsMLVA7F3sg8+KDgkWqTEQqzqew/ik8uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=hiF1ynXC; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="hiF1ynXC"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9382e59c0eso1181574766b.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773177025; cv=none;
        d=google.com; s=arc-20240605;
        b=AWIb/Q7niiI+Dd4bwU0fNH3yR+SFQmFCb6DNCJduBfIvUOwgb9c2rnjpaKGKCmhRdw
         VoDiW3XoO1UYSK7V3PO60We58j/Dl50TS/nB9JINRaNyHMe7uM3mdQesE8S9SKb1jc1u
         tprivjxWap134NkMyxTRN+J+SGmQqmV3Yxex5ZFAEhpWuE6QWDXaGBFSxVjfE3ZaFXDt
         0LXsGGM+cMbgHVsmm5Pwni4TB8I6MVBw14+oeaXq4XpcdkOIDnNNT/VF3e8qeg9eDLHd
         nQToXOHZAwahTp829E34Il03Y5ujq3ih3zeeixdDHnQOQvSSZeEMQjVuWQTUeCWR6UAr
         Uc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oi/L8eWgfYVsU5dtnZ+R6UCvPXaUF6X8iSq+togJWm8=;
        fh=w/yrzUbetl6J0dfbam5kAn5kC/AsNvbVmDc2uExMv3k=;
        b=RXcFTeFMyBMQg8rttsiTCTlcMHJ3QeKCZE2Cq6/H6ltQjVTl5lVYn62BDCcoagM8hG
         hxr2x05ue4u5LuC4y4ZRQpSlqkbts/2lB1s8YIlslrnqeb4mchwV7yxrNYsxgci53OQi
         CFxQYkxnamoFUme0jJes56qz/xALQIPhvz0dgL8zO6nlTa5Fk8Gv0OnxE8R3fAx3heo8
         rvBUJpaHtuSuEDD6xDBfzo59Skg9hnkEyah8Uu/q64dkqDaa+Kcoj5+SjWI/2KE0XssI
         g4i6j2Py3ozq5qLmoD6dCAz2c33W1DC70e4u4R8fTr3XUWV8s2MPr8vVI8VGGBfch/rH
         II/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1773177025; x=1773781825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi/L8eWgfYVsU5dtnZ+R6UCvPXaUF6X8iSq+togJWm8=;
        b=hiF1ynXCMHyk+J6tdMJ8GO8TqP1HqVpGdWsaK/YgEhOcAH4zlyALhfr0kPMIAnB4vQ
         vvdXDNCgqG6qjaQrCn6aaHROdEb6pXw5FNCM26QZaXUTayFVfToPJtf+U1zBphn9f6nS
         xwc2MM+vK6lSOYE2vWdcoaiUUMdY5jPYS4iP2AqfQLQzmZOUgpmFVb08ujwruMmq58r6
         oIZgtMbrvLprScgWghqw8o80kUIJELz3K36mcKrEFsQcMmqe3e3s629vg0kH1dg8nIir
         hB+D1/yc5dvgVf6ODwfAVnkxtCdym/3GJ7Dy5pIgsflSoihiNTxGTUVyN5vViXtMsUVn
         VjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177025; x=1773781825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oi/L8eWgfYVsU5dtnZ+R6UCvPXaUF6X8iSq+togJWm8=;
        b=JR8LB76jYFJDk5nx8WFlbFHIA+gxRyJevfnSkV4a9Hb5RMZlDdmhccEG5TsCnF++48
         9Nnxgg4buAV+qI5UA4s5SraFtv8OCcIaTvQPGptB3Rq8QbIatc7HXVJNpL9zVdKH7yya
         4tL+S1/+fPjVYVk6lHby6ADBLUFfgCdkTlDJVks8hqeqzzQjR1LhJ2arjXpF9JkCIxFK
         01Yi4TvEss1VCrciAP0L4uY8/qO661aHJNEOLSKuYZSrnQFxXd+4IQ9l6uhIE2FFlEbs
         Z2y3cO2lspJbSuQtK1AHY1DG0/TOr3Ugzofayqs5RYUly6CcWjU/Uzp6B/nlgwxVyW2w
         C8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh8QOusGhh8aqUclElSLAp6YdapTYr7dmeKdBNaEMrcVx+QVmQosRJtsv7uAOPG/1HWHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxKaGBuWCOy38NNzh6AmsreLOC+jyW5wiPD6JM36UqZ0/7iwW
	v2Hnkj36Gy4a90HKYYoG/pHrpgp6NN+bR/TzyTEj/KxRSaOJlpUQvLjkzuaWZKNIhyPoZDkp6xw
	U5hlIDLDLFrFZG9sK8gW2PVxYSNqknYqOtwGLQbfe
X-Gm-Gg: ATEYQzzWw4bPSbQh4vNw1jMnnIhd5WgkNwgsmWpPr7mCeaGTanxeJfocgqTlkezCe1U
	hGE9HCopbFPq4asTJcP7gqq9M0oimxBbigARRrkKthVhYHY1m0jJ7TJDZHrGKTXFNe+ZxuzaQgf
	0Uy0Ws548hzM2XJB1NAW67OC+PQLsi8kgnqy2+zWnSCGOqnHf+U2dJYQccgup0dMiBXquA2Xikj
	iBAYPOUmXWnGabTq/OkvzjFpTt4HQ+AdSayy7d4ryU2wkv5EftouolGubzSvOnKRQNYf9lXFTBP
	dMRxSIW+LXMHxg1pqUPBjSqLP+1D7sUT2F2blu+DRP1joZ8jPwn/D5AC3Vwhl6g3UxgquuHJdqS
	v/xC+fMfKdDuszj2f7w==
X-Received: by 2002:a17:907:1c06:b0:b96:f0c9:821 with SMTP id
 a640c23a62f3a-b972e1dd2aemr2571666b.25.1773177025093; Tue, 10 Mar 2026
 14:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
 <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com> <8bfaa14d44e224c5f8a3cfe1a0c55e9ca9415a98.1770384180.git.gitgitgadget@gmail.com>
 <faf8622b-b960-4f58-add7-28b5e081afb3@app.fastmail.com> <CA+GP4brEROn5jhmtjW7gwk87hi8T23voyG+LEx-ypwUE0Q5F=w@mail.gmail.com>
In-Reply-To: <CA+GP4brEROn5jhmtjW7gwk87hi8T23voyG+LEx-ypwUE0Q5F=w@mail.gmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Tue, 10 Mar 2026 22:10:14 +0100
X-Gm-Features: AaiRm53qwkVWY8XKTjbzDEugeTIAW3y3YDBF2d0kuxPqCICrOC6bgvizRXH5t4g
Message-ID: <CA+GP4bqf6=Lv3esMxorhbn6J9AMT-A4cEyhgpnm8iLUd+Myz0Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] Documentation: update add --force option +
 ignore=all config
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Brandon Williams <bwilliams.eng@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

I am unsure about submitting these fixes now, as the patch appears to
have already been merged.

I could add it as a 6th patch, and merging would still work fine
instead of amending the 5th patch - please let me know what is the
best way to proceed

Best regards,
Claus Schneider

On Tue, Mar 10, 2026 at 10:04=E2=80=AFPM Claus Schneider
<claus.schneider@eficode.com> wrote:
>
> Hi ..
>
> Thanks .. I will fix both.
>
> Br
> Claus Schneider
>
> On Wed, Mar 4, 2026 at 3:02=E2=80=AFPM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> >
> > On Fri, Feb 6, 2026, at 14:23, Claus Schneider(Eficode) via GitGitGadge=
t wrote:
> > > From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
> > >
> > > - git-add.adoc: Update the --force documentation for submodule behavi=
our
> > >   to be added even the given configuration ignore=3Dall.
> > > - gitmodules.adoc and config/submodule.adoc: The submodule config
> > >   ignore=3Dall now need --force in order to update the index.
> > >
> > > Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> > >[snip]
> > >       all;; The submodule will never be considered modified (but will
> > >           nonetheless show up in the output of status and commit when=
 it has
> > > -         been staged).
> > > +         been staged). Add `(new commits)` can be overruled using th=
e
> > > +         `git add --force <submodule.path>`.
> > > +             The setting affects `status`, `update-index`, `diff` an=
d `log`(due
> >
> > This is in `next` but: should be a space: =E2=80=9C`log` (due=E2=80=9D.
> >
> > > +             to underlaying `diff`).
> >
> > s/underlaying/underlying/ ?
> >
> > >
> > >       dirty;; All changes to the submodule's work tree will be ignore=
d, only
> > >           committed differences between the `HEAD` of the submodule a=
nd its
> > > --
> > > gitgitgadget
