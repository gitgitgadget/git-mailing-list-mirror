Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E53F8890
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925120; cv=pass; b=jubWHBhlt7Ss0d7f1QggZnWVMXYJ2U3ma7oalRJvNxRwzxi6v25kwlsrN2TMSnzFLZ/mTL6UCMF1BYbXXsQJfu2wXm3fqDPuyxUB/0bZ3VM/0yr+Nx5HuiSOtH+R7KP3umrtv4K+t30t7kIH4or4Nr84VlyyVJPoMQ5Sy/ODUoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925120; c=relaxed/simple;
	bh=vpExXQEDfTqKHD2l7PXwgvIJvLBhlT6YKQVPwzGo010=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3J1mVkQjhR3epezWR/N3SiP664N3qilERPHC3zE4Gm4njTDx6gkGjydoHhV0G0CJzyTRkUaHweT89CXuF5Z6UrZpUrEniB8fZDXgG2ejFcwXiylTlsxg6sxsXVYYc8PbjT8FfHizidwSSxofF45+sZHl8H9IJPLRD1dOBt39Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/k3YGW6; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/k3YGW6"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a0faa764beso6667441fa.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 06:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787925116; cv=none;
        d=google.com; s=arc-20260327;
        b=EO8VWWUzJ/NP8zx/Ox2z6/jV7/CocuZDwN9nPDsADZSt/fxcEV7JrxwH0YmI5tjprI
         ZZO7ululzNqWg+W8iCE921KL1YEw7h9mzZz87xf5UomTc0/imVzKbMQZ8pIHTnbVASdK
         AUMMhntwzEdynn2lojkM5eFG8HlfHfBp/Pm/Y/oR99MBB5+P4idlVdo4QxrcexuBs1ZE
         QGfYKN14ZT03MD8h/UC8VZ0AHCZZ3G6BFAXnrdZJauiswpJP+fnty9+iBnniwXIUsxcU
         JRZw5mbCoU4QsjhVrz1f5pBnSVpdYtNWXKrnfkKtdVkCiy/z1PvO1shoskng4Ezi1a1D
         34XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rtZGOIIvHScuO3Z1bD26a7URDaYOSo/hYDmGODoKfu0=;
        fh=2+9D9XrHc+BqZ01z1xDvlFZuapUPgNsCu3EsPDN3Ewg=;
        b=k3gXXy5OY/BVPPCY3PQde8z90/pIYBnwbesDY9su1FSKP0UVnquaA08+9IT5mZ0XnD
         HGlZJ1iz3BcfVjBh11tmUyzKR/W/tyIiWVcDzaqmx/ri20N50SngQIm4vzYng7A+NBpg
         6C55YL2463oz14xhx+PXP2+Lhgs6N79B/x4cFVHrB6Vx+9ecRuYz0Ixn4bvQKdNzHaaJ
         4z6XatV19kH9oLRkFSqIASFIJFi9Hbrah9joTv8/C0AmtOW8DUNhkRO197NepU0QFw3V
         xMSFBURu0afiZMfRlrdVkc9Fc7gmVOzQnR9GZRa5V1C0P3OoPG4pk9J/GudNY4ROKzEk
         nb6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787925116; x=1788529916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rtZGOIIvHScuO3Z1bD26a7URDaYOSo/hYDmGODoKfu0=;
        b=o/k3YGW6pdR74MavwGQaq+WYubnBGeyEOdzX2cSeeXP6Hv90Nm0ibqUbb5iTEdz+A4
         UvUJSwEtHyo3kD4fEQd3aiVLpKPjgAqXbSvvGlTq9oIG9my6AGT6TKlpAtZpoNgjnB1B
         qsaUg5rn37oAmofbLz+d4iIRO/7FEQ/GfQiWGQIe16td47jd5CB7zio/MXLlhtDblIQ9
         MWv1oZ87rjTtt4mHXDhFtj+R82cqLgmnCxk4W8CRgToUiqRyftGZAQZqht/ON44wtZgv
         kwDjsPsg0qQ1XG9fx8xIog3te54PA9mcx6TIHSK5vjXkI30l1XGnax85J7ZckCa0vIsy
         D/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925116; x=1788529916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtZGOIIvHScuO3Z1bD26a7URDaYOSo/hYDmGODoKfu0=;
        b=YarzBdjM4eYu+FzGYapOh2E4MeUXXBWbnTzqjhcFFuAKsMb9KS/3tqDoqZVVeUCz9a
         53jaCssuARkRTIvPY7STub3bop+0U6cwUyFbMA0DZ8sCIFmlklZXxXmg2lnxnmIoUmIG
         S35LrL09NVXEX5CQY/jdLkpEz7rzCibDe4CRbw7aEvExBWr2mypeYO4JxCZEKeDYZ/VL
         PKZ+4b5XeS5nP0T2S0fZ39UXv+EfSVknvpdxdfaq87ukvH/JLA6as0pXidF02bmR6EqN
         noF9ikXjv0vHofD+1sanQIdIy5XY1k4Nxq1rK7rwFrq4VxaV4/DSOKodZcvTPf7W01gP
         BgGw==
X-Gm-Message-State: AFuF++lLhDvz5nRbah7kekmhPOURfD7ql+MSWELHH77dZhH9X3IK87Uj
	KjfetIGrmiKrxxLf1ofZpxMeb0epT/AvwoYbaH4N65OXmzGGy7tfdcJ9C8uFvRGczBW/QnzwhuW
	CvFoZ6f4x9tXMCaohG7bJEse6zYvIjxk=
X-Gm-Gg: AR+sD13u4KzT8p++5Fb83Ivoalyjh3JLmCvwzH6uYLEfGhJhAtA9zy2i0zer4nLWxx7
	IImTXWpsPDO0tqcanuip5Ka4W9Di83aEcZUHpr3bwpHx4XOmAkilTvok4EmJukl/Lb4y/+pe76f
	73Mfsuf1s9Sfy5HWPDe6Bcp1eQz/DpaIWDKL9XnIRfyO3lbYcffU4vunBwrKh+rEI0qIQunWKsQ
	/Ft//dBF3/naXAdRqBdsP5e0RSt6QKCs+eLVgu9/k1uAf8iUz6K4FdtIN7w36JhsdZSBI/r0xuT
	GlhzwZlqLRtquu+i913VcN1b28pZhxfhWLP1gyaWWQShlX3eI/DQf9hX9z3afVbDXF/yzY36uOA
	6hMQ=
X-Received: by 2002:a05:651c:2210:b0:3a3:63a:bb06 with SMTP id
 38308e7fff4ca-3a3063acafamr8520181fa.13.1787925116232; Fri, 28 Aug 2026
 06:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmruqt36l.fsf@gitster.g> <20260818214858.65122-1-ggordon@gitlab.com>
 <xmqqpkz4czhu.fsf@gitster.g>
In-Reply-To: <xmqqpkz4czhu.fsf@gitster.g>
From: Grayson Gordon <graysongordon1@gmail.com>
Date: Fri, 28 Aug 2026 09:51:45 -0400
X-Gm-Features: AcwNN1Wvx2hqGBRjNo-dZJWoocqhd7ad_ZMBN66P7nF82Xx6xx8O3BxAntCqQ20
Message-ID: <CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP responses
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, avarab@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio,

Yes, I was hoping for clarity on how thorough we wanted the testing to
be. Patrick added a lot of great stuff that I=E2=80=99m happy to use if tha=
t=E2=80=99s
your preference, but we also talked about wanting to keep the tests
succinct. Please let me know what you feel is most appropriate.

- Grayson

On Wed, Aug 26, 2026 at 6:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> graysongordon-gl <graysongordon1@gmail.com> writes:
>
> > From: Grayson Gordon <graysongordon1@gmail.com>
> >
> > git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> > OCSP "Certificate Status Request" extension and any stapled response a
> > server sends is ignored, including responses that explicitly state the
> > certificate has been revoked.
> >
> > Add an http.sslVerifyStatus boolean that maps to
> > CURLOPT_SSL_VERIFYSTATUS.
> > http_options() is already the collect_fn for a urlmatch config, so the
> > per-URL form works with no changes:
> >
> >     git config http.https://example.com/.sslVerifyStatus true
> >
> > Defaults to false/"off". This is due to the nature of the OCSP protocol=
.
> > If enabled, git would expect to receive OCSP stapled responses. If the
> > stapled responses were not present, the connection would be blocked as
> > the status of the server's certificate could not be verified. This woul=
d
> > break connections to legitimate services that don't use OCSP as their
> > certificate revocation mechanism.
> >
> > If the backend can't check the staple, curl_easy_setopt() returns
> > CURLE_NOT_BUILT_IN. Error message includes curl_easy_strerror() with
> > the option name to enable users to more easily identify a libcurl
> > built without status verification.
> >
> > CURLOPT_SSL_VERIFYSTATUS has existed since libcurl 7.41.0, below our
> > 7.61.0 floor, so no version guard is needed.
> >
> > Tests are in t5551.
> >
> > Additional note - I put this in http.adoc:
> > "Defaults to false, which
> > allows connections to remotes without validating whether or not
> > the certificate has been revoked by the certificate authority."
> >
> > Technically, there are cases with older combinations of GnuTLS
> > and curl where the revocation logic actually WILL NOT allow
> > such connections. Search "OCSP" in the lore for full details.
> >
> > Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
> > ---
> >  Documentation/config/http.adoc | 14 ++++++++++++++
> >  http.c                         | 14 ++++++++++++++
> >  t/t5551-http-fetch-smart.sh    | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 57 insertions(+)
>
> Are folks happy with this iteration?  I think we have already
> reached the point of diminishing returns before the thread went
> dark.
>
> Thanks.
