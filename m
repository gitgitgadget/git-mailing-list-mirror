Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CA18C2C
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225654; cv=pass; b=fBUwFctNIXXkuZC3Wyi+kudE9m6yzjVg/558xL+UTp1nBdpBZyt8xtoVHwRr0LiGmDebq9JsU+7aWm1uhdWf0pkkhvCFAig0PaUhZi3BvDlEsgOSrkPx5RCJi90DNFB0TpigGjqtvXp2qggZCYt+78aJhsAizx7EdYJixknrRn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225654; c=relaxed/simple;
	bh=cbdTmx4Ql3Zuy1wg0U8ALtf6N87QICL3jRFR6p8knW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOontdN8mCaNJjPDG0VMqdp8AqjnXDQNlIf7dUmHWmPUZ7PWYBeMjiSdHrjMYLIxV3qH3MieqEfkE/rkb8Korv1SKmvzeXtw5Xdge6C7vUK1PpQZmiCu1zXe0RwrN5IiEYHNS2lhk9eagboDcxe/zi4n4YtK94ks9s8BrRLWPSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12734af2cdcso203464c88.0
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 23:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771225653; cv=none;
        d=google.com; s=arc-20240605;
        b=dXnU0eXzxExZiJgzxjGm2WvPAscj6T+sm//zEh6tD8RnVuoEpqsWiCVUiZFHPSY1sZ
         aCfPrD/CGXsxW8rTMYvWv1mxloH1rAPcKZoNx4DJgspRqiP4pD++k9FiZs1sNW2MDqSb
         fiSJGQ3Vj+MCxv1Z+P9MiqvT7CHe90nk/S3ypYaOaKn/LF3e+2wIaD+PcDdFylqtq/pb
         G21r35ZbfUUwMPsYO4pjcDRn0qidCMYcdMO7WJTkMCvuzZGubatPng0iqsb4fRdJU4CW
         v1seDvxy8X/BKJHNtVtrPDDr6E5pAI/3M4XvqDOJbw09OSWvTl0MdG+jjM4/WpvDhfDb
         dtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=cbdTmx4Ql3Zuy1wg0U8ALtf6N87QICL3jRFR6p8knW4=;
        fh=v47hjdPmCTLWpvgW3NTMaXdowhR6qrHotpo4pQstG2M=;
        b=i0EF/fzQI5lK3Rxjw2Q7I3zXILAHTsv3GROJjIl9B/dqmYj2G1tJbKDyw8l4F9asUE
         cvprkzbDtXnrwz0AqO98HCkmJOUwgnJqrMdxAnb1WTG5d+pCDZ/GZkmdQ+ij+B7nU15L
         tvyQH3/uPFf/5kLMMne+Q67F0LyCfvT3whaeoByC95O6iWqnpCPQEgjVFi6hsK07JHZN
         VlXY6DT7DSXTe4L4eOZdqPOlIh+GLqmwRbc+tOTI01053QF0aKRHmWwizQSvF7x4mYvc
         Cszrld4zGc0M+QwZ9ddrYu4CkVxvT46ZcQ3NRW4hpOYLFsW8fuJqydCrICWdwUdb/z5V
         pvUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771225653; x=1771830453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbdTmx4Ql3Zuy1wg0U8ALtf6N87QICL3jRFR6p8knW4=;
        b=rB8OfDsl3BnWqtbkaZ3Q2o4IzQVcxafpnZxriB6IrTzuVTJeooveKUm3Opev5l9vTQ
         O2LctK1ASpLlmd7/19sx205NiOSaVWt9WXTkhbZzDFll2+337z8PMxFaymkorfaR32LW
         ZC4DIBRchOYw9QmrBO1VfyA/BdnIl6KBJr7mE+Vb6SzOENOTo/13K+iTHjGXC0Rf5rhY
         NGEX2cIkg7M2/O+z3m4pwxcsXL+vF85LThBWSvj7sPD8l1OzLjhVKALF8FPOpchNI/gx
         OqrH4v879sCs/wSzqUr5yM9nzFTvK31gb2XryDLH7ROBSN8ve+PbgmRFnSctA3lc4NmQ
         Pbyw==
X-Gm-Message-State: AOJu0YxOk5QqTH/48pTpLaRwBL+noGlp1PAG8vA/ODuOjPr/IpXx6+bz
	wNQgFqK2Sy5k3CvQQQHzh6ZJ3jeZoUS029xrb1IZnqcMP+td9TpAoXcfoff+fuT9ljYts7A4KC7
	K+w6R/qfOM28fvAmXnME730YTedgSudIxkg==
X-Gm-Gg: AZuq6aK/1c65h4OJb1A2TxhFN+9sTmYcpx/MKi3DnhgF/37QkIrOfINBX3HOAhACMXr
	CXWGW7ZNosF7biANczQhLNNaVgTYxHrz0xzDSMLfkVy5mhSM1fY1M4mPMCWhtxo1Pg4bTz1ERzS
	yK1f/xSf0+1ITXaKj49Lr59iHKybq3hmV7pwZjMm2QLrjBe9HfaxNlpD9x0VNPNXRox8EpvdgZ7
	4j01I2McyPrGaigkm1wRnvMsAuxeeIl/TdVlbwi0OIvD3iiFQS6SdqIo6IUrV/xvwT7RROtTX4w
	fztkX+GPHg==
X-Received: by 2002:a05:7301:608b:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2baba0dc237mr1768241eec.5.1771225652686; Sun, 15 Feb 2026
 23:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMh=C_0ravwVS6UsKKux8PTewd7Z=db4bgvisMXnPwKU-Kyytg@mail.gmail.com>
 <CAPig+cRpiOqDGouEQG2MUnYXNSMLKGcqBTBWgqQKYxL7fdN7QA@mail.gmail.com> <CAMh=C_2jBkukEkAgViSFi6+c_kQeU-1YN06FyCxWX9grDPujuQ@mail.gmail.com>
In-Reply-To: <CAMh=C_2jBkukEkAgViSFi6+c_kQeU-1YN06FyCxWX9grDPujuQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 16 Feb 2026 02:07:21 -0500
X-Gm-Features: AaiRm50Dtyi78DqvoPXLmMzeFWhLpUdd7Mj-OU2OPzRHSMNxJaFqDy7MeD2HjVY
Message-ID: <CAPig+cRYfK6fq16aiZaBJBd4LipJYS0HPznuTXqB86Y2Z+BVjQ@mail.gmail.com>
Subject: Re: [feature request] stash diff usability
To: Pierre Houston <jpmhouston@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 8:20=E2=80=AFPM Pierre Houston <jpmhouston@gmail.co=
m> wrote:
> Ok, egg on my face, thanks. I should have looked in more places for that =
option.

No egg intended. By saying that it is documented only *indirectly*, I
meant that it is not necessarily easy to discover.

> I would like to see a long spelling of that option with =E2=80=9C--=E2=80=
=9C for better discoverability.

A patch to the git-stash documentation to mention this useful option
more explicitly might be welcome, if you want to give it a shot. In
fact, it might be a good idea to call out --patch for both the
git-stash "show" and "list" commands.
