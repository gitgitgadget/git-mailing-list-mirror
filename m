Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC38186E2E
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598221; cv=none; b=dQgs4HETOyYrWh0Ssg57jszW0EoTBm9t/Ja4NBTjTELoKVq5Tj/8cuDFUg2uI0Cg46+43EAzZmpouQoJO8ML+mVvPOz38HaLG19Iw8m92pkqCjapC90seO0hb7FC4sdsEiFpo/dvoF0hAUV7Ow/KiZGXoml5QuCItIjCa/IB7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598221; c=relaxed/simple;
	bh=yT4qAbnDvfSfElRdovy1j+J9iM21t8bqtP16aLTC3TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUDCrHPxIqaxOFHHbCz33QhcfTJZRvpVo/qCs14/raAl9eDD/GMKiUTI9xtgnhgIv+rc9pjTMKZS22mI42epupKJ08Bxjv1nkZbXPGkA72//VFuSTLFP4PExAHhuD1Bzbvn5bS0XscTwvnuk7DnkBTA/eUuUDTIpCu1K8VxdDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4aabba49c97so9803881cf.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 09:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752598218; x=1753203018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT4qAbnDvfSfElRdovy1j+J9iM21t8bqtP16aLTC3TA=;
        b=T+6gZpHzgNVzP2GNslLdB20ZoZZzLt5O27bIg1723/6JZMpwQ2jm+vqEEjpnskcizp
         VuGDZ4MernHYIj9HFBKZ9xUo/ZfusKMDNYCln/JgCcQ1kdW8ZvIUi2OSsYCksI+8pdw1
         5dXhD15uz12LFGM28AQa7iGmASsuQAZKEBD29vOPrSeZy/ek1tEzAVksdXctJ5laRlJu
         J6yCQc3QZuC34rRmtqoHBri1b0xLBnZ87+kjqYn2GMbkwmodUZI4KAvGa40TV9k5qKke
         3IksS7NNFN+bkoP2eGsVWnRyJkwGaegejTTE3bjBhImzuvbn25ucg7LV3LVGc+trR2W3
         YwZg==
X-Gm-Message-State: AOJu0Yz465dTpgc7i47oCI9/JbPI2782NvC+/kRemHQqrg2L1aHelhc6
	m1y0nY3A3QVYWfSShMWF93hQF9YugxyuxNOaP7TzEE8g8ILfvUozFZq4kFEY8IcobRTbtOqf8fE
	cIUC/gvRr6Si7KxeyDrJXA21jIMfz70g=
X-Gm-Gg: ASbGncvMvDTLaK3LM4OeETY0q0du0JmzlSiNOPngl5AgNTdO7LBLtGQm6vCaBm4m39A
	XnoL1UGDDS19/ddgSfh5wLaZzx7DcC3T5vQ46g/EwyPz0PiyHpHz0qmncwqXDDct+FEkDUP/FBr
	E4ALUU9R1DzwnChZKR8LO1y3KMU6qLN9ablHBnl3cxG7EW8eMUNimpDeF2nzCMB5lGXjsDNR0Vn
	IIIr7PnDPgMVzSpvtt9lGqDnV2f9vaAiWgxJmSy
X-Google-Smtp-Source: AGHT+IEGodMgGI5ateiq3+C9Szu9Xc3NF9Kzv5W3dIetJn/jOSjq0YN2QZT+v5Odh9kv8YCUfgYjeyw8N449ZOG39Eo=
X-Received: by 2002:a05:622a:1910:b0:4ab:5aec:93d7 with SMTP id
 d75a77b69052e-4ab90cfa1e1mr867541cf.15.1752598217966; Tue, 15 Jul 2025
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713174807.32444-1-carenas@gmail.com> <20250715114407.37955-1-carenas@gmail.com>
In-Reply-To: <20250715114407.37955-1-carenas@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 15 Jul 2025 12:50:06 -0400
X-Gm-Features: Ac12FXxkRIHydJtq8N81zGd0b799SAUqnJkNU1cypHNc3qhuWybHZ-fXIJiSxFQ
Message-ID: <CAPig+cT+Csi6xEmobkDRprxe7pU157Z0J8bKK=iFgm2+o3xbwA@mail.gmail.com>
Subject: Re: [PATCH v4] meson: woraround broken system PCRE2 dependency in macOS
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sandals@crustytoothpaste.net, 
	ps@pks.im, eschwartz@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 7:44=E2=80=AFAM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> meson: woraround broken system PCRE2 dependency in macOS

s/woraround/work around/

> macOS provides a PCRE2 library in base that is not usable and not
> configured properly, as it installs a pkgconf module that
> points to a non existent pcre2.h header in /usr/local/include.

s/non existent/non-existent/

> Detect that case and allow a fallback to a wrapped submodule
> if the feature is enabled and that is possible, or print a
> warning and disable the feature if the feature was set to "auto".
> which is the new default.
>
> Suggested-by: Eli Schwartz <eschwartz@gentoo.org>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
