Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CC2E62A9
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184799; cv=pass; b=kqdXuHj4iJaRVLQDpE1eoLaCPgBAkfrL/sSmB4WMN6kxZNbNYDIzWEjGr/eFHpbLeKLmDGPQ2TqDIWZNW49/NYU4M118xsoBx35HPo704N8IZW1Z+F/NIZsh1zVvEIdAlXP2a3rvKJykLPd2DIZRX5DJB7OJCG/AuospfZGwWKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184799; c=relaxed/simple;
	bh=Knu1AWMN8By0t1HAN+jK0pa8QxR6lMB3+ehkQSJ58KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EL3b9zuXln3PH4D3T5BWslXdRk4PFh+dNHgrZ0qXgPgj+hv/ofaRZ0ug9BZJ27q7jyxUtuMTWf51MzlKn7CkLejH5qPyXWBgJmcAQKq+sSbjehK/nWTWDZdnUSyjRhyGPVa9GflU6cDCMqw4GrNKPJwDcsybOy422ZBbaVIKupo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6akQCYt; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6akQCYt"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1855544a12.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 23:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784184797; cv=none;
        d=google.com; s=arc-20260327;
        b=qyUXtSm7HiuFiFvzv/PDm4y8UdpWl2x2WzHBSxdrP8sJjk/RdAAdf4je8kPuJcN0Rk
         3mW9i/U/EKwVVmmIJQ08EL0jDeNXUibBPorj4dJncqApFq2VFQieG+ONA+FZZ52/1fwF
         RgdBR2pdemjkRf7swziwhdUtP1YU1UjfXvt/xzjhJzrWgsfH//NVBql2n/QfN4BPgtYI
         m3m2uhnrPHkjfiZLsGRzDMJJaPhixSGHrKuJlFXRNHt3OE1+T4S7WdDTK09UZ/8Ib0+F
         DqgxE2hCl7RVk27wtvOP7wGkPyvO5fN/elc86Xz+nlDgVoqy9oPjIbhz73rnvPUPEvcR
         Lnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Knu1AWMN8By0t1HAN+jK0pa8QxR6lMB3+ehkQSJ58KI=;
        fh=ZO99/xGBIlyewuCaOws4UM6DsXv52IVEi3R1H9qGYDc=;
        b=b+5efLHWJwBg74u1MMffLFr/Cj4lomoK+UfCrGUTH7geYFQ1LufradfjWkTnHNOJl4
         uS4B65CIdOCo6DqnY/E0BjTUlYWkURIUbqXvCCq7/ATWBtjqxT32CK83ofgasIMYsxoi
         sKPVurXKJiEtIVeNCDOaV0ieAJN35ehqrl5KIFt29n0oGEEHru6dFFtoGiHAZA9nipDk
         2wwslMKKznFvcYaT+Wlax20UxXYjnnWWPri5IsqE1zq/qX9wGabF3RzGyv5Wh05dwTOc
         gNIduP0RC90YTctWwaBwncm/vzCKx7048er4bfvuemBW1W2MOcDbAiClg/FI/fmrwKpr
         5KIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784184797; x=1784789597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Knu1AWMN8By0t1HAN+jK0pa8QxR6lMB3+ehkQSJ58KI=;
        b=B6akQCYt1JCVpi3HBHiajiI/28iuR7Zp+G0T7rmRV8UInWzliKQkp/RJ1RzJDCK6ha
         wKDFb1LPM73tEnfBhOind3MhAPTcP/evEw6/EadetyB03DGdjgH3u1kHbxRXc4y7hSyT
         PMYuASTijNOyn7faHGEVMGPxV7hY7o72iRDCGC2E12vfSIgwHQ7nACLZIHl7pNMRw9ne
         5OLFfgYWPPoX0UoxMbq9/1ykCaWjArKlBS2tIXwZY4y/Qfz4LYyqT3hEX9XHES6uZUKD
         LM5dOGlz8YJE55qAZ89iMpHvb6bts3yWzKzjasxRQRqKhB648lQ8dT7l0Wqr9iQe1GtK
         fsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184797; x=1784789597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Knu1AWMN8By0t1HAN+jK0pa8QxR6lMB3+ehkQSJ58KI=;
        b=l2l0NndNCQCYc7Zhkkco+Eo7tApflQOb4Egut61bJEPcoh+jUeTfaiBseLxfMUq9Zd
         gQ15dTDaabP7WyIfWjk6FQhpIjhe0OH20WVPKfuYiXODnNTzqS6Ep3ZFRisztksQdG7D
         4f7OVCSFwgJ67khXMKmeChUESsF2uzgEC4rYvquSuLImWWWCeI23Cl3uVqL0V0sgA3Nw
         ksnaewtl31PqrP9439Z8irxsg4NyxEf6pxGL1pgCmEb/08rFjvM/tBFilksPuUQtXPKn
         woj1lFZn9qxu94HYXKrxmj6Yg41+ywMDrqKPwGykiKHs/rN0rnxAV2DkUB3tVDbH+efv
         939w==
X-Gm-Message-State: AOJu0YwlRkxbauGMyEC7aTsg6tZWbAHGb/wPOKUUP2s1lZjQasOGLto3
	sZhJkmh7UelXkFxM0ve93msPF6IB9qgupwuGnou/kjgkWQ3AImsX9hF/L4+Ncnbn6PDedPVgQb7
	IKZygQt7R8c0fh1K0sZ85ggltmcnI74Fl1f6ej5Y=
X-Gm-Gg: AfdE7cl6/S0rk1wl/6hnlT6lPs1PsSDbW0wkesTRZMYGiFBqGUq1Qizaet3VwOdv8Q6
	UbLyJdtRNVwGPhsVf5aoN5fkyxhWI85igolYxpW0SFa+CpxoCfeQX0+s0tjvt/YpyVzMoNVDoUA
	X4p+LfMnsrIB/nWibIu5zTbuVr3GMhgdrBIKNboArhGiEq2JZjIe70DlLqWsTRNdpteLeO9pP/d
	Dsw/a+nsrkFADiaR0v8QO6EdHYMSE/wyNfMesXbjDapswYS2fxi/+FPn/LKic8E3v98ASSpi+dQ
	veBvfwRIlWuoDHTKa58waCO0w/Q9QxaooG3ke6qfKnrpghg=
X-Received: by 2002:a05:6a20:72a0:b0:3b4:6026:6c5d with SMTP id
 adf61e73a8af0-3c1102d7d30mr22034440637.5.1784184797523; Wed, 15 Jul 2026
 23:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im> <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
In-Reply-To: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 16 Jul 2026 08:53:05 +0200
X-Gm-Features: AUfX_mzDNw9kxQbb7WgIzraU4mxhpbe8Zy_G0Wu5C-utMjs4h950kK23iO8ujxw
Message-ID: <CAP8UFD2e15P19_XCVyf-NQHz8Dj8R4UshxzWL-i6R8c6prmc5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] refs: remove use of `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 7:33=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> this patch series refactors the ref subsystem to drop uses of
> `the_repository`. These patches were part of a discarded attempt to
> make the initialization of the refdb eager. I guess they make sense by
> themselves though, so here we go.
>
> Note that these patches contain a slight tangent to also adapt
> "worktree.c". This is one of the subsystems that caused problems with
> eager refdb initialization because of `has_worktrees()`, so I refactored
> this subsystem while at it.

The changes in this series look good to me too.

Thanks.
