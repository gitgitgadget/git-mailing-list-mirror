Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB83FD4
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533440; cv=none; b=ANH2zPLKEix9r6c9x50RZYhQM3suB7722VcEI/cjKmcwDPxTF4yNBy6yIBZTRz3vJsZW2G3qw0jpgQIG2R44B/am/LvHxzuQNp2tq4B9tflMGzkTjCYAdi8oTlIrBgQLfbz7ryIux6+qzx88qkwrWjKzqJ2mCkc10ZUYdbncr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533440; c=relaxed/simple;
	bh=ZqEmzpiYX6gci281+dTJfJv3wzNuO2Md1F2gp9Fz4zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ2CunurRUPrMNv+eIRVsMGzAkIgwH9z/6odoks5kUZYawFeoiTqhxp0j9xs7Haaw7FXkr4jVuPVwwq99GesM76zpDi2NxGPDegjfs0s/qFIqQ374fJWcCywosBjMXRb+v7pnGMIAdWlrRLzY6cHXvEgcbEY1SyTu5qKEwVjDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4twNgne; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4twNgne"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7eb01106015so651239f.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 17:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719533437; x=1720138237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QnUUqFnMa3Pl4PkTD6ooUt0vXtjNepNo/7d92y6Hi8=;
        b=f4twNgneP3Pn2O1Cja/QZhUWQOLH2YsG7wGnrFs/3ZZmgnzfXZOJvJgSqnDJ0x12jF
         u/Gg6tLilaW05II7hNW62dEUEgRW5rUvQ2aSNVfqumiGFW4RVtrYlYS0f09VLBuOka4v
         90WnmFBNlQNbQP3NORGrTE651oYvk27ZRlhAJ4wtQEfwThjQ5fs9Z50f4d/L+/QzRAB0
         xNRRSTE3flrxEnD73yGUHw8mcjHIil9ESX4h2sQkebD/HRhjnC1tBSuVZ72RLVBKdfEN
         HvPUkLn/GzIY1DvBiGdDV9nW9e4GV0tVgesDWaBDpCqLfz5NtQqzXH8L3+I3A6X74+jB
         Y/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719533437; x=1720138237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QnUUqFnMa3Pl4PkTD6ooUt0vXtjNepNo/7d92y6Hi8=;
        b=Wih/xZsnopVDEXO0rZIm5cFQXGCR9wRlbR0DFVcnlYKmHpH2zOwraBa61bDHpbTkAk
         FaklDusgxuSf6OlEbJyQgnv4wDPGP1yh2V6uqvZ63IYqyZeclWVq8rA5IM9FSDlI3g5t
         uY29ZrnIwO0SU89LIBCx0XEYergcAOE7Fr8Kw0Kmdzom0meMDvgbiS7vjNhERbcqbKux
         dmp2ku90xguXt7KT36Xhbngdtwr6zrv1tvJIxD+pxvpEWzKWnuJQU56uEfLS+j1reRhx
         hl0TKXoHSpvsqodMAFJlLYuGJWd40dpoLllX0h1XBumY2NRk4OZJ8tZG+yXIabw9I0/d
         ilsg==
X-Forwarded-Encrypted: i=1; AJvYcCVgy+NGjvw2KvgeOntYeQjYS7tYiVG1462boBRfXTCopzbD3fk8ivAx+go4EjJYRjONPn51SOhxasZ0UXdbD7O1Xakc
X-Gm-Message-State: AOJu0YyWw+rAxgD48GLbpnGyk0UbaJwMZU/IOLQirQlp/V80tXcvH+mr
	TeiFYQSxynJNQqD2Ne8iP3/F8prv07V2CriTZDYeIDydEuv/AJaVzlT1VIvmOJs6vSxEWaXRkSY
	CxdxxeeonPLuOsQaEkX1wvRsQTbA=
X-Google-Smtp-Source: AGHT+IHOei92HZEr3aY/LdWw7qPTEfmHjm+7g1qN1Z6n5ZYNO0qS4PLBeAnZUux8DlaiCTxudMSFbdB/8gq7hM6tI08=
X-Received: by 2002:a05:6602:160a:b0:7f3:d326:1fa4 with SMTP id
 ca18e2360f4ac-7f3d3262347mr844302139f.18.1719533437660; Thu, 27 Jun 2024
 17:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <2654fcb7142a606c5684c762ed28bb5e8d9b4712.1718899877.git.gitgitgadget@gmail.com>
 <CABPp-BFgg8DOy-SUUsXLyfsWr0DOUUc1vQKnPpihy-h+NAj_zg@mail.gmail.com> <cfb20e54-eee5-4043-abcb-63c8211635d3@gmail.com>
In-Reply-To: <cfb20e54-eee5-4043-abcb-63c8211635d3@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Jun 2024 17:10:26 -0700
Message-ID: <CABPp-BEHP1h244etkRANCiY9Oz6qsQrNB+Sk4s=kXdE9vucfNQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] sparse-index: improve lstat caching of sparse paths
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	anh@canva.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 6:06=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 6/24/24 6:14 PM, Elijah Newren wrote:
[...]
> > Further, you can recompile the git version in use in another window,
> > then come back to this one and run 'rm trace' followed by the last two
> > commands to retest.
> >
> > The commands above create a 'gvfs-like-git-bomb' git directory that
> > has 1,000,001 files in HEAD.
> >
> > With this test directory, before applying this patch, I see:
> >      ..sparse_lstat_count:722011
> > After applying this patch I see
> >      ..sparse_lstat_count:135
> > and with a slight tweak to your patch I see
> >      ..sparse_lstat_count:125
> > I'll comment on the slight tweak at the end of the patch.
>
> Thanks for these numbers! Are you willing to keep that example repo
> on GitHub so I can refer to it in the message?

Sure, I've had it up for several years already without change (though
the anachronistic 'gvfs' in the repository name feels like it should
be updated...)
