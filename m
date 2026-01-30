Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89963644D1
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794571; cv=pass; b=lgq/Odu24O2xujl4zmRts5BNCJyCSTB8stGJlAFnB2PtxWp9bEse93MMcvPNYJsxFC+VS/TrKS8h0CCatAMyqx6QlPxuhCIWuw5N34mESIuZ5YKFmx+l6kwzFdaJs3n2zL66ZHuiv/WgSXi882WCjc2O7oQauQVby4UyrjwS3PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794571; c=relaxed/simple;
	bh=egVrb4p0VrYWtbKSyAbwHtyxwo7zS3H+Awv+zEiOdRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCSi95cIyQYtsUBSj0q047AV1InBOH+ykJpYpXeAEUXl+E7c7UP+4IP/4UwMwwOpTti67voFC23r97AnpCuFF27cUEcg3uZ1zqNUCqapRN0rMO8yMpLsmEvw+Ber/xyvY3IkYerGbAWXQcmTyelYjhmfr0Ovvup4rsJm5NWZ4YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9WWeH6V; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9WWeH6V"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56641200d6eso1736891e0c.0
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 09:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769794569; cv=none;
        d=google.com; s=arc-20240605;
        b=EqhaANPgWMXJdDWUfR7dVgkMOqDvAMBBnX1uPcT6mJYATHguyY4iiDZgPepDxypA7L
         r82SeSVf7WtJdLe2VUsCts+dqrMdKHMMHG3Pw3HGxnKLsYXHpSati/PqZ6iMoBzbCDak
         TD3PX1V/XopR5RgxdYrenAbTmrBnmINot8QzdkTdH2V4NZit8GKHwGS7BrSMRt5SqqkC
         o76IGgUKO8eMypmIVUXcpP7axNoUDV5kb+XKQ/aTngqtWsJu/XQK2oPGbeJtqzi3V2tu
         pgr4ATC9yre4OstgvE1tuOgXFMUI8rdCxpbI7MZzEA4n5Dqzwm6KPH23O+RR1UC25QCK
         gl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=egVrb4p0VrYWtbKSyAbwHtyxwo7zS3H+Awv+zEiOdRA=;
        fh=shWxNb8qA0DxLN80W7Sz7Tg64EW8RLYpEjyr7bUBFds=;
        b=V7jTqj/q95cBsluNx4n40mAULhAR4w46waiHYwWIe/6ZRrP7E7njJOfoNcurDgf5ys
         Ji4C3LVj9IgpsnaZuL1Zn/3uAydSMAbkIf/Nlb9DBl7YC9fLUD8UfGGcUwsXhyheNRmh
         QsVW09e9ubitSyadyS97wPw1n8Ab2G4phjzaPE7JV2OMD8pwfhMg1RCzl7lAQpsP+Jtt
         tUdXEq1lZmd2t1CThCWDOE635WJRX9gomTt3z3KddNo3Bt5XPhaG1P6RE5TL1hgr4C5V
         UWXI1q/0ZoGkKEHcjZ6LDXq8gqaYk7HaRVTolQ5fcaLvmaLL2PYRpwpb4s1Z+u2FI/ID
         4zFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769794569; x=1770399369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egVrb4p0VrYWtbKSyAbwHtyxwo7zS3H+Awv+zEiOdRA=;
        b=R9WWeH6Vs7sHVeEpKjv13xeTZFEz4PrFr+BlxTFtWz2pN3wlVSk1DSe+1THrO9Y62X
         BNVluwFR+AOyEmOZo97UbG+vlVgoqu/uzFIXFLrmroZ4VfppMnf+nFtdqsR69cdKrdlz
         9AbZvkLgrFNU+SiL1hYVIWlSnVmCO7cd5DHgyG/wH0jMfoyzm34py6UCFHPH/2FJYUKx
         /wjalpStgMe5pkdRWMqk8aCrJtcXL5sgpbpuUqED214xaxHGA2w6rWqguOBLdUKP4E7g
         Pe06LvEeZE0d7mOhftB2Das5tsXeBaRywZO87e0elh23s9HXEK9B80wEu2gS/hzKXBD3
         zp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769794569; x=1770399369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egVrb4p0VrYWtbKSyAbwHtyxwo7zS3H+Awv+zEiOdRA=;
        b=LkDAOLDoDtUgqdFnUnuXoQyN5kW2yjoBrvkP2L9EAadbu1w29FJbeWE2fKXi52SjK6
         HXmKyrZxl5lwqLbg556+dqIqARYT5ND8TVRAn/SCCfMhDcGjacuLudpgHHYRfgEo2t0s
         AdecL6LAYg+dnAsS9eL+CvkpE0Drr+bEg8KFpkJEiQAMRAF+4fXYdD4Z+s9FUdtbNOmm
         +c474qBDyJrBfQrRZ/DMLqQmSZhsj1pKPEIb5E6dag36c5I6aakf+fJYSYcPdq1fkF4A
         c+WGetxdNAjYIobOByQjmZHXOq3pBU5OjxI5D2UziGeTgSK+e+wUJPKfLB1kpNdctxUl
         8Rqg==
X-Gm-Message-State: AOJu0YygOFp+Y0707LMl7SjIPJDOLjh4GWi7D03aYytpp+SOCarDdZzD
	cBUVYKxlTYjQlGN2d1Usb7/aEqCBzHK0PoML9XYkOuOngPNTa8ycdbW9cGGEN6unvH3kBKi8T3u
	Hv+uxGYtpovtzgeDt9XU4dT2U8t2Co0w=
X-Gm-Gg: AZuq6aIpIXgdec3dr4K6V6mSwmPGDYfGFB+LGS/eTYcxDTYwDp43QaptYyDYm7kHbj6
	34NpquIwqeXtILSayoK8P6bfXAtksw6cCHXy5Y1CPZqSNyf6oxclaWuTQ3TprJp9dz6OwoB4lsQ
	cPpvyP5pfsPN1mEZPWMAMYKSVFTOrrceu1FtXAOl+j0wk4VPXBpcSb232nsLzzlu/Eb404JogKq
	kWUHkySPfslL6MCNO5ou4I8raZT34AgYuMkEV5k9F42L9NbN1HJCePN26L9ruxbKM78WYqA
X-Received: by 2002:a05:6122:29cc:b0:566:341b:4ddd with SMTP id
 71dfb90a1353d-5669fd6bd88mr1067237e0c.0.1769794567240; Fri, 30 Jan 2026
 09:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
 <9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
 <xmqq7bt2g4tl.fsf@gitster.g> <CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
 <CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com> <xmqq8qdf83nu.fsf@gitster.g>
In-Reply-To: <xmqq8qdf83nu.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 30 Jan 2026 18:36:09 +0100
X-Gm-Features: AZwV_QjshxYj7F8bcH68IIqdTV3hjXYieW7KeUXRY2W0r-Rahrf_M7O-peKiETA
Message-ID: <CADYq+faOK=VQarMMyxD9OCTMrM__o0=87Bm0MSxFkSfYV7v7nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on all
 its hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 5:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Samuel Abraham <abrahamadekunle50@gmail.com> writes:
>
> > Hello Junio, thank you for your review.
> > Here I explain my decision to move the "git apply" in patch_update_file=
()
> > to the caller.
> >
> > Does it sound like a valid reason to make the move?
>
> I am not sure, but as long as this is an optional feature, users can
> choose not to opt in if they do not like the new "all or none"
> semantics, I guess.
>
> Thanks.

Okay thank you.
I will work on making it an optional feature

Abraham
