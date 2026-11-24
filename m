Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535367;
	b=OtEG++/0P3ZUobAs4PKgs3RoFB1wUgQOVEfF1hJXAdzGzBlnr6f1uDhNFur5bGzMS00N
	 Gw8pS7wlAOENmuoSzqXjPSXkY8p4ioQEWCmcS4BP3oq48q5GfPM+AZJCl6PpBMdYAtWHw
	 wINI7M1KjTVjCRJ4PGTf4+6tp5Xl1B5YDqUKh0stT1mzbGzldUT56PD6tNfgUITEY6S3b
	 XcXSQRMJQ0ImS7u20jo/bAJQJ7Yssc1eUWRiBYixCdGTasECNX7R1wisa6kC3VXeFCLb5
	 eiuDmSDAzlLVezkcl9y+Ytepj5DyarkE8mirJUy0xzUmImk1r5TnboRaQK2GIFxVRYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y39UN+iE06Q67IFcGwwsPwQ+szDOCgYcVeEwzPRd52I=;
	b=weAKS5o2+Nixq2Wazx3WIMrH0DGrXyIOeqdjuPRiK2wiiKVqqUU6u8ZXlOn55rAEC8yq
	 rotpLFDyF6hZQMtO0g4BG+PWfKOOwsuA+oB3xi6tc6ShgD1fLH1rN+5QhFrvyi90EpG6w
	 VjLCWdiCXC+dkOUfFKKKRq+Cs0X9tRU+zPfK6y7Zg/DGGqOCBhNQXzgG97zKjbzZi0/wY
	 kLc7PMrU48/a0K674oIXCVj8ZLz5DQEe9WaGysCuQADql5b+lC/OQJPLS8lsVLk2RoreH
	 ZI+Vfb95zuYBaB3jo8F3xDHwXuC7h3JUdetn0MumUs5a3gikfP92aX6+6c5GO6ZQ7uA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDe4ljgQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E179606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E179606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDe4ljgQ
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6767d92cde6so5075543d50.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 07:49:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535366; cv=none;
        d=google.com; s=arc-20260327;
        b=Y3uMAhxnDOXiUI2Od30Pv3uc/BuHQDCT+YO+JM3s+iH9NPJGCO1Mlxy6X/BdBqAq+Q
         1EGK0zXsipkUxP5ATQgwtSjtcw72eKhQBzgiKUmu/obIz6O66w2uOe9e//lJJYVGjYPA
         lEisKvIehUhXbMNWX0zUgNNbYc/GKqkHZyA3oK4jp5ZkoMBge33Y5eMNgkq9mpr1Guup
         dddFB+fBwS6sW6VlH2CGL2jm+3zQuDGizZuiSm4SZzyySp6YRimVJlX8tMVQLcJFdyYK
         piX16uQRjI7HRTGx6zN96S2RKzcPhW+CtOSG/rThj13P5j55AJ6uJ0qFRS10K78mYYL4
         75qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y39UN+iE06Q67IFcGwwsPwQ+szDOCgYcVeEwzPRd52I=;
        fh=b93BLYhEU9d4PvUs854xLtULYcpDvObmLRSV+ERr1eo=;
        b=RR38LJy/ArfYRmfGHJ5xS32z8ZlrLXc81ae4AF5qNEtC94JkTFmSjRr7sUYaBeoAtD
         PF7dHVcN8mEd9NhC6kdLaNhfdYox6un857am34df6VDIsl2gnKGV4JvvTBOlF+TEQyrY
         6Q1X96qefTWQBwiJu9b5DIasRARGtaTjYWGdUSmuIb+txJeDQGB1Gkbj8smlSbYpKZG+
         QLLzvLZhF3VHFSOFQcEAM886h1WRi1dLB2yNL5WI5Q42h1tn5qiq377m3wPu7pp9Dl3p
         k082ciCuBUzTc8ffIgtZQrZgcVmDpGecjRRS0QbVY0Alid6UglGM3pwAXoJLWcYbwHxS
         3Jqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795535366; x=1796140166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y39UN+iE06Q67IFcGwwsPwQ+szDOCgYcVeEwzPRd52I=;
        b=PDe4ljgQ1JjIN6igMHH3YhtSaPDfzzF/9CXgf8e2l6vWf/S62QONKLH4UkqKQ5r2NP
         LjMGc9cFaIuQTnsxUORY3wXOhTcXRW71HEb3yIMxPgTECFa+BreMPb5qkdzZs2IBu2Mp
         8x+SgRKAjxnckuhxbvnkc5JPBGuKJpTYMPCA7w9hiWE8H3uRpot1HYh+s7dVOpBzeybs
         GNxLGFPVZLSx9vFEKw8SwJyHdVB+BFU0YrHhR+mK0Y9UyeYhfzSJh+6UoIp5obAQhppT
         bKmNcoqvg/Qrvo+NpzNMFGEqCKhQCPA3MPVueU6399tanGCOj/DlIwwloL6/CeCkdYXb
         13zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535366; x=1796140166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y39UN+iE06Q67IFcGwwsPwQ+szDOCgYcVeEwzPRd52I=;
        b=CQ7xTfmqqWsEyuM4RzmQF9GPCrbpvVW/iG7NxyJbEBCLk4YjYNXemGBUHE4yVNqjW+
         9T59U83LsqAalaSD/DLP7laMEl03B6SxcnZmzUAH5ea5XRXnFpSJrXRmJP6AERQKsqpW
         1OdKOZiLVc4ySFeE9pgm9TMkon6qrtgV/cOgGZVHQBj7bxHkVKfaqxvhsnA2Cp18bQxI
         T2YJzhxqEL+HU+LIo/XS3lchl/of39Ioi5Mvuv5KzUphfOZLucTWwT5Je9EwdSKc4aum
         EMHIPPTrBghG+92ZBYb4r9iAS6zMFOZzH0/ZNZvNL+FFGOXTQQdc8ClNYGgtn9zDj7QH
         L79g==
X-Gm-Message-State: APuU4Z9qQHOMErufr7dDKXhFvX2CsRHL28Xpq8HrhigvkuYRx43LcQ60
	Fv/KtkzDDkWMki9mrxntuQl1IXzXSRW+NQNxmYmyl835SanaO4zrrJR3mNyVacojSYy/wXGkBLo
	QeXZSOA3R/pFmIUW02RAsL00YYi/B+cUx4daCFug=
X-Gm-Gg: AZFdTZcTfM61vY562anEiH3j301OjuIWoZZFY/6thADccUB3/IaCcC67Tg42BgKzMIx
	ayCx/mROAqMPGm6u1Ch2FKmZu14rimcDj5Cx/5qS2+hmBgqA8c6drP1l6nOHTk1xS8P8OYcyZ74
	CpPzYGMqH/derFIsk/KxVahUt7Psf7S4FqeihyKPXearSm7hSVsm1B5bsXpdyQH1X0+gCY2Gt6x
	lW5S6WOLIZxGUzMX/HPrc9TgNAy8Eb8d7HdelHqzbVpZfUP7NWB+6HqOp6RVdE/36zCSJJdDyDY
	D14FegNESZ39swBy9PU7oS2dXjUpYJvuFHwjGjXwJ9Cf2Dvg0QHtWkFi+bP0yrKmCFoI615/VY7
	rOCj+sqbCOQIGkZrxEe0GkszuMXmjkuY4Ze/uMNj46L3yoZaIxAgUmWiNJ78D2LfKtoLij2DbqR
	x6Irc1uwFLOE7alxYdVTUnqBpZZqYLj01D3dQZxZvmiJpbbqGerxk3NThmugcBbpgRyyht2jnXL
	nRgo5FewQaZTdP5wbGYyYn6NNnRz234xtD05g==
X-Received: by 2002:a05:690e:108a:10b0:67c:3484:f8e6 with SMTP id
 956f58d0204a3-67df43f8377mr4201850d50.38.1795535365579; Tue, 24 Nov 2026
 07:49:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p8zw49g.fsf@gitster.g> <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-6-okhuomonajayi54@gmail.com> <CAP8UFD3SosDP2_T3aWz-72TQy4yujaEtRH9tM01AxwEkXzmDtQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3SosDP2_T3aWz-72TQy4yujaEtRH9tM01AxwEkXzmDtQ@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 16:49:13 +0100
X-Gm-Features: Aa3M54oUaq-CajeAUjZeMa3Ohnt0J-sXfUBh1PMtO36m-K_jqmah-0-9aXCkOBo
Message-ID: <CAFpMFfDGOCmq2=kWAFU4FPkWa7fLZCUqeCSF-5XhrDkqMbWnGA@mail.gmail.com>
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, ps@pks.im, 
	gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 4:27 PM Christian Couder
<christian.couder@gmail.com> wrote:
> It seems to me that the copy_note() change is not related to the
> combine_notes callbacks, so if you moved that change to the second or
> third patch in your series, the title of this commit would better suit
> its content.

Looking at it again, the copy_note() change really doesn't belong with
the combine_notes callbacks. I'll move it into the writing and pruning
patch (patch 3) in v2, since copy_note() modifies the tree through
add_note(), and adjust the commit title to match.

Okhuomon

On Tue, Nov 24, 2026 at 4:27=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Nov 5, 2026 at 9:34=E2=80=AFPM Okhuomon Ajayi <okhuomonajayi54@gm=
ail.com> wrote:
> >
> > combine_notes_concatenate() and combine_notes_cat_sort_uniq() read
> > and write note blobs in the_repository, even when the notes tree
> > belongs to another repository. The callbacks are only called from
> > note_tree_insert(), which has the tree.
> >
> > Pass the tree's repository to all combine_notes callbacks. Also make
> > copy_note() use the tree's hash algorithm for its null object ID.
>
> It seems to me that the copy_note() change is not related to the
> combine_notes callbacks, so if you moved that change to the second or
> third patch in your series, the title of this commit would better suit
> its content.
