Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171013019D6
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467978; cv=pass; b=i/cLZQVGXIV25s/HrAnOuPHcwQworcwCP4UsUNXzSCGKO4JEMoz78JZDHuiBw2nyQMF0TvbEv19xzWwk/T0Yq/jcugyuUQRdpLSrJwWzfkgwMm1jkB/m0+cEDuTa7OLXkGsWH7V4mTToGTo2XqO3xQnhkvxBE49xS51zJ2u4rQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467978; c=relaxed/simple;
	bh=4UOwDNt9IM5IqBeVmJ7V7Cllq3+FH6Ui+Uhc0v/9j9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vsmd5/Yk28BuCyQicQqNdcJYX2vij08gRqEhaQr8w+0l4Dz53uwLqAm41DP5whWVxb6TNE/+Zep9MJ6CrSVzUhyfkRM+1+yiHa2ErFlXgEJMZj2F2nklk+YvgiJVEKnLaBSQSMoD3tOK96PeYDtluCE2viWx3elAkbY62nBqXV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opencanopy.dev; spf=none smtp.mailfrom=opencanopy.dev; dkim=pass (2048-bit key) header.d=opencanopy.dev header.i=@opencanopy.dev header.b=VlouN1af; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opencanopy.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opencanopy.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opencanopy.dev header.i=@opencanopy.dev header.b="VlouN1af"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso20205385e9.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 06:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791467975; cv=none;
        d=google.com; s=arc-20260327;
        b=qJaaVL1A3TLfHXLPYOpdYyvCDdFhvwvzv7d2OH+2ZvRIre+hJuo0yAMNk7p+MiFsYL
         BMqJPMQZe65I1q3IFYEP2OkL0OrSBdUV5uxYMi4tyfZN2ORd/O+LjW80B0L+QXzya7kW
         qXqNZ9tuxWkVCRmLnzOM/1g7o9TQoirJ1z637VFIHbSc5hGfSBgfgxcYCFPcUDvc0kwi
         1tERJyBNzDdG9b9n/w0/468VrGgxBtvi44nYw1/w/U7BL3KvOjGiOHezEf8OLe30Gv4I
         ad4vY7K0L3KeiK1R6QtW5b2lXeGAF1r2rQ3HzVDGDKNHYs0JV2u36zryMoLiDW+49TlE
         h18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4UOwDNt9IM5IqBeVmJ7V7Cllq3+FH6Ui+Uhc0v/9j9A=;
        fh=+6v/RTDEntvgLEIG7sPuYM+20sl+JBjtSX3HkQTTByg=;
        b=rwvORRC0Dv5B2OKt1n94kyq2N8YwdJX5ppn8QlwKs8ym5VE78MkWcBtCVMGCT4SBFk
         qWKSxkSVgICSCVPCqpq2k9EB8f+sAsa30Qrrek+MW6/g1XU1x4oUSD6zlWax9QGZlfGf
         guOPbYL3RFajLs8PzBJhHSD/JAJ2Og7BBN6FAJGzKW0cP31PEWA2KG4T3sZaYziuPyK8
         k4W5Eh+GfacbLXnjhlWs87ED+OqB+QwL9mgj3Zgu/8C17KXtoej/pmm7Mnivwr3wbHFd
         DCoHG9mSE9oy8I4taNgU32R+BlKqCO12gRNkXrayh6HE6rCEdIkhd8soQTNEh0C++ipW
         7qag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opencanopy.dev; s=google; t=1791467975; x=1792072775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4UOwDNt9IM5IqBeVmJ7V7Cllq3+FH6Ui+Uhc0v/9j9A=;
        b=VlouN1afwk3J0geiKuhs9HRjS6YTj/TPSEEtkl9ijsU4Pe32D4yT7mVwZkxqN7hFjV
         z2FT2GJfiZQipeA5XcjwD5A70uh4zUKjxPQmNHy8VSY8NfRRutSUmGGyjwLIyCkSkvRi
         WJKL+wz7RfidJltYEFJFy4d6X+6yCxi93Ioe4k8O/GSyINnCZ5kjzs/igWDhcBA3H0WX
         XHzwutjKau4HeKzmppX8OIBwbKyiGuxE9jGLshiB1HkjZAzLtE9QsnYimOM923IlOGna
         9+q39KpaUAkjTYO9+C5aisNU5CFD4I+U4xObjgy9XT28ZJaUZkg7Y0jn7Ho72vCdX7k7
         h0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467975; x=1792072775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UOwDNt9IM5IqBeVmJ7V7Cllq3+FH6Ui+Uhc0v/9j9A=;
        b=tXQyYLG8/ydHvplILHT9CF0OYXHNQYkD+LUqnuOpZzC+XrmM4KeUxj8wyLmgFPZh5P
         CenpTTusXeDnRRxaLm48WhR5LWp9wLNbWfdG9Y/pFFEfrhVll9KU+j3Iq3lbXz65scP+
         TYgalYqDpJmWudg1hJIgmFoAjs+mdOtyvqapxFq3iRsnSoBi1lHLA8eVChO67N3n6Wso
         6PkPRJbcF0huRgbv07OfTxqK1/4Nx6TBYaKTIbKPRZuD5xqwDXI5nAEqP86yreLnv7um
         mAqIhfNL3sJQ92A4HtTgz7ocl1o5kbeLfxiwum/jINxGmti1y1U0G9dF28M+P6fO9zQH
         hO/A==
X-Forwarded-Encrypted: i=1; AKwUvByVSElyLC4ljyKYy0NafdcaoQDEy0pW/q/LyzGCgpjT4IweZR6AAIS11LgiJjQ1NKH9iPM=@vger.kernel.org
X-Gm-Message-State: AFuF++kYH6T0jFQebWk5csSR8udMNLD+RaOMffJEYdjYM6ew0liODkOW
	vDZRcPYZfAee/h0C2W1NkioU1HWzIuraJzzjkpMMmXfRZralKGf/bfMI9XSa04vXY8Ha1BS1O1V
	v7XpnYAf9dU8mwBXHF3eEm5SqTQQSslzMrrX7WQwi8FM=
X-Gm-Gg: AYBFou3ms2eaT6fayXFQEIV94jM7aJGKqP/wszOb/0Mc1P8sIUcj3LlRJO4RkGVuZxP
	lX5CWyppoAKwyxJiQRw8a6CvCyEFwqomMb6i0Im1dWljwhPMtMAdpJS6o2yg/GlVxbCB4n8/Ooj
	egWE3Tn1OgA9vrJPYsCdYY7BB5Bl2TFyJHqo9WdCIQEvLmY6ZqAbSTe8GZ7s+ZYqkoTJK4LYjaY
	DAyBsL7LuFEo3MOf8SM8y6l2DtY9piHmixKTsefKRMc2+XcEt2E1qD83kV5lVLdwUn+D8/7Vuu4
	k3FujSpd7yO0Lq4kS/5NVtj04WCu7zxQQm6U9/hsd3cDCUKBdZ/L64lK3g==
X-Received: by 2002:a05:600c:8211:b0:4a1:7bae:d80a with SMTP id
 5b1f17b1804b1-4a180419367mr97857645e9.9.1791467974983; Thu, 08 Oct 2026
 06:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929112544.86511-1-scott@gitbutler.net> <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
 <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com> <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
 <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
In-Reply-To: <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
From: Sam Reis <sam@opencanopy.dev>
Date: Thu, 8 Oct 2026 15:59:23 +0200
X-Gm-Features: AclHuK_U2YxSg1rX4mANS-aCR1QoQiC6OvQIWIIDTu76uxP_E4Urt5ZYkmp1kXA
Message-ID: <CA+Te0V+PYvsv5pTdwNVmhu8acCJ_68V_9aWmCArh6qszboe2aQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>, Scott Chacon <schacon@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, Oct 8, 2026 at 3:25=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> Hi Sam,
>
> On Thu, Oct 8, 2026 at 7:23=E2=80=AFAM Sam Reis <sam@opencanopy.dev> wrot=
e:
> >
> > Hey everyone. Just for the avoidance of doubt, very happy to see
> > Scott's patch here land and for git to benefit from faster sha1dc
> > hashing. Let me know if I can do anything to support!
>
> [We bottom-post here]

No problem!

>
> > > On 07.10.26 20:13, Scott Chacon wrote:
> > > > Hey,
> > > >
> > > > On Wed, Oct 7, 2026 at 7:23=E2=80=AFPM Junio C Hamano <gitster@pobo=
x.com> wrote:
> > > >>> This series ports the approach of Sam Reis's sha1dc Rust crate [1=
],
> > > >>> which gitoxide recently switched to [2], to C.
> > > >>
> > > >> Which means license-wise the original is compatible with us, I
> > > >> presume, as they are "Apache2 or MIT, your choice".
>
> Leaving aside the question below about AI policy, I think the
> important question for Sam and Sebastien is license compatibility?

I can try answering as best as possible from my perspective. I think
it's important
to note, insofar this wasn't clear before, that the actual code for
the ubc checks is
fully autogenerated rather than written by hand.

The generator for it was written from scratch by me with LLM
assistance, and based
on the methodology described in the 2017 paper from Marc Stevens and Dan Sh=
umow.
Nonetheless I ended up crediting Stevens and Shumow in the copyright notice
to be on the safe side.

>
> The sha1collisiondetection submodule and the sha1dc code (extracted
> from that submodule's upstream, if I'm reading 28dc98e343 (sha1dc: add
> collision-detecting sha1 implementation, 2017-03-16) correctly?) are
> MIT licensed, too, so there is some precedent for Git here. I skimmed
> what I could find of the original threads:
>
> - https://lore.kernel.org/git/20170223195753.ppsat2gwd3jq22by@sigill.intr=
a.peff.net/
> - https://lore.kernel.org/git/?q=3Dsha1dc%3A+add+collision-detecting+sha1=
+implementation
>
> but I didn't see a discussion of licensing at that time. Perhaps the
> idea is that we are clear that such code carries a different license
> from Git?
>
> Anyway, I suppose the fair thing would then be for Scott's code to be
> MIT (and/or Apache2), in which case it would need similar
> clarifications? (Or are we prepared to take the stance that de nouveau
> code based on existing code can be license-washed, in this case to
> GPL-2?)
>
> Interestingly, Gentoo claims Git's license is only GPL-2, but I think
> they compile in the sha1dc code since it's the default in meson.
> Should we be claiming the Git package (with sha1dc) is actually GPL-2
> and MIT?

Again IANAL, but my understanding was always that MIT is GPL-compatible.
From https://en.wikipedia.org/wiki/License_compatibility#GPL_compatibility:

"Many of the most common free-software licenses [...] are GPL-compatible.
That is, their code can be combined with a program under the GPL without
conflict, and the new combination would have the GPL applied to the whole
(but the other license would not so apply)."

So as long as it's correctly attributed, that might not be an issue?

>
> (This is complex territory and I'm sure to have gotten it wrong;
> pointers to past discussions, esp. those by copyright and licensing
> professionals, welcome.)
>
> > > >> How can you/we be sure, with respect to the current AI policy in
> > > >> SubmittingPatches (which by the way was vetted by SFC lawyers), th=
at
> > > >> your "AI generated" code did not "borrow" from places that gets
> > > >> you/us into trouble?
> > > >
> > > > It's a good question. I actually just submitted a proposed update t=
o
> > > > that policy based on SFC's updated guidelines, but either way, I
> > > > learned about this from Sam and have talked to him about the port a=
nd
> > > > he seemed excited about it. I can triple check, but I'm fairly
> > > > confident that he's fine with this and I am fine signing off on it
> > > > under the terms of the DCO language.
> > > >
> > > > Of course, he in turn used AI tooling to produce _his_ library, but
> > > > within the guidelines of the updated SFC guidelines. Johannes's
> > > > alternative series is the original Rust code of Sam that my agent
> > > > looked at to produce this (in addition to his blog post explaining
> > > > it), so I'm not sure how that might be materially different.
>
> [snip]
>
> > > >>> [1] https://sam.dev/blog/faster-sha1-collision-detection
> > > >>> [2] https://github.com/GitoxideLabs/gitoxide/pull/3008
>
>
> --
> D. Ben Knoble
