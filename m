Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401594;
	b=VDHU3gi4Hroe6hJUlQvrEQEJ7JD4H0dXVuCL9CyV5vv+y6JhYo+4tY2o2MioHt6BCEwM
	 Tq3Z0sYKzRmG3TTnUxQ6pscn4jvT9TE0YehQCAFb9pkrIxwJ15qCzWlhSUYsc4ZWkLDnj
	 rKk3xzxrx6qa7tK2YtxIhu6STpZAOYQFuE0AkQc2tqZoFEcPvC/LBcXYvfS5Iv56HHRaj
	 ++7K/pFxt9kUnI8NmpEwOjPxLR/9NwchqjeqSLmi9vNrV8SWbFo7/kaltqWTb8cF3ysf1
	 ZRtc0COODT4mnJw1s52BP5NSSaio9DLDhFY7qGzwZrIsJNSp8etP5iO9QoZNfA7udoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DEBsHHKt7ojPgNXuaszIHKfI9qLKGSMBJTYfQ7v3B3E=;
	b=viNR2SF4SDTKUy+ONmLxwUYwveQryF99tyJGQdm9BLyCf1v22nPODlXrDBgZGWv+0XM8
	 REFr5VvCacuLPfWeJ7EAjHi8F0cg+t5oX6B48Pm9Iu3FH48lWQ+dcmgSb/IS6oz8BHF61
	 QTRoGCNQhvYH42kZ/ArSYgQn+XeZB3hHO19H/BkQQWXgYEQGAOuamIT7qa8ftNqI8wjs5
	 iZ2/JUPSHkHR0R9UkM6/ihlSS+GQ/5qih3JYYiakd4v2Xmp2zrrAIKfFpiBcPBkfwGBpL
	 oFM55e5wj6y6qbmRJZo3raDL9JzhAdjOx2w2+8LAgJS3cTgY68EVwUJXHUyLBONIL0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=aVEQNg6X;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE6606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 23:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20AE6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=aVEQNg6X
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-843a4ca671eso549756a34.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793401593; x=1794006393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DEBsHHKt7ojPgNXuaszIHKfI9qLKGSMBJTYfQ7v3B3E=;
        b=aVEQNg6Xgsr7W1DIKsicyfsXffNcfcmQVovgiPLq5QzZbvzVETAgQpdEI889HKlwLg
         ozCdZKvH1a/guapdFRchUkcHWvf6lYVp80Xk766lWhFuTGBYs2Eiewf3KVQRIgVrUARH
         PjP6gL3P33+VxNNS9s4JZ9hqKiphE9asX1LAaBEi4bzQAIfYhRQ7mniAP+yT0l53ofPU
         jdlslJQ6wjXOkCfhtiNiyN6abu11N/h1K62GFIa2ZTv0qeUGoiD6QcPKaPq0gQ0+Hycz
         /IcxzaJqWA4s5T56wk7nEejvnW1gRZC7v4y/zK9rutJ6tJ4NFFhembrY/xqVKdLUOnCc
         dZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793401593; x=1794006393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DEBsHHKt7ojPgNXuaszIHKfI9qLKGSMBJTYfQ7v3B3E=;
        b=lZt0lkXBuJLZSnT2B7hZqL0bhN7aRojDmJ3J3vMN2tgJz2wVBu6z/zVBRtuaqy0ILh
         QakyVSd7z9a5WmxBFb0Lj9hEkYx3MaF2eOAPZCpgZ8235Fl5iZ49iiC34dpEC01zcMyn
         4LtX50Wj2kguc9MbvBM2lpXVRwc+8Z6kaHcywGQ2YpjHvWMHx/WisKAXfYkpxdVPyiJn
         i/8yzZqB0Xpw1gsHNpw/DJaCRE7Vt33GwYnfpfdpSUrY3rUXyHErKktMjdSEUxjE3c6c
         ZTDQjPOmnbzkaQYXn4+LPQATtrHiqHCeWPMOOmHcJ+dogpoitK5xv++/JS4vPqqGn/Up
         TzpA==
X-Gm-Message-State: AFq9FYLI542VQOUCAxAfxMvGWDLAzwlIcH2idesDG/dcDbXg4VZolYlO
	5HmLf1wqmWItf16Pg0hQn3eyjdtacW/RWjLRpuIiBfF1HY+nA4paoOdsWftJ60//EqDdwNJvkMa
	foagXnxZFxOSAlan6br/Ecj2MHEePRwcFelqc+W+vvphehYGTY2COfUWxHA8DlQZ36IOxCky41j
	l9v6Rcp0KZd88PRI85ngGQdZuduz4L2EQ=
X-Gm-Gg: AYBFou1kfOjhS+YUjpGtfr2P5ec5/NSFT1kfDBhkyUHNOf2mzdNLxV/cnLmw8eMQZCx
	RsMngQs5L4quHCeE368+KkyAoBXcZyAEhbwZdcu4B3DF3cw8WgL4fJMfxXzKQMm9izjVZIdxzB6
	odYQLluvjD+TcYHSMkzHKRB+LpEgYYkneqEUukdZam9/ygUgdH/41oFKmyVeY9Wq4ic45aw2HUp
	DEY1fbr3DgBulLZD2CkJka8g6e9+8DvYwQKIloyUFv107bupmniB+8rj1fsmCCOV8Uo3obvsMPe
	6JqgsqFZwb7zHYLggDEyE90YI4RFvCbSXuA0aDvjgf7x+Kic0DXnwVPKGC+vgU8m+DOfW2Hk3nN
	9EiSSs2GTqrRcf7pAJBGXrCMVmmwLfSrrYNU3gAhg8cZ+San1zZdUOnPO19+fd6YtNDVVBBmlu8
	7DzJG4v9LUvGrW7PnL3sika5lfe9BSLYGcitP+HZIchsgmEv4mqps475RnEb9yVMrsaFHEP/tmr
	x0qLYr9lwrSQsoq1L9BkUojHprZ4wA8rH5ck/CELzwQ0CVMNpwWzmN1WlM2H++2EJuvyhAUPrUp
	HWTPn7nbcD5UV0ak6hlDwhV6LzL0zUgff4EFTAMC17dOdx4iLadWBmenG2I6VFNdLKZx+cPmIJv
	01U3bRbEUnBiZkqLZchW+j+dLKeGg5piOpME+QIxJzYKzlO8N459RtuO7YTix6sN5l4mGTv9Qmu
	KVp0JrfGrBfKhNV0cU3n1dyjAr6Nar6QhlCYdg/cux0c41tMuOt6QxkGCXtHvejnssPUXUN13M5
	FMfSpDn4fYodjMBCKXlVMIdvMbbLUYq4Ukd+vA0SJuby3zIDe0M
X-Received: by 2002:a05:6830:440e:b0:804:ec69:3979 with SMTP id 46e09a7af769-85d3662422cmr2651676a34.21.1793401592980;
        Fri, 30 Oct 2026 16:06:32 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354f660csm3006456a34.22.2026.10.30.16.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 16:06:32 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH 0/2] worktree: treat a branch being rebased or bisected as checked out
Date: Fri, 30 Oct 2026 19:06:26 -0400
Message-ID: <20261030230626.85196-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqmrruu7bs.fsf@gitster.g>
References: <xmqqmrruu7bs.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Jasper Mayone <me@jaspermayone.com> writes:
>
>> This replaces my "git worktree list --branch" patch [1].
>
> Then please label it as v3 as the old one is v2, or it breaks
> automation.

Sorry about that. I will treat this round as v3, and the next round
will be v4.

> All of these address great points.  Thanks for working on it.

Thanks.

Jasper
