Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B521FF40
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992963; cv=none; b=suzDYbWEas8nRIUQt7GwWb38A7nhMYGyzg89V+buiJMAPs3nHNGbaiEUZOgBTwK8mGX/RpBk635lb+kf34pXXXl5nkRGeMdPuActnOrZEI5MblGDvv6e0Tq4vM9TTMqNjClmmPT+7feO5+5NfGiHv8CZDv5KYRWNjmh/xPh6nas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992963; c=relaxed/simple;
	bh=r1/ogtFMKTTi2Fp1aiJDVEOPkFH43mfG236cHcRTWCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWmEbmX4VhV++RJYE5CzFDTTG2NXLxisV9C4AB1B20s4MWGvYYBnJsvSZq8e1++g3CWXZZbbCWd70JF+7fwCvmLWGeKh/o1oS7MQOlkDz9l0eePFQ7ntCSwstp3Zc5xBV4aPkCUlnLubA4dxQeZtAnrhfFGn8uoC15J+cXSTv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-707504f050cso1877926d6.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 13:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753992960; x=1754597760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2VB6h+JN/UA7I+DBFXjQqGYnqRVF8/UN6s50Nh30DE=;
        b=oYAXImTmNb/M8AQPILL/cgpw1P+HWzQp7cbKTNCU61emLxeF/GSfOnKnTIRMmYofPh
         lMvO7D8VdiK5rzjTzQxjFnZJS3h+frt+eY85ihJ2/wUfdyF3kxrhx0z+6HCHe8ul4Dp/
         KzZb4jwt3rGLwnZVmcGuLeAyia8F6afc9iKoKDxuDgoybuiM72m1W1+GoHhkCuvOyOX1
         OBFrQqt220hk7Lgj6QKnu2tL8xYwbXmSrFLyqOCUR85IbeVXIvhsHK5XQOpKO0KuSERl
         TU6ok7j36esr2AI/L4qgnN7+2l3V2H0a6RZA3ySV0o36MmIRad94YkrqawnXVI5+olyY
         yipg==
X-Gm-Message-State: AOJu0YwkUG9w7h+ondlqjNqYkM9Ja0NpnWwGRmZ0Vp0Qu221aXyLSXLr
	tts6hciQMqypXIOkQ7F7MTXG6r2/ylpES11m6Cl2TRn2WvePOglFxoahTvSOeC1m95IZ21MU/Nf
	AECjjtc7qGUNKSqFl/wf04g5aqaQUpomK/LKu
X-Gm-Gg: ASbGncsu70BFRsfkGOAnc9cI/KpSWrKO3VcNaACvQqI96Q6N3U3uTqUHyaK9jYUtzhh
	a3izfyh3kXeQs+v5pnFe8++TyU37d8onocWysDKylouMQiEYro2ojdjW29urgJ55GQGHTC3NOSk
	rPq4oRaKq1ioMGxS4BsVZVZfN1ZFp+azE+YIaHKBY4jUYdbMj9f6zacYMJjVBNBZkNrn1UevKMO
	hRehsOzLTaevMLzVICUau990Vt8Xk/WIh8B1+Q=
X-Google-Smtp-Source: AGHT+IFtzI55OPhZ+iwIm7+3fPhjyGYCbwQSQuKVb54zmmHx05flk8Lcz65DZgGKlTVCli1TC/4Uls7Uz2UhcosEL5g=
X-Received: by 2002:ac8:7c50:0:b0:47a:e81b:cca6 with SMTP id
 d75a77b69052e-4aedbc3e4b0mr71699051cf.10.1753992960548; Thu, 31 Jul 2025
 13:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731074154.2835370-1-gitster@pobox.com> <20250731074154.2835370-8-gitster@pobox.com>
In-Reply-To: <20250731074154.2835370-8-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 31 Jul 2025 16:15:49 -0400
X-Gm-Features: Ac12FXxddvuzljb0lumdqD9uvQxLH1-nMJCU6NmkMKtwhJR94HvaSm2pNWSDsA8
Message-ID: <CAPig+cTnNeZ9gtQbKdL6P2KBn7jzGJT6BC+tPMnzBNaR0tyrvQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] config: do not use strbuf_split()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 3:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> When parsing an old-style GIT_CONFIG_PARAMETERS environment
> variable, the code parses the key=3Dvalue pair by spliting them at '=3D'
> into an array of strbuf's.  As strbuf_split() leafes the delimiter
> at the end of the split piece, the code has to manually trim it.

s/spliting/splitting/
s/leafes/leaves/

> If we split with string_list_split(), that becomes unnecessary.
> Retire the use of strbuf_split().
>
> Note that the max parameter of string_list_split() is of
> an ergonomically iffy design---it specifies the maximum number of
> times the function is allowed to split, which means that in order to
> split a text into up to 2 pieces, you have to pass 1, not 2.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
