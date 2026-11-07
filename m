Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794082975;
	b=uYSDKxsAzp6tom4gNHlIVtqXMQUswA3Lx++b88MY+B8XC9PKOqpBwPLjvV0ftGugELtm
	 hNUUKgD6X3gQd7mShpC6H7cFf7ROu+yXfgf2PNd3rurqW26S94BUiY7Dcurg3XorK7Ic3
	 b1U7nkwR11XSieUJDDLiEBj0R+CNBJjJpv4pDxWjpaDRh+GVxmqTJPFaKqqzyw71RUZrM
	 4y8TJIBbpKIulau8QYrE3Qp0f7R4tK0IH4Vjme4tCN8WldWLagOSJ55VBc4ocgXiljte/
	 eZaKgZbEGr5VIHzwe1k37mAUteCgI0Vb1ypdcIgSfFQH+XmEYTkr9DQxLzvW5Rs3egQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JOkwIywIqPzz1HzdqKqVgUAr4pH1jFgDjphBe7/Ofv8=;
	b=mjfyphrjFjATQHvUb+XuHkvFnAkXzJaGu0Wq9TGx1Cc34As15ngYpRzskAjKDzcxdwJg
	 d9t72tQ1pYFhMdpU7roCPl5hHRoPQ+7XId9cnQemggfr5hxnmAoZ/Xvx7UTsZ0iUsXIp0
	 2z238/K1wCG8rvtDlXrdZL4mm2aO8a3/nUE01A3pm8UI1GsIREvyU7lcF/7vc55q4G4tQ
	 Mrf4OZRNovL/LToRVJQYE8A2UFTAajKdZvxduMdfLD2f4makEt7ZWwufEfDYtWmNkAJHu
	 nCO6tdgJoqTlzf05kMZuovjz/JeMk6btG6j3OG34MSxCStnFCF/K15XHlLxcGve3Idg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPDix7Z9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59881606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 20:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59881606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPDix7Z9
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so7917a91.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 12:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794082975; cv=none;
        d=google.com; s=arc-20260327;
        b=M1CKquGsHDsAu5FmxTOo/FRc9TgjLSJOZqhHDY+DgOKubr6n81iqMgHD7Ay/9Y0uKB
         Kp3bseoEZ7I5eZGA+7vAtr/eLx1avl+CGSKBhhb6TvZAP78N4m+LI7ickDCtlgcXI+6U
         50rnPx/MWSoeBR6z84EiVFQSoSMlGrpNV0N3CLB5l0Q+6R4Ict7X62BsydtkOXEldFpa
         0ksFgEbmuDHrAr3RtwpFVepVksUqamJnofzzMiTTN86Jaffq/LxJY8NCAdgS6+t9WcGR
         wcnkP3AwHUZz8mquijdcIZzR+EN29TPTcJcgbq7Fd1Y4fWt6n29n/74jI5482qc4UKFV
         QkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JOkwIywIqPzz1HzdqKqVgUAr4pH1jFgDjphBe7/Ofv8=;
        fh=Pfqtozic0s0JshYzqx+RPsNBG9mXb5Sb/3g+nM8CA+0=;
        b=OZLW7d1CIKrLtZAnzm05yFsX97YCI9zFUMH7gJQuGshBjQng/1geeQIs3wdB+8zvjZ
         fRKw/3cYL0ySyq3dWiXu80DmTroOnnM01g1D5T2icuUz3+ssYFcpsrZj19AKiqgBDkEV
         SQG8Ag+vmiaYvECmqiicm/0XHi4c78UTMlIpK9cSbTjE98wRxJSI20bAnqYWzklqbhKo
         289e0vDKdhSmCY7vcr4bCHOWNwTuzrhErYHwp9JY/Q4k+qzSWItJEiq334C0R/zK2tv8
         xJzLs5dnKxZxXW70bs9CJi3xYWCohzusRZp79H60SuhROJiYQc/dFPS1Xns+9A/rjMJv
         C2iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794082975; x=1794687775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JOkwIywIqPzz1HzdqKqVgUAr4pH1jFgDjphBe7/Ofv8=;
        b=bPDix7Z9sEAAroJhU7IQM2WltiSGDwx+rcfVzMFYGgc1xcpLGcmNmeaMyLAW3cPptJ
         oCQxUoSs25Wa3zK5Doiwb04d1RuyVBGL7CHI5d9HXuSWk2Xe9bCtNTkxFkZxrmLwFeHG
         1Hm3gCeqZTtY2yylFnTZl6Lq0n1nADnbydSu7WVPknfmNCFsQ/wpKU1sbQect6SrYw+K
         uQBNYVTreUcx/i9gTFg9KpyHoM6+oHxiEABQiqBN2wZZR2MC9gf+LZeUrmCo9/8Z4UMY
         XnOgQuLxofT/GhcCGl1hVtoM27Q3mksNcrNdbdeot8b6L/AnLI0tZx5SIKqfQSgWJYnd
         RTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794082975; x=1794687775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOkwIywIqPzz1HzdqKqVgUAr4pH1jFgDjphBe7/Ofv8=;
        b=1Hd4f+mtEaPJPoj5EICNr75OlTjIFDkynj2A+hi9ho8Y5281JxIk32tusBMSWfunVF
         bbQKAxw+jfhbBEtZLGPdCOSiHGIMh3uo2BDZgKHIUQR+c/zVhuKOmgwH5IZlskPtUdms
         rWneHE7HiLrvTmY716XdSA36rSP7hK2bxijRBxA+4SG9w4XQGls2Q5GhydHqXyVthQG7
         G51GWkhKrc9lnKUtA7MR35FGcTHHMCoG4BelF0QFJyiOup7hNqDgvUt24ZQAZzDHX8sZ
         nbLh7xmst1KLkypbWlWR+hvw5HYWrS+iaVtmHU04+Ce962HjkoWQUdg2Kdk2sLzrgG1A
         qNGQ==
X-Forwarded-Encrypted: i=1; AL+hErH1njWKTQCsu86IjGmuxFunkmWNpSi+ASgygkuZtbO4yov0ZFzlHaXfBl3+Ih8619WPirE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2DfLpluab/XfiUCwBSbkXLM2DdF0gP2m5hlL5mF4vIj1dLalm
	71897HDQHulKo4J56iG6ZJcG0UG8ilOPyJq7RVokIPioIrE6F9+ddR5ZD2lEGzB+42M6PdkJY20
	tSH2Uz/1WRJnWo3Lh40X6JSBKd404fmA=
X-Gm-Gg: AYBFou2A/nrdWt1a0yEGPBu7NvoIloGv8C7ZomdnwDBDlgO53EQeUz9SQMwTfxVcs+3
	fzF5CxDyoqPSkD7pE69R8HC66AvzVdwJ9JLg1MIAKaA288vFgkHyXi/PLrEe0tDax2GOxtVNXox
	onAGzcaqbpT3d3K2Lk8Qn3FLp0P+JZsRC9SVqOiY2JQR19hEr6o5azQR9zHxlDtC5i/nAXBSo0N
	voNUdO7KKHj7ZYiLiNIoFx33ff4tDhIx+TOBpjHZps43QRTK8wp9uTGRERZkOiBnLYPiRzIr4CV
	nSLP8NFqc5g+Zc6FyWb8CPce/AH7lGgc1egBpjTkmnZX56L04UnAcyIcYKFAWhQL0MFbbl3Cg/n
	B32aPZborVVEcnoXNJrHL0Dnw4oBQqKZUbc6F6DS+KRrtJwY7ivrB33uXP4v6p0rqxdPkrNmFig
	OaHnkSce2h3Y/DjGL5CN7MICOcZnNIJoSmzoQz5EkL5zAT1/JqvHaDprNHsSknLfhDJ2AxIGl1b
	qsYX9PnlwFdPFk=
X-Received: by 2002:a17:90b:4b0b:b0:3ac:b145:8f4 with SMTP id
 98e67ed59e1d1-3b0db6f7ffbmr7199833a91.41.1794082974660; Sat, 07 Nov 2026
 12:22:54 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <78d4b7c0-3a3c-4d4f-a9f7-4a6f7618ad88@app.fastmail.com>
 <2A1E1423-8C1B-48FA-B1BD-DBD422748623@gmail.com> <528139f6-db92-4061-be0a-88d4c376d252@app.fastmail.com>
In-Reply-To: <528139f6-db92-4061-be0a-88d4c376d252@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 7 Nov 2026 15:22:42 -0500
X-Gm-Features: AclHuK-E9lZts6vdyYViwpwIvQKtJtgwKWqfUcouMSEIGlrwJeQVFXGWMyCr3SQ
Message-ID: <CALnO6CB9LKjJ+NeSacJCUNrhWLNj6CM2Oo+JR9c7ZdohQPJWow@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:46=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Mon, Nov 2, 2026, at 17:49, Ben Knoble wrote:
> >> Le 2 nov. 2026 =C3=A0 05:51, Kristoffer Haugsbakk <kristofferhaugsbakk=
@fastmail.com> a =C3=A9crit :
> >>
> >> =EF=BB=BFOn Mon, Nov 2, 2026, at 09:51, Junio C Hamano wrote:
> >>> Junio C Hamano <gitster@pobox.com> writes:

> >> For you all=E2=80=99s information, what was originally totally unrelat=
ed
> >> research has made me doubt whether this command is needed.[1]
> >> git-diff-tree(1) cannot do what this command does right out of the box=
,
> >> but it looks like some modifications can make it a replacement for `gi=
t
> >> format-rev --stdin-mode=3Drevs`.[2]
> >
> > I saw these come through, and I=E2=80=99m not sure where you landed.
>
> That git-diff-tree(1) just needs to learn to optionally NUL-terminate
> diff and log output.[1]
>
> I looked into it after that and the code has turned out to be too
> difficult for me to make sense of.
>
> [1] <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
>     https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f0@app.=
fastmail.com/
>
> > I was mostly interested in the stdin filter mode that turns hashes
> > into references; is that supported by your alternative?
>
> No it=E2=80=99s not. `git format-rev --stdin-mode=3Dtext` still has its n=
iche.
>
> >> [1]: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>;
> >>    https://lore.kernel.org/git/ce69d94e-7329-449d-b3c3-47d4f3aa608c@ap=
p.fastmail.com/
> >> [2]: <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
> >>    https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f0@ap=
p.fastmail.com/

Hm. In that case, what if we made diff-tree do the things you want
from, IIUC, the "revs" mode, and made format-rev work only in "text"
mode? That would make invoking it [say, from an editor ;)] nicer, and
also cut down its scope a bit.

Or would you still want the somewhat higher-level interface of revs
mode to be an option?

--=20
D. Ben Knoble
