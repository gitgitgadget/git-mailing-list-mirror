Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EB129A8D
	for <git@vger.kernel.org>; Fri, 24 May 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541326; cv=none; b=XTLqSEfOtGdwU+JoAz44GDEA3Rism8qlHbH66oj2EMJr6VhtxqoFw8XYyObxI38gFxV8gIcLwgU7UXtDKQFdiCyq6+bmrpZb/Yc8g+Di2+eUZmRIDO0ZnHRlMixSps8x9e578QtL6+Sm7rfdRxOadS1RsAkrlxLQvCnFeuEuIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541326; c=relaxed/simple;
	bh=H89A0/UrbsZhwIFMTKM5VUS92W5wV6Z8wX0Z7VnHn7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6WUofqTpx7rF85iDFl17RhxrKa5eRSphBehhBJRpNeiRkoVdLn4v/OH8U+nMyArDeRVHS9L2KavTiiFiMXnMxOTDBuvnGMDqy4S/MhFYqfj5xK8EuEcWmGdEQuMUCZM1eWHWIsrBC/C1kgUt6F5lg+hvoECGBue5TjjJdUYaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9958a9485so1900140b6e.2
        for <git@vger.kernel.org>; Fri, 24 May 2024 02:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541323; x=1717146123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H89A0/UrbsZhwIFMTKM5VUS92W5wV6Z8wX0Z7VnHn7U=;
        b=Ym+llE9ffgij5uWz7My5zOfgVWCxpU8WHBhcoMzEiBlOoujfUC/C4wQSRYhlKFepgM
         0pnGYoScDJWZNVqUHKna1XMtf8cruGTAQA/ciXwkJZGKKM7cqhsz7et9XM0ZJYq+V7EX
         WRWxnu2a3jQupmvjAGoVqPUZoISg5D0EHzjTcaGS8fb9sqeosWWCip/i12M39z4qfpvi
         IpIhbl+F78v5Vwl41s/Q3nf1wnNZgmyZZajqHiNI2GkaAZtMtUmgqjwtv7aAgZDcoMZa
         1cxRA0guiGeFGly9FKVHa2YKhl+KOdQvdPRzbN6zygeqhVCCk7fhYX/31EEHQm99onFT
         VSPg==
X-Gm-Message-State: AOJu0YzcV3vtjPbI/NcV0wy/2V5vWeHso/BvkYgxrFnnQt1I5pXXe4CZ
	x7SRGAuY2wvSPorn8ra23lPsw00JNY0lvCtSiqAPsDf/xwDXZ1UEvj94YgVH0pfp1m2SBDeauMO
	LAdXRKs4yb04OT9FJwCHce70/d00YtQ==
X-Google-Smtp-Source: AGHT+IFVnb5oDP0lMwamvOGkv53HvI2VeQ6nEkVHoPXZB6T/eiPkKO8iLnvwfEYKqSNFHZJ0gYRpAV6Ny5RkKb3N53Q=
X-Received: by 2002:a05:6808:1786:b0:3c9:7a59:3bbc with SMTP id
 5614622812f47-3d1a7d2872fmr2134513b6e.54.1716541323247; Fri, 24 May 2024
 02:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716451672.git.ps@pks.im> <4e0edda6d3ef48509206d849ceb1f347e51251d9.1716451672.git.ps@pks.im>
 <CAPig+cSM2mcEByQ=kJz2nFRR6OoatoNnii7Wy3wAiGBHO0LWrg@mail.gmail.com> <ZlBDUncKuWsfrfXF@tanuki>
In-Reply-To: <ZlBDUncKuWsfrfXF@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 24 May 2024 05:01:52 -0400
Message-ID: <CAPig+cRCERqusxCHTmsPLuj6bgpQaRfM08L+D1Y=MSQooJikmQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] refs: implement logic to migrate between ref storage formats
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Thu, May 23, 2024 at 01:31:03PM -0400, Eric Sunshine wrote:
> > On Thu, May 23, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > In other words, this version is a minimum viable product for migratin=
g a
> > > repository's ref storage format. It works alright for bare repos, whi=
ch
> > > typically have neither worktrees nor reflogs.
> >
> > Worktrees hanging off a bare repository is an explicitly supported
> > use-case, and there are people who use and promote such an
> > organization, so I'm not sure if "typically" is accurate these days.
> > Anyhow, just a minor observation, probably not worth rewording, and
> > certainly not worth a reroll.
>
> True enough. I would claim that most bare repositories out in the wild
> do not have worktrees, mostly because they are used on the server side.
> But in the end, quantity is rather irrelevant. I'll s/typically/often/
> to relax the statement a bit. Does that work for you?

Yes, "often" works just fine.
