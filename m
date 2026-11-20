Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214170;
	b=L6/S+wkzMdKkoB5jITZxScJt8LCQ3O47TsG70N3+5XSgzaZWvb8dW8PnR3yypy8Vsttk
	 Dyq719e+pys2RxVzSXsSYc6WzjI3SFD2hHBqe8rHnO8Zm7Aj3hCumoOSjzxA8F3nGbrSU
	 6uAxrpolC9p6xkhxeb5aCc5ARE60fxU4JAtm9eBf2SGbfY1ANMH6SV6R3RpGI80jkh0QI
	 LbINT/VcKiT+NvVQdyxbpSSUm57ZXhcPTvagsOdmynAOXjZiDKuaS2nXul29h7ALqEl4w
	 n9HchfjYQgxwN3cS9G98nNPioCtqiZwCxYOeE89mQeWbVjGCloclIjxQ7IGbe9m8dwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tfblQ1v455Pa/OID+22js9IEXwESaGKnOjJzCNElWPE=;
	b=ThfZHi1uHQbRVrq1Mi/5nXu8WWh2Hnp+1a1mBCgUT8FzXwf3TlF2mO4rw3zgLUsfDFcs
	 0tLn8PeNHNRZuxCf3je29chzY8Gi1eMvhSoRTv+8hOj9E/7WPDyojXWDgY4EpuG1iY9Ja
	 mKO38zUPtwWCnaaigPIDhQQqojTRckM7yW3KRkfW8VuY6YDCUc5oEUOtD4XBlZorja524
	 hUbikpQGeTn62stXNPb9EsuOt0o7jYUYdQilm8vzZB4BLl1rNLrVcADYRRZ8ytulaAv55
	 qmZ57RTYt0KEO+AYQqNxW8R16Wf19MYkwepgjFew92DrAFTZ5dlsClyIgHEtE7NWyzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ItMjIpo2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404C606A685
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F404C606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ItMjIpo2
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67921b515a7so1630057d50.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214168; cv=none;
        d=google.com; s=arc-20260327;
        b=gfWjuA1nKLd1Lyh1srp9c1HwZ/Ye7e1UsSH99i5hV5EnMgDhbEUgikfhCIKqnLvpCk
         qhAXZhc73GGPOxwfwPy9+e88sa5aclBiMVbWbjUVcuMfpc4zuJ1UchSExr920A10uTl1
         tlJafkKyAnSpY7XMbQFB97VaFS+k8NR/KNIUPaEH8qEcPwIA8qBdTHK8b6Ub2l5Bu8fz
         SJqLbE26VdCg9AtDn+OjAZuOnwycSrp3+XsDXLt/m9se6dq8viHhEgYxXkG4hrrmTMs6
         zj/UANHELayVzmsuX+9K4Yo6puzLxRpCQzxMtwBAAv+SbVvjNBBPVD8NTyL+Tb/wrpDN
         VnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tfblQ1v455Pa/OID+22js9IEXwESaGKnOjJzCNElWPE=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=ePWPktOIHpjj2DvK7Q7+tIFX6FU4ifh6KtKBP7Sg8azgls0/Hn/4IAGwb/+O0rgt6F
         oVba0er7vd+C0YpWAFk6zXub/lo2ZkEQW/UXApMX+Jc88tgKlDGk0fasSopYbvLxPZvM
         8gtJspXCGf9f5fjpgnh+O+Dn+UkPXiSEwjdsfbGOwmTIrk+N3pV/Rzjp5d14cGcJtASe
         6YBRNdGSVeAORg1LczsOGlA/OgrR8ViI27g/Etjy9n3+IgjjFaSUqStg+OHFnXNxCymd
         g1gPjGAOEVGjzlUmmxd4qw6CfwoOd2qlsrnc529zhxLTJw+FZw7bFB4mv6TxG+OLVAXv
         nukQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795214168; x=1795818968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tfblQ1v455Pa/OID+22js9IEXwESaGKnOjJzCNElWPE=;
        b=ItMjIpo2B4DKHw461oElkprFHi4k7jU2o/kOfl8HG9PvkfWou9uKQcpdXiU091DMhw
         wQr/RBY8zpaVNyf7/Olr2cUcJZOCGm9vfZDyAlwUlFpbCI4GCC6CYSSxGfT3k+j7BSgr
         zgtFemcyAF+ArTCvL+Qpy7XaSjCVtEE36q8HIgIeTwVUmBmQ9w9dvf71Piz41YebST6v
         bHfG8AmY7Qe4KVMkA/vVNsRjceve6uJg+X0cqO/aSDBIr0U4qxlvNFDEH4BVDbHLiqLs
         vTzxfvdjmi6IzpT6AGCRVam3jQtvE7Lechx0ct46jTiY3Okba04vwLS9wlxxb+SIbGKS
         XcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214168; x=1795818968;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tfblQ1v455Pa/OID+22js9IEXwESaGKnOjJzCNElWPE=;
        b=x8JU9DCdlXa9d3PbC0gIylR9r7NgwrvOfsUHgqy8ZqNKIMc/cE8nzH7tLU5tZT0XMW
         RAe8P0qb42ULij3srAK80TNfjz3IDTtxVHCP4YznSWMGtQQj313qWYzCobkIzmeBplYp
         YBUs7cY+3Ng9VsUEz4pRiQ60mIJh6CEpzatqCp2CVagrhbkJok4E02ToSeL6tgHMEjZY
         YdXqmD2bMkUk6FG8uK6OBukMbQrd+1DGSRqbmIh/IiMlErp4qks4IJ78KTvHLXaUCrRd
         catHJEjKoVkevwh8Q+R9DgP6M6fA/4aWL+aQ+WF9n71mfuHo480n6hyfsX1gQJTzpCyR
         AGng==
X-Gm-Message-State: APuU4Z91TfOzZabuFbDVj7MfxORmMzX3EAqzL2ZLs/TGdY9Y8JaBLmIQ
	ZRLJ6BKPmhjWFToQ3HWj4V0hQQyimKfGWEBIOKeQ/P3FmOuuu80ADjbJKEPOATEjZeowiqnc0Uw
	SgJB2P9OJbJXpM2RdWXRNBpj0G/NNKjW/Y7US
X-Gm-Gg: AZFdTZeXjX6tRyYxq6I2YCbEexeqr5DJeLz/XPIlrvRlMfDkgXawF2i6rPAGxsfYyXi
	0JD6zCYOXUEN6f4pcmRZ9N4DEtovqtStZ3Yt0pnC+r+BbGoAR5mrJJg/xpLizUPzrPw6Ko2hnEd
	yJJCS7Hhe6dT6Skid9rNVA3SD5cK2af9aVsY4SK2zsCHqPYSF8UgbaWVLb5mR32HAW7lGkpCoWi
	Kyxt9EjpUVHbtLAeoNgom36maqn9I9xQI7B260YbjrmHYqlPJbZkKU9H4d9eB9VkSWkRRHGdatB
	0YzakFj4V0/d+ZMJuJqwfxaaC7vlnaEouzljOo3HlEvVizidKG0d6c26/eQg9L/Zsge+KDjeybr
	h0xRXRva06uIr9IVDDENgh0qe+LBbYMfZMjeJPAj26bbEuzdwwbiqY5sOqrU9IILexrRcdlpgtN
	2TeDAIgKHnhzw7ZOamS6HsyAjHY+T0XeVlX5LGqslEcXm6iHtnw28YlHgWr85tnKf52OYg96P/t
	eJHnw6o9CJc77lklovRx8tM2j3f4jCpVZ3mRIA=
X-Received: by 2002:a05:690e:441c:b0:67b:e219:e623 with SMTP id
 956f58d0204a3-67df449b741mr1374399d50.104.1795214167817; Fri, 20 Nov 2026
 14:36:07 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120055908.83043-1-okhuomonajayi54@gmail.com>
 <20261120110215.42209-1-okhuomonajayi54@gmail.com> <xmqqmrr3qt9d.fsf@gitster.g>
In-Reply-To: <xmqqmrr3qt9d.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Fri, 20 Nov 2026 23:35:57 +0100
X-Gm-Features: Aa3M54qjLEPmZ9TrzD1j0QE-xAyTNP51unEnJtO-sIpCdu28vtC-JNUSQzKYwEU
Message-ID: <CAFpMFfBvMZC1Gst71PJKugZHFv0SGTNg0cMU0CL9kr=V+=aO_Q@mail.gmail.com>
Subject: Re: [PATCH v3] doc: wrap emailed text to a maximum of 72 columns
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 6:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> But "Leave a blank line" is an instruction that the imaginary person
> is adding.  You need to tell that person to tell our readers to do
> so.  Something like
>
>     Tell readers to leave a blank line between paragraphs.

The blank-line sentence was an instruction to the person writing
the patch, and it did not say why. I'll resend it as an
instruction to readers, and say that a blank line marks a new
paragraph.

> The phrase "patch message" is not used elsewhere in Documentation/.
> We use phrases like "log message", "commit message", and "cover
> letter".  We do not want to use the word "patch" here to avoid
> giving a misleading hint to line-wrap diff lines in a patch ;-)

I'll drop "patch message" as well.

> "before and after it, too."?  I personally do not see a need to
> specifically say ">" quoted text and what you write in response
> to that quoted part are different paragraph, but some people may
> need to be told, I guess.

I'll keep the note that a quoted block is its own paragraph, with
"too" on the end.

Thanks,
Okhuomon
