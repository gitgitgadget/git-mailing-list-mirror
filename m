Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60C2D978C
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111799; cv=pass; b=r6HBJPe/MApfMeAnLFYzrncsUJVqRi2td/yQ+BWv4PV+u8XWksj29riHxFMOhxkfTSCOoCLRsufr1TgBAKC6zOG3RBaUOHiWbgbRbZV6oVmHobTNgHNp7AO7YBZo5MgQdw5U3EXrObgRqfbQYGkQFKaKrkmgpur2mo3fkFSULQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111799; c=relaxed/simple;
	bh=Qd/itoAAmWhYYxfHsX31zfaSyMi1qRZYv8xgoCCi1qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHxPyqpdAlsXyNhNQGfxEmA6mg/ieYw6O46/xW6aiXymy8e+WanNgZbqSoA/O3L6kLJ6lhtNfvU2eedhpsgojP2BqHmXJXROoU1G8tRA5KDL2yEWimPlouOeefS4DZAkzIqmYC1roehiA8fFrikDnP1ZZF7zg0l/OklAEGlD1g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFSniWE7; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFSniWE7"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271195d2a7so1932348c88.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 23:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775111798; cv=none;
        d=google.com; s=arc-20240605;
        b=dXSMy8+ZGuKNJzQ/Xui8Qi7xdSbsNg06avUOGAXkCq6Q0SxafrSDo5e6g2z2VkTZ2e
         kcFfsO5KCdeEoStPlqYWv+CQOas2JjiJOcEC/a25p4rudYUBcKVuxIU5IRh8gye70oFX
         nViU6HSY3QQU7l5nu636eCdGkLkQeR0fu5OVEzTYkaOU028zLR4erQD7VZnPBnLz8xZg
         37jIm2x3W0DMxse09x3itAuTvSJKyZn37cPpCWYUnHwv43Ds3bMWUQ1Nh8dp/jCTyjW4
         wsNyXeeIbuj1p3SgpgquOsAb4bhycq/cKjBRHFSEwDCGCdf+ImleYdmP3aLl5M4sNECF
         nv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+bjISLINlbf0ekwF+tGUwWQ0vnrVF1k+SfRimpcAbQ=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=LVrW2QUxdv7hAHzyPeGe05nh1d/hddCqkcRE0Eu2q7L+xyt78XnKi9QFsQoGr6Z3v/
         pYfyf1Wqj8eqiOI9/Bhmq26uuyqFGJ1soMWlKnOh2ghFRjJhahVE34CbspU9W3mTAFyP
         sXDyFwCSul2a5ef+mK4ieVCcYkelQ5eBdoVLsyA7eAHTuWC9S77GiQOk5LRf/wfu/C8O
         25SCA5wyvf3PZkCmoBMUDWjwssvkfFKN3gx8QrQFMattxrA5wWtoaTEu6pMkaNhrnzQl
         dRSSI8lVTFIZGZVGHWEksZqLJ5rltKnqch4Y4H8inPUpoVr9FjBtWlPE10yJ8OpM6+jb
         6Vyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775111798; x=1775716598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+bjISLINlbf0ekwF+tGUwWQ0vnrVF1k+SfRimpcAbQ=;
        b=VFSniWE7EjSy4pxyjPDdib7nkCFr/7zqw0pUXvBLaBgh8gYi3gacijdI20N7ItdBxv
         /o00teuLvuKPsUjZCst/N1LRHi/PjSRM2GUas7jLUuCIBTm+Zcm8PMYXntL2+TuZvPpV
         Ins+HbpoOJaU74eSw7CmVUfGfH/A6xTwz64GK3soNyiROX8Se7uZY+CtqMDB6uN5gjRR
         J3fwgANyWW0fegy6RWTmFWklyeXuyOUqhhD6Ajpk6Lnx8+TkZ+HkwVHVlpi2LaISXAd3
         O9s/dsadu52JQ79NxGK/1N5vFki9rbYLGX5usBdQyHU8J6KwJlyVI1ArVj2+JBc6jlOj
         NZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111798; x=1775716598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+bjISLINlbf0ekwF+tGUwWQ0vnrVF1k+SfRimpcAbQ=;
        b=pZXi25UfF7XxMSGWGobIIjKlkikX3/38/H8jX2pxWA3/ZYLnBhv53fskmJjuRHK1tM
         miUmAGCSez/HWEjIp6oEqeFQXurb7zPPOp67EsWZgoNdHWObkB6RC7HIXhZ5Bem7waMT
         1taDUj/sADu6/5YzqCdp1B6IoeyZovkWIyBedgq7nLRF9s9dosuy6aBI7t5qlKSpJ0gQ
         keAsrQvmNwuGOfJJ6pIZcOHltxZSIrctaT262zbXFxQU4jBLGmg+YzWEH7XWqQTOOgJg
         wjZlc0fnMg6OCRAF4eQt2bfoIYXpOkq8jVVaP9zpgH9BSF0E2JBkwnlgHxo23QnHYCf6
         qU4Q==
X-Gm-Message-State: AOJu0Ywn4klMYQdrgJYZVdN6dJQMxs4WK+nWUu0V8GDWiOOjjhXSWeur
	74gEX5JMvnv9G08AgLAxcvEaU5WnCo89QWHeg/E5pI1LhL1cbMvT0bK28fXhkZUOTG4Nfzt5IGX
	O9uxTHkZxV6Lut3fJKk99/wYquSqKg4k=
X-Gm-Gg: ATEYQzy8k5hFXZCVEKRjjGmxPPt9LFKn4lLbY8Sw27D8ZIptOQrnEuSPISrIv7gCTMI
	ilCKkg7Bc4upRUwXUiyZQCP7uaXvXplmuhahDx10lQ62yacw9rwC5baK/SCiTfUd+3RO0Q9VtQa
	n5BQwcm8yEoL429WT4vnWP04RVtppqmnJVjLWmSd9pDHBsFV8HhGKz7xRW+6rEkQCxXuozRseNW
	OMmvAnv9xOIU/FMaHu336KAUw6gGHC7pfwq3w7lVPpFEl4Up4g1OzzVsWEEpaEGnpcXvJiXH4Rc
	3mB07BtYiFnIc7XUuv4zOOW/eu3ztMTqQwUMobL/7SXJLAZ9FZkPSjHrSmMFK0QFyzTw
X-Received: by 2002:a05:7022:b97:b0:128:d7a7:5261 with SMTP id
 a92af1059eb24-12be653ee54mr3641213c88.30.1775111797676; Wed, 01 Apr 2026
 23:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-13-christian.couder@gmail.com> <acUkx8KwusUzYqne@pks.im>
In-Reply-To: <acUkx8KwusUzYqne@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 08:36:26 +0200
X-Gm-Features: AQROBzAkxWblc1g-JJ269I5SMGSl_U1xPS0NBLGuzYtGEzzsuxBzJ_lpQzWdMmc
Message-ID: <CAP8UFD25LFuUX4m0EUooGQimb+h9K0Vn1AGisyPyocbqj6qTug@mail.gmail.com>
Subject: Re: [PATCH 12/16] t5710: use proper file:// URIs for absolute paths
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:15AM +0100, Christian Couder wrote:
> > diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-r=
emote-capability.sh
> > index 357822c01a..c7a484228f 100755
> > --- a/t/t5710-promisor-remote-capability.sh
> > +++ b/t/t5710-promisor-remote-capability.sh
> > @@ -76,6 +76,17 @@ copy_to_lop () {
> >       cp "$path" "$path2"
> >  }
> >
> > +# On Windows, 'pwd' returns a path like 'D:/foo/bar'. Prepend '/' to t=
urn
> > +# it into '/D:/foo/bar', which is what git expects in file:// URLs on =
Windows.
> > +# On Unix, the path already starts with '/', so this is a no-op.
> > +pwd_path=3D$(pwd)
> > +case "$pwd_path" in
> > +[a-zA-Z]:*) pwd_path=3D"/$pwd_path" ;;
> > +esac
> > +PWD_URL=3D"file://$pwd_path"
> > +# Same as PWD_URL but with spaces percent-encoded, for use in URL patt=
erns.
> > +ENCODED_PWD_URL=3D"file://$(echo "$pwd_path" | sed "s/ /%20/g")"
>
> Can't we do this unconditionally on all platforms? "file:////foobar"
> should be valid on Unix systems, too, shouldn't it?

It depends what you mean by "valid". Perhaps it works and would
simplify this code a bit, but I think the standard is 'RFC 8089: The
"file" URI Scheme' which seems to says that the `//` prefix with an
empty local host must be followed by an absolute path starting with a
slash, resulting in exactly 3 slashes (file:///foobar). (See:
https://www.rfc-editor.org/rfc/rfc8089#section-2)

Appendix E.2 of RFC 8089 also seems to say that
`file:///c:/path/to/file` is the standard representation for Windows
drive letters.

So it seems safer to follow that standard in our parsers and tests, as
we could then refer users to the standard and possibly make our
parsers strictly follow it and test them against it in the future.
