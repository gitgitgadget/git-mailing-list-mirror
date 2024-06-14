Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA84181CFC
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718401350; cv=none; b=K8ihv4GZ5EUTzh7QsKIs4U5shoVZUkV9/BvN8IJ/5NI2TgQSI60a5DLqA5hOWUG7fNEjTrvraDzbVva1l8ziB7GKY/U35jX4LK07EyJu0avAg2d5zHnamgBixRxdrOac5mPbaXfAgBVMlobOWHZdSLG42mCincn20xlG4XOZk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718401350; c=relaxed/simple;
	bh=RrBK1ubBCaJ68yQwjWp2B6yCWSoXPNguI14BpI+1VVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5NWd0UofQT8AAoZPQaJsz3In7QKJQsuXhBaISlDcpskvYIRLs16eYDHzF1mgr0j5o9RPeZq1lDq1z7PTi5Yz8wc66+4pQuoz4t9fNwQqBjD1xQ6wVFRsf7GXKsapJMJSv5QWRGM+ytzkk/onIDxl1l3JYbZ2mgj8/DLN2xEmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSpRV6mP; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSpRV6mP"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7ea0b5e0977so121976139f.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718401348; x=1719006148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8X3vVnandVHqqE5BZ68IG4f4/wjJNKCzTKQ40ufsdg=;
        b=aSpRV6mP45A32WngkSPV8jekZ0656w0+zlNKAs+CWMlUHz4hzhbVMF5zU9yavHIhmA
         Ej5tWmuZGDoAsZSQyTPBlNOVJ+/MNUe9J18W4Ss1BPj/GKoNz50vlfNX0bfVyfkI09S/
         6nwXgJMHUP+yF7FdiQeawX9/Har/gbqLAvY1vPv//G0dORt52Zkb8uNYUHDdoSO8OP3x
         IJSbTB+T6NEXZc2gsXncK5XlNxNCgo0eBancy+upI+5LyZSev+DElIAeyWJY23sYEV54
         eEL+56QfgCb1NTKtSv892+BrGpVosRvBSspZZGYLl4PM2Mv2+FxvpG2+vROUEJcCO2pq
         4tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718401348; x=1719006148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8X3vVnandVHqqE5BZ68IG4f4/wjJNKCzTKQ40ufsdg=;
        b=DeSTADgX7yNt6cnLH5CWTK2Xkigep/sOVfxT1npE9byYdm4VkCPfj32ll8oGRHois5
         pTlnlf639hyOvFoyfUyophzbXlfNn97XSL+NpURdeN5dFMmyr+YKOIXkSTwFjshAoObU
         ePW6tlcBFRyzaexV9KdNE8Y1kV7fra5APe+QWN3bQf076NbAvl7WtPJqIol+2UkGIqjO
         njlPehyEWnv3L4A+tborexrkABUTCQSuFTMzxmv6bYiCM+tBmqpDMa1F1zWLmM/zCOrw
         /FiYI2FFHCo1x3OELChomHhQYJq4KY9AKt/oc2YuPkYcDYi870MHKn4a2p0zi9KAupU3
         wlbg==
X-Gm-Message-State: AOJu0YyMy6K3/CcmbRCDlVS7vs+WqT06wAZP1GfVbPnFS5Nyty7AiWQf
	queNdA+/qXmumbufR/amrQGQ8OcYHg6SepKQJ55YXocLWAQscFn3Mql+g+Dt+Oo6nFk8oelgA0e
	zZizREcohTLmbDJtvL66BMidhFMZFfQ==
X-Google-Smtp-Source: AGHT+IFOe0pkVx9GX5TRs0Xs1VSjaKDnHYFDZrobAPcKHUqbKQ+renwfEMRZ0hv37+TiA1atogiJiwUXWAg30hlC6iE=
X-Received: by 2002:a05:6602:608c:b0:7eb:76fa:1209 with SMTP id
 ca18e2360f4ac-7ebeb4b8746mr360299239f.5.1718401348420; Fri, 14 Jun 2024
 14:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603200539.1473345-1-gitster@pobox.com> <20240604220145.3260714-1-gitster@pobox.com>
 <20240604220145.3260714-4-gitster@pobox.com> <CABPp-BH3ZozGnDueK=J4QvZMYZkS13Gk+0rhe+Dywqbx1F30DA@mail.gmail.com>
 <xmqq7cerdxv4.fsf@gitster.g> <CABPp-BEM4fqU9s7_dxgi_twe_T169mGjZN9-CJRLU5cjnUi8WQ@mail.gmail.com>
In-Reply-To: <CABPp-BEM4fqU9s7_dxgi_twe_T169mGjZN9-CJRLU5cjnUi8WQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Jun 2024 21:42:17 +0000
Message-ID: <CABPp-BEZhR8T56bwxpi+_uGG8w7nms+7HtCR45S4oVjPom9Stg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] show-ref: introduce --branches and deprecate --heads
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:34=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Fri, Jun 14, 2024 at 9:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > If we are renaming --heads to --branches, should --head also be renam=
ed?
> >
> > I do not think so.  It is specifically about HEAD (the thing that
> > lives above refs/ hierarchy, historically implemented as a file
> > whose name is "HEAD" that is directly inside $GIT_DIR).
> >
> > Thanks.
>
> I'm fine if we don't want to rename it, but I don't quite follow this
> particular rationale.  The logic you use here seems to be about
> internal details ("it's the file named HEAD") and ignores what users
> might refer to it as ("current branch"), whereas --branches ignored
> the internal details ("the files under refs/heads/") and instead
> concentrates on what users might refer to them as ("branches") and
> used that as the rationale for renaming.
>
> That said, I've almost never seen users use --head (and haven't used
> it myself), whereas asking for heads/branches is much more common, and
> I'm very happy with the change from --heads to --branches.  Also, even
> if we do agree --head should be renamed, I'd be fine with punting it
> to later in order to get this improvement in now...it just seemed like
> a small inconsistency that I thought was worth pointing out.

...or maybe my argument breaks down because `HEAD` is more prominent
and tends to be used by users more (`git reset --hard HEAD`, `git
checkout HEAD~1`), and thus there's an argument it already is somewhat
aligned with user terminology?
