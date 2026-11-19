Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127203;
	b=k1V9mbrS0QZ+8TJEeQDqXd+ISKNOcGSEqMnv6CkZPbrrmqfX9SNEzngtCA5SLlePFo/5
	 K3p19PyhZLlAL7HMLzJ6To77VUeIO/qV55hlqWyVXvXxu8F8/O2e+3ndHd7IkrNYOQ0Z/
	 mwRzY8ysZaXtkBVgUPd+aP6dFPbUyLno6viDVU8YT0NBMhUOvo2uDCdYDwzA+RRfuscPz
	 ntqVA3XXvvIxo+jYar7wEFZtAPKKgLeNP3fHuKmkAfpKcD9QBt3HMqQHZpm6NMOcea9EP
	 lGF6Z7hRD4HxxqIbcIUevg7CzqCsH8cveS90t2UhPFFPy9FqyY5ClPYTqqkMcEdsfAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=v/Pyrhd/cj9vMcaCp5OtkvjAchApTSme+2CvMFRg8nQ=;
	b=CoMar3UogzPsW38nAwGxGH1jZH+vBU92uxqhcaien7Puj7RO8w/RkQA9cIv1G11A6xNB
	 KzkzIyvTUDnQXfnrwLENnpuktiQDWobdYLbtf5xG2zoVDZjXvzPtOz2CbXmFQCC/zQvQn
	 sqiZHZujqwBmMZnEhOwJFno3Q9DbmFFPJQCayjIrp6u7kxy7ON7Ie1UpNJ4AL9d4zIilf
	 Fft9SrkEzYrWA39qvA38JgBo+2HZzNWq5UYRqo3RMgV3Iw0UOIQMuWdQOjtRxKb44KuhA
	 6SpJhT/iVRlxva5iGB24USW2cjNq07lugXvu0h3/pEGgM1rTGfB7mhMap/40pqvfFMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Fa/tRmCR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB9606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDB9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fa/tRmCR
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-679aeeddc6bso361899d50.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 14:26:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795127202; cv=none;
        d=google.com; s=arc-20260327;
        b=YRwMKoTV6m16pYtoCmlNuAwGUETQrurOb+K3lt8jwFTCFQnx+R3w/OUTXVb67l2g1e
         1hBjeHmLAjx/JnrzMvyunzznEZn5p13qj0AeZHbqlxJxhcnKPO9XUxO+G7I6GMmW7I51
         xQs0TprfPRTFvN4+kVXsD9nhBYWDTxmnRgI3edtUUHUL8Mf2OtMJgzx45HyCkBC3Kp8I
         q+o2ld04oZI0fhCPp8mE6Gkbwh2z2yWJpswxFYz7RN9V39zJv3Q14ViUTvenbZ5Iv9Rd
         IEk+bZAuKNEQOnBGl5y0L6YmJJ6xLyWdPkgO0mNE0jkqkQxq0PbtalYY4TeocekZbi+y
         VW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/Pyrhd/cj9vMcaCp5OtkvjAchApTSme+2CvMFRg8nQ=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=lcVgpRGmFxiIsKvwxlcm3HlH4HD5uwyrtsodG7EAGEXvQE4/diJHN6QXZUF04AtV+Z
         SNb3/uFHt2hxdKc4be8J+FM+PmAqeSQp/LvdkR/F0pnxspS/wjmPZ8MUdRSl2S0g0ph+
         JR954y+DbYFtkgIkf/wZBw+bY8+VgopQ4F9M2EJMNcUZK5WBQoGBHCF9eOjzMcbFmQ2x
         uKwfkfG5dW6BY7Vh0OVsFIE3+UjeB9irGkHlH0TjtBAREPB+iEp/YZ0GGU95yakOm9Ga
         6a2Xx4ghvD4pY5gIAv1XXbjMcWy9kuSICZHnhyzphWXO92r7GnCV3nena49mXnwvVOaT
         /sTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795127202; x=1795732002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v/Pyrhd/cj9vMcaCp5OtkvjAchApTSme+2CvMFRg8nQ=;
        b=Fa/tRmCROFt0PlldFlyUp5m7PeeuTR2cGhR9BmYehCM9DZ4c1AnPxZiA7X3O3/xqCw
         egE0BrAsnmrSzHXfHUUg+8sQdoid7cM81OvlStDB6hLu4qpD+h55Mc5CI0sdqUUWuWd2
         LsUcE06BWPrYZijdBYc1DGCBJFtlD0glGtFnkx8EGL2r3T7wAnDwQ6f2bGEHA1cptEyt
         j8fi+BYcueVYl6g306HIoA0KnygMVgEC6+mnzo9TjNFXG2Tp9BNE00vrLbsWhEbUz9Bp
         y/1b+/sV7jzX3hssV7rCJzKN0fxpzqjyUzBdNA8ws6WS2wEp+ejmDl4q/bAins9Jem43
         /f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795127202; x=1795732002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/Pyrhd/cj9vMcaCp5OtkvjAchApTSme+2CvMFRg8nQ=;
        b=hNzRMtDBc1/pzfM4vYCjtDBjpkzG+ZXuQ8+nHD7ENMvyUcKwqrtKWlmQ8Xkl/P/xhW
         pMI493WsZDOkTz4lABYcHwBlDfab0S0duzLsEj+PwIwAl3/8wKOJy1P//hc8neRN+Cre
         MiOoAqtg0jl8cPZ3OtIWh16SbJGqFSVtHMHzTktKAqPrA5Zh7QThBUeWqJ8FVGLv+VgM
         8HIZWoXwrC/E9mWW8o4rUGIZ6dIYEofe4pG8SlOOd0vOmGS5tBhqJLQFnP2RCzWIOFYH
         TBczLES8f/aRDfnk7q0mK+f9Sk+75u1Tf4rn/Hco7jyD2c0fnBwcrBMABre0d7HP/2YA
         i3hA==
X-Gm-Message-State: APuU4Z+8o3WwefEOkGCAWBhOico6ZLV0RIQsRMwtmTkR8n7C17WkFSDV
	J2vE6D0eQPTkjYdNLFAgKHO7uBafRSGgXYuPy7op5jeHdhV29svoHPU+a71L37tqdXKdbKaP67I
	57gPLkoYRXbGOSkicidUsG6EEk1jfMDOe/EZrgS8=
X-Gm-Gg: AZFdTZeRMmI3XAAtWhpSacBrCmu8I7VtEH7fGXdeyJ8z+8TKU2HJ7/zl2iMkKTaa27M
	XdFLjVCy9U3WTJVBegsQ5ykDcDyY3kGX5S29r8HMKGCvXuV6LuH2w3k2ayTVcitMwb4h5Z53zDC
	C1U+gh1WIW9aNIfTX+UzHkCTICeMcCWqQTO8wMyZwtkyus28whnN/KQqgDBKoUfyXD65a041H/B
	2HjnUItIvhSV8ETDXlHJE54LQQxYe4b+R0y8xRvcwt8r22B4mS9Io3uxSIngacHPQcc/iCcE2Xg
	tnwzWO0GE6yr0717m/LVwFGm8m6n6zK4hhflKkZWDyEk9txaVlsqWbO9XwSqSHTyGKQtsuO3RS6
	5aRIqszTben47UxALB16RnfD2U6MrQC2cSxhorKLS5RpP8xdiu11BxO+n6z2gAnhwaiy+ncuig4
	fHms9RnRSV5dfifc0LVX6JqhQCpLvnYbnLe4IWhbvxZvEZXQ3q062cw9gsv89R9ca7yVp3Izbkx
	lt230QtUZ9uIycqDXjWGDRJUHf0iIqlOSyPYc+BPg==
X-Received: by 2002:a05:690e:4088:b0:67d:c305:ca38 with SMTP id
 956f58d0204a3-67df44521a5mr336861d50.41.1795127202238; Thu, 19 Nov 2026
 14:26:42 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119105300.95746-1-okhuomonajayi54@gmail.com> <xmqqik1sv4y7.fsf@gitster.g>
In-Reply-To: <xmqqik1sv4y7.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 19 Nov 2026 23:26:30 +0100
X-Gm-Features: AclHuK-Xwuo9qmGDR1Bc1vnrMbrs-SCDG3xkRj13u3DCWCZ53sGGtJQEstSC2ww
Message-ID: <CAFpMFfD=7B7jqQG2eZPxLEJx8Rq2z1fH_7TdUaU4+bFoDWS=Cg@mail.gmail.com>
Subject: Re: [PATCH] doc: wrap emailed text near 70 columns
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 11:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> Thanks, but then why not also suggest to use these inter-paragraph
> blank lines?

The blank-line rule is already in the MyFirstContribution patch
you queued, so I left it out of this one to avoid repeating it.
I'll add it next to the line-length limit in these three
documents and resend.

Thanks,

Okhuomon
