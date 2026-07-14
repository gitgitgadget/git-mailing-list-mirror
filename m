Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0A424D4C
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057610; cv=none; b=YuIZsKoLLVPY1NyM3dDQvWCbTxABpTFzuMSzwGr0VCooGF+xh+w2H9O5Zh11SwbqEEbfJTt4EIC9YhGBiPxVEidEDBuBjb14LrIJh90aO5aTSn6jvrvFMsJEH3h856jy3N4lqHtgFzoFNfHTBF/A0lGHblchJlB5sZncM/wS90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057610; c=relaxed/simple;
	bh=qMajCN9TSKdyH5KvL/cRlQU/eotuX3lt9lbqGFEEniQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AdHoukm+3SiRPZkW+CDQKuFWdjSMPTXRpopFs2tsQDqnmfD6Tr0d/Cw1ldwdtDXsO8x9uAJX5NrznMy+tgvPsxyZ71SwdjbfoWExvUXRNd+MAhB9dFU/PMCAuB+VX3xQqTQjt0vXaUhXUyadrTJvAorbNm1yWCMSdFDEycGOJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgdx8u0G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgdx8u0G"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso33871895e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784057607; x=1784662407; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l2kytfJZLr2Dn4Fi9l0KbUye4dePjFtufO8qak7dpsE=;
        b=hgdx8u0GlgM/uh9XwEEmGl4cAgt94uIEQCMVDXoXMu/5JIfqqWwb+j809IE477x4TF
         M3XzNuoa29hvR5/1Dn7OIgQ8C9p7h0yBKMDrDBVXg+pDAWOHl0Nx43MrrcKa3VPhiBr0
         H5j4KUTSgJmX5bYkvb4GeyqeMaHDumrEClrRuT7jjXkd/NK4MhL5E1Ox/CbHBmE412u9
         ioo46/r11aljjHV82zWVZv6I9c9+IUefrSBkhrLu2y/HZRskGsgyY5cus65V03pj9Nar
         6GCSLOPbLcT/wujIFRtVEtupPIFD3fid1vPd4dgoUVi3hf0DhFfuq2xqcv0UZV+F33CB
         pmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057607; x=1784662407;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l2kytfJZLr2Dn4Fi9l0KbUye4dePjFtufO8qak7dpsE=;
        b=fSJKzpJq9SsDqfQ11M0LhMYEnT/gWtjI37J25ReOVlDmskYi00NlKWj7sb2FdWgP6C
         FpXYLoldobZ73OVpzCRQVpU9hQqiRsUJi2zHSo7fDmtVJeJF4BuvJlcZX3F5QhgksS1s
         YlsykrIEF/iX8DNMo+EDbAR4YO1x5JIkyq2nPnlTKBi7tFEikCXr/VP3JbNF0Ho/HcdI
         qgv4CSzKLRtJOwPkO0B28ZBNmkpE3EOz+vTOx5zXmbmwyvdUt5HxRfi9SUZkOc+2I7cH
         pArR6jGXFrDr4bgq+nRbHJK38CB7iXXSP6rgZ33nqqd/4Mh/3vR4GO0961Ayc0usZskW
         257w==
X-Forwarded-Encrypted: i=1; AHgh+Rou9AQHa1kc6ZRXVOWgfMC3mX/sYziA044VbYMvAVdD6yiZdbaPLkNjjhmveblG3GRrEXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvOA2Oh0DZmZz+wz2juQq+JyJ1HOHJrm9IIEmI0zRCMhqmBGA
	gFPGUNGu2y+v2yn7aqUoCofVxhZ25lV0fdPETYKKhbp/PunsQy6WbAGo
X-Gm-Gg: AfdE7cleHqdldEj80pgHdKUWY99awsOmXvyGuBJi2StugCiImsnY6iBjr7bk6ZdB7No
	i8OYwQic3tCv4IBr4MEfd2u6dVF4R2CfTmA1aAB5NOXnZgMciZKTsPlPoIicT+Ovb19e+UIMJDx
	GYcOeFajykOAbrtRYuqkrs4K60ysBy21Xjagq7YMhKlXEyb6sUgzUFow4KL1pEzkbmrBUypzW+9
	b/3zZW+imBnSOSDtSk/fem0cKRADSHU9oX7o1lHSr2yHciB0WQofUUHw19co5Ykzc+n1bCSeTSL
	8Dz8n6+rIdgYiVPzI6TpTby30QmX4WIfLc0KVagMAvHPlMwEW1Y2qrqZtLQRq9bhJiqyHBLRAC7
	z13XrmY6kguWR2a4lCOv703EU/cM2VwDHbfNVwzzUHMK/jzssKt3bIDCElO892swnqg1eLtNVoG
	Zqn8e3vlhG3R3uyKtj5oMB39Pml8QOQLEC+vKQqHa7DEE8YVWvhpRqtJSJPdhY30BaKYxdvjoPK
	jERj8gBDysUxumZuNM7uKp0s88EHIrCYs1j7jbP1iJ1JojcrahFdtJI1e3fLSDhe2eO6YEwycoo
	EQGydUjXQ+P0rFKIvAvQS+cMXv8mmw0G3DvYUOKrSAdr0sNzzoMwVguZTLVIxhcxI89/OA==
X-Received: by 2002:a05:600c:4ed3:b0:493:bb0e:2832 with SMTP id 5b1f17b1804b1-49518320e73mr57052675e9.37.1784057606824;
        Tue, 14 Jul 2026 12:33:26 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm101891405e9.14.2026.07.14.12.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 12:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:33:25 +0200
Message-Id: <DJYJN18OMC4G.2YYRORCZN519Y@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <git@vger.kernel.org>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>, "Calvin Wan"
 <calvinwan@google.com>, "Jonathan Tan" <jonathantanmy@google.com>
Subject: Re: [PATCH GSoC v17 10/13] transport: add client support for
 object-info
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260714-ps-eric-work-rebase-v17-10-afabfc83260e@gmail.com>
 <xmqqik6htpv4.fsf@gitster.g>
In-Reply-To: <xmqqik6htpv4.fsf@gitster.g>

On Tue Jul 14, 2026 at 7:58 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> +	for (size_t i =3D 0; packet_reader_read(reader) =3D=3D PACKET_READ_NOR=
MAL && i < args->oids->nr; i++) {
>
> An overly long line.  Format it like this, perhaps?
>
> 	for (size_t i =3D 0;
> 	     packet_reader_read(reader) =3D=3D PACKET_READ_NORMAL && i < args->o=
ids->nr;
> 	     i++) {
>
> or even:
>
> 	for (size_t i =3D 0;
> 	     packet_reader_read(reader) =3D=3D PACKET_READ_NORMAL &&
> 	     i < args->oids->nr;
> 	     i++) {
>

Will wrap that line, thanks.

>
>> +		struct string_list object_info_values =3D STRING_LIST_INIT_DUP;
>> +
>> +		string_list_split(&object_info_values, reader->line, " ", -1);
>> +		if (size_index >=3D 0) {
>> +			if (!strcmp(object_info_values.items[1 + size_index].string, "")) {
>> +				FREE_AND_NULL(object_info_data[i].sizep);
>> +				string_list_clear(&object_info_values, 0);
>> +				continue;
>> +			}
>> +
>> +			if (parse_object_size(object_info_values.items[1 + size_index].strin=
g,
>> +					      object_info_data[i].sizep))
>> +				die("object-info: ref %s has invalid size %s",
>> +				    object_info_values.items[0].string,
>> +				    object_info_values.items[1 + size_index].string);
>> +		}
>> +
>> +		string_list_clear(&object_info_values, 0);
>
> Is this not trusting the other side too much?
>
> If the other end returns fewer values than expected (e.g., if a
> buggy or malicious server returns only "<oid>" without a trailing
> space for an unrecognized object, or if we request multiple
> attributes in the future and the server returns fewer values than
> expected), string_list_split may return a list with fewer elements
> than size_index + 1.  Accessing object_info_values.items[size_index
> + 1] will then result in an out-of-bounds read/crash.

I will add a check for a malformed response from the server so "<oid>" is
considered corrupted, similar to the size values a few lines below.

A subsequent commit in this series (13) adds a filter that drops
attributes requested by the client but that the server doesn't support so
we should expect full return of the attributes asked or "<oid> SP".

I'll add a guard just in case in a future what we expect changes.

>
> By the way, from a stylistic standpoint, "size_index + 1" reads a
> bit more naturally than the "1 + size_index" used in the current
> patch.


Will change it.

Thanks for the feedback,
Pablo.

