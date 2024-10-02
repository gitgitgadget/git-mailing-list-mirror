Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5391D0E3F
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900665; cv=none; b=S6b6PgmVkhw4RSJdUYIMxrmW7uzXpOL3V83qiL6jIp2CRCKaRtjrLCUesOMBj0Nxr8LDKvun/73AVz9jtqqW6Rk9eAxxQZbTxPfCCq7z7f4uQRkA+mJ61Dt75gkrf3yJMdkA2VzE0y9BvoH2GV/JsZUFNls9BXqk6Dg7KRukRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900665; c=relaxed/simple;
	bh=9CNpGAgjAXY9orj9Lpw41nfHAffdwphtNLtJnXRAthw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBeFXH+RxXEazPI5ps9uY9FPOMN/2zTk6W9OnZJ4BeAt2BrthxfcqdQtQtt5D+X9h9Wv4l5GUNGfyBH1XMwFThc9OjeLhqAVVXJZAiCgArelNFUXqXYTNR9/CaIBiQnWWuqIVxOiAsFlILGaf72sEfuOmPbwDeeUTlXxtD5KIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c567b2e81fso337126d6.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 13:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900662; x=1728505462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CNpGAgjAXY9orj9Lpw41nfHAffdwphtNLtJnXRAthw=;
        b=A5jV2tTxCGkkbONglTOlUb0viazDhRWe1+Q6N7fEni8b9GW7o0b2tnC68qQ1tC40GN
         XerYjFmO6kM9ANeSh/n4KsRnzEecnwx9D5kklibPTTx1UAp7ywSbiHteps05ijVIFRtC
         4HTSi70AJL/qqIl5EQdCfW6lkGRlv2e2ojtOk2mnK4KNravCoaL4WvcIuwbRbzEK+ZVe
         yxYf9HXZGYZDpxtXN1UAbm7H3Lvj8hH8Te/2peyE90HFZ/4d6cfUf6e6EnglQDnJlQ1T
         +AT9yJvrtKKCE49C6AV6C0j+AORrkQ1OXB8zsTvIob56FXHTigCltLyytXrW0J7bmToQ
         OoHw==
X-Gm-Message-State: AOJu0Yz9pGYxHBJ2JoHatBnok2Tpt7Ilot8CTcJIbav6LvLzXQD9xe1z
	wYAI5lwBo84CUCUYwoKyfbVd5/ZW13vNf3qbM1odBLDP6Ft/TAEK3o8MU/8lWjYKqsqg2hghGfv
	80kbOG7ipHD8zdcz2qapJNIQg+Qs=
X-Google-Smtp-Source: AGHT+IFKGOfxbOgCa5BnI0M4EY6CdInsT9Ft4K8XKYX5v8tWDAz0QRenE7vdP/xRfh+mLFTbHWbZ9FJY9q5gi5T6Kas=
X-Received: by 2002:a05:6214:1bcb:b0:6c5:1267:a821 with SMTP id
 6a1803df08f44-6cb819f6e0emr30330766d6.4.1727900661800; Wed, 02 Oct 2024
 13:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
In-Reply-To: <508e3783d284fd2d3bd4840907ed0bdc20bc1b23.1727881164.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 2 Oct 2024 16:24:10 -0400
Message-ID: <CAPig+cQtxx=fQM2xHSt8AsxyWgjSiS9Kd5PtjA+jDoK5s9xh4A@mail.gmail.com>
Subject: Re: [RFC PATCH 01/21] Documentation: add comparison of build systems
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:16=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We're contemplating whether to eventually replace our build systems with
> a build system that is easier to use. Add a comparison of build systems
> to our technical documentation as a baseline for discussion.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> +=3D=3D=3D Rust support
> +
> +Many long-time Git contributors are nowadays in favor of adopting Rust a=
s a
> +second language next to C. The build system SHOULD thus support Rust suc=
h that
> +we do not have to reopen the discussion once we decide to pick up Rust.

I've been watching the Rust discussion mostly from the sidelines, so
it's possible that I've missed something, but I was more than a little
surprised to see the claim that "Many long-time Git contributors [are]
in favor of adopting Rust" since my impression of the discussions does
not reflect that claim, nor could I find sufficient references to
support such a strong statement. My understanding of the situation is
rather different; I've seen both proponents and opponents. With
regards to project regulars...

* The most vocal proponent has been brian who gives the impression of
being quite a fan of Rust, but hasn't provided particularly compelling
reasons to adopt it, and some of his arguments are highly subjective
(for instance, "Rust excels at multithreading"[1]; while it's true
that Rust may make multithreading safer, it is highly subjective to
say that it "excels" at it -- especially, for instance, for anyone
familiar with Go's approach to the same subject).

* The Google team is interested in having a Rust wrapper for core Git
library[2], but that doesn't imply or require adopting Rust into the
Git project itself.

* Randall has severe misgivings[3] about Rust being introduced into
the project due to its exclusionary nature with regards to the
platform(s) he supports.

* At least one well-established contributor has stated[4] that "Rust
scares" him. (Possibly this was said somewhat in jest, but I suspect
the feeling may be shared by more than a few long-time Git
contributors who see Rust as an overly complex, complicated, and
convoluted language but who haven't spoken up because they understand
that the programming world in general is moving toward more modern
languages such as Rust and Go.)

* The only properly compelling arguments I've seen in favor of
adopting Rust came from Elijah[5,6] who is always well-spoken,
well-reasoned, thorough, and backs up his statements with plenty of
factual evidence.

Those aside, I don't recall seeing any other long-time Git
contributors speak up in favor of adopting Rust.

[1]: https://lore.kernel.org/git/ZrqJM-vmPaJbdHP2@tapette.crustytoothpaste.=
net/
[2]: https://lore.kernel.org/git/cover.1723054623.git.steadmon@google.com/
[3]: https://lore.kernel.org/git/053f01db0b79$0d885b30$28991190$@nexbridge.=
com/
[4]: https://lore.kernel.org/git/Zu2D%2Fb1ZJbTlC1ml@nand.local/
[5]: https://lore.kernel.org/git/CABPp-BFWsWCGogqQ=3DhaMsS4OhOdSwc3frcAxa6s=
oQR5ORTceOA@mail.gmail.com/
[6]: https://lore.kernel.org/git/CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=
=3DD8wsCCVwqQ@mail.gmail.com/
