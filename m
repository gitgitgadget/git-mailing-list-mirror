Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420711CAF
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712368155; cv=none; b=hMhTjHWCgEiEf08i6RruGb+pGMx60caVELo3e0j6MIA0nGqXzi0+yG8JYwMDLIio+poGuurd0ymuF92OIPDRaUPlCLsZkl6X7Myo/xTFgxk5w++9rb5JPCkz7PxKwTC8FHHZnNddxb/SD589PqJgRIo2yLR+PEni2TziuGLK8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712368155; c=relaxed/simple;
	bh=sJfCUdRixkkEOJwFje3KYOwDvSEtlutbbojzGY+Nx8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1ENmAzpLOYAAOAArJA/VYKgnzDuNBUEZj96BwTWCN/T7u9qqTj0129whXTGnGSAyMBzG7HOR0PlFZPJjOsZSue/u0czeAq00tG2oqRNXAWJ42RpoEXkWnhhZWlEecQuRq0MsTryB4x78GtqKdN0wLgc3NwY8uQTW9jEKKtRziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2c725e234so11375285ad.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712368152; x=1712972952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhMmAa/1737Y5q6Pfj1arJVsgvU0rd/S89CIeM0EQ1I=;
        b=JYc8mXGTsJ9t3azLE6hXzRTyMYpouLj2ppkwHXQFTb67n4h/N14G3FgnkxyR5HEvWq
         TXs5cmTMDrjT8lrIOgCtCPMGHQxNCZPlyEpMuQPhxSSLerF3jvbsj3BlW5cEa75273e/
         P63x5+tBkJ/YmOb13NNcofnMFu03pLFcdXMUPlYKvebZaWaJQw7EIW/sihtlU01NXRET
         1qF8IBMpKFeRjq5UYIFGsNUD1eM7qVuZrsXWHkoF67tUuuG1IQ25dzC4pjDx7jERq71z
         4ZdIK2RKdCbtFn7VYVGNab9P8c+lFNTv8GdN9vlLtYN4Ym9LWWroTdhqZHi8Gi3Cfk6g
         Xi8g==
X-Gm-Message-State: AOJu0Yzp0/f4RYSQn8XbjRi+LzQuRB6Ns5/14Zn32g533rH2YgzudKK3
	uyvUGL3+tfLVyEdGzxeZvpr89x+qsjWnGTBoi5MB5s5gTmmuk9nxNLM+t6Ue4AtTzwKR2Q3f9Hc
	kJoaFNy3mFOOPv3fkBFNLvzns9qHv+8Vb
X-Google-Smtp-Source: AGHT+IEdSwI98hHUtivT3u4hfsQjhXvnVsrcfixAAz7Y2bVTJaAQdFvgTF4eZ2aHADac11sSlqBFFyaW7uOTmZ/OyTU=
X-Received: by 2002:a17:90a:b382:b0:2a2:9d4c:2166 with SMTP id
 e2-20020a17090ab38200b002a29d4c2166mr5772007pjr.4.1712368152285; Fri, 05 Apr
 2024 18:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711398665.git.dsimic@manjaro.org> <CAPig+cTia_gXkpNw6jo8VHg=ODqX71Nvff4Qfq0oMWqShv5TWg@mail.gmail.com>
 <92cb6c057591c7192fd7eb7097336f66@manjaro.org> <CAPig+cRECapN-9_u0JoESaS7KTi-==ri7Oy+sjff-VHL7p+vHQ@mail.gmail.com>
 <a3bc4829036f5803da513fee52267c2c@manjaro.org> <f5c2c3af9813d56adf85393f0e8fde0e@manjaro.org>
In-Reply-To: <f5c2c3af9813d56adf85393f0e8fde0e@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 5 Apr 2024 21:49:00 -0400
Message-ID: <CAPig+cToJgRn-ao9c9wXf7g99_TL3aRfwEasA9U3e4qNC3cVMg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Assorted improvements salvaged from an earlier series
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
> On 2024-03-25 21:54, Dragan Simic wrote:
> > On 2024-03-25 21:49, Eric Sunshine wrote:
> >> The range-diff is particularly valuable exactly for this case (new
> >> versions of old patches) since it is a "diff" between the old patches
> >> and the new patches. Thus, it provides reviewers with a precise
> >> summary of what changed between, say, v2 and v3 of a series, and
> >> manifests as a concrete representation of what your prose explanation
> >> describes.
> >
> > I see, and I do understand the purpose of range-diffs:  they make
> > reviewing new patch versions significantly easier, by relieving the
> > reviewers from the need to track down what has been changed in the
> > current patch version.
>
> As a note, I kept my promise :) and have started providing range-diffs
> in patch submissions. [1]

Glad to hear. Thanks.
