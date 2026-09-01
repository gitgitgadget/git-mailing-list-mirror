Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77038655B
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272933; cv=pass; b=rOuF7RC1F6RmGt3wWWGc1phykcRPeYVaEVO7hI9CaTL5s8azbUqEGgJ6qzr/HzxqyKB60OUtTLDm0ZSSM1ybGFGeMa10JUL1GYUbRGZlyZWoV3shW9zGzKOaHbtvyZRv2MQYaUi3Jztw/76SbwDCLRZBE+8xmFgJrBsujRMK2Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272933; c=relaxed/simple;
	bh=/RdJulDE6lwYwIyKBYtcnbKJXFyoS62yNJG1Xv5xmMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTr/V0vwrZUqvO8gqEVWCD0GHTPeUJsGTyXDtqHW2T/Qc15UUkarI/0H3urS4oTwH0FuVh3Or35TGWrQIuTMN/sDdxJqmp57lvXFZovU5xUKsh/woEOTMT84gPsW1DD4WUn4f+Ox7tV9vMeEmRpbbUQbV9Cuq/RQSOKm6OuqCK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q47P1OON; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q47P1OON"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-469d76ce704so663005fac.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 07:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788272931; cv=none;
        d=google.com; s=arc-20260327;
        b=d4CpWVcTEP+LlAiFcIA49VClHKNCMgQ5ebqYlQM3D3+3cX9XlChs4oc7ZPm9FEtBAG
         FLiwywgVejqgJU0rEPXF6lKq3tciAYtNKP2VOOUzOQqNJmnBSCrLG4oRB+oq58HbxcG4
         tuizapnBT/g+s8BKL57mB1DLMzwLviH2UqJeOZ1f7gXnfoHWvQ1ROzLcBiQEBjxddqeK
         l2hra0gbASH8sHAqtu3cmj8ZcAiOEGf/h9qHHj9auh0rX54BKU29zK4VC7+Svw8A9gb4
         9BMhOI/jnledtgOXz9x9KyYOGCQWiDACsR2jrJeUBmKWzaktT5fnvvN4ygojI7yOEYjL
         C16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wdKYePvVD1HDkvajsY3WOrqNBVNwuCUkNiUPGr0JvaA=;
        fh=/9ZdKINiwLJjvVtBHiCHIJKSS1w9iFdqRJb3DcIi+zE=;
        b=TNzpmTG3ynRUv6p8AucrIYOPg3fjjVqJEUCE+fQcp5lzJO3IkqJeKyYXlH47Co5KwA
         LqTsCuExQ1VaNVCKgDlDVfFyg/YtcwPE3MEpL5eKhG/mSOygJ1I9R2GUGtxhJJBxJHfL
         Rq9WVMLnXUkX+Xl7+qKoYOFQS9fYElacddUo8qm74SQ2OvP0bYlgYp9dqNtTIL/mTpOL
         DDBLNIWB/ud5wVhnymdeTYhGxrZRKFi7xlQSjjqECmacPBfX+nvQVoXVaOgH1lw8Rhvw
         X+b0v+fIaPf/SqCwJBMUnCiZ0cTbrWqa+Xm/j/nKZbbiSmNgsbA5mxcaprJTFfIzugdf
         HGIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272931; x=1788877731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wdKYePvVD1HDkvajsY3WOrqNBVNwuCUkNiUPGr0JvaA=;
        b=q47P1OONTPfpEXoNYrJ3I3SfMlOGD7cXQlVJEQQi5FibrcDQRnxHC8XUSSLpJ4TAed
         hVpKoci6/hyr9tmlkHqDTYFY7CoEaiaS3JGji/aGt76emtO4Qi3iUTQb6b9Mus0xuA/4
         F/RdrWMw/VdLXAs+wgtdnmHAxB9ilga7MW9+ON2ZMA+m+Z9BGL78EuqFjitK6n5BPQrp
         58awbpLLxoX1O0yj5v4ZG2kKi6FZ0DUrmTFruGMchpHDB7u3rE8HhSeH+WURISTjMmx7
         5yZ1kMLYXdGQZFNw0+c9YZRtDuWOWDo6z8KbqpwLSk1MsXJoLNvusfTZjUVtWVsy3L7H
         3h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272931; x=1788877731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdKYePvVD1HDkvajsY3WOrqNBVNwuCUkNiUPGr0JvaA=;
        b=ca/3T8cQmcNX8rITZJ/qgrjxdu/NE7wdya40UG1CfbvrHUUZesI/EvgpR6XUAa2BpQ
         ptLlSTrOoE675tmhroSnoHgH+atngy3GhHR1OAGe80cx8V/j+k+V3GQhPI1hoVZAxxQM
         HiOuaZ1tYJQArq5P9hoVeKvGqpil+VVj6q0ljkSEo2zg6V4YZoX650HpVYKCLZfUZfLy
         B79a4nQ09ojBmxOnS8xgEsqqenOU+lCuefVC88zou6ThZzsWkTaahqM/Siet/t0KNBzf
         ZQz8s0M4LA0HXJEQiGzSwGDcYf7TOvV7vCAsXWE1nmxAr3qHi3S6F/w17Ft4iGdOUNIu
         AXeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiYmudHP3U9os+jr16U0sCKLookJ/BgB4ncOp8Sl5vPjPGPyiOLwqLvkQAI0r9KVBYF0U=@vger.kernel.org
X-Gm-Message-State: AFuF++kytphvOSzCdrDmL4Vu7laOs3a0Wd0nKXW1Nuzyga78N8mxopjQ
	ZtqduL6meUrZVmD3Wn+of9sGia/CI7XIRaha0lerUzgRHeDzOmWh+RpDe6nqsXDW4g4FoDvvHHx
	NahtB33ds8VkAlzd8fnl9HRIZQrR24Bc=
X-Gm-Gg: AYBFou3tXsiwgc7Fn5giv0MwJPY5uFSTnNl46ELrTsAyccKFpprlO0V6zRDSzqwafxo
	kYrd3yxStfKY8Z/eyenNxpqgm6oIeF+xTFL1l3IbIrbUpvcPjD3A4bVOFHAzz7j1l0w5EWcDpPh
	0NrSDodvazKMdk1DYxl8DU9zJre5oNWVBvfw9ZK2O89RO8YJqY2UFk2XPVx09gaJhoy1B2S5pWZ
	kmm0GSbU5FO3fNU6uRBkSyUg2QMda7URc6IIUScOQAoOaYwRRi0xF9n1nGrJEIzWIGci0jZZuOL
	+ILtQxPZg47VSKFJAvPW24Cm2CW7QfHc6X997g5B4sgRa6dS1sBNTnSv5ca9hM48XeB6oXYXFRQ
	IWFsfDh5RCjwoUR7D1YlzLGRooxHqdvRzKZCWQswKfrDzA5r+lymLSoO60t293iw=
X-Received: by 2002:a05:6870:71c3:b0:451:22e0:9604 with SMTP id
 586e51a60fabf-46835d860f2mr33059192fac.7.1788272930822; Tue, 01 Sep 2026
 07:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v4.git.1788222476.gitgitgadget@gmail.com> <d8d11ad246b2e5ca73ea131e908d74111bb0fcf9.1788222476.git.gitgitgadget@gmail.com>
 <apa0N7VNNkcKurbi@pks.im>
In-Reply-To: <apa0N7VNNkcKurbi@pks.im>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 1 Sep 2026 07:28:38 -0700
X-Gm-Features: AcwNN1VWrHRos2docY5ke11ThnLgHUwhYkf0rZh1ntIBYZtLjxSbyiyVFiluXc0
Message-ID: <CAC2Qwm+dOZedmzzui5TSKJ1FNEiDypwUwVqGBgttG_OvDWQBBg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t/lib-httpd: document writing concurrency-safe CGI helpers
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Sep 01, 2026 at 12:27:56AM +0000, Michael Montalbo via GitGitGadg=
et wrote:
> > diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> > index a216e5376f..8ca09fe85b 100644
> > --- a/t/lib-httpd.sh
> > +++ b/t/lib-httpd.sh
> > @@ -159,6 +159,17 @@ prepare_httpd() {
> >       mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
> >       cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
> >       cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
> > +     # Apache can run the following scripts concurrently per request. =
Make
> > +     # sure any state management logic is resilient to race conditions=
.
> > +     #
> > +     # For example:
> > +     #   - use "mkdir dir" to ensure only one request "succeeds" under=
 some
> > +     #     condition (see http-429.sh).
> > +     #   - chain (&&) atomic operations like "rm marker" (no -f) with =
the
> > +     #     logic that "claims" the marker instead of relying on a sepa=
rate
>
> Nit: I would have written "with the logic that is guarded by the marker"
> instead of "claims".
>

That makes more sense, the current version is  circular (rm is the logic do=
ing
the claiming). Will fix.

> > +     #     "test -f" and "rm marker" check (see apply-one-time-script.=
sh).
> > +     #   - use scratch file names that include the process ID ($$), so
> > +     #     concurrent requests do not overwrite each other's state.
> >       install_script incomplete-length-upload-pack-v2-http.sh
> >       install_script incomplete-body-upload-pack-v2-http.sh
> >       install_script error-no-report.sh
>
> Other than that the whole series reads a lot better now, thanks.
>

Thank you for the call out and taking another look. I really appreciate you=
r
feedback!
