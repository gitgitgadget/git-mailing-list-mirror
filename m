Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D902F2E
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728216385; cv=none; b=kOWSKIwg+8b/oCyvYP+6zWQHxr7aZ5LFCHdaPluCUzz4Kc3aDq4h9zxeLQ1chBdJpBAhhs+/Ih8UEBrSsQ3UhzVT8C/UwmOqgDGFHMdrAnYJYfpag7b0WGLwhEtADusM7Vw9N3DkkS5VFi+I2YfjgRjTN5Z3hNqHIXsnuG9CYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728216385; c=relaxed/simple;
	bh=d5BOFGkCbgUqBuC5fsCFoQBUT4hZMETypkp9BajETP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTfJN0FpJXSY/ctOSQ4v17bo96YAIxHF3NuAihEM8ChMFC5xBgXhaWMYMoD7mh8IGLjgDdf97C5Wul8OqZYIXkiAyptRf9I5bsTQzl2CJfcKu2SWWk/9zDv1AKsAIL47hwC4xttlm0brVq9obKYPi8paeNf9STGvYbboJNYwbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb36237f28so5040046d6.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 05:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728216382; x=1728821182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5BOFGkCbgUqBuC5fsCFoQBUT4hZMETypkp9BajETP0=;
        b=lJZ1t1MoPdoFYR+oJa2Dl6Iec0FnnN+GlOp6xfVGNaG+IEh8ls0EDMQ4K/ayRGBa2b
         Y90LMhdM3wzvzayBqfzXsGG0aFf6WZ7X1F7eGaKSNmZzJn52XR//zC9FWywfzjrzzHhm
         bjORUTmSGXpLnvEE8iGrplhbJ9JKxMhC1QEwUR0RzejCET5ZcPPeC3izBKbin6Xq2r/o
         Ll7W5DVQdby3RmnyEVfjLoAM6hCycwEjgsmsKRl/jbwtgzb5Qh5QLIK9XOTcfWtGUb0L
         D27duiv03jfE3w4YBeXMwGVdexDnqlAzxG/38uuk4Kmc/jDFUDfZ043aMwvErcCKXHp1
         qzew==
X-Forwarded-Encrypted: i=1; AJvYcCWddUd8SZi32SgiW0tXwck9R2NuXs41x7bn+pqaHSnlKxJS/zNt2CwQw+G1y1As2SP2p0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzORiTdWevJ9dOLy+XNhC5eIxapqApdU1DTTlSthKAOhnwUBkMF
	YyDORyb0ZkZWt14JWqtNgRoy23/QqFX396uL018dg8FN4O8syYeGLz8VEeqsJxcbMPeVTBkF4i6
	wWuwD/WNgohcvXL3Y8wqD+MYDUYXCSw==
X-Google-Smtp-Source: AGHT+IFbeNza57DvhBtbqypVP4iOmWCmwpKte2jSo3qiBq4o6+rTptOulmBTiqGcbWCmmzf72kip7Mm1IlTLAV9c8JU=
X-Received: by 2002:ad4:5bc8:0:b0:6cb:6782:6a8c with SMTP id
 6a1803df08f44-6cb9a54e244mr56508816d6.12.1728216382018; Sun, 06 Oct 2024
 05:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com> <ZwJwsuf5ZOKiWbS1@ArchLinux>
In-Reply-To: <ZwJwsuf5ZOKiWbS1@ArchLinux>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 08:06:10 -0400
Message-ID: <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: shejialuo <shejialuo@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 7:12=E2=80=AFAM shejialuo <shejialuo@gmail.com> wrot=
e:
> On Sun, Oct 06, 2024 at 05:19:13AM -0400, Eric Sunshine wrote:
> > It probably would have been helpful to reviewers if the patch's
> > commit message mentioned that it only converts some of the
> > instances, but it's not worth rerolling the patch just for that.
>
> Except that, the commit title should not either include
> "[Outreachy][Patch v1]" here. From these two reasons, I think we should
> reroll the patch.

Your observation about outdated/confusing "[foo]" annotations is
certainly something the submitter should take into consideration for
future submissions, but does not seem worthy of a reroll, IMHO. First,
`git am` will strip those off automatically, so they won't become part
of the permanent project history anyhow when/if Junio picks up the
patch. Second, asking for a reroll for something which does not impact
the correctness of either the patch or the commit message just makes
busy-work for the submitter and wastes reviewer time (which is a
limited resource on this project). Third, the point of a microproject
is to expose the submitter to the workflow of the Git project and to
the review process, and for reviewers to see how the submitter
responds. That goal has already been achieved in this case, and
rerolling for something so minor provides no additional benefit in
that regard.
