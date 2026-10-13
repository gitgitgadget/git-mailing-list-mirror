Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AB52F27D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921744; cv=pass; b=BwE18eL0rT2N53VUncex1lqL7BIV/C7ZoAs2NeUglJb5qC/SZ9yACGbRpZm1cnTTIxCnT0OkqGd9rnru3z0ddJ11hNBFWCOzhMzOrOFsoRQv7KkCi9M+yRvJ0LnO8BOAOtvXi2STi0d8gwtAJy5kcLVoZ0RfAlq6Dv0vInnxvKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921744; c=relaxed/simple;
	bh=zB+kSUCy5SEqtOjk5k+56T6Uobj8NPrAvw7XQ3d/dQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYiF3+k57viOIm1+tS8g/+yIp+kKjUTwYxhqJHzbDNohn9KFd0tD/z35RllcstZzh4ZmO9pMh5f0KhCcoh0SS7pTN9VeQ8nRmMsdDL5BWhHISLIM9mRCAcTuLyRev/Ja/fNqoC0o7sv3hqrktcll66WK96i6CavSSf3BQ8FTra8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5wDpL7r; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5wDpL7r"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3156e7705cso52476366b.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791921741; cv=none;
        d=google.com; s=arc-20260327;
        b=YvD0MrtBDS5b9Ku1Be9AFe+BAWkdgLqSSTaaMYG/W0IzD5GezOCX8mdZSa2PlTZ2ng
         YSGrMNtMucNmawLhd1dQ/lGM82fZPSlT0xJ3RMlDX2rauomlofm1hWjkKs+iwhaYiIoV
         hUC39/9XRTJsXSFB77xOGKGbmSn46Z56yPVL5JL7WZSupUGH2rVpVDWf0trPQXBwPmyR
         TQpG76vaUdh154Ajhu0fGN+XvRNvS6iD32UgGb4e8E18FsszKaBDTMyHB/RJuQ2qzfL0
         5wZyap9EwCCiuKvJ+3MLHejOUyCO1cYvnF2Rdsmz8gUOtfQluVwfTUQFUWIy+X6/65zv
         X/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zB+kSUCy5SEqtOjk5k+56T6Uobj8NPrAvw7XQ3d/dQg=;
        fh=BA/vsfG7m3MAoBqpN+ihbjXHELA/zRbpVmQLPci3dNc=;
        b=d2vMfCViKku2OBjMKpxowwb9t69OBevSXgY/b1luO7dunBFjBmBhHS07G7lRs/FRqz
         7yS6nSjpZSJAoaj0bf8hmiTRXXtuC+DROB92vKXzfZstJQIaInPhtxuYHs1TwsOJH0PE
         6aUNy0TqmqOeuHvTZ2BIL+y+3DaqgDUALQ/T0b0G6i2yUItl8/MSG0eCodsEwi+aeC8C
         QNpp/aDvrvv2UPVA0Vr+tPXXtdO8FlByGiUSohrHswvFaxcBJ0N5BzYJCb4Ulxu7MDPq
         8kTFqM7q+m27G7pr4uVKAnywybVdl2RjebNkdwuVOVYPkvyB79lTb2szyTS3QsDslYQR
         fc3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791921741; x=1792526541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zB+kSUCy5SEqtOjk5k+56T6Uobj8NPrAvw7XQ3d/dQg=;
        b=b5wDpL7rEl7+cWTvyjQZxgZ71f62O/nm5NNj85AO2e78yxwc2PqLc3hyrEc5PxAaSL
         mKBDl1OMASkngbdcHIkzyWVJ2SRZnlmYGY75GrpMzDKomXdT/ObM5F2E+AORecVW33kT
         w4Bb46gl36VjInSqrd6xd7YTw3Ea0QMDNnBSo/c4Ocq57XtJs4Kg4lP3gip0lyNZThea
         5ccqM5lNCCRItQZjqZgWskyoproMZBsYm6VKpyRTXOIM7nlV1OPYFXhNKi/k3PbsQeN8
         c8TBF6beafs9U5RAm5GVykztwjuazhX7LIGPuTx7xxsga2/jYqUf6f39Ktv/t1tyWNvd
         0LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921741; x=1792526541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zB+kSUCy5SEqtOjk5k+56T6Uobj8NPrAvw7XQ3d/dQg=;
        b=TevIMr7IR0Xz3fCG/wcfe2KNBrgA/ejWvdkOk+zL/NZv6FyHsdsfwQDff2PANJ2AOO
         tODeubUUgRbUmuCg544LWq9bJaXrX71hQnAFPhHNWUu9DPjCNrwMeWFp5EOiEbb4LcVQ
         Q46WjcIB6usjOdCUYPqYRl201pCnttmdNmeQBYa/7sp5M3g88vDk8YP1DO+DYTuaFXiH
         JvY5PhCgx5QCR617Cr6JADXLfF4meJJ/ThLF7foghTpA8JliEsFxPVm8Y7Ppk414Bv17
         XfZ3CBY2U5olIQ1SS9KqmNrAkNKQYJiyt5DXG3KEQmeecRdPZpAEKMbFlyHewbvQOfYS
         2ySg==
X-Gm-Message-State: AFq9FYIwOLU+nM9C6W9Wl9mVJSGeSG25/o3sVIU1z1gByfmwEoUchkIV
	PDrzIORtstwO5Zekq28V7EReXPP2ssr8ka8LlWaiax8ssoNGTw8KSzYcvMuKhxtbXwrY3Pwr99P
	k5vDK7Hnpy4gv0uYtgBFQ+arzMdM+eYvZwERM31Q=
X-Gm-Gg: AYBFou3fqvFAOcJjbCj+mU5IFVIt1PobX83/MabSnOLW+AdMHes/iJGUxPZwOy02FG3
	qfQTf4+W4wvwsIr3vIwESe1Sp/Q+tiXTZdaRwhtbKh6dqBmhUiUudi7zwZmf2jiXJ45DnyNG2bS
	LVUacplhYVFxBou4B7WPc9ZOttShTJ98qZnOfmZwxaFQC4fuH0NwKtS2PC0cFmBm5f5LhA2m2Sd
	hmi2TjY1LgxHsiEBLMKiMv9TfwKPdNw8qb99CYmiKYdekxo4ETAwMWbeYXSz2wEBAxICcD3nj6O
	qPZctDF805+iUTJCG6aMj6s+Jyj9vX6/ZC6hxRv6ZZ/ssyW8atgEs8MvQEFqR/4oUEzBpfg952I
	MyR//88H8fRhbOQ==
X-Received: by 2002:a17:907:9443:b0:c2e:4a61:d436 with SMTP id
 a640c23a62f3a-c31aa09632dmr1383701666b.36.1791921740945; Tue, 13 Oct 2026
 13:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABh_KWjjVPGwLPxvUZsFzaSBPBvhMNeaVbTdk1WEZ7bruYWU2A@mail.gmail.com>
In-Reply-To: <CABh_KWjjVPGwLPxvUZsFzaSBPBvhMNeaVbTdk1WEZ7bruYWU2A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 13 Oct 2026 21:02:07 +0100
X-Gm-Features: AclHuK-26zFI91BjE5fBgZWn3IP1YVAmZzwC1fA8zGD0RMlH6PfWtgfSuAK4ua0
Message-ID: <CAPSxiM-_s_uS5u--YMUnzqPjB5BgHx=q0nqmdcjSqRuXU2dQTw@mail.gmail.com>
Subject: Re: [Outreachy] Microproject: Modernize a file check in t2030-unresolve-info.sh
To: Srujith Poojary <poojarysrujith@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hello Git developers,
>
> My name is Srujith, and I am applying for the Outreachy internship.
Hi Srujith,
>
> I would like to work on the micro-project =E2=80=9CModernize Test Path
> Checking in Git=E2=80=99s Test Suite.=E2=80=9D
>
> I propose replacing the assertion
>
> test -f .git/rr-cache/$rerere_id/postimage
>
> with
>
> test_path_is_file .git/rr-cache/$rerere_id/postimage
>
> in t/t2030-unresolve-info.sh.
>
> The goal is to use Git=E2=80=99s test helper for clearer failure diagnost=
ics
> while preserving the existing test behavior. I will run the relevant
> test and review the patch before submitting it.
>
> Please let me know if this is a suitable micro-project or if you
> recommend a different approach.
>
Yeah, this is a good microproject to work on. Importantly, the main point o=
f
the microproject is to get you familiar with the Git project workflow.

Thanks for your interest in the Git project.

Usman Akinyemi.
