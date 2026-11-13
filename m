Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580116;
	b=IRYV2LEPQhggl1NKA/sq7QSrlQVzGZ6ws6i9tyY9i/IZDvh1f0WyHyT8QiGWCTn1Pf4S
	 d/lz9Roobaxj2umZwE6RoUSMrj4CPNHT4kmailhAJrVM7iANTNz+rICTUmuuDIyhLYGNu
	 US/JSqRfEH8GcL0E4iMZmu/pClOFfBD+19x7Z2I0ejszzVHPB7Gf66x5/Qn1W0123dG3l
	 1/IGTAwZUIF1FstDWwwOvri7ftkVEsW3QQ6S9g2DbaJ1l6zU6VBUGNB+31/nj3P6ujcVA
	 gPk+Tsr+db3RMMyjaZH8B+zFrGIi1P1pk321HfMXcJX2LqBXkdNqkIpHYZFqdsABnnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SNXC2lhkCoxQLHHKj2cPy9hCrSbktv/QxF49fwHbnss=;
	b=bcN9Mj7yMaXCsXDqWOwyyZgsmWPjm3Kbc0bNxOeGxVtfyivtyZ2L9eqXu+gorSOsQGXM
	 uBVhuR00hCina8Go7aM5wPiMkjumB8KnDp8wye+UFqNTPJp9K2JzQ20HEpEUUd3wzDWN5
	 UHXQh9TvUBpa915CHbQO7ooOGLG1d3WHV1Q+MUEENsgLyx5rnlAOnxx/uKwKR4D//7gYo
	 n5QyTL7hnQOzBmKONjRSO9ToJXUw6Bk3k7rFasF15UEKNIA+Q8CjJ9HHmQzFTKUJTyX2Q
	 SSSb7O6fBwAjxEKrqOw8I1mXPgEYTMEJccaCvvu92icHpKzlZjJv+nCSN+YgY1cGwBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXgqUh+m;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC321606A327
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC321606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXgqUh+m
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso9711475e9.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580114; x=1795184914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNXC2lhkCoxQLHHKj2cPy9hCrSbktv/QxF49fwHbnss=;
        b=tXgqUh+mkYX571h28UrSodom34SEvSBir93b9Ubl+THl+WbhJqdjLdbYdoZEGyxkOU
         7Wd7Fjdx3LFm5MNHylhft0mgNl9nKk/jQC7Jc1fTBZhT8HOxZZFuib/KylTSdD/BKpxi
         cZD/HSps1nJ4ufBAGS0L1pbP0akNTxo1rlJs9BIo+XHoL5QU15l6nwR7dv0GZTua5DAt
         WjXITJ0gX+7ZyP828TRlfUvzIj3FHcYICQs4wzfeyRZUAcLwbKgYyMEHW6VqCns95B0A
         eskOLy/DM1nFwpdKfNm5SG5TfAbhR2iKnXjL/okXJexnUGHKmbrpZo3P6GuNAEnPNp/p
         +5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580114; x=1795184914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNXC2lhkCoxQLHHKj2cPy9hCrSbktv/QxF49fwHbnss=;
        b=WRbGGACRD2I4kkweWoG/FDjMWicTgppMqckoSc7cnkCYvMT9Z93+cJzkfLGp0M4dFO
         3xSV/jy6o7FY/7TRvuf7dtJHguVP/g9hXSplqsrdjgfEYBKMYmndgwb5G4oU6nCr0VR2
         dtTf0uisBkvmzsCkamB3/LAfi50NmcoVRX90WxqV8DJgDbCIICdgAZ2V0al3IcFDPJVy
         DkOEtuuOcOxB5d7Al7aM7jguI/rrXmNRvQOcAC4JashZRbuhAjwm5vL5d4hQxxR1Kc5S
         CSaOCqZtplQC26K9FQKW6eziThkSAKhj+7SvBtiudhgc/KnyEEUAr4ylM9mNx7jMi84x
         XrlA==
X-Gm-Message-State: APuU4Z+qnWT7LInmQ/jdSuCW4yHJuSWITuLTrU3tVTsC2nUhYQp2IU8l
	4pILJcrdp1FkiyTw5iYuBrrBSpYLBWX4Tn4LyUWEvNUPFVs/arJ2kkYE8uayNZWQXY4=
X-Gm-Gg: AYBFou2EdFpoNphAlSt4ch2xMwEZcw1I5KhP1iA4vuBfZHJcNZxNBoqeYoOWHVclb4p
	E8S9YECQIIwFNmM5fu8mtMQNt+Iaz0lX/sVT7GoBjWxkwq/2lB0LPnIX+zcx4RMT/yrBZsoSgbz
	58x/MqD3t7I0TtkHjRl+hs6q0OJDQkwhafobnoFco+enfFLBSg6KQhFfbVkg+W5EyOlBKC4C11Y
	05/FML2U6DmWq5Vj3OqsnXVJZ13QPlG+IensNn1xms/Eg94DRk+/WC4r0TJ64V8s4QV+RXSBEG+
	lYbfAPqaE3MmrxmUVwFvwRPeBXRw5WlOm7EvRSodWynC8fgW8yeY/3r/8bTjOsRHylQXngHUPX8
	x3BS9ZBC6WH3bIfod+fSPmPO4BGTmNdy9dgJvrsuV6iPmN6Kvyag7MgIQjXK/z9yUXOIoGsASkv
	rCDBTbj4fbYzaE6xw32PoADYVXO1abMpY6381+PSHR6gOMzhNEHEj4ToA40oD9NIhVZQr6Isl4j
	ehCtwnbqhZtd+50qcB791kkccTeorLEiWl0XjDz8dRi5vS8ssn93teG9X4YF5gEq8W3eNO87ApN
	+hcIKAhKHq+Jh1FAauDHIRFXNfawJvHJtyW6PG4j7UVOoerWyeirepplAUcfI91mScl0ByQOsi0
	fPmoqAw+IDa4nAGYL9QIh4rflMoNTFq4=
X-Received: by 2002:a05:600c:1f96:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4bb55a4d2b5mr58576015e9.14.1794580113688;
        Fri, 13 Nov 2026 06:28:33 -0800 (PST)
Received: from KURSA (ipservice-092-208-105-158.092.208.pools.vodafone-ip.de. [92.208.105.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm60033285e9.4.2026.11.13.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:28:32 -0800 (PST)
From: Caspar Duregger <caspar.duregger@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Caspar Duregger <caspar.duregger@gmail.com>
Subject: [PATCH 0/4] cat-file: do not die on reflog entries out of range
Date: Fri, 13 Nov 2026 15:28:00 +0100
Message-ID: <20261113142804.7465-1-caspar.duregger@gmail.com>
X-Mailer: git-send-email 2.56.1.windows.1
In-Reply-To: <20260212040708.GA1894049@coredump.intra.peff.net>
References: <20260212040708.GA1894049@coredump.intra.peff.net>
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

Hi,

I necropost with a patch as I stumbled on this the other day.

I have one "git cat-file --batch-check" process per worktree, but it
dies on "ref@{N}" past the end of the reflog. I work around by using
the old "git rev-parse" for these but it's sad.

Passing GET_OID_GENTLY from cat-file is the obvious fix, but on its
own it would change answers, not only failures:

 - "ref@{N}" for a reflog with N entries and "ref@{<old date>}"
   resolve today, but fail with GET_OID_GENTLY (patch 2, which picks
   up a review question from the series that added the flag [1]);

 - "ref@{999999}^{tree}" would resolve to the current value of the
   ref instead of dying, because after the peel fails get_oid_basic()
   reads "999999}^{tree}" as an approxidate. The same bug already
   makes "git rev-parse --verify 'HEAD@{1}^{blob}'" print a commit
   (patch 1);

 - an emptied reflog still dies inside read_ref_at() (patch 3).

Patch 4 then flips the flag in cat-file. As Peff noted, this does not
make batch lookups die-free: "HEAD@{999999}~1" and "@{upstream}" on a
detached HEAD still die. The former needs get_parent() and
get_nth_ancestor() to pass flags down, which I left for a separate
series.


[1] https://lore.kernel.org/git/xmqqa5745ttw.fsf@gitster.g/

Caspar Duregger (4):
  object-name: do not read a peel suffix as a reflog selector
  object-name: let GET_OID_GENTLY affect only failing lookups
  refs: let read_ref_at() fail gently on an empty reflog
  cat-file: report out-of-range reflog entries as missing

 builtin/cat-file.c         |  1 +
 object-name.c              | 28 +++++++++++++++++++---------
 refs.c                     |  2 ++
 refs.h                     |  4 ++++
 t/t1006-cat-file.sh        | 35 +++++++++++++++++++++++++++++++++++
 t/t1508-at-combinations.sh |  4 ++++
 t/t3903-stash.sh           | 17 +++++++++++++++++
 7 files changed, 82 insertions(+), 9 deletions(-)

-- 
2.56.1.windows.1

