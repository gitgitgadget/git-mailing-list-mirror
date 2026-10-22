Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668299;
	b=HEyyo785qCur2AFhQfCeeQ2OL11iaxXx08Jq4a5V5FMPEcF6eWaAxDkUgvMudQmS0uA0
	 6iRuytk1l8YC9T5/526wV3dck4uKopRZTL7Itk6OHVe2/urf1Z9hRu00rQIT2YOOfzPkZ
	 ZJAWBJHssZ2XM4QhmOswaWInuk/yH0r/QIKwunkVdV7RkBYea7JbVmdRpDa+aSsuQ+ZDz
	 +FL3alfKmOhgWKy1tOoJkFg7uYJfHWhVwoftwZy118k0/Mw4l8QyBquttRvbXgauj4Sdf
	 xhYS+Och1CPJwKv02dGasK8wa0jE8FD1WxJSsl+EjuKgevljcNRB3E6xmZGsPzgBlyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668299;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hWV4iyjFM9RSJ4z8nN3cg9eeNVn6GRqIhbX9rVEAbQ8=;
	b=brB9RyKLT+suU0fJb1fYYp5AcJe5WupvnhZjwSBGyViCvheBIIosQBB19KNNM8FDRkg+
	 Jm3wA3CRoQCiAE+q+IznMutjA7RJgTiSLU+KsuqkDB6aawNWWn+a+HTv+yMujBwKObGmt
	 SlVAM2/bgJCWurWMwZV5kKlCa0f6few7vGuNy34f+++/Lv+QE2uX5cq09vh56dwdgvPYo
	 SL98VpTP+lO4C6UA6JrIkC/GAM06LS10Ih5R32ITgtKNBYCcOmc/IApoMnC4hAM1bZbP4
	 nqHVEUwtUN4B7CzMW8i/y0gR32VwBYbYZVQ1SHy0w+TGL0zCwhor1ZY277DRqWePg/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=WAY5S9mw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="E/7znd/g";
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED0606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50ED0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=WAY5S9mw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E/7znd/g
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F0847A0032
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:24:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Oct 2026 07:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792668297; x=1792754697; bh=hWV4iyjFM9
	RSJ4z8nN3cg9eeNVn6GRqIhbX9rVEAbQ8=; b=WAY5S9mwk6GnPJqrWN3h/bhBnJ
	gWLhLxu3xjVNeWIW7EXB0YuY5im2IEd4GDxO7BtBJCGzuPk+iM/LSdc7zi4d8NPQ
	RI6irRdYi39WQA3rfovX3+I/oO/ooxyBOdapKKOo3x9m0H8Rdko+PShycIBLLICe
	Xw1zlJdL3x2MsQkGcjrYig5+nsWA8EsmYssBWbjrf7pzYPprXjXilqDau88hqp9C
	M+nQygp0zY/mcxXYWrNG0FTM76xX2XheVkE0EETpwbAfdMQZ9gh+QJLT/pjiw3sn
	znx1pgLxCy77H4eKAftiU5gosamCX4pa6DehewfsqEuLhORiXhwfjx8eMKvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792668297; x=1792754697; bh=hWV4iyjFM9RSJ4z8nN3cg9eeNVn6GRqIhbX
	9rVEAbQ8=; b=E/7znd/gMKk/K5V/WXj2Bdt9JoIUIVAhlPSpNKNibB4834/iRCF
	A/eV2m51Ni1oCyGNnw56P9jf5HVku5qNgV/bHBikgAoFrLUbwhw0wcJi+sePxahp
	0NYRGB+NJERO2f28y4FIeDvw2jhhNDTjdfg8oHBLMM717DU5RS4Oxda1qyMUwhuO
	kSEmllMDCY1jrwnzofwy5o1wzOfcp40UOv0/hUGc0MhhTSvJN7YZqRC7OWj6bQ/q
	zVOORIT4/PqVOowdACj7PIxcMKbyJ86QtLmPENlIAEWbeRD5WcWUYOWCKF1cARYU
	1FZbbm43Pv10/3lsAHMmNPjBb9gHJRXVNww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792668297; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PV5NkJgwsBM7wR45C0XqxoELF/+ak8wqobUM7lGHz5FHDw/
	0FGQIJqahCxMzZ+8MqiZ0mO7kXytfh/Y6poVqzi7k7N1WNO96H+EnRE6wakdncxG
	ywuXylm9OQr9Rb7SMk2u1aka3V6yQlh8I8pi+8G2b6UquDy247rTejkdqECXRnuN
	GS3ikErBmDC96zHVZZiOBYa8oJUSNiUJzzNAdFX0+RdR5WGN3Oi3KVouwWIoiPM5
	Q0JArqCz1zOw63HVc12lBx/O5aH4+TgZdT+e7T/Uh0ynliACU91P/rEHSDhtEIYv
	rUyLNtIAYuTnQHmrnxoJ9Utn/If9FVkJ8B81/uA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:s9nW++1sLlVnuqH8XrIcn8PE1U/nrknrp4xMQvyUje0=:j0ZpHMWVCbqkWk2RR3cJLDUuhKqeKc5qwbjMAvlwtNg=;
X-ME-Sender: <xms:ifLZamL-rrjlYDkU5YOlbF-g8mUM9tgZf7RkjiG56PYBpBc_4gf4hQ>
    <xme:ifLZakL7-TFo2XcBn5S9A_prmW6rbKIxigX4POZmNzyGBwWUZlnudzSliJbLbZlWt
    X4eLak7yRDCzTnh3m9qTChOqa8Ot0NcUU8aR81N0e0iX7pU3UV8Yco>
X-ME-Received: <xmr:ifLZakU9TvD5R8LWClF2ZM8ZjXdB21eZ607ef3dZdNXQTjIp2Tjd6jU680ZPDkpALptPfg>
X-ME-Proxy-Cause: dmFkZTGKM6k5EsybbKG6wa4GzWSo9Sag00+tr9aqtjAx3Z0q5EoYnoeTKMhpJb8Br8olPm
    GP+245/MO8YP/vTNWCFQ5Q1eo7i3YdVK/s5F4lf5xfSzwjB5i4SgaErLLCJPHDRUYG9jMG
    44v/y6Q4whFnJMCWAszY7toXRlQtuqUSzazHMCCu1uqU/k5yzVbvtgoJZ+Sik+DbYQJDH7
    Lr143ehqdCqntVdrMU66BtFAtgyVXAVq2bBV40wdepXlYTyUA62s4InjzRwLzajvAlhCyQ
    EkQLUi3HeT5/pa5+2HvYsadZgMwpFp17k4wYGA2qjKAGLBtpgFI+NqOjMDurc620dYUFom
    3/3wAJ52puDzgJb8trPAwztNuW4zLoCYVIoJYpEqnqX+68fVkBIp4T8mfHDOoGMQ2aeYfP
    KuOvYyzgLLQewVzOewUhPi9BgNUwn3vPYvT4lRmeaN4T4oum9n2fNdb84bXGJN4KhVi822
    b90aWdaXVwEwKAXQB/WkckoS4NdSxZ2f1VpYSNtGqTQr9I6Q5WR3HwBYw4wNm6+h3DJvwt
    v+aqa7+pdrhlc4/0FvN3DFsYnf05jjq02/NZwIDqf2O9o/ttEmknySFsUz3MnAZDrrs8SP
    M474FnQE1fvaebQUp//cPSzIVIg9NN2UrUknWyWRzmfxG4VrMBnA5nORKUCg
X-ME-Proxy: <xmx:ifLZamhd0hVOP8RgGg1lReOW4HXVAY-FaabJJIFEjbkwzpuF1il9Uw>
    <xmx:ifLZav-yI4B1y4FfUthXPrQEBrgBMKOORSNYsuIWG3USzGaeMIS8GQ>
    <xmx:ifLZagA8sGQLGMKG4JcVoJK6ZuqwQ9ZldduQz26eZ9m8GLu16ySHWQ>
    <xmx:ifLZasI-hmCVE4Zcfe3WnBVNZ0rkdz1rQMX4_MNt9uKH3lu55n81hg>
    <xmx:ifLZauu_Y3Tv5js3eiHXJ2TIBWWcAcjFN_dbAbrap6FluBM6gwmIGjhn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 07:24:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 617e08eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 11:24:53 +0000 (UTC)
Date: Thu, 22 Oct 2026 13:24:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MyFirstContribution: clarify that "reviewing" is
 a discussion
Message-ID: <atnyeZ23tdPC-GRB@pks.im>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261020232242.2217109-1-gitster@pobox.com>
 <20261020232242.2217109-3-gitster@pobox.com>
 <ath8r6RX0u2Uq4x_@pks.im>
 <xmqqecdjqb10.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecdjqb10.fsf@gitster.g>

On Wed, Oct 21, 2026 at 09:22:03AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >>  [[reviewing]]
> >>  === Responding to Reviews
> >>  
> >> -After a few days, you will hopefully receive a reply to your patchset with some
> >> -comments. Woohoo! Now you can get back to work.
> >> -
> >> -It's good manners to reply to each comment in the mailing list discussion
> >> -instead of letting the next version of your patch be your only response. Tell
> >> -the reviewer whether you plan to make the suggested change, keep the original,
> >> -or pursue a different approach.
> >
> > This is a sentence we lose in the rewrite, but I'd say that it may be
> > useful information to retain.
> 
> Hmph, "communicate your plan" certainly is half lost.  An early
> section ("now-what") advises to communicate "I'll do it differently,
> disregard this iteration" to avoid wasting reviewers' time, and the
> rewritten "reviewing" section somewhat hints to communicate other
> kind of plans with "your reasoning" in
> 
>     Do not start coding, much less send the next version of your patch,
>     until you have finished discussing the current round of reviews with
>     your reviewers.  This saves time for both you and your reviewers.
>     They can respond to your reasoning before you spend time preparing a
>     version they might reject, and they will not have to inspect your
>     'v2' to check if you addressed their concerns.
> 
> but it would be better to be more explicit how "your reasoning"
> should be presented, I guess.  How about inserting "so that both
> sides know what to expect in the next round" to clarify what "finish
> discussing" entails?
> 
>     Do not start coding, let alone send the next version of your
>     patch, until you have finished discussing the current one so
>     both sides know what to expect.  This saves time for everyone.
>     Reviewers can respond to your explanation before you spend time
>     preparing a patch they might reject, and they will not have to
>     inspect 'v2' only to find their concerns unaddressed.

Yeah, I think that's good enough. Thanks!

Patrick
