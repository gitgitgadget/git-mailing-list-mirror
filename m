Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445A21FF2A
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793582; cv=none; b=DE7lXvXxt1JtGdJFvDPDjJ7mByaLm0oinC3wcG9jlJ5ZIlGleoVY9b60d3WjiCfLnWdDMbSO2rANb8QYOPeIVR0lLK6gTJCmorGsfKqRpcqzO8zwrVkoLEks3GWdR0J8h6K0AQCMyh/nckFzof/safYUXisMNNvsPPWLtK4N9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793582; c=relaxed/simple;
	bh=nxOhiEUq39uegCU/gdvVe+gpWGV1ejRT3a6gblekFuI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=feGDJ4jyhJboQF5gOULcji1xxIruXk1cUfkIiuV32hAVS4hhDDEVpgZRwrkmiDjyaUhPGhmiV3xJUVTMM3LZ7k7GFAmGB49bLlLmxToVYcwr1QiMBUVqzs4XDGrl75TkazQnuDrIZqgUdeO5BCZ9ngWRpoCsfv2n7yEAnsPUANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2PUFMC9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2PUFMC9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49553515a8bso39969035e9.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785793579; x=1786398379; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VGmXeL1f3F1YPxxSmtv408JZGopMOaSUdXvsJp8iyy0=;
        b=k2PUFMC9E6myozvh6kvU48VjR/IiVbTMBsOamdGFOJSSTEsd5OrGzfDupfOsh2esai
         BhJ8tuwQKP8bR/c+ZmEnRGT+YaeFlGzx5S51ybzdW7ZYuRIPYDigtzDgzRiJjp7yQr0d
         oRKQqgobKGt2daIAGf1HYpn2aEiF0Djcx6NEujbJH/8IKEI1ya4+8pw0ejiil94CvtqY
         HhD68qLeVTp/aU6epAunjqpw68SqyjbQ2fhsQT+ooJvepdN9LCN0edxk/CzOWkA+1ddt
         +MSkU9S8iQu+Tk8/jVDsmvKvCaGfZwfyWP7nSDZRPk87TDH72q+5wt5pNIhqcrUqjaqs
         0kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793579; x=1786398379;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGmXeL1f3F1YPxxSmtv408JZGopMOaSUdXvsJp8iyy0=;
        b=bZoYZznE3FR5SuplOhH/Syf2JAPq+Ugmy/S0LVuVil17boDA2VvXIS1hqdP/PCa5Xa
         4tBRzwSGFjL5aRZyv2gpPRvSWma1goplJvxIxb0PFhAqo1hXb1YESFkRN3Vmghm829NZ
         D8P/YcCWjyhxppy2V8OriVo7OaRhSDQzGypmaVx0VDUMluIhwikD64UxXhogvJU+AEys
         yFNIIU7D69CeXP2gLN/jfmAdH4LxrYbNsQdEBQZDwlV/N0Czgen9G1gO19q6uUReRtB7
         60JHH7IlAvTCjgeub1oFWZBOnOCmWunlZVTRtZ1OrlKJ8e/GcZoGdylCJ6+mR7Z6ccQl
         vttA==
X-Gm-Message-State: AOJu0YxaL1eVK34RJego0pXIIOluxBdX2PM/1XD0T9fUoLILBUTRXGvM
	oGDlcwd6PdccFMt+ABBJzj2hkk3xWiLcyd/NTCL6/PGDr4TsIjSsQmwY
X-Gm-Gg: AR+sD113avmOAkm+hAqkZ3v+Uobl8ude4H9aZ6CnsVGSBplpj94CFT7BlexRU98dgCi
	qahVF8CCOwGlL4eOyuggmYf3EE/QHJarzqjjMS6wZ6fnXxC5o3rt6vibYWIBO+SJwuHcx3tbohg
	GOOibBZ3fEQJyrfwcLOV1RGVxa58uNNN9m3gxQ/xFTqkZMVaVvamwPtgJht8ew/3Q9a2G3JI/gW
	u2kcGd9DeNSAPFBorn2/Pu8MO50dZ+kSpeCsP8BmICIvKQkD5mPFDo+Bi2oMPWNXCZ65OwEVQmh
	Gn8pNyaZyUifo0/+oOEpfQDex38wFlmCiWjSNfMSOZPBksi7wdEtVwAYtcB2li/dluAty5mw3lA
	KPgTD+dJM7od7/1gZYhW828pgkNOkOee2udAgkz1IC9NaOjRUPVe9L71a4DGkyrRdMXdiQJJQI9
	062ObNv9IPbVG3WXSgyP2WrE7yAOmTUb4K9fllfU7agOVa7QdDcES7tye1j1oFhAPuQ4i5Z5yHC
	uPld3Z3dJ2tiXCOxQ4UIh7hRJ4oungCy0gD2NmEu42Mny+CrDckC5wO/JIYylBBvcH4o8j7iKxQ
	l1jwTmiYXki/nclobzBdwkulDBC+CsA3f8wgAVeayRqNiJaDiSmZViSynh+Ols1rw1tFLrJ6dN4
	=
X-Received: by 2002:a05:6000:615:b0:47f:762f:32a9 with SMTP id ffacd0b85a97d-47fd72a8f3fmr30228203f8f.12.1785793579332;
        Mon, 03 Aug 2026 14:46:19 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456220esm37645945f8f.18.2026.08.03.14.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 14:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 23:46:17 +0200
Message-Id: <DKFMZO5TH1MW.1JD6RQLUJDK3M@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>
Subject: Re: [PATCH GSoC v3 4/8] fetch-object-info: use dedicated struct for
 the results
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
 <20260803-objecttype-support-v3-4-7176fecf7950@gmail.com>
 <xmqqwlu7xdmb.fsf@gitster.g>
In-Reply-To: <xmqqwlu7xdmb.fsf@gitster.g>

On Mon Aug 3, 2026 at 8:28 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> fetch_object_info() collects information about N objects, but it stores
>> the results in an array of object_info. That struct holds the extended
>> parameters of read_object_info() (The optional outputs the caller wants
>> filled). Its pointers tell that function where to write the answers for
>> a single object. object_info is not meant to be the final storage, and
>> since fetch_object_info() does not call read_object_info(), there is no
>> reason to use it. Using it means allocating one scalar per object per
>> attribute just to have those pointers somewhere to point at.
>>
>> Add struct fetch_object_info_results. The caller sets the wants_* flags
>> to say what it is interested in, and fetch_object_info() allocates one
>> array per attribute. A set wants_* flag means "asked for", while a
>> non-NULL array means "available". The caller releases the arrays with
>> free_fetch_object_info_results().
>>
>> The object_info_options string list is no longer needed. Filtering
>> against the server's advertisement now sets local ask_* flags, and
>> send_object_info_request() turns those into the v2 protocol option
>> strings. remote_atom_map[] existed only to map those strings back into
>> atom names, so drop it and build remote_allowed_atoms from the result
>> arrays.
>>
>> free_object_info_contents() loses its only caller and is dropped.
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
>> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  builtin/cat-file.c  | 59 +++++++++--------------------------
>>  fetch-object-info.c | 90 ++++++++++++++++++++++++++++------------------=
-------
>>  fetch-object-info.h | 28 ++++++++++++-----
>>  object-file.c       | 10 ------
>>  odb.h               |  3 --
>>  transport.c         |  3 +-
>>  transport.h         |  5 +--
>>  7 files changed, 88 insertions(+), 110 deletions(-)
>
> The direction this step wants to take us looks good, but at this
> point we only support "size" and the client side starts parsing
> "type" only in [6/8], while the server side starts advertising
> "type" only in [7/8].  If the software at this step talks to a newer
> server that does support "type", it will hit BUG() if the user
> requests %(objecttype), no?  IOW, introduction of "ask_type" smells
> a bit premature.

True, if a client asks type and size in this patch and the server
supports it, "wanted" will be 2 and because in the loop over wanted we
only expect size, we will end up BUG()'ing out for something that is
not a BUG(), but an old client vs a newer server.

I will move ask_type int a later patch in this series where it fits
correctly.

Thanks for noticing it,
Pablo
