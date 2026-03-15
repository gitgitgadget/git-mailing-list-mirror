Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2B37AA7D
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773614681; cv=pass; b=R7n75VH7P/wMW/A1jK/jkaohI6eelQyYx7NKft8jN8PH+FTNTtHt1QDyqDGugUcmne+z8RHTl6+ZqFBivpr1F/GLBfTO1wD9BwSvYzp23Rvb3lxYsKlSjH0MhW+yhPz0FKRcwHvsUohX7uaXW6+7tlHS24CJ2nPcG0EKuzHHTj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773614681; c=relaxed/simple;
	bh=1CeXJMKDhrZ7AT2XaI/eMO1N/xWM1aPJf7axh/q0Y9o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=e0Sj9C9B4/AxZ9rvuTTl1AAznTmeCeJHcyTg0IR1LSbJaspSebFMsoCpDeX+4V/mIYdKUknuQtZbCmmU2bcwubgqgfFrvRqQHAMX/d3B4i6gyIgLrh0zqarMDPo9O5ZxAseKZbyEzSeqX5zcqsXSqI4n4DpfunO194MPzhmbsyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOmun6XL; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOmun6XL"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2beab594d8eso5179355eec.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 15:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773614679; cv=none;
        d=google.com; s=arc-20240605;
        b=es5HafWe4wm/cDE7cfqt0oLw390K532ejFfhL91Tn64UT1MQdrWYZSTyNRe5JnQynj
         xo1s/8plO4GMrjiaIpeSVKUFk7iq0x5ERN+i6krY9Fejm+mSUU89uMcEl77aV5HXtGIV
         dJO/kSYfl5gf5ktl5YfKyDvXJS7QEL2mGuuG8BMFdGHC3pTuBjJcPOs4XvctRTzwZiIK
         18R4qQr+vIAh9wi3pAhxW7aulFB7//hwtyRPCylfO/YNcGSIyWN3z67UKJyHctzPqhvO
         JmcfJ4W+yuDuAYt9S2Nnx0oOkHb7rsP67F4kbuk1dT4h5iUBRITRq7twG8/p8Mr7U6Vp
         UGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0csBR+0NpxH7/QxE/mSVXNfTzmgTXuOL7eRPl0Zanlw=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=B9RTbMjfCpUKwDRM7EY7UBOJFA7aXYxeijoUdRf6JGTQGJgomXojqCy5FToudqsC0S
         N1VITDh511lqqICOF2M9VgFbQXAoQvs2+hTP2tNvX/CDsJFVfJ/Z8/8TfLnsk++EG0Yt
         w/q7j/ojNqwkes67rXmzA6UjGaxPofW+FxxajXrqSVXxKKXiL1rOvFXu4EjF+CJ0iYaa
         lckztkUHkWXWnKqSjPkHikzGZWzg0HnGJBr8nnFPn4FegWJflIcVlo1Q/UzNnE7Th2ZG
         QfKxgpYeKrx/ZfdEU5+BdePleihGemDS5XqbmNqjXy/fWFLdBmGqupQKLk8VoFPLw1S7
         00LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773614679; x=1774219479; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0csBR+0NpxH7/QxE/mSVXNfTzmgTXuOL7eRPl0Zanlw=;
        b=EOmun6XLQOIG1KHvO6wC0NKf6BnmXkcqYxSndmnwI3N5SFxpPBf8T5VWHS4D0l4LuL
         MvY889Mh7NIfxKObNErTsMQx+KqmAx7q0Uf7DUyFTYhqWA2lpYPAqpkyu4sFiH1xO1Ya
         BNyPqvVyxT1D743KtDrZl/H4BQr2QLbGFP8NaaM1nkPd8eeVv7cRHz/YUbsRdBH0CzXH
         eYhiiBh2vhHQ8YvzapCC/Ex0V5WyV/MGsaqvdWJJzn/R4dwkejokyN6iuqWCR6xFwjob
         Mn3yTEbnEDe2EKkT2Z/9jqOa6kVNz28vWW1jisYvzdNg2iKUqI2Rxhhun8W5UETUhtsP
         mWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773614679; x=1774219479;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0csBR+0NpxH7/QxE/mSVXNfTzmgTXuOL7eRPl0Zanlw=;
        b=DXwP5TvjQDqmmiHziEWVoTV+7mOldpGPHAxQqaq1SUJGl+pQ4VUXaFeUM31vGRbVJ+
         EfGYwtgGAGDMkwffLSyx0qqXNRi5h/99/RRKSA6r1QFaaGmzKdjH3oLDGAeguzNODAcb
         G966sAcHuZouE9wsxPFV4iSkajShCRa5ze5A1/Kv8JWKIv0YH3lUZ0+eW7zyJ1pHcDli
         J+o4Sa/zpn0bFnq26Q4xl8cGIcmej8eVU+i6S9hNmrG7FCnLFlC0z/v+11XJbJYq78UR
         0gtdQYj2Fk5irlA9y/qBT0YvmUOdzs/Xlxw/02B/KWpBM1vU2RyQ4mmTRhqAtMeT9s96
         Ik3A==
X-Gm-Message-State: AOJu0YwbLLtukPgh2yxV3QX8Uw9nkIFSSbxJkQKRXQzMj3WuyZntR5e+
	zMYOHay5vwB6l5i88PnwCq3qnVLGqVxxM+U1QsIaA18CBPJOAYquSdGucICjWKu4/I4STWHyA3z
	baTmFLZfuKvL0AzSs507C4U0NWtHwiFZxGsIblonxPw==
X-Gm-Gg: ATEYQzx6btnn/aAfZ8xj20VAHpxYJEp9yUN7ziDyqOMPaA8MprbiVXfYDIr3w8aoa9K
	Au5NV5i9plRHL0Grsr93tfKMJEMUgka69R9/Vk5xoTbNdEDMvty2JzdeuIZml4o4ffk60lVt/DD
	1nMfVDGqzRo/RcYAN8aUENctSx7Nl/DKzj+19FxjxOO3xBq3W2tr1JwYh5+9i+qQrg4FCP95WaS
	Wc6jJ3CYVhc7Bhd8gO7yUZ7SIdJXfs/kSWpY9ju5j8W88Ut1lmz0WilUzPevFTGTf/NEKfRr09W
	97WvZ+WJo/C0h4ZjyaVFujjWwQ==
X-Received: by 2002:a05:7301:1f0e:b0:2ba:6458:b325 with SMTP id
 5a478bee46e88-2bea5585cb6mr5175094eec.23.1773614678499; Sun, 15 Mar 2026
 15:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jerry Wang <jerrywang1201@gmail.com>
Date: Sun, 15 Mar 2026 18:44:27 -0400
X-Gm-Features: AaiRm52zyF2TjJ_XxCactw-MPm1_rAYMDcbwayFtHv3Z-IwejsNJL_qZmlZ0qQU
Message-ID: <CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com>
Subject: [GSoC] microproject idea: improve corrupt patch location reporting in
 git am
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

My name is Jialong Wang, and I plan to apply to Git for GSoC 2026.

I have been reading the Git contribution documentation, including
Documentation/CodingGuidelines, Documentation/SubmittingPatches, and
Documentation/MyFirstContribution.txt. I have also built Git from
source locally and started looking for a small microproject.

I found an older open issue that still seems reproducible on my setup:

when git am encounters a corrupt patch, it reports "corrupt patch at
line <n>", but that line number does not correspond to the original
mail/mbox as the user sees it.

Related discussion I found:
  - bug report from 2019-10-02:
    https://public-inbox.org/git/20191002184546.GA22174@generichostname/
  - follow-up patch from 2019-10-04:
    https://public-inbox.org/git/ec38908d05f0d40190173158ef3f0753fa9f1184.1570226253.git.liu.denton@gmail.com/
  - GitGitGadget issue #374:
    https://github.com/gitgitgadget/git/issues/374

I also saw review feedback mentioning additional test coverage for
cases such as stdin input and running from a subdirectory.

I reproduced the issue locally with Git 2.51.0 on 2026-03-15, and I am
considering working on a small patch in this area.

Before I start, I wanted to ask whether this still looks like an
appropriate microproject for a GSoC applicant, and whether improving
the error location/reporting plus adding the missing tests would be a
good direction.

Thanks,
Jialong
