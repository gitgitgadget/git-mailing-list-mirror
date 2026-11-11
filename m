Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794385848;
	b=YMLj83MQ7lv6MglopFOyk0oSKsVMXfXxSYvF7abOQT8mQpPeWRO/hiofhU9hlR3udiNW
	 G54js0gHP6KVjQ8eAebiVlqW0Ea4DcgXu7hDPH5H1aBn9ET885oPjnnttUSpgl0czz8w+
	 2zQ4TztdNLQ2alC1F+ljdLzmNkfThpyL9XS5auMC+jEeol7fldQKL8G/qDacymZfQJKhZ
	 vYXSufKP9oRS46tmZDVy1ISH3lTc6evkBoRYl80oY/Acz2+Agk9A2UwsIOer6nrx1/RPw
	 ziwwyGdH9pbhvZM5xJT5W/Tqajs9xPv5ilNtcLWCi1ed30s/muqynjs4W19I4xQA2cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=yZTAxEPKe9Rha3XWGESptwzDvJpTy81hHTxitXvlpMI=;
	b=N3QkzLslsCHBrbIcBZFLiHsgKEAFbtoERA5lN1r4yWypm/gNV1YPE9w8IuZio9qXZP7d
	 KfVvkyXIlBQkRsf1iJINiW4thKohlnERhPw1busUpdAFsNlNC0+wFUrqMbNjkCYbReMvv
	 Pg6edQB5JaKY8ZC9s55dixcv7g0ie+OErDlDHwygvmgCZsAuvCIeCxT0g62NWA3d8RK6s
	 SXuMKzZJjAqz6KMN3cMGns4zHP948fDGOSely+Nfr7yXQ6sJtHAXpwkiJ8m9lgHAEbIHl
	 nX2qQKo6Jpn2AAVI+gCP3mmKIhoeL5Ko3Yr9YbGnTPfsoD0rKl5tic73koUs+0UmaVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLyIDtGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA760A2604
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4AA760A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLyIDtGa
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d581da0aaso314076566b.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 00:30:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794385846; cv=none;
        d=google.com; s=arc-20260327;
        b=ibWy1VHWLFF9hNlqJYci+10bt5RtGJfukSc12q+AUlqB6rXnItYPteTQRZSWbMmM5L
         l9tGVcfwqaZiMNYxcHExqENqypuvcuTH4jGhlxeeuusVGal+sJAdCJ1PK7qgcOVsQ2s1
         xX9wRXizTm8hA8IZ0IYO3KCazBo/MSS0KiHnzmAc4pRSj+nTU1srZdrsCty9pY+KXnCi
         fYoqhwA+ONHNqHZGIanCdAdvPEEC4kWpWswjIhwnBROH26oK3RLUOvDaZQB9HmDUeL71
         hZ8XOePuA25y05K1gFWjYjvQUEF3R7o7yh9Z1yxakdCrmC4HP+0Hj35Zn7BVUjh1QJDz
         vS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yZTAxEPKe9Rha3XWGESptwzDvJpTy81hHTxitXvlpMI=;
        fh=xqC2nusd1rEH+KewYqXmqwNibkcpekpkeTfF9sjE1tw=;
        b=iPALApx5btRJ2Pmg9+myZ77d3O8B6jnxEd1g1iNPbZOb24FZnX0nWddu/nLRztzpH4
         L20UCVmhhb36H4CbSQvpOqcmoFQ1uTltMMzk2bZI5iXseaCaX/Sa7QraJGNQDyKq7KEp
         oaChJQjzLn099EAp3BFpVRty4Lllx+LKJ1VJ+5/C1QYF0aAVcyxhpv60s1M3CqeRj48N
         Zej2ir90PMyyxp6uPVxn2zL3PmFDJCwFoHdKDi9O3NRN3cGgawQ9QO7rjN/qqG+LZvKD
         lJOYX2ymaIpKtNJmyF9XosBVTFLsPMZSSCNS1fgnpdczT2yXTn9LLb5SsTI55cTOoeJL
         4WFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385846; x=1794990646; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZTAxEPKe9Rha3XWGESptwzDvJpTy81hHTxitXvlpMI=;
        b=zLyIDtGao6uLaqLQcBkiXPcaI4NEkyUUL9FDRWCcy3eXyb5Gmr6zS8hrCsNGL6SLvu
         QWPjD0/BGPJjfDOQGio1P2Jkeg5cU+9HHcTPyyviZ7vbnzq02tU66gNXgZ9rOHbY3exb
         lVUY50CC8cRm/fdxEXGnBzqEqvhrLWj2jpyX7eOT1xkNlRZZwgB9WQgDos+KxBKIqPnj
         ZeweLKWuvrUb876Oy1bon3NjuPVqcaOjPNgyFw8F18eLhbk6VCXlGN2jC6pvUBeiY1zI
         ekyJwhMIYjEas1kpko8a/LrlTemv0on89zl2jGGmtUqChXDIGoQY/XpXg0FezVZOY1qB
         P9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385846; x=1794990646;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yZTAxEPKe9Rha3XWGESptwzDvJpTy81hHTxitXvlpMI=;
        b=vykC+HMWLsBgx/C8mibl33sp4LHDxkkucEXB3YKwH061KpowUx/Pu0ZeY8L4DU0VQt
         ZM2MYgaNfo9enh+DEP1UKN9r9+aurYDbnb6F+gBK9GvFzqYCG8P7XmrKFid/vK2ahKzr
         8JjjCepKwl8+dCS+dAAQz3Z5/7r3VQ2w/OzTBtto29iOrYwc8jEiSt2LcYgGpEgqw/7N
         4Ld+khQah2iSnC4vQiPkFpyXK6qCqAkuo/JDP0p8cBaMgBHSQLPHzKpcoGrVeSNXsGqj
         LaopJEdtXZ3ZtWKpQV9NUZ61yVX/kHszgpE5SZs2KejNhozXaqEwhYbCOhKyY2GcM262
         4v7g==
X-Gm-Message-State: APuU4Z9W9HW1AOue3MlFcAG9T6kpgovwkGQUj8MiTiECwO5d/fI/uvbG
	fNZWZ5Ttyv+Nwlchh6tp0ftR6DQqhuR5jByJG8ADQhZp5pyeoBG40R9Ngr5ezaip1MCAJvg2w/d
	QrvSu2qgf+Bpmv2RGFNWHgs6gApe1fxQ=
X-Gm-Gg: AYBFou11xpQ9B7t124C4EJ52+jhCjw0R5koWKVmwUbViIss12P71SyC7aKG6c+Wc/AM
	DbxKq/kL/Hnf9Dw946ACj2PcsP7nrJ/xhFwg9wGUw+n2RDLuH8jkJAdAYYCTD3kGKsVVS36mXu/
	WgPmaOGZJb88reVOT+5MxT4wcORd9WuAhHC9gUuaaZzf71zA3lMQDy+y7kYeGdMLCgtrB+9bz7f
	JiiRQMjnXqT6XNgLwPT6ZtKIK8/xvqFnxtqkX4JNcICMzyLvv+tav3nw+04R15lhE2CqLAL+aM2
	FTmAM1x87mMuS0Tzu0oKwqsi8vV2kCVXDdpVZggIowQVV518/R6LyiP3kuj/4PVO/xhOMHvAd1E
	SURf54B6BiLmwDoiRgiucs6/Kk/TNHLubZEIH
X-Received: by 2002:a17:906:730a:b0:c4d:28be:9ce7 with SMTP id
 a640c23a62f3a-c506698abd1mr118840066b.4.1794385846277; Wed, 11 Nov 2026
 00:30:46 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com> <006a57d7d150d581c920e2d2933bd9d9faa43eca.1793521331.git.gitgitgadget@gmail.com>
In-Reply-To: <006a57d7d150d581c920e2d2933bd9d9faa43eca.1793521331.git.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 11 Nov 2026 09:30:09 +0100
X-Gm-Features: AclHuK9OqeXnJHGaNar4BgdvwbY75qlOjDMJSXdjsngweBAVVDOdPD6erwViyvI
Message-ID: <CAHwyqnXuN6vjBD4_A7FsSHTvra_k7XCpZPdm=DSdH+r+mNgekA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] branch: let --delete-integrated find branches
 merged onto changed files
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>
Content-Type: text/plain; charset="UTF-8"

Could I get some review here please?


Harald
