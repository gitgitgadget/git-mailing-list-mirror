Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3B24BD0C
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846210; cv=none; b=ojHHO3dDAuYPkCInrD0owB4UaPOzRX11IQ0wYTDgZFDBbSaYGCi6mAbUAWYOIg9vLePYszxUyEyW4xCFYrZ1JRQ3zG9yobD1QOhIjTVah82/UQOlVGXv7iNhPtWfDvKn2b8/QdopgK9nK4hEivG5wY1+SGupgE48kCfLtKHv7sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846210; c=relaxed/simple;
	bh=ryJqUTC15UXWw0bIxDmGnrxJoWPwdBxuyZP9d0ID8Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZy5nQXHf87R7CpQ6verSDod6uiyIhhHLiu5K3Qe3l+HVvIWfgI4ultDADxuOJuuPZ8rYElWZLhwwpZ5wPfMQ8f5pMOpBt5qTq5+I03GhK/6zyhNhGH06+oF7QQvBh0dcsGl36E4lT6arMfz8MJ/wjQ2TxRQmBoYvGK2+UC2/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7cee016d9baso29857785a.3
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 13:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846207; x=1750451007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMpKO4oXO3V8gRz4Y5wwX4T6aKwRlefjW8oTr3o19WI=;
        b=Kaps8L8uAPDNu7r3JNa6jlbb1pE5knkLVFSXpb1lnaZ8UpgdeJKnTCiOAfEfQ7a9mK
         5aZqWSwPIjWycBZ7ku9sOO0YgblGNPxVn1OIXzSdt1rmb4hGT1Rebx6EzPVRX9KHzWlw
         9LBQgwtsWiDm2CtvAnFS+ClfwbYsRvKos7Hf8VxacMmiViEkt1/kcz7zoebhAed3YhRx
         /15FPembif0l9vDP/uifGN+Oz4gmcehLysvTvN5Et9fe/tJVicmEjHwXMliBd00h7/XE
         43A22P9kMfrkuUPrPTvvtFZWejgcxp7kD0G5lN17S3vn1CGTODF0guPrQ9LNui59Mv+s
         YSOw==
X-Forwarded-Encrypted: i=1; AJvYcCV628pbC1unVvaeevh7DH2fdNsIsK0zIy52j+v/nklZ/zpPefFgeqQ6qPsqBSaOmMDFUxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0lc6CIli/waJRZJijcnEeTM7XDCwEebmHzlULv+6CubtCaQn
	AnsIa3tVkGI9CFGxj6xXSfQKwHj80Yp/hZHcSKQnHeZRTUfLdTlZSdIgV/U5hUgEfKVGe+XwZxl
	x+c819wMtPCTdFJBUAI0WS8tPEy7MCgA=
X-Gm-Gg: ASbGnctfGavmR7Y2J0MCmYIAPShqTX2FqicCCh2Byzcdwe0T3lVrhD+ufT4NIkVAHNX
	WI4Oj+3c16xvcDXJmEy+83sxpnHFd0F64rI22/Xx9CxykJ+D44ODf8odXH4OkiSSs0KW+2YHAjC
	xQJeV9o6l3wsLdu3WwbK/bZuKgqIn2L6nPqIJUAlAimQ==
X-Google-Smtp-Source: AGHT+IFs+jWEfxvPiUt/sBZVpyargHaFtPAkbLztjTcrlJA63rVY6FHxsb+BEpeTotQrGwwLV7zY/XWBIXBi7l6RWfQ=
X-Received: by 2002:a05:6214:4001:b0:6fa:ed19:2566 with SMTP id
 6a1803df08f44-6fb4775424amr4675466d6.2.1749846207322; Fri, 13 Jun 2025
 13:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
 <caaa5d54-d32d-40b3-9bf3-0f322e7c4316@comstyle.com> <874iwlegmg.fsf@gmail.com>
 <5895400.DvuYhMxLoT@cayenne>
In-Reply-To: <5895400.DvuYhMxLoT@cayenne>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 13 Jun 2025 16:23:16 -0400
X-Gm-Features: AX0GCFu3SDRJngDtocN3jrqM8hI8xOnVKgCE0p8OvtRZnaZ2Shvck1s2A3_tjEM
Message-ID: <CAPig+cSu7+fxveULiB1vDbcy6Cnia_5isVVy+RCO+HGAyr8uvg@mail.gmail.com>
Subject: Re: Solaris sed
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc: Brad Smith <brad@comstyle.com>, Collin Funk <collin.funk1@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 4:15=E2=80=AFPM Jean-No=C3=ABl AVILA <jn.avila@free=
.fr> wrote:
> Would it be possible to set up some kind of CI to check for compatibility=
 with
> such systems. This is the second time I introduced regressions without ev=
en
> knowing it, and it would be really great to catch them before borking a
> release process.

Had this been in a test script, it would have been caught by
t/check-non-portable-shell.sh. We may want to apply the check to
build-related scripts, as well. For instance, it would have caught the
-E problem:

    % ./t/check-non-portable-shell.pl generate-*.sh
    generate-configlist.sh:16: error: sed option not portable (use
only -n, -e, -f): sed -E '
    %

You can, of course, run check-non-portable-shell.pl manually after
editing a script, but perhaps this check could be enabled by a
(hopefully) minor tweak to the main Git Makefile?
