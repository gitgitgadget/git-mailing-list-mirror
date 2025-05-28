Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8A1F0E34
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417012; cv=none; b=D/s9hqpf2OT+UMCtGqKZMIHWSb67TBsWq41uCsuhujn7LuEDMbhceMLgv5cJ+W85sIEk73uchJJaYaJeRfpZVvtx3milzz14rMYiZIPQxUUBEQ5+MPGZ5GIvfqnYWKlLOv9HbX89Ejd9mGAPkVb6YYsyTQy6yKIzOGIp0dRoGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417012; c=relaxed/simple;
	bh=UMItEbh/Csg4JPMagSNNZqpb4doymPyr29BWJg4Cpr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+MMd3nusONeG9SYs+bq09F0xoPEqQvj365iajGm4ew24IYOaim07P+vh7LDOvxNYHu8SxZtzKpEkyrdk4oaJvYbYBiMl/IrZ50IhV0spbhrJB1F8N5FBOCr9jqZ4MDHWMRKFzyfK7n8wTEg8xa2NgiM4HAHh6I+/rizry61BSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7cedfd71d3aso79207185a.2
        for <git@vger.kernel.org>; Wed, 28 May 2025 00:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417009; x=1749021809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIU86fGaEZDSVVtaqzkJyi4UhbtVwvn2zgZdfuSbUVE=;
        b=itCQYuvNpoEl5x0pAoJQXKjGtOtj+soV7jPHAH6zYjXvfUKBYsqOQmq6/6dlpIH2/k
         hY0ZUGdHY9/4uEPtztkW5krfgcgp1vgGpYFd8EMzoSzzSDminUCpEe8IAOjpvwsSCw78
         DBTVYeES4MPnP6ZsQY/MERLqRgcWFjWOAYwLWnxJ8A/j043ymg9AZqAwRk+nvZ8W5dvm
         1kpM2pbcKw0O7D5v9l7NPsfFHt626cVxc9ciUT+FxkyuWI6CDr8iL7NzG802SIPxUOaK
         frZyJl9V2tUYbAgqrJL4e1gI6Alr1k5ODUJNSWwTR564pFwYOzT6h1eqDiF/3ajlFlD5
         zG4A==
X-Forwarded-Encrypted: i=1; AJvYcCWs5OPIRLAR+rpHRs3lbvDnO9S8BH7sq3OqXv7Lrp+hjepqa0EiRHqwQkYMHqZvV2QohGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmASRhUzBcIGym4FuhbkfQrvJo21DIWi9ZPBXzZ0WEMHLN85B
	SIMypGEFbu0XF4roqw9FcIEkfyVVa7rcW/5iJYzt/Iukn1Uy+KoxFzW3V8L8NQ7lDn061EVcbbO
	XDqyaO9qArq+PagNPB0aXChIW/xbvciA=
X-Gm-Gg: ASbGncuGS2njV5Ku6nYkxayWEm8Ddb5MDgD4EtWNIJtMx2JNMsqDr0aoSfRfrv8pC5A
	mexwNwCb3shPOiAQ4zrihgWxdpbcsznTb9i3vss8TjnpO+qi30F8wIP34/FEeMStuxh9Oq0hvWH
	8SmVt84gvhehDqcZKW8hwOZXTqBTQXpc8=
X-Google-Smtp-Source: AGHT+IF6EsGFVYFiKXF+SYSbPlvNezHQ0NeMVCuICmxSmozOOzxbjCHci7fqYH7ycXEnX6Wq6pm04Pwc1CdQfaHlKos=
X-Received: by 2002:ad4:5be2:0:b0:6f2:c10b:db04 with SMTP id
 6a1803df08f44-6fabe48d296mr10339436d6.1.1748417009229; Wed, 28 May 2025
 00:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
In-Reply-To: <20250528070521.17379-1-gargaditya08@live.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 28 May 2025 03:23:18 -0400
X-Gm-Features: AX0GCFs7lj52hoDifk62y9IK2-YsZ0q2uJTVryd9LsljbXDyVgk3OIPUToy4MyI
Message-ID: <CAPig+cTs0+AUPp1euxqKkX0iFTdw9zGuMU-Qnp+ywhcyP8gxfA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] docs: update email credential helpers and improve formatting
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>, 
	Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 3:05=E2=80=AFAM Aditya Garg <gargaditya08@live.com>=
 wrote:
> v5: Added a patch to make the purpose of using app password for Gmail
>     more clear in `send-email` documentation.
>
> Range-diff:
> -:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and=
 link Google's sendgmail tool
> -:  ---------- > 2:  bc1d0471ca docs: improve formatting in git-send-emai=
l documentation
> -:  ---------- > 3:  b9e41e2492 docs: remove credential helper links for =
emails from gitcredentials
> -:  ---------- > 4:  a6ad7ac810 docs: make the purpose of using app passw=
ord for Gmail more clear in send-email

Strange range-diff.
