Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CB70809
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734574475; cv=none; b=M7Xo7g5rlj0JhPuNkApsTHQHImOLzqfJ4/cp5B3+fWNg08NjpNitZt3/KtsSrA42qYjvG55jlF+0f/drT7hBZ417MlU2YApiwy/oK25Cnzv6GfTmeFmGhjaaqHX4t6cJ/NH3cnCiRCNSi3QJCGyQxmSmKFlKtpjXqWPTaP/QA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734574475; c=relaxed/simple;
	bh=gYuD+lCoGAWk+uNeG6l+Nd61pmRQ9g5WKjMPWbEy4HY=;
	h=MIME-Version:From:To:Cc:In-Reply-To:Subject:Message-ID:Date:
	 Content-Type; b=LtjA3TV272SxJ9+Ri6a8UsYiz2SCCWS56wAGuYLufsEA+jDC9+H8rxNReI/ltDDX0kjUbSIfIBwQxad9wG4roamBeN5NNvZqYQ4/J7NyoxRhMy0osn0Q6AlNAZs0E91r8SfgfhN+swkilUZQIc6ON//uPHvNNg2S61MU0XIn7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuhLNJjK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuhLNJjK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728f1525565so381889b3a.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 18:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734574473; x=1735179273; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5QRI8WqPMpsEBAR5OxkEqNRDkSHBcVCLa/VQfhc4O8=;
        b=DuhLNJjK/26Grfsb/jk3X0mNcs3hIfXDnjOKLseL60fYS60+2RjwTRaqVyDH2DkbA7
         628nVE1kFrbUkiAOzbmJcGBibH17wsM3R7+ts098Te0l/OsOaYsl8xt6NH4hpT4xEPve
         gl00SUMA+6celg6EcSD7XvyOKtIxjFL+MyxbomBRrj1ToYQlPQDW6r2jguAqUl9a8GoB
         4AJV/z2bG3JoQZ65IkXGYCTIyqVr8xbzoydZFdCWpX0jqt+LLves8RJW0tASha4dhhM4
         6b8SnLrbEKrofeEyY8NTVzLIjB62QuX4pE4jaGhC83DaOQtCQpjndVS0OsA1ibGOmurG
         iOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734574473; x=1735179273;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5QRI8WqPMpsEBAR5OxkEqNRDkSHBcVCLa/VQfhc4O8=;
        b=VdwU4kMKS487WoKn3IPthD1HMYaWFghXZva5TpjpBquHXWKMaS2vX9j5PxwnGBQDFb
         MKWBX8kxtzC7T2ovcJgFyN1stf8XcrXyREFeR0iMWfiaPBnaT0QS4ywczRZj/jSRxcK1
         P9yC42NmpQ3/M37qTymjk7dFFgolgOpIxOoA/UjTebK9k8lexaLqM+Wtp5QMCX/DsvqF
         zd2zmUpE++ojDemV2LMduDn54HUGX9HNzPCbmEVykao4wxErnwARDvLgEPD3TRadchrz
         yGozfQkWkK4Dw2anqZdOZ/qdC4GfOpPgyhvmwJO1OCOYV9coMuAQZ4hFVgw3SixFGG6F
         dNGw==
X-Gm-Message-State: AOJu0YwWY6PAwu2arpME4xjcCN2JUaXI2iAV9rk+VMqZQ8L1dOFIK6DB
	jW9vRsZOT7dv0afUdrL2VKT39mV1LNctcDXqFdmKsFVXCoGo4pP0YAiAH1e0
X-Gm-Gg: ASbGncuvakFFL6nZOm62YoXBvWZ4he5V/Q4D4N3DAD8S5gkQ96mHw+yDdlq4926RLaX
	4xNyoRwMek2MWOGoOcUSzgB4NtVUGH4tjY9tThW/OpQtpDRVCGvhhvkogWbe7lzzkwQt6qyieo7
	MplOdY9R+XToVWH4mSDXE78wdeIJxYjsWKjCCaILnYIOtmAN4FbNupXYWO+sBLFY3Wz2+iYxvir
	4+ko+V2jh1FEXIpGWWXX5KoTzJKqByIMqwtxfbrN23dRi17AZyDm9bouOhGHlCqnHuyq7qaPVfB
	/mQAqg==
X-Google-Smtp-Source: AGHT+IGw7A4UN3KG5XXhe++X+pUHNSBVe7zGm4MG6m2LvR/foUJxdqQWmCYf+sj/BVe0B6A4+BJKMg==
X-Received: by 2002:a05:6a21:101a:b0:1e5:7db5:d6e7 with SMTP id adf61e73a8af0-1e5b4bb459bmr10443037637.46.1734574473278;
        Wed, 18 Dec 2024 18:14:33 -0800 (PST)
Received: from host (36-230-86-110.dynamic-ip.hinet.net. [36.230.86.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842e32f5f00sm121291a12.72.2024.12.18.18.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 18:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Wang Bing-hua" <louiswpf@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
In-Reply-To: <xmqqy10dt2zb.fsf@gitster.g>
Subject: Re: [PATCH v2] remote: align --verbose output with spaces
Message-ID: <1812724a6e98b9f0.772d5fa147f10a1c.6ab8f72f53fdfcab@host>
Date: Thu, 19 Dec 2024 02:14:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 18/12/2024 07:39, Junio C Hamano wrote:
> Ah, of course, I should have double-checked, but it should be more
> like
>=20
> 	printf("%.*s%s%s",
> 	       maxwidth + 1 - utf8_strwidth(item->string), "",
> 	       item->string,
> 	       item->util ? item->util : "");
>=20
> meaning
>=20
>  (1) the first output field must have maxwidth+1 - the display width
>      the second output field takes.  The field's contents is empty, so
>      we get enough SP padded to make the total of this first field
>      and the second field to make maxwidth+1.
>=20
>  (2) the second output field is item->string itself.
>=20
>  (3) the third output field has item->util if exists.

Understood. Thanks for the explanation.

Here is a tested code snippet for the record:

	printf("%s%*s %s\n",
	       item->string,
	       maxwidth - utf8_strwidth(item->string), "",
	       item->util ? (const char *)item->util : "");

> You already know from my initial reaction what my answer would be,
> but I am inclined to hear from others before we make a decision.

I see. Thanks.

