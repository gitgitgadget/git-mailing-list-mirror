Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A152EEE6E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397793; cv=pass; b=IWPTBGaDXEzEjpnm0eQ4UjUTEtCXHZjTJQEzS/2fTp76SaWI7NVOH94jkT8i7uyQnkDMJ9EO6cea8NbEFOTEtnDHMtZjyiCHvEI6THhDsydZEviLmInbuCUVGhi/3mX6zWzxnUZXP5NRqdYkU7d3704mRueiv8JD/U8R6lkNBE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397793; c=relaxed/simple;
	bh=WTcoB8yNCyiErVQ8hKqVPI5TYTyZxBe/aH7zieSplAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qp1Pafxa/rhD16yGK+WUjlpvhuIKp7SUuAkaw1nN4v1Vlgo5hivdBUIeB5m/mjCSm+7BF4nXJ4RGV2WUP+v7PfV+a9n1BcEWrVf0Rp+jXY95xrA8xuubZJZ0zILAewyn4mGDEB3sKTjCqOSF61jW/jTsg+SNkRYZftFHXWOcl/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8IT20l5; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8IT20l5"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efec2c28f8so14675656d6.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 14:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786397791; cv=none;
        d=google.com; s=arc-20260327;
        b=kGwuJeF4H9sbS70p96T/2HYwxlwaDJoN8WebGgxgCGyROserdpJKCTlVFWi1d9TYgh
         iGMCrcijdBbjBO6xV6eKtAdRPC5woy97w5iY6sFUAqp0dt67LFCsFd/uOACDN5nddYZi
         FTMxiGlzbTe2vaVUuCkxItcg/+j3MMywTrHP+5x07muoVy4ZZz/hD6bzscGqBH+/iElU
         Jcxr0TdyUuU026BhjuDP8TmsQFjAXryP6Drw1nnB0Z6UMbPPh1kwv1TX5asGY+ZgDMQa
         Z5UmvCQj6Fiaibipv4iP5SIU/3KYrUAySMNKrAXZBmmdSEO88Y3OjwbqoJy8VK2QgIA8
         OOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WXw9yPf6U88cNOiH7end3RJbD8+Vbq0Jv7JRz7pDyBc=;
        fh=Je+Ogu0BJZp1fAN3c+gBvp3co2X9r1YC0xXVFNYi8W4=;
        b=dsOtVDYB7sF1hCBpN2xh2TKRpayBSdc71wzrslS3pVVpG4MQMXa/aAZjwU2lDyTvJA
         2rUGRr2GlpnjSWBH1XaWXW/Jv0/qfYUqBcjUXSCu0oRT4ZZfcvnDdSlcsDPtWwn8wHhi
         7w24QzvGKMkZb3/Iicir+YgE9sp12XuJ+AxqpV6CjxJFkhiwWua6x+deeqUEAO+SizQY
         SQyhsPTIwHfVR4GyiWOrhWQucFse07hhNUKribTG61BRGPAW0/eVpDq3QoPHL0rrLAbw
         I0fQpNmdFxpcP0Ozq2guZo9aZK2a/sl66of2U4LvkBlqnUPWuJzMQnan13k5RY7dcEzn
         b8JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786397791; x=1787002591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WXw9yPf6U88cNOiH7end3RJbD8+Vbq0Jv7JRz7pDyBc=;
        b=F8IT20l5ZHGNn8i0hrO/+kWNmDCV1QRKVBboG+FrRhvIpAeG7blwLF7BGXKHwE+Xen
         URFCxsrAhRsBihJPxX4P9VM+IGSQ63NGAx5Vm1wa5arV0XIzDqfP63k2MfeHCAcrMfmX
         hTUbBzUR4+jdR4UEwZG2LJQpxcpLcF9E17oNcWt7Hsfn3UrY/qbIDrpNUBbehT0iDJDH
         lqlx/hiBr6vym24acCn2/aOnHpd/LMNZRJHzZJ0NL5l8HZzEU9rq8O4nO5emIVgne5or
         Ritbkd5dmMtRTYXb5AdoqzpB+nUEp01C5wB8nC59YRm0YGDCTTqlicH+hG82W8Tkfu08
         cNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786397791; x=1787002591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXw9yPf6U88cNOiH7end3RJbD8+Vbq0Jv7JRz7pDyBc=;
        b=MvM8YBcUl33n0nDF9TikKjbHSy+VuWf6z608ntB9kGEKXalfuQbfEfjtCFQxeNAe7e
         1kkP0aR3a623HbUmHO40kGDBPerwdMGIEfi2UmLfuU8R45Z1wD5lvLsI2XSozgkQmycE
         1zWPGtgFg1IQTcULEs3icprFPr/1gdC1JVdxhEmTaoT8FVwQzFko8+OCH3teZYAnDkO4
         U9O2CuauTxpSwNKkrwrsVTtHUJFCx7LrdAcHULcWqkm3iH3T66tQ/mCLdqGGDtRIHLG1
         RD13ObqQ+53dk0/6BWDEj6CBndMjhyatnDlnV05CU4B7gcdHgYTt2EsC2pbm9TU+v0uL
         YsLQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFkF2QBfKH4w8MdDrml2KJITukX2Vz2QItimRxVup9/mMSC6P+MaqxZlj7PIsckvFL8K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5At/eC+7vbxTSMSM/HcncIMxvZklgxWUQgD7twYY2C03rEd3n
	q4jyt1HPKc+7srlsz+6/Mp/pTMPHIlK3oZRGZpOfdhz61lJt8ChGl23Sv+X29Mb5QYr2O3W1NeF
	UkckulbcTEIgVG1vd+XmGVM2xJTQE850=
X-Gm-Gg: AR+sD12XX3MFGM4dAOjlJXOeMcmImoyVH8xV0PyyqOQ5OBKkuQqCXxpj52n4XXU0O/x
	VR1SXj1K/haWyjIcOcl/l0EeHo2GMAXulZiSag2ou2uwTCe8LSAFUki9691q523iSO7DGuPqaiy
	AoRN3MfS57dXhU/poHRGerlZ1Co2111UTmu0RwlxYtysG/Sm4yiDvsnDUFko8Mm9jzehRUl1VVr
	7a5YhPWbzavf3e98RsJ9HpDX2NMZe4JdQdrzmS0px13w3BJVhWHUh5XXdnJ4Mmz36CPISNaadxt
	Xngg+ETT/SZcHsUZ0pcPc2XdSHqnEBCA+c7RgSQCeh25dQcvtdcd9vznyvn6uTgDpzLepZrY5Xj
	EBQ==
X-Received: by 2002:a05:6214:2585:b0:907:b32f:9b79 with SMTP id
 6a1803df08f44-908a6f63efbmr289923186d6.6.1786397791154; Mon, 10 Aug 2026
 14:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com> <CALnO6CAdr0ft8KFgGCFX9ueKUdX9-2DwB+SNs3Q8ykw4ne=54Q@mail.gmail.com>
In-Reply-To: <CALnO6CAdr0ft8KFgGCFX9ueKUdX9-2DwB+SNs3Q8ykw4ne=54Q@mail.gmail.com>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Tue, 11 Aug 2026 06:36:19 +0900
X-Gm-Features: AUfX_mwS2TyPtnzcp01QvAPqjn9oTSw_sh1su2LrMFuBWtQ_agBveZkj4K4sR0A
Message-ID: <CAF5D8-u23Z=f02vF1yAHGKRED8DY-v5=BNf7w-yY3vEDmJChDg@mail.gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:08=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
> > -static char *dwim_branch(const char *path, char **new_branch)
> > +static char *dwim_branch(const struct add_opts *opts, const char *path=
, char **new_branch)
> >  {
> >         int n;
> >         int branch_exists;
> > @@ -781,8 +791,14 @@ static char *dwim_branch(const char *path, char **=
new_branch)
> >
> >         *new_branch =3D branchname;
> >         if (guess_remote) {
> > +               int num_matches =3D 0;
> >                 struct object_id oid;
> > -               char *remote =3D unique_tracking_name(*new_branch, &oid=
, NULL);
> > +               char *remote =3D unique_tracking_name(*new_branch, &oid=
, &num_matches);
> > +               if (!opts->quiet && !remote && num_matches > 1) {
> > +                       if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_RE=
MOTE_BRANCH_NAME))
> > +                               advise(_(message_advice_ambiguous_remot=
e_tracking_branch));
> > +                       warning(_("'%s' matched multiple (%d) remote tr=
acking branches\n"), branchname, num_matches);
> > +               }
> >                 return remote;
> >         }
> >         return NULL;
>
> I suppose the extra warning won't hurt anyone's workflow :) so that's goo=
d.

I removed the change (advise and warn) here in the latest patch. But I am s=
till
wondering what I should do. I think a warning would be excessive if
there is no match,
but the user might want to know if there are multiple matches.

Thanks,
--=20
Yoichi NAKAYAMA
