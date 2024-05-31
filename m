Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCA1B812
	for <git@vger.kernel.org>; Fri, 31 May 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166173; cv=none; b=HltMsX+l+7NPFje7Eb61m+AJn/5WYx6KJLEUY2185+41uc0XIVAXkpBI36TIrBpqNhGKGeb6QL8V0I7uFmzNd4ys4UHKfw/bP7++1nNKEmvLGRbxWNBZf1DVmVGCOpHqjLFZ6/RCTXTWgMEaet0bizkUHY0tUDmcKJ9ZEuhkERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166173; c=relaxed/simple;
	bh=jnDwA+szjIejcSpPCEdOPwrt8TZp6NHXyUBptcNZ2X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p08hR1vXWuwF+TWDtIElY6uYJub8LLV5pN9xnyl2HXfhYdT2rA0xeZInhY1CN8Eu/LqfLQzGj1SHTkkIA/5xtuM+vwCIx27EUB7p4H8JVsz7+MsM1OyThjgXmlFQ+9GZRhOySvyZ/B0TDC+mnygu+XntnIUAdv1yQ5StOzKuvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlJQmQ4x; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlJQmQ4x"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a683868f463so100185966b.0
        for <git@vger.kernel.org>; Fri, 31 May 2024 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717166170; x=1717770970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnDwA+szjIejcSpPCEdOPwrt8TZp6NHXyUBptcNZ2X4=;
        b=AlJQmQ4xFH00vKC/crQp21mQvUK8Zuq0GAGpJlkJVQMzkHkIVYEtzyCAo1CwO0rQnb
         MKKoDQNepX84GQFlG3zg4hlIuzObcAvN+ucCLdI7NsJPL6VPpZGYrGKIOeoQWYslhv34
         r4hrpwjpsLawQ0viqVG4g++Mi2uUYlLmO4/Lt3yZKIvWtVcPY87Pw2+jm55cJ9RxbTvm
         M15q6WN///AYKWIVs4lGt0ZWlNC0ctFrSkhYcVSK2XSRRma/76hnUYnyH5b20z4njPbG
         Vrdu44+o44f+xEs9Fn2JR+M3Jpoxy0GY1iiv5C6cHHOYtSwh1RjSIRf+VcUMeB9zSZHW
         Q8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166170; x=1717770970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnDwA+szjIejcSpPCEdOPwrt8TZp6NHXyUBptcNZ2X4=;
        b=ar+vcseqVzPRL43w/Qpg88yMQW1+pAbtbYpb3t4V+sm+oqQtu6AIu2T0VDgUYlv2+C
         EAUImW5ItZ5ZK2UbqvBTCJv/FtatoapUxTr3c28kbF8urfaa29Gn/QcQ+pv/axx0NZI8
         Fm7zDbAdYe3+iTlqDcxcZDteKCeBE6a8ydw9uUkfHVOIP7Q/6gMm9VxL+T6hoD1XImqZ
         6Q/YQdknabMbeL0AbyCvMNtsdy9oL9AfzahdUryyH94uvkUWLt/2NthoyEUjn5yk7Zx5
         6PwnhCaKfKgWe2m+9ona+LlHcL9W3Sqlyh96AyybRv5HmHHfDX+MQkT8ezV5FnITCUlB
         38og==
X-Forwarded-Encrypted: i=1; AJvYcCXoUJox7bbMHzKFExLMDa0ffbltkCh6pAKy3x78jzv8NrggEpqk1OtWQEtEOE0fnk/DCW1uPx2dGU2eaDEAcIOIMLBk
X-Gm-Message-State: AOJu0YxnvmVXUxXbif9ET579FaI8mAiksJcfFWebjSzm6cOUh/3b+Mht
	LSJN+0yArPTs62wc9cTwuaWzbQTWYYhGPJXXTvbk9NZcQsfy4T8cesan0/QB0d9pP39Szkewaqv
	E1vr8AmkZCJppNOxUizgOCpwX/pA=
X-Google-Smtp-Source: AGHT+IFSq7IBfrJorefYYEU6BTVQCdux3kTqp4YEHSUrG+Z1VsVYbspL6MHkep1j/hWy1SN4J0YJXq/Q1tHzFaLFT6A=
X-Received: by 2002:a17:906:d109:b0:a63:535b:b316 with SMTP id
 a640c23a62f3a-a68208f0f9cmr166809966b.44.1717166170132; Fri, 31 May 2024
 07:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org>
 <xmqqplt4zjw7.fsf@gitster.g> <ZlmH1CFZWHokAqso@tanuki>
In-Reply-To: <ZlmH1CFZWHokAqso@tanuki>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 31 May 2024 07:35:58 -0700
Message-ID: <CAPx1GvcNF1_te7v3K0bN1s1OaR8JwHTgfQnoKV_tapz6qzbX7Q@mail.gmail.com>
Subject: Re: safe.directory wildcards
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Stefan Metzmacher <metze@samba.org>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:18=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Wed, May 29, 2024 at 09:02:16AM -0700, Junio C Hamano wrote:
> > I am reluctant to use wildmatch() but I would expect that in
> > practice "leading path matches" (in other words, "everything under
> > this directory is OK") is sufficient, perhaps?
>
> Is there any particular reason why you don't want to use wildmatch?
> I'd think it to be a natural fit here, and it would provide a superset
> of functionality provided by leading paths, only.

I have to agree with Patrick here that wildmatch would not be
surprising. If the concern is that it might be accidentally dangerous,
perhaps requiring one to set two knobs might suffice?

Of course I've also thought at many times that Mercurial's
"syntax: glob" and "syntax: whatever" rules were a good idea,
although not necessarily that particular notation. Perhaps
"safe.literal.directory" (aka safe.directory) and "safe.glob.directory"?

Chris
