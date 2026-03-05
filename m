Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEB366558
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752823; cv=pass; b=cDB+T1iz7YfCMrG1Ur9E7iHh6LBJD7nKv/5iLN38HAy2GPHgY6V/5vKSRY14+DXOupS23Uf1HpMdvTQ5M2EiNkdXlL0/oivB8ZUeqisXkMW3tYqYbtOqhVLL06t0L4z0N2ArDVYeqoaGXaxqmfiVcOJR0JSy0mKJdOp9V+bWXxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752823; c=relaxed/simple;
	bh=ttFV3GA/eIYnme5U6NmLKea/U4Gcjp7d9MoO4pq9R+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkTDxj3tNEKqsbJHdOXJl66zvdhwYycvW7qQPs97zMLE3xn4/ITJvAnu8NyU8VjyQSgqSDLC1Y2lmagUOYGBuZc1i9OYMBXkkHH2TSfFyyhLgP8TKCyPTFhvj2IKDhshbJDHJ9okAZR7CTJi6BFP91oz203OO9FJT8iv95vdxvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtgUt6RU; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtgUt6RU"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67a02dcc450so4697337eaf.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 15:20:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772752821; cv=none;
        d=google.com; s=arc-20240605;
        b=kkILRXajJQVg8SXMsPt0pDxQN7pKCilW6hoc7QLN9RjJujEbc6B1ghHQqJn2PaBAcu
         UpxkEB7Piwr3ahxxMDAgOAqumn4+dKjwEZNB+Pk5HQpVI5mFgCcsnZBASAkorUEIVFVF
         6Y/zFRuB9ZsQnQNjVJ+HVCSg065ndzQPEfPOBky5/tSgmUTzDr00tNtIQ5zWj9UXnp3p
         LyvFUi/L+Q7SbgwKFQuXNRuk6yzNGsk8+xp+ZX5ZIDvqz+DANr8vXzCR3bw9caSjTWnv
         sY3Jaj7nWAOLmGeTfeXYa0pSUy0fdU2l5vhZ2KRqH1fjArlDWGshaC3TXDe7MSaGmLgV
         OIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PK+SyWkb0G8WjhqooA0SbYUkg3iQDH3KKdazAIRUc9Y=;
        fh=BlokmVLgx8CRL8s9ttZFF/rEzt3qOXF+IDpsOh/L9Zg=;
        b=EEhfEaVkuE/DHKZPe5vnuWLzeQYOyDzp7VBo8jD3VFmwmRKR5ERKT/OQZh3jQhE0iM
         zls6q8Pv6JgJTLJM5cEAubRlB+/nEOf8ozxunReU438BhACcPU8VP0iGKc+dCp0JRLxS
         JWy3tz5vbRv1ZAnzETU5mzBrG+XwJ7Pi6RqzRA6Wxzy2uhLEQQyhRhzwemAsuL8+j3CR
         hRR6YJq0osj7ULIbOGUwSv4eLTjkszCtieXNxtn4uqMMl/ShNn1/67lXKFReh9Lf8Xen
         Fc8ax+L4k+7VPCdRXSvEbLBKexrEI39xsCv4kJUA5Eg/f2o1kp9LAre2n6rSuIkD530Z
         3viw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772752821; x=1773357621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK+SyWkb0G8WjhqooA0SbYUkg3iQDH3KKdazAIRUc9Y=;
        b=MtgUt6RUnx8lFzB/EGisslaIqpNTJtUw5RExF10q8ovWbZG5b7NfwABWYuEONgTHcx
         IbLhyFSLXY+M86i/xhgdopk3mgAZTKjOQ8usHIfnDjTVNjtgBbHuvH7LEmn00u2MYleB
         0oWotSctpCOomzKSoVlBcokAlq0xewdFZSDMrgeuEB9yKf9nRwp74b28Qx4relT2Y47P
         hE2aDFmDj5bRAUaxLUXi7nJ9ZvSKtLjepKu3Hfj+SZi1ia1O1FTNdwze2E1kmEuunHa1
         9QOMpbTsQkBs70eGIjWvu+iIkNxMN4zeOVS2jjnyV+aSPevi/Myylp8zezIIP01Ws1Lc
         iZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772752821; x=1773357621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PK+SyWkb0G8WjhqooA0SbYUkg3iQDH3KKdazAIRUc9Y=;
        b=vOM98fsPGziDmEfDVZqcBdl2nxUSJyon5OxQJjtCe5q2Kcqe9/VhWSmV34EqcidZY5
         A08ziWjFzSuet1+862cxEKA18JFhGfjwzL+6bNraF1TKtSRvB4147fNEdnXT5/J6DWvn
         nl0RssBPvLALEMAjanjV2CZDf4v0GR3VD7nQL99+YmlwifdwoTHvZDFeBOCdwS23b4lJ
         KGAPJtNMIm7aURSm1an1WlalHQTULhUFJwxeGwjvVhKUKeh+2kL7s7zw+TkVz2+ZBzB4
         hpJEgGggOQ4P/RD/Wd3Uz3jGG0tCxEByf5pJax3YZ0uVLDW4IuXL7kM2PMOSDoQMwRbY
         Xn1g==
X-Forwarded-Encrypted: i=1; AJvYcCXBX/AxJJo1tF9ryhQFhBszkXGMYyrDu+PSpLQmSXi2JbWRPB6ARel5CHG3JslwWjLEXlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoctQ9j7dhAnwkIRAGTEbDbO8Roc2GPTzXt1MqoKYwWLou0JOH
	bAoR9Xw+P+WqRQhrzvEqsnTZLYhRRK0JWfYGWV+uEvk6PfyKU9E2dbvQq6W64oGdkNgu9d2ge+6
	RInhEcNJ40ilv2WCLNLjQPeDSE5SYlC/p/w==
X-Gm-Gg: ATEYQzzibyzlNh7ZZdlDSpTPOzvdQ83A8sl0tw4dRSVg2hqxEy//c4yVrIB6p8awofO
	Pc9FB05haBfFRW0uN5b8X+PsMu7hUy8RC0XNtAjxVjYnrdwS32dST5Ab0PJj8ozV+oFIvdx2Cp1
	rf5dE/Q1FJwwXdoLMrXHO9RkjoFrorrpo88OfM5Pi2TrJv9jD230R7BJTj6QDH6HPUucqoxEwTH
	l+sb2BUB4mztsfVNpHMdR4VGFm94tfk2dB9/r0w9dt2YqxMBChx1Krg2W51LLXWkh5hjw3QSYTm
	Twdg6Q==
X-Received: by 2002:a05:6820:f025:b0:662:bfe5:92f1 with SMTP id
 006d021491bc7-67b9bd55d49mr168414eaf.65.1772752820908; Thu, 05 Mar 2026
 15:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305230315.GA2354983@coredump.intra.peff.net> <20260305230956.GB2901305@coredump.intra.peff.net>
In-Reply-To: <20260305230956.GB2901305@coredump.intra.peff.net>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 5 Mar 2026 15:20:11 -0800
X-Gm-Features: AaiRm53s-QHcQiklnoA-WNi1WBC_7kKZkKhevJL7IIQSmCHAQ5GfjpSYSVYqMhQ
Message-ID: <CA+P7+xryAanTArTc+iVkuHGSZXWZpUYjtHuu-umi15UDzpYFRg@mail.gmail.com>
Subject: Re: [PATCH 2/4] check_connected(): fix leak of pack-index mmap
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 3:10=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> Since c6807a40dc (clone: open a shortcut for connectivity check,
> 2013-05-26), we may open a one-off packed_git struct to check what's in
> the pack we just received. At the end of the function we throw away the
> struct (rather than linking it into the repository struct as usual).
>
> We used to leak the struct until dd4143e7bf (connected.c: free the
> "struct packed_git", 2022-11-08), which calls free(). But that's not
> sufficient; inside the struct we'll have mmap'd the pack idx data from
> disk, which needs an munmap() call.
>
> Building with SANITIZE=3Dleak doesn't detect this, because we are leaking
> our own mmap(), and it only finds heap allocations from malloc(). But if
> we use our compat mmap implementation like this:
>
>   make NO_MMAP=3DMapsBecomeMallocs SANITIZE=3Dleak
>
> then LSan will notice the leak, because now it's a regular heap buffer
> allocated by malloc().
>
> We can fix it by calling close_pack(), which will free any associated
> memory. Note that we need to check for NULL ourselves; unlike free(), it
> is not safe to pass a NULL pointer to close_pack().
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
