Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8336C589
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727121; cv=pass; b=NTrO3nhlhav4zY93aahqkn++l1BZIXYVwtWwNUvmH+Do3mRCeWZbjgL5AhiJPvTjWuDPcfabZRsYA0kJ3F3oGbKxtJfnLqOcExYjh1gsWxJ9G2l0UO0MDkBIR4vmjX+qsM7ssU7TtH+4MMJmk0i9mW4LmxWW+k3+NSJ3adxSkcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727121; c=relaxed/simple;
	bh=Vu0yVpryIyrjXJKAVw7duBQsQgp9DlAtmL0EOVuYi58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=slNYhlQm96ERACrYhR6u2TkTpjdUiPt8AJzy+dPAL9S/Rmf5Kcy/wnbEjwTgO7fG9qMC2tYhApJjy0FP1CsJH8V3oQE4wudrUlGimCL0eWEO4xFYuZ5Fku2RXveQVELNjzyQHP8U0fpwe2FI5GSnnpxaWdy4rn8HhiWCfu3kxGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va4nUYMB; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va4nUYMB"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b78c97f57bso3470eec.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 14:51:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769727112; cv=none;
        d=google.com; s=arc-20240605;
        b=EHXKeWxaYuVuMgczPI6JCIAPKRqmqE95YhTHlRbb8AYwS/Kcua51anOx3RzSD97uZJ
         PjRvkwec8iMAKKPEaKMw4gno8iDyalbr3fGFWf1CKVxkE0xko0tRKTPMMBhhI5500u7A
         9qlgrx/ln1fpdID3psrb0AAZTcSzSMxKmTWY0o5BH6pY82Xx5j6ZeLKMTkDrqlFWpVfJ
         Xz8vv8s+JMQ2FBGm7Wg/r7wLW6i1W1uTniXSUQ32XAreSR6hlTjNMZ8d5dL80us1Lst+
         MPPTR1Z6F9sRGg6Bi0UrZ/ijGFnwiiGhsGzVnplv50hLIngHQ96FIodrx1lpBTtEub5t
         ldTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MICH0bCitSmnUDXmr7qdTPONHDsPHYTh1diEmeYkGc=;
        fh=tBMWfE6Fzf7O+L/hAP7buJOUjzKHzkr5BVcA4G7LalM=;
        b=dh33e5vSt7jq9hVp+2cjWED95Jq39S5bc2ePZUQJW8IoVQauZqRzE5E7GR6nYSm9mN
         Vxom8eP4YWHZDHjqB4RR4w1TCkQ2batrmC65fPx4LjEhpMN9BaxPOKmr0uztbqw2oeFF
         VJmkR5WXA3gns/vB0rJ+FFZm0bgek7o08HQ3eVZWQk7IcXh/+OVvrVvvNVsB32l8bfRz
         0dtjZhq2HF7Hi68SvENO72nhp99cbnmFunq+jd3p4A7BzZuN7nfyED+/zDUKvL924+B1
         +nlywRtBCVksJ1qj980MDUiXxANKfrOMihweWgZDYDyB5uj7HVCc2XyXW4W6iMOhE0Up
         RQYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769727112; x=1770331912; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MICH0bCitSmnUDXmr7qdTPONHDsPHYTh1diEmeYkGc=;
        b=Va4nUYMBqpOoVvoqaYZdmQX3M8L8UZLzImA6/m6EqU4xBjqCEu5sKZoz8XP7IG+Nwm
         M1WNEkzygNpvaw8eojZ0+bKTUD8mVc9BzCgYtmW3hxte7T9VSKo+LzMSV3DkljzBHc2e
         5QcVMMzgq/NEZwMblPVOQt4mF0BAxBd5wmD//YCwoWVHrbRZBg/TcrOWXqYntz2+wbUU
         aBtE7Dl/4YDT1CDD42OpIl39Crr5iwgXbOJ08UZr3GrxpNa1bRyVtmpekylVSUdY2R/u
         95Khg/0a4m+THRMz+Yd46y+uyu5YfWSx0AyYudtaj3Hyj6wjuswW+V6jc1VVs4SDRYVw
         a3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769727112; x=1770331912;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MICH0bCitSmnUDXmr7qdTPONHDsPHYTh1diEmeYkGc=;
        b=EUud4aeK0YMxkL2kDUX7VxG28REMu5NIt9tcHdD1OYpLa3NoSEIqxxE0G/g7YuGXzQ
         WYl9lrF0bIrSFtAw0yx1nib4SKZfuDc0+1VCUXN2KwrPZUeDV3m8lReRAFERKkouAzc7
         9xONTv8atbMLu8E40xNLwOtGiWLgvQPnQlrRHV1wXJyMrFRxksI9x7APkg334ewZQhIH
         /IrP0PGEFF4JlfRz77BGpOftu3mliCRADGQRY3IAj1zc9cP/7lsDrwSQD02rA5rAkv4Z
         zBUQkRXSKOBrTMKTKmbArK0AVDvOzc9V1P+jEZL9ijd8nHxd96eCR5tqZMRNgYN/iKoV
         yh9A==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZyAHM5s6AbQJXjBpZlMQbO1eTzI4+UX2WGu7HrgI21nPA3aMNjn7X2WPnMf+ZmzQiP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4ww6pZr8wPWnNUwsrzhn/hBrvopzGMvJ7F8lqsO+ATevFKSX
	aR1jzZIJHLpdJ2z7nAczVSqMO7kiGcu+p0DLGbPg7JEEzqi1RdcjxIWznebmYaPfMFX2fxDToc/
	jcECdQXd6piCGTW2attJdLmCpoWMMXNQT5+js4xI=
X-Gm-Gg: AZuq6aJUezewSDyFQK2V1YyUWVMGgXvPDXvIZ43XencySPHnKO/SB3vSezK81d5JsK0
	htGjGth+xQJZUw8ySkgJ1x8RYLNVOzEcirtfvbtaB1MpuCU3jFRqqxS6ckc3ghUMbhGuHiyj9Gn
	Y3+Nt1AK4yRN+tHeO0EKUksHkMh4xkNRpLzybxZPv7eoIG/wO4knY9KEh7/nfo2e9oCtuZ+NYSq
	jPAxKFT84QHJV360d/k6CDpFeoxj8OM/IZRsKgt8sXHLw5z5s70gwpa+0oNOSwjrFpzzKAzQw==
X-Received: by 2002:a05:7301:7c01:b0:2b7:2d5e:3f3a with SMTP id
 5a478bee46e88-2b7c852316amr290732eec.0.1769727111951; Thu, 29 Jan 2026
 14:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqecnbeyvr.fsf@gitster.g> <aXqSyn3Mfcgs8MUG@fruit.crustytoothpaste.net>
 <aXvYnCsXPV0yefyD@fruit.crustytoothpaste.net>
In-Reply-To: <aXvYnCsXPV0yefyD@fruit.crustytoothpaste.net>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Thu, 29 Jan 2026 17:51:40 -0500
X-Gm-Features: AZwV_QiyB190Zlb6nYms_32EJCXQIjtazTDZJGMHByVlXDlIJrIwwl9WgaGxiXM
Message-ID: <CAPig+cStjN15WEKSN3b5VGLK-+N5pzj-dUDQ2rm15ne_9Q07FQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #09)
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 5:01=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2026-01-28 at 22:50:50, brian m. carlson wrote:
> > On 2026-01-27 at 17:42:00, Junio C Hamano wrote:
> > > * bc/sha1-256-interop-02 (2025-11-17) 15 commits
> > >
> > >  The code to maintain mapping between object names in multiple hash
> > >  functions is being added, written in Rust.
> > >
> > >  Any progress on CI breakages???
> >
> > Not yet, but I hope to spend some time on that this week or early next.
> > I now have some more time to work on this at work and I can try to poke
> > around and figure out what might be wrong, or at least try to beg a
> > colleague to try things on their Windows VM.
>
> I did not get a Windows VM working but I did discover the problem and
> I'm working on a patch and will send it out once I have CI green.
>
> The problem is roughly that both the MSVC linker and MSYS linker are
> both called link.exe.  When compiling with Rust against MSVC, the MSVC
> linker must be used, but the MSYS linker is first in PATH (because I
> believe installing the Git for Windows SDK causes that to be the case),
> causing build.rs to fail to compile.

Didn't Ezekiel already tackle[*] this problem or am I misunderstanding?

[*]: https://lore.kernel.org/git/CAPig+cSBEX5QGnzpBnVs_hKM2iUqcmA4-DzKDgkwp=
G9ZzWZ__w@mail.gmail.com/
