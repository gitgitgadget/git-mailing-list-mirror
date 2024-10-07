Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85052CA8
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271599; cv=none; b=rrJMWz5xV620aGgD4252SydROZdw/fj0/W2Q3hL+JUeZpdN708bWFBttWSoZA9Cv/LCMmUXzaqOljoj9KG6t/uXEELDV6mPR8pvmSmm4hoOKck86h5jsad/sWBqXCmXP2QhwcvQgfTkEJNzA5eCRX9nz2+6099wcu4kNdnpy5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271599; c=relaxed/simple;
	bh=0RkImec8rI82Ad0yRsS1COdj3Afs5jR7QU6qoHbSois=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jdztx1E6UBTyXzBA01s3mkEwbl2s+UGCHJdMlEHmwkQAsw6yauJCYqTu10NNGJrx6IjsHFozU95IRXhs9VA+VGC8IiVivU4UESmKARYKXvJVvsuzhRlHslZeSmvl/OaJe/ZCvI7Ccb6B93n+eluu8hl++RkIYvORq+5KkPC0B68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45831fed060so6638041cf.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 20:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728271596; x=1728876396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RkImec8rI82Ad0yRsS1COdj3Afs5jR7QU6qoHbSois=;
        b=I5c+7mt5+Ib/Zqw7v9JY2J43wD80TFVOTqTYbJ4eCLqtiK9ezuclnjlsuD79/1PriM
         vWxtKvDx7oZC39H/fADll3wTvgXZzp3zMnc9aOjjjplwmzxxIwaJiylAjXKb/PaqoTCb
         nl8QaITUiVL799lQyHrOcCBMZ6Zr62C53f77TlJM7f1TZZD2488MXYR+36Q9KeXyBV7r
         TO7/DCTffqJwGpunYj79zhKPH5uCLaRxjavWKb/jOJbUK+IjPNy7RVct1NLDX3jmtY5L
         7T2aoWbRmZD15CSgDe3ZDAPJiGE8C0F/dckpmI4igAcaxZy3LVWzVj1BtlPbFwDbElua
         24lQ==
X-Gm-Message-State: AOJu0YxBhO118VPRyXH+Ouh+CvfguWAZQV/JE2qbGMSwPvNhgebUenor
	/HYB/D3QKppoJIvLvR5J8jO5Lya1JoUROX2k3/9el8x8UZy9llexXPhR31hHuymW5Nl8XKAIN2Q
	zklmu12RONEGs8RuRQsQWK2leHcs=
X-Google-Smtp-Source: AGHT+IGCYoJfSVWnqfOCs8/NOssCKUdps+2R8rpqNr0P8uMm2WFoBpWiuM6hQClue1JvhWHUFc8yAHGd9qAoRe2+1Xg=
X-Received: by 2002:a05:6214:20cf:b0:6bf:6d90:c084 with SMTP id
 6a1803df08f44-6cb9a2f28acmr75108886d6.3.1728271596416; Sun, 06 Oct 2024
 20:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me>
 <CAPig+cSe0ykN=Mmb8Nwp112ROOCuhzzP0jofvL91PsVi8W4dHg@mail.gmail.com> <LyrqJt-X7sHVSKc-97V4-hTsDiIuz8ucEUMDtLCPWAN15k31EBjZnbeuJ2PldcCVvZaPyudvgb3H00T6uZQsI-XON7Ku8jNFjkfRCgrdr8U=@pm.me>
In-Reply-To: <LyrqJt-X7sHVSKc-97V4-hTsDiIuz8ucEUMDtLCPWAN15k31EBjZnbeuJ2PldcCVvZaPyudvgb3H00T6uZQsI-XON7Ku8jNFjkfRCgrdr8U=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 23:26:24 -0400
Message-ID: <CAPig+cTDK7dk-BNgidQnyTBXi7dqQ1uZ91geerzN4aLtJyHkgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 10:42=E2=80=AFPM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 13:16, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > ... this code now becomes more than a little confusing to read. It
> > says "if infer_backlink then signal error", which sounds rather
> > backward and leaves the reader scratching his or her head. ("Why
> > signal error if the function succeeded?"). Hence, infer_backlink()
> > should probably return 1 on success and 0 on failure, which will make
> > this code read more idiomatically:
> >
> > if (!infer_backlink(realdotgit.buf, &backlink)) {
> > ...signal error...
>
> This was my first thought, however, on unix it is fairly standard
> to return 0 if successful and a non-zero int if there's an error.
> I don't mind updating, but I want to follow what makes the most
> sense and would be most expected.

I mentioned it because it made my reading hiccup, but I don't feel too
strongly about it one way or the other considering that this is an
internal function.
