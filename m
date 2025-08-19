Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F415D5B6
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634612; cv=none; b=OrZgMmSCr3Xfd7kMzbn28sZ09Qya9tqgkumEIFINkYKWDV6YmAirNUDINN9gYw0CHXCSrYPE1b+jV7nv2Mo5qyt8DIpbdPAM7BGrTNHYIIB+8UqyiQzH76XZYN8l+w0glduWXJgZiN1pD2tpAWhyrt1Loe7e0jPbt1/VLWOGRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634612; c=relaxed/simple;
	bh=Jum63JIiui6fm0fZ3cnIDiNUKyTmX6Jv+qf43sKOmkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+1CKc68SPqGFYRbri6uMddpa+/q7CHZt9mhjGWw3MmcVqdfk/5YFrK8cVNfh6wX2N4qAdcUyuXUlSwUOFJdq0iV3HgeDqc8DwyNlh6kMmRY659SNWtR9Knhlk41beOMyzJI/npdMj2AFrcfBmkWstbcjNG4/Pvmypy+RJ7lgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70a9f5ec05fso4117836d6.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 13:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634609; x=1756239409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJBg+Ta2Zjif3Wn2DJlhBaRmYqtfS/LVucB4dc7UJ5U=;
        b=SaB+Re/MpJqRaks1i+BS6SPXlgI1KvrwltsQj7qBmnXCPj5jKDOVr7riU5wmBagxdB
         EqavlbIoKGI9S46EQpqzUsxucsiuGdYQN5eeLaTj+TgbfYEtUUXLMTwGWonuYQvvBhPC
         6Tcg4ltI6lRer7f9FC9PWL/rg8fbfJtfV31wt5EY6OjkIv/6gkqc0lXvLQbwBsfltS+G
         iYhLS3MotradTtOJVecgo2YQws9xzOyalMDMX2Ew3Xr2eyYkBt7M5rn1qMdBSfWbeieN
         j73fjOAeswtAqTEKspv6WP2lBt/WmCJ1OMhaRtscuf8P0MFwN6lmBTyqn76dF3iY6XLE
         0OYg==
X-Forwarded-Encrypted: i=1; AJvYcCVY5jsyrTZlO4JceuYqlz2nXQl0Y6/VmqLAuRCnYD45SseZgLVXDBswG0AEY/4wgf4bO1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mEMpK39Ex8QEBOutTS9uutD/YZ/A6BRi6KKGvh2AFeyW4WCJ
	M8KplEDAv7q7BKjLcXyH9reLf48wv5qb5C48mnQuxa6U3EdoDqS26WDlhQsF/0Mg/j3869yI5dz
	wsoFOq4KCc9I8guXbOQXUvMAzwXWZRMY=
X-Gm-Gg: ASbGncs3kw31CtKH7Ava84NsZ2+6NrEHiOpWkPkUMSd8sShQBH9PSThADrQ8+6wOeDD
	bZ72dTZK+CTR5cdXVB2dx3re6fPxX4vqYnNXIG1AXY9gAXZDApXh4UOM/PZXaGm+2NgnIKF1dYE
	jJycltpf0VyJ7UnxtfAOJThXYoEWyVpHjMcMkClyovWoDj6V6UGs5SAgD8M95235hsigZ9Pq8Tu
	JaLpocr3KmYSxt45k2Chyw5scud62Z4rWxmtCvC9MSIVbBGY8s=
X-Google-Smtp-Source: AGHT+IHu7F8Ku/FLR9jYJG1lBMy4iBsjWinD+Vh95opZrLjVqdzmBzyR6aoRhzY9so37erHQYxJaHEij7Df77XeTh5U=
X-Received: by 2002:a05:6214:29e9:b0:70b:ae8a:2e06 with SMTP id
 6a1803df08f44-70d76d4a609mr2360726d6.0.1755634609247; Tue, 19 Aug 2025
 13:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819192004.GA1058857@coredump.intra.peff.net>
 <20250819192455.GA1059295@coredump.intra.peff.net> <8797c495-8277-4f65-845b-167542b82949@charter.net>
In-Reply-To: <8797c495-8277-4f65-845b-167542b82949@charter.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Aug 2025 16:16:38 -0400
X-Gm-Features: Ac12FXy3d9bYmGkdbTyZDZ1tAX5DX8L4LuGizlqKQVt7dbkfHKdUDThdTIYmsDA
Message-ID: <CAPig+cS5CDA_yBkHa-nuR0jBg5yygwncKAs8yK_2civBMx1gVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] t5510: make confusing config cleanup more explicit
To: Eric Sunshine <ericsunshine@charter.net>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:05=E2=80=AFPM Eric Sunshine <ericsunshine@charter=
.net> wrote:
> On 8/19/25 3:24 PM, Jeff King wrote:
> > -     test_when_finished "git config unset remote.origin.followRemoteHE=
AD" &&
> > +     test_when_finished "git -C \"$D/two\" config unset remote.origin.=
followRemoteHEAD" &&
>
> For what it's worth, I have an unsent patch from a much larger unsent
> series which cleans up the t5510 messiness differently. (The below patch
> is probably whitespace damaged by the MUA.)

For the sake of completeness regarding the "much larger unsent
series": That series modifies `chainlint` to detect `cd` invocations
outside of a subshell and fixes the very many instances it discovered.
The series ended up consisting of 41 patches.
