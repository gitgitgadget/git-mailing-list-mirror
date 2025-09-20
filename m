Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7720C488
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758345064; cv=none; b=Yuw6xG/o5CGtHOHxOa/FNUszEtDH+CuisJVAGD/umBPpCN6Dj/pqoHdRBKVY7gDRdYt7TvbUQ9mmhXZ6SWkG19PSvSKWFrqpBVzdZY1mtoookYqT3HhAFpTLKZ9lbVQARfDfiX+mdhwG2YKgjbSz2w0bJbiz9l2d2maJmYqysOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758345064; c=relaxed/simple;
	bh=a6N3B/8Xj4bC5h+SGmW7FNN0BFEX6U5MSHIlBEl7RdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpuGLI0+Yb9G1FG2jBwxjCpZvxvQ9PyljbrNpxh2gRxS9mWQ+NJQP3mOoZ3IGj26l8rEsTcLXUNbNmOvxn17naauy2UssrdZYq7lEW9TYryjvabKvUQskW2vObjqS5leWNQ03lSQ+83qlA5dUoBKENib7fHmIILsu6EWSfow5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b600408e9aso6218361cf.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758345062; x=1758949862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6N3B/8Xj4bC5h+SGmW7FNN0BFEX6U5MSHIlBEl7RdQ=;
        b=cqeTAJFjdi5M/lMYG3QbolyFupyUl+l6c0nnw064S90EteHTLFxskM8qO5nn0lruWG
         rfNiNE8MbQYh5EHMOR0KgqCTOs/TCRVX0xk7LKWZQ4hqc6tAjcnt2cxyqDm5tAM7WORg
         tC4RLf+DxwbxkwrPLGxE9aI6gQNfM+JkiobMAjd4QGMvLFzBKXUrOjDWdYlGtDgrbcM9
         J13OTAMZBiFDTj36LBYgGLkCqeywTSlkymviHqmwmprB6EzbgUfq7x6jcjvaYtrYQlN1
         npVHng0Wt/qNTHawEMZQmcomaWq/OC30eRjkuGyY9LCpB0lPSy/tQashxejWS29qPgcX
         P3xg==
X-Forwarded-Encrypted: i=1; AJvYcCWUlg2rAlQ079DmqZaemA5kOXNSVzXSt32j/BT9oPdg/guMCaPoZuiHePWbNG7WBKVJUXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15s0v1K2TOOpOlyi9byPJmw+G6j7T146QeU0lhxlxM7tibMLO
	hXiWPy2TztNGHDZJg4mUoY0e220mNGIJnlpCohjFzJ+ZqqcX6T+Jy28QXVC99f6PJfPqiRkNM13
	uC+XzgY6MFRYcL9jcn1GaxLashteemgdXCLx5
X-Gm-Gg: ASbGnctxIx6F2gJOgTZLKOfVLIiRRFXcJGpDGixNLnnCfLI9tibs9Baw3dD3UVbZgc1
	yn8RHoDllXw51BczttGl15ox+nKbnI4TUP/HoEpCos+XEnmFua+6h4TLYR4HtA7mDtfISjGknWS
	IWPKardJdlLJFSSwPqTNsCkPYeBFge870XRQuJp7dq/G8xwuSX0NE0lx+lhn5V82WeFHyC7OaIE
	HGwvmz3NJqjRozyQHZCpGXEFC8Wsz575wtBGOEATtDifVvSSm8=
X-Google-Smtp-Source: AGHT+IEGCq1G0v7iYDPSKNgK2OXHa/wyWpj3JpTLCRNjXvDaIrnMBQlGQvAUrhE2xEWwghuoMMgy7kH+JgRf9bxEADQ=
X-Received: by 2002:a05:6214:2262:b0:774:48fb:f8f2 with SMTP id
 6a1803df08f44-79903fc9c10mr50440026d6.0.1758345061551; Fri, 19 Sep 2025
 22:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919223351.GA3906184@coredump.intra.peff.net> <20250919224847.GC594545@coredump.intra.peff.net>
In-Reply-To: <20250919224847.GC594545@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 20 Sep 2025 01:10:50 -0400
X-Gm-Features: AS18NWABNP58xAbzoSTZa6mipPk4e5NppzW66cQQJeSimc2YtL8bnUHKLa_pjVA
Message-ID: <CAPig+cRSQAs79oVmNqvfqhEr6K3T1FR13NwbE50A5CCMJ8RqSA@mail.gmail.com>
Subject: Re: [PATCH 3/6] revision: add wrapper to setup_revisions() from a strvec
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 6:51=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> The setup_revisions() function was designed to take the argc/argv pair
> from the operating system. But we sometimes construct our own argv using
> a strvec and pass that in. There are a few gotchas that callers need to
> deal with here:
> [...]
> We'll start by converting all of the call-sites which the
> free_removed_argv_elements option. There should be no behavior change
> for them, except that their "shrunken" entries are cleaned up
> immediately, rather than waiting for a strvec_clear() call.

There is some grammatical problem with the first sentence of this
paragraph which makes it difficult to decipher.

> Signed-off-by: Jeff King <peff@peff.net>
