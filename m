Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A819F40B
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938361; cv=none; b=s/sNaReyC9dsXtk2e1IUWthJwpbKBEI/9piQDqMVY5E8HRP2QqJuf2h1QY9ILYxNOjr0pLM+dK0uyv+JyyNT0+tJNXNZO0qJIfl77nIjAf/csBQilMbyncERZr5T1YNHJJ/nEp8XyYlo9cfzcrrq6hLWarMKHlRcg65kYrECb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938361; c=relaxed/simple;
	bh=L2tTczvVspP41924fCxlHI4sOOTroTUkigCUnP+BFRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9jjNqBVZxob37fxrg23rkrwl22fzeM6mKZEQ5VGg6znsm2jtcOY5h45PEQxiMSXX1gBTGRDWHz8+u9+7HGmjiLs0Zy58PZHbNNF2uZckrPHHWXzPadQl34YpwWDa8Zbrq48PV0PuACNi5x7SpUlGdZ3OaTE8+K7SEGjDuyRsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fa92a47361so513456d6.1
        for <git@vger.kernel.org>; Thu, 22 May 2025 11:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747938359; x=1748543159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHmdKs43XNKDeri2xX/e5tSloWn+TonRTPotkIye9yc=;
        b=nY89YeyJJFCyzsyOkvmjwcDeArKCElkWnnCFWys98Qb51ddE+PmylwOM4M0YPOt2rZ
         +uIOfC6XLZP6TpEal/+omNaBux/T5GCxVVyXq0YLO/WpiFn7cfviuoBBwmA44ggmBeNx
         FqRcU1pUrlB2Cl4cxmi59GAMlDuPxATUr2AnNHJeWeV/Kl6Mrg0LNK0WdlTBdjXnGQ3p
         dJnn2KKHl7Y1PAO1cbz+rEY7p+KO8rhXjsTcDgVhtaTB2uLGjizGSHYpmt0g2W8UiQg8
         Bn6y+26NvwxDw0fYazcXpKSAJC55dZrpv1dWzL66itGZf62tgomghG67C/TjWU24KXWp
         D8wA==
X-Forwarded-Encrypted: i=1; AJvYcCXu6aiX+O+5XESk2aqkFLn/rQHKMvLb1b7T+losuMEdSbH/hpwyRRm7wXZoBRBhYDwcCTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6e0CA8FCi8G31uvW5SMLpJSeAqgdGNZo/UEyWshSKGZvGFQ7
	xc2lFCYUdjTrFKLF907+H+9mZ/Kaa+aNILJkst2FsUxgGXUXlYnYRT0K8GWl1L5TdqBLzoVjesB
	vc9uyxWcBNc23II4/0BSN+9xe5Pn3BGE=
X-Gm-Gg: ASbGncvOGhqxjpwX66SpwjmeicS3U0t1rT87d87ZYhWi186zhvGO/QwF1KuXpwCXsRY
	4GAaGJM4ts07Yk4Hrk/xIM7C2CW1/sVdYfNJuCblt3aH+6p/ZyEpNPpNyvPzmw7bPAtaTqXSD7P
	pMImOePQxGl5P0OUWr78i0ytIoqUuZnPqUi+4xp72nk8G+cTWlM/S/MyXfpDMhY6g=
X-Google-Smtp-Source: AGHT+IGN0ObFmTWo07dn8Y+w0Ep2xrA714xlJmoLf5buCcu+9Ce5J6jcWtlEzbMt26O1SWmyMFZnQR4RC3BZ6PTvZMo=
X-Received: by 2002:a05:6214:1cce:b0:6e6:5cad:5ce8 with SMTP id
 6a1803df08f44-6f8b0903d96mr127541366d6.6.1747938358786; Thu, 22 May 2025
 11:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com> <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 22 May 2025 14:25:47 -0400
X-Gm-Features: AX0GCFsye42GBEIlhpSxkBydooGTES6aWvDdKEV7RcTJF2MyjJLC2xe9uei7VCk
Message-ID: <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to NULL
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>, 
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:21=E2=80=AFPM Aditya Garg <gargaditya08@live.com>=
 wrote:
> On 22-05-2025 11:30 pm, Eric Sunshine wrote:
> > Squinting at the code a bit more, am I correct in thinking that
> > 6d1f198f34 missed a case and that the function is still leaking
> > `cfg->host` in the "imap.host" conditional? I haven't traced the code
> > or all the callers, but I wonder if server_fill_credential() in the
> > same file may also be leaky. In any event, the `cfg->host` and the
> > possible server_fill_credential() leaks are outside the scope of this
> > bug-fix patch.
>
> Not sure about server_fill_credential(), but I think this is also
> a potential memory leak

Agreed.

> static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
> {
>         int ret;
>         char *response;
>
>         response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
>
>         ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(respo=
nse));
>         if (ret !=3D strlen(response))
> +               free(response); // fix for the leak
>                 return error("IMAP error: sending response failed");
>
>         free(response);
>
>         return 0;
> }

It's subjective, but I would probably fix this a little bit
differently and (to my mind) more simply:

    response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);

    ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
    free(response);
    if (ret !=3D strlen(response))
        return error("IMAP error: sending response failed");
    return 0;
