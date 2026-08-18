Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F433A70E
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088191; cv=pass; b=mAkQNbJzN61Kk2Y614O2kVthfRv3KGJ1vhAV4G7d4h4DaqCeR04CdqzboKyERV8EhONFiGxhvTT9uYZMQ0t/GHfuO1U67cIpWR8fPshMhFb+P4uluHCOTaPc39PpL4uYVgzgAAjiQp3n/Dv4s3Pv1VVKJvyRyU5eTN6yuueRxn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088191; c=relaxed/simple;
	bh=CTwd9Oaol086X246o4S8rYxiQUfrlUqLwg18p2nNTi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSQCUQdAAy6xMXWorYFvVbGl1lX4YFU5JlkIjBCn2UhY1W1wLxMQ5rKhlQ33vrkuWEctzO0VQLOiSqaXHHbHJ5EE88PnYNLs7a3pKJ+0sc2GG9uGQ9rWdUsagLSqii02x0yji28tXnofy6p4PK6WdpXrzvkqiLgV35WJtp8yO4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh4ztUNX; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh4ztUNX"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso377084e87.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787088188; cv=none;
        d=google.com; s=arc-20260327;
        b=avcLG6Owjx4ofveYFNhDSN03rnU6ibDdnb+wwgGQG8ZDEisRsikEwzbvopdjbcghuc
         j4rS/CY2BNDWd/x5Nl0oCuPFkTUjCljMH18ivDX1i/vJpqga8+MYCQfZanIoVEmWM1DJ
         ZbadkhWChnXbrl0aHC3j4ZoLMBANLsd5Jr0W0ppr3DzQ2cJGlVQclrtjccdjJtiwI+rn
         zy/JqyeDiSNrTj1SCdkD9p9iZ1yF2tEMYbUWE1Oc90fXs4TOU576ymZ0L7IILfyYneoN
         ZfceN50m3mls5227+yVGsGairniGOVW2dtKPzN3uLphq9mgUlEsWpCPkArksnlsBcbZd
         NPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X3oj8m3oldpEp9s8Q5rANriGo9jPYXUCLOomdURSNzY=;
        fh=2+9D9XrHc+BqZ01z1xDvlFZuapUPgNsCu3EsPDN3Ewg=;
        b=j+ar5VlKTqhrUCfdrR6O3JvSQQa51BXKYKT5VkVcChyIZf/cFVMw1XaNGh+0UrxbOs
         lNGgwipSMrnTEnRtWi6XFlCWfurzpvoL/HIvRFE+YPBhZiIE09gWlW3mmtoX2pfiUj98
         hDIslTjJc45eBNVAK4nVzXQz04nQge+qhbqOn/o0wJtJDa+2B3nz5FQOqSHKE5O22ykH
         sOPcK1TqjtiPCLy5rkotgQPCjn/sIlDcVQ/ldVX56dCLTUSIEOUhhsoaC6eLOCjL+1dm
         Fq80H7OKCZeToCpN34fpmvDIpnKMmhsCUFMYTDoLw3XeTxa96NHj6QGEcNQvbJ5z6MWI
         ARVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787088188; x=1787692988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3oj8m3oldpEp9s8Q5rANriGo9jPYXUCLOomdURSNzY=;
        b=Gh4ztUNXnG+FCRVCWPx6Q3akfzS+vcvYuDYmmQFI5VqhL0KHyoZ8cm9e/RrkIex7cu
         /eK/JMcTx15vSumkd+IA+8BSMgNu0mU3hyv4GAGOSZRbWKDrR6c4slslY6buvzY5pbLo
         DuV2Imhq3BzhZs4jxMcnGBJibuTydfJaxBwUINTSno1ltUPl6ctnVhRWspRx7evB9m8y
         KRg1QMm5wiyAWJ/zeoMEHLa37WI47mnIsmjXxASTpQ2PC/8OIWZKK92b3/cFnNqSEamG
         9rMJRAWzPl+1fCL7zBZxgwpjTdWepVa39Iit+CSichV6piuFxQeCIpQqAPHbyePdYmq3
         rM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787088188; x=1787692988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3oj8m3oldpEp9s8Q5rANriGo9jPYXUCLOomdURSNzY=;
        b=kjzk91XFy+LI7HxPQ31lIlPFRCxpaRiEKdfJcIciAb29J+fTjUdmaMQGGHReEHowO7
         CTlY3j8CZ08Yel+0rPQdHE9KhBcImrk8PGu+BoTRuwOpoZI1hcF0MMtz7W6m/wvUfEXf
         n/FM6goHIYa6OItqR8+H37V4vsCltiomwMjTMvp+pv590z1wLXw5zlCCIkHXk1gGsI0z
         l9xDEnScnEg1Wy0AifnJBPxROkfBxXhGOkfAJMB23Mw0K72oCl4EsrGHw/mB4Fdmbh0t
         JxqLJnJJ8QugmY9ntlbUuimGv3GkHVZFqCsn6lPgHBepY4Md00TC1rBu8WU7hf+mhc8v
         woeg==
X-Gm-Message-State: AOJu0Yy9QrIYfDY8cjrwzAWdZy+nSFwLTzDq3str/BmaWLL9VjFxhQBP
	+sx3nWkc/HbKgvjKMa9vW4S+Oo2JieEkeow+8/9N+59rdUgi3HMorMP4XkghurqFvVx2Nq75H0m
	5EjervIyjKSIZzOi1n/OGqCcX+3etm2SxcTsl3J8=
X-Gm-Gg: AR+sD13oITOWwgdsibzXePPBMmB7YFfXa/BGHffVDJi0Xob6tmK00R24UkymLeXGOmp
	AXcFK+CYmIoHrLfDsyknUhNba7AEyN7jrYGkUWrwf8zuWZ/ZnTW+SYnxrmlMUHJyO8aUgGYs1w6
	p5yIM3czOpbpY/7eFmm8aD2ZjfaZ4rbabXrd39B4p35obsC2e/Il3rflaZ3f5LxfD/siAgNwCF3
	OPZLAFvanQZDaOpeWKJsiVdRedgX5tJ3Dnr7xHe+3jZ3b8btIeiBPxf/arEIGmyiDISrT+u4jUU
	1Vhe3XJeid13NjKcpXtN4RDcdzviwAtWjDlo9dQ4e8eM6WUlIXjQyDWZ8HYECARbwaQi5QC3Oci
	Brbk=
X-Received: by 2002:a05:651c:1442:b0:39c:9891:58b2 with SMTP id
 38308e7fff4ca-3a186e489f7mr1544811fa.13.1787088187511; Tue, 18 Aug 2026
 14:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmruqt36l.fsf@gitster.g> <20260818193710.56955-1-ggordon@gitlab.com>
 <xmqqo6ezw5l1.fsf@gitster.g>
In-Reply-To: <xmqqo6ezw5l1.fsf@gitster.g>
From: Grayson Gordon <graysongordon1@gmail.com>
Date: Tue, 18 Aug 2026 17:22:55 -0400
X-Gm-Features: AcwNN1U5K7hbl1gpSW5uJAs_b-fopBG9Pvk0FUzn0GUvKFsm6zr-sXvnktBogUw
Message-ID: <CALgUfNg1yryPygp_UVp9cGFfiUe7_6Uqx3ExBt=10Qh+PKG2QQ@mail.gmail.com>
Subject: Re: [PATCH v5] http: add http.sslVerifyStatus to check stapled OCSP responses
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, avarab@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio,

By "fail-closed" I was specifically referring to the case where no
OCSP stapled response was provided. Failing open in this
context would mean that, despite verifystatus being set, a
response with no stapled response is ALLOWED.

Maybe I'm just a very irregular human being lol.

I'll update the adoc to be similar to what you provided.
I refer to the edge cases/different behaviors that we talked
about earlier in this thread with the older curl and gnutls
versions in the commit message and keep the adoc
as simple as possible.

- Grayson


On Tue, Aug 18, 2026 at 4:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> graysongordon-gl <graysongordon1@gmail.com> writes:
>
> > +http.sslVerifyStatus::
> > +     Whether to check the revocation status of the server
> > +     certificate using the stapled OCSP response supplied during
> > +     the TLS handshake ("OCSP stapling"). Defaults to false.
> > ++
> > +This is fail-closed: if the server staples no response, verification
> > +fails. Set it per remote, e.g.
> > +`http.https://example.com/.sslVerifyStatus`, rather than globally.
>
> I do not see us describe a knob or setting that can stop the
> operation depending on some condition as "fail-closed".  Can we
> rephrase this for regular human beings?  Perhaps
>
>         Whether to refuse connecting to the server when its
>         certificate has been revoked.  Default to false, allowing
>         connection even when its certificate is not known to be
>         still valid.
>
> or something like that might be a good starting point.  After all,
> the "check revocation and/or validity" is *not* the primary
> objective from the end-user's point of view.  Ensuring that they do
> not talk to suspicious servers is.
>
> Thanks.
