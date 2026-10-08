Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496E4218A4
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493891; cv=pass; b=e8bBUZok/MJq9/aomIUHn+kdosTxmLxl47CO8vnL0vc4QaKzxIThae6lIj/fsuBkG2zextnJG3MYVDFghs775BlL+4zwxeQ3Vw5tjqTnBkL6kVn3bYoF6eud9YUtayqFj2RMAjukXuyxpVxTNTawhszznxZLB5UUAtm3cZuWAcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493891; c=relaxed/simple;
	bh=Y2DoBVNqA+kpUwk+lKsUXJECJ/iEab329E/DoVudXw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJFp68VycSzwSOoybe2LIEBnc8hoSQo8I1gOCUYx2jKEceUCdcxRcWlhqmN+8VyX8FQhoMFln7R2k+ef0Gn2CG/QBS1EAB1g9jIEkeKnKQhM68IyIwWmv/05bmN/o/NPxkAs7ETOR9zzLUQFP13jYvCKuiQoudwalAmwqNF4s/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSUFsBFo; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSUFsBFo"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso26395981fa.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 14:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791493887; cv=none;
        d=google.com; s=arc-20260327;
        b=QOG5Ruhblv/IuK0CN0a77x0rJfvHn5hgjArBMrmU57I6wlTfhydlKS6q03Li7tNij5
         8PAoUa4LGn6769FtwRoMGsmd9dF2KmmS5Qtx+9zEfRaWUU+Zae98jYu8heyLGs15k0RL
         ubUI096fxJ1JuXlKJf4WroXdgbIceciYHejKv80Pm4ZpqyWKpoOvFbg9WHq96/uRjW6b
         zaXsd5jL5acCCcdkO0FQWpFmRdHH4gcZXA3VUbsXqSCsJP1xszUxuVDJhu1o9ihOs2bk
         1YTPtu10vzQR+w4GnS9Ohr79uPohWWRSZsc5Lql9oIf+AMYXOYUlDyXX7usmLHKX+cCH
         P1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y2DoBVNqA+kpUwk+lKsUXJECJ/iEab329E/DoVudXw8=;
        fh=qT03A5YgtGpaxAt0gAjUqZrvGID+Pe1LF3Fz0GOboYs=;
        b=TaiE3gj1OQr6FqMlBeU3svMH445XDUDPBt9GbR4n73T7LKKzJXhQLrE11Hq/V85eaT
         kfe/KNL/pU99QpTBm12vtxlxEjTYIQAUpvTd7cUEiojs3RME58+zHSjSjTBHQdtUeHId
         BWGy2yiQIkJeQRgSSQLEvzAinTolZanj2/sdR7P5tP5vckDcV1sOZ93mw0e5cslk6F/P
         Bwe35NBbUQmTMtw/qFTOffClsKbB2ideYPHlKiV4Lbr3sOgDswIhFlCB8BequEggSnVU
         +d2qPlpZm1+4AzWY7KZlB9YizgWlgYeq4eBh+bUyXerKZtkONthSobvtYLqu17SqooT6
         48lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493887; x=1792098687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y2DoBVNqA+kpUwk+lKsUXJECJ/iEab329E/DoVudXw8=;
        b=nSUFsBFoe7N1FkPv1W7n9j3oZbWIJ1Dwcrkxu6xznOzTJfYzourzXhl78LUUEWuMSO
         WfzO8mn+PKKbtWzb5WbWnS+sNHalzfjxuJ5atgZF4TYj0C3mQ656G6sZoA1EjlDT9jNE
         ezI9QzRP5IY/xZp/QHfzCPTq5A2gkbMaEZEkOQz4XJX8vON21PsHWhE5p001BYN95PSM
         tG2SYKfHzusyL5cTWel5F9Iq4T7i/0a6rn4Qk2SraT4WOpahX7VkeEEeRgQ3jeEbWgUy
         quPOO8ZWwY5E0MXaXnwhFz5LXZyR5RntyQFFZkZv/0/nnq0A97nXKZp6JCMxgqm+HUI0
         w82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493887; x=1792098687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2DoBVNqA+kpUwk+lKsUXJECJ/iEab329E/DoVudXw8=;
        b=Vmp8mp+3pYaH9fT/HUwIUfwCrrBIovQYynHuv5LC78nx5bQFoKinGiHBXbd3eVP8PP
         wd259WEYTJ3dw1NhPij9pXH3qtvlFp8UP3gNic7hAjJN9y9LBNstpekcyDrVNSPyQE83
         v/NJotTelq7QbBIA9GJfFtVQYvmywRMfFV4JfC2+HX0857rofiwJDLqwqBM96L5viD7F
         rKFZo6Ecl/vxp7ef/tBxHC5DkR5a660ClouCEAsGoV++978A5BLWfOy4p1RC9XqqvaQX
         OxHVYtBRjaLB57fgEQ0tP0Tcx5bWdiRfXSbHO5F8Z2xrd27IjAlXRG6aG3Q82NQxorYr
         g1Mg==
X-Forwarded-Encrypted: i=1; AKwUvBxWNgtDxiMf/LB2tiCIYwhsDuwI4Juxix8rgoIlaOsWSZiXw45z+U8vGxLJAy1moteQfUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZMiPUl70HOizwFLqL1NzY625K2XYM3da+eLPzZU9IdjCn1eA5
	HRzOxMbNg91w88XlzwKcXQgVQDOAVfza1kLTmGV9wpXip05wpI5hudXw+CK0ibZCKmvVedVcJ2T
	HRihqt7dboBTcJ1f6dCEywpE/4k9rqrs=
X-Gm-Gg: AYBFou0e+iwnJFsF8GhLzwRbmRwfdxqPl8FBIi3pFDwn+uQ2OyEl29Gty75h0BnDr0X
	zxA5l2myE84uTmrghurM9BLQjLVECWN5LQnPv1bnZKVraPBwpbSes0+ENBbq/+d+opYiwvLGQ6q
	05+713h3BiEo442B7FsKEDqzZ9RS98dkeWfFRVz0MwhrEitM406oGXEAASq904+CfJoD+5YHmOg
	uqyYoFLrlnJqPz+mKELNqb1TpYGMsPwVAZEquk0Ny+1/mMzf8JssVycqmUzpn0y2Phj7hYfjVb3
	RHYGRSdQGZ8dQkD3lk5NkcU1FlDNbuSukxiAYNSrXlM8XhjOaJYiVbM5dayqSrbhwAjXbSCgsVw
	7uVpxU2VuhIOAuumYJ5DNLmUvprpCIWgkkUGod3bL98/jE4O2BV/2geMFY4T9bl7780hXsNGp
X-Received: by 2002:a2e:bcc3:0:b0:3a9:9b66:c18e with SMTP id
 38308e7fff4ca-3a9c2aa7da0mr1235241fa.26.1791493887250; Thu, 08 Oct 2026
 14:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com> <asdsIjNEUOpaAnX5@pks.im>
 <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
 <CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com>
 <xmqqqzi02o22.fsf@gitster.g> <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>
 <e64d1300-6c37-4ae4-9377-77dd16f3cf19@app.fastmail.com>
In-Reply-To: <e64d1300-6c37-4ae4-9377-77dd16f3cf19@app.fastmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 8 Oct 2026 23:11:14 +0200
X-Gm-Features: AclHuK8dLpNKHz-YpUfr5cRepXwnQVXxnlSI7SM3GjAuIMN05jX5Ys2ysb_13lI
Message-ID: <CACQ=SRG86pgS+BubOk5Ud6bbeiVOztWT-=KLveJvZt_iKoztRw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 9:20=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:

> Augment option #1 with stating upfront that one is using a coding agents
> and to what degree. That=E2=80=99s full transparancy and people can then =
choose
> to engage or not.

Yes, that could be a rule.

Thanks,
Maciej
