Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A173C2B8D
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788495626; cv=pass; b=u87H963SjF56j7WKH0UXVsH/En4VpXo2itk1nLIA682muYtUB+AqI/UniuPk5zX9ttIAL4vOGWRT1hXtX2b/t00AUrw2z1NALFjM8wr41W4TxQjTef8+RVfUDE/SJujOtXvcMqcl8IK0Sh8w2h8Gst4y04KcILz64gBA7zoctxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788495626; c=relaxed/simple;
	bh=wjh5m5PkBkscpJBuNS73qBRq8YpWR3N7XQhUMjUxr9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKhy6GZprM/bJ14+mRCIgqyIgA72GbNlO6wGs2SFIa6qLQp7hpG7h178Y9I04CASXdKLUvRHJXPRGrIfVPxUojf200+yzFew+R4CVWuxMjgn4iZO67trPzIxjQBJ57uu1p7o1Kw/KXKTSCoSEWrUyTUPunVG5OifhMUN8eczrj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3wyKG1Y; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3wyKG1Y"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398b3d66515so676872a91.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 21:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788495624; cv=none;
        d=google.com; s=arc-20260327;
        b=EsDS51XSgh3E1epETqbauLE9KXHRkXWaenS/3BSAT1zkEqfYeNvm3Hx8KyxrDHS61V
         CULZuP2h7UWCk38ltHSSHzqPi4hmrX9eG0EQ9xYL8KS6BxkHKpDHhz0HBr1LCC/D9hLj
         kSScmcdsK7xOCTqB/zhRcv/m++IQ9iPAxGReVOQk0pZjWVMu4DkeMyrjaQ4T5ObDj1vJ
         wAUomARdUzT5W2t+SCgxDLtR9qTsy7fFhzaHUe9UOAp9h2zh8hoauj2Nl4NPprzf9r9Y
         dRHea+XsCtJgv1zJIiXVexZLengeZmqBLlm+7vbIJoSH2GJxj/WZIZggrQynUUxIxbxB
         JC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0TaadjcswpVJ7gdlqVT+LusxbtPBLj2KVIj8M7HV4I4=;
        fh=7IIR9kjCqncO1CW7J5ahq31tTsPno8p1y/IOYXP5f0w=;
        b=cGZYq9aQlvxtw4i0QrpBrIy1Sb7expJlM+qC8mfr+JUYYGZKjJG5XyMKH2DF5L09ct
         XRNbVl9V1g0g6a7ynh6+WU1H+W/JoH0CrxWf9ccfHIZxayIlZi8le64K46Ihid08iitw
         2c84lrMJH1a7xLDsFiy03ghiSRsuTWOJyK7nC1Jo20bVlWsAPd4nLRIER/W72hdXVQlo
         gKHXmyPTllnskxbJXhIth5DSZLAmPALkpVT2HUS3bHiFBrPXHKgW+PUyt04VfXl72LXM
         bk5xNRXWwounccoqpcqbvpXE/rCo8bNw1gdD1Ohr4Tco55X/t27v6EKEh3yOYMAwjb40
         p13w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788495624; x=1789100424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0TaadjcswpVJ7gdlqVT+LusxbtPBLj2KVIj8M7HV4I4=;
        b=J3wyKG1Y5WwbjyZI+6gSo1xg3BFmG7vXDXTIX8mD2OgMCSXE5juwtAUF6w6vF/+Lpn
         9E5udBGNCmUVcjo/iyHyNVE7Hd3OdeYzTY861TEAsoyGLIWupDYxCjLVa5/W6EaQiAZ+
         lSjp9Udy72gGq4u61lP7UptHpXxsnwtMq7P3KaYWzcX7/1N2PYt83McySiTBj4JBhdt4
         uQk6TebmTjITQUdihCrNflN4XMhSTcMiYOw+zgKkOdcZF9hIeb3NYLV1mTdKAm9hYqjp
         za+Ov9b3i0xmliyYkALzPlv+f+wvE37iVnle3/wMX2w/4cx8oF6oz7fyneX9y5QN2cGm
         jXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788495624; x=1789100424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TaadjcswpVJ7gdlqVT+LusxbtPBLj2KVIj8M7HV4I4=;
        b=G3vIN1Kyfd7Iv5jToSylgIMLzFYxbUOpn69dj8YiU10wrwR8dd70BPs7buynVp8wFt
         CDPJYJP8BtEroWubAqkC8Obs0rz/+targV0MARnkSyFNGPHPdqw4xuUOLhdbo/cVvdC3
         dp6jCE/Gwv2QM5VUSOCyXWXXpC7IbA4WwlG/qGhLfOVRAPS99fEUR5vjJVYaEB2/60tE
         GW3m2ugxsDduFdynFGgehGD+md0IsQyG1K4Ui8nHr+TpIyVy+AAx1xiJZ4d6L1wqOOa2
         uI9px9NmYUoqAlw5/DM+t0Mo+32cn0dW4+YPmUC9czzlk5DQbq+HAgoAJ9ZVIy/svfpv
         BepQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5a0TnbihtEkCtT6e/CH9/w7ChpWftTHYu1qH9XQW+szx+d1Ak7Cy90WSxJKeF7vDEeYE=@vger.kernel.org
X-Gm-Message-State: AFuF++kv+e7RGEF3Xrd61051hg265O2D/O3Gp6EU0RS1kCbGj1iH+fo5
	+jBhWplOENyx4sS3eK9//9cXKjb12N/9BpJEluuapKM0o/vy5tZ10GH8lnFu0w0hkQzywCTntsJ
	QbLmJvF5NHkdnkj8H8LaD3iP0y/uSXv4=
X-Gm-Gg: AYBFou0OAEo7Jhezi0NB2dTbQTtIKJWzFXLegD807l+vtzSyUBNjhWiyQuJ5/kIvErH
	BnB0W4FpKDcqVqFT82qI7JtlGftLHySyPtCyEAJVi1C+sKrH9kyD2Pvf135LPIovSuYq2VYlPZw
	IveH3OBHsK5Brw/IM9eBhmgFDfFsXzuge1/5mSSE20Ivm3Wl2zZuTiVRgRK0/jGsiLjPKe8f18a
	TpSLiBzSHfMXl6Ntq04Ndb4EmVpv0bkzkbintSNbrT0paVSST3H3Tf0cvzhSZXOpHJEcCNg3EKY
	nmVW34knsX+wxU71bN4dak/fcbUkeKyGLjhdDDg9MZo=
X-Received: by 2002:a17:90a:d64e:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-39b2612eb54mr5655778a91.9.1788495623745; Thu, 03 Sep 2026
 21:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724091152.27794-2-tnyman@openai.com> <20260724114948.GA825505@coredump.intra.peff.net>
 <xmqqpl0c8jml.fsf@gitster.g> <xmqqbjbw8icj.fsf@gitster.g> <xmqqse5870oe.fsf@gitster.g>
 <20260726074122.GB2366012@coredump.intra.peff.net>
In-Reply-To: <20260726074122.GB2366012@coredump.intra.peff.net>
From: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Date: Fri, 4 Sep 2026 05:20:11 +0100
X-Gm-Features: AcwNN1UwZmanWjkbMjKuBqBJfeI8hoGFlrB7M-uUbejqA9dqW24HkVdTOh9ogJ8
Message-ID: <CALk1092+d4kazT-cQuN3Xih2cJNBC8mBAbyR0YPELWT37K9KDg@mail.gmail.com>
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, tnyman@openai.com, git@vger.kernel.org, 
	haraldnordgren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio, Jeff,

I'm Emmanuel Ugwu, new to the project and looking to get involved.
I noticed this #leftoverbits from
<https://github.com/pabloosabaterr/WhatToGit/blob/main/leftoverbits.md>.
I have gone through the thread, the desired fix is to fix the inconsistenci=
es
in type by choosing/using a wide-enough type to avoid overflow (size_t) rig=
ht?

Is now a reasonable time to start looking into this, or would you
rather it wait until 'hn/branch-delete-merged' has settled?

Thanks,
Emmanuel Ugwu

On Sun, Jul 26, 2026 at 8:41=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jul 24, 2026 at 10:33:05AM -0700, Junio C Hamano wrote:
>
> > Here is what I recommend that we do.  In the short term, i.e.,
> > within the context of the topic in question, let's use 'int' to
> > match the type used to count the members of an array embedded in
> > 'struct ref_array'.
> >
> > But let's leave a '#leftoverbits' note here in the mailing list
> > archive to remind us to revisit the idea of consistently using
> > 'size_t' to count things when things are quiet.  This is not the
> > time to needlessly disrupt the 'hn/branch-delete-merged' topic, I
> > think.
>
> Yep, agreed on all points.
>
> -Peff
>
