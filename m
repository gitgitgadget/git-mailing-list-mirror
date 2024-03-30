Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DD847E
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711786656; cv=none; b=ZMEm7FG2vQttSA/FranUwLGOUVOcnUQJaluiHu/tnVbm1Qo8kKQrBB8fQeCTiRPRYg9mIrV73LlxPbHbwZ0iP+pWo7X5IJs6o8N1XpxzH5S0aVKaZ2D8zk0I62htFzVNir3sLMTgB8rchHrYLc0HbvU/pzKAm5uF5INFGeoUIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711786656; c=relaxed/simple;
	bh=uGpIQy/2kMh2b6EAk5wBjMFPBC/uj2t8tkbri5JEuFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmLlfw+MksuyjWpX2NBnK2TrUXq1pTfij3W93VlB0ik7aaaVVmMky4fmRc8p7jxB2jaUOrcZDhE7wS9t7YauKSmbsKO/e0U5bx0DkcGNa+7RdsdatOLQRKcwyNVqroI86J/zSKOGfV1OmGNmd7IJHON2+L3N+VX+/znfDD2Tfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX3FQTHH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX3FQTHH"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso331065066b.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711786653; x=1712391453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/SD/k0/pA7dJ1+iaSgtkEkD+96DTRx7H1Eba0JFrk8=;
        b=TX3FQTHH5LhxtOS2F+ZNvxy49gOQBxBOQWPdYvbCr6H5vjAuuaTFse0j+qauRR6D4l
         q5SauPLxFSBuL7HLwQsRFcWI/zOuB6sUlz/b7X+PM2/e2IF0vWMs5SwSSWTNFBv2TEcV
         NUSBx79J1TV3plvCjqLntIFUQtEnb6ZP70ZGYlw4BR3MnbKPHd/OqOSr61sHrvpB8nKN
         nLBYAQQnS32rGRntdBwDylK/LedzT3PC5k99HhFP43ULjUdQZCD2lGYaP+ZVsnbKgNJf
         e0Yi4yE9xb244bKe4q2TfpsqWVG6Fc0KbJa5Sk5qW36TK/Bvo4FBUoQGahANAgImM3mG
         Cdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711786653; x=1712391453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/SD/k0/pA7dJ1+iaSgtkEkD+96DTRx7H1Eba0JFrk8=;
        b=JpdX/wfr0xq4uCtRImOnDdO/6HMoZmyx3mck8V4PRCCl1J1ST3sTPohMMCeFcMxoBy
         OeDISgEJTQf9/ZKIgJL3hQTHyIY1PcjQAG5L2vFmHQHkfb3COhncjtJTFHsMv8ezCpgm
         nRhLK+qE5IZRdKN6IOXROvCBFCfE2FVZC+2IZP5GVRmn6Fdc2jHAnfoIUQ4RiLgxc2qo
         w5Zuaq0fjdBOg6+Sd6xYeF1QA8YWxNq4aPSqiQ8pw3J3iY/0x5mWPHRt8SaijlaM05I1
         D2OQTtrEX2fz9wPxr+nUARFA0f4EQrwus2MOTWh8U3/lBmVjQH9RlzM8sx6o0YXxyg6m
         m5eg==
X-Gm-Message-State: AOJu0YxfVBqckn7DKln1esFKH5EfFeoUawbfjPUiSIPZfqIuSmRoAFo0
	f0cdC0aLI3fxR9Kq+ekBuHxB2Yta8oemwQXQe8iQotGh5nQsR55kGqsHY2aUKEIKf4QcrXbbdie
	lvfy1ZksGVTI5GYg5telbWD+8QHk=
X-Google-Smtp-Source: AGHT+IHFNjywmKCYYoEe64jDmOvAP9hwRsIjJFSpwXXoYxcKTdLy6ADGM+9/hVCX/SKGSkXiTVpvOdFWu60FW+xNWQA=
X-Received: by 2002:a17:906:39d1:b0:a46:e0ab:40ff with SMTP id
 i17-20020a17090639d100b00a46e0ab40ffmr3324335eje.35.1711786652694; Sat, 30
 Mar 2024 01:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 30 Mar 2024 08:16:54 +0000
Message-ID: <CAGJzqsnyPhR2t7yuVXGQtCoeeUM+yxOR9hDm1y2Y6hcSK6QMFQ@mail.gmail.com>
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

If you've time, I think it would be instructive to add (conditional)
tests to libcredential and support in at least one storage helper,
such as credential-cache.

This would clarify the behaviour in subtle cases involving expiry and
multiple helpers.

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
