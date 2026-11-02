Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793638399;
	b=SsKltgdVpPSslQW+r3Kej0fe6BQEJIRJHqxAEVwlnZ3nbCYhhWqCqBcKQ877O7UO4dKB
	 9ps7x5VYXMPz+bmJdLo+FUYyOSkU4me2GCRfEk5Kva0fv48lyYZhuZB8elb2KDWndP5GL
	 pQi7KS39i395EGQ7MwcspI6+NIKw8Wp8ggFIEs4Qo0FkdB15LSf6j4pUnnEv8LrEQ4Nvg
	 wx3AclUJ3H5DIn+z0Wd+UtpMz1dAVw7gxQqN9PM/EoLQNhbl/e8xW31YIFQrIb5Kb6pWu
	 NbpibLIbkHp6jzt3N6g4TP4Lm51TJqtIkPYsTKyx5r0396bp9D/XcZ/CE6nf9rIL9pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=rcRsB4fV8TVlZvyUoNnUPTkt8OHaxqylNr48gFuk46w=;
	b=aVu71LqT4wih8Bf5/KAOmQhj1+iAC24UlNyOqTcEkrO0n1a1GMEagxTjFUvKTo+MFhyY
	 NrMuwMobbc3W+NXJUdT6y45ktHoTKGlAwB3lX5jr8i7pGKNohtoo93Q3xIoPcmDyOf2LZ
	 v/6P6t1xb07uGMt3i5oO4RCIaV+wU2Mn95zUQ/6R3Q8e7U1Rq0HKHkOY6sx5zzDObae2W
	 pVfgnOVtWaD7IkRWwZvhA1Iiwjwb6aYZHVpcfjIKo6+9T2CYpND9yxNlEPxneVEooksZ6
	 Zr9mXPFvyr7UJVLrPMiwWmmnfe0A1lVzVVPmvPRMcpSrdC2W6gW/4oWSc3L9t6Hv9dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8hqDmWk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CE606E010
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09CE606E010
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8hqDmWk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1380188a12.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 08:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793638398; cv=none;
        d=google.com; s=arc-20260327;
        b=Ez1Ve2PCqGmf7gFzbJjTe8wHD3S2/6lNlBuQtxtEncumfe+OnzBmra1arOP2+htY5L
         /oQnmM31XuHrHup4smudIp6NiN3u2ZqBIJl7wGDnsUK+MGipBJ5xUKT/erkjaLHICuBw
         DZa8QDtE9fP8U54vmk5Q+81BtgYH27atD3+gTLr3JvXgb7YsHVKoYiigKl1WO/MKLz9q
         OyEX05/EcYqUI5Y+QB7wHqZi141K96FHx6/9JzopXmlQiFc90LECHgAh3UUb1NmeC0H5
         950SAiCP6y9aQ8XSVD/QdyF2N+WeOhVzHvmj4t+Rp+kHOa3BwoOPFzQvTaFG34//IKMC
         XKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=rcRsB4fV8TVlZvyUoNnUPTkt8OHaxqylNr48gFuk46w=;
        fh=m3Zu5e9VUKr7+m4AYJ0/GHwqVgYh+wXrH7VwcIbju28=;
        b=B0+gWWdjrcRb9617t8BDyQ5EvrxAyP6jCHnL6zBDUOYWB5jbPH8mn7BRXekQV8HpZ+
         9X7dVEvCJfNaz/QD+hkI4pDJKu9XIAZ3TYvKRJ+pay8qMK/ZW3tkLqb79AZCnStrCLa3
         CsW3jRARn3+mEXNhFnwn8wDJy+KB9G+ILerB6wHgrv2QOEKDlU9LmtsXRLMwV1f+6NgC
         AYXxinuheUwI6fOzUHnkN4JQioXqgrcXR61DQpBuq1t9WTHKbRlydSs/lGlEeYrR5HaP
         qSZJ/I/brAWHB3BK/8nETBhPp84xKArDCYXwjOj3Yj0Y/waU+JXVlILO4gDdmDg7FwdK
         Drwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638398; x=1794243198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcRsB4fV8TVlZvyUoNnUPTkt8OHaxqylNr48gFuk46w=;
        b=P8hqDmWk9kBftvA5cAJ7RiXcrh0+Y76O+cZ7qZQ7cOOZndsKtQGe+1T/+YE6ZLIYSE
         +tOynx0vA8APziuI2EPfT2uvduIWL2N1YQil9u+6jod+oHoysRXwbPgNJIMfHamH3DbG
         aUDBCS/PTAL0qnQFmgTxjAtsd3RySAmvsvPA8G0r6VotgGsnIcWmfVKeDkhqbN0JknsA
         mgXamZMiUf0UStrv6dzS+hOMpjB68dcS6+q3STThpcVXoGdYWldVUaC3piWtZPL+8WMx
         q8e1qeqNngMRKEIjcKy0B2SbWIbQ122GWFYbTW7ndRqgmkxrPiweaaQzg4DJsBLq2aEp
         6VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638398; x=1794243198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rcRsB4fV8TVlZvyUoNnUPTkt8OHaxqylNr48gFuk46w=;
        b=evdkuaKiZlYo5ubHzgunGaSnCbq09Gdc46L/P+oDVaOH74C5Uor0vy4onfneAjmmho
         NDCpoQu/F8ylFuPO4quPQZxE6o9PW307KJRQQ1RwDXwn4m+m0KXqPClVAzp3azNaeLko
         YEliqZIOZuSwx94c91M/mRYAkeOyEuvEPTNmD+XM7fLGyOBkf1Ib+1e7Sa269vDrnbmz
         TAG29X5VEktcsMIWKt/KyWvlZmCU+Q80ezvsW2GxwhD3an9ta0qmT3Yq3K4zUFsKMLv8
         +hF/wyg/xmnVBCcDQ6ac4ZJP931/DtQPIn6i7BKtl56r4b/5XnFw1ngunjdcTWP4BoeC
         B2kQ==
X-Gm-Message-State: AFq9FYJ5viJZzRaWtwUyi5R93a2JyU0Y0sZeFirdoAjrv9pKNAmuf7Tx
	T6VPlak87h3he4eFB/+oud0EeHJyJvcKUQK2rS6SWHABsk0pMdrDyvyDe7q9/hxVefNJpXY23hT
	+mQ0dnysuc33rd9rKhhKgRJ24YQA9J7zUoXFW
X-Gm-Gg: AYBFou3NKDvX2T5w7MHV1gRk4d0QVNozONupAmFqJz7us02MCDPGFvLUrp4P5U4+t7M
	NyoVktJqVQJ6YADzrX5lH/qw0Y3GdmYgykVO/lueShatelj9jviA1bNUqHYSXSZ0FDK1puiG7Pg
	D72q54rllccmHj8bRWUBPss7FemDA/J2PE4EmDe3qcQt2ZIVHGUYC/nbp33JZKCQqy/E9oMJl/Z
	Y4CWCoCKbGEZLW3fwpkzh3sPWk/QVZfTOiPtUKAJUuz85uAu+GgAbO1RR6V8fHk+BcE9wQsn6hH
	dFPtA4PvsattdK79oSTuBx/STOdJ3lnZ3p1wVp9sbwvH8WgjDmTO0Vadz53ZqdZnPXsG8oJi4hv
	kOWrCHXd0EF+pnaPv5/4b7Q+P33LSnIxLF9qVBFM584bOupD6jG6XrVzfaC3fCCyxICC1ZDvylk
	SsiMBkI0UusA2BZ7jerzVqaLvoIwgwXfJsHvDruwmJHS/iCHnwcAK5tdJVmhjguDOZyN6i1J1YW
	hMl0/3T183TloZobAO+UkXD
X-Received: by 2002:a05:701b:42c3:20b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b2366ae854mr3166706c88.32.1793638397973; Mon, 02 Nov 2026
 08:53:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Nov 2026 17:53:04 +0100
X-Gm-Features: AclHuK92V1x0i2Zmg8rxlGmNYNklD0TM7RNo0NryayP_5pJR5ZA0FKuG1z50s04
Message-ID: <CAP8UFD1oXnQPnQRXB52HQzgv8mq0UjxTzxXA8Z21sM18PZbmgg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 140
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Aleksei Sviridkin <f@lex.la>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Thomas Bachem <mail@thomasbachem.com>, Weijie Yuan <wy@wyuan.org>, 
	Tyler Cipriani <tyler@tylercipriani.com>, Pablo <pabloosabaterr@gmail.com>, 
	Jack Lot <jack@themoderncoder.com>, Okhuomon Ajayi <okhuomonajayi54@gmail.com>, 
	Spencer Uresk <suresk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 140th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/10/31/edition-140/

Thanks a lot to Pablo Sabater, Okhuomon Ajayi, Bj=C3=B6rn Fock, =C5=A0t=C4=
=9Bp=C3=A1n
N=C4=9Bmec, FluxGit, Jack Lot and Spencer Uresk who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/880
