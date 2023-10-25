Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972D29427
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8rbb7Bq"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65710D1
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:26:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-540105dea92so6616173a12.2
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698244012; x=1698848812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vc7137rh4o78Jc2V5i36Jvuthsz0P2v3KPLqy/wBtc=;
        b=y8rbb7Bq5vrE6B2IBg/ktFcGP/+EBdNx2wktVPNkRCbYtpa1iQw9vLjmZmV6t7bLhK
         H4EbK79ZsOSAMS6V6wykK0oVgI/S/7S6S3twaJuGIlRYz+d44d04xyhw8s2kNiXfLVMj
         R0fARN3Hd2o6jaTxy1pfsJSOQcOTyXjOa3s2v7bBXMltIxIuIDyXrk61tFLon8m/BQCt
         tU7G9QMZ3wVetQ1+amNrv2lyPEM5Gq3oULzpcv3CPBLFUfEy0UAGgrukxnBTKOqhZ43F
         pv3FE0yqgomrbLkxxA2z5EgQanE6C8tXbqPtu0PBeQOE6d/AK8h3w2w5gDoOEKLTtw+N
         n7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244012; x=1698848812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vc7137rh4o78Jc2V5i36Jvuthsz0P2v3KPLqy/wBtc=;
        b=RXQB+gu/kVsQ9fdKEdmNxCHN4y81mt7HNR9C9VEGq0SadtPt6EPuBJT2fdqRXbxDSr
         GfNx3f7tQl90EBxVg7sVRVu/omPXPUvQc/K4GuF4gcZEmwn/n/Up6eMizIyobZqC7H0W
         +109UWpeYbsAanURuc21JlSg9x6yIPCUeDzoyAizAYKdxXwQHkjXSpu6bPF+p0+vIbil
         9PK14v8z0X2liiYKPMdT43Kb8z6/9L2m4sMo2xYvQuzx1qG6OVhywtgUrCxezzKSp4y+
         GU57QMggqrhC11lNZLm4pS7PaOdD/YQUzepX1TX26g/1m6jI2Me+SJjFNy+YisxNpK0k
         91TQ==
X-Gm-Message-State: AOJu0YznPVmZSzVeeM+UtG1aK3FkNC7KRPiaAHmQ/o+q75E+nY6r4KmX
	Fr7BOanJmjL6DgFiHrhKZaiKCfXZB6fDsfMZW2I7Mw4YJ0kltEDE19U=
X-Google-Smtp-Source: AGHT+IE7XFFnwuaM8lyw7QYFZ7p97MnRBf202PD+IbQrEBdl7PnmXtjRXrqMMUR1qPBrdmGOZxCCcwQW0mbqvbeKTj8=
X-Received: by 2002:a17:907:789:b0:9b6:5b56:bbe3 with SMTP id
 xd9-20020a170907078900b009b65b56bbe3mr12120607ejb.72.1698244012098; Wed, 25
 Oct 2023 07:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698152926.git.ps@pks.im> <xmqqttqf3k5a.fsf@gitster.g>
In-Reply-To: <xmqqttqf3k5a.fsf@gitster.g>
From: Han-Wen Nienhuys <hanwen@google.com>
Date: Wed, 25 Oct 2023 16:26:35 +0200
Message-ID: <CAFQ2z_PqNsz+zycSxz=q2cUVOpJS-AEjwHxEM-fiafxd3dxc9g@mail.gmail.com>
Subject: Re: [PATCH 00/12] show-ref: introduce mode to check for ref existence
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > this patch series introduces a new `--exists` mode to git-show-ref(1) t=
o
> > explicitly check for the existence of a reference, only.
>
> I agree that show-ref would be the best place for this feature (not
> rev-parse, which is already a kitchen sink).  After all, the command
> was designed for validating refs in 358ddb62 (Add "git show-ref"
> builtin command, 2006-09-15).
>
> Thanks.  Hopefully I can take a look before I go offline.

The series description doesn't say why users would care about this.

If this is just to ease testing, I suggest adding functionality to a
suitable test helper. Anything you add to git-show-ref is a publicly
visible API that needs documentation and comes with a stability
guarantee that is more expensive to maintain than test helper
functionality.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
