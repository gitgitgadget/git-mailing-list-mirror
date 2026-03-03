Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD86390985
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533877; cv=pass; b=UnQ+yv4cC6a3SPs9WlbtOtFAkGQXvLNnVw9feYOQoKmzc2Z1eaQvN098eqNgST9uGyHCeWrE0Gyq35JKHcXB8feV4pgKOmhL+JWUIoqZxkX3Rz4eWTTPAbmhXl5DCSbdbInnyvqH3ubYiV0IIv6FQhX5OZ/zmq730Tq8vuZ7JO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533877; c=relaxed/simple;
	bh=RDwzjr2CU38mbvz9BXFHIT7FCtZcAeG7bdbwa7WQjHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFDtNWGMvrDy62tHkyWNvx3ucJHDu94bwJ/la9/VcUBtWJp4ws6W08kfgl23Or0B6vYaoTXt/PG3JwCC5KuB6zJjCKUvxohkiK3ux6AvZlbZsovltjVA8TR85IM9G9x2HkWVxzOztoU5Y1F4Ubud9R+gpbMySNadGaTAmXC8Ml8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEOZJ8O5; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEOZJ8O5"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506cb1b63d0so66859941cf.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 02:31:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772533875; cv=none;
        d=google.com; s=arc-20240605;
        b=ctMcW/9z21daIfqqPHljj8J2zbIuABxN6WPZ2p1yMqFMiamMu8SsqZUK8aqD4m2S6H
         whji7XElFpqKmUUnldwPCPphfd8VdAwcFDLCWFtHVRRZREORXpEll/mmDDWBM8xeeqcD
         9w/ppaBmvUMeE1UfQduRvop7Izh9rijZ1I9QIRlax73ftHT+hPsbe2J9EtUMGZoUXHYv
         JL9W1JtjL1z8brJ/0gKHLhEUUKabhfLQN22vaflQyvuTm49BVV0lLlyNptZhMSyPj6Is
         QgvxbxSRMR54hGVyox5Ilj9fQXlJiOht4XwosAOUnyG2REXbwMJ9xseS2Eno2XpImTsz
         17XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DvL0mxvjPwR+RmH5z5cJ1eMcifsWj+x6nKk/FO1ojQU=;
        fh=Uc8Qyfa26QQtNfjAyy5wURzfV0QAg/r5qW26X+bxfcQ=;
        b=UFY7bXsR0cJpUNk5WCTqW2p0ywRJVg+pxmrwG5cBi2Yfh7df8xaCwHgZcv+yZd+qgy
         Uy1eF4dIv1HLO1D54cPXAeWl+oLjFEGwjt6o8WbiM3+VlfBG3kiMUa1g169D4vkrE+Dc
         hVvQxYyEOql0IyEAKtMCAyOUmrCQyAq6HMS2nENYl7qp2oaSAJUk2I1V9jjXiYiP/8lo
         LkPpgKLwPyjxhMdSo8Fx64J2pjLwi+CGac+h1UqtKrxzQ4aMXi9Cu7F28rdF0MT1V0ea
         I3aY/8eKerbj5aEhi9v6VoUxLjm8d3HomVOoKA7g+qifLQ150em+iZYmjEQ6fPnj6vnW
         3FBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772533875; x=1773138675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvL0mxvjPwR+RmH5z5cJ1eMcifsWj+x6nKk/FO1ojQU=;
        b=WEOZJ8O5MndQJPNHwztdXb3R4+fo2B6PTUPtG1hBPr8DeePnEh8VpLuK1qMxp8Q3Ky
         TjpWrAlrEA7J4yNgmKBW6t96weChUsAm8jYFeGiIgz+U+aGwkK8ptWmXtO37vBHaoBhA
         c0Y7SLFkP3pZhBfBSoC2DGrNwBM+XCrDjzasqmieh+ULHRRKGiun0Jux/tJ+74kRK3Zc
         OaWLV6xWbUwj2V4Jw2loifYT/QQUyewfBzoj60QGdNKEuC5Fb+j5xehIJxbf8DWB1KzK
         QRFFM9kCvLZjYk610xpHhTSHrOmZtUHtLzn7/z05hl0qEW2pJMCDxwAEDlwz9aDe0AEc
         lI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772533875; x=1773138675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DvL0mxvjPwR+RmH5z5cJ1eMcifsWj+x6nKk/FO1ojQU=;
        b=KZgkKlMCyrAPBPXXE2Cn0BYO2yDuy2WrRr1BEKlBAPqdwf++b4llSqjyMDGhW490gz
         S/1arXjN1DY041TOK4rhVHPW96mZnchxKMPlVqfciycYNxem4XpLBIwq8ShotjrRRZEc
         ty5sWkGBU5Dl3FMKu2eUxJs1t059cR8Hm//btsywFAI9q82rTuVB2VRzMgxlvYRA/JW3
         G9ZbcEuW+OUZmJOtFi9Zx2GttXFGgPIuCpug38iVJRKlkcT8iAlNMAUj1ie3TVvKZQAk
         sDgL6UNR9exCahjju9wQrMBg6wmLqEyI0k9oeUlMsnygeZ4QFnuUJW1VuYTDH5Rx+eYw
         B2qg==
X-Forwarded-Encrypted: i=1; AJvYcCU7xzN7jWQcj4LUuhhBTVrURX+qjLxTLw6PLIbLwy3zgZXnTF68ubHZorZCiOYwL2LWLxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACF3Y+1QPPlJjicXzfM3X+eR/VwplbTP1VE9RSir1N3zqhEJL
	TFGjef4uDeaYHct/BaAOKuHWLrkVJaDXGIh0dEpVOQ/WVYpGvT2SGbyYbvW6OhwecKZMcJPVf29
	ch/T3twuxZa+9NoMXuhEQ2rYC6pbPx8M=
X-Gm-Gg: ATEYQzzT7GWTWdkWK1pIVh9YZDC2AOnsouiXazMPJaZGaPAQLhZvmw5wGFRZVzegUoT
	Jy0rXjV0JWHIkns2aZCkuyxVOTPKAhk4ZHwrbaeGqU1MJeqmAZ5/E6fDu/NL+dbFH6yK1brxXhN
	05yS05JFF838mf5tncZyu6tYTIqq/9hiruH9uTyHzwrwqnCCOXnBpVsz1+QYvpMdGgD767WFb9c
	+wDF0RPkEdSDOTLZnzymhum+MXbfLxYIcZc9lmdyTpv5LBYpugRyCsJ/32Fa3b47yqwnpu0Aqzr
	Y4vjd6GjS6ky0n+NOSHbL2GX3VDSpkK4ks+XLuxbybwEN4tzkQ7F3fsTwzPc2PMozD6wxbypN9B
	Kutp+hwU3xkiQvmtYspC1uIFr5w==
X-Received: by 2002:a05:622a:148b:b0:4f1:ac12:b01b with SMTP id
 d75a77b69052e-5075284a74dmr216983541cf.38.1772533874607; Tue, 03 Mar 2026
 02:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net> <xmqqbjh64262.fsf@gitster.g>
 <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com> <CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fvwriad-O5CUeKHQ@mail.gmail.com>
 <108ccc9d-5777-4c84-9dad-c2d0f5dc2e42@gmail.com> <CA+rGoLc+ULYUZaDCdAHxuL8T-qyjJKTRJfSe6Muhb7c6d12e_w@mail.gmail.com>
 <46c60949-87f1-426a-aeb9-706e97fd8e8a@gmail.com>
In-Reply-To: <46c60949-87f1-426a-aeb9-706e97fd8e8a@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Mar 2026 16:01:03 +0530
X-Gm-Features: AaiRm50FwtY-wkQwqJqJCasn_pDFO5-Xi9E83grjirFQs68T_Plrpex8b7orWLo
Message-ID: <CA+rGoLchSjQHn_jmHVjyOHUsYXLtmR+oOYKJc=c-ZNfpJ=S44Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	kumarayushjha123@gmail.com, valusoutrik@gmail.com, 
	pushkarkumarsingh1970@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> I see. What you've written matches what you described =E2=80=94 it essent=
ially
> replicates the functionality of ref-filter.c. While I understand this is
> just a simple code implementation demo:
>
>  >          opts->path_format =3D PATH_FORMAT_ABSOLUTE;
>
> This implementation appears unable to support input like 'git repo-info
> --keys=3Dpath.absolute.toplevel,path.relative.gitdir', meaning it cannot
> handle multiple paths output from a single call as previously mentioned
> by Brain. The 'opts' here should be a global shared state, right?
>
> I think it's better for the parser to allocate a separate memory for
> each arg it encounters. But then we'd be back to implementing something
> like struct used_atom, hahaha (=E3=82=9D=E2=88=80=EF=BD=A5)
>
> Thank you again for your email.
>
> Yuchen

We create a fresh local_opts copy from the global_opts defaults for
every single key:

for (int i =3D 0; i < argc; i++) {
    struct repo_info_opts local_opts =3D global_opts; /* Fresh reset */
    char *base_key =3D normalize_key(argv[i], &local_opts);

    /* ... find_field and get_value logic ... */
}

Since local_opts is local to the loop iteration,
path.absolute.toplevel only modifies the state for that specific turn.
When the loop moves to path.relative.gitdir, it gets a brand-new
local_opts and starts over.
It handles mixed formats in a single call perfectly, without any
persistent _pollution_ or the need for complex heap allocations.

>
> (I feel like we've been on this topic for too long. If you don't want to
> reply, you don't have to :-)
>

I agree we've covered a lot of ground here, so I'll leave it at that.
Thanks for the great discussion ;)

Regards,
Jayatheerth
