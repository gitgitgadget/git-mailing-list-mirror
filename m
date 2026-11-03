Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793706626;
	b=ghhR2iR1ENDlV18JAVpPxDHkkPut08sNm8mZuI+eghGELcb39b741CGe8wLBHh253Obm
	 ZnE4bczsR4V+JPc1j3b8+UIdZiFGxmN9Z4XQqCoFMOuRuQvmbRE9aJ4A2Ppj+jXKaFWj4
	 KqnQs7DIPXXOovnM3GtNApTEwdiO4kNeBBidw3gHXiC99+vQLBcGwqM8l//ZHXmoXyOh9
	 Yq1m7UUf2ffBM2dVTlQqNteq51yEsbURS3aPc7VCX/B8te9fUmQg84pTUXlyfY18L0Oq5
	 1LieujKIuJa45cnuFrl008L782AGN1Ci0Ob/+O9IeKtDN35RfZh4huLBsJOwvLEdu0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OZAvoSzJrlZgRpMAa3D99xg3EAFRxsbzA9HwHBha8/g=;
	b=InIgrOtAzPD1FKwo2iYepLjMgOSdJTlLUdBqtj8536vM+cyu5OAXpg0DwwtlDROu7MGr
	 FsA4MiKTBvzv81SgXSHBSbGNwwfZ6ifGBuC8xaA6E1OHpjhtvUKnc1QRCt7a4SHbW5e6u
	 +wOrOUnUzEJ015ZyuvPl76Q87L49pvAxC06Z5RczKSyBTEmkUr4N0B6iejS8VZ2TvVjT+
	 cVkqkTTTtscnOezkCxut2soWbtrV+VqJlCbNS+8FpetowbO4zenAsrRBwAIrAQnn9r3v6
	 ZiBVFllvpvaxjxQ9Tlp4VGmkuA3qN0HT84zDFz7eKrSxX+QtZKKd2i595YGuVYEJArw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbUZcIpc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A79606A33B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 11:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A79606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbUZcIpc
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso6869969c88.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 03:50:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793706625; cv=none;
        d=google.com; s=arc-20260327;
        b=R/8igpOsFu1MyAve2FvwFz7l0z4ax3vtKkPtRIxEjsfJM9uAhGkf7GmvorVk0R/hEo
         XYMTvMpCtAWNKK/Sr8tCdKnTrlnIsE+b9Lv36KEOxaJfpW1QATLGrwvMcO8XP8kDjiGF
         t+NILc/lwi0n2bxnh8ekTKKkRrzQtv1bLm7UKaOS6LLsJZar125YGvK8rlBI4pCTja9z
         ESDjuV1kISGjsZLWUT8QuDLgXU7OO7kYggerlthoAJIbnUBNn7iiqfjmU8rYjmnxujbC
         MCywNj0TJSbc7f3U0RN7Ws/iKQon2MwkqbQp/RSjpNQpclfkNT5h2ZBFHiHMJ6dLFERQ
         jtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZAvoSzJrlZgRpMAa3D99xg3EAFRxsbzA9HwHBha8/g=;
        fh=M0bpdXiSTXdD+3QsRqpLy8Sf9mfMfWjg6PwNpY05g9c=;
        b=VJYHZVFIrFgR6rmz4sEP7IZqOGrFTmUIqgWAa3XzRv/cwmBhR4oXuwbYnYu1eDPcoi
         cVLp6LiVBNHA65CEeXr2e4OSPTM91KjVkYI6fMgAJV8RP5KoYZ3gNHz+CBCA3bbsSj9s
         +0UlJgbWic1/0BVOKAdEp2Rqj673aamN4SYgU60JoUFMTfF+GWIsuydqtmrF+UJ4zmXd
         +1hhn175u1ss1KKh++Bt0vEEEME79k7hpsOKLA0JLf2cHa61+bLniOjySGTnKVt4aR+J
         nWYBiXb6ypLiC/QYweGigFDN9ipz3acj7EOOdia+ij/rCs1RcfnmPHNUWqje6/BsAEe5
         dPyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793706625; x=1794311425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OZAvoSzJrlZgRpMAa3D99xg3EAFRxsbzA9HwHBha8/g=;
        b=kbUZcIpc3IYJLpw4/IPiCUJnnrwTeWaMgkHxSfPYVhtLaTuOnROPAbG9TKXDKA59xl
         TopCjtDv7JfN8XmU/rDcqxqv+nZQn7V9e96j8Tqy7dE37CRphKZTWKSl30LExZdewvXL
         ibLWlUVH/g9X3u7b5T8r7XoxcKXq0InkJdvsoSwVIvIcC/DO+Kx7Pi9B5jV4H4fTpe/m
         GB38pvxA1s6NNAEF3BFDS2hIqmuItK7v2BtBq142nZ6ooS/Ti0NNqIpDDiR8mN7tu26/
         zNriOflxrg9cn8TPO29gRxXvsqME736vrBQDoi26JguCauCtCH3v/2vON95NlwWvzvzK
         0kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706625; x=1794311425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZAvoSzJrlZgRpMAa3D99xg3EAFRxsbzA9HwHBha8/g=;
        b=tUf8v4t0gzBp8uR0+0ZSDykWEzhUwCaz76FuwySrzKFvL3OtiZHwQ9papWhlTm2NJ/
         /ca1okIOHyR0Yc+mS2n+YO/vbwfBoS4MhtCJEojooaH5okrz+fA4iOwH5vN2JxwWk9Th
         huPm09dLSzzMnpDMyNci5IuYZ1pMHOFNXptuOMkL7xvPV4EYWJdYYUGJYt+Mn/Q58tkL
         QDVw33hMmY9+OL8FWBAeK4cHEL459UUoOsDIssyAJIErbq/N8JKq7cA+hitE5cswrYBl
         WfU8KmXUh/uNeZ6/bR1l1XZm7+rJQn2pidcNMh2/sgBU0KbsxL6Y7MpdKQirnOLIl8kr
         NBHQ==
X-Gm-Message-State: APuU4Z9UDBwKZkZWuRCE9vfoes8EAwZHIvCHskgWYuB4KYUO78TUbeNf
	ap6ieDF9pOLv9W2zm+s/pvD0su0FhH+xyi1LRpTlIq0r0U/XIUbKIuTD/Ku1CCMfb+auJmo8KQV
	firZpNSWPvtEIejCwiXGH1DoRqn7eckA=
X-Gm-Gg: AYBFou04rnTkXDkTVe1ft3bPzwmORoKVz2tT5DPs+Th3OLAEYubYUmqZKSfDyzJxWv1
	/Ys4koKxPg5a3k0UYoTPNvBvUUJBcfxd3lSHm4Y1nmhCd86Mwgp/cWpuqvDNPbWJuQvVKLnPhid
	qyE/+M6Kf/ngJe9ArN/o19HN/VuQlrpmTrPNRjqScM3SkJDmQkCRllwIufqrMq3uFz1WCwZbDNO
	pCaY97RMaO9aVhqsCrWkB00JHuaLRpoBIgfD63bZ4DMRrFCUIfSuGR7S5cGynOtHN/AThPQvzc4
	LQuxlO5liUt5nBegI3Vr+8OYnCYThFLQuSmXLCx8noN94Hyrzjfvjk2NCJ/BOK41IiDjEW8j73w
	mAPYG/yUJnvmSINEpD56UtvyM2A5Ta60YL8N8afmeHtJPtpMzR0Au8kaxEPe0FHYKzUlIwmMMqQ
	z175v9IyfGHtIJhkg8Cds5ONPb/iamuMfPHSgecrgLYkzqW7RVm9BMOxqFJa4aQY+BNTOmEUE2A
	AEXfOzuDZ1V9WBrfz2ICXR2
X-Received: by 2002:a05:701b:454f:20b0:167:d73a:e994 with SMTP id
 a92af1059eb24-1ac5ac4f0b9mr20198925c88.24.1793706624569; Tue, 03 Nov 2026
 03:50:24 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027153429.14131-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261027153429.14131-1-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Nov 2026 12:50:12 +0100
X-Gm-Features: AclHuK-9jNgyUNUEaLIralOC4qtNCne9oGAdaEMsuifck-DEXC8_e8yT1J6iI1s
Message-ID: <CAP8UFD1BW7qEWp87j+7B12d=eOu80Yv1=Gf+ibEriV9s=4umag@mail.gmail.com>
Subject: Re: [Outreachy PATCH] negotiator/default: stop using the_repository
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:37=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:

>  static void have_sent(struct fetch_negotiator *n, struct commit *c)
>  {
> -       if (repo_parse_commit(the_repository, c))
> +       struct negotiation_state *ns =3D n->data;
> +
> +       if (repo_parse_commit(ns->repo, c))
>                 return;
>         mark_common(n->data, c, 0, 0);

As you introduced `ns`, you might use it to simplify the above line using:

         mark_common(ns, c, 0, 0);
>  }

[...]

> -void default_negotiator_init(struct fetch_negotiator *negotiator);
> +void default_negotiator_init(struct fetch_negotiator *negotiator,
> +                            struct repository *r);

Many functions have their `struct repository *r` argument as their
first argument. Is there a reason why you prefered to have it as the
second argument?

Thanks.
