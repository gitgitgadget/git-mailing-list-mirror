Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC63E479
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022352; cv=none; b=bXouMC+u0zCuTvvVdCj7uzhHtL1oVuEtQmCwkaNcMxOSQZZ8/dPdL0HPPkv9b2xF19Aha+iWC9w++uO+R6jPYShr275n4zDIjcgl50LBkaYRa6UoKiODNaD4+50CSExa8f6IhMMc+L4nmH59noJnjX1Q5qBW4jUfJT3Woi1rSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022352; c=relaxed/simple;
	bh=vESyMSczE2pACAEY+DNL9MzzYrE7Vcutfg8UzTmyHpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf6ksU/mj7oskasqozM+Ip35TFjfpBmVO1MVrEsLoe1ISHl/iMRmj1aZzi8VuS4Dd7AnDQdUD5n0RPSU3uF0X8ZIJPiE1cUWszgEt8uZxZr+6XlqzddwRrfrpn3VC3cgplZGOBfXj4NciAArGE+rD3h1Ouo9pdVrMj0uDcRl+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b7acf213a3so5073776d6.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022349; x=1722627149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0SmzdqhfF7qmjtkAiPUDNDJX+e05j3GwMkHVfl55aE=;
        b=XNXB71kw6ydqzxMxK8mmRiOY/WVwAbVUocCiXduJ0by0sxVGo7GjL6Ncj+YCKUWPr8
         0waADPVxcwZnrydlRs+ONRnxHH97EFw66dGYwj6rzHJDolOnKR9uoXfNI0Llx05A4rnY
         N7d0qvkN3BQXvsDNADqPX8Bcdx/PQ2mysJwDs+jSiRNgp4pV5QPrrz8VWsTe32WvXFfA
         rAs7O2qMtKcjCeYJl3i1tXAirFILoOxN3GF0aUv2WdH4rCURYRHcw03pAAkX9Cm3uusB
         aoVlyUiwDwlUuSC5ncli3ylHjzb5tY+2OJte0QoyhY5pG7BmTS9mDnfVIxmD64xIBEH9
         KIbg==
X-Forwarded-Encrypted: i=1; AJvYcCWNbBKb+d5AWT4LISrILEtRfp9HARJ7LYcfqN8TOzCmPP8xQPjnAZLrSbWCyYuprST4N9hEA2fVMOv4RRf7hAmvH59g
X-Gm-Message-State: AOJu0Yxd/BLN9ldhUSMDh3zZeEBAJucXP4fHZ8x6aYv4xxXQy4qzrArf
	KGOni+zJ9UCb88oGMMWi2uzis5k0VWN/q6irFiqSjSrcRG1kOfNl6qQcMuSwxhXkzcsFTxfU9Il
	AuIS+V/9m0kIVeYv0Y6aw8MmWg9DA/Q==
X-Google-Smtp-Source: AGHT+IFuqQ+GvwfPzqPVkjIp7AlEbKcTfayEsB/6GOhf/NfQNVewgacS0UOhoJRH6mcgLeTrtJ1Dt5k3uiLy7UcezkM=
X-Received: by 2002:ad4:5962:0:b0:6b5:116:b212 with SMTP id
 6a1803df08f44-6bb55adc09bmr8327076d6.45.1722022349172; Fri, 26 Jul 2024
 12:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240726081522.28015-1-ericsunshine@charter.net> <20240726081522.28015-2-ericsunshine@charter.net>
 <xmqqplr0t2bo.fsf@gitster.g>
In-Reply-To: <xmqqplr0t2bo.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Jul 2024 15:32:17 -0400
Message-ID: <CAPig+cSOggARypGJzjKBe82DtdFGz9OGKm55sB5_pj2d79fD=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] t3430: drop unnecessary one-shot "VAR=val
 shell-func" invocation
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Kyle Lippincott <spectral@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <ericsunshine@charter.net> writes:
> > The behavior of a one-shot environment variable assignment of the form
> > "VAR=3Dval cmd" is undefined according to POSIX when "cmd" is a shell
>
> Please use the right word to describe what the standard says.
>
> Throughout the topic's discussion, you seem to be repeating
> "undefined", but the word POSIX uses for this particular unportable
> behaviour is "unspecified".  The differences are subtle, and for
> programs that want to be conformant, there is no practical
> difference (in other words, we should not rely on the existence or
> validity of the value or behaviour if we wanted to be portable).
>
> The former is what results from use of an invalid construct or
> feeding an invalid data input.  The implementation can do whatever
> it wants to do once you trigger an undefined behaviour.  The latter
> is what results from use of a valid construct or valid data input,
> but outcome may differ across implementations.  An "unspecified"
> behaviour often are still consistent and sensible within a single
> conformant implementation.

Makes sense. Will adjust the commit messages.
