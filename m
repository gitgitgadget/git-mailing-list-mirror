Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795170429;
	b=dMAdpqHx/kIxPShES9/3wnZ6qijGVN8Q/lkEUIzIWeVjXC7tabeM5sVMEUY1d16BC+hH
	 RdTTguBpqZrwLKt0iQ1++3XyhdAyXo3coPwBA5sKBSk4zpb7nR7wE5KbzET5QV//2rs7H
	 Btdlmb0GtoHPHDq+EP3OWZP0WbJbeGCBwM6YTt/8CazWtCIS0ZlGQbLgHd1sQLhTXCGtZ
	 gmyB2dI4NUB5wBRMIdZzyFSXIEDbT+da3FdapzmVM/QoXi8XN1VnnFY/nNm/vwuniya5H
	 eRSxubreXGJDEd0ivd1KyXxtZTexK9ojGertDlWOfWHAxzfzm80CjK6HQ/5zmyodZWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eE+ur9onEoXZIpEU7i+KHJS0bV7aVJ9k0kZungtfYkY=;
	b=RJr9UNZzV1EIyFHvG/6VUJTx13t9EBbCDy4evrDZ/0iQCWKOtZzzGRrDl+RN0O2V0LHQ
	 2vQqrCIOz6rf8Kg9LaAFHeF3avXYJGJqS8q6dagXDdl0I1OMq+g1R3r8BZsSWOUpHNoKW
	 Lvq20mTvSabdH04swTiwdNt/mKiBP7tovFcnS+c1xZQFYS39jEaK/rk3BM4ldfkHyKeN3
	 AeI6dE9mDKs7smS8cFsRn0XxHPRfYvQyx71ukFe/HG+KFC/fVm0N2tyDbQgjxWaiQV34v
	 Ohc4z1aiEPLFCVcVTkJfGelvh+7vcOQWm6Wsk2p8erAZhd/dHQAZOMz8Qq6ip+/HQaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlAfJJa3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BEB606A332
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3BEB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlAfJJa3
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-675617e81f9so891582d50.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 02:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795170428; cv=none;
        d=google.com; s=arc-20260327;
        b=BUycABcSIMrCc5SsE4CSi5NuM5hDt1KD4FJDezt7nFhvmkF3qzWvT1gnih+HhbLF/z
         XpUCFvJhrb8/HYT7aOdIdf1J/6DpF2kOViGp7NDeZiTL2YFQThRhXvGjK2WBKVvJl0OW
         wgY5sithClQ5vjhIbHuChoTtD2ip27HcD+vRtj4YYbXqJkqIjGADo/RLycLHYYRE0/Vc
         DiWavESFegq5+e5hmPD2DBj9+FlIqkuJOnsL8mz4RsZqGzDowEntTbjzBrjUw0/xy+Hj
         G3G4ayvXPs7eIlEwXE5h/FWKiLZ0pUyNHEXgq8cQd2K6yr2E4acBn/y1DWpeDWQ4zLIC
         XwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eE+ur9onEoXZIpEU7i+KHJS0bV7aVJ9k0kZungtfYkY=;
        fh=uLroqYqcx80GBCiwIGXxfGNsg5J6DEKTsHj898AfvWc=;
        b=hADWx2wy0PqHhnTXWImGbN6S/SaU9Wjrtp3UgVBMqE7OZ02eEkE54W2Jydp2JT1XLS
         lO+Y8p4NndEqLsr345WH3WYR3s2t0V2P+1M3aOIvmyGH41XexIAJFIZyEth5Mn9ceFpp
         ybfMh349hQnk5VQppIURkIvuj6pzR/DyGzBN/bTe26K5Fhb3DG44LchCZAxX3qHDmp3q
         78gDflqaN9+jot7J98+bC4bLsWgKBYqmqnte1KhT0BB/zWWKbCVaLO+SBNpMhZjoJZQ4
         No1KNU3uXdkyv8bbH2PvkDUFdCG0M586aIXjX6v9fexeYboXcArIyBVRHsZPttFPhKJm
         Fsvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795170428; x=1795775228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eE+ur9onEoXZIpEU7i+KHJS0bV7aVJ9k0kZungtfYkY=;
        b=jlAfJJa3Si2IZykdcC3/ffzQJGOYIoTMqE7rS07icsHxqcapPlBwMjMNEX+mwL7Y48
         LtQhbHkKlCiBxmY3t9IlLb1i/Ba1w7YQ9y50xTQXrdUN+E8dK99E/PyGvKsiWwV4sceY
         0e4E4oqCgH91fWVjgkKChP0Dxzp27GWPeBR6L3/GOda+uCDUqcA4ItFGOJRCuURpmJTd
         3xK/VgyP/J7jc8lQWuSzDvbhbDYgAAx2ecNQ9FDx38rE+2Dh6AIaZwV9lpemHyIrtMaH
         MsN2smMNxQOszgYa4aY1+mbmiK/dJGufm7eYrwl7KEcZRNvlIk2dV/ocoMEAi3kupq4Z
         1I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170428; x=1795775228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eE+ur9onEoXZIpEU7i+KHJS0bV7aVJ9k0kZungtfYkY=;
        b=pcQCw4Z1aMMiNGa4z38OvN5c2+xk29DvI2Q77DVf9oKVTxSz8fI9eOfv7ZAIl8wO7N
         pnZPJ2JlTaKebJRUrJG94ZmzJtJgt+Vg2eP23G2SiCSCcLTSDi4DuJ5pBU4QllkzNwWu
         BF2uxXHlPZsO/esQ25hC4gfD9k9aa3Krpw5Lmq9JyN1nu29wdzwDge5uAzwW0LCSDuKK
         2/zjMT0ggi5ZDeqjN6RgL2jInci/wqbDDUMG6NTBh8/3uM29hzT7MD0WSdifEqJyW0gm
         935O6ViEtW9jtNYnE/UgQRrLwFK8mL4EIAYcLyJGxhDvN1eHlYtuZRdu+s3W4IfnYbiv
         Qy3A==
X-Gm-Message-State: APuU4Z9wjc9XVnAR3skx+ib9f1jR0awBoFRpbQQJ65UqlaTHWcWAKb54
	Itew1qCiJk1vMa0Vv3VwcHcoMHL1yDihQWBDfIFprer/u7AISPq7E7pQmWqS5yX3S+tOSG6AiKE
	WoZRHfhFCJ2SH6lRcYsboxy+d6G/HQBE=
X-Gm-Gg: AZFdTZfROZy7Fwlr8hyHQ1wJT7+4CE4jKt1c0mrgyuOvOOr4BK07CSmGjyIi1UeIy8t
	qt34yi/94QMwEHv5WKdRaAc1FCmH9UEGDI7/1E8OP7XPtdOedmOi5aNmlalFBwdh6vT+Z50hY6p
	GC3ohcYtWp/mAJ7+Or8gLWn9HKQWUSA/cWoVnBA66hmw3TpRed8/zL6Ki+HGC37eB1410XRHHye
	OvLrdEH5T+Kv6ngEXIvMZ70oEwJ0DZ7unLVS+nSo0sQMxklzxzwUXWXImnyHYPDTrs2C3AxReMd
	cJlksfuT5M1wSSVUfp22S/D5U4z5/dTWYBCLS2fKpT12pUpIHoFLJiRJG+YDUFALauSpKdotpjz
	Gi1F7XivMBjX5usOoosFLRbYlrRHDFgh+lg9V7yaXhukrrEB+vpvuZ+1IwhiMiT5RPz8lucgpvF
	cRZqfPmj5azoriGtFCgMtSISuinvWCIdFlf+Wg16a/4z75YEjbnMZhXIn0rBqyufDUQ0EnbKs0r
	YmoDUp1qJ07fRPuwY2bbyxvs3cFdMcn93jEBQ==
X-Received: by 2002:a05:690e:1187:b0:67d:ba3f:a9a6 with SMTP id
 956f58d0204a3-67df43ce269mr1135771d50.21.1795170427754; Fri, 20 Nov 2026
 02:27:07 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119105300.95746-1-okhuomonajayi54@gmail.com>
 <20261120055908.83043-1-okhuomonajayi54@gmail.com> <CAHWeT-ZJHZrAtVEC+-WOy0HPRZuepdYVzPNw86DcTysf5z-gXA@mail.gmail.com>
In-Reply-To: <CAHWeT-ZJHZrAtVEC+-WOy0HPRZuepdYVzPNw86DcTysf5z-gXA@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Fri, 20 Nov 2026 11:26:55 +0100
X-Gm-Features: AclHuK_Zx8klq_QiZmoQ0EIqEoH2tWpUw7bNYaKu1HKGkgvVzk_HeC7MVJjzxwo
Message-ID: <CAFpMFfD_OgaRFLiscoSDpH-f_T_T1PLikOJLsYvHWxAv8oy-Yg@mail.gmail.com>
Subject: Re: [PATCH v2] doc: wrap emailed text near 70 columns
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 11:08=E2=80=AFAM Andy Koppe <andy.koppe@gmail.com> =
wrote:

> I'd say "to a maximum of 72 columns", to take out the uncertainty and
> match the convention for commit messages, which of course are quoted
> in the same way in replies.

Agreed. "Near 70" leaves the width unclear. I'll resend with a
maximum of 72 columns, matching the commit message convention.

Thanks,

Okhuomon
