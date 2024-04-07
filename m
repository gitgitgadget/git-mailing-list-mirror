Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08C80C
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712457776; cv=none; b=c170kV07bsxKvFUthI8Pbba35AP4zaiakVJMHIsoB3RYOvOr705ZDBiHUCzYZI8qJaXGxpxRaZfYmbmCpC7ZP0mwVswhhHzBtDa8Drbg+quDtimjDCJkT4qbgEwongG7QiFBGE0Uw6jYgwJdSAL/Dv5STSjVDqRzhZ9JI6mbAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712457776; c=relaxed/simple;
	bh=wJ388HOLChspKjKyFiYlH0EUR2gt4CAhXz6wQQg7cKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lm0QjPqgmzLfpLJFQ1RLBN/ROYuCYM8VwrKSFcCo2/D3SVL6asTtwDnHDawdCMqCNZV61ms86+t4X5CFRovc1elWWLWWWF0IrYZbBw+6DRcW+p+wRUrOJ7NI03A+AWL4a0LnSlZwa3jIEPfpDaocVpqWXwpLrAbGnbYCr8lVRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-696315c9da5so26862236d6.2
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 19:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712457774; x=1713062574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJ388HOLChspKjKyFiYlH0EUR2gt4CAhXz6wQQg7cKo=;
        b=ZKSwAeTQbaRP2ssRaDq6xZ5V+7e5vAq4dL3MZhRSHTux/4R87jcqAUbYj6OEOeBcDa
         7iODNZ9KKubvfWc9VpKbvtKtLkElWq7d2C66YmVd97qTY6Ci6ObaDOEhu7leoO4hFSNg
         anMgqPLWZ1jGGg18ZLvB3rrXYsRNejVL0vpkvujySGvOACtu+lzaRG0VY6F95PV/xtXQ
         vgRoOJTdydEFD+X0lu/ivdXqACjedyieqUw8WfKo2FIFuMCW6N1aznmbChjaqewgRF8Z
         EpHUB58UWqi/oGylWhT7cDUzCq8hbGLgGiM6K+bThMqqiKv0P8uJLbExPA7nfZ9EJc5D
         pmsg==
X-Forwarded-Encrypted: i=1; AJvYcCXRqCtBs6LtzjTtokiqW/y+3Xl0Y6oXbqZS89l57HMpmwzEA2nEi9UEc3BKBPMVGvzbkS2aJpaH4PS806k/XyFu8vSS
X-Gm-Message-State: AOJu0YzM0ejETthJW3DsMuPVkvr6q9IiFYNNe7QSBy2bpc3RMqXrHMsu
	hauqlUqkqlnmtdFFWCbxlqSIytfHo241bBsHHsjyRuzaTVKqufJR2vsAGXc4w8b0hkoeJC5WNCg
	KxCY3h0Q67wzg3Z5R59SmEp6apRs=
X-Google-Smtp-Source: AGHT+IFtsdRIC9uFcloQpXm/fDSmrpfxlCyQV6OJ+mTu5Ou8sPqEFyvRdzTk65PswvsAOlJX8+yLhZhNY9W1VYRtBow=
X-Received: by 2002:a05:6214:d43:b0:699:2c32:d98c with SMTP id
 3-20020a0562140d4300b006992c32d98cmr6077993qvr.56.1712457773739; Sat, 06 Apr
 2024 19:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407005656.GA436890@coredump.intra.peff.net> <20240407010704.GK868358@coredump.intra.peff.net>
In-Reply-To: <20240407010704.GK868358@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Apr 2024 22:42:42 -0400
Message-ID: <CAPig+cTj=_1JAvCr-RWtZT8nZtccGYmrPgcAARx5XMGZso4BtQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] blame: use "dup" string_list for ignore-revs files
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:07=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> We feed items into ignore_revs_file_list in two ways: from config and
> from the command-line. Items from the command-line point to argv entries
> that we don't own, but items from config are hea-allocated strings whose
> ownership is handed to the string list when we insert them.

s/hea/heap/

> Because the string_list is declared with "NODUP", our string_list_clear()
> call will not free the entries themselves. This is the right thing for
> the argv entries, but means that we leak the allocated config entries.
>
> Let's declare the string list as owning its own strings, which means
> that the argv entries will be copied.
>
> For the config entries we would ideally use string_list_append_nodup()
> to just hand off ownership of our strings. But we insert them into the
> sorted list with string_list_insert(), which doesn't have a nodup
> variant. Since this isn't a hot path, we can accept that the path
> interpolation will produce a temporary string which is then freed.
>
> Signed-off-by: Jeff King <peff@peff.net>
