Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CC1A840D
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814318; cv=none; b=n3f00X4X03f9SQjxBdD4Y5a75Ow3Vf3T+T/rHxaX2N+PG1/5bfLAOOI6M+q0pIxRkikoXDOHrBLGda9ogVEhLxyYGKWtH/DYBEAwVDoDi08btiA2iFglpVYfzP592/r8g8DXAr0TZKauhk/L4scwVTuz2ALKOLH8ye+T5YFfp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814318; c=relaxed/simple;
	bh=vNhqR1EjYQmfPO4s0MA83m7r0gMiVoXpV6K1dpDCO9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=al/u8aLLgymZEc+QaPBizbbUv7mPPxONf+QWPGYfnn5NmzqDMEWI3n5lGFUUpi5x6D5DJcqRFeo2WbHeIXFbnkAW3VyZMd0ugUBTnHtGYmgi8nMe7GP0hsSX+2+DQotdpjrjGego0WQEXLtFbfmn8AgXv2soyqVn0hOrM+4jKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krNXEmgT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krNXEmgT"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476f4e9cf92so50785981cf.3
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744814316; x=1745419116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6e3Jir8n7pQYX1yRmv2w5W820R/Jh0i7tSVRArti14=;
        b=krNXEmgTNazYnyvpM4bvdZCYJN/ACV1hKoKd7F3S5NG6jWKNTNujdpoYPs38h23raf
         cIn3UrAkc5VNsqCZoU6u0ixWTSrRku2z8TXZKsjyP4RTfa8mW/KNDduCLq8f98vHUU3g
         1WdeHSMW4eQSjUwZ+aL8D/zd2aOZrx1ZlENx8LyGh4FJYuLJI4iX+0gAkC/OSi0beyi1
         sKaLTA2W5A7K01RJlefZTq42O2w3/ZHILFXw5N5NXgOLJOGtiveRfD8kpiuQiFqCfr2+
         WRAz04nmTr3oERvqmbpmJgUy96+5pQyx02uAJwjiYc0u1WGHe2iJgs1ced5Q7mw1mWnj
         IwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744814316; x=1745419116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6e3Jir8n7pQYX1yRmv2w5W820R/Jh0i7tSVRArti14=;
        b=L+5Jtgp5cU2hcCsOiudHEn49er+KfItNz9D+TbdYADHbTL611tMAlfJBqCPw9CJWcO
         yckm3J5QoC6v5ZKtFV7XeCEmIbCW+bLaw58xCDhQzlr3ZrVKA5XvoXFM/ujH6VhPMyrT
         t/VCNpHs344XesB29zQZoIBwBs2bxvKNVch4AdjbNrigB7Vg635Eof09XD6QliZKpKeg
         LiqUl+JF83kTpnXulDrbK+w56WLKoFr8pYOLE4DOvxjZRB3Lvb9Dges90gnPsTZ6BEcR
         q6pQBq96khK2JVlbbP0ZvNhf3SfQ8QOauNRZ7krkjvUfLrjtygNuQx69semynjvBqRER
         YqVg==
X-Gm-Message-State: AOJu0YyIP/mta2jIe2McIJDw2EzuzFrZKcWAjjSOkLJ4kOS1KkliMCpv
	ZgNEOFV+18jr1KJujLHea3ElWJoIBiC0wG51TPWwhtF/U6pa1i+izDgWTANJdsbIRbqao++dbw/
	4lvnPNLknbiRKbqn2z1+2iymLYj4qTedj
X-Gm-Gg: ASbGncsPCF8b/SnlIbTNRTSEROd/tKBLpFVxpAWcW4uDcBu9f8k1rF1Oajmh7JJEvw8
	KSutWft0UFn7eaJyV43TdXQep83Q/rZAA+vAB5cwbaRMNLWxe1ra7wGlhpg/ysH0lZo8TJh41TE
	6s+mdk4BPAwYzV0Ms5qM0zrTxMTpxyISpYEG1gjqYsKfbJL9DdfdtBeY0=
X-Google-Smtp-Source: AGHT+IEhY5r1eUqa13DNxz3Yhm+/5VqkP1av6BXkAK77xCDM6bnl7E7/1GdF3/trL8UA/cmg4mjjhXaLhY5665iJQxU=
X-Received: by 2002:ac8:59c6:0:b0:477:704a:a580 with SMTP id
 d75a77b69052e-47ad80b41b5mr35712221cf.13.1744814315762; Wed, 16 Apr 2025
 07:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com> <xmqqr01si441.fsf@gitster.g>
In-Reply-To: <xmqqr01si441.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 16 Apr 2025 20:08:24 +0530
X-Gm-Features: ATxdqUFr4xuqB428pg7UkaH-Hz21QHRJjs6NrqGIBFXmQi_4VSaOy0K-SnBP434
Message-ID: <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
>     To: git@vger.kernel.org
>     Cc: Junio C Hamano <gitster@pobox.com>, jayatheerthkulkarni2005@gmail=
.com
>
> Pick a better reviewer than me if you want your patches reviewed
> more quickly, perhaps?  I had only 3 patches to the file in the past
> 3 years, while there are others who had their hands to the file with
> more changes.  "git shortlog --no-merges --since=3D3.years" is your
> friend ;-)
>
Umm I got no issues with slow reviews too, but I also ran the command
and I think the most amounts of commits for this file looks something like =
this

git shortlog --no-merges --since=3D6.years -- Documentation/MyFirstContribu=
ti
on.adoc
Jean-No=C3=ABl Avila (1):
      doc: add a blank line around block delimiters

K Jayatheerth (4):
      Remove unused git-mentoring mailing list
      Docs: Correct cmd_psuh and Explain UNUSED macro
      Docs: Add cmd_psuh with repo and UNUSED removal
      cmd_psuh: Prefer repo_config for config lookup

Todd Zullinger (1):
      MyFirstContribution: *.txt -> *.adoc fixes

brian m. carlson (1):
      doc: use .adoc extension for AsciiDoc files


If you can suggest someone, I could CC them in this thread.

Thank you,
-Jayatheerth
