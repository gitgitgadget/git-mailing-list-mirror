Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165764;
	b=1SMU8l6azASlKvESLDwP2Ch/XOqbE4SA9rCPZCe6ftyKOOM0l5sXDxZYmILc4sjodqIQ
	 D3PO1/Wjx0DcLfzPnEolvBSQwseweQKuldN0dwlBc8397ARofpqL5vC+KgBAI+0hTGRKI
	 BfuUdOurgb8I/eRi4cSSStHo9RlEX/nYUspEitOgLczExzSCR4Zm8ZVCaoNfe/1mvtyAa
	 FBKFetOb6QVFn2MQMghlv9QRuH28vrgJNoJHNk3ONHwBKIT+I0FzHRGmnMBqFWSd/4CjO
	 Le8qw6cQYECaKDFXKMka2uiwTqmmOfUDZuDGlQo3pwlz95yfRj88M1FLA8wxNjI/BvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SsR0I4UXhvDlXiSE9Zdziru80P3vA8rg4iIukH80tO4=;
	b=5KdnXj0lndt6padpZt8Bmawxh23AwrZ0zAb/ZYKZomTatcGP+iQXkFv6oFLq30h6dLaz
	 dSgnK6jJ0+v5AeOu3yLq/r4GkqLyUPF7WLAqGbXLELfYjW2WIWyluNKWiW4OW2F/SQlzs
	 BEIWZlNTaKpp1zeXXdgJR/JM70I0eZq4qVjUaUVZPWmG1ze4255eoNvx8tjIerRFC9X70
	 +CHFdKFIaEcurl+twYBpRnJiUoUj89aCq1YoZllQd5UtQPxwvlVx0dYp+Kls6/L+yFzcD
	 KRlKPhk18Y+WYKU389IAoMzhrU4CPlUFmI9WTcT1lD0Xjqw+IZkoswWyWEPk6Ppt3sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AnevAn+8;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B9606A323
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 732B9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AnevAn+8
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso885876eec.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794165763; x=1794770563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsR0I4UXhvDlXiSE9Zdziru80P3vA8rg4iIukH80tO4=;
        b=AnevAn+8AeNRi68gwsYSXlm2cGvQgryaSgi8qeIZ50bRE2PPNQ+XAlDsJ8mZp6omF/
         LMdoq+rC0EEOTGh/1TLLqUIvJXw/WWGQl6qY2J5KIpzxPQqiGq/JDjl3M+EpOxF2DlNp
         MCDs+P4bLNCXFyDa5Kb8/WByJGYPfL0eaHoTVaEew6EYykpJWCbmhDnU+ompMblNBy5D
         s5sC1p0EuSh0Q73u+8wpBvfar9B5PSaGuRfuoRLjDTeN1jqpCoFCRj8zY0zy/IDtQtal
         H4EuWIb2TJUY7S2k8p5pprpPjchX3kms6lC9kSexAcPYbEtaeYnTlv1uo3UdbpFmqFLI
         KanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165763; x=1794770563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SsR0I4UXhvDlXiSE9Zdziru80P3vA8rg4iIukH80tO4=;
        b=exhEvEXKNzNcPGiziJfYnnfLAW7/mGMVcy3UdU8uXo071bzDacqEzlR6BJ3vXsT7vU
         EVJZpROrEO1kbH59yJKGkHbrgUpbSk5aH3pSlAG/NXGNAJW2BatOUtBN0GHS4WUMdqLv
         sjWwZ+0Mqh8Y4OkYt/04IKY+U99lC0vrA+MUxqJzXlHCqZsTzgbpQTYlA8LGniCaNYlM
         UgPgQ3dePt6FoLhozuLddUyMlkvMAW6ecOYbGPOvLC+vtuHEr2aUFRCjUYwnYMKdHuYl
         cL4h/h0+fraIvbWFa86jypJqjfcBYQ7Q+rUouWmYokIl9BIXcKM94bj8d+/DH/FQW3hk
         pg3g==
X-Gm-Message-State: APuU4Z9bVnhgwSniEnbt4p0DxwgHzDnmoRcHng1am/C5s92Gfb/6IxCm
	L0Y6XcQJgGGpOIfcxgVvSB0ZdZXvP21QvrJNSqEC5ABuSQlBWOUr8yTz
X-Gm-Gg: AYBFou3GnDbZeeobQBjvUxT0AecB956mD6A6/0hK3zqbEM6pZcHDD235WhiW1YIFy2n
	bYFlTSJTnDBkI28rcMp30BwV7TDzerOtssdf638Db7NucmMZmvkmZ2FTXZmEvIGPf+o2RbxZvTq
	bGV14bACw6P+udt9baYo6xw2irTFLM2af8ndNPGWqbPs8vt7a7z5v+PMKX3Usf5+KzSOsAGVWVf
	jz8K12uSSamSj+GDi/obz6lZ5kPeD5Xz0l4aeeL2X/kmWD+SEgeZ7w/19NrdyWhNPSxC+An84xh
	5x8UXMc20Liit/kbY74I1gJo80krR7nWO+84PwZYhOtCxdd9H1YnczVd2OHe0ROr02HqmJDKll8
	INkCF/IS2co5HnSzByhaU2J5KchxtIrtNwvB/2xeqZfdMVQhstXuxX94JkVEm3H03cRqcnyEIZM
	vPwbMuxhIx8j5POMNxKSUS1YQ/alZCJFqzefuBHmVCtdyVV6XdzkwZfOoEyIajbIG2NEHkRqBzf
	mjnghD0TFeKbkmmv2EXnZyBuBateFNThn0ycfFLXNY4H7ehJTOVaxCmynu7th9oEKxam3cOYksP
	8ilnQpSIHiyF/sJwIQG5qv1bmoJ0GNLGl6mcWMVpHTLRRb6Bmlo=
X-Received: by 2002:a05:701b:2506:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1b39fec935amr3518472c88.15.1794165763349;
        Sun, 08 Nov 2026 11:22:43 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.58.0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771e5728sm6756173c88.16.2026.11.08.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:22:42 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
Date: Sun,  8 Nov 2026 19:22:32 +0000
Message-ID: <20261108192232.681-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqo6bz2kxd.fsf@gitster.g>
References: <xmqqo6bz2kxd.fsf@gitster.g>
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

Hi Junio,

Thanks for the review.

> I think the entire sentence after "If a fetch from a remote fails"
> should be removed.

You are right. The fallback is already implied by "tried one after
the other", so the sentence adds nothing. I will remove it from the
documentation and also drop the matching clause from the commit
message.

Thanks,
Hussain
