Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775630DEDE
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943640; cv=none; b=NJcwZmpqYnYlbg2u4cc6oZfQjr5IfUjcN7Am4OvofyXy/J/JmIqUu98/PpDsT8qWqR6l5HtLG8/736RFItL9kGN9eMTbHtAvAjXUl5GxGioKIqY6opLuwOiJbwrJPtwTGe+18Zo1m3ixXwskV0JcRDt5XPNkaKzt0VoBBRsAiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943640; c=relaxed/simple;
	bh=IbWo318A00NFQQexc4dwPo1zOTIo9dTlHsrU9sZbLAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYQM9bX+L0yIVE4E6zT24cLVgjP91dtUjOPsQAjYzr9kpeW7Uea5KqRB+d3xnVyOkRoaROi/R1OxxvuTF52Ox4nWkucgxWWqixDzKZNO+6Unq1cXRm7iLsJYPS2fp4v86wiOCNdZCtwvtOBnJ5vVQ3Z1TEqMIMZz3nRHnP0eSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/udtB05; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/udtB05"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d71bcab6fso36767527b3.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943637; x=1758548437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbWo318A00NFQQexc4dwPo1zOTIo9dTlHsrU9sZbLAo=;
        b=A/udtB05JCGQvVqQ2iPPXXTXTILD0gebLYFky3L2fEyVNX2Wuer3ayGWCtk5+GLIyu
         zaBY5wenzZ97mnl2XPBaFgrIImXnTZmRiYUd78vsFWTAxHKa1gKbFsBrKS2jvHUpYryV
         svBrhKpfu1Ru0/H0xtzad2bWo4AK8p0IJ8uN/79fICBWqrp+4Zi7PVHXe5TgzsM1WVBV
         VQ7THFSxc87+/gEzQvVlNtqWEGzzQ/6Yn7r4kFykXkUzmOJQvznGm7daeVl2kMGy7VeX
         RDcaFQF2nhUaWj1P06IcdHJ6pYCCy+axh8myAZ5nxcvFF6kt+IRDBu1O+GGWmHoOh+Eg
         v1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943637; x=1758548437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbWo318A00NFQQexc4dwPo1zOTIo9dTlHsrU9sZbLAo=;
        b=g7SA/yuZRj2DOFBiPHE2Rx0fn3QvB6c2zvxBMvWNo+XH+/CZEUsYuN5KnfOe7yuLQs
         za6HGLRybsGynyc1Plmnvw9mIjWEN0T0SsLvdVessFMWtU43WzovbMK5ycevmYBcJAjg
         yqgM+GHckx9Wgk5Pv5G1q3NL08P1qM0HqDHdSYKk+SWuW9f0Z0XB6e0LREK3nFCwWYAl
         v3ALx82YFo190aqvRYX0Jn2IlB2dC0cEh/T7ZaRBqfrR7UxlgDEEU0/mlHww2puFSQBc
         qgbZVKNsFcbpMd/azAnWVGZu7HZaeZEaXG6crHtx2gCwjv3ILK0iuu+0BRPOlMDi7eWK
         bohQ==
X-Gm-Message-State: AOJu0YzvkptoCrfAWrSQ2k8EQueNZ7bSYFSH0Toi4JH5xcAV4rWajlqv
	dVVpfira4uQUKUGtXTAlefvmEpM+CYbyVyX9G3isZU3efeM87CGNQd9wjOlfF2KN6/GImKRVzpp
	t1cJ8Nxh25HMA9UUtRQ6w9XBx6cGkGZGa5JGASM8=
X-Gm-Gg: ASbGncsFEfljXNZOfGf1tAPiM+tjEPyiOtMDuBL+vtMsZLfJ9RkZys6HggBh+2RELzp
	QKoIBomBxjQW2HNwGw0a6afC1rnJgpoVq76WkkEdPdfGzWVzo9xnfThtsvQm1+gcH00DCMVIym1
	Aed5Un5IVdUbuYr+4ns+3PWfme3J/fyVMxhir8Wkr7lFUpUtQHGx9P8K2yATx+aYDjBFoDyFHPQ
	4C+rfpX
X-Google-Smtp-Source: AGHT+IFq2OVqgEQxOrPqJfP6ESsHslSqdOpLN1wo8w58oYmpIFYzEGcsX86noxQ4PZqCuGDGxpd1BCXsuMaCkgngXok=
X-Received: by 2002:a05:690e:201b:b0:624:1660:ba01 with SMTP id
 956f58d0204a3-627262e88f0mr8606105d50.37.1757943637198; Mon, 15 Sep 2025
 06:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
 <62774477-81d2-4959-aa5f-fe0dca023a2a@app.fastmail.com>
In-Reply-To: <62774477-81d2-4959-aa5f-fe0dca023a2a@app.fastmail.com>
From: usharerose <ushareroses@gmail.com>
Date: Mon, 15 Sep 2025 21:40:25 +0800
X-Gm-Features: AS18NWAEwSZXgIoYNFx7HIEuT48oKUYnt2jdHg0huvoLg5-n9NYsh9JnMmZWVp4
Message-ID: <CAJKmQvcUQnsgcWW5EgUEaDwZKdtWXnJ1aoVQTAdvG3+te5p1ug@mail.gmail.com>
Subject: Re: [DISCUSS] validation on git config user.email
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 7:58=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> What=E2=80=99s the positive case for email validation?

Thanks for your reply, Kris. My intention behind the original question
was not to suggest adding validation for email legitimacy, but rather
to inquire about and understand the rationale behind the initial
design decision to forgo strict validation when the user identity
feature (user.email) was implemented.

I've come across many explanations, but they mostly list the various
application scenarios for `user.email` value. I haven't found an
officially recognized answer regarding whether the above applications
were explicitly considered during the initial design phase. Therefore,
I would like to consult the official community here.

Thank you again for your help.
