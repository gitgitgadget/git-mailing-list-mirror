Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794298177;
	b=zMJ9xKeJkklmDTYHgEUF9NITgrrC1IKSemwZZ+9U9r9JhF39RZDJimfpvt/Q/TR98U3x
	 EBh8cvDETTDzzAXxDnrEQHp9UWed473z6+jQLBTXc4V6No6P78bCIPaz7uO+8VStNbCeG
	 2x4U828pZeUXzVP1G4dS7m1SKqR2XCvZ19PWy8zVvt9Funp7Wymk3TckUaBnzni/YrWNB
	 XKJ4exs5OH7ShxA2UpaXhqNBNLcQt5hDteS1YbVmpf7Ae6BXhWCD3yWee4cFjotI1sbj8
	 OCDILE+M4ynXA1eWdXlcomTwIp5UCtIfkHgEb2XCrCLE+PvNnnntO70g9x4eSmqYFuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UMMJCmidmYzIuevLomsRruUoBt3lfZrYvhvRM0z33yE=;
	b=QfbQP76QL1HQsf7b77ugHkCrqP3uAZ+od5lECvKzGefMLPeAx1F4RoJX4NfVPkjcymyi
	 B6qVONnxxIIq2qzdBzv2uWGUe2chFIrGi6YeYGnO7Nyqo2W+i0fmpUjOiQzuhp6yu/5Ty
	 SeJqPlhc5C2xzJZ7iItd/INCw3/ik2GpMK2Ir+2p14SqyP/QPAJAgTtRktJORim2AaO4A
	 Tg5qj8Msch8UN5r7+Yu14bFWNl2C/TgDOmd1jLrtwtS0THIUgzM/H4wtkcQcIlGZkKR4/
	 LLLOJ8Z/D9FGcZRls2yHYNAzbigOMJY1IsUVGMqr/bY+Ldh+IXj2d0jCb6FmY37KuGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=BzSx3UZn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EA606A32E
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA0EA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=BzSx3UZn
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c43373ae89aso70956866b.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 00:09:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794298175; cv=none;
        d=google.com; s=arc-20260327;
        b=N6EE0tp/MHFt6i5kOz5dhiJSnvd2AWnaLsylEcH8BthdmqKuY//3uCnEVUtK//X6RU
         Sivl3Ebvr9o2u6i741DE2smXm07nQ+XBKkH/4hCg/mVeEPJbi9tkgEO4uCPQdVOqvd5R
         Ql5uHDbaST8UsxmyMlgxvOA383MrTJTtTXoAfxD02hKj2qoP2Ogoy8RgUP7bBMqkwTZC
         cEySTX+mVfnyGE9d4q5qdRPNrL7DugkkaE8afZm9bLL4TA+WKhlrjXqKWoTGglRgLpWt
         0j4QXizK6XOe8/jd7RcRNW5Ts8LwN5E3V/Zc/0aU+nKZDholmmceTg1G7JJVAy0ASTjI
         vp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UMMJCmidmYzIuevLomsRruUoBt3lfZrYvhvRM0z33yE=;
        fh=t6w/N63lYj8KxL8rVZ9Cb2PWxrT4KyU/byPEZA1CoX8=;
        b=EaAGhMRPl6CNlEM+du7owMISEQ394iyFeIHwC4kAe2FDvktZmcI6RXJb7QyiKsgQKo
         XqbCb7/LbyqtgEUBoxdfRO/J9Aho+xekXuYNGsVss7j7tkN5pi8iJq586rxbSpzG4GWV
         qruYUD+OLGxw7ty8qmE9PrqLCNiGVyFBtoTm3gVtv3rNZVvwJ+mlLCfl+tvOiEUAPm2s
         QdFC0a/cw2MsltDo4xhxCTiI5pneZNUyqxu7OO37llZYZRGFuY2NxcYfgBBpeXUcYuDi
         1zgfxCZnv8t/Th1qX6Eyk2iMi09v/nTDE/W9GqhYGi2vxShjIez+wu5RwoIAQjZEkit9
         wQuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794298175; x=1794902975; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UMMJCmidmYzIuevLomsRruUoBt3lfZrYvhvRM0z33yE=;
        b=BzSx3UZn2QKX8oGp5pLdUevF2WXW/RvTPS1SYB7JEqavCeZw88/oFbVkrE1fV9+3sz
         VUCFe2EBOfmbIPKNzTV6XW1X/OBRkVfPQvKTLksrQrgL+QcA0Z1LusL7sGPKNmg+SH0g
         kcG2C9lUGuFMxRzlR08CwwYGa2rcnG22iJ3h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794298175; x=1794902975;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UMMJCmidmYzIuevLomsRruUoBt3lfZrYvhvRM0z33yE=;
        b=2wtD8CQbEJ2EGQu3ijG0fiVJfA4xDkq9AcDmCrzfnk9XSPx4HgdTiy/HCHGuYo+FyG
         fvox8LQ7GG/bQR5sxXIgJlIELn52EBmqIjaoKHOWuq/k7CFJ1haf27sLP/+5MVCSy7Gx
         uekKfvyIkGr8gCuAcDMprXweHGbw2KWtC9kAuOo7czQ2xdogOH9TIRDrzSuE6QPgqYEO
         y4sVEpeNa7W2KxCCZpAsGwkj+/fENVYaM+SnXaTMtgDz9o7D4T0nznoJXXk6Rspfi3p9
         81KJ/Hgr3EKSfJ5MVnMwrI6smUDeRfGADrexm4rnA3CtOxjWx7STdyClpaArY3w8uwjq
         QSNQ==
X-Forwarded-Encrypted: i=1; AL+hErFszDoBcmCwS8WR+zrAK41KumtlDbDWWb6qnLX/ADVx10WIq14pDeFSwRuveI63VvkepY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vC28UMQzDyP3B5Rg5LXDXDTCYQXPRVri4taS7lPqJnCHNQslN
	P1p4V2PpqKCQCiacgKJbg28sEDuqMdWoBJnW4Ma/zIQXoZdWBAyExUBC9xz7LnvJQOjXhiIvbYj
	nE/JeulE7YwqhdZP5P8hj45EtOEUfPbwJKm1lGQGotw==
X-Gm-Gg: AYBFou1owmLc3K0xxEgaNu/se7oEm51oRoAJbLrDA1X23E2gPg5ocDJf4h7XTNcpqTJ
	6h4uuIcJ8aMm2X8BT5oUWksXQxpsdgoEmZ3dJ9BuZB052A4GGcu0mhXCEIHilfuRWDwDH9tkk3V
	JuzQg67MPoLh6sqjZ7fS8n7mXx8BPw2O3aYSHYNlTaEF7A3Cfz8liP03QFmW1jcZ7yyy0KY7DbE
	K/e67ZxNcReLl58sQPv+WBHUqqH1a46ejaYKiEYP2Sd2mC8ETtMRtpzm6tQBdb0UHidHrL6BSKB
	1o9bahGHqhymhlBh8T1001dvrS0tadGrMqaDpcLHCJAEvCbyaaBrGI3bVSDasuQZkh4TJa2MOPw
	3QOJp9jhaBtjgdaRTdjRy+NyZtd93XVp4kr9JWnSQ6e8Wip/0kxz4KAJYviIy
X-Received: by 2002:a17:906:830c:b0:c42:fc8b:6c7a with SMTP id
 a640c23a62f3a-c50496cf8fbmr94691066b.41.1794298175237; Tue, 10 Nov 2026
 00:09:35 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org> <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
 <8733t9z0mi.fsf@gmail.com>
In-Reply-To: <8733t9z0mi.fsf@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 10 Nov 2026 09:09:21 +0100
X-Gm-Features: AclHuK8_WaaRq09y10_HzyV__iplj0l7AayNoGl3dVrUUeUMPfOGLCkUIExUo1k
Message-ID: <CAL71e4PR0KOAE0Q42S08zQbwukw4mM3Mffbekm6mJUAWONnDYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Collin Funk <collin.funk1@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 07:08, Collin Funk <collin.funk1@gmail.com> wrote:
>
> I'm not sure if macOS 'tr' handles multibyte characters. But it might be
> worth checking if they do, and if they keep a fast case for single-byte
> locales. Doing that without duplicating code is quite tricky, which is
> part of the reason why we haven't done it in GNU 'tr' yet (but recent
> releases have improved multi-byte character support for other utilities,
> so hopefully it is handled soon).

Thanks, this was an interesting read (even if it may not solve
the problem at hand).

To answer your question about macOS tr: it does not seem to have a
single-byte fast path.  Apple's tr (text_cmds tr/tr.c) goes
through getwchar()/putwchar() for every byte even with LC_ALL=C,
which is why "genzeros | tr" takes about 2 minutes for 2GB there,
compared to a few seconds with GNU tr.

"yes" is nicely optimized, but without an option to drop the
newlines we would still need to filter its output, and filtering
is exactly what is slow on macOS.  I suppose the primitive I would
ideally want is something like "repeat <string> [<count>]".

In the end portability is the main problem: with tr and printf
behaving this differently across platforms, a tiny test-tool
helper is easier to reason about than any combination of shell
tools.

Thanks,
Kristofer

>
> Collin
>
> [1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/printf.html
> [2] https://github.com/coreutils/coreutils/commit/2b1c059e6a06eebbb721d010b1221ec54200cc33
>
