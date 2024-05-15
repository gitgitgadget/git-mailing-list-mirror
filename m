Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BF14AB4
	for <git@vger.kernel.org>; Wed, 15 May 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774238; cv=none; b=MU3FfAjtGn70BoH9LwJIZWP77L23cQ2eu9QSMa2OzkRlcbNTmlklGwvrh14XhULzfbLo0f2Yel1Ydn/EpS8gQDIZHMufwirgoOXaPzsh3AEb1EmgPVY4D24keq6aOj8TUrvrmU+0gTWrNxO+DYhPLlrOIFeRHpeLC18glrG+jfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774238; c=relaxed/simple;
	bh=VbAIaomAl4Zugipf2FU2hInoaQq90GIHs9/TWKuUAuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETUsbNY9Clp4GtcVQynmKYM3Xpx/iA6LUHMcciv1HVW6fAPIEU0zXoRiUM3JQBeh6Aw7+8iWvvlDQY6O6i5FwS+zu6BUz2gIcpSbSyDshAcJI54SHlyJ6idlyqMbK7Z1u2TGrA4y9VcVyfrDzdJoOD0FlhV7Pvnw6oDxzDzeTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBLKUshB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBLKUshB"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so7352517e87.0
        for <git@vger.kernel.org>; Wed, 15 May 2024 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715774235; x=1716379035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyhhxoFQdOmWwQ3o36/D7qVJeqt18FCxSPB56ZWKiNQ=;
        b=bBLKUshBoD+KNNQhTOCslAsmsLl80nTCLvJ4gC9Q5v8Jx/I2KbKBWHeDRrzFQ10ODy
         7MVapfhbdrfLSrBCvNS3kUWITpTmYZ8UewT+MJEpJWBNqZuvO/9I1VClkvzgR57s3h5w
         sD0INlcpZa6QcmoCRD72TkbGdnN+Bg+hFpeuWjFQvy4Y6YfuZM13zQ1MmhFFTR2LuY4V
         J+E8cak1/BHgQq+6u4WK/DDe913J5Omc6lCqQOjPACJR+7l0PcBS2tbKETOJZsFLcjAx
         7ofm7ORi9g9jHHqGMjkoHVDMDBqiGa9XfzzepEF9HhXPOT8+byoHBVsEkPUR4M5OVBLN
         6+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715774235; x=1716379035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyhhxoFQdOmWwQ3o36/D7qVJeqt18FCxSPB56ZWKiNQ=;
        b=RbE0Vthy6IR1C/XE+XbyNbXVRwcgD2k7jmfdfcpo6477LnKwFxvmwObftTOPVhxYUk
         Qmp/ODu74xWqJVBMvikbSxudaqH5d+lJvUj+3DZbptKC4ao0R62bO3bNuo0+TjQKSSuj
         ZPoJp+1qu1Hwc5HMKxIb7klJ26tSiDE8n3WhAEpJzEjeQcH+8BwMr8Nr1lPCcyp9dfBQ
         q2QTbZEcTMfcdGx/4TFS+DKxY8kMuN0027PcGCwD70fzy5nDBQ7dJRDD+dB4rOAMfyFD
         UyCz+iLPUR7pJG3RlW8fhbif8+Hp/+Lhs3DwKMTqNzDY2CGaD0EwwgYqol0FM/O348ar
         Zmvw==
X-Gm-Message-State: AOJu0YxWhac51bSAi7pTeFZ0AezlMQxy9x6Qhw4KoMxvq//5SKP3f/AN
	7oQHe9WBWFjr4bKfHFBCZtnzCVBRsD7dwo89MjCzgOyUAix6+WundL8gKYFRjMghq0ZT9RYkpvF
	lmo2JbsEQ0ZF4j2DtTFCXT657a/Q=
X-Google-Smtp-Source: AGHT+IFDF2fphkgqS3LxdPL7V23gShvMk7DECfVrTzyUUjl5Cg6tOYtoPuWcpDJJqStsD8n6zGd4hDkzmiDS9xZzEXw=
X-Received: by 2002:a05:6512:3b07:b0:51b:de3a:33ac with SMTP id
 2adb3069b0e04-5221058453amr12783661e87.59.1715774234681; Wed, 15 May 2024
 04:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcypo47p7.fsf@gitster.g>
In-Reply-To: <xmqqcypo47p7.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 May 2024 13:57:01 +0200
Message-ID: <CAP8UFD0q1yBm4aG6pmByOxMAvYcbmwfAWkSK=nyCoAAY3qptig@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2024, #06; Tue, 14)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 7:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> * la/hide-trailer-info (2024-05-02) 11 commits
>  - trailer unit tests: inspect iterator contents
>  - trailer: document parse_trailers() usage
>  - trailer: retire trailer_info_get() from API
>  - trailer: make trailer_info struct private
>  - trailer: make parse_trailers() return trailer_info pointer
>  - interpret-trailers: access trailer_info with new helpers
>  - sequencer: use the trailer iterator
>  - trailer: teach iterator about non-trailer lines
>  - trailer: add unit tests for trailer iterator
>  - Makefile: sort UNIT_TEST_PROGRAMS
>  - Merge branch 'la/format-trailer-info' into la/hide-trailer-info
>
>  The trailer API has been reshuffled a bit.
>
>  Waiting for a review response.
>  cf. <a75133dc-a0bb-4f61-a616-988f2b4d5688@gmail.com>
>  source: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>

Linus replied in the following message:

https://lore.kernel.org/git/CAMo6p=3DFS3ShvBdutprWBiAVef6A1XjsXB1UJSQBk0s5e=
uN=3Dtog@mail.gmail.com/

Phillip then agreed with Linus that the improvements he suggested
could be done later.

I took a look at Linus' v4 and I am also fine with it. Thanks.
