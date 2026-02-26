Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B77364930
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139421; cv=pass; b=gUbepCJ7EpZvRcqwbrAqy6FNu2tIslKIMeHkr5KiBwkRI2ecZQz3Ck6uyONlqV4bfT5V/DBGtryXemia95MnRX9MRWeOjsoQuibr4AP+XNzsVwFQ9TIYygfZmqsBRiDDcJus/GZyfv1cT8E6nrcpvrEGZwYSPsyzIS3TidFEmuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139421; c=relaxed/simple;
	bh=F8VN31Y1Itqw/BCG8erR3Al2KjDqDiyHLeDNuOVj2pM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tzEjRhkSlqB6HUDhDPnULQk8aLsHEq/gCoZzReQItJM9UXMwMQjj3d7Ul/glrAQlWkxz7zqsrCZtMntbcRakdOY9AN3JRtyQyma5lGNJCNb9onjBfHWNUeXsX23JEyMqfuABVoxi9Ze5IBcr6sWSZQaE1rEVw1EDEieSJ8Npy64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhPy0Xc+; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhPy0Xc+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so209620066b.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 12:57:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772139419; cv=none;
        d=google.com; s=arc-20240605;
        b=IUQBxmz5rnSsjDoVORcTIj65eJvQWrDgKthV/E+qgEhowHW9cbdU1QK0SWg4Z12qHQ
         SgXyNaSswcipgYdtQJbpyc0H0yW889bq58UT+hNKAFiO9RePotltM5vgK5cM6S3XaQ5W
         WS6FV3QZ9e18oriplykCtceERbQlzEFHv46n3h6L8hbOk7XixexeZ6EvEHoZQPpPjpiH
         Si+bVujVQkhe8AxhMkcnUcm3BU5VleaborwufrSGuSBXIpitOZq5V7/KXUyWGT2LLgRA
         ylXAl1hYN7dotptpD5FUBnilcWPTkoR32Td3MDC1mjYpiqHPmlT1AmPchyghc2bPQiv+
         j0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=F8VN31Y1Itqw/BCG8erR3Al2KjDqDiyHLeDNuOVj2pM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=exilO1sioOWL4VVXi5eOHNR+5dXSxKcIGRhgvmQ2LYmw06ZFnCWmn483OMsyjWo8QN
         sD6hpjHY5R3d3aFR/dUmRrib6VGdnEA6igkfrsRy4h2pmbtJUFUu87rxXk8UwYlcIJF6
         UZQqSPakvmckiXFxGyhAV5m/zngZvQtgXA9rY/laLFOEBtlSNpJsj+CBlUTWlAFGtxqM
         tsGqfO1WEU4GmffGSImyub7w66LXSUILU56biIt7DkGHiG0hfA8l9aVmSQGRreM2N4Rz
         EV+N8woDmApQdsjGwC+0z8IEuoKXmmH8/2ARsJsClSGGwK06xH5glRCDGrVxGpyBwhWJ
         INTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772139419; x=1772744219; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F8VN31Y1Itqw/BCG8erR3Al2KjDqDiyHLeDNuOVj2pM=;
        b=MhPy0Xc+jkQDZu9OFGZhscl8Gjj1XgOpayp46sJuoopf1yLT7fAxKmpQxXKGJQT1BP
         ED5EB7iva6njAJHudCsCdAxJdbZg1rg4GAZUriaVNzfaF2jfucdtDvb2VjTYWZuI1IRE
         zzxbVadjc2gCcOe+5tI7vM73s2Cso8ezfCFQT2JDLb/wDCAS7bW/IOh+w9ef/VV0qZdM
         PhPptsZoN+QNNFFZZku1tvj4PlbX+o8gVqP4SdwAbADlWw1RI7+nz803Z4D4Ac1o9Q0n
         dGDzvIsdFinRjZQF5JqiZJ2G5PGTJqxYIlvO/NwewZrnIXH1+lUVDbeF9Z4QPHNFp23X
         YfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772139419; x=1772744219;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8VN31Y1Itqw/BCG8erR3Al2KjDqDiyHLeDNuOVj2pM=;
        b=T9FDigQdxqwwccX12dHySvPt6E4GnuRY2HSG3PdzWm3J4ZKKHShAI+R94zlFfIorOr
         86KWUz+2RcM+7kbGXSjRSB7n4rDjWWgV5w+RSx2pEbSihkrNd+ZvWPF3QvsWlAGB/J0d
         jX+nxdwUQt8Z4Ge/Y2f/d3tC5R5DE1qx0tKrVZvuGQbK3Kau71DO2tbsrGOB5GwKA2w6
         1bDNoPKWEOKtk+W2ndrvFkFlhLMoqRyuo61gNnFGhC0sky10qUEPG4WthqQ+SfT7Vitx
         jKOpB/zXMGYaRXF3lo8uXcOObZV0KqMG+SO37qb1Nl/wBnWPiVgG3uoFdVz16AQvzp7B
         7MqQ==
X-Gm-Message-State: AOJu0YwO4moE5oApZtvrMam9rQH1os7Kx65lamX9KNK1SXtxE2UWfmyu
	GxZIQ8Nw6UpQsWypmha508qjyoq7RLcXfXcJOHhBfc5c35kouUUqEQ0U/q9Jz3+H10xpUe2h8oe
	qsNGeYvWVmGalOarxA1JHXwOjWxlv5bsdtDIjZYEZJKM=
X-Gm-Gg: ATEYQzzT1EO/GUv0AYrrE7eGQ+DUlZlICiB5kQujQfFjy5HeDmkNkGF9JnMggU9xi/w
	QYbyOgZC9etWbmDH7dDB43apAMOAgNviK82aoteqD1Djpcp2D/dM0gjjRMDp87mlF/5c7BiUKH9
	KBgAnrq4gtNW/zbhAL+tjTd61f75YpP7sQT7by4zJNKKy8IuUEwy8xDbWLrPbMWjNlkEdLy2r4P
	32q0JTn6RvjxbPIvM8A89PlB1IK4RAKk2G6H+h07zN4SwFaSwCAmsA1GnbtO6J6FVsUVSt0SYWN
	BvH5OIU4HqJSs8bx7/JfVYI/DNeOEV2ekb3WXS5mhbco9KBy2ZmN6CcdzLhdQzQDAu/z1DA=
X-Received: by 2002:a17:907:3d51:b0:b93:5fc6:161a with SMTP id
 a640c23a62f3a-b93765922d6mr21191266b.52.1772139418509; Thu, 26 Feb 2026
 12:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mansi Maanu <mansimaanu8627@gmail.com>
Date: Thu, 26 Feb 2026 12:56:47 -0800
X-Gm-Features: AaiRm50UFCD32ch2kp7IIWmgTAn8hUoQ09bQ4EeFm7l3aRAIILmRBfG1pVgPy84
Message-ID: <CAO_P5U2ePS55_w2OiipW48AwMhvTJZtZnYVJqKuJdXRZhztazg@mail.gmail.com>
Subject: [GSoC] Introduction - Mansi, microproject t7605
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

My name is Mansi Singh. I am a Master's student in Information Systems
at Northeastern University (Seattle) with 3+ years of software
development experience at Nokia Solutions and Grant Thornton, where I
built automation tools and AI assistants.

I am applying for GSoC 2026 and interested in the "Improve the git
repo command" project idea.

As my microproject, I replaced old-style 'test -f' path checks with
test_path_is_file helpers in t/t7605-merge-resolve.sh. All 4 tests
pass after the change.

Patch submitted via GitGitGadget: https://github.com/gitgitgadget/git/pull/2050

Email: mansimaanu8627@gmail.com
GitHub: https://github.com/MansiSingh17

Thanks,
Mansi
Pronouns: she/her
