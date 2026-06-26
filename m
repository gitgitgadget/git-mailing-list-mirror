Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288737F723
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782502094; cv=pass; b=giIOtIzNodyNBYJWRjGRHZnH0o3sjBkw2f6p+bj8xyGObPDhmmQd95kgg8dv13NvKS/je7ejjwlvRV9qlY/BUryt5psXHfdTt5R4wrO56yw3fbVSJc1IWy4w2p66iqtH7XXPov4WkNTHFuapaja9duWS0RuP1Sy+T6hcWbwEzC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782502094; c=relaxed/simple;
	bh=hX772aaa9Im0ZPpHaI3mkav0QznayIWdLHogMuoNIrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIbcX98Tk+hNNRySYkcWUq7oyok7lxeneG8rIn1VOvN72i1lYtlxm0VTGSMKgh0L4XgWpVx7JmGhN4MPlYsPUcwcBzmMDaZ12PVsNOel6XkK+9pKQlvIkiEE4S3HFHKQPOhIznSnc64d+P7Zkv8vg7S6Pq7PXWaEru6cGVTbdw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpLU/H2A; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpLU/H2A"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6978f1eeb87so2295794a12.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782502091; cv=none;
        d=google.com; s=arc-20260327;
        b=LZ/G+8UYAolFlpmDosMuQE4PPB+5aEq4exirRPtXBMEfgpUYOVlyzirTKK93oeK55o
         TN038945sETapK/WtTz3lQkVXP8JEhSaD0AwR5Fr1yklby1JknlAD3pSuRIjpO2d9sYy
         VorPxtTfdR08u/g7jeqzH7hmrjvvKZZRqlsJeFQNeykcQ0kJRR5FbyXHLeC4dWcFpk+O
         eUeRIweWzj2GpiJNhoGQGOE2ci1cpLkZmC572zwrQvlvqteyKLuX1MdQpmP4f888efJC
         NdUYYv6LGYzEv2Wcn8wy4LCsu+O83iMvT4zyTbGC5c3XXI17f3IoK+WlwnJGJDWelGWm
         zFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aEUzeroui6FCkfVpdqVkrp4jtvnW0E5b9jJ0W7od6vc=;
        fh=mZixHP2Ewss2SFJr0NJjUylVjNy0qV/BrWHw1aJTsFw=;
        b=djV5QyNBEyThL6i7peIkf7jFbET6D/cIwpGLtCaiw1rVrqeMKmPDTO+w8jGEy3E4Ka
         tvn+gwaLYd83NleaOTSq7l5dbp41GBww5Hl6kC29AcHSCql3fc6SrMpV+axVaKJW/fWU
         ouMMpWNfNkhtfOSTQBBwHjpR+a1VUsYDXv/n/kVlpVPVa9Gw592J+S62mn7e7Ij4Cw63
         43WK7FCNyhBnhZ1ZuDG8z4dJG+adXk7/nSvKTGX5UvZLQfAiufI7ClTVstl0WCJ/tmWH
         r0+U6jrhJw6GJG/ehML8u9N5oYfKSggeTh3UhbHzvU9UqJ/YXgOhmFQuKJbwyrW1r4ZX
         VTDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782502091; x=1783106891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEUzeroui6FCkfVpdqVkrp4jtvnW0E5b9jJ0W7od6vc=;
        b=CpLU/H2A+zt66RzVNBDm/gTBQttHkNbcn1ARUgd/itpdUKdp668tC77xsWcqK7k1Zw
         P7DvuJixdt2Yoi7jB67VRYq9ra33ThueBoeCVsgfPc9kwUTUh6x7wXA00LSiOafdyRul
         GdUxfejuWAbq/rua8lip1MHvfbGEgP/trK8A1ypshLXcTAhq8Stg/bbNSIfvnh7DPe4z
         4lFH/hPavvQnqwbCOOEzkBRtPyxg6ifLc9gISlfGG7BEQo/Lp0YOGqXVTGb9jdtB4GmV
         qyIhi6eCo6ARcMs8Vjm1o0EeEm1FtU5FbpQhCFvfahPHxRrBynyh2MFbdecmsklbpE9i
         pbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782502091; x=1783106891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aEUzeroui6FCkfVpdqVkrp4jtvnW0E5b9jJ0W7od6vc=;
        b=s66TVlKs89ZwlwZnDECgegGg1dsZTLhC8OvZXlyBwWa5EuevL+xGNsro7y5nGDyWrY
         9wizBzsdC8Fhjpj0FLn1eine1NBOQveis5yftlExdkrOru4CrVs/cZocW834g5d3jlJ7
         WUG+JKDa/7gcIwuPDr1f2az3f5IJGQvqYXmqhdo07qGqfneGejIs4psSJiQ+jFh1PIjq
         Nla7rGvWnSJYcSFEnJ0xkhZzCMOilObKUqxqxyH15shWxQAUz2cEDQ5oLoJvSkhHDjso
         Xeh4gTGfSlrd8Yeka/mBt23ibwCCSnDW2kHbEBVedQAsXZvnQ4hLoYqy7T1O7P+gu3nl
         7SwA==
X-Gm-Message-State: AOJu0YwDL7AiSd99S6FP2ghwyVvjmMfF4GPBl672tBE9zzmqz9cPcdHZ
	NATDVPj+hXkAob97BrD6sfLLaPu39A7c4ynpVOJXF++J/keacuVZGRwGySgOQ5pvLpfkgPo04YF
	tFUbjyWBqPL6+IB//Tv1C0eCHQB4N8nk=
X-Gm-Gg: AfdE7cm29v2oXLObn/tpC9ZE395FT7ys8NDpQVqatLOCIUFOrXY3aPA52trhRA53BGE
	bWrJLsd33IPq6nSm8kkVugh08bSRGW1YVuwdyreuE8/A6cCUYXaQo5stQ96lCIOLQXvPI4hE9zk
	dv+jxwQNMvtwanhVG/fM3aeBrWZb3lfhfcHM3WYtdWu4sm2rUSS6S2jn0YwU+uucLD3sbd9+Kqp
	Y0UCgu9HG01a+Crg0w+UU37Z5c0/9255E8W1OMG7dhsS3Mnsq+U2N3vER9YF32RDLjfE+po
X-Received: by 2002:a05:6402:2343:b0:697:6824:5e58 with SMTP id
 4fb4d7f45d1cf-69810867cc6mr2884052a12.0.1782502090841; Fri, 26 Jun 2026
 12:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
 <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com> <d38d233c-a7c9-4457-96c1-bfb75af71ffe@kdbg.org>
In-Reply-To: <d38d233c-a7c9-4457-96c1-bfb75af71ffe@kdbg.org>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 26 Jun 2026 21:27:33 +0200
X-Gm-Features: AVVi8CeIUVwxkFm5CqF8d84GDs6FF3RnqaqSG8c6h67HuZwLMTcHsBe5hB0eUL8
Message-ID: <CAHwyqnX78ePVhiL+_T3FzCSA5oGaU_RPvQj6YP=s1WyULg=tdg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Silence po catalog output under "make -s"
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes!

Thanks for the help. What should I expect here, will it be merged to master=
 now?


Harald

On Tue, Jun 23, 2026 at 6:23=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 21.06.26 um 16:56 schrieb Harald Nordgren via GitGitGadget:
> >  * gitk: gate the quiet helpers on -s in MAKEFLAGS and give the catalog=
 rule
> >    a QUIET_MSGFMT prefix, so a silent build emits no MSGFMT/GEN lines
>
> I've picked up this one.
>
> >  * git-gui: replace the QUIET_MSGFMT0/QUIET_MSGFMT1 pair with a single
> >    QUIET_MSGFMT, since with --statistics gone there is no output left t=
o
> >    reformat
>
> But this one, I skipped, because I already have all of it in
> https://github.com/j6t/git-gui/commits/hn/silence-make-s/
>
> Thanks!
> -- Hannes
>
