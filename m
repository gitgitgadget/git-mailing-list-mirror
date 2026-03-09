Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EF257855
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063215; cv=pass; b=aLc3I69p2TCPnfzhqE+BrWu8RIR3ZbFUcR0L9XcE+pUEYQle1vHP/nNsKCzOvMg87WsDvH2S/DolxDd06fSlEocKHpQBnNMAOytjFFVW7R+l1DKny/+puNVR19a2QaE/MS6OcFBIM3qW46aw0cq9LGjh3exGrsTYxE5LUrMLHvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063215; c=relaxed/simple;
	bh=tDyxEG8SXmSihmATQth2z3RhvhjfsJpmcDJ3iay19wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcK9QgmioIJCVrQhx5e9lJC5xatwuXHkMkLPUpsaFiayPkNzuBR0g1SntSvLNoZ5tJPrMIerhl/auRVAlfy7oRm84BK+sY9KQ2o+zNpJJAAZxY4j8DFZugvG7d9Epxp3elynPIj6Qsvj2h6rJsFi2yOQ4DzzMqFYX8ilhFd12sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYQGG/3f; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYQGG/3f"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a0d53f3d1so71739596d6.3
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 06:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773063213; cv=none;
        d=google.com; s=arc-20240605;
        b=L1G3QH2U1jVu9bGKm3+EDfG2hxFU1Etvq5T9QPSJXFJFwRysmiNmFFVuM/lvnir5Ej
         byL+idp0MiFESdKlPeM2cSwqvLSpxP0ZD8NDYhZdMoGkpcx4nK5OzeyamdHtZfsU15Lo
         T/uF65rMU3eFpd6+zNBSojDS1dOxyeAzzRTevHvm0nnq3EblyaPhJkhf1RU1BKKbYdkl
         2DfHwEgw5+ewTpey5y2fAL5aZYum0cjvK0Rb9Ts+u8XZfKj04t4BO0Uz5PGePLzbsSPT
         HImlxIFiIkbraGBm9/3C+D2PuPa2sr/ic1ZzoseW9/yt47vrQKYPc9iVST+kaq3r2VL7
         NDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tDyxEG8SXmSihmATQth2z3RhvhjfsJpmcDJ3iay19wM=;
        fh=Vo072L8BMjweoMsmdogjl/jSR2e+/XnSezO6fFsSQE8=;
        b=G+1/TToonZVoirM9g+wmhpQBTY1HMnK+iz+jBI22jvot6phur/mk9fkC6yOmRm4fyg
         wxsvoHoWAYz7FfVk4UyIKBN2GkI4y7/oJePSuF2OEejnthDOzBzdLJC55jvvsSIh2dbq
         Avf7/JhEYhi5nTsKGOjHGvcwWLyZm0wjPkUzVfb2AOBmrwq0I+qStID8NlWllpp0hWGg
         b77FjF1QPJKm16c/serjSs97err03ZFl4FE0hHH7UkbPW4ETgW17QqdasR4749jZ91pC
         vBSXy2dFLRMXvYcI744usE4lrrNg2CD/CpK2X1qVw/5AjHfKnDgy0gIZu9feUt4BUNiK
         c6qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773063213; x=1773668013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDyxEG8SXmSihmATQth2z3RhvhjfsJpmcDJ3iay19wM=;
        b=WYQGG/3fkZB0Bs1MmunKYOBY3QyjxSzdzxvdfwtN5uMeXtRDMO+3rS6c5CGe23VzMt
         VDR7Faxbf8kE0VmZbUrI5gbQcF1AzmIHmYSCub0qvq6UMylgWPOH0NxOLHLdMgPJS+xy
         AGfKFsxUlXMZMG1wepLZQWaK5iYEdWAKlnTRIYZu9gX23TvSZBxTlb1i+KVkMbCoqRmA
         Rs4XDEokYaME/6mkxypY7ed8v8I8ElVXvt7AVd9kUmTVSYA2ssOi3sw9t9zTT9zCAnkj
         k8P+lyNfCZUtYsUDrJgq4+3++wI17KdJ6CGTySYRBIarRcRfSdbGoG6wSUJrV+AUAVqa
         VYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063213; x=1773668013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDyxEG8SXmSihmATQth2z3RhvhjfsJpmcDJ3iay19wM=;
        b=H59nBLvscsvj0wbs2aDlqjwYEvE83qh8ynUYeIrZ9gVlMNQFpJCBQwZa3f8ZUd0ovf
         p96vpJXS5jYBrGnGFT2waawRF1PzJGzW0oagD7mOicFkr+mvg6rp6SB09vGh+uzhKjn8
         18F1o1CccKxgQ3ywHWPKYGnc8MTp/9cr71lU8ZOe9UzBZp6g0djeDuh4iuHZS/gextvw
         ZxNZwF/9BjOVxh8X0aBmAHRch7qBRArUz3RJaGA9tisYIRifSa7DvxZBddBz0n8vMtGb
         zKGziJpesN1JUP3j7PcOQN8BVuAONLeBEPjDq01i11rViIZrjHUwidUv7zXIt0uOjzZu
         npGA==
X-Forwarded-Encrypted: i=1; AJvYcCX+rtEH3HhpH6K9oMWwvimH00t0tsCS1GKIke+vmIbEpNWG/fOV1m4JSwK6749a4nP7/DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdy6VzSYClee25fKSPzyb3FIh+i6nbxlrgUFAIK9/Rrd+1TMC9
	BrOH9VYacGC6Xmba0YUE6d7KpkN3Re2wvXdL0224OBF+xl2cgSF78QGWs0vMSmQ0tIhPPpD+s9M
	jllsLlJNQPJ2ZcU8ptYIXPBkxXd+ZUfWe857Y3tI=
X-Gm-Gg: ATEYQzxrSBFcVxqDlF07ysOp2ojYwuxqV4iXVE6fhksHvQp3PvfpeWG5A336vx3boMk
	MWP/OU5t8ee2MW0mOnCeFLRoMo9no74dhXMrYDdMOWrmXPybG8QotRZ/rNGedFLuwUsqNKySoww
	C7xpAgNo/NFGpFU4L1vivv0mYO5p6F8uetvLlT5Q+8/uji8DA3Kjfvr3Bxp3KDFZ2wOn+sFcIHp
	uf/lNktWq/NtAG/VekWb6dcuqaSauXsIg+N7q4nkNnULTIkJk04xC+YtxJMRRABzoiF5NiuYbRc
	fU2QaBg=
X-Received: by 2002:a05:6214:528e:b0:89a:2f:2ff6 with SMTP id
 6a1803df08f44-89a30c2b963mr155608206d6.65.1773063212760; Mon, 09 Mar 2026
 06:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
 <20260308183756.31860-1-dronarajgyawali@gmail.com> <f03d40072ab106d1a0a7852718d42f56@purelymail.com>
 <6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com>
In-Reply-To: <6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com>
From: Dronaraj Gyawali <dronarajgyawali@gmail.com>
Date: Mon, 9 Mar 2026 19:18:19 +0545
X-Gm-Features: AaiRm525ciQhi72bTon8NVX7lrtAaNdV_xx9nzmJ-CJTpjbVij3vlhCE53S5qys
Message-ID: <CAJtK1FMzbX7dO9y7hM_6_DbLpwbeYHnrg7WLjAghGX6UDVDmJw@mail.gmail.com>
Subject: Re: [PATCH v2] Make 'trust_executable_bit' repository-scoped
To: cat@malon.dev
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Yuchen,

Thanks for the review and for pointing that out.

You're right that calling prepare_repo_settings() inside
git_default_core_config() defeats the purpose of lazy loading. I'll
update the patch accordingly by removing the handling from
environment.c and reading core.filemode directly in repo-settings.c
using repo_config_get_bool().

Also, I'm new to contributing to Git, so thank you for the guidance
and patience while I learn.

Thanks again for the help.

Regards,
Drona
