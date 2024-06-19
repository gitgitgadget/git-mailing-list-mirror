Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CCFC0E
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718764532; cv=none; b=pTrDBK31cGhsa56o/hV3cKZgcoRTKP6NN9StfLVpwbh/OSbQ74tlmkcgQSTdwtKU6oqM7WvQ1EO8kMVUuGaLOq0S6yU13SEMwpcD5uOsSdKKJvan6nMr+/VyjR7dWzFyPgFustYVKar4DqIlPasGfubh8dHG9mr5XPmvdVWe6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718764532; c=relaxed/simple;
	bh=7/+BeXpyxTJYqmrpvh/n4wpWasOEimB1+lqwL6wTgd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQNnsXRAlB+B0cIEQPy3WkHNFyy33e0bNX8jIyLWhZjNr46ES37aX/4Pf+jlg7bgqkeRKlzH+GiJ2vt2wUgjz67+VlZ1L90x2E5OWKXBLHvv+17qcsSl7VVJdd5Py335yc+3iCjmL6sQb5mv3fjOUKoA/Sr5cNrme5pfx0cOifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so28229296d6.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 19:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718764530; x=1719369330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEfUVOXjzKcBSMdJl/XnYYFXMKz3p3fHW3iVCgQwGEc=;
        b=su+si7+7hFYk6GQgXrWsMsFFGho0sS6GtEohKhUMOrIOhakhuHZk/BuNKY6u4m5dTz
         OpcYgTwXr65mYCynQRGJtRQC2d6+rBGAEExIomPLZQ8etKeZOkZBGQQ1TMMAZOsudeMB
         DBoUY9s2FNR4QWfcxGmIZ9VYigKZNEOGzfWaDHKq22fbDRpV7pdrkknc+MMXrRVlQciu
         KoKKMXM0c4hfbRp34d3A61kDInf6dfjQ7yRVHhLDQDQggr871Mj1/mmvu6lLAPlBPORb
         Q5caQOonz2DuPn0/RSeTOGKoBACUBof1LbDq95KDFBWQhYuk7UNrCEHUvmV7z1uorS7F
         aKsA==
X-Gm-Message-State: AOJu0YwNteSsNVeoLqS90XfVK9TNYi5N7HPNfKitH1l4o2RuqDK+1U5w
	RyD96MR/KXGNImVk+damqGyJztabyr+r2trtTGuvAmKO8jmKzX07gVRjgaNwhjsxThKqyC7+Gb4
	uv25b17E38a+/luFvUbTON4yvZnE=
X-Google-Smtp-Source: AGHT+IF19uNyM/kcjKnEMC6a+Qw0o4bZVusiS9YwwCOpnQLm1Sg3b+KpjvcUADgyE8npp9WuzHdKxcYh+s+7ZOTKPBg=
X-Received: by 2002:a05:6214:16c5:b0:6b0:774b:38c2 with SMTP id
 6a1803df08f44-6b501df89demr14441426d6.6.1718764529667; Tue, 18 Jun 2024
 19:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618233303.GA188880@coredump.intra.peff.net>
 <20240618234436.4107855-1-gitster@pobox.com> <20240618234436.4107855-3-gitster@pobox.com>
 <CAPig+cQy2e54Pjiu=7xw7Ox=OyxmFuoW6MU31JXXuXobQ_vvXA@mail.gmail.com> <xmqqplsdybkh.fsf@gitster.g>
In-Reply-To: <xmqqplsdybkh.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 18 Jun 2024 22:35:18 -0400
Message-ID: <CAPig+cSHYFbTAf_XMucaj_+=84pc+OiBVnyRXogOGTUYfZHFEQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] attr: notice and report read failure of
 .gitattributes files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > ECANTPARSE: perhaps? s/errors/& be/
>
> You're right.  Thanks.

The same problem occurs in the commit message of patch [3/4].
