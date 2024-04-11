Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608C13DDB7
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818921; cv=none; b=VrFPbm1d/6zP+35LXpuH95Jzzpl1wF9UVMBjeK4u/wKang+gcZ6sgU1lQZZK9uKgNRGMuHBBbsDK6H0zOdBFxSY0rCLyvnIjLcr+10lxHUaObHfc+FgNm2LFqS0PAyF+jghKq3o6kuAS/9jTAMfBhlaLwNgHuSZVHl9vroJe6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818921; c=relaxed/simple;
	bh=ptnLAZRmo5cqPQaAY7c+V42rj36SMOR/O3UEPcg2iho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvLNJprP4eqXrY5Untn+UvF5Dm5HlpEQd8Cw+lTai2Yd3R82UJYL9EqWnhfLtTnsT6+fQbm4pJCvEWHigJXwaf95Ivza02QgSXOsppcAkML8ceIpcumGtVsURTYgQEMh0YRFtetzMg25iHJHH9dpJukjeWwZzbgbTtvhN0sEtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3b2F4sL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3b2F4sL"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e2ac1c16aso7722320a12.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712818918; x=1713423718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptnLAZRmo5cqPQaAY7c+V42rj36SMOR/O3UEPcg2iho=;
        b=F3b2F4sLdgPhHmnRtcPiEm5sIE+vm9KV5eTPwrS3NQtBIvDmcuQzkZd0wMoVgxC3bv
         Bw7kBY0P/Orqkhe1QEyZaPSXhnm0s54p5EeTkFici5KO97xbcCKUCwUs1qQ+Kozt6s01
         zyh2EeKgBfe4sZJyLg/YW2Y7SI/QWR+tafuE8f3lPrx52TxFUrhH0DXwpeUdIcGmoAZd
         kWKmwHDlWjrkolrMpRPT09HO3sEkmK6Z95dXluhbkXMoOQZMS2ejkP4NNXcwlXkgeKkU
         Lyo2iBjRkN9GefdvAkXTTWtplwQFaHfxRnXxKB/AJfDyvp/PHuksoETYGCKsBAn1OfNV
         5A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712818918; x=1713423718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptnLAZRmo5cqPQaAY7c+V42rj36SMOR/O3UEPcg2iho=;
        b=cbB9nVIV8lPdazWjFbTkBg2UAuMRBLHodgL9rK7Vwa3N16pvvgfvQyz94Y/TlDvxoF
         871ZcRO8jeJtutosUrCZ3J4ELCvCecaEZfa7NIEG2Vdf5piycsNzH+uhiTXqUTPiNsqk
         O65vxg6de6xEFPeZPTIaTl+YY3mLZCcefdY1paVZmTduNNxqKxVVB/11pGUo6X5lI0oh
         X+wdzK0O+ZNiyfG0au1K2KXd5uPQEll4s+jXxxx3Cumr5G3AsTlPaomdLupKuBO0UWs4
         28WTLfRbau9YWP3gC99BbBBLvSZUiHGKPqJd9LXdlJmdbDSzG1YgxTo2yc7LJvIC7gdw
         p/GA==
X-Forwarded-Encrypted: i=1; AJvYcCWTkCg0CR/9I3crlWwzNAXuijYoe0Vpr4GGeO+4duJl45QbHLOa7DT9Bi2sL3PbzMGtFJg8Y+KkT/YYf8PCD96Id3Lp
X-Gm-Message-State: AOJu0Yw+pOH4Xq2usOEb6XH/VDluRj5KsgKrdNVHd1xMGEldEmezPpgc
	wuvMJsCRHyBTAXEJOlgLrRJckDnKnv0Pn8ustBq7dRR0ZPIw/nGhEJGaOjLJRnky6yXDzdetpzu
	Mrni/ERQ1/bUkJpCWljcCBn8xcBQ=
X-Google-Smtp-Source: AGHT+IEAzgI5nXz5J/Ele/YTkLg4CspTNNOueFya71lxPjOBHknCXgT4GVVRf20AAzImjxIrFiaY92RbmBc7USUMc/w=
X-Received: by 2002:a17:907:72d6:b0:a52:1b7e:b019 with SMTP id
 du22-20020a17090772d600b00a521b7eb019mr1301665ejc.40.1712818918226; Thu, 11
 Apr 2024 00:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240402222619.2212650-1-calvinwan@google.com> <Zg38BLxLe193zYss@tapette.crustytoothpaste.net>
 <CAD0vCJ=4-QoqUovaOuw6gPTfPEa+d6uJBaO_Vq9R9Btn_YXzwg@mail.gmail.com>
In-Reply-To: <CAD0vCJ=4-QoqUovaOuw6gPTfPEa+d6uJBaO_Vq9R9Btn_YXzwg@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 11 Apr 2024 08:00:00 +0100
Message-ID: <CAGJzqs=PJX_ydB911QqBxf41wnNXaT0LZRwjDqfTw_vTTMPLow@mail.gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
To: Jackson Toeniskoetter <jackdt@google.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Calvin Wan <calvinwan@google.com>, 
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Matthew John Cheetham <mjcheetham@outlook.com>, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 19:43, Jackson Toeniskoetter <jackdt@google.com> wrote:
>
> Just to clarify, we at Google do not use extraheader to pass along
> credentials. Instead we use the .gitcookies file[1], which iiuc gets
> read by the git process directly. I'm not a security expert but I
> imagine the risk surface of extraheader and .gitcookies is similar.

Hi Jackson. To clarify, are you describing hosts *.googlesource.com
such as https://go.googlesource.com/? It always confused me that the
'generate password' feature gives you something different to a
password.

https://www.googlesource.com/new-password
https://gerrit-review.googlesource.com/Documentation/user-upload.html

Have you tried OAuth credential helper git-credential-oauth
https://github.com/hickford/git-credential-oauth? It can authenticate
to *.googlesource.com without setup. OAuth has security advantages
over .gitcookies because the OAuth access tokens expire after 2 hours
and the OAuth refresh tokens are single use. These credentials are
stored in the user's choice of secure storage such as
git-credential-cache, git-credential-libsecret, git-credential-wincred
or git-credential-osxkeychain.

I encourage you to try it out. You'll need a local web browser because
Google's OAuth configuration currently forbids device authorization
grant for the relevant scope
https://issues.gerritcodereview.com/issues/300279941

>
> Reading your post on
> https://lore.kernel.org/git/20240324011301.1553072-1-sandals@crustytoothpaste.net/,
> it's unclear to me why the credential helper protocol needs to be
> updated. If the goal is to support Bearer tokens, can that not just be
> implemented using extraheader? It seems like the goal of getting
> credentials out of the config file can be accomplished without
> updating the credential helper protocol. So is the bigger goal to
> support more robust and modern auth schemes which require multiple
> steps? That would be useful to Google; multi-step auth would probably
> be a more elegant way for us to stop using .gitcookies than other
> solutions we were considering.
>
> [1] This is actually only for external contributors. Google employees
> have a more robust authentication mechanism. Concerns have been raised
> internally about our usage of gitcookies, but it hasn't been made a
> priority to address because a leaked credential would not allow an
> attacker to commit bad code, only read it or initiate a code review.
