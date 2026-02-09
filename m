Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F442049
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674278; cv=pass; b=IYt02FjxyVMvX8xMXOIUA+abThqpDurB3ga11/cT7H69D9UWo/6OoVlMdTz0Z+Q4kL2PTHEJ9SrwiNIO7kGn3mrwuEIlw/Dr0Amg6xwXDVt8LZW9XH1hzzUgmUvdb2c0snvLuVYl+RptVU40O7ss1CqfYE34w54NriSmMXMEwNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674278; c=relaxed/simple;
	bh=wbER0JCUh6hOW2yAla+z4SuFsgdwFsyQjtvcjmzel0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thA+8krLwtaqgg2kopor+oHyhDYNU6UKVFzTrFOiEQAQcO0Ym+FnfVIj2bcfFMPEAN99WXpmeUuItvLS65cXXUQKL1o1McYEeTw33b8PGFBNpd+P/LYNdb0WzjrMZq17A+lYslAaaOwp8VYAWM1TGSFJ7iQLpwIiJDUJqUDurn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afdxw5e8; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afdxw5e8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso2879172a91.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 13:57:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770674276; cv=none;
        d=google.com; s=arc-20240605;
        b=Cel/n3O3SNgyIniaQmTgfBam5qAG4XgWGEBmaMjMYggje+hLR7AcRIaqQ5bo25UVEa
         6+9P8HCW09HV3FnGCF/9h8Rb6eN8T0q18ymVUxX1FMzmP01mvZa5Oa5cVb0m6QqNby8o
         UQsWJaLSK+eohBzhGPMYHDESJKLO/02XTLinsjjwSSI3ZJ0tWULpZ2cuGywN07WvWYVj
         zmbs/SVPmRZUM3shiWWz4CjxyDlNvYZx3TCuNZ9AV1gY6LeWfZC+3v9HOeYbjmfLttj5
         lC9GzAwHU6VbZ/HGB9iHuIT5R9ZqYU4KIL5DzX2ypB0fCAr5YIh1sboAbQVGQjJXPq54
         UT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9o6C4nybvWwzWRcLRSP947nJWIZV1hD0hlEHEj75fvk=;
        fh=mJbBesx+oRc26OZKm2CZILTBbLe8BCinXbh84KNv+5A=;
        b=GnR+UVSYw9wMnDH3L7Et0PFFMo1MgdYKHxe40r35pSzrHExFuhKRD/eYP86Fffq+th
         +bUN/9vGL2AxczyqMP/yWChwHg5P+bzM5UD1aES44X2xLCQt9I+hDBqicpLmUnHpO3c6
         liE80AKxZNoMMjIvoJgdeWWeTgkTnAi8I3E0MgJoH4vqcOqGvfF2y2syx0TN2n7QV8DO
         6QLGskwp7LZUMeZN5IQPOLfbf4UwYCWJimXrNKcI2SISB1WZa4o52faLKgfstYzUep3Z
         9eDXZ+WsiaNLpusozKBCFvhRk0PECS5DL1JmpjwM38WVPE5PZXwFrotcpR7qyc1hWWG0
         aMjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770674276; x=1771279076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o6C4nybvWwzWRcLRSP947nJWIZV1hD0hlEHEj75fvk=;
        b=Afdxw5e8retGqX/E9YnPhH7u4NEmDKWGcP2i/fKk2+ce+E61YMuFyUoa4Ilmm9WrU6
         rkKAh94OWwalHn/M+kWYO7Yw9om7z5NHgwAyM++YrDSGQYWbr3hV/hDOT8Bh2/GREsAL
         1Bk4fKkYz+GqzCRWl7LLAze5T8tl+z96wNSDyvfdx09cIzyK2bBR9UftWK3NzafR729+
         XpCuJUnhmC1xm7hPgs7HlQMgtZ4u0x37apsDGq50+r8gODQ1bFO1izEGhILy4qanxMJO
         fZft8WcnVsF8GWOZabZ8HA1jt72lIGy6X8dR373YafzT8jyXZd3e3Q/rNbp5m0IlEyPr
         E6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674276; x=1771279076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9o6C4nybvWwzWRcLRSP947nJWIZV1hD0hlEHEj75fvk=;
        b=oOS5ySm9Z0bdgeQ+oIofRLmB/QAaJLV4Ar0hygTumQd35JxEHHgIyz9Ad32hn5B8TO
         kUqlqSms4NiUW3Fl0tRcxII0WIJUOYpKEh3ckOxrxa4AoSVPkKWiQgArHdFPiojIVLWr
         LMWvd4mpDAaCp+fnD2xdVLpZrAAyd3ooCuIG1Y+f5eMqa45Nbfs2tbLyBFwPNuRjOsWo
         w6WmgzjZyATEpXncBEcIT6ahJ0Vmr+ogdp0rycIMRkt2M9S5aYq00TCn96ob7uqTHMpm
         z2tsDBoCdAc2dqNsQIrZzcSsrsOYN2nlYD3kPAky1xtbIkydMTX60YyNlVXFEaHYTgeq
         36xA==
X-Gm-Message-State: AOJu0Yzw1bix7YeGnbmszGLGwDoLBPsDEihodELGAPFUoSfm8fhpyhwD
	rUkGEtgjOMoWM0gyamSgkuiCgWKbZ07H+qNAyvsgbZ7SWqwbL20XeA0xSlceJQrxFySB/8gM3z5
	4n9Qa94+DHBRgZaDoUeqQB89z3dTyZAukWg==
X-Gm-Gg: AZuq6aJ3O6uXledLbBSbb5qsn5All4hZALJScCDhb3ui9wkA2uJtWfDOfDgvaHL5Vv9
	WQjPX//WxPWwRU4F9/6GwsReI8gOnKvFpHIY/GbGgIlve8h0GuyR/WE62gHyMOPhrW1DCDvjP/1
	4aBUYdns8Lis2pXSd93CED61X0EW1OTHJYVjTCCwqrmKNUR3A9KZi0rIuhNbzv2y8UQHJrI/DIt
	KAY8XzHqts/sli4NrxPy7mBQUlPA4OrDeHWC2uIs+MSHyAQyE6QVp0Su1KySIvsK4mOf7IUmBIi
	mF/NtLOtqOK2ypkgb+tEUJvYxn6u9WTRK+2J8idIoEbMqSzKeNjiElf6cS+3pxoZKwqc
X-Received: by 2002:a17:90b:5748:b0:354:7be4:a250 with SMTP id
 98e67ed59e1d1-354b3bd326dmr12468251a91.12.1770674276258; Mon, 09 Feb 2026
 13:57:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
In-Reply-To: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Feb 2026 16:57:45 -0500
X-Gm-Features: AZwV_QgyzHi3fh7bKobwE2ej3flFw_lFMkPYq16wkhj-XRbsrW11hNa0QVNcZI0
Message-ID: <CALnO6CBTWTqfVNerHQb0X4Y4UKXggRdqzgXqYKd_O05shC+jNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] doc: am: improve command linking and add am.messageId
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 12:35=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name: kh/doc-am-messageid
>
> Topic summary: I noticed that `am.messageId` was not documented. In the
> process I thought that the way that git-am(1) refers to commands is a
> bit off. Replace all things like 'git am'/`git rebase` with
> `linkgit`. Also fill out hook documentation.
>
> Notes to the maintainer: this conflicts with topic
> kh/doc-am-format-sendmail in `seen` because of an adjacent paragraph.
>
> Kristoffer Haugsbakk (4):
>   doc: am: normalize git(1) command links
>   doc: am: say that --message-id adds a trailer
>   doc: am: add missing config am.messageId
>   doc: am: fill out hook discussion
>
>  Documentation/config/am.adoc | 24 +++++++++------
>  Documentation/git-am.adoc    | 58 ++++++++++++++++++++----------------
>  2 files changed, 47 insertions(+), 35 deletions(-)
>
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> --
> 2.53.0.26.g2afa8602a26

From a quick glance I don't spot any issues. Thanks!

--=20
D. Ben Knoble
