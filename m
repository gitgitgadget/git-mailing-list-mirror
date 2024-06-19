Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C62139C7
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768286; cv=none; b=Z0yaNX3H4PlhZo4dokTACE61HQNAtuwtVK70aApj2a8JNGDYiVicM/ZCO0QWbqqTlwK9eC1qpkcwF9GkUXQky4WjGLGQlmrF0yNvY4c9/UsAEfsN4yWHkvAt7QzWNwKSN9cyuZ/72L0ZPYD/Ix/D31imFLhFMBcpVdfh1dDg4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768286; c=relaxed/simple;
	bh=6CZJFR+fIidJ/xAeuckx2JyCmy2B/XAtPMQ2QJ8sDgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HY6aM+ukMluBDgNcWJsfX1OLRGRV2YHBJ9Lygm08YaMgUzg9izspjzs+Np7AxMg+vWA6qpyGOxzNsnmI/xKFxpJCmf94mCULTjBqu1VtUEJJBUPh9usXYCwNqBl5UGywn0Zu4bhMg5OzERCwJHIhIqwIjljsSDh3g2TXe6Rw5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky7un1zf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky7un1zf"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso8197430e87.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718768283; x=1719373083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eo35Wudtk6Od2dHkF95sfcy/vqUMH9vwNhd1b5Xefxw=;
        b=ky7un1zfPHdO+av6aMHAtUVGoNALgJXexZbSX1pBMBr5estN9rvIpLtPhE2z+bUuP4
         QN5pNUgpByxM0/AzNSEX6VYqDC2b3CCpUO4yZa/u/gvsKWDnYy8rTU52gFQpObazYJHJ
         B6SAvBQjGqUgyO86NOIv4aPl+EZT9rWIdX281QwZjqDuTpw6+CP7jepgEP9gw1mltLBf
         BPZUFsLcoTdBaWvhcwtZlXkUYsOtImFigZQWa+nM5WJ5S7SN+Z/hxsgXeaGDAzyXEGFK
         wE0/Q8umcnQbLfaFdgHZt8u/LMPzA4g9s7ARUfqNiBU4iOu0+60BH9Glo89Cn3VCUct6
         Ar8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718768283; x=1719373083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eo35Wudtk6Od2dHkF95sfcy/vqUMH9vwNhd1b5Xefxw=;
        b=EtVrl+kFajsIulx7io//db6bK6VcyNwSKZLhzHPNQuUJDVI9sID0ed5L3TxoDiMfFl
         VuZmzXyOZ/fNbp96RzASRXYnjvpv8SdD4fYXYAlGA/XxiJW5qgO9sTQgCkkkzbPlhI5x
         JIG6UhSbYxokZEfO3ELeQmns+zc7jvqeuu5EoJ8FPTsz9vOZbwJH0D/2/lXzqhjW+SXj
         YVypARFdGWX7AJ/YTZHTxkPeye52BFY+TXGDMzrfiCM6ocIUs20SAoTY9ITXXfrXTeKU
         j56/lTtJiSSTqFGZbFTaQ0Dl7jc2cv1aJg/qUUnB/5ezNf6ke2DHrtL47KgrvAojM2DY
         NqSg==
X-Forwarded-Encrypted: i=1; AJvYcCUH0Fbjcj1V4UKlMZYCkT/51cXSO86pfgbeRMD3JecH9LYDOj7I3uv8twshvkWjCq35mSW3uK+ttmKN139HRDy95AFs
X-Gm-Message-State: AOJu0YwhCZPHPPySAUa2lzHdD1RDKCqfyaqq2vdjBNpgmDqxUqiuLNEn
	0gdUwXZkNfG44RzrgLTvMst05sME5ox15V56PgI9Yy/glMLgwMldQcjFm5T2FXYlUkuC2FILPty
	B5aBQdKz8WOAuxfQgU1C/ZGdWGY4A6Ddq
X-Google-Smtp-Source: AGHT+IGWl8eJZaTeTsbGvJd0Y41KuQKu1pnhjxNXSgDnW5E71ZR9JqhYMYedLHaaLOar5v0th/qwS7MV+zkUAth6Z84=
X-Received: by 2002:ac2:4308:0:b0:52c:c97:b591 with SMTP id
 2adb3069b0e04-52ccaa3695dmr767133e87.32.1718768282729; Tue, 18 Jun 2024
 20:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV3CQPRyJCDanB8JFpkAMwuoo-mg3A=_L743_GXJtoFtQA@mail.gmail.com>
 <Zm8EqOfc_v4KBVVK@google.com> <20240618182415.GA178291@coredump.intra.peff.net>
In-Reply-To: <20240618182415.GA178291@coredump.intra.peff.net>
From: Devste Devste <devstemail@gmail.com>
Date: Wed, 19 Jun 2024 05:37:51 +0200
Message-ID: <CANM0SV2N3-uRbPG=VuEuUhL_BdgbCkoWPxzhwoa_g2s7ejujvA@mail.gmail.com>
Subject: Re: Add warning when v0 protocol is used/downgraded
To: Jeff King <peff@peff.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At least for cases where there is a difference expected in output.
e.g. we deal mostly in huge monorepos and there is a massive (= 2
seconds per fetch!) difference between v0 and v2, since v0 returns
tons of data in a fetch that you don't get included by default in v2.


On Tue, 18 Jun 2024 at 20:24, Jeff King <peff@peff.net> wrote:
>
> On Sun, Jun 16, 2024 at 03:33:41PM +0000, Jonathan Nieder wrote:
>
> > Specifying protocol version is meant to be backward compatible, and
> > there are cases where the old protocol still needs to be used - for
> > example, if an SSH server doesn't support transmitting the
> > GIT_PROTOCOL environment variable, then having the fallback to v0 is
> > still useful there.
> >
> > So I'd be concerned that printing the protocol version in the default
> > case would be overly disruptive for such cases.  This would be even
> > more so for protocol v2 for push, which doesn't exist yet - once it
> > exists, it wouldn't be great if all pushes using existing servers
> > produced an extra piece of noisy output. :)
> >
> > That said, I'm sympathetic to the debugging use case you've described
> > here.  Do tools like GIT_TRACE_PACKET, GIT_TRACE2_EVENT, and "git
> > bugreport" produce the right information in these scenarios?  Would
> > "git fetch -v" (i.e., when the user has explicitly asked git to be
> > more verbose) be a good place to provide some additional diagnostic
> > output?
>
> You can certainly distinguish v2 with GIT_TRACE_PACKET; the first line
> of the v2 response is "version 2". But recognizing v0 as "not v2" is
> harder for the layman. Plus it generates a ton of otherwise confusing
> output. I do agree that "fetch -v" might be a reasonable spot for this.
>
> > > If
> > > protocol.version is not explicitly set or v2
> > > and both the local and server git version are >=2.26
> > > and the reply is not in v2 protocol format
> >
> > Interesting!  We haven't previously used the "agent" field (server
> > version) for anything other than logging it verbatim; I'd worry a bit
> > about getting into the same kind of mess as User-Agent parsing on the
> > web if we go that direction.  But I would expect the main obstacles to
> > updating protocol version support to be in (a) reimplementations of
> > git protocol rather than the standard git reference implementation and
> > (b) plumbing such as httpd and sshd around git, rather than git
> > itself.
>
> Yeah, I'd really prefer if we can keep "agent" as purely informative, at
> least by default. But having a debug/verbose mode that says "looks like
> you should both support v2, but it wasn't used for some reason" seems
> reasonable to me.
>
> We don't distinguish right now between the default behavior and
> explicitly setting "protocol.version" to "2". We could perhaps take the
> latter as a hint to be a bit more chatty about falling back to v0.
>
> I do think that v2 isn't going to make that big a difference in many
> cases. For most clients the main benefit is the reduced advertisement,
> but that's probably only meaningful if the server has a ton of refs
> (often refs/changes or refs/pull, since you end up seeing all of "heads"
> and "tags" anyway). There are other features (like fetching individual
> blobs for partial clones) that some clients might care about, and where
> finding the v0/v2 distinction would be valuable for debugging. But
> complaining any time we fall back to v0 seems a bit excessive to me.
>
> There may be some error messages we could improve there (e.g., if the
> server comes back with "not our ref" and v0 is in use, we might give a
> hint that the protocol version is the problem).
>
> -Peff
