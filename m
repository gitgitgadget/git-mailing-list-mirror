Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8935148850
	for <git@vger.kernel.org>; Fri, 30 May 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748638296; cv=none; b=Rm6RZOUTrPaFKFnYB8LG2cL6T5Mg5mKzR342VE12RCXJHKaJxATfw8g9Qrydv3CJ7qqCkfieyNowYhQRwFg691UMRAWReX+YFvfjf+VorrAUMrZg5GIVlJNIDP+Nyta3a9QJfgL+g2yl1ChLDVsljxRKwlXJEDWjc0deS08WPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748638296; c=relaxed/simple;
	bh=zLhv9/eYqNHN+zRD2NqWmf9GiTPdh0bP0kmf2LkOYXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqWY7CtiI13QKhetqFdaQagJC9KhGdI27KqVnXvvtw4doCUDeVLwmrYVaL3r0UojqAsCnZp5hR1iQXXKCCr9gTNPq8apRKPzL+zkQg+lH3k+KOzzpQKcUlFD3QLXABqDfRJOFE3B0rDF08zl2rdNEx97/OQjKR8Pjz7FnZd1jXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d09b0a504fso22136285a.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 13:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748638292; x=1749243092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqw33rX65e8YlWbSav/mrNC552BRGQWjbA3AgEKnbBU=;
        b=tMO3tF9Bbna0luqeJmqumhQJLOrhvriex4Bsw41drRpS2DlK4Sxrv4upX7nrDj/OaX
         K5+7wERIQoajCWlRXY4qpgcoqKoMCty+B+q3agAA461PEBfAMA+78iQAFtCJXRN/S31e
         wGg4ivwnoBaCISusdej4scSa07vIr6pju3+KB0E7sz/GGdwvSLFm5mw2Unw57B0XymF7
         JiZzhNlbpmSXHIPO/HWA6gVgGQSi6OKMVHD5TPFqVjkW/3eNTZxnqvHR8v738RAxQtjU
         GUj7Geuc0YiMkGzod4gMaTLpX51yn7YG1M0wWgb7by/cVLVW6Lb1GoK9NC9OzgU7xPiZ
         Wq+g==
X-Forwarded-Encrypted: i=1; AJvYcCXnYfIlzRhEDL58/BvAQpMdS2suND7D/ZpLJQ/JlbiMNgh1yW5hZ8ZL/5da5X46at4nigI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj03jX9bH7UmxiVJ2upDRKxjpKNUHOGFnEFon0sF2G1f7eeRDV
	PBQkkrReMgLbT4cWBg7yehjbv+9CTGUSF94UJleVXnhO4Y7YbGqYPiInRqIpRAoE07I6XLo1Dpv
	vVhXROlyTH47wQeqvBNCe8GwMR0axgRw=
X-Gm-Gg: ASbGncssXmjxaa5z/ounpT+v2ZdeS6C++dUfzI6ragR2LvhqSY1nQhM5iYNYZAwqWyz
	hWqLQrMF5d7rvc3rqXjgM/QiIzMIF9PN5JrMyWJCdUM/hPiu+zWoz9eH1b0YyarfE3heniiFgu9
	DI3+6uvjiX1C5ri/dmhS9SZQGAcp76Lgg=
X-Google-Smtp-Source: AGHT+IGjYWX+1T/pXjCLyDyKG3cP5HdZl3wPFL/pCzG9dtEaaaC2Y/eXVQx1YHBckR3jIqSsJOpa/2YlqI3XkaAfIuw=
X-Received: by 2002:a05:6214:2586:b0:6fa:ba95:e4c2 with SMTP id
 6a1803df08f44-6fad076d130mr18896226d6.9.1748638292621; Fri, 30 May 2025
 13:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BD09F7A450C6CA26B421B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597BD09F7A450C6CA26B421B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 30 May 2025 16:51:21 -0400
X-Gm-Features: AX0GCFswbvJVmkMxYFiV1W4i8vIw6vh1kRnBhFNSLbijNBZFvfNjR3cmoJ1Ig9s
Message-ID: <CAPig+cSFLF9de3i7RsG6j4wSGkRRhGgOGOovoFXm9U2+t=qC+g@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] imap-send: add support for OAuth2.0 authentication
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Zi Yao <ziyao@disroot.org>, 
	sandals@crustytoothpaste.net, Jeff King <peff@peff.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 1:32=E2=80=AFPM Aditya Garg <gargaditya08@live.com>=
 wrote:
> OAuth2.0 is a new way of authentication supported by various email provid=
ers
> these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms us=
ed
> for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], wher=
eas
> XOAUTH2 is Google's proprietary mechanism (See [3]).
>
> [1]: https://datatracker.ietf.org/doc/html/rfc5801
> [2]: https://datatracker.ietf.org/doc/html/rfc7628
> [3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#=
initial_client_response
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Not a proper review, just something I spotted several versions back
but assumed that someone else -- providing a proper review -- would
mention...

> diff --git a/imap-send.c b/imap-send.c
> @@ -885,6 +889,66 @@ static char *cram(const char *challenge_64, const ch=
ar *user, const char *pass)
> +static char *oauthbearer_base64(const char *user, const char *access_tok=
en)
> +{
> +       /* Compose the OAUTHBEARER string
> +        *
> +        * "n,a=3D" {User} ",^Ahost=3D" {Host} "^Aport=3D" {Port} "^Aauth=
=3DBearer " {Access Token} "^A^A
> +        *
> +        * The first part `n,a=3D" {User} ",` is the gs2 header described=
 in RFC5801.
> +        * * gs2-cb-flag `n` -> client does not support CB
> +        * * gs2-authzid `a=3D" {User} "`
> +        *
> +        * The second part are key value pairs containing host, port and =
auth as
> +        * described in RFC7628.
> +        *
> +        * https://datatracker.ietf.org/doc/html/rfc5801
> +        * https://datatracker.ietf.org/doc/html/rfc7628
> +        */

On this project, multi-line comments are formatted like this:

    /*
     * Line 1
     * Line 2
     * ...
     */

The same observation applies to other parts of this patch, as well.
