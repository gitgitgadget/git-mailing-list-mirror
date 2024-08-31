Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409F16A940
	for <git@vger.kernel.org>; Sat, 31 Aug 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099890; cv=none; b=dMa9HEOI/ByfAZJgnTnsV5lnzgCEzu79m/spuUOIX53/5e+qsWR8aj0qkdvZoRXr0PKIU2tEgcp4GpaYbnGc1Mdm77xqibTEO1eivbYM75gDpvIDSAUShDTXvlrC5TMQME53f1HBDoK2793iT2tuVza4SdvqX8Rq8W7VSRU69No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099890; c=relaxed/simple;
	bh=W+jvin7qg5jnoglh+X3ErXpuYHjZUv32SGoAgji6u9w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ww48DoxCtbfeD/SAVyd6ws6HEK8MbNEOCc+LM0a0F+pMC/f3i+HaSMKyW59lc2g7vFe052TYYULuodxshfmWSFCu/JBuprpwd0VVWpu3tfygQ50cLAdeoQ8zCL4kOocr916safiyYxQ8PH7XBhOOeJ6x4o8Q2225TatR+O6NfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZlvIOjn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZlvIOjn"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53349d3071eso3507325e87.2
        for <git@vger.kernel.org>; Sat, 31 Aug 2024 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725099887; x=1725704687; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn/eUqAItQ4Ja0y4bnzbarZa5dc4k02TDEVdxSKRW34=;
        b=eZlvIOjnwkIs7XejbcYbQo5oqysZXSn1SCH3EWygWixEpumealuuRE9mxL8Q5xB+5b
         J9hl/f44v90wB9of5wAKI3GMrU3iwirWOXWYxUSEZSOhdrlCEwU9r1YG087A9BKtHPVa
         8LPf+YTlKtZVgabw6OMHoAUok2ywSfY79tcohz4ZqGwGHNxP8jFBzG+QE06U4AIvldHg
         7ViaSxe2s5iI3qp+TqJr+hlt/LpNBFrsv89Kr4eJXgPZAIfLvgugA2t54BYWFDDvEI3U
         BO8NBXz0dZI/FEGZxLy2HqI7ewIdxrtEUAZQeBWzyZOlofUG8i7o2ahHYodbaDV7vsjb
         kAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099887; x=1725704687;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn/eUqAItQ4Ja0y4bnzbarZa5dc4k02TDEVdxSKRW34=;
        b=GhHBdFCn+1udecgM9nXdIQbrVvbSf9jzkSXRsJdkZuUaR1yhXrtJjnXsi/UKvsvlxv
         n+tjyNRn0fPPrldaU2XUbAW26e/qJJoD7DnhQhuKxg23AtOQpXW3tfMK12lcAejOiUM5
         diDeBJhxQMLN/9cnp9nPnOYwM/UEr0NdLFbJ+J7xSFIMt5C+uTdKO8sDZkfGukHNP3hO
         Guwe3z2o1FRLLsuMJbD7eX3DExkt9HMTHQQdox7U7fBUookVWgMDJTprqQ4xX7YYWBqV
         cFT8ZUvhGYOEZEUhJj3LS+01HGWbcUxsDynpPKlFiEBnn26X+mhkFQX0wkFq+RXEJ/0b
         +cig==
X-Gm-Message-State: AOJu0YwmkTpXY6hE4jfvwEw4oJxOemcOnrzCeGnrwTSzemiqlYo3AMaZ
	jJL0LjvJCq8qf8qYfIPdEWa1FJIg+BlsO+lmu4c/O9+abVSFYlfyw8CMIQ==
X-Google-Smtp-Source: AGHT+IH1moPtrP7XFZRrjQT0puBfT1vO9pnYg/8zhZvr01Vh/POzU6f3L9JwDrV6gLhmCuSyrgPgPA==
X-Received: by 2002:a05:6512:10d6:b0:52e:d0f8:2d30 with SMTP id 2adb3069b0e04-53546bb8cdbmr3592659e87.59.1725099886649;
        Sat, 31 Aug 2024 03:24:46 -0700 (PDT)
Received: from smtpclient.apple (88-113-116-214.elisa-laajakaista.fi. [88.113.116.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079b82fsm916346e87.17.2024.08.31.03.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2024 03:24:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Unpredictable peak memory usage when using `git log` command
From: Yuri Karnilaev <karnilaev@gmail.com>
In-Reply-To: <20240830210607.GB1038751@coredump.intra.peff.net>
Date: Sat, 31 Aug 2024 13:24:35 +0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <13D8CFB5-4073-42CC-BFDD-ADFE8FFE985C@gmail.com>
References: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>
 <20240830210607.GB1038751@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3776.700.51)

Thanks, Peff!

I will try the recommendations for optimizing memory consumption for my =
task, that you mentioned.

Have a nice day,
Yuri

> On 31. Aug 2024, at 0.06, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Aug 30, 2024 at 03:20:15PM +0300, Yuri Karnilaev wrote:
>=20
>> 2. Processing commits in batches:
>> ```
>> /usr/bin/time -l -h -p git log --ignore-missing =
--pretty=3Dformat:%H%x02%P%x02%aN%x02%aE%x02%at%x00 -n 1000 =
--skip=3D1000000 --numstat > 1.txt
>> ```
>> [...]
>> Operating System: Mac OS 14.6.1 (23G93)
>> Git Version: 2.39.3 (Apple Git-146)
>=20
> I sent a patch which I think should make things better for you, but I
> wanted to mention two things in a more general way:
>=20
>  1. You should really consider building a commit-graph file with "git
>     commit-graph write --reachable". That will reduce the memory usage
>     for this case, but also improve the CPU quite a bit (we won't have
>     to open those million skipped commits to chase their parent
>     pointers).
>=20
>     I haven't kept up with the defaults for writing graph files. I
>     thought gc.writeCommitGraph defaults to "true" these days, though
>     that wouldn't help in a freshly cloned repository (arguably we
>     should write the commit graph on clone?).
>=20
>  2. Using "--skip" still has to traverse all of those intermediate
>     commits. So it's effectively quadratic in the number of commits
>     overall (you end up skipping the first 1000 over and over).
>=20
>     It's been a while since I've had to "paginate" segments of history
>     like this, but a better solution is along the lines of:
>=20
>       - use "-n 1000" to get 1000 commits in each chunk
>=20
>       - use "--boundary" to report the commits that were queued to be
> 	 traversed next but weren't shown
>=20
>       - in invocations after the first one, start the traversal at
> 	 those boundary commits, rather than HEAD
>=20
>     You'll probably need to add "%m" to your format to show the
>     boundaries (or alternatively, you can do the commit selection with
>     rev-list, and then output the result to "log --no-walk --stdin" to
>     do the pretty-printing).
>=20
> -Peff

