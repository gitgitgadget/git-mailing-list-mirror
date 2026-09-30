Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDFD4F93CC
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780350; cv=pass; b=r4aQx6u74uwCIyACsRpxdzmvaHHkazgljTssQWkYOaFvu5gMjdotsdb7dfMFE+2DYElmpaet3ekhj94OOcBFEbTQC2mxf1Z5qEyHOT69avzCwXIhGlXFz6U7R7KkGmeOj8tkUteEn0IIwpraPhUpN2K9r5pqdZ/R0jAAANoTFZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780350; c=relaxed/simple;
	bh=LOaTrTHU6SMtjpF0MGNE0i048dgVpu2bgweGs5lS8y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRUfBNbXR3p4t0yGkTI7pLS/1ZLjpISEKMoc+9fx24XQhceJB5YcwIkBMnLktjwNIf8Dh7+aZf/DZ6/TFbYMfOjoJSeNtqhZjqV1HjYJLMDL1FDcSgNY6nLD6mThSL3Hi7xJA4A3a4Ex+TiSV/DEigRi3jn1X8RmZaoJgBVg6Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGhpznxe; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGhpznxe"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ad795d5205so1086487a12.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790780339; cv=none;
        d=google.com; s=arc-20260327;
        b=HA3K/6RPQZO5xEIGxb72H3Vr0zd6j+ZJ6ksE+e64vcjXq6NaeJ59MQUjuRo8+lTeEN
         vqUUc+WhZ86oH3699fE5Eb68Jkjkd89K28o9VmomqZhaSe3aRyiU56oKoyA1wiPvXvzx
         FTZ1rciH7K/zFAunFlODexEfGUGc7Eeo3BPDsL49U40mWlqEsjiPuT6h9sOFuBI0iDsU
         bRlrsJ7E0yw4gBZEiPXyHIJmpr60yyUCbWYvPNU7NRly6gBogtKakmNKznLit4gBuLFL
         /emHDr/wXcFdwuY5FTM2KFlA36Mlg0QLiMGD1FPPg8dpLnrjYX+lZ23RJd949wObf/sT
         uMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O85meBPB/8uu1eE8XWBQpTM/UXm1Xkmv3hLW165HqO4=;
        fh=xhTNA0mJPQkXgCl5nb8pmfEc9l2jOBtNjAD+skEbj5M=;
        b=dhZJmScKW2LxwrRaSBIbtJAy/9TLq7J4KvmN7Mg8QxvKblHU6c8JRWJ+0SLWEUCCtr
         +/D5v5JxoMCMPy4xOdoD0MdoOGRHoz+485J8y28D1QxZNLwHc2y1OsARaZN50HPsvYW0
         5sQlmmpDe9F59tg58OSU5XPdT6rwOemL6aWNQAU4B433pM53y24CMBHoT24jLx+OnJuZ
         bN6uD253yrOu9DA0ZW7V4NUuEqCsFq1ROuhDqP5Y2lRyQ8CyHqNuVymiPuOEe126OfKC
         5P5PD7LNTFgCvWLNOdQL9FS7H2cNn7BD+hJ+DDF/flfC4OcOsupy2hqsDmMkjmQKT/PP
         Zopw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780339; x=1791385139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O85meBPB/8uu1eE8XWBQpTM/UXm1Xkmv3hLW165HqO4=;
        b=dGhpznxeZXhtn590lKsB/0MECxd7eGo7YaJfYrniAusgxRZjmc5JA4J7vLbwAdwfaL
         fJNeFGt2gatFV0EE6s5mkPyH62Ggic5Z8ilmdTEIg+XWhsn2oB2Th0M575pRDnufJuMx
         Hp7w9vTVJ5l0Dx5UTYw6ppY9kqoksRbzFERekLSFul+oIKAoy/Rl0ouOxgfzKYbj4zXr
         1vZU3LILDXILlNuVuck9RH9odzpY2wi86fAKPvyhZMYrg80epoS9FYPjD3l+0vzwDaC+
         DGZ+jU0GCf0ja99Mo3bGmxRdWeDBHWyy66Yd2yHU8s/42SBWMzVtPkT7oK25UmjfkxhU
         RiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780339; x=1791385139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O85meBPB/8uu1eE8XWBQpTM/UXm1Xkmv3hLW165HqO4=;
        b=tYp/XbMhSxNiwlXmjr/OHfC5ihVSY7RsW2R4VMCC99EPXvF6d6ptccO5gRCTSxpxAl
         Mva4Z1oLaTmDn543XjuTq6Mr19CAC35xhL+dOejYH/bpH7OVOlNJ+vtiSgUTyWAQbN5/
         fYbbZyJ84+akwWzkHnevTlu0DrMGsZsAt4Zb+StaTeRpk4d8J9odkRG2jCqsCbv5ggw7
         EbbWtNus12uT8JpnelMpt/sZUWQ6aFD+WHff2/S6FVJVEEHnVEbhnUauVqnivEserP16
         cch2l727GVdcXU/xmrJKa8RxGmAV7a7w4nGjqqzvsC1A06lWdkawBP8HkhKGL9sETj/g
         VaLg==
X-Gm-Message-State: AFq9FYJeiUUrmKycURijq5dV+S4JbrI+NmP8JZppxHAaRw3/6PLN9IiL
	3n0fJsok+USTB2d1P0LqjOEhqTHKVXCVFlHea8Xp2UtqM6rD/YW8jZXgmOW9i8gqi6yG90dYjBi
	iiR+ft6eyt0ksCDuTCBKfDeHKE6n58D+GzgRs
X-Gm-Gg: AYBFou1BoG/DqmBOyxSj/nGdq1fTloYGH3FLjXmYjcQyBxCrnbmtNdsdKaGajpfZXkT
	y+t40Z6cbob0lQUQD4mJ0Ikl5HES7cpQdDQ5LaQkMwdoktB0Za13E/pB7oxHMQDoBnWaQjQsmBw
	kHC82CME5HcauIqUGQH7uVIrYUrvLNCkwK/f6ehxXm8EZGPzJRCYyX5HF0jRl9Ce8M95FGyxd75
	P7VXEw9msQioT9T7EQ/erflt2VEHfR+2Hs2W8OERbBmBcvSisW4+q7JEU99vdB9XuYpmmCntn4d
	eRpP1Yj9bQkq6RHtww4hR0bFB49oCjIfnwIvONjVxgEz29gYwdRRmCE45XHX2y4dw5CiQoTFs1l
	SJSpLfbeXTX4yX3trhqOC7rWhgeHnXKWglNCxzLqWXxsSj9bVKB4J35By8UCZCf0nrXw=
X-Received: by 2002:a05:6402:43c6:b0:6a7:ee56:6160 with SMTP id
 4fb4d7f45d1cf-6ae19949dffmr1219130a12.34.1790780338635; Wed, 30 Sep 2026
 07:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
 <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com> <ar0gon2VE0RlG_cC@pks.im>
In-Reply-To: <ar0gon2VE0RlG_cC@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Sep 2026 10:58:22 -0400
X-Gm-Features: AclHuK9IMe_bU9B5uxXZTr8lSZXQAUCu8509BfflnhbugDkQRv9wLnBWE6EbguU
Message-ID: <CAJ-ks9kYC3NM7BY=gYKxVL54nOkH4wp9TdAJye_8ifNPa7oVdg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ci: use cmp and align job-count selection
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Wed, Sep 30, 2026 at 10:20:33AM -0400, Tamir Duberstein wrote:
> > Changes in v3:
> > - Use twice the CPU count on both providers, instead of adopting
> >   GitLab's existing one-job-per-CPU policy.
> > - Include CI timings and their tradeoffs in patch 2's commit message,
> >   and explain the use of sysctl directly.
> > - Patch 1 is unchanged.
> > - Link to v2: https://patch.msgid.link/20260925-ci-large-test-resources=
-v2-0-f632cf319756@gmail.com
>
> Thanks, I'm happy with this version.
>
> Patrick

Thanks for the reviews!
