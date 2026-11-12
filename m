Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794522554;
	b=yOwEM0vnInTscS8sZj454oJqm2lgPqKMjfTjJKd5GnfIpr3MLyQ3aXcZMHLt8puns9G4
	 hANHyLP9FSeWYBOIGV+VuIXbVN4BnX8VYjYbHfpL2GgXV1PjLEeXrtTbNg42E++moFQe9
	 15XBF81i3rDJbGTFL312uRq4+JVONzmpHjfOcoS1BiQM11QqS/pS87l6gQeHcTfYPbcN8
	 OxBUf54DTfzxRGSBaJKMYgjoeN7DOda2IToeRfJH61ietC28pYRBOTIl3dghgbylR8dVE
	 gaB/pJkrtO/ca1n/0oOg0HfYIejuk02DRliOQRUvQrgXV5yxWCTVawyiHILgklewjSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=YY4ufy9oLH7Q/TTBWOalVI9Si2u3R0DYJSuSSTxX94o=;
	b=a6V5z3TO5MMyUHlhP4OUIQ65l10VHbsx3UIxI0DndOpkSsShODdAilL2Ix7SXHD/Irnu
	 /f6wpKS17RBJ3y5JsNOIDdDbjOOfDerd2SmytP/+cAYiNupOGfkQ8nGCKE5/p+ZS2OfNn
	 l8XmK0vhucJXKgA44KQLOWfa2UUkQhA8yC5Zl8WedjN5ePIVCOhM3bs13G2mszfjEYCz5
	 YeQKeFXPdIy3DBI9BW+QLizrshCU4+2WeE36jfqYFl5RMEye4wyYiMDqaxKBTntOA7gFo
	 XqLub83YrZioinndDb4mvfwaEbGgQ3neDYeoLTpo03xLoE4sQVQJXtXHypy+HZjyG0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFHslk2F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E3606A333
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A3E3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFHslk2F
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-70b875f6f1fso393663eaf.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:29:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794522553; cv=none;
        d=google.com; s=arc-20260327;
        b=QcS40wDrVG+X2RDo4v1PjDi+bcFRCR55f9ylydGWeQLC/h+aec5HuRdzK6lzFjhkzH
         sAUzSuFgTsVJwQxUzQGtH2pL7IAbZyoegUG9+kkJD7A/nutkhXoV2xRbsLN9xnXpPvgb
         uYAJrdbwvOjtiA0WtYvzwuxRLGu5mvDq9jBFmSUM43YzpA1/NTv6wHnxJIlwJNMxCkGv
         OC0M2DgwlKHL5SvSUDZ9BdXFkrMgzf8YIUo2OJ52T8ELsKps3JTWk4s0snhqJvDP7cYg
         hcjp+rxGXXdMuy9vioQPEehEoiZ5Z4XLXw8sgzji11bgBVXdXkuBIBBPRVglC4ioV6si
         PkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YY4ufy9oLH7Q/TTBWOalVI9Si2u3R0DYJSuSSTxX94o=;
        fh=l7/dyyS5ePl0mMVTKrc8c1o5nJYFvATkAy0S73UC9qc=;
        b=KDjxra49S8dw3cNYoxAiz8NlRBxA3AjZQnKaq13aoU7MNAkFwJBX/pjkrhmEOBuLOp
         5Qc3cbARwnNNeVk5YQekAz8gUStj9K6ki1FprOvBJjax5I825ex4Nb1LRQ0g8mQx6QeY
         Y/vVkbiuJwmXUSGdCEVk+H8pIIfMob74EQXe6shyXhmMlNZbiyF3IuwRuNcxHq1Djd8J
         soD+L4BBrCShEnhnE7Fm3UDp/M2kyAp6emtbQEln9SGYLutAYxio+9WTDXvYCRRPttDO
         ohtIM1udA4wedtQ8SaIWHy0T4PR732h0inaaZih09FKFgOVxCtB7KR0Es+nZhslBkYKc
         leDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794522553; x=1795127353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YY4ufy9oLH7Q/TTBWOalVI9Si2u3R0DYJSuSSTxX94o=;
        b=RFHslk2F+Mfrg0v59cdqUGImsMA/16Sx5XSAeZisLwhhNW3qzjyhD3u8/p5XnSzSG/
         lSwRibAJzRt2TTxUwQdxM3pS41qhdBtZp+XKNyYPV/FSjmyXL33iKtmVFZJS5E7gAy/v
         HzaB5P8fdWmrZ4TzErfx2ZAdyERkF3YaJOEfZD59nhiMoCeIZJT9q7tNpZfHz/Y9a3QO
         0aOttKTKH1naAKtQ2ftYrKauQMC/1SvoTADV2ZLzIPsJ3ANCiOn0cqVRrLoKF9BF+iEr
         ErMPevyXjDx3YNCKIfltze4OQMIJAudlwkm+fqueyfZ5ba/dlLrDpWUtvkcmxbo/2wT/
         vz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522553; x=1795127353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YY4ufy9oLH7Q/TTBWOalVI9Si2u3R0DYJSuSSTxX94o=;
        b=UjiDnNmq6ZAZNDCpOEXC1BXn306v4u/OWBwBQ/npse+7BI3z4LsuSe2utMnkZVdIBP
         Wc0mXAwFdQCR+IOtxw6Jk1rA9nNpv0dA/JSyM2c1bh8Wv23JYNbs+OF2tsBz/axJHRw1
         5o6dtG0uIYSBjv7Z4PDFga2lMA8b/KmAXTfIebAAcc9nDZ7uRVRNn60EixNyrPoITj+h
         nUvwyms7YivElLRzD5xHJF4urobNdf7nh9P5iRABlEXNMj0nWlN7kS3L4YXW5S7GWqb5
         tDsxx9pJaUB48k+ChhbVSeflqrLrR7BziUXzrKi+tww/m6tDSs+oFuxiJOYXaYFvFz+/
         CHQw==
X-Gm-Message-State: APuU4Z+LSHP/HitsmzYmrtZyoHm/HuBGT+vUvtRIrxJLZ0D9nLZ+6i9d
	VxgSnKnfnl3CleQU+eVatQNxiVvyOUuoot4GQaE63FzzGXdpg3q7MrPQhZ0C0WLKOtE0ySrJTMv
	7+/kjwCjp95JEson4DAitY3LE51yS4hGj2m2iprY=
X-Gm-Gg: AYBFou2ZDdkg/4ILSqy61h/AoeoQpUu/l605PFsv3aIHTUlOLIL8emeqSah0uS8+9vN
	X3iymtMqdAxr+EU89yl4cwzPWpHa5BBdVNtwYgs4vIAEYHcn69CdjfcDikxjvXgc2gfhhZ9oQSf
	+yxZXwIY6Au70VAnCWc4Bezi6KYbLLQmZSzZJEuqezQgwQK69HE/F7GRuQzM47WvUdqq7EdC6SI
	Mafq0SjPsYcQMVglG6YGNB4OCKc3YYazISi2Eq8k/1uKQDeK3CWFuReMdkk0mfBvVlCr815geV6
	JLpfyP2b38zfeRAZuSMC9/GG+5Q4dK2OqhrLhIUi4h43atSsjUiukY/+2KzXxGsgb+DBehn4KiC
	WVcKP9C2k8CrLrPQRV6J7y4Y5uGKxQGM83vo=
X-Received: by 2002:a05:6820:806:b0:716:d3dd:c506 with SMTP id
 006d021491bc7-71ab4fdefbbmr378763eaf.29.1794522553231; Thu, 12 Nov 2026
 14:29:13 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <cover.1794000450.git.andy.koppe@gmail.com>
 <5630c671dbfc4a017e6698674c4b3f09d45cda54.1794000450.git.andy.koppe@gmail.com>
 <xmqqzevlehgx.fsf@gitster.g>
In-Reply-To: <xmqqzevlehgx.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 12 Nov 2026 22:29:01 +0000
X-Gm-Features: AclHuK_1FIueEQgSa5JV8N8izY1HvTiSZFhrcNLz6HTv5UdvETWSD1g3xLe3KSA
Message-ID: <CAHWeT-ZGYWQvJUh6GpCJ=BUUY7RMP6PCpu=qFCdfG7u7ZYpv2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] doc: glossary: add root ref and clarify pseudorefs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> wrote:
>
> Andy Koppe <andy.koppe@gmail.com> writes:
>
> > +     ... In
> > +     contrast to <<def_root_ref,root refs>>, pseudorefs are therefore
> > +     not stored or handled by the ref backend.
>
> I am not sure if we need to contrast this with root refs, though.
> Normal refs are also handled by the ref backend after all, but we do
> not contrast pseudorefs with them, either.
=E2=80=A6
> > +<<def_pseudoref,Pseudorefs>> are not considered root refs, even though
> > +they follow the naming rules.
>
> Again, I am not sure what the value of saying this is.  It somehow
> feels like elephants are not rhinos even though they are both gray.
> Why should a confused reader expect it to be considered root refs?
> We already said that pseudorefs are not even refs upfront.

Fair. Dropped in both places.

> >  Different subhierarchies are used for different purposes. For example,
> >  the `refs/heads/` hierarchy is used to represent local branches wherea=
s
> > -the `refs/tags/` hierarchy is used to represent local tags..
> > +the `refs/tags/` hierarchy is used to represent local tags.
> >  +
> >  See also "REFERENCES" in linkgit:gitdatamodel[7].
>
> Do we want to mention remotes and notes hierarchies, I wonder.
> If we do not mention remotes, calling things in refs/heads
> specifically "local" branches is not very useful.

v4 mentions remote-tracking branches alongside local branches and
tags. I left out notes, as they seemed less essential examples than
the other three, and of course there are more.

> This is a tangent but is very deeply related to how "root refs" are
> handled by the code, so I'll mention it.  Random things outside refs/
> are usable as if they are refs in the same code path that handles
> the root refs.

Yeah, the rules are incompletely enforced. I assumed that was due to
backward compat concerns. 3.0 is of course a good opportunity to
tighten things, but as you say, separate topic.
