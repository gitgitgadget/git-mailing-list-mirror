Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1613DDCE
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818925; cv=none; b=ZIPrWBmiWPpb/LlbTOpU8Z9DwFO0eqtwmPCE0fYXbo95IKAdFwNVO3t4euSxEGU5hw576YTgFJkr8DFrzwjrAbTGQRgin+U8pfzWHXNM8G5cDgMS8rnKWFHYSiM+WDdSp5fwcMMoXjgPylQ8sr07Ka42/nxu3ZrvuUUgPYwEwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818925; c=relaxed/simple;
	bh=N8CY2+UGdkI40Zg/vQBbGBaTF09b5ATb/HhLNlJii7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3X1SPvPFu5KnP/TCbmOf23+t/18QpsAq0SZ2LZYnoMMtT81BwASQofnTijPEVWhiuWigJQMiME0ZYXzIJGxso9EfIjJkOeKEuCp2BlYtycE5NhO29aF6X7H/Njj7INI1IEIshLMytZq06hjAsW4QocHfjVlP1oRX+aejhHtik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6DOt8AP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6DOt8AP"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5176f217b7bso2401205e87.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712818921; x=1713423721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz0COE82w0wU3E0sQJmsIMHYTQwhM75E5hYw6665tdo=;
        b=S6DOt8APambgnNNp5UlRZflMEb95Yx2F0gp5sBKcpV8GSCPyAwRNS2sNGmqOxA8N2B
         xnpM4KiO9nXyu7pOWFJ68fgBtUTmKc/bT4HQeJBF/wbtGHHId/MDxhIEv6UoX4/6L+0S
         o+TNclbLWXFlm4c2uPt9mxVcf1xMGXeYhj+cI8xZ2J/ezvBct8Am6829Z4KrjFQuBG1I
         f8reuo4hhVDP+x5v35nx+ElwvHDl3AYhEGLoRMffXWZa1nH+TfWFFYgf8aPcbMyV+qO8
         RtP8mdmfkXne6DIBv9HBzX6NvASz+6hd9DstON8M+dVrWTAMfw7+C26en9cAF2j8obWV
         m7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712818921; x=1713423721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz0COE82w0wU3E0sQJmsIMHYTQwhM75E5hYw6665tdo=;
        b=h+5Ray4g1moRNRoywb7deiuvjG1DanR28YO9yz3fz6K7BOZ+L+Jl+a30zsMlxNkRDt
         ExM2QzXQGsNu+Cd1OC2f82US+fCpJYk3x8Z2uBixLDaxBuo3fuTwW3lRR+z0tbW2AMbj
         9hYEzdzeDlgW3rbZHTwdrz/iriRmMy5BPpFZ/SE05V29eCmE7VY7/URJaX4+Lr9pcP67
         1NQ2D5bUxlGptbioYiFWmFoPiZBve3xi7NYB7HyDIutx5pLEojW6IlS0iosw8q7DTKdp
         SNmEih/8lWBS5exG5LXPlu0Gv2HSMpxQ/58coEHXwvq84DB9EN6jmMzbSq+NM2/W1qzu
         FD1A==
X-Gm-Message-State: AOJu0YyWLR5AgHp46E1VPdrmcMCkZwp11+CNzyNucWCiMnQiZA26orBV
	5sGpCDdgi8pdSgk1KpOQe3RiaaLnX/yY14ra1UHb8cxAn10/29vJX7Ud3VrkcGrkKFQ9KIpdiWZ
	7JzZW/tSVMjZJYdy8RG42winMtbo=
X-Google-Smtp-Source: AGHT+IHeWwsOfKC973kwgSp4VIJEZ6yG8oYlHZlaBJk7BKZMQ/cULVwCdb45iWhEdNSlP/lZqVLNYzS9bf9irzlhCp8=
X-Received: by 2002:a05:6512:401d:b0:517:89e1:bd93 with SMTP id
 br29-20020a056512401d00b0051789e1bd93mr1596149lfb.27.1712818920794; Thu, 11
 Apr 2024 00:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 11 Apr 2024 08:00:00 +0100
Message-ID: <CAGJzqs=N79qLXD7CNo6m4x+KPzMFq5n9_wa5mbJw94VNatksNQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Matthew John Cheetham <mjcheetham@outlook.com>, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 01:13, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Right now, HTTP authentication in Git is mostly limited to approaches
> that require a username and password or are Kerberos (GSSAPI).  In
> addition, we effectively require that libcurl (or, for other software,
> such as Git LFS, using the credential helper, that HTTP library) knows
> how to implement the authentication scheme.
>
> However, this poses two sets of problems.  First, some sites, such as
> Azure DevOps, want to use Bearer authentication, which we don't support.
> This is implemented using `http.extraHeader`, which is not a secure way
> to store credentials, since our credential helper protocol does not
> support this functionality.
>
> In addition, other tools using the credential helper protocol do not
> support the variety of authentication mechanisms that Git does.
> Specifically, making NTLM function in a useful way on Windows is
> nontrivial and requires extensive integration and testing with C code,
> and because of this difficulty and the fact that NTLM uses cryptography
> known to be insecure since 1995, there is often little interest in
> implementing this support outside of libcurl. However, it would be
> helpful if people who want to use it can still use it.
>
> This series introduces new functionality to the credential helper
> protocol that allows helpers to produce credentials for arbitrary HTTP
> authentication schemes using the `authtype` and `credential`[0] fields.
> This allows a suitable credential helper to send Bearer credentials or
> any other standard or custom authentication scheme.  (It may be able to
> be extended to other functionality in the future, such as
> git-send-email, to implement custom SASL functionality, and due care has
> been taken to make the protocol adequately flexible for that purpose.)
>
> In addition, the protocol is also expanded to include per-helper state
> and multi-legged authentication (the former is effectively required for
> the latter).  The per-helper state can be useful to help credential
> helpers identify where the credential is stored, or any other
> information necessary.  Because NTLM and Negotiate (Kerberos/wrapped
> NTLM) require two rounds of authentication, the multi-legged
> authentication support along with per-helper state allows the helper to
> support these authentication methods without Git or other clients having
> to be aware of how they work.  (This would also be useful for SASL, as
> mentioned above.)
>
> This series introduces a capability mechanism to announce this
> functionality, which allows a helper to provide a username and password
> on older versions of Git while supporting more advanced functionality on
> newer versions.  (This is especially important on Azure DevOps, where
> NTLM uses a username and password but Basic or Bearer can use a personal
> access token.)  It is also designed such that extremely simple
> credential helpers, such as the shell one-liner in the Git FAQ that
> reads from the environment, don't accidentally claim to support
> functionality they don't offer.
>
> In addition, there is documentation for the expanded protocol, although
> none of the built-in helpers have been updated (that will be a future
> series for those for which it's possible).
>
> My personal interest here is getting credentials out of config files
> with `http.extraHeader` (which a future series will produce a warning
> for) and also allowing Git LFS to support Digest and NTLM with a
> suitable credential helper.  Git LFS used to support NTLM using custom
> code (because the Go standard library does not), but it was found to be
> broken in lots of ways on Windows, and nobody with a Windows system
> wanted to fix it or support it, so we removed it.  However, there are
> still some people who do want to use it, so allowing them to use a
> custom credential helper they maintain themselves seems like the best
> way forward.  Despite the advantages of this series for Azure DevOps, I
> have no personal or professional stake in their product; my only
> interest is the general one in whether their users can securely store
> credentials.  I believe the changes here are of general advantage to the
> Git userbase in a variety of ways such that the goal of this series
> should be uncontroversial.

Do you happen to know any public Git remotes that support Digest or
NTLM authentication?



>
> Feedback on any portion of this series is of course welcome.
>
> [0] A name different from `password` was explicitly chosen to avoid
> confusion from less capable protocol helpers so that they don't
> accidentally send invalid data.  This does have the downside that
> credential helpers must learn a new field to not log, but that should be
> generally easy to fix in most cases.
>
> brian m. carlson (13):
>   credential: add an authtype field
>   remote-curl: reset headers on new request
>   http: use new headers for each object request
>   credential: add a field for pre-encoded credentials
>   credential: gate new fields on capability
>   docs: indicate new credential protocol fields
>   http: add support for authtype and credential
>   credential: add an argument to keep state
>   credential: enable state capability
>   docs: set a limit on credential line length
>   t5563: refactor for multi-stage authentication
>   strvec: implement swapping two strvecs
>   credential: add support for multistage credential rounds
>
>  Documentation/git-credential.txt   |  59 +++++-
>  builtin/credential-cache--daemon.c |   2 +-
>  builtin/credential-store.c         |   2 +-
>  builtin/credential.c               |   7 +-
>  credential.c                       | 114 ++++++++++-
>  credential.h                       |  69 ++++++-
>  http.c                             | 128 +++++++-----
>  http.h                             |   5 +
>  imap-send.c                        |   2 +-
>  remote-curl.c                      |  14 +-
>  strvec.c                           |   7 +
>  strvec.h                           |   5 +
>  t/lib-httpd/nph-custom-auth.sh     |  17 +-
>  t/t0300-credentials.sh             | 136 ++++++++++++-
>  t/t5563-simple-http-auth.sh        | 308 +++++++++++++++++++++++++----
>  15 files changed, 760 insertions(+), 115 deletions(-)
>
