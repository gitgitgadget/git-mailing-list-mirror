Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D062144
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805734; cv=none; b=e+gfqoCVz2KulZR3DzQfUqNXFEzXAILb1UR7ajm7ah1mhAIkEl2LkLzqNfstry3edMbba8qhLvXD0/xSjnYc1khQC0WHAO34Ukbrj07LuqB4PUkkKPZ9EefBG+cCGpObTki6xmz91rLOoL5OzqHYzuJotF5WYyUE81gR0k8xzAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805734; c=relaxed/simple;
	bh=KfkxXs2eCrg5yvZzvlMq00h2kn8s/dM1pjnTEp6aGYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwzVgn8zd8qBMFonFBaPEcUUwKBOH4cNjztvxkV86VsZTDA6me/BiqEK29VzrzG7S5NTG8381ZjYoyfnDNkINr90qhrvtxUQfVIf/1cl58cbd843ygg+DfK7sSaAt0ZGDiPjTlFeAMbbamY256OyoXMSHEE9ZlkWzqNBHQ0zffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zjm1FhvS; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjm1FhvS"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a9ec68784cso3575803eaf.2
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 20:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712805732; x=1713410532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqvGfvH75HNgd6b8zLuLpp2qGV6q4NZmM0CHlLx4gAc=;
        b=Zjm1FhvS74xMzg3J9eoy/h7oMutbb4a6vu3qwRQyP3xOp1z6xKkJXHc5v1QZtBc45J
         Wo40yAvfwRC+ChxOQkp0mcJniBek3m3JqpdKjtD3EBhPOhhEQrroML6Xoxc3XZ/yb2AJ
         uHzQSZuIDWHpcLiDb3241P5JklcurMMoBSd9w3/kswcMCNP8Ogo5HHNz42IucTPYsnbZ
         mipbDnH9nfEHjpO1MIBoPxev6G3fGTg0ielCrD4jODmpoZYSIN6cq+0BFt1XTfp17x/j
         poqUxnR2HjcXPXlrovhoPOshml7EWmzZeRoZLrYyQACT2M/gMtUc9iN4lFlfZtJPnd8D
         XsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712805732; x=1713410532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqvGfvH75HNgd6b8zLuLpp2qGV6q4NZmM0CHlLx4gAc=;
        b=M+PpDF+59vZO5iqq1UhyNaWiwaPkOhjAm+NIQ9lWdcdQdNVPe1iZs0FKBzr4zRtWQQ
         MZS2o9xRayCkVTSt4UXIlpF3MhfcHAdXY9kQW7oSr027scG/jXbaIJdj+IXEsD0PPGM1
         G7DxDJasbkAl8TKNkmyTjBEW7spDTsxB0mTUcz/qsiftaujJ1DG7DiSQFfJemIY0os9y
         6ZfUqjm0DjV63yJmjjQJSTtRyFs2vTki4hKPgGCJtvo/flsIDyzwZHwnYXdTklFLZHAc
         jg+yG6kXBmswcd7JR6uqebzjVEGcsz1AjP7JskptW+v1Boo6+7elCtDptNzSfdfkxXVw
         7WJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXmlJqr9Fn3NdM1bPhdDZrweIICfYR1Fw8jNvZeGKsGbmPtYzLRH+jOhbCow4mlaQ1COzHf9PXb/XcwpGkfR7YeQtU
X-Gm-Message-State: AOJu0YyLlfU868SZTuIv0HyQkdUUl8UXzxJb3dJQkDf0vLP5AOQVDeh/
	+byUU2BSUHQrmz+samxXtndy12VUt+xX521fLiIAodtaqd3h1cvoRpv4rVMz6klohzXhxmt3Ind
	QuxG9R8I5I48PKRIiWQBuJdHlMIY=
X-Google-Smtp-Source: AGHT+IGcZ8+9KzoaLvOAg6rlUvGrF6bJfysRRzZPku6RZfqzv9aPUlaBAIKcHFvjvxwECb1huXgqW4oIsCU6H5rWnuM=
X-Received: by 2002:a05:6820:216:b0:5aa:676e:9ad9 with SMTP id
 bw22-20020a056820021600b005aa676e9ad9mr5073691oob.2.1712805731919; Wed, 10
 Apr 2024 20:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409000546.3628898-1-jacob.e.keller@intel.com> <xmqqpluz2tau.fsf@gitster.g>
In-Reply-To: <xmqqpluz2tau.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 10 Apr 2024 20:22:02 -0700
Message-ID: <CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
Subject: Re: [PATCH] mailsplit add option to include sanitized subject in filename
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > I originally wanted to avoid the need for an option, but git-am
> > currently depends on the strict sequence number filenames.  It is
> > unclear how difficult it would be to refactor git-am to work with
> > names that include the extra subject data.
>
> I am not sure if I follow.  Do you mean
>
>         $ git am ./dir/0*.txt
>

No, I mean git am invokes git mailsplit to split a mailbox file into a
temporary directory, and then expects to find exactly "0000", "0001",
"0002" etc, but not "0001-fix-bug" and "0002-implement-feature"
