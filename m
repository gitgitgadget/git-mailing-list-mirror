Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4D26AE9
	for <git@vger.kernel.org>; Mon, 13 May 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600618; cv=none; b=sUBZOhxLB6DA/LKxkBdPbErmwMOoa+U9BTZvVjeTyzAken6lpEoAy+onAAgHHjKPAKlOHLX+0DT8rLjoG5p5nqoWMPKjPtfAQc87TjW5EP4LExM7AkL2yiuKJ333EqLT/1j3yRIk3EDOlq643ZVoOd7g4h6FR85Z17A4SMfK22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600618; c=relaxed/simple;
	bh=VdmqMyyOv1ST4pJqt8t109rA7MJs0LPiefUxd1Fkd5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGrVFaJwN1rE09PankcQlLqsQH0zBve/9tBPCnBeV+vRTgD8tYgRT4gv6wbmssaVw+RwwyEdI2vnyBdKhy3IommziYzdr9EI9CDZE1YZviuQ+X1PDS7wXnbd7B2ze/PdH3nJMkR33E/GmRaSnEN8yjDukKj3paBse07Z/O7RV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It7LPwae; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It7LPwae"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b273b9f1deso2276707eaf.3
        for <git@vger.kernel.org>; Mon, 13 May 2024 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715600616; x=1716205416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/AdGUztfXnjgCUXkk5XXlmReRbiCx9JAQI9Gbt4P+o=;
        b=It7LPwaeIeqX6N4xMm9GAX+83aYtfK7ruDfSGGj2A9fR8pNcHOAC3ESbv8RAEHfy5D
         YzOcvzUEPOb0ZEq4WDpxTTt6t3RgVl9DqXT1Z8il4IaDFagrykWKZJ9ae0ZZePJ/p11b
         a9avZjOSicSCkSetc2b9LuXrKSNeNRCs+q9gGH2hUY8iL0K6J8HGtIqpOoXRUp6If1k/
         RoyDg+H4Xr13Cdu/z4U0irS46EpdDZFUHolQAVh3fZI4byGxRSSIpU7jV1bkChaEaUBU
         Fffhdo+Vyt9/OEFklUGBZTp9VmcNmEaHFcHKc+SgQyear97cw/kpB3e8IZLJ4hdfvWfA
         XV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715600616; x=1716205416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/AdGUztfXnjgCUXkk5XXlmReRbiCx9JAQI9Gbt4P+o=;
        b=WJQnx4fx/PE5LtVDdga0TNTD+eSriCQ+XbY9vhxbwGbtL7mC/N0TcZiXiGavfA0ZkR
         vw/d4rYTERWsPo9UBaMDutTNXmHGhRLgcrflW4KrKr2P1avOKizeamoy2wgTpPQxohQ0
         dNPG+FKFyW+wb5Eari6VCwg4UshZoII66RA3hcGDlpV8IhoIdCZ/tt1yrS7W+xyKYfdU
         wS2OFySyCrXcre2lAdP7cd7Z/fORH8mqF+xSQEtO90ID8/EPkMIcRszRg7xt2eYaObtg
         bT0+y2vZ8EwX//VyYbomg0OX3R3HTEYv7/LAMnssrKq3jnQmzqvCVfuxlzNMGi93QNq0
         EOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQ577KUui6eXugo8+zfN5VpMJdlX5h+jEt1/fD3Gl/M+WgrkWMOpUZHO7wRVO3XyF1+ZzprgT86IUX27+9LlWOD53
X-Gm-Message-State: AOJu0YyZQyPclARpqV77UE3RvmVj60dJZVwnccGIaBvVcAUstO4DAQjD
	fcJOQTpbXAJg+SqPKB23CBfKcby726CYX84dNpBsSZxs/9s5aqiFof/JzKcv4FF+DfFEL0YKsAt
	UGfmzoH2Q3QLW/LZBjCU0MvtYRMs=
X-Google-Smtp-Source: AGHT+IGYCbDIxn+6FVsDIWXWromKAsfwUgi42xE8yqm5n5KFSi7Lho0nCLPaHbQQH5BBko7z7qVWReoaK5YOZN/qJJc=
X-Received: by 2002:a4a:5141:0:b0:5aa:396b:6537 with SMTP id
 006d021491bc7-5b281a1b4a0mr10330159eaf.7.1715600615743; Mon, 13 May 2024
 04:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKkAvazeFvCfT7tZm3emwA=k-NnzPD7X0v4t2E9Ja4r-GpZfoQ@mail.gmail.com>
 <20240510221323.GA1971112@coredump.intra.peff.net>
In-Reply-To: <20240510221323.GA1971112@coredump.intra.peff.net>
From: ryenus <ryenus@gmail.com>
Date: Mon, 13 May 2024 19:43:24 +0800
Message-ID: <CAKkAvaxFbcLZNdz5cdAF8ZFNtVT1qQYKWcmkniQ3Uzu8mdEt5w@mail.gmail.com>
Subject: Re: Error: failed to store: -25299
To: Bo Anderson <mail@boanderson.me>
Cc: Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 06:13, Jeff King <peff@peff.net> wrote:
>
> On Fri, May 10, 2024 at 03:52:25PM +0800, ryenus wrote:
>
> > Command I run: `parallel git -C {} fetch ::: repo1 repo2 rep3`, which is
> > to fetch multiple repositories in parallel using GNU parallel.
> >
> > This worked pretty well for me in the past, however with git version
> > 2.45, maybe 2.44 as well, it would randomly emit below error:
> >
> > > failed to store: -25299
>
> There's some related discussion over in:
>
>   https://lore.kernel.org/git/pull.1729.git.1715328467099.gitgitgadget@gmail.com/
>
> But most curious to me is:
>
> > But if I do this without GNU parallel, or `parallel -j1` with only
> > one worker, things work just fine.
> > And when I switched back to git 2.43.2, I don't see such error either.
>
> I would have assumed this was an issue going back to 2011, since each of
> those fetches is going to try storing the successful credential. But if
> older-but-recent versions of Git did not have the problem, it could be
> that we are being more aggressive about invoking storage for some
> reason. Can you bisect?
>
> The obvious recent changes to the credential code were brian's
> capability/state series, but those are not yet in a released version
> (and from a quick scan I did not see anything that would obviously
> change things there).
>
> -Peff

@Bo98, possible to share any insight? It appears related to the following patch:

* osxkeychain: replace deprecated SecKeychain API [1]
[1]: https://github.com/git/git/commit/9abe31f5f161be4d69118bdfae00103cd6efa510

Apologize if I'm guessing it wrong :-)
