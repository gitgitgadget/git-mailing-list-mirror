Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A47261562
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295383; cv=none; b=fZExv6qdNd12EYI8eaS/tb50wS+Cxo88JVTXxyRnKruYyP9Mo5ibTNIDbMbW/Aj7KWn0kZ+d0FO2plJAaEEWCrMZJCs8tL0qWzAML36kq1JAISS0YDMAVuQlwi7vezg/1dsXZ6WJvZdJ7ZcQDAnq8Dy1bjYU2PaiFX9rYk7Taiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295383; c=relaxed/simple;
	bh=RRYzSpH9zAjqD64dy4ZKJPFrBXvwfFCd+DV8NkR0QBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JE0ahz1dUhcZ9Xr30nziuQoRGUuyZeR8aGzM8N9oIO6WgxZn/0LWeJ/WPHiQU/VI/ve75RfosszOmBhivEwd1FxCb2u3fLat56cfvk7pRbwXfzRreQCG8AjR93xq9OKkUyQHOccYclK9jKeTwtxFCBOZuKlsXY6Onlosl4wxGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=KG62ltcc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="KG62ltcc"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5450d56199cso2211525e87.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 09:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739295379; x=1739900179; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9g9kOZsW+Tf8RDpnGKwFjICx7yconMX4JvmCR6RfeZ8=;
        b=KG62ltccy2BEgCMwSmJCC2Qdxej72j2b/FGkA/LzdjkHuxtijYpCZi0r6FO0mkS2+O
         mL7mV6zaNyk59vxmS7355MFfMpyOE8QXV19hnKj4yh1I84RXnVwVr80Ft1gb4jEwRBWV
         egAHb02mJuG5lIQqKrXtgNk7yiIUJok/FAMBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295379; x=1739900179;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g9kOZsW+Tf8RDpnGKwFjICx7yconMX4JvmCR6RfeZ8=;
        b=h7/27QV0rF63oWXjbAaEmKkgKLFXzp4flgMPunG+zu/i5NBelK4puWnutAosUL/zp+
         gOS4ISaZ7h2dELeYV/qZanKpdSm8/NUUXyPDZ8eohLmfSmVKzfRd2+coeB66sj11fMeB
         bxTQYA4u1w+G+a6TBxyC65hCb5GVB0ENDG8tAK3XnCNo53D2Uu435MB5bbl+K1L6/mOy
         mTk1XJg5yg0k52Irjne9FgiezcHQBDRSoikAwIlXcDzFVprYq2baEcuF+m3tC1x6spJc
         poqNbvPWJAKsYRgQEAO5tgqtRCUc4CQpP/xIr8oqGeINGhu0u9a2FSsh/inQyCa9HRVT
         hnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqLQe5RyCDnDdClKIB2H9IAFe3Hx/xEP2PSofxwZKd3oKZAkrUHvANOdrYK/ltvRRVi5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwam+1xddd08hHNhi9eWA4LDsN8ofgzwzdHKSfCXKMUVzn9A3
	b0MvZYpw9qQ5jPb1FHc/dN6j+2RRiBw5JFjsmSgWJGFksJrgMYC4cxeCCN2WYh6DJx5Hu/m9l9b
	2Asg=
X-Gm-Gg: ASbGnctbdHp0bvrJ6oesYedfAu8+h9qjhv554RA9+p0absfdAATzh1ndosZk48pYGRS
	9rdc8p61FH5ApO++9J74jHP5h4Z0IINV4E4EeiZw4DqJ4fR76rUKTbqCaIZ3k1OHHXOqlQQYKl8
	KHpPYx/MxTQW6TJ/Fi475VN99h51UDsiqKQwXsKgaFbM9Gh5wiVYg5A3O/9U94nVx00VYKQ6DDa
	DJ2MWMeLch+z031DYNAmP70WhpuftHjByWWcZL8VAgCOGzdOj4GwWNsZbVpwFtNs6FelfKcPxos
	aUrFpmq/Pz8rDVpN2wEbhc0QBb/otht35Ac5JKZ3pOOFh+8sNg==
X-Google-Smtp-Source: AGHT+IHwN4710Afxcld/I9nh0Qeio4U2neTRrYgOTR8SWk7SFLDNuZTm1ECI6oLQ92EEmV7+oxjmnQ==
X-Received: by 2002:a05:6512:2347:b0:545:17b:5755 with SMTP id 2adb3069b0e04-54511c8149fmr1347136e87.23.1739295378712;
        Tue, 11 Feb 2025 09:36:18 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545004c07e4sm1190222e87.132.2025.02.11.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 09:36:17 -0800 (PST)
Message-ID: <a761826ddafbadac6d2932f145316493298da33c.camel@intelfx.name>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org, Elijah
 Newren	 <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, Alex Henrie	
 <alexhenrie24@gmail.com>
Date: Tue, 11 Feb 2025 21:36:13 +0400
In-Reply-To: <xmqqfrkk1l4i.fsf@gitster.g>
References: <20250210191650.316329-1-intelfx@intelfx.name>
		<CALnO6CAM7WCOJV8s8ZARi3BAFwkh0TNTCod_YH9s+EpO7t-Qtg@mail.gmail.com>
		<bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name>
	 <xmqqfrkk1l4i.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2025-02-11 at 08:50 -0800, Junio C Hamano wrote:
> Ivan Shapovalov <intelfx@intelfx.name> writes:
>=20
> > > >  --update-refs::
> > > >  --no-update-refs::
> > > > +--update-refs=3Dinteractive::
> > >=20
> > > Based on `git grep -e '--.*\[=3D' Documentation/git-*.txt`, I think t=
his
> > > should be more like
> > >=20
> > >     --update-refs[=3Dinteractive]::
> > >     --no-update-refs::
> > >=20
> > > But maybe that unintentionally suggests that `=3Dinteractive` is the =
default?
> >=20
> > Perhaps --update-refs[=3D(yes|no|interactive)] then? Or is that too
> > verbose?
>=20
> If `--update-refs` does take values that the git_parse_maybe_bool()
> helper parses as a Boolean value, I do not think the above is
> verbose at all.  Rather, it is a disservice to the users if the
> documentation does not mention yes/no in such a case.  I'd say
> listing other Boolean synonyms like yes/true/on/no/false/off is
> too verbose, though ;-).
>=20
> > Anyway, I don't have a preference, I'll just do what I'm told
>=20
> That is not quite in line with how we'd like to operate.
>=20
> It is your itch.  Others may give suggestions to help you polish it,
> but ultimately, we would not want to accept a patch that the author
> does not agree with.

Of course, I care about the patch and the feature; what I wanted to say
is that I do not care (comparatively) about the formatting of the help
text: I couldn't figure it out on my own, so whatever you tell me is
the proper way of formatting it, I'll do.

--=20
Ivan Shapovalov / intelfx /
