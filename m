Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955D1D527
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leuBt32W"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1fab887fab8so1237619fac.0
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703252582; x=1703857382; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2igoi3N37iiDbBXzgMDcpuZJ663j8O33Z90xwW1brRQ=;
        b=leuBt32WKD8jW5WuTc7mWC2JnqvyECqSoxAn+UjN5Pg86oA0rEtxJ7L+Y/sgNUyowB
         2SCi+59Kp+zJTLK5GE/MlQZsq63MKiL3vDRU6ZsRL7L0QwO1hU3gY30claLKmBgJyybL
         oMD599StAPRSafQEA55NtQotJE5ibTh5R8tN82Dca5g3v1nWAiZL950SeOXsdhiIp1V7
         HErArCH7U1qe7DxrUXo8b9nCJKzdmpVliwGolz+8SYnrzny3eEJZeHVRyTK0o02pUMQ9
         7fFTA/NWt0DKpju/RDoN2Q91A6KZMaGSSmBEy8V/09TyFbwoRYcTjEcQVIR22Uuq4eUN
         jY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703252582; x=1703857382;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2igoi3N37iiDbBXzgMDcpuZJ663j8O33Z90xwW1brRQ=;
        b=qi34C5UvVCmWoQyHNm8DqyGHd05H324fwdZYna5ZdRz84IKcFIJ8BxTJIg2aC5p9yw
         dG+ffWT0B9mHF/LL//tQY1AexMMMOnw6L44HTjtZ22GwedlDutE09bpL2NjshdO7ydRB
         vfwg22dcGV1FdnbIVHnDgo0lBDTZ5B2ul+E3lx0aOA15qHwunfb4kHSJYUejN2e1VBx7
         ICXhj7W1RiQchgk+0IbnW8uNxZolQq9tkpOd8m2bhOBxwCTUZVXuW0zV6hFhJJtRxvA8
         DYkrlMo2eno/qBXqQw4HnuL3orTqY73pv7xFpwaaHa70GnVzTvu92RR6LN6Mf3DHgry1
         Fv4w==
X-Gm-Message-State: AOJu0Yy69To+mJN2/NbD8EX/pjdiHyEM2yo0YPahE329g/AIIKL/bV/G
	YDObelK3YjXdlLmHkfv38GAqsGy6g0h9CydmVKE=
X-Google-Smtp-Source: AGHT+IFci/E2yOYbb1qGVXN5L5f5S5Cs3jXCS++JGz+iI23Ncl6HGTrXV3UMDo+uPBsOA75h5JemG4fOYJRXjNz7iaA=
X-Received: by 2002:a05:6870:41d5:b0:1fb:a96:bd76 with SMTP id
 z21-20020a05687041d500b001fb0a96bd76mr1863670oac.15.1703252581879; Fri, 22
 Dec 2023 05:43:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Dec 2023 05:43:01 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <bbe2fbb15495ad6c8eb0824b4b4aaa7f3e6e2537.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im> <bbe2fbb15495ad6c8eb0824b4b4aaa7f3e6e2537.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 05:43:01 -0800
Message-ID: <CAOLa=ZSoW5NhUOLE_qYNTvPwdUi9eCwamtJOgTtyrvsg-LcytA@mail.gmail.com>
Subject: Re: [PATCH 12/12] t9500: write "extensions.refstorage" into config
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In t9500 we're writing a custom configuration that sets up gitweb. This
> requires us manually ensure that the repository format is configured as
>

Nit: s/requires us/requires us to/
