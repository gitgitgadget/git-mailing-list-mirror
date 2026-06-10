Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC481DE4EF
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128825; cv=pass; b=rEXVRUeRSwFQujdJE7r5FqsNegFZyNZif/6zRQOQEHJYG5UX15R6sOJ5q0FeTfOYYRxitSmlKwgCmAErpK/5Ni+SQebsSwYAqfpH9N3j7Br+2TrFWwq0cjTpfbXHuEZx+aw61k7eS06siRCEipE3NWxqUoc83H0r+JelLNMgkEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128825; c=relaxed/simple;
	bh=t6sGtCHsP9NXKZgppFxUVq1Xyv4NEcDswNx3HQQIHck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9j+yYdS6sbfPbHpP+dv1vEcdoEdoOlR/JWhQhv6fGvnW9BHyQdGsGXWK57Mdjya3rnUsPWJA07hJDOXz9yX84FNVZxfldKROQH2ah5D+jAlZeHHc6Pt2zcHZpVEl3om4ixISv/fDxeWsrMUAHZAm7Yqh/89528mQ1R2YppEMfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMZDRQGj; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMZDRQGj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso56318135ad.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781128824; cv=none;
        d=google.com; s=arc-20240605;
        b=bf5J+Qgh/bjR4F7+oPCqCxufk4oW9seNnesjpN88AtPFp5P0m/jn2wiEJ/gn+ZkuD2
         8Y5ajIcRuRaFZjg3S+/8LgLoZKeXKgsmXxGBsc1uRFsjh6ZB+M7BDfYR/HeKadOj092B
         hdYVekUmbIrKHL3sNJSWDZbmJp4lbcPokfn8ICSqG+sQ6X7J4QXhMrN9ndQo8yKBReCx
         2ehdk0pjekQijV36ac8W3xSJ0LTgVfGgGK4SQSgO4k9ZmfJLUurL+EuFUQciMMyHU/+Y
         v8svRPGI7lwF1KMcFTc22TwWuL40xZpo6+F07gqRWdnv+k2lZ7xfsWBowWr0iJ9LqQao
         YZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6sGtCHsP9NXKZgppFxUVq1Xyv4NEcDswNx3HQQIHck=;
        fh=2ZqOkygQPiLG09KuaUBLmelfP4NyTv45iJ/X4ZTyW7k=;
        b=HNDsGyzBJm65D22VLKclHex9QYfu6L9obgCeLAkXLoapNnc/Yyqx0+MMySxvvbpV1V
         TZMHrRXW1bvrtRBya9eWZb6ex3JplmV7aM496uIP0NWDNneb9odKXXj6wLv1LvH93wQH
         B553QAFiRT6rAqThJT8u6l6Ggo3ufbMcoJvEkI6uOGD/TYUa/6zMK8CE8ZYcIf/W+tIw
         cyGQD3MOGoXw+QkNRB+B4aehs1BJFDBiBnwfbmfvF+yJ9yqqF+wxGSTBH5dmdRRSC+ut
         I20HfDo5X2iCy4mDS7zxpLQaLyhnlhhqOXDKOivD1cLx6+b13Yq/nMNo8UqM/k5UTiGZ
         xB3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781128824; x=1781733624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6sGtCHsP9NXKZgppFxUVq1Xyv4NEcDswNx3HQQIHck=;
        b=lMZDRQGjbh6xnl3CyKwr4HC8Sf2GcfEsaNfVj3Cao69+x2jI6RvYuJBvvj+Bz51tW+
         vbYTk7F38+CzKBbSvADTAYTtkMPNuWerxBqyx0FOFaQSBArQB0BY9dAmjcreQeu63+yU
         c6cP8pCJnSvl3Asu5/LV5AYgQsagXu0b7wICEZNMPBvU8NCNFU/C53+bNwYCds2pN1VZ
         4wbNQwMJJZrWchyHx8ca2WfbyOzWcRh67bIMFdp25nA/IyeefEbkDXvhLCGLk3aRjAj6
         VIQBmNMR4tA+ozthXwAaOIV4l59IbQx9rjuc4GqJ3Jej5TcfQiu7bgwP7z0+3Algw4FT
         m3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781128824; x=1781733624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6sGtCHsP9NXKZgppFxUVq1Xyv4NEcDswNx3HQQIHck=;
        b=HEezyDwKXwF4cttvRL4SFbEVvFMqYD48qnAhddwpIEBl6H+PSRZn3Dh+yRoTa64dg1
         HZFnULXFnFnfy01g6plSctkdvBiRgEgv9kLeFAZRdHNLq+ruGmiV6t8TlT07MdbDh2d9
         J379OMis3jHYZRc0L2LFMg1so7flF1by2yGZOm2MGkDM8ZZcPtXtlCbmpNRzTSgQoTfO
         QfOaGTwlZzhUviqfKAa6D1YgnDWv9bAUSd8bxCCCUjhiLLprL+DoLQGPXqX1bgKwjpLE
         qS94oIHCHB/iyZAoXcQdQA+lOt6U5p2JTrfZOqb3hfDOpVQ+5c9DPqIOXZdCieoxKF86
         Ic7g==
X-Gm-Message-State: AOJu0Yz26muheDpRqFA1RGpZjJf7i2riWxF43Bd2T8MvmFITZJ0uynkF
	LtEIUemYBDflyISTzHYiqCPMxsDUR9+MZdJXkM6CehNj6b+jTd4Dl/+VklOBLln4YQ+qxColzGf
	rIkG6I4MttGWIb7jR7CIh+kVQeFFOWBg=
X-Gm-Gg: Acq92OGXRx8Wsbx+HlTALPcqbtX3+EWGbmCglfHzDBH0Qo5yPOIo+Jq1oERtshn8/h2
	wcUDKXg4U9YgEC36PsymNXdIecOL9ZFdUuosQJrG/A+vU3EGKCXI8o12NBbomG9wtfICs0Fw6Lc
	h4vzSJRxrjzdFJj5CsLJFoIuiNFoPJUPzuLj9DhWVaSoTr1JI8RX+87RfJCW48drHPaIHAFR4Ij
	43zQTeo+egWDLmZ2ihpeAvAG1g+95sQqK7eEf5sT9LsEhMNGN4QMQRdyCyGG1UtlBo0/AxAzGTK
	i5V4gU+c38xsv7eoY8I9ZtcUTPpdOQlg4UAZzuk6zWiaRPOP5g6zuj55XoyfqgQYk4OszZb6XkQ
	pyA1YEwj+WaRrIw0=
X-Received: by 2002:a17:903:fad:b0:2b2:ebed:7af5 with SMTP id
 d9443c01a7336-2c1e7b13addmr302756925ad.13.1781128820473; Wed, 10 Jun 2026
 15:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
 <V3_join_paragraphs.8ab@msgid.xyz>
In-Reply-To: <V3_join_paragraphs.8ab@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 10 Jun 2026 18:00:09 -0400
X-Gm-Features: AVVi8CfyEjlcUszTh9SQzdj3ftlbtxQz_ZBNqOc8iB-kqZlm_1qrL41EoGt8z90
Message-ID: <CALnO6CCg4ubVz_VJuFjn7tvXqADR40AdjCFJ6xfRcms9a+GQWA@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] doc: interpret-trailers: join new-trailers again
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	jackmanb@google.com, Linus Arver <linus@ucla.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 5:24=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> There are three trailers that talk about how a new trailer is added.

3 "paragraphs"? :)


> But the first one is separated from the other two by two paragraphs
> about how `key-alias` can make using `--trailer` more convenient. This
> short how-to does not follow thematically from the previous paragraph,
> and can wait until we have fully described how a new trailer is
> added. So let=E2=80=99s move the three paragraphs about the new-trailer t=
opic
> together and move the how-to paragraphs after that.

[snip]
