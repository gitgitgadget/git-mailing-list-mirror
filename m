Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795595140;
	b=ssignJGuTID1mvDNU3DREXHJav/ifSDxjgGmD49wa/deR4dutc+mu/Ebfygx5QQ8SSQc
	 5seDrG8lESGtGDld3knpK2nnrh+oEWnzBTRysrF2vb1Gzd23/6vtzTBF999OC3wy//O6J
	 pr9bMy0k8B56ZwEISYcogANcFFoYqGC6AAfE6n/ue1OWbQejfa+mqyph8LnMkNdmJwUss
	 nQ3WNd2/i5pKbB/vjMnExPJtUvX/x3KoDiuGWNx6wS90Frl1spKx6IToOgAJx9sIhbI0D
	 0xVuhfwh8dI1qPGYwyVfnt98HjW7u5m3dUM2QE+I4mjBaKZnwUtiJe/+UgGIFqVxo9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ekOeI5a0BngctH2DGaprfZe3+Vrw7Nmk/hkJdfWW3wM=;
	b=YN61progCKAAfXfuQmqVMjLFayeXInMXosYtJhZeULkopn2J2YaU77vIL92y2RCUko4d
	 HnrH9U4vol1JWH4CPwEL1+RfjEaN9vm0jwFfbn7S9Cr7xomVA8mhXmVlA89OHmmf8FwhG
	 Jui49NhOYIdR0CuIDomvR5alFKmWwYzt1XNYbRUIKy2RVMUVpty7e5+dk5/hQM2KJVkNZ
	 TghJBBe3g+TNzI8FReyJp5sxcP00f2MD1KOgX84uiC9iv+4DKInvGVHtuVtvTGIckZHbT
	 T8hR4ostF6YH5SLXN1lHC0xnrjcUKPH199gaB2RnSNQr4GZwOkcIlBGgZyVvPpTpMaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4NYn02c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE15606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 08:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE15606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4NYn02c
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b5786e099cso3677500c88.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795595139; cv=none;
        d=google.com; s=arc-20260327;
        b=WcowvV5JMGncGOUFiMjQb3FSvsNePtaoVXawj/Av2Rv+gWV6zfBaDH1dtiqOOSru3m
         z0N19ImjxT5iQeRj57yA9fnQ80SyWv7GZqLVPfXqUQSch8+QN0TtqMmfZ+BNv5FiCdTX
         tG+PfI9MSb/rifMeEyyNhax+Hu32c6UaDcX0fvWYijQKZ7vxImC6ZjM/JvKEqkGS6pJE
         M5opsVQEHYuoj1/xsLaR978J53t4PLihl0MtLkocSwAmBQOiurPSbB+aRBsYrKZSzbaM
         Lq7BMFB+xAuaDcZs1wo9N6TiFYn19v94vcpeCoMNYV6yckJFKeHkeApjxIhAOEsFKB3z
         +7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ekOeI5a0BngctH2DGaprfZe3+Vrw7Nmk/hkJdfWW3wM=;
        fh=AmY6HvDAyhoLqa22kJAAE0Za1KTIdmyGX/wKiClnamo=;
        b=Dj0gAeZx+050jCn+ZM5tcQKhhLIHG9T9aBCJGVqZA948jkPh3g5WsEjB7CcurbsrDc
         R+weqJSvJBWAiW4WNatxOOoPqBFf9pYFPsklLDavKCofRsESEiXJwBtvN408g4yTeAic
         lXt3/p6RpvtC09k6RnZfExtKJgbywuJ3xI4yW2YN81MR5X5yS02jHuxQJ8lbSJGJZ/oZ
         r32vzR21ejw0YfLLNxuNZZ/N3TI4C7k+g7GMgSSA7qC/YiH3n1g9JXur4daozgScC6UC
         glxxeFJ7TUPxFWMvIQ4NdH39c0AzV7jFRZ11ArQQatVHzLxqoo3Kkck4m/w78z+oMGth
         2mpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795595139; x=1796199939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ekOeI5a0BngctH2DGaprfZe3+Vrw7Nmk/hkJdfWW3wM=;
        b=m4NYn02ce0mVmKMQ+A8TXm1q5iWsCVaUnCr2AgViPQ284Vu9zFytAcrqQGpmYwOZin
         3CXURI9MDFX59hDcqXY2FLUcVHL0oVoEynLdJQisj5exNVyOxw0LaKp1ZrZ0/jszvvoo
         m7yDLGAHr6ijlf1FAeYEtsfmuo7K5J7WpixaVvfMTIUn+V+ex+hctdgWfZep3fRVRwB5
         IcSMz5mS3s9mYkl9dqU5VOB/jbHreDtj5gzOkLG/ZQMOcZGUSyg1K4B7rHXHYqGK3mqA
         /GJAyOmIE3Dm4u5qc3hT/+U6bZFebQcGHb6LeAmifQX1FBojY7MfevGJu1AS5KpqBNNz
         dAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795595139; x=1796199939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekOeI5a0BngctH2DGaprfZe3+Vrw7Nmk/hkJdfWW3wM=;
        b=JMvdAp0wtkJBF8QEILi1Zbz2ojzW7LO2F3NpYggdYUNsoKFRPIE5BPiH+QoC2Lh3IF
         E1EsfCMh6JdY2tPSR+afhuLGBfr5sBrIT+10zEo9WndumzoFdmN4+ODzwT387SVmPFoS
         8Ar/ViGcKKO8Us/CGuTdpSL+/o+zEvhZGDNg1Qig0OPDdkwdCcOtkJBdk0UA4IQnQomi
         4ku9LBxCSI71pyC6jap5pINaQcV0OCF3lhaoKqNITGocWIr67CN9rtJHAagDrte/vDcJ
         15+xVXZnwYmM+B4BJt0cCIkuvmebAOLYXnc80IqO0YGOfxfKu01auYi05hwCxAJB4uNw
         XSSg==
X-Forwarded-Encrypted: i=1; AL+hErH4mocBvhS0wmU8jADIxyRblI2D9qk7YkccvrzB6B7BhFK5i/dqbkTtbX3IdFCHn6qldFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h/KnynwQpZcnZI+VGWKdn5dXt6ho5txT2h/wsM7miSeXA+vlK
	Dm1znaVOkpKHVHfwoXdV7GSc+iROeseUKU6MUniyANgng0D9bxskNCzSk4Nvd69jl3PbKOHNmTa
	l5XzrTXwodvHBzLibROh7oLvXgx9KgwU=
X-Gm-Gg: AZFdTZffmG18RR+BhRaCBnzgttqCfSvCwm0B9qah3EyH2YF3fgA99ExeEtiljwsjGM4
	RDhD/x8pK7UYVwSEkQ7WLF/Fb90wQUnJwdkzGaDWnYLIjqi886F58NjB49oRfsLiA2A9uawgcbE
	Uq5tMeAtZCLH4Tu1WBUxoIUAmDkGK0H2AyLX95NxiqGa5Xoh6z2BlCl1M2TckFtZb8MfrA15H9q
	iEf4vJRdQJVxwpnyutCJHVvkJ5o6lLm7KodWzSKnTvmlD8I/3IWYwnXDn/38ZXS+bjMd+BsamSi
	54Txu16cSKtfOxmENyaJ6QE3X3gnlw/P+PWh20I2XQxkJvKJSVBMmZX+kAuyh/5iVsS5baJyCPh
	xPJEKbJN5+7yw8Dl146v07e7fVfSbeCI8l2iyhEiwfE/J58vP8TGlpkQvhbLFQSq7EL5Deh7Dw2
	DR9HnTpkzS1vJmK8cXv4Q+7CsEKhEX33Df83RMPUcX+GiXnxg/1urc1wfZTNflyAFU0bO49mZDm
	ksXWMgrtjNx+/TdrrGHNhX9
X-Received: by 2002:a05:7022:f907:b0:1b5:1005:682b with SMTP id
 a92af1059eb24-1b55689f5f1mr15607151c88.7.1795595138747; Wed, 25 Nov 2026
 00:25:38 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261124172146.18330-3-okhuomonajayi54@gmail.com>
 <xmqqtsl5g28h.fsf@gitster.g> <CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
In-Reply-To: <CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Nov 2026 09:25:26 +0100
X-Gm-Features: Aa3M54pQSSzqh2rJZWd38HBDVuIjpZcYRW8Bl7Rdq0rloGkGHWj8e1y3so2Nef0
Message-ID: <CAP8UFD3Pf-0T13OAPO312tm6DdYdmF_-NR6zRyk9-T1h9Qoi=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 7:45=E2=80=AFAM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> On Mon, Nov 24, 2026 at 1:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> > But others? note_tree_find() calls note_tree_search() which by itself
> > does not touch 't' at all [...] The conversion in this step would cause
> > them to dereference t->repo without checking if t is not NULL or
> > t->initialized [...]
>
> note_tree_find() has a single caller, get_note(). It replaces a NULL 't'
> with &default_notes_tree and asserts t->initialized before passing
> t->root down, so 't' is already non-NULL and initialized by the time we
> read t->repo. note_tree_search() not touching 't' doesn't matter here,
> since get_note() has already dereferenced it.
>
> The other functions this patch converts are safe too, for slightly
> different reasons: remove_note() and format_note() guard a NULL 't'
> themselves, and add_non_note() and load_subtree() are only reached from
> init_notes() (and load_subtree()'s own recursion), where 't' is the tree
> being initialized and so is never NULL. So I believe this step is safe
> as it stands.

It looks like load_subtree() can be reached in other ways, as subtrees
are unpacked on demand, like for example:

get_note() -> note_tree_find() -> note_tree_search() -> load_subtree()

So I think that the real argument why the other functions are safe is
that all the public entry points (add_note(), remove_note(),
get_note(), etc., and the internal format_note()) are safe as they
replace a NULL `t` with `&default_notes_tree` and assert
`t->initialized`.

copy_note() seems to be the only public function that doesn't do that,
which is what Junio found in 3/5.

It would be nice if the commit message of 2/5 in v5 briefly explained this.

Thanks.
