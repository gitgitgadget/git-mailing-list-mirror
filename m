Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544941957FC
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743993159; cv=none; b=MpYjHgo4D0XYkIAOwtx+/iGtSD23DVnx3Xf8rnduWxksvJC4JRMc/Qo4dnUfnceWKufCrs5WP4RrYOtXWb1Ya1t5GDIfPImcW5I5KqHd+OGzzUtFXRR0parHTC+awJ0BSje2oFDDSiWHyPVEOOCEbr32hjMHRp9YnfaGqm2OZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743993159; c=relaxed/simple;
	bh=Ee4qL0ixXaOCU0k4CCgjf6SAPqW1q3SXyqHpywdUcwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/HRprnkb9jt+nMbJZi4/xj1HhydWI+2IatXxvK+HaGWTX+b6Frp9sVQ7IoinoTcME6b63nFlWrh/6Bj1fjB6Uvdh1qq5EFLv1gCKR6JMj9z92P/PeOM5muHKmkpnuNN79oXSz2e6X20VHnyBUVEodtzui8CsOHpmE3wGkcSaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv/mj49R; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv/mj49R"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-477282401b3so40811501cf.1
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743993157; x=1744597957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee4qL0ixXaOCU0k4CCgjf6SAPqW1q3SXyqHpywdUcwU=;
        b=bv/mj49R7SDCvYF9avlB+dN0wfpjaPpDosSuOh90T+AdU8vhV1x+iHqHzlN0RBnu4L
         C7V/LlHwqN7l76K1NvM0uSmSi8t31DUrtLnmINRbi4fQUcDJNcGRUcEv1ZlTMCozkv2e
         Y+SbVikAUYnntQU0GqPu7nl+4L5FORspWVhsesziGjQ7lsGjwPgXyOPbRlP8WrVDmENE
         YjiDmmUdaim5F8OuEDHEUl4Q0BnLI7SRv++M0pR7K9OxMvqm+vNThNJgxV2odoZvxTIH
         PHLvSuSVqUPbS69N4PaJcDCLyMfr5PFMcryZt5Re0KFITGM1027hQR4Dh/loY3ksnmDZ
         xYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743993157; x=1744597957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ee4qL0ixXaOCU0k4CCgjf6SAPqW1q3SXyqHpywdUcwU=;
        b=bZ8AMB86AXVDlMv3bQSE1/FfEk/C7rjFDzoJrjYnzmbUlR4/xBzNHzJRZHJOBcD9iY
         UMsJXqAtJOcLlZvIv/Si5M9LneUDUCZvqAIFG/l1FC4v+d0xV22cnRSnqImNWRvLRf+q
         GxQ7ZeePtwVvwvBPI2vfuIt0pt3MvA/DLGwSbGhtj5+Ri6H+c8tSrHTqnIOfN9GggVpj
         WSXekk6gLajiOvg34Oup1Pytroq+Mwajfsao0PCBCFdz55u3cRzqFulmxOt116jIYSTq
         bZQzZIshHdmN16wHoYCtRyeZhd/1FoQVSTxRhYm2cFgYltG+uWPXCDO0PZd0Z4/7WCwy
         BuEw==
X-Forwarded-Encrypted: i=1; AJvYcCViHzeqe4aROimZ0m7e7xeOX8TyMKAoGlfaLUkrfmSmlUeaPuxACVQ4VJducEae2zsOebk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojorXlc9R2L0omoWLqWmVd5x9q+kCE356uAKZjbRtKV+Jx8Cj
	+d8KwG/ZofxATvrlHWuOSUEu51JHmqfO6aY/iWhjF8Hln4Wq/xSkGy2MIgxIrhMYM1/4YjJ8aqG
	oia9+DymzZEYx5jaeMjO00USVpK5avg==
X-Gm-Gg: ASbGncvK7gKh3EBbscqD9e5gs869jCOZBOMmNEguH5zZifY71EkyjIe8CStqahwDqbG
	JaJBENK56fL+57KzVJasQCwZ94YMdxf0SaTjv+rh7g835LAJIHb+DqUv54+a8EXbyKwwpIOY6FQ
	xsTtUBx7FLBSqCe/DmGJMb1DOGx4ZKk5Pxn1tXNpRkNmbR3AQhzRCJlXNheLJT0TDPaTD4gQ==
X-Google-Smtp-Source: AGHT+IH1viB3VlG6XmnjieuW9gQ2z9kWmnraPSdeuosyrqG7nlze+cRZH8rtE4B2QLSzHq1BZJrPh4L06E7XLteC3MU=
X-Received: by 2002:ac8:5915:0:b0:476:870c:300c with SMTP id
 d75a77b69052e-47931007ce0mr113556331cf.25.1743993157202; Sun, 06 Apr 2025
 19:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
 <Z-5hlL1Gk0oi4fX2@pks.im> <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>
 <CA+rGoLeRXUQu8ZbDtaLp2_YbVGA5D1DeA2vSEcLf74qXjB5U2A@mail.gmail.com>
 <CAOLa=ZQCTJLSWV-y-=nKf9J4xKr5miAo+35RktmbGmHPL4Sp-w@mail.gmail.com>
 <CA+rGoLcDt0r0mDBk44SY0NcnG3mNBy5vSNBLzeggsGwJ4d-Cwg@mail.gmail.com>
 <CA+rGoLc9g4werz-k4_ZzfNLLGHjzHoOcFYSmV5V-Krq04drgZA@mail.gmail.com> <f5ba0329-5789-4c20-a2ea-b213365af5a5@gmail.com>
In-Reply-To: <f5ba0329-5789-4c20-a2ea-b213365af5a5@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 7 Apr 2025 08:02:26 +0530
X-Gm-Features: ATxdqUFu-t8E0sZOfVAXkDrl9srKOXuBot64n92wbomcnUVVqIOGhV-YsJD-_kU
Message-ID: <CA+rGoLfPDVmxN7QQjjNhiwL=c1PUiQRKe8JGqkbm=dEaqWJ=9A@mail.gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Sivaraam,

On Sun, Apr 6, 2025 at 11:38=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi Jayatheerth,
>
> On 06/04/25 11:39, JAYATHEERTH K wrote:
> > # Proposal for GSOC 2025 to Git
> > **Machine-Readable Repository Information Query Tool**
> >
>
> Thank you for your proposal! Just wanted to send in a gentle reminder
> that the proposal submission deadline is April 8 18:00 UTC. So, there's
> very less time until the same. You may want to consider submitted your
> current proposal and use the option provided in the GSoC website to
> update the proposal before the due date (if necessary). This would help
> avoid a last minute rush.

Got it, uploaded the current version, based on the feedback will change it.

>
> Feel free to let me know in case you face any difficulty with submitting
> your proposal.
>

Sure, thank you!

> --
> Sivaraam

-Jayatheerth
