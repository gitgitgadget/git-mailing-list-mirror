Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961F4CB4E
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628238; cv=none; b=Su9qBUkCsmCUC5V1FEI3UgdcyRcNrZBZf28LniXl0ywcb4AXqNiSvFejkMCxIC+vtlgRo8kVIXa4Akf3WMri74HLEAD+qaro6sA38WFBeXXWy1x/ynNc4W2PrlnECJ52o+0qLufy1oJCclAZo2RkTIgV92iPAvSP4F5YLA45B2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628238; c=relaxed/simple;
	bh=7bCcj0V5kSQwrXB/h7nQngBwves4zr4Tjcu3pNGAm30=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j9NYKwtaL3iGJGj/4FmNdmgBd9ZIN8or3rG1Mc97E63sZx8WDblgwzo8MhLHDcIHypRsfHPURcaFsgLnW766pswa0GEqXNF73tQsgN1aqxYBIn6D1InjnlJizEfynJAXkzLkpwg5t2MPqopsLY2XxrL8u/IQ/mk9m9p8u5gjg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB6GJmgs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB6GJmgs"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5135540c40dso325664e87.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 00:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709628234; x=1710233034; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUSNpHFqyxl6sSomzZzBqxhg0n48QwvX5Gon1XwQvJw=;
        b=cB6GJmgsALkRiwAgdVCjXJuw8jYadKa/6KZichSny/7Gon8iT1TPyZ/ksxAfb2Xnc2
         8LnncZnJ88Z36TYCy0/+670hlAZqxjJjn4eoiVulDhhXJil+nKxvnjRkQgD3+o2J47Jy
         bfaIDVbdfJctiAFolLnUS6XuaLSSgs42Ni0QK42b2wFF4Evrr9Y1ljBxG7jixt0C/G7F
         DFCrv8D2dLq3QVkbyyL9AeVZTblGpNxhNl/yzDPX2E6V1dIE+hEE5a4dSE4UQDFfdSqW
         RRz7NZcXCTet1AWz62HVt2XGXeZKCgeC0pf6BPBwrfMyIb7GFsiTwryqw9zbGPTKCVle
         dxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628234; x=1710233034;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUSNpHFqyxl6sSomzZzBqxhg0n48QwvX5Gon1XwQvJw=;
        b=wBJfDfXNiV06zVG1+RR8U67DDjB28YJFxsed9Zt/L6GpamYCnrdvdZ2ZFxs2iAmd9v
         e1drCvTfgFlGObA1pI+YFoNUXD1CXy9s+UqCYQkeAZJIn0R186Wrwdfk5OV6HnYou4Kl
         3VucxazUaxfCHJ6Gjhb5j4DnpUIGf0D63Ni/zDmo6hfcGac0fQstfnENgnADAkEHpKEr
         KsN/KqKD2oXg2aY3zOLDlkJEU8SYn9/RtnKyrfIElza02wEwHpg8goGJCpxZYduacR1P
         RuJjCuJ4JjuAold2Ylh+66bCqFi/WH0pvcUiBUtsK02axKGmHpBeF4JJ++8NkC2BLBCT
         6Jxg==
X-Gm-Message-State: AOJu0Yz6aryqxgRp6x4IZNcO7oI6EewlEha3kNW8gMEe9fPt32qQBbzF
	RqCUe8RgBLY9ImbdIlFZIgJJaXi2eubgfjzcIXYShI6QHxwcTMj1+TzvjRZFd8crnabTDB1hRqz
	kATRUKIfu0dw0YbK8JlSI+kzgPzrxfLaLHXA=
X-Google-Smtp-Source: AGHT+IG+C23mZculvbKUAKIf/NxcaMttCHutdXOICdhnbcIEcPgtEF9hx8UkwSXnlMn0z9fW9oMV6BCKBz32OqDPGeA=
X-Received: by 2002:a05:6512:2342:b0:513:55ec:71bf with SMTP id
 p2-20020a056512234200b0051355ec71bfmr715476lfu.58.1709628233712; Tue, 05 Mar
 2024 00:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Manlio Perillo <manlio.perillo@gmail.com>
Date: Tue, 5 Mar 2024 09:43:42 +0100
Message-ID: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
Subject: Clarify the meaning of "character" in the documentation
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The term "character" is confusing: does it mean 7bit/ASCII character
or Unicode Code Point?

As an example, with
git config --add core.commentChar =E2=80=A2  // Bullet (U+2022)
git does not complain, but it is rejected later.

A counter example is using UTF-8 with "user.name", where it is handled
correctly.

I sent this email after reading the documentation of "git diff
--color-moved=3Dblocks, where the text says:
> Blocks of moved text of at least 20 alphanumeric characters are detected =
greedily.

In this case it is not clear if the number of characters are counted
as UTF-8 or normal 8bit bytes.

Thanks
Manlio Perillo
