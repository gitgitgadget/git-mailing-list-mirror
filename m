Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793267673;
	b=rLhBb/70KcIizRmae0yKfxgglFvSZAObtO/AkjzrDzu1BlSmFDqjwGpl0xp8YMgLxD1l
	 AZkC/80Y57dL4P8hV43AM9d5PIDBxvpxDmf6pegfTqK7z/0Y/8XoABOZ/r5ffXahADjqL
	 qrXyXsr1KwUYdpNYqCR45bWEIrAfRc72UhvKTb4Qv05xxR9NOkt4WSgQug6XMW+ozgh09
	 7nBzerNwcwlWxVyO8syst2EkSWeeG5pe6GwZo2DJMTobHZEMd9NyKFBoQLK1AxbFR6nSy
	 xBr4aRAW81ZKb6a5ampWtUx6/wKzvl/+R5m6ujTb+XMQmIuNX2+A5jSU+IbjpKGCWDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1fonyhctsg14g5zBHLtH0j45drBPvgvTiE9XH7z7LgA=;
	b=4UZMQByS/h2aNNpU4DR9zrrg5KvIVUdfDkB6eP8fBjDBI/s5dRjS4vtsktWp8/LgcV3m
	 EjWbFXxkcrgD0sUFTYTtvcJMdMePCboYv9F5b0mCbIojTaqzcePSIXnJfk5+D07hNZBnE
	 dt9uvWd2bJenMegIy4Yrre23159WJVi/L6cPPVZz8aXktvyBY6TfQjZuJl58u5/BikB3u
	 PMdMBtN4yPLM3/j+mN0xkM5o1TSGVoTFfTgd+bcVUrkqHcdM4AHaoRt5K+P/0345k+eDv
	 /xkk+aVXFUnWLIG4YX/SP50QWZv3nxCe0Q8fOCisSNXQ/eYCSuIXVOjQjC5imz/qg2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LC7YDLuo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B7606A31F
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 906B7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LC7YDLuo
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a98fc80925so22297581fa.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 02:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793267671; cv=none;
        d=google.com; s=arc-20260327;
        b=eRzVVMSb2FNUS5hppTiZgrsPqikbYlIazKDfoE0afQAEGi6vlrZOu8CV3Epsf4OsAE
         y1enw9buHyFLXDfn2HiBVoxVQex5pFOHwml3+VX0dP2lbqTSbM14i45+T3krtSP7bzt4
         9gL+5xpp2KUfLjNPX9Kyd5zBkkczGWGbximT22UZ81uPDTUxmAyoorY9qHL36pUZjpWf
         P55VwPtED52fkheM5WZPAl30EPlHDOQrZEinfqqxOuYOGhKr9PoYs1LbWLkMlvR6V3d3
         5VJMBDv2UWSwdcqsn9DSDxjH5KGGylPj1le1w12oo15VMl4DkIc0tKdGWnOv/feGViFr
         u+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fonyhctsg14g5zBHLtH0j45drBPvgvTiE9XH7z7LgA=;
        fh=cFmPBCRkUlbdViCibjE6uk5A9Ac092edx/tETJJ9PM4=;
        b=q00Dlq0ZVO2Q4BNlOei+fQeNJq15ViyBOSrbHHiH8ZkU5+Vkg711pYs0eD3IbQmN4L
         B7YkcJUzhsRuuAZTaj5fZtxfNF4m6wN2wSCrbHmX55oruzZd7jlqLu4FFILCqMpt6Y2G
         ZmSx7yaoDU178goxUZvuVl+/0Wl8ZyhUSgb7f2fNkxu1d4BZrgZ/5VnNl9v37LHMXmrZ
         k2v68aca0B/xTyQY0HMCKyA8YmD1KeOefYDjjMXq29sTFGmu8hxa+zrXQw2Z9864wcVr
         b9CDgW794m6CVeEPdtX89BKopBnqxOtOK2yXekJm2B1nhjOmXs5zHBJzN1QBLsW1Wgpz
         Gu+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793267671; x=1793872471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fonyhctsg14g5zBHLtH0j45drBPvgvTiE9XH7z7LgA=;
        b=LC7YDLuo4hbx9vMW+NzEFPdbMqf5QRAie3dxrbI8uH0i0zfJkI/WospKIMxMrgxUvP
         LAfzVgWNDbhtFJ7yqOFK6APQjO/SD0/rA553veKlkrZ0V9FhGfScenbNu1A2F+10ZEzc
         B3ODC/7doTOHkDq0SJ9YqZLdPxyKYxpW7/kJOLb23A83C2MVgKL0CfcSgYvLWRgNw5K0
         EnTruttdkozw4ISoioZEktmP177iVu1Y851MAZU84epAmN6fQQC1OSS5XAfJuA/M+j0M
         GIqS/cII/aGL641HH4maVeNLg3uXvMfRaYP+uXEcw/QEUiFFuSQiHGG4TEEY5bSVznFK
         8SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267671; x=1793872471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fonyhctsg14g5zBHLtH0j45drBPvgvTiE9XH7z7LgA=;
        b=XsTG5U7lsqep5R7UF/zUpHTe08q+lVuT+wknv6ajIiSm2KQL14enzudj2wIuKWobkv
         Ccc2sm/WSyrOILpcJya5dOreRVeBPLfbeJU/xFiajqPXf8aEd085dGpT8NHOIW1xb6eE
         OhIhIyd9k+29J2LpMzdU1U62I4qWDAssh1YifXFgMBU2JYeZwjUi2m/5SUinKHsVE6Vg
         b0fiIrrHkTwpR2Qkp/YNsWkuOcEsD0Z+c4Rh51gGxsBlvjnAGn6pP8bs9ID1RZpqLVUr
         KwM0EFMvYFbwjmj3Ew80HCxqmUtJNZ8qJQi7T+1NXLpG2vxAOvpmFxSsokr7QClb6htT
         DGIA==
X-Gm-Message-State: AFq9FYIjp/BchUpqLgcdAgyEJfNeZoT6dA1kQ8aA4k1n+FavU0KTxBjx
	xGVuaQsh13KxPGDLQn2U+qalZ0zkQV88E+ulkWgeLWRLDCMh9TGDMdbWqMNcfecsfQWKG5xQttU
	fVYMHUxn1kEQMOvaWimwIrP1gK0uAUWh22fNEW0Y=
X-Gm-Gg: AYBFou2pB7uxNxrNVM9U51Ce+mIiOazsf560o6I6ADKxiFRpi7deeCrXtMJJOpeNs1u
	XGNX67gAixW2vnRb2/LATd1aJPd3FjM+qr2Tj7vNNxqLs6jH9prbQSih9em3bZ1y44wgvg5Cdo7
	py6aWjYzILwba6xmZhvnpL3ixtTA2HyUUzsLHZv2MT+ZYYLZpP6QjsUbHcV8JYqORe+Wk4WCMSL
	T6EKVuf5AaywnR/0E4tEj2Dftb+gWK9dbG9x+Zq4OITmNz9C4LEXQhaTgW97odJgecm/oQpK99K
	6ysgYZUJyeXD+Jey7EHyWFHg6VFn5T3e6gg5zX5kNnbEqrv1Zt5vzYhLkaMremsXmtl9qG3eLED
	9RdGhvnQEKze3LHYPmFGV900/TUu6ahhT2qMhj0+kjIjpRw1GjV1wLEVwErMyuwwQJBU=
X-Received: by 2002:a2e:bea3:0:b0:3a9:a1ed:6341 with SMTP id
 38308e7fff4ca-3ac9cf4083emr12344521fa.11.1793267670526; Thu, 29 Oct 2026
 02:54:30 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKUOgLz3sefhypa9yzLszW43uQ=Jor_nRBAJaBXXv0d8M2ePBw@mail.gmail.com>
 <CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com>
In-Reply-To: <CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com>
From: Immaculate Mecha <immaculatemecha87@gmail.com>
Date: Thu, 29 Oct 2026 12:54:18 +0300
X-Gm-Features: AclHuK8-5iJmWkjWkESXrYHS9AHrv53rA-fFf7VkPnMCTjn3Jg2l8l5SdtgQ1hU
Message-ID: <CAKUOgLy_jS-x5jZcQZmjHzLV=TnPi56iQ9v00hUXmX9Kudorjg@mail.gmail.com>
Subject: Re: [Outreachy] Microproject idea: modernize a file-existence check
 in t/t0081-find-pack.sh
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the welcome and for pointing me to the existing work.
I'll review the mailing-list archive and the What's cooking reports
more carefully before choosing another microproject.

Best,
Immaculate


On Thu, Oct 29, 2026 at 12:03=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 9:10=E2=80=AFAM Immaculate Mecha
> <immaculatemecha87@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm preparing a microproject contribution for Outreachy and have been
> > exploring a small test cleanup in Git.
> >
> > In t/t0081-find-pack.sh, line 35 currently uses:
> >
> > test -f "$head_commit_pack" &&
> >
> > I'm considering replacing it with Git's test helper:
> >
> > test_path_is_file "$head_commit_pack" &&
> >
> > I checked the file's history using git blame and confirmed that this
> > is the only test -f, test -e, or test -d check in that script.
> >
> > Would this be an appropriate and useful microproject, or is there a
> > reason to leave this check as it is?
>
>
> Hi Immaculate,
>
> Welcome! I think Shashank S already changed this exact line in t0081
>
> https://lore.kernel.org/git/pull.2254.v2.git.1792061236183.gitgitgadget@g=
mail.com/
>
> Before choosing a microproject, it helps to search the list archive
> at https://lore.kernel.org/git/ for the file name, and to check the
> "What's cooking" reports, to make sure nobody is already working on
> it.
>
> Good luck!
> Okhuomon
