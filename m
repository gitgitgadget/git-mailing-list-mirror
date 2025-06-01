Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115D17A305
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748762950; cv=none; b=Aeg1J+FAKqHTPi9A0CZaiCZRuL1u1tFX4NB0XbcwsrGcuKDepvmvy0yjVUjqi/Cv87KYH1UedV2oi7hu3ZAoxFplLkQR2DoqpFccs9KPvnQGS6yemdJEvoL6rYi2C361TdqIAOYXjFHnE5wgqF7PBDveJBaLFDzsGhGaNiwHVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748762950; c=relaxed/simple;
	bh=zMRtNwETtfw/ZA2l5FG5U5qdsUrKEwtCete6Oci/CHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3k2IA/alDYIIwFLsnLq82u/RHdyPVDjhSorsGn5+jax260Nw6T16xT3L/vFxsaGIFg91k3tgEqJm1ZIkcV4EZdcVBv/uKGAFru9PAOqISjDTP4s1E6iGR0OHSkdpJl4pvd7Qb1q3iS49MAFIc5KnhcCw4aMkVkjFMb6KdPevKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7cd34b6ba10so48786185a.1
        for <git@vger.kernel.org>; Sun, 01 Jun 2025 00:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748762947; x=1749367747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FboYtMMCV2cXvYmRS3vYQ/XJxAbzSIZqdYzNhIpZYc=;
        b=sbKe/IvUXlRP1ql5gfiA/WXh0qUwWcAQuWufVh8XdKDAz/EXpr/EIUY/fbxQJOPfz8
         yWQdZfHJTgbUl/SECy0oRbpVHDXlR4Dq+G2q31eWZd5MnpvpA+F4MF2hZclT/fA40+E3
         ReD24PJO6V991aeL8dignbhffDmV/AxP3j8uV1dBV5R75Ep1jjYu+WNN+5Fa8pIYW4Jv
         ZPJgprDiNfkwemn2A+dtIudpyMihsBVY/C1wbv47rU+O+U34HPmQrrp3z1SrVvLGSmpn
         joPiTDVjt82V1TD2lXDcfN6OXUfPTYi31BkmsmweljFVSjzEnulpupE2AX6Y+gNAmwII
         dz9g==
X-Forwarded-Encrypted: i=1; AJvYcCWT0zLLpl8rX7gNCNixVtRDqaEb6hj7ll8+nOO9h1ZWDm8CYNLiB11sPP2rvwPgb5Ms9Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UFkvby4W5StybxY7qqpd+LLv13DLMkB1Bz/xz8WjyDRI/2vQ
	zACQdkFAUKk/lvUoAWdG/65raR6y5Zg8tgKPV31SFGXDIbR7QrDfMQPKtGNESVLmQcmX2oe2VvK
	ghv+QIGyfh9feTMY3UfWLp+ZpQ2OqRD0=
X-Gm-Gg: ASbGncvjR6buS6SocbbGEZVszfFZGh0Ry2+mjYCpyoy8/dtZMsOk+JBypfDrSIkAsqv
	almt8mVeoyIF8I8taworcetRxkQtXm4wI58UYoUp9gHzSTkOWh+pJoCEwNa6WNJYk+TFGEngMqu
	9nAb/39FhBFYyk/ME+xDALwaKAp1AVQkQ=
X-Google-Smtp-Source: AGHT+IFid3zpvd0q+lOSylk5ScLnQPED2sc4hyEYclkwDcY2M4MEMS0okqer9XONIWwb1TioR5Iomteydse6PlmfoyA=
X-Received: by 2002:a05:620a:450b:b0:7d0:99dc:d027 with SMTP id
 af79cd13be357-7d0a3d7b3e7mr451953085a.6.1748762947610; Sun, 01 Jun 2025
 00:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A33B17E07B461A5C276EB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597A33B17E07B461A5C276EB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 1 Jun 2025 03:28:56 -0400
X-Gm-Features: AX0GCFt0vswbxhYoZazAN0l9d-F4hJFzdw5Qiyy0jHrWrRcglLVYSWsOxp3No3E
Message-ID: <CAPig+cTUFAFYx7SLtSbgmxuZUbbwRG3011fH8s_jFkWbwO=uig@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] imap-send: fix numerous spelling and grammar
 mistakes in logs
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Zi Yao <ziyao@disroot.org>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 3:12=E2=80=AFAM Aditya Garg <gargaditya08@live.com> =
wrote:
> A lot of spelling and grammar mistakes were found in the logs shown to
> the user while using imap-send. Most of them are lack of a full stop at
> the end of a sentence and first word of a sentence not being capitalized.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> diff --git a/imap-send.c b/imap-send.c
> @@ -249,9 +249,9 @@ static int verify_hostname(X509 *cert, const char *ho=
stname)
>         if (!(subj =3D X509_get_subject_name(cert)))
> -               return error("cannot get certificate subject");
> +               return error("Cannot get certificate subject");
>         if ((len =3D X509_NAME_get_text_by_NID(subj, NID_commonName, cnam=
e, sizeof(cname))) < 0)
> -               return error("cannot get certificate common name");
> +               return error("Cannot get certificate common name");

This patch generally seems to be taking the code in a direction
opposite the rest of the project. Quoting from
Documentation/CodingGuidelines:

  Error Messages

   - Do not end a single-sentence error message with a full stop.

   - Do not capitalize the first word, only because it is the first
     word in the message ("unable to open '%s'", not "Unable to open
     '%s'"). But "SHA-3 not supported" is fine, because the reason the
     first word is capitalized is not because it is at the beginning
     of the sentence, but because the word would be spelled in capital
     letters even when it appeared in the middle of the sentence.

> @@ -1053,7 +1053,7 @@ static int auth_cram_md5(struct imap_store *ctx, co=
nst char *prompt)
>         if (ret !=3D strlen(response)) {
>                 free(response);
> -               return error("IMAP error: sending response failed");
> +               return error("IMAP error: sending CRAM-MD5 response faile=
d");
>         }

Providing more context in the error message, as done here, seems welcome.

> @@ -1223,7 +1223,7 @@ static struct imap_store *imap_open_store(struct im=
ap_server_conf *srvc, const c
> -                       fputs("Error: unable to connect to server.\n", st=
derr);
> +                       fputs("Error: unable to connect to server\n", std=
err);
> @@ -1343,13 +1343,13 @@ static struct imap_store *imap_open_store(struct =
imap_server_conf *srvc, const c
> -                               fprintf(stderr, "Skipping account %s@%s, =
server forbids LOGIN\n",
> +                               fprintf(stderr, "Skipping account %s@%s, =
server forbids LOGIN.\n",
> @@ -1594,12 +1594,12 @@ static int append_msgs_to_imap(struct imap_server=
_conf *server,
> -               fprintf(stderr, "failed to open store\n");
> +               fprintf(stderr, "Failed to open store.\n");

Taking the above guidelines into account, these probably ought to be
changed to start with lowercase.
