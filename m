Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CA2E7376
	for <git@vger.kernel.org>; Thu, 28 May 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996677; cv=pass; b=tukuqNqdevMBptyarjpVqNj0PCJ1t1EI84R0/rBL0Y+4yqeiPWk3JT1Z4mXLt+TdIdmfps53h+iNKHAoAxUkamQSK41KbJgaYZWZb+d8vjBEz8zcGR6hgLaFzJkZzSNR5m3zDXyjP61uCnk1Jwx64Q6p5iEuKGM/kEI4DGdIh9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996677; c=relaxed/simple;
	bh=EA8/bAO+jE3aCLIFJovh/aaKq9z3QsNjwLuBW0ftuhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQSqayAld7z5cHcjHcqkXWzxt97olBXdPVhLn8yz2Yz/5LPKvaVlivZnVKBE0Z/xhmrtxYwGSpU2bupy2m0h62KmJppH4BLiCR+IJSrHLGOxrKB9Ll6T3uRvpBg0HIwCTx0w7DakNpK/SyvNxVsjCoSW98aVHJ7K+RFpeovZ/60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLz5mu4p; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLz5mu4p"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6949192b840so3681491eaf.3
        for <git@vger.kernel.org>; Thu, 28 May 2026 12:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779996675; cv=none;
        d=google.com; s=arc-20240605;
        b=AFQOET7ybo7X0cBZUZRbbf9PdDyRXl6D3IlohWhv5V4VLY2AJunA41nMuezzPCMVfb
         1JBMW1or25O6ssx4rQ8oLuuL2UxTIL8KGSZYQqgQCXmnrIYfj8GfXKWPATCfvMrfwxBw
         F11Nv2fKJpTC9hQ5OVLj6BbAI4eaFzMMSU08RM8Wb0GGQCskWk0zSMycXcRQB+wliwwS
         DmNYXpFVeKFoMIaVp7Cet1f9Y1UhaFgqzH742+jQ7k7VYsIygZqppPLet733CMlXEsrw
         hhOZNxZog8Duz99DS7o56EyRU424Wpwp8fS3rDS56KeAAjf/2yt0PWIOt4wZhO3wvq07
         JdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=knxjkYhh2ZKrThSYNSbXhCyNZ27urHSDYIGH+jazeR0=;
        fh=qf1fOvL4U1mbe1MoPyMXOD6BmqNgOYBQ/WV21QRzEoE=;
        b=HOA5TM15o886Ew1kqxm31cPsLhWK3v6ZDUVOD/hSjh+i6yQ5ZjXRg8jPAUWNmy8eO0
         9U2CBLkFZ5GsN8uhbxml2qEx4Ts/hboI4gIaisThQ3fbSM1Fe7ulYJEdpbpTASR7jeBO
         8+2G2nVgYVWnlr2FfZJXi2vyvRVk1TkK7vMKRaM1dYWI4lABshYZfK3uIdHytccw80nU
         Nr9YecDIAXNXmRgl0QfvbtvTNStsSMZT/R+2J1F8SS0fr7ekB/z4yY4IETJI+xJzZyKp
         qKu40+ze6PIBRuyeY+l7gXuUpY2W18277k7I/pMB2OXNX6uOgTR4XfXOqBPlQmuESmfx
         TqnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996675; x=1780601475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knxjkYhh2ZKrThSYNSbXhCyNZ27urHSDYIGH+jazeR0=;
        b=qLz5mu4pUuxDyzMOje6eTwTr4KC+wmrQKYxvxWjC4h3Rm5iRYtirBCGt/r7kD/CB2F
         TQNAoFAtX7uxEMRqprmYNAKvp4IqRQaKFBzxAWAGDixZ8pP5uzki4OhTHG886E6S20OK
         qnwif3yJiJUjW8FToeGqCCJ8T6zG3tpwuNUyTez5fZaBTepLdnE833C/+cO20nzvWjT1
         Cyq/jqSGSZHZnWx48K1Z0oO6Olu4lTjkbNmN20QI5UV4Dci9nlixKbep3tRM2sh4UsWm
         nU+sZtDg9MLDIaJCtnbwnSmU8HY/5AhnM944WmgGEWtqIVySR7wFyONHDH0bVLknUlat
         zXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996675; x=1780601475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knxjkYhh2ZKrThSYNSbXhCyNZ27urHSDYIGH+jazeR0=;
        b=gBBuB1Gx+bgv1N25NC4WN69O4J419kU3PdyD+cM3ZnwP3ZdLECimd1zuSSH1C3/e9n
         9EgBhmldC9+mnBQd4lCAr4zPJ/4LCfpalD3aEag0iYKYyUX7+UVD8hhH3pcGjuPR+6SS
         fuOn/PJHbqytwTpR3AwUaSTEQwTk6Lemsyr6EldedFqyna8uiNTiEPpwnTVEKe8FtFEx
         NJL20+0s69kCIi5gBgHSRVPZN9ZSx5aoNO7Z7cehsu6Tc2E8HpeGy2MaCNqMTR5jVRdY
         FISRSKULyYakisoTQNNy+aX0d1NAn7qAdmxdg4v1EgCkQ1L1bO2ez56RAhlNHe76pszF
         VoGw==
X-Forwarded-Encrypted: i=1; AFNElJ8t1HShkPa5GM3ERcaX6k05oYpXioPnFxN2/6iy7Gvj9wXlVv7H5Qj+lgmHJjJDmheqx2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4Rd/KGKX4o8HcNkU9bqOGkq33JDwXR5466pjggiz7NWOL9Bm
	UIbc9POJXKLAA/y+5/oPUKQXT1S7p/S8t8HyXyP9bwC4KGGAoRaqcnDcXO2Aj2wG7sxqM63fM7/
	8Oxqf6K/qAx8/NypEgAp5xlQbyXKx96z58qGt
X-Gm-Gg: Acq92OFZEPnauEEoeHLxK9AwhqOa9x6niHLvRHWfhOfFuPbSlGxvJ82jcNVRllQHYhG
	mmiyJ3seZV+3IBLVoipTTJJTFC6jhEZJTGQ0ZgFh7WlZq7DiJG60GFKGHlWbepavuftYKNz2xDW
	nqP86A8nN8ZZ6wbyZS5GnfTDjQmkDW+6hP5ldIB5GtnEgsEmjwzvhHTImVW8P+F9v7s0Rvqlu/H
	OkayQKf6srxiSIoeF9DDGrrFMIO7kcaCJCIREY/R2jLEgofzkeg1Ehpl+25oBPcFIP7tcnrU9a1
	u42DVC4hOT3j/3XY9g66QMlhNiyX9P4+TZo/C6MltOXNbCilxPuaqoRBPZdJ6Q==
X-Received: by 2002:a05:6820:c0d1:20b0:69b:56e5:e4ce with SMTP id
 006d021491bc7-69d7ec6a630mr9550948eaf.37.1779996675531; Thu, 28 May 2026
 12:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
 <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com> <CALnO6CA5GPS2CMv_x_=wOPBgspe31FkW=h832GCBpAUbBoJNLg@mail.gmail.com>
 <xmqqo6hzjrde.fsf@gitster.g>
In-Reply-To: <xmqqo6hzjrde.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 28 May 2026 12:31:03 -0700
X-Gm-Features: AVHnY4J6962S-5WE4FdYiQWB850409OcLkGKmM7QbPD0y5WV75dcZSbbrswQn38
Message-ID: <CAC2QwmJZyVY0EZnr1144gRrAxBxVoxd1x64t60DL-SeWFyn6Rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] line-log: integrate -L with the standard log
 output pipeline
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> >>      ++ ! test_grep "^diff --git" actual &&
> >>      ++ ! test_grep "^@@" actual
> >
> > I wish we had docs for all the little test helpers=E2=80=A6 in particul=
ar, I
> > think this is supposed to be "test_grep !" ?

Good catch, thank you! Will submit a fix and try to address the lack
of docs in a follow-up.

>
> Good eyes.  I wonder if we teach test-lint to catch these.

I had the same thought, and started working on a series that does this
and migrates
existing offenders. I should be able to submit it soon.
