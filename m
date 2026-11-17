Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951779;
	b=DpW10qdW/NMkPQ8nu2UgG+R9AONIOgHgQ0zPR0aN5iq9auo1IpTxhnhU8CTq5nQhMNgv
	 bw/TbMEkQK72JsXE1Wox1AXbXDK5UqpD/s5iZ3fTqvbdfqXojvJx6DYD2jdzqpsQte0AJ
	 S3Fr4hczfVdD6TZfQ+OLIUDXu8XAkXQn8bvAuii9nhOdUehgW3bOcTFm85Kc1YNNVWwnx
	 AxpTEEfIvLfgRnpkXMU9SMNK5qfRkD+MapKmkcFdZr9pAFoLVjRnDhZ2nKW2e4MNRB3Xl
	 MXpV/lPc96aeCGzj9j3tdcsV+kaVSocF06wIgpXUnK88bjw1rtUr56o3BxtKCPbR0ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=32pQdTO7AjOPi5aVmyjBQFE7nmTYgiqsP1ki48ek8vE=;
	b=gd05b2WZJFl01XTLFGLLUsWVIlpvv4CDxbiARyc8kDR8pazJ84XSpym9RTxUMNG+JGff
	 8ukbZ/6giuxExTicpPR1zxVGvX+gdUB9mt5RREIBQvp4Clz9VJaa4FgQbtIu4Bnx1uY7H
	 67kzXMcltJ5i7dEYvV3MD+lQzk/1ppUgfacC9pw62zEFRohK/h3kXM7Fu9gcQJK7l0D5B
	 T65tmbIe+n7t0SqidgHE1cob4JtkHvy7xfF4TjrvnVELVDvEMThvyjgMBrjStOeFNRlan
	 TW4vc0RKxcVR10r4iS8BjCLs2OZBr9wJ21nCoAvlY+WC3K/H0Z0Yt/B76iax+lh9LLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iqwt7ZTF;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0F606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 21:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iqwt7ZTF
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so3413595e9.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794951778; x=1795556578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32pQdTO7AjOPi5aVmyjBQFE7nmTYgiqsP1ki48ek8vE=;
        b=Iqwt7ZTFa0l0NRdV1qyKAvNbPjaFU7PTaeGxauYkSvbwqxwxOqihakKD29pIMoYJrX
         odDZ4fv1NqzrkO+wC5L9JgpU9rLms9jYz2+8YY4KU0MS0bKazNK+UT1rjzmsVmARuChB
         nYDLfpQWZGc/KmMaCn9h897zg9ATLFdeYPmdTbMLjlAXeN6Fv4VKP8F+dW1+si+E//6T
         QEBhNM9l/1ihXgY8n4apttqrsqB8N59Cvy8lTGXpzwAbsIrtdzvTk9ivOA8+Qs1IYLGX
         YyeinpaHRiUB8kP841usQCJ1rIhXI3qnWPYDs5u/8SfOX6j+FF7/iGAfA0xV5ZStwBOw
         Wyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794951778; x=1795556578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=32pQdTO7AjOPi5aVmyjBQFE7nmTYgiqsP1ki48ek8vE=;
        b=BE3esLDrQOs4V5Px0KHyx+9HPu8plfVGzYV0IoWdi6LxWzcwtdELoMcvXYDDw4Pb6P
         h3sAzkYY0aWRBD8DroyLvmPZeyDWq6+dupX+WQt2JTuTgb5b2oEVjKiPI1Mhi1HZ8ZUY
         EqFZZnNAxyRGIsh9S9Yd0f2CjIkqaB9a7X6B5+IpGGojMFl9eDx6YNecbemIiGDJlO8w
         44c/LutKuqkb9uGrvW38Inyvyp1pOfSuSFU5HfkKewFGIES1mFob9+WSbfeIj6yI8vGZ
         2IcPvvlTtKJ/jwSuIY95cG9gE1qmnIHofnC+tXGKqr4Hc31HxTJbfmrpsh62M16YwLio
         lSzA==
X-Gm-Message-State: APuU4Z9zA0x/CJ250oYQZEeN+jG9ydQhbGEvE0hAeUuVeyR0k8zyxUEM
	ovvzReH73JP4ft0qxbdZWIHcycDBltsS3gK3XCOhUHglaGHorMrbmDBjgoAAgQ==
X-Gm-Gg: AYBFou3K0z21+bnri+qyIyj70ULHD8yVNE7QSBjpYnxaVN7UNcbzWUe2OD/myZ5xfTj
	mHTpHayRu2ViAZKXPc/N35u5i9Z1v34iWxCo1o+BXUONlK2wS0eCgIRU05My3jKNQj8OkDD86sm
	HnTJ5Hec5c2B90ln1mxYegkhJqlxO64AKy0hI9QLibYtXgKDmBeA7xl7KLdBKFYY/h8q/zFtFzV
	GBt2UM+WQAtMe9+hYv6dEVvOXSbezV46BAEwikIWuWNtVy/YxDWAGhBeUJwWWvEIv5lmGUGic6P
	BOPX2waO3N6Fj3gYCpguS4jyNtz0JBQG+ioTWuZCjXKan1UpfsiR0Rm+qW/+y/ZQ4Pab0cEXQn6
	k+dyuaIxIVurAyuHQuw709UsOnnWPc8tUMVZ922u3F2GvI9BaTKWSb8Hw+zuq2YDCGYHlfBu5eH
	Q59B57G6NZ8kw9k84qVAnsd2USLbt0dI98Q4u7g+t/DxlEBhgHJPfK3BCUfoJOszQmf3iTaPNr/
	grKdwejPBFwkH4jF2LSB3/el8hZg1S+4a1/is1wPDotGjj3AT7ucA2BqSD7Z9r6uHu83i9QOvwp
	0eASXY8V3D2viTnmT3/6azQ1j/cGqZyoU2iv6ENtHG7Gppl8QuUfeibLjDyeF/c=
X-Received: by 2002:a05:600c:4e93:b0:4bb:5c92:ce12 with SMTP id 5b1f17b1804b1-4bb7da12f06mr9935215e9.17.1794951777612;
        Tue, 17 Nov 2026 13:42:57 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656933961sm1024535f8f.46.2026.11.17.13.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 13:42:56 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/2] tree-walk: use size_t for tree sizes
Date: Tue, 17 Nov 2026 22:42:53 +0100
Message-ID: <20261117214253.716770-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793357680.git.gitter.spiros@gmail.com>
References: <cover.1793357680.git.gitter.spiros@gmail.com>
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

A gentle ping on this two-patch series, which has not had any comments
so far. It still applies cleanly to current master (e1ec09b23c), and
nothing has touched tree-walk.[ch] or tree.[ch] since it was sent.

To recap briefly: struct tree_desc keeps the size of the tree buffer in
an "unsigned int", so on every platform a tree of 4GiB or more is seen
only up to "size mod 2^32". The walk never reads past the buffer, but
when the cut falls between two entries the rest of the tree silently
disappears, for "git ls-tree" as well as for the checks in fsck_tree().
2/2 does the same for struct tree, which matters only where "long" has
32 bits while size_t has 64, as on Windows.

I would appreciate an opinion on two questions:

 - Is this worth fixing at all, given that such a tree can only be
   crafted on purpose?

 - If it is, is widening the types the right approach, or should a
   tree too large for the walker rather be rejected, e.g. in
   init_tree_desc_gently(), which fsck_tree() also uses?

If there is no interest, I am happy to drop the series.

Thanks,
Elia
