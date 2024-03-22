Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CD1A38C5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074923; cv=none; b=K18unnVROnx12dsluzB2iZ3NWhH30Nty3M+53RKCXTIXXln5N4N14WbrguJW7XsXioKeBbaAd5Wj3z2pid4uhSEfKIqu/wwsUu8G+O5nLTAwS/xert8jN+EjpcAvwAytnIV0ZTKRurbn6+gZKhGVX20/q1kKrdBmUjrQnNOuzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074923; c=relaxed/simple;
	bh=ufEu7PdtQYhRixqUMI8dYbRDMHS0vFIA0KD4pUc7f3o=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=oT1pb69M7H0ajiWktT6BMQ7ndqTOntG+AZOwMkjnQaF4xoSX0Q1EoNmzFhSGZSDKfzLukGopD1JThOwLHVMq7027JUE0MORyAiFMxYE/1+nRw8aMXLP0eor8kCLXrvn3IgXnlGmubXLZkB2abwuOOZpyoMzBqPoh7AQiR5aDKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX4qjnO1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX4qjnO1"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6918781a913so13838046d6.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711074921; x=1711679721; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rA1zq3CfTpVsODZFjIEi0FFbMh9OJPTRLFm4mRhB5so=;
        b=HX4qjnO17dMy++bluzOnn64BEufzMHDMNG9ytQTF64nJW5z0iRO3b0gIdh84fSDTga
         GgMLfEgyPuw//mXQclwFtS2rRLukFZt1pPZ4XJFrotFk1nW0wnfphM8XanrFO3IZhkof
         nMfeS/a3VsKaxnbzV+/znZMjhd3nxLJo666a/tU9Lw9yy5EG9G7kZgekinAtIfAv2M3p
         w2argPkxZr4sYx1l7B/I0BOOae3o97UzNHvPgPtASjrPKmehPcuOEwbsSWGw4nPnerOF
         yAJxcZYmQnuybsZcmALjVaEejUpCZRaEQc379cFJgD/XIBaTvSjFJ4CrsfsExqSDmd1i
         OOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711074921; x=1711679721;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA1zq3CfTpVsODZFjIEi0FFbMh9OJPTRLFm4mRhB5so=;
        b=n1qBIChzDq1ZNBBtKZaI+hP1tC/zrmJA5ccBifLw2CJr+GNu27HGVHHNY5Q6usySuk
         aLGA8loBf+12JTwiqS7Fr0G1bUbUI2z1xKMIleJmZEUgOG2/xiwEH929iIPRMj0mgwvd
         xBvumDVC0crIk2wtTBm44V+CRie5db2HB47wsV7shoHEz50vvtL+0FVJCNGlsdEgIBfY
         nJELV1dBu1bCuG0oqN1ORvaHzjmtJXmyPd77tTfjybdgyF8+KsgA5OdpNiSEJWvOWXU6
         yyB39ZzPp+Aly474ZVsok7qNK8ek6UZ8XVJejPwgj2XUpf5x6Mk22sHtU3/xNqWYmiAB
         ISCg==
X-Gm-Message-State: AOJu0Yywxns2+BtzTfbExIN1AhXTxMGqrWEAF9FPLUN+4ycbJNCwHfe4
	Qj8EFcVkCLOplMM9Q/mFwh2XGDbtIMPJ9t8F2qwfF6NWfzXotNReiL68AADd
X-Google-Smtp-Source: AGHT+IEnm0XMTIeORkUzeyZRfGh5VyS8Ax91oKobCiQmwevIFDSzE7fHmpnKR+N0xLh0Me625AFcTg==
X-Received: by 2002:ad4:5942:0:b0:691:837c:a140 with SMTP id eo2-20020ad45942000000b00691837ca140mr1074193qvb.64.1711074920658;
        Thu, 21 Mar 2024 19:35:20 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id t13-20020a05621421ad00b006960f8a6023sm585873qvc.69.2024.03.21.19.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 19:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqq7chv58by.fsf@gitster.g>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
Message-ID: <17bef592f076ab87.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 22 Mar 2024 02:35:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Thu, Mar 21, 2024 at 9:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> "Brian Lyles" <brianmlyles@gmail.com> writes:
>=20
>> Thank you for clarifying. I will let you decide if some updated wording
>> is warranted in future notes from the maintainer, or if I simply
>> interpreted things in a way that you do not think others would.
>=20
> Perhaps like this, then?
>=20
> diff --git a/MaintNotes b/MaintNotes
> index 57aa6dd..18d8bcb 100644
> --- a/MaintNotes
> +++ b/MaintNotes
> @@ -34,8 +34,8 @@ and Documentation/CodingGuidelines to familiarize yourse=
lf with the
>  project convention.
> =20
>  If you sent a patch and you did not hear any response from anybody for
> -several days, it could be that your patch was totally uninteresting,
> -but it also is possible that it was simply lost in the noise.  Please
> +several days, it does not necessarily mean that your patch was totally
> +uninteresting; it may mearly mean that it was lost in the noise.  Please
>  do not hesitate to send a reminder message in such a case.  Messages
>  getting lost in the noise may be a sign that those who can evaluate
>  your patch don't have enough mental/time bandwidth to process them

I think that makes the intended meaning much clearer. Minor spelling
correction: s/mearly/merely/

--=20
Thank you,
Brian Lyles
