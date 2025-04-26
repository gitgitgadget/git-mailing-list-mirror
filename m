Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7317A13A
	for <git@vger.kernel.org>; Sat, 26 Apr 2025 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745658250; cv=none; b=ssqe9Mm32hqPPVdQNu6HOD2VQ21oTXid9BCEV0PqsESdRNVTq6G50Ze6X1r3A6tCvkvJonrzgOWsIqwBecHJNcwINIDijTDQqxSaiW9eCJsEIGpla3Vn7d3licYUaZkx0ZBCosHpzRLAbEk140uGQvg5Nht13urpO1qhe3AaVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745658250; c=relaxed/simple;
	bh=s6XbvW7u5G8yAWnltHKNrCxcC4AbhsWME8cNV/Nk0hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLNevhLtxx2o4Z804h9fDgKURm+K+S/6lMMroiU6UufQB91bNT0irWWCC9gGLikSftlC7cbuXCL3EmOBM8fesbAjsBmc1ALA7CdDRD3+W76CHTF2SMxh5FmaFX9d6WTOPDkCQZ35K2A5n+OezwMY1bxB3FFH5TqAiaFK473rnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so5609206d6.3
        for <git@vger.kernel.org>; Sat, 26 Apr 2025 02:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745658247; x=1746263047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E33eBqhyXIWVzI+Rc1fG9fmzc0Bv4yQrYAw9kmOITPE=;
        b=mVrJmARoHWt9NmDm3sEMt55V6Q79Bl9TftCKoqXBfm1Try1i3mwZ13X13uYx0HKuKC
         Kub6ddVzgOJLTEVOrQgTH3Xw0Qtv3qGm4VUBkFkZ/wMMQc4zI0uwc0aPDoDZJIPg28vK
         U5BYjKnHUWB+7hj5loyZH4c75JuP/1/K/nl/cAUxizw9G/CMUUmlY/zJ9DxxlcnhqXmH
         RgVrO4pVdwyd+rQXdqHOkC3kXsXNT3YFzSsl8K/w9rizbbYarXC/esaynavzz5mC2qNf
         ZYjyCFOUnKwvICtuSmhvH7tlxYqRATO+ZoWyMNNaSw1BtevBZ1MxrW0Tn2v9TsxnrhiU
         0U1w==
X-Forwarded-Encrypted: i=1; AJvYcCVPxjT8KdqNRqNyxkbeIOm4vyQZK0uZKO6p1pr1oG8qjvvzRdSWKd5SP7gEjjljmaCZ0wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjRZAmU3OAy7BagFRvOohewo/2zWhps3RZ1zQmREVujzovgGt
	Vrw/nZGqD6K5kYRijl2jL+3oi5w+yTUBgftSrun2cIINeT+RPFKyoadm1xs7JzkIDNWR59diqE/
	5qgh929Pq1GW2aXv0Ykhv6Hyfv6Y=
X-Gm-Gg: ASbGncsfDwTkKxocE8CDbOGxRO//1Ssd13xhURDtoA5TX+vGYZa71aVIe1R29PxulTQ
	wQh5y0yC8Aoq4mNSTXO+sRpaDQgxE8e5cC8dM8CiRQuDBCEZao06HzQkMdAQWbCrKiC3cEuldyC
	zbjUd9wVyRPn/UkHBVEJa9
X-Google-Smtp-Source: AGHT+IHNj2NJrmbQ89c8nYrEXDtpqWXFYiD/aXDbrX74FngENCs95OnrypSTATsl5TZGexWI0b8Y8mXbgog+zq/ySYU=
X-Received: by 2002:a05:6214:29ef:b0:6e4:4034:5ae8 with SMTP id
 6a1803df08f44-6f4cb9da9a7mr32600866d6.5.1745658247263; Sat, 26 Apr 2025
 02:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikmstatc.fsf@gitster.g> <PN3PR01MB95973B932F4961FFFA9786CBB8872@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB95973B932F4961FFFA9786CBB8872@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 26 Apr 2025 05:03:56 -0400
X-Gm-Features: ATxdqUGo_ww36Kl3NnVN26lo-UGk7_nk8KYgqqpKLvlpiFOEIss8gEstl3lm5hc
Message-ID: <CAPig+cQAbF7iOGtyoVe921sJARaR46sWqdROZQWdb9mOQy579w@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP server
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org, 
	M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net, 
	Shengyu Qu <wiagn233@outlook.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Erik Huelsmann <ehuels@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 4:37=E2=80=AFAM Aditya Garg <gargaditya08@live.com>=
 wrote:
> Add an option to allow users to specifically enable or disable
> retrieving the Message-ID from the Outlook SMTP server. This can be
> for other hosts mimicking the behaviour of Outlook, or for users who set
> a custom domain to be a CNAME for the Outlook SMTP server.
>
> Co-authored-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-e=
mail.adoc
> @@ -421,6 +421,21 @@ recipient's MUA.
> +--[no-]smtp-outlook-id-tweak::
> +       Outlook servers discard the Message-ID sent via email and assign =
a
> +       new random Message-ID, thus breaking threads.
> ++
> +--
> +- '--smtp-outlook-id-tweak' will attempt to retrieve the ID from the ser=
ver
> +  irrespective of the SMTP server being used. Use only if Microsoft is y=
our
> +  email provider.
> +- '--no-smtp-outlook-id-tweak' will disable this tweak irrespective of t=
he
> +  SMTP server being used.
> +--
> ++
> +If not sepcified, the default behaviour will be to enable the tweak only=
 if the
> +SMTP server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.

s/sepcified/specified/

> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -60,6 +60,8 @@ sub usage {
>      --smtp-encryption       <str>  * tls or ssl; anything else disables.
> +    --smtp-outlook-id-tweak <0|1>  * This server munges Message-ID. Retr=
ive it from
> +                                     the server and assign to \$message_=
id.

s/Retrive/Retrieve/

As this is a user-facing help message, it seems unusual and unhelpful
for it to be talking about a variable ($message_id) which is internal
to the script. I realize that there is a slight precedent in which the
help for the --foo-cmd options talk about $patch_path, but those cases
are semantically different. Thus, it probably would be better to drop
mention of $message_id and just present a short and sweet explanation,
such as:

    Retrieve Message-ID from the server.

If the user needs more information than that, then he or she can
consult the full documentation.
