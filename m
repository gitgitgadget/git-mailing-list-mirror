Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D212839E
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506088; cv=none; b=NLf+i9/7LTkoBS1TB2fksZ0D6A6mYJa0QB9v+DcVRbiilSSyyJn+rf5YsFBLspWZ2sx6e8HOW4JNr2UcaRNch25wtJZ/4RRjcAtWn+w/pQ5uESqUgfSWuCZg92zZJyVbckhkfJvaF64KXY2x24vkiXlSfWyP7ZvI9NJyk1ZLYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506088; c=relaxed/simple;
	bh=/yLX/mxOQUQMnRygSnZZOQlbYZSgzDQudLxkvWT5lAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIzV4omTUV/JleHqJ4EetcRkmZ8R868XPSxbmTKbfi2kF5Sd6Wv+OnGCl9vNdEdgHLaXmdrQn1GpKklBeQDbJNOWHkn1nwlkbulkpiJ2miN9dEI8mVB2rZMF0LRWrigXVIzk3KQV7RPN/DACsQDwnMVSMIQrKvCY1gYQQ3wjKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43f84f53f66so15571711cf.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 16:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506085; x=1717110885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpmPJv1xScvnKN4Q3ZNk7ITfprXfEgv3ehIaARn6adQ=;
        b=TveoooiMEDzEhIxQdVgy5XuuQ3hjaSWcKASMx8uEhhxAWiq9OnvSNwHeCS4DAtyzqM
         e2aG51CmAY+PjhTSH1NzkdMwbAB6CWG24g8YMcv80k9xZtJYKYdK626KNplAKWiPTkei
         BcUL5jLmbUOYBIGJP6Jf+Xt8K9ZLkjnzf3+AHePWs1Y/i5mO3pVXIi4VFQMAgHLaAPnY
         aNmra4/K9yh+/d7HkhmAm0pEzvI0Vtrmha+eeqClkwgAIFBDLhJTlVEmxFXzg7Hh/WbB
         w+lGJeX5YJDTrrNbbeFCmSoKHK6pHpmMXbPcZL7/aKLb+38GfZlDtF5FfECERz5n5oeh
         9JkA==
X-Forwarded-Encrypted: i=1; AJvYcCVTkghkdtz4TttPQPqXeBV8DsLe4emRJtJf4ThHCrLmSI2vfrPiWdij8f0pGGtWW1kU84UGT2kh6FILqt3VgLh5amBA
X-Gm-Message-State: AOJu0YyztseqsmT3vSgtYjBNpKKVedkFPWouVfOSLhnDlFhtZQIs64NN
	16iZbx6d5gl+4l8QyiY0yd2wxpGtWP8FDuxlRdmRoME+NvLHIMKqm25nE/uGy73psVLEWsY3BvC
	qCGFoaHQqqEv+Sl6MqlxJqjj6ibE=
X-Google-Smtp-Source: AGHT+IGF4CbgwstiefZSYNlNIlzmPsanI1dkkPxK/Nz8+kEjax6jHm7q8NORp0CB/E3R2F+0lxO1Zq3R6ahWkpBvmno=
X-Received: by 2002:a05:6214:2c03:b0:6a9:c9c5:75e2 with SMTP id
 6a1803df08f44-6abcd175d47mr4399146d6.50.1716506085488; Thu, 23 May 2024
 16:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zkdk7R9GIfsyQjkc@telcontar> <xmqqsey8tnny.fsf@gitster.g>
 <Zk-nswiCF-SnyxLE@telcontar> <CAPig+cRddr=JTVvkh5xkptag_1C5-z1t9Pzr_OdcGFSVwRg3vg@mail.gmail.com>
 <Zk-5YCKSO32vPKDP@telcontar> <Zk_FiYd8uk-P5jIi@telcontar> <xmqqcypcqgf9.fsf@gitster.g>
In-Reply-To: <xmqqcypcqgf9.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 19:14:34 -0400
Message-ID: <CAPig+cRme82m-09_yhiMx_O3CgnoAtEZkdFiZTX46yTZ0M0QpQ@mail.gmail.com>
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
To: Junio C Hamano <gitster@pobox.com>
Cc: Marcel Telka <marcel@telka.sk>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 7:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Marcel Telka <marcel@telka.sk> writes:
> > There is a problem, but definitely the justification in the commit
> > message is not accurate because we do not care about POSIX here at all.
> > Also maybe it would be better/simpler to use `echo -E` instead of
> > `printf`, but I'm not sure here.
>
> How "portable" is "echo -E"?  It apparently is not listd in [*], but
> it should probably not matter as we are doing this in bash.
>
> printf is a kosher way whose behaviour is pretty well standardized
> especially with respect to "%s".  As I said that I was going to
> merge it down to 'master' already, it is now part of 'master'.
> Use of printf there may hopefully educate folks to think twice
> before using 'echo' on unknown data.

Indeed. Seeing`echo $VAR` used always makes my reading hiccup since
it's never immediately clear (without consulting additional context)
whether the value of VAR starts with a hyphen or has embedded escapes.
On the other hand, `printf "%s" $VAR` doesn't suffer from this
problem, so this change is welcome regardless.
