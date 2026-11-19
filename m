Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068329;
	b=po927FlpDC4HhcA6He5EiDtu+F3irjvQxgafqLOf3m2LLga6BTioF94Byn9G8zVtqpf4
	 n5+YbYzlSVZ1SMzNjieaGemnXg5T/pLSF9GPpU1/2Qx3v9DGkjSkLrCGXIgsEcLHw11rw
	 E46LGO5I5ZXHp9RnaksWhL7t/P63xMDrhPC1g2Y/JzayrFOpiAbQelaKhbybTFJhgM5Bs
	 RAteKTzKmnls4HhnsPHwJg/I7L+Tls1eVQrHyCki9NjToqz8hCWSMSvmIrh//1qp5Oako
	 qToEw3VTktECPbQjzu189H7QVk3kti9lHH2dYmunQmrCLf7OvpAzE/4O84Ktz1vwEoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/inu8OsX4xEYu4Iq2Leu9KwcA6CJsx4aVlEauQ+h+Bs=;
	b=fg9O/2f6m7NxR2EQllcU04Eb6641YVw/upgMXY9ridQgp4pEZcsWKgNWrwhp4vI7lkGZ
	 sybsry6L0JMAt/vvdgi8Ql4GMgyQqhg/4cfXVg9s3FF/ek1SpFSrpMQkp3jYUnKuVeCg1
	 m0NpcWLEda0ovHE+devVh7QbXm00rPeNFjjhpQbfzWDeeW+bfapYALYyN/hxv+PCp6Eqx
	 GiiukCeX8Xjuy8S2efcHPlk0CK0Em/sxqU2TpO8frOkjqapxwf4IHY7y1CCek70d+O8im
	 TridFE+jeXAul3MwKyJkLg2UkLABGdgK1EPKqsmJV/m2tHmx6pkzAK8aZrBdOrm62gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWaKPoJL;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E10606A326
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E10606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWaKPoJL
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso17999185e9.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795068327; x=1795673127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/inu8OsX4xEYu4Iq2Leu9KwcA6CJsx4aVlEauQ+h+Bs=;
        b=rWaKPoJLhlDXhi67XfCIwGwTIMaP/lyih3VU/KvTTmfY6etQYGRUb2Qwp04yVcs0kn
         WBZ3uMrozfjW1L6rnyBILQedRSvy9Vn3OjPn4crFC90TNIJLnQwYMj/b91R60887Ctph
         3sJcOaWtcfY3ZlTqHPyUdzj8KLlLrbKyGR9RMT65DO6Kwd34sNL4LuqW6vNEUQcactQE
         gY2sdvuuajCeRdYyGmK2wXMqHpNUXfoD4wcMbtGVo1ipPR2ct82aUveOLybZ/xDbrCH0
         VATFUPsyp7TDicdHEf/LvQ2lC3qYp78Oo82a/oYI8HBdFsTtKTrHBHUfN8Ued30L7jaO
         5Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795068327; x=1795673127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/inu8OsX4xEYu4Iq2Leu9KwcA6CJsx4aVlEauQ+h+Bs=;
        b=TBetnZLXD8OBZhWdE3/qsCuGuzbmGXR75Fs15MHu66GyJoe48aGfxjiBErYhXn1yfY
         KJxGDHr21h77QhrK1QpqgRoezMG+UP4WRJWQj5Fy5puZM7NCnzfjpzRfxD6I+rF66iWd
         RN6xH5rHgvgb0vAbkpBDfHJA/yUVElPaYsB20+3firLth3JPq6dOL9CxjF+lstuhPJjx
         kmJLqcN0PhBI1tfsaI4VHRex++ougCR1Yg5wYyo1EhA25HOheRT635DQc1/ZZRkvJrHF
         EncHUP9poFBmCpbB9ZH8I8qQaKaLAWfxBT/agxEm8cNqQWAyUl3lcNjEOmdbrV1KsgIi
         p4ow==
X-Gm-Message-State: APuU4Z/zu1bVAtiabNqPxILe/uxOtYtTWcaqhO7wLze4PVgMG5ugil/S
	Zh3301kmG1aNyI49bR9Z9ZYlqtjDJ4GkOGYkN5Pi4ARLHiPBsjVSSsqQ5u/5gg==
X-Gm-Gg: AYBFou3KItCb3SU5yALAj+2rxKevAbAFQ7j1yH48UYBgm+dHfxHexuDIiflkBATUner
	wFo3HVFhNwTbn/5sVCZdbTiAJmLsHf4VgQMz+/hYLDp6mHpnbTRtmhEYog6/BkWCOIs5VpT+YXP
	sLAzUxt/Bw1e8mlo1gfZraw2LO7UXKnQpxEdXFkC17xqh0C4YlcrH7oPrDLcuRgKKJ1z7PdeiR2
	+ZmVXkqsMMb8UdgoXTYeUcrJsFtgsOnc43gTYwtYM/zuvewQQPkqbGAJ8uzrwFoMPvipqRzJVUK
	jzLhXMTnDljjnbO6I+U7X+HqIm8UFnxiaw8F473hrTDkZwk+Zcu9hqMnvQZGnAske9xj5rPPcKm
	I6WjA4oAkH1iWAPyw6+VS48Jm3IeuLshRBem8Lxj8KyCYax9fPb9EsLZu2St/9+hEMY4BdTUpr+
	RWx02trMcI4NX4a9clSXgcP/mz9ZpqEX69Lc1GQqQpUYbRejseF6QcLdV3cAgqY2P4Ky21foe9C
	1wunrYlnLJoN6SdbkYNu/P7WrEnyBc01FoqNL/k9EULq771xM/hBxPgMuJMgV7TOX+CTeQvAV7J
	tochhT3QlAsIrJQn9ctyyvZDOSCNMWG/55gJxqmEfUE6u80WLebd3DIKqa4Jv8o=
X-Received: by 2002:a05:600c:b99:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4bb7da25163mr92185635e9.16.1795068327138;
        Wed, 18 Nov 2026 22:05:27 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6570dcdddsm8006902f8f.54.2026.11.18.22.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:05:26 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristofer Karlsson <krka@spotify.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/4] unpack-objects: use size_t for object sizes
Date: Thu, 19 Nov 2026 07:05:21 +0100
Message-ID: <20261119060524.775205-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <av2pBh7vLj5DVDha@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com> <b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com> <av2pBh7vLj5DVDha@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 02:33:12PM +0100, Patrick Steinhardt wrote:
> Phew, this commit message really is extremely verbose, and I eventually
> lost steam reading through it halfways.
[...]
> So overall I bet that this message
> could be condensed to half or even a third of its size without losing
> much information.

Fair enough. I will cut it down to what the diff does not show: why
the cast moves to write_object() and what changes for the user.

> These casts here make me a bit unhappy, as you also have a patch series
> in flight that fix `odb_write_object()`. So you'll have to send another
> patch series after both have landed to remove those again.
>
> Would it make more sense to defer this series here until the other one
> lands?

Yes. odb_write_object() is changed by "use size_t for a few more
object and buffer sizes" [1], and parse_object_buffer() and
fsck_object() by "use size_t when parsing and checking objects" [2].
Once both are in, write_object() can pass the size on without a cast.

4/4 depends on [2] as well (see my reply there), so I will hold back
1/4 and 4/4 and resend them on top of [1] and [2]. 2/4 and 3/4 depend
on neither: 2/4 fixes a bug on all platforms, 3/4 a false "SHA1
COLLISION FOUND". Unless you or Junio prefer otherwise, I will send
those two on their own as v3, with your comments on 2/4 addressed.

[1] https://lore.kernel.org/git/cover.1793439137.git.gitter.spiros@gmail.com/
[2] https://lore.kernel.org/git/cover.1793444420.git.gitter.spiros@gmail.com/

Thanks,
Elia
