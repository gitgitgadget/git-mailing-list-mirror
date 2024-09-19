Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8723774
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774856; cv=none; b=gsysCoG6rivWupef3kEbCRtbsitp07bWVJp0WrSIuAAjav//MLrh+2eVXWKNarIRcDx3Wi149E5/kFX3AP9tND4my7xPPus8sTLphnYT17FxhW4ejQnf4Lg+8/5DhOkpaNW5xHeBaLYwwKrtRIORF1gtcb49RlF0/ZWYQ8vtY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774856; c=relaxed/simple;
	bh=lJbgFBGhgMdP4nn/oSs9qzrfuIzbhZSIYmm2GnO4h9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sE+IXfZaV8zP88hyDY90J8u/WR0a0er7yqKTE8wSaGfCSai7WCzDRBMcts4HJA806aZFCH5OyiHz+KPpRT590RRJ2uGdk/cKfDTFo5Uu2sKGcMkiMC9OV3y9K7ZOqgDzIqtJw/K5Y0idUbJSJsZZTvzGNaUMHlIVNoqaaQ/mSo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c3567b4372so1715786d6.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 12:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726774853; x=1727379653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T474UqucFkb6r/Hp299KUZ62jAchvvUKb3DucIMlD/g=;
        b=aI+M6IKBvNFDnfO5bNROaJ31V066b9nsW8MLINPKIJzMXeswIrjgaECZGZ1TWmSRvP
         J96FB/9knEQ/1twhylIjf3TmMonimTG8gZe9y4ApUFtJxZLrDzM0dj2sqpgiMI1iuo4M
         QfYXt2vKU12eQGCLVjwbpnARkeOJhFMLlCCVS5u3+2QxchN9+dhZ+48RXxblNNXyvzXE
         aGH/OIgAmO1ROfGZHSBafxJSbblUh6PcOSoUWER46iIDqsYRwNRzhwzbuAyCLER28bjy
         +xAIB3663/YHxiDa1QnSG/zQy90w0Uj6s30Rg5aDAJ44iyI/oIzMW1Kf4JbzDidNNSEO
         ntWA==
X-Forwarded-Encrypted: i=1; AJvYcCVngNLGhoJnP4M9+U0JjkGlrf8Hz2kUgExDK7dLK/964fVwUwmeEay+eiJ1cnxhkQJ5BeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkdUXw03n4gdtS25AbmlGtMO55V3870TG7NzF1QoiAgVMRlK0
	QXJHv5FZe0nqvaz0I5AQo9kzgOTmiinvki1DJ77ZqyhvZdPlFzWWd236Cm4R/ju4ii2TRwzk+ie
	qrhVkGTJ3Wx84frM37VSJKkGuKGE=
X-Google-Smtp-Source: AGHT+IHYBWRBG+mg75M1RLZuOSMS6L/UEunP87UbjznVOwrmhtWsGNejF7nvSJYi3Sy/YJcHaU1ZdsQ3607sdWDKGQ4=
X-Received: by 2002:a05:6214:2509:b0:6c3:678c:b37d with SMTP id
 6a1803df08f44-6c7bc62544bmr3138016d6.1.1726774852892; Thu, 19 Sep 2024
 12:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
 <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com> <CAKDm0rMsXUpFSWRWkW0J0FUpEbot6wQqdzYTT5CLZ=3TGbV-OA@mail.gmail.com>
 <467f6fb4-5f83-416b-bc09-572a82f210ea@gmail.com> <CAKDm0rO6H4RTa5EXMrNvSy2swVegHveasY1koZXF5V7HvZzK0Q@mail.gmail.com>
 <xmqqsetv795s.fsf@gitster.g>
In-Reply-To: <xmqqsetv795s.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 19 Sep 2024 15:40:42 -0400
Message-ID: <CAPig+cTDFcJiig7=Sf5vxsgzc8_ax5t7Vqy+-_x8OK_U5U6Qnw@mail.gmail.com>
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: Junio C Hamano <gitster@pobox.com>
Cc: Matt Liberty <mliberty@precisioninno.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 3:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Matt Liberty <mliberty@precisioninno.com> writes:
> > Yes and also to have a 0 exit code.  No error occurred from my perspect=
ive.
>
> I am sympathetic to the line of reasoning, but I wouldn't go that
> far.
>
> Running "yes | less" and killing it with 'q' saying "ok I've seen
> enough", and running "yes" and killing it with '^C' saying "ok I've
> seen enough" are pretty much the same from the end-user perspective.
> You told the command to go away, and the command complied.  But I
> haven't seen anybody complaining if they see a "Killed" message or
> "echo $?" immediately after it says 130 for the latter.

Regarding the exit code, it's not even clear how that factors into
this discussion considering that, in the presented example,
git-submodule is upstream of a pipe, thus its exit code is lost
anyhow.
