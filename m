Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD530EF81
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410452; cv=pass; b=O9fniRl7TPuMDIjc5Y++tbwv+/E6v3NJYyJGCURE0xUMson85Glaci6zWhQFArHKraoEpyQ7xg20+2sIiLXP4YmhbmjboWd2MaTeRJ1LpyQoyCaDqnIDrlaV5dyzRfQ+wxSX2DdUAm1muPK74BfOne8DeKknXmZmcBzt9H3sLqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410452; c=relaxed/simple;
	bh=m4kjWua4VyJVY2u58Ftc8U4iXawGGuF67GpPyWFjcrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIkWjRSa5N1+k5LBfzcGWeCLnI7xdET9dNvYQamcoxrGYxHhN9yxvK+M02pvcri0QklX2O+RibMVx8TEs48wcYfTPdqsDk8G+OgvsCuBqZZs2mrk9GCQRtjZw+nv6AsDx45qJTdq4L+pVn0oSFHtOZmI7J1OgvLHxrtplHBXGRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/JkGerd; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/JkGerd"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-566390e7db3so2114255e0c.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 12:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770410451; cv=none;
        d=google.com; s=arc-20240605;
        b=k7i3+WMYqWxSJSV4zGIoQ82f3p8/NNjk1HxcaoEc55oMH9M7fz7uMh5Q8Zg6vL6hB8
         J2a4O/tOMXChcs1Ms25gin9F5bRIR5PkGTWy7AKZckAqQjRaXc7MKxftiAcpmaSfCPOV
         4pRrbOtSrs8XQeocblaKNuDyQLRbODeTJObPI5vGUw0/STXsmXAng2lY7B+CIey8M4Uh
         TYHw86H6vHZfkozfaruBn5eVCS2+zJQ/Kohy3xZBZF0Yx/KNciaalCw836ZR6xJk/Ypx
         yOSPuUspH6oB9ZaVVIM6f8FdPbjIHI/VRvIR3ScockK/wyL9+W12M3/HCPDlOY4DVRwU
         SXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zdzmh5WGMh16Bpzg7ropUAWy+VipJfs1pL31xn3PpgM=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=lVl+2jITJcj3PINpE87scef4UkLsoFYwmIxaoIWV05pPnTMuWFzlvOrx/mVlBybwpO
         LvrYxl9NjKIJWoR6ah8KO4L2MgbFh2eEllN45PyIiqYF4lFhasx2AXmMXBLJHEwutdUh
         vEv2laXI5G1BXuQtSH3awsMZXfXXKxACew+jI18NhIDWPiFg5NDIFqiSI0m7oQEnwNma
         IULscfgq5fm9m06IKsbPkCHXBUY1P3xZKOvhRlWBxGIuxbs8xduiGfe/NNZtFPgB/VIX
         8TIXFpUxZuMt0/DY0iNd6qG917ALCFkdwx2oMAq89NfiJ0rwNsc2KTrOsimS+xOCuCrB
         mETQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770410451; x=1771015251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdzmh5WGMh16Bpzg7ropUAWy+VipJfs1pL31xn3PpgM=;
        b=Z/JkGerd+EWUxuw0urxaW+qoOKgXO2w9OlDFmHWM+674oCXrRto0SDvTI7vLOTmz5M
         8gLkMjPfXoTxAyFnwOAdccfT3pKSdUSw5qEsxfylXRtrQL3gSHUTBQ5/l1kQeJX5acOF
         ClQdo3Y6vo2U0M3DGSgPgeJ6vjVO1/WaYDDj7FWpzxqHOR+7eD0ejBhD5j7tIZz+zO8B
         4EP/oPbh/K/9tc5uN3mlqGZfNAgcDnqU7L1xsx0/tPTWQSp9AOn/r0Du5RCsScIKby16
         GqnAxlUthiyyKPfNF0WoHWoxgV5RxqAepl7ZqO9+6OTqWEUfGNxzioGj9cyotahrUQ57
         HgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770410451; x=1771015251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zdzmh5WGMh16Bpzg7ropUAWy+VipJfs1pL31xn3PpgM=;
        b=wH05MACoOpu0CX8VyHwXDtNTUeym6YT2iNjvbzvxViYqPSUmKcd+h5nh7mOnDQ6o+X
         FDTu1j0qzl9tq/Rf4SMO/YbyR2p0jINno8DMBsDciaeFPbm1ozVeQgLOZvd+9y/DfMid
         Im5DZzo3IjCeyBvUtkOXQ6ihdCr3OP/6gqWor4O+KImqKYT+oyOYIV6kcXHBbYjRgOOq
         SaCAhqDxjEtp2cThDNPLZs8a7emOuYHlekVC+Q0PrrQcbYYEoydQ4KMcVrbOW/DR4zg2
         MuQvsR3qHBKSGkHOi17DjqQqwa2TSVRmAFn3q2mIxaLBuOZbePArmr+SPQSdt1pY2LzG
         k6uA==
X-Gm-Message-State: AOJu0Yy7gS79VcvnwlIzl4/udISjMh+r+86yXgVXnEXI1LkAxnrTbLAb
	5wiRc5TY95J03fzLIQp2ifHYQpuTI00Q/Va7llIo2R0zrscebOK0fDXDkbI+P5RshJ45Z9ptKh6
	ODvpE62tLiJvaiu+dFyt/O0mCgBW64yk=
X-Gm-Gg: AZuq6aLBlHdAb4JbL6A6jbnBUB7ShwxT+2PPk/v7cnRNosQbDzyBg+ieJSSqkzAlcr3
	FvDTL0GMNfYNSulyr8JjWp+boJ89vfQ+XOmrROgrSNBwMp8bKaI59xBiAeSF7W1J1zwy4131ZSs
	9rwXt1tLQzkXnzJoOb8JYL6ZcKGmxsgmG9nXD+2TH0sloL2rmTCtiNWenoeYp3+vFTXadK7MQhO
	XSfbyG0BUsUnsCweF1Nc6n+YFU6tl/SCa1x7P4mv0QQE2PpQIt9fx5+2IPfpnvCf+hn3Twv/eo=
X-Received: by 2002:a05:6122:328d:b0:566:3685:6ed0 with SMTP id
 71dfb90a1353d-5670606138cmr1525077e0c.19.1770410450911; Fri, 06 Feb 2026
 12:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com> <xmqqms1lel34.fsf@gitster.g>
In-Reply-To: <xmqqms1lel34.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 6 Feb 2026 21:40:51 +0100
X-Gm-Features: AZwV_Qiwbwg8UVUMITdsGAvgSxVJFt2o8Yr2ZFxF_6QwrRjxRve2RADCNzUmeH0
Message-ID: <CADYq+fZGnJ0LFfTz3VZbRPfuecZ_i3h5oLn0UfiybwzRAXyzdw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] introduce new option `rework-with-file`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 8:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > Abraham Samuel Adekunle (3):
> >   interactive -p: add new `--rework-with-file` flag to interactive
> >     machinery
> >   add-patch: Allow interfile navigation when selecting hunks
> >   add-patch: Allow proper 'git apply' when using the --rework-with-file
> >     flag
>
> By the way, this series is conflicting with your other series that
> has been in 'next' and is ready to graduate.  Perhaps it is time to
> consider rebasing.

:D
Okay thank you very much.

Abraham
