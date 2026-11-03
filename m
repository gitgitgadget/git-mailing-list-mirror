Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699700;
	b=jclm4Hc6QjTF8ykLkaGd44fCRFVEQ/6laO9rXiFMFsTwEeGTPbCNcNqplYxb4+Y71ffk
	 q/Jv5Zi5LFey3gAOoOcuif33H/Zrz0EXh1Gfam891b6dWBYILxLyfHcQ0FCvlxnr+rCbP
	 7fsPt+s0jJFjAm5b07d0iaLJLoF/LFYtQngbJbxTn7pMFEJfSgL9djie5NTPv7aE2URHq
	 1n0GzdY6mnZkwfwo5cApt9htc3KrFyPSuI5dMxtKxKfWCGCR2kN6fmih6q8W9kviyFxNK
	 kwAqsuImieD/+a1dr6RtSOxVk9zLnR9rmPyA8VgImYrObpYobI1KzW+oT+Fep7iwp/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uC5w6JFeKVSy0bgJ6pe5OsUFD606rnjjaJ3Ths+wkgI=;
	b=JZO6wvV437KsxCKqn14gzMTYGDC0MrvDOdM49Ek1fHMyOcRm0v3HQkSLID6kH5UHj/a7
	 7Y2E+Lz87x9slJnG6Q3M5DgpYXXt3VzXERiGyp+UslF6MA0eod4U8GNPzCZuLtB8JCc9B
	 xSsmQSnO3ryVnsB3aEGF2rh9LVuLJ41Mijhb+0/9vomB4QCj0ODz/RrKK9rn9o+tdQUV/
	 PnkK8dIPH8xM9ZmghU9h0lk70FtGQ3efRszFR9gly/mI5HMGQjbtNq4lkgsexvO5eoxNR
	 KTNfA5GqJUtQ0x1AUfTSlGHmB6R/1wljXANuSj8f55/q6M6TvG4QoRRGHboZVo++cNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uV0i9C3H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F6606D803
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514F6606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uV0i9C3H
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7a6e560f580so2679379137.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 01:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793699699; cv=none;
        d=google.com; s=arc-20260327;
        b=gMsDirpEFqN+vltjRrWU7LssDZydMsAxXn36SAQC8HUohxWpLUkaR60p4OsntYIFWZ
         mNtQQrHesOP6VZwiAJwhVc+X3LI4gsQDW9Qr3Vxf6eb9gbzWBiV9YrQofNofLfCvjPrF
         HJ1NdhwT1g4+gnyCpC/7zGOy7KaQSlWwz7EdPC0s8B9J7wTuJ+iOKEDrfPN7O1hAjZFA
         dga72Ori3OFF/k3tRCPF1lDm9c9kbr1rWy/reaDyDXf+CeXIvAuhZkTqGXiu4LDAHG+1
         74dEs++o3Yyt8s71VVyJn5/DRjLRee0mj7onvnh176nn8yXX5VApBKggn0MvamJEWa3p
         trag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uC5w6JFeKVSy0bgJ6pe5OsUFD606rnjjaJ3Ths+wkgI=;
        fh=0jabnKDs2HVEwXCfdjOzh97L7lcBEOeJBQPtgFBVgt8=;
        b=GIAQoSWPFxPOB4MGRlENtMbCeUo/Xdi7waBzS/dw2FJEGIpaGo8H4AO/v4E2VGFrbp
         bRerOB9OQ1VPj/e/btu8SoPu9JHVh0bOqvWGIzieKfPU6jCs1cwrjIAj2JOszVQc4svb
         81cSSG9lX2daSdYc9mVb1CN+AHfeKE0+2etkFem6lERH/ytdsiracUudXLi89ShYQ+7R
         ynTS9sEQadm1QIjy0J1494nexG4H9PlCuc93jQJiJEvx+MF/KTJJfzCv4gQy/UyKbp/+
         yeH6GJqIh3b7BUsSQ7x7cts8PjnPASEMmAXrEyxc4uRzhUHJIa2BBWTYjlRIDJ/YMTnD
         RNIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699699; x=1794304499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uC5w6JFeKVSy0bgJ6pe5OsUFD606rnjjaJ3Ths+wkgI=;
        b=uV0i9C3HL8Swvf2BQqgqLZMyRCcUNk8l0I+mvJrUAdpHy4fMMzRt8Ka0X5pI5n21sj
         OUOy1JbmS7F6n/C5kAmfc18d6T4904t/DI2UTUjL+ZRdu6cIkxHiVq5TKVoRKyDXHPTo
         4DeRcnR3VJWUByI3pJi/Gwwaw0w2fEouo9aZSdhT6LtlcC9pbwdRueKtGk8rtwnSSHKf
         nI8soNEO1HRftFVrLpdnenPjlHiPU7eU4rJUKWKX9ZaVIvdDtRN483HiPp05Robh1QXx
         RRL/bmS0wfvm63C75b6JfozKNKHN8mfcJgKFkxepS5dJ+081S+5IojQwbyXYwAgCFlnL
         Qt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699699; x=1794304499;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uC5w6JFeKVSy0bgJ6pe5OsUFD606rnjjaJ3Ths+wkgI=;
        b=UYzZDvOjKPGlTaaFdEFvx/2P83Qv6vwGtDoyL+5L1UuUPUZo6UaWt7U6cuZimq7qPL
         ajN0R0EiM1qxOBz1oBdjmCJHsysxWzi/pGQb1WCuYYmIRvsxY6d9X0gnBjtQ0tHho1QK
         q10mpQ1FhkpquSVb6ZZ0Kby0eYYCTniF1KhzUtkrspvRk0e/EWss35oO6N5vgp22RQMc
         8r6MyxZjpGmdaCn6HK3M5h9e7GP/ejNiWBods9+a4on6FdOa8NZSeWypgOb292+HDTiJ
         BsWCrt7N0SjAl2Tx+EjsCKZWaLLo+h7P6YGFeUvLViEn36JUkjB7t8qGF3u96fhP8evo
         EkIA==
X-Forwarded-Encrypted: i=1; AKwUvBzxv9cIAYdkuj427WTJOrHQfA35vA1FWzsfm0szKVeKvQ0dtSF7eg3Pef212mKDOPTTUBk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qo/9kXY+Jz8UfRiuXacSD1jEaZEvQWUjp6OmJo2Rq3v0qbuMS
	s4CnYi8eEA29KbClqO5Q7e9Adlhngmm1vG4ff9nCvTToWiSm5QeVVRqtlnhWeL8FPENY3ujU4yB
	AAX+lkWBM8PlVEUCCstbWXwAgIVRMdow=
X-Gm-Gg: AYBFou1/hO5tYq27aL2KKeRmsC3pCWfG/8izldbh9nyOVQuSwYYfQuGnLgXVXOgo9t6
	weRSN0fsn0QVG3t/lHLXmO5LXRYWDoC56bTvHrV8Ik+BksGWKwU23gLA5AuXBfEH8dWNN35gfqp
	bytvuLZDgJedWjbX4aDgLNj3J894Mlr1JwmhROTVL7FPqUZKvKZzyJmrA6DkkuIq43mMuq+krff
	M+oyq+MCFOCffW93xopkhsGOrVBJNYRV/MPgiM1ttMCq/dfi2BL86oZq0hvVbZ16icLJ5P+27o+
	Ezq8UAd26Vy1xo9i+tOgqDEaGs9HnsqQdO2h0JmFximF8WPxN2YCxPCFnRL8ZamhsPslSkquov3
	clQcKLvH0drJ1o4tI5eEvB6u4T2oAFTUc6EHQ7epQoy5YL553icZqs0DgMQ98ceU9bw/YOeO88f
	Rm38fiZYyFgdshlWXs8fZpQxzhbkg=
X-Received: by 2002:a05:6102:1623:b0:7cc:26a8:e726 with SMTP id
 ada2fe7eead31-7d0727137aamr5064808137.26.1793699699274; Tue, 03 Nov 2026
 01:54:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 04:54:57 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 04:54:57 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 04:54:57 -0500
X-Gm-Features: AclHuK9XIAZgZ5gymgGa2D71MAVWlTc8M7Z3iNTCrnanxuOOMyNfbrH_OjRr1Q8
Message-ID: <CAOLa=ZTKaJhWHuKnSxL1pYN_JXdrr1Eohy8RepqFRc=Qph92Yg@mail.gmail.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Kristofer Karlsson <krka@spotify.com>
Content-Type: multipart/mixed; boundary="00000000000068d308065f5c41a2"

--00000000000068d308065f5c41a2
Content-Type: text/plain; charset="UTF-8"

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 285fb3809f..b2c0d394ab 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -1107,6 +1107,7 @@ It is an error to use `--missing-only` without `--missing=print` or
>  	(For internal use only.)  Used by `check_connected()` to
>  	select the connectivity check algorithm; see
>  	`transfer.connectivityCheck` in linkgit:git-config[1].
> +	Replacement objects are ignored, as with `--no-replace-objects`.
>  endif::git-rev-list[]
>
>  `--no-walk[=(sorted|unsorted)]`::

Nit: Should we also modify 'Documentation/git-replace.adoc', which says:

  Replacement references will be used by default by all Git commands
  except those doing reachability traversal (prune, pack transfer and
  fsck).

--00000000000068d308065f5c41a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7b3c7871fc0c1587_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ycHIzQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mempqQy85cFZjY2xGSkl4ZjlFYmlOZCt6MjZKcE1IOQpuYzZVdnVUdUVF
ais1bGR3bUF6V1AvOHpTNm55eWxCN0thT29yV1pnYzJIaElHR2MrMFY3aEhmS200TlFiOGJ6ClJT
dHFERVlRZkRDSDQ4dEl4UGpBOEszNi9LRHNuL2JQelRpOSs5allWaHVvakdLaHVtMGFWS1N3aFo5
cHRUK3gKU1l6dStUemN2RmU0UFY5VHRwLzI4cTl0ZjFBeklZNGU1Z3lSWnVtcDZJN0ZhOSs2SzBk
NzdlelRpcm1ZUm1ULwowNWNnUkNWRCsrVHF5U3QxTnpJZjl2WkMyN01rYWEzUks2MU85NThFcUxD
L3U1WkNOR2Z3RWVmTUlxS3hVSzZqCjBXZ0hxU0ZrdFV1TGRvUk9tcndUQitFbWQzakJHR0w3SjhY
STVWQkdXay9mcms5RVlScWNXZUdOakpGU1FqZUQKZzZJRDMrNlc1ell6bXBtNERrbGtMelpNbkZC
cy9NdnNvc3ZuTFp0RWVUL3ZvVk9Kc2hHMTNyUmVvaE9HdHlBcwp4NGhIZm1heDdJcGROOWpHdWZE
QjZtOElmUW5wNkIrUStnamtHdGUwVWJhZW9tY0VlZEtqVUZOckN5NEJZd1NGCmhUdWROMGExbVNE
QVlQZ1pVSncycmpvL0pGOWtXc0JkUnpvNEorUT0KPTRVUGEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000068d308065f5c41a2--
