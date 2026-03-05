Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61690384248
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709208; cv=pass; b=HxWshPawx/mt5IZ8uvdj7/oUNrobMK+AIAfHVwKtfsfu5MegWtIhH2PKlNBZHQLMbFNeN8DGuAWdwfCYz0yvrEnDk7xlNrB+HObfwf8UBlNkXkyMquKM8Ye/EsT7vT4TC5Ji70/2mpVl4a98X7fhjDgwV2cOFzZzFWR10/7245A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709208; c=relaxed/simple;
	bh=LzAT7CwQL25fjKmu3YrSTWDXR8eUP33eFVSUD1VKiLQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=o0mlTDzOt3nN8jpPWKfvaYoAGyVOU+Pkv6qkIRhnbUslwSnNqu0LyTEqqQsalvJSPXkPxaAmAIIGNxRAIu7KnLIKlRGznu7TsdIU7A+YITOBuLBSgnh1vm1CcOVdht/lshi99LgEbuKfDoCHGw5yJfAqVuxcLUAWelgCene0ZKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIc8mh5u; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIc8mh5u"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ff05af29b4so2824905137.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 03:13:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772709205; cv=none;
        d=google.com; s=arc-20240605;
        b=RXSVdMRVLbZw2DtEWtXz72EnIysK4Q+7m5sRQT/2V7wwPUC1k9J5nTifoGjdgwlevp
         odIvGZMARp8Qv0NuseNzkJkZAs5NHPAL89/YEjbekmdOWSfErl2qmH6JUnR6Hfcp6J5r
         a7XNxV8Ua94PeBJv02t6MKRPh51PlXD8Ee5ftSdWaONCJG2yvfNqifb3w9QYBPAOIT10
         EaXpqqQ9xawOPyjk8b4JpsIXs7i1PTl1KsLyoX1ensAVL5xtvthX5fwH8LGj2M0Fhy24
         k1YNcOFniimeBc4cjyB39/7DlnslJUrYmxnWreZJw8k1G6feDGIoZ6RPFbxY3B+SBTOb
         moNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=KqnpVzuxPmOUCnGuBN0USuCXk42iHSygQe/WQIZr23k=;
        fh=sIKThXvWqWvyT141nKwH9vBDdqfZdKKWnxvoBPuhnK4=;
        b=HzX8jVu1VJ/Dmg6w4NzVhlsdNluk7cZ9rxqTw23wyc6NxxL+0RK85LsucjPRfG8Ejt
         K2EhdX0K50OiqI4ts122rykqxrmrWpyGOX8BQImdHz0n1DKnbOL7jYVzAPDZhg7rWbVf
         m7LLnkh/qjl0qGR0pe72p9c1Wyb5PGWh6dRWTj/K7wdL2t4m5nqZbC5lDaqdnrM3p1pP
         x88i7XBoNTOURMPW6+uUiiENtQnWQ7Y9phwzBEAH+2asv5SHaSkYkUwO2rWzxj4Xc0pz
         NJOvPj2LA4OOG4VAkhzqWxmgt8mRA9k7gtANcBDg2FhzLQn5dQzocGLhl1Dynyc8v8Gs
         54QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772709205; x=1773314005; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqnpVzuxPmOUCnGuBN0USuCXk42iHSygQe/WQIZr23k=;
        b=JIc8mh5uk+raA9/gQ25PirgGkAs6yoULhNoG2p7Yz0mQdTnRgeUTKSumbnjUUHsvaY
         Xts0IngHXbOkvgvbQgpxrCUJgI7CakV6psfZgzlKOTcaNNNWCXl6iyV1WpP4vr7ySWRd
         ESisMWGBCLES4GW3Ke+KzfaM3/V2Y8qFcs4Ty/qXMc921np9IYM8OeYsdbZTI9w3DjC6
         Ma7ToISC0Jy5n1cbrDn7MojbBx6hNs7e83pmiaIziKcbkYCW+zM2H9Hd8HU7Ubrg1HGn
         tjGxBmKA/nHEPT4g58F9pNnD67HGBvPDMvyPV7BjOWxErnuAFAmGct26+A25Djcaf1b1
         +Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709205; x=1773314005;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqnpVzuxPmOUCnGuBN0USuCXk42iHSygQe/WQIZr23k=;
        b=JUhx6B5t/+FWyg1yNq9lGs3SlIgLxh+tWEdjsoN7C1S2+n2W3Bc3/5uTcviMoc83OG
         ox9R3UBaav9p98KkeP+ReBP1J1Q83mfZp0tSPNJPh98B+JpldxnUZTldafDS+djBiYXk
         i2Bgc80CZm0rJ+f5HtWri6grzvDehHVEHGdPnKz6n9YyhxrA3t9+0Yz5pzgl3TzCGXIU
         Vr96PS27d7UBygK5UraQCwcnAavA3P35w6oYPWMTERJjen58HLCFEjXlQt8ChrNNjPQb
         5UgyFh8trLPG0y5POYql+4eacg6qgs9nIkyTT2r+CJmBCXOOGW7SF0h5odX3dIB34/48
         bcqg==
X-Forwarded-Encrypted: i=1; AJvYcCXmKauo7E2JyQHNht1uwB9/ICjluMCM/jLAkX+tJvItZpJxPACsdWTtDVxZi76Yct3cr7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdajJE3f/iR5k/Lf44qZXI1zppWNzH9ajWz/n1hc9MlJ0YRRZ
	Vd8nzOymnnoFf0nJ8X+CtH/Fe/iGKNLX2QTLewY4A7LngUmeDw2au+vxu3UrZISLrjXUq1/5GKl
	UfqDN8bXniCp+3mLLjGld7A6VQ+hB1PJTR8BR
X-Gm-Gg: ATEYQzwUXG35OAxtruWC5fbriNO8DI4g0LRpgW64wtPGVBDdsbj1kX1YFMwB4prMYJC
	jJ4JMrM1JyOUbhvwiovp49TwWo0dRjcy8erwevGEb8+bg7yWtvkHqaHlY0cue00KFopNFfDNSHF
	iJEaelZo//Izoc/NmzaezfCVkJbW37vhoUxLJSHFCrky5w5ZNy1oiw3qsEhfpwmDlT4V4O8ddOI
	+JzaPLNcLZwB2NjWy5PY7oO5MdPpaTg9nIWrwN1D6ODmQLm9QNV51O10RmDNVlcc53yzPQVuFvX
	oH/AR6XrOnUs2lUbdo8L0cLNyksOONE1oc4akj8d
X-Received: by 2002:a05:6102:a4a:b0:5f5:3d46:e601 with SMTP id
 ada2fe7eead31-5ffaaf0baa8mr1976066137.24.1772709205343; Thu, 05 Mar 2026
 03:13:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 11:13:24 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 11:13:24 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-10-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <20260223-b4-pks-odb-source-pluggable-v1-10-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 11:13:24 +0000
X-Gm-Features: AaiRm53PsoJrcMKfDmggsfBwm49aSdKp_r4r8eULJGNC9ywseE1aQTg8nxhJTIs
Message-ID: <CAOLa=ZT256atEES+7-8q9tDPzW5h=L-ApWuHF1udUVFQ9QrCFA@mail.gmail.com>
Subject: Re: [PATCH 10/17] odb/source: make `read_object_stream()` function pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007996d1064c4506d1"

--0000000000007996d1064c4506d1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 12 ++++++++++++
>  odb/source.h       | 23 +++++++++++++++++++++++
>  odb/streaming.c    |  9 ++-------
>  3 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/odb/source-files.c b/odb/source-files.c
> index f2969a1214..b50a1f5492 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -55,6 +55,17 @@ static int odb_source_files_read_object_info(struct odb_source *source,
>  	return -1;
>  }
>
> +static int odb_source_files_read_object_stream(struct odb_read_stream **out,
> +					       struct odb_source *source,
> +					       const struct object_id *oid)
> +{
> +	struct odb_source_files *files = odb_source_files_downcast(source);
> +	if (!packfile_store_read_object_stream(out, files->packed, oid) ||
> +	    !odb_source_loose_read_object_stream(out, source, oid))
> +		return 0;
> +	return -1;

Same issue here regarding loss of error code propagation.

[snip]

The patch looks good otherwise.

--0000000000007996d1064c4506d1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c3b3efb9c94f21e1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcFpWSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menZZREFDa096ZDhEME1nTVZYM2RXRDdpd3NISTQ4ZApuaXNpdllMTkdH
aEdpNWwzN0pMQUxRODBLRU45aERoUEE0Y2FvTjhyRXJVNGt6VEVYU05BV0ZDZmx1eUxzNTB4ClFO
SFVFbEdBMFRkb1RoeDZoQ3JsU2VIMGVZTWJUV0FTQmlLY25YRStQUnlDS2VWNEVaOG5rcGREd3BZ
YUJpSGIKWTZ3UW9JajV4d2ordkZwc0RpZ3N1UWFzR1loa3NKbDZ3bFVIcVZ4QzdvOUdVZTh2VytE
TWZMeWU0UjExUm41VQpucWxFekFja0gzUndLVTRnUmQwOW1rK0ZONVd1ZnM0TWZHWEdWVXhmSGV2
WGVEMklWL01xbG1iVTVkTDBUZlRICmwwemowUUVCVzlYYytYUEQvcWhWV0ZNVmVRc004N1B0aC9Z
TFZYOXYwTTVma0dJeVM4ZmNjTlh4OTZSQlZueFkKZGRMWkZoZUp3Q3NaY3hCMzEySUh2ekRxWUNw
SUJYblFYZDFIVVBJREY3ZEc2cGdvRlBZK3dhMmkrek0zQmpkRwpLbnp2b3FDVExOOGxjTnI1U3U4
NTNqSGRPYnNRTi9XVyt2SVc3YWFXa2xMVGdwYzNOM01xbUMzeHlwUUwyK3N4CnlCUzNSRE4yVFF1
QjFsWlY1cUd6WEs2aVk1NEpQQ3N2ZFJaTVNqcz0KPW5WVnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007996d1064c4506d1--
