Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727239;
	b=H18XkNYuGwPR5dtbijLqtEEkb7rjNXUpOgVgQS1ArBzMGmGTJ+V54RD/XTI8qfgNWIur
	 GJQI8HW9DtLXs9qvtzetNoqRFiv9pBXsZg+kwhnF5KYy4NGGuibrZH/KVcHC8D4doTrHB
	 ishRMWek2bFXzSi/N4IcUWMbbpcl37qiiFJWrHeOvZczBbYLh7iGzSIOw0jqVS7m+hlz6
	 vxC7XQ07wKF1GT3tlvoDt9wdkd5+FxSnfomYIXYufPb+c+Y7m5In3o41zGzyFHHbf97iX
	 ze5laLg+oxaBqHAUPcD+JIL9GrEh2yL2AMlVerC37MlBZZ008VeulwpcoaPBeFM+c1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NzMpUPOUxqFjP19eRm7nrwhegVFDt8bGA4H1ZmixgYA=;
	b=EBROAJH6KUGgby0Get9CxkPnUOADDrZb4Nkv5eikSgEhx3pvwXB7+8Li7DJ2qHDAHV35
	 VF9FaoYyjGwTa9TWil+DRB/p3x6vmhKk9Nw0dj6ZOaNle3JfAbD+fmi3P8ZQ09HSKWYsA
	 65oZMpdcCJVl4aLwtFbXmwkdS3ik1yrX6ijmg2djeE0w+prgMysh7gbweLh1ZA8mWb1yk
	 OfHnQMHF6i3BJQ254Vk6bPWKSyBFHQewFWI1Sh132cthskairwNRX4T/tyfMjAON4qmbt
	 ByHs32N2x5Ny23LcTdA2jTm78qnmAGGQvOgHhSlZnFDFb8oHWpVrdRRiqx50pb6mtCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IabZj2rF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77C606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF77C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IabZj2rF
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67da62357acso9850863d50.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:07:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795727238; cv=none;
        d=google.com; s=arc-20260327;
        b=HCeC5GvExAqThmfMxyQwnjye49k8ykT04b9dNOOLDadjHWK45g/U+mY5DqvmdywOWw
         lWa3H+KAGCUT/MqG2UCokacIDP68yg37IZSEBtUXNVzrXcjzFUzLcrTPMU5cw0T9o7l5
         DXYKRQSwsoGqJ5GF02wEkc4UpGJJgkHP+hlWv+Mw3HQP0hUUcBmMiRFnUbFZ3RxePU1Y
         5P5JpcNYc+bu6ncLJx+9gInWV+53/yAZ6F2psYoI2KX9wzB7z0/e635koCAf5CfSUYSl
         MwyFYULA6r7wiLLGyvhwynMTnmYXE9YtsCE72Q5iSmsjmmVijs+jtajfw2c/yYB+gsEq
         vKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzMpUPOUxqFjP19eRm7nrwhegVFDt8bGA4H1ZmixgYA=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=hdutY3H/P2rrBngVK99TeHrrJVppOW0hdt60zax/dAytHXZm0ERs1WPnGrwnaLCQ6v
         RZFQsuuUk5GzonN2fWB/O/nUfi1VMgPA/jtzuv/fcNz8JlTIMK5kUn0/zWqrVupp+r5+
         DjclmMbbA6gP5eubLT8/PwC5dXGLLMRAEtT35/LLuypiLRTCUrXUsY0WsJssgmD1GlKr
         CEcSeBhG2m/t7t72DdxkJsS57mGPNkukf2DqcMDjGJ4BUuK70mgOf0QMuDEo9MAFV9hq
         EaUvkffgWM2waSc9NJXpBq88IVlEZiR5BgxtWScSpGndM5AFTyOkbb7TDZDDRqqnKX4V
         l7JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795727238; x=1796332038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NzMpUPOUxqFjP19eRm7nrwhegVFDt8bGA4H1ZmixgYA=;
        b=IabZj2rFYlhDxBDGhsrIZOmiomzqi4UkySkQoqQ6ip7y44/hhznrzrjfSOvm1pITEm
         48rOQvAjhfilBN6Jj+Nv5YPLY9uGW1wJNxXDor85qm83GrWqpoV2XQvC9VyQtGQbwfON
         IVLSwi04dT1byS6uKrgR7vyJZkr9wB0uldd38a24LAkZcfbGYEjAtbn9rJQsPUr/iApT
         0sNTl5UCk11Qe20cqLXy7XtbMq6IfCNlYJtsXUsP9sY+w8YFxG266ZGts3mx19dPcFG6
         jkaiDrjaUHt523a/ocqZpkpeuzxZX6tJ+siyHr+BiSZS54DyhoLHJnvJS/X66Y3Q24gW
         da0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795727238; x=1796332038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzMpUPOUxqFjP19eRm7nrwhegVFDt8bGA4H1ZmixgYA=;
        b=gthS+YiESSZ13x5JFVy29kXHgXnA3KQzhK1baxWngwtEaNYVr/F2iiIr+ILMbs6TGx
         gYCIXdUKd3Odx451kTV8uDFaDi9gsWJEY2+vZRbN65z3TT4o39m86lIw7EAPYH+HzSbx
         UN8GyfyONJdy4ULDTmvsAmtPVc0zcBy/UQjz8izG3IY8ZSCnNQA58CWfyXE2uUbIye+m
         GXwb3OhtWDSKLl65tyJ6MNUx3afRmvIoGoC24EMwQJJA6NPwbdlz+CHXcXiiQbwiJQyl
         W0jG4EzlugfhR+iiFQ/H4mt+MFO7w/yO0cz7bR5B1VtnFvkHkKzfMzWs9M9c8iZqh4D/
         7mcw==
X-Gm-Message-State: APuU4Z+FqliT6KKIgAnMCy8MIxO2b9o4ivq+d4an3+R3LjgZNJ5QoFbO
	zKI9xjzAK4hgdQjOkZHangpK89kfScF+360Yj5WMa5Ki1Ny8gd8bOT0hWr6wQij0Q8hTTTF4ZE0
	rTrgCSEkbbeBIdAmQZqV6V0xG2sKC6QQ=
X-Gm-Gg: AZFdTZf1SsEA5mjBDk9Gr0dGvyMB+9G+6+KFXmEuBqzvsggItlcHWzgu+EtKV/rcoYx
	tbz3CBmsEqyr+/GgeT5ld6kL7V6lCHdgolUc6fzlH+u1nf0UQYIYb6dtyu1jh2zO8KSpT+pqVgj
	zCjwM1aXl7Rp8o5jjeeozpbKtqYdzPvKmGHnrEQGmnlsTn8Flc6Hjqzmyfqh2ViRCPTN0Yxb8xH
	U3llJFAKP+243lAXrSB1JmpPi63lTMWaHtG/CCKD+d6JL58Ni1c3uMYasCsl7TX5To7qMau+Cuc
	HsEbgO81w11sWmQoAh90dCFnT92KtX5jExDt5XMJ8IGpkc3WiRCVjdpyw93XnRasVdJ4fzFB4lb
	6xxP/2n0mf+V1WsDfNpAATGaPPZW/bdHogAle/qOjDXcgUbxUD7QIgqlJWbhp7ucDi5pYFAe9Q+
	SERp4Ad0WEZzJLrtImvxeW2zRYC5tNFhn6bmRQyUuY86bRkpmFTHIjWNkHptSo0mxU42hI/VSAf
	J48RupW8ojZoeekBs+sRGS/uSMMB0uUK1tuJ4pH0eepBxxsxfair2rb4g5+Zg==
X-Received: by 2002:a05:690e:5d1:b0:67d:bdcc:4236 with SMTP id
 956f58d0204a3-67df449a6a6mr6505949d50.75.1795727237720; Thu, 26 Nov 2026
 13:07:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261125220214.35881-1-okhuomonajayi54@gmail.com> <xmqqzeuwqm6l.fsf@gitster.g>
In-Reply-To: <xmqqzeuwqm6l.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 26 Nov 2026 22:07:06 +0100
X-Gm-Features: Aa3M54raeZCbUn8yu8c4EoVf2E_0p91ks_yhegZ9HjZ1dlVRUlXUFPiVKqPCw6o
Message-ID: <CAFpMFfCzQ4+5kktpx1JrUx2e79f23FDCxHFMtW2T9S8-_JO8kA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] notes: start passing the repository through notes.[ch]
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Inside load_subtree(), the KEY_INDEX and SUBTREE_SHA1_PREFIXCMP macros
> still derive the prefix-length byte offset from the_hash_algo, even
> though hashsz now comes from t->repo->hash_algo, so converting KEY_INDEX
> together with the other hash-size helpers will be important before
> mixing repositories with different hash algorithms.

Right, I'll add the KEY_INDEX and SUBTREE_SHA1_PREFIXCMP macros to the
"what is left" list in the cover letter, since they still read
the_hash_algo and should move together with the hash-size helpers before
a notes tree can mix hash algorithms.

Thanks.


On Thu, Nov 26, 2026 at 4:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > What is left for future series:
> >  - notes.c: the display-notes code keeps its state in globals, and log,
> >    format-patch, diff-tree and format-rev are given a repository but do
> >    not pass it on. format_note() still falls back to the global
> >    default_notes_tree, and expand_loose_notes_ref() only takes a strbuf=
.
> >    The hash-size helpers are also still on the global.
> >  - notes-utils.[c,h]: still use the_repository. And the hash-size helpe=
rs
> >    still on the global are reached from here, through create_notes_comm=
it()
> >    -> write_notes_tree(), so converting notes-utils is tied to converti=
ng
> >    those helpers too.
>
> Inside load_subtree(), the KEY_INDEX and SUBTREE_SHA1_PREFIXCMP macros
> still derive the prefix-length byte offset from the_hash_algo, even
> though hashsz now comes from t->repo->hash_algo, so converting KEY_INDEX
> together with the other hash-size helpers will be important before
> mixing repositories with different hash algorithms.
