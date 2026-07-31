Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258A412276
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521256; cv=pass; b=NsbXMSp3hbOrLpOHivdfjhoLG8fCQCe9+ILCgmFSAjOq0Y5hMX5SOHbl45NtgZ39BzfL4TnKXzI6bRQb9TN98wYX2+WU7QqlIYK/k9QyCV4aWClZnNzLDJD5NEWxa6Q2TZXTUu2FSZLRxOe8z5aagommCPVAiQw5XqB6jngfuVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521256; c=relaxed/simple;
	bh=SjeMvBCaplWybQldkTaaDRY9relPP3OjfR4QkpjQ+vU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uozQZYZff0+IWJn38KcZuox0qryjeRxJ80BGglYBCXBd9gC4zCpr7uepnDriJJE0pcmTcangyaAZtlWZwMTYIGrKQKFfYB/hz54EA+iQJNpezKVYqSs+QQm4fjpFJqimGZcJswe+Dxr0D/W8NNJaAg6C645/XZnzvwQOZxKf+AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=getgardening.info; spf=pass smtp.mailfrom=getgardening.info; dkim=pass (2048-bit key) header.d=getgardening-info.20251104.gappssmtp.com header.i=@getgardening-info.20251104.gappssmtp.com header.b=zClB6G0H; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=getgardening.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getgardening.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getgardening-info.20251104.gappssmtp.com header.i=@getgardening-info.20251104.gappssmtp.com header.b="zClB6G0H"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1276529e87.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 11:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785521253; cv=none;
        d=google.com; s=arc-20260327;
        b=WAw20ddSU9AxgXAPktpMbwJ3m48zhMdP7FWhrL6rHOW91ZRAkKnAhfGADJmMnXNbWJ
         iJ8c9CYPsFrebfyvRCtSEEkSwQcOSIWLSETF6wH1Flh0CiEHNbAWfcibUAYxlCD/ycF/
         nbGtBpId5r62L4bl+mYjjG8gZWQO47z22VB8SwM2XiugBXAzEKwnfFyfXmSONtyVFYD1
         bu9nYo5E+qbIf1oIza63+O5WELFM9CwXGlSTMYALkatFT5Z4S+cKMumyZQtDCucSmQ+J
         0QazBkNQl+Z3cubiX4FFZWKj6KiJhGSDqeOtyJtuxs/m+3T3csPWGmtwwjqixgFZ8aX7
         ViNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=SjeMvBCaplWybQldkTaaDRY9relPP3OjfR4QkpjQ+vU=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=oKdWXtQyoqeTWmFjc4T6qHyTH0GPZFdWydJpRj8cTqU9FTfue4KZnPOfckwyaAYzRj
         4I1v+vVIy1HiPsEcPuKhIb7JlLeaxnreQr0cnOzIefm5E36xx4+VzrD4Za/y+qXOM8Yh
         w2m9i1/SyCcLDnFIPRYl/axiToCsO/Bjfsrc+ulvBgc+Qm/tULGRhw6blam/ZK39zbYX
         oUeF6f3mR8E//iaN7sSlWFDqIXa8LNhxH3B0Pc750oKwQ+4XCjLWdixUQijg526FsPJq
         mEluyWXARNMXw/Wl7B5Icw/v3Wo0+szXGc1SJd2CuG+aZASu4SghqmwQ/BgLKH5uAll6
         /Tvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getgardening-info.20251104.gappssmtp.com; s=20251104; t=1785521253; x=1786126053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SjeMvBCaplWybQldkTaaDRY9relPP3OjfR4QkpjQ+vU=;
        b=zClB6G0H5IzZERwHpR8uVQt32m9Ws30i9Hfu7fxHWvNCTpBSWYNuNO+AAGEd3KPEJl
         iknZj4I3gYebGEfEyr4OFVIGK0Zxh++gIJd7fj9sX6pZ+BFTyOKkiTUg+sKJjv6NnCf4
         5tiq0IgQwRcJmoN7McvxOYNxnrUfI0DnlwIA6q9iD2jZkMLZPjbedSEwQleSTB932B4G
         3n/+at4jTxiXb2VwE8xHhNrnhoLTOqWRaslcl62P84jqNJMeUyfmjUzkJI9QhBXPxGix
         3syR/3YZL/Ftfr3O1WX+Rs1n0kedWHj4bylEeY08Gld2mRqhdZ98Nq6JB/H6OdEPXGHr
         5q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521253; x=1786126053;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SjeMvBCaplWybQldkTaaDRY9relPP3OjfR4QkpjQ+vU=;
        b=D8aMaH3F/GUG6vpmBgvKZlb5nOOJ5bsXwYXvYrQTLjfzcQKJGqhijV4hS6mZAwbwNp
         xF3H06i+0Q2HI1IFRcDX0BTSdkWWCWp4RmzQuEiJlo+jEYZhMNL56VHn7GYwuvLakpK5
         LAXL0WGBg7/+vKO2n5Cm1HW1kREAVuKqSnr6HPVD82yTxvTcVaU+OObRl9Iw0fnZWULf
         tUADfJTBpgKCLI8suSjEyE4mt6MLuukmi6yx4PXgc1N9OjuWNV7yVWKhGexcFCmhV78F
         EZ/eflRH7yUDCip+eyo5ipgVFjwSavjnnl9/KAlJyOHRvO/yE5acUYL1HIMhMpQGOPzC
         3new==
X-Gm-Message-State: AOJu0YyjB9vpnFLZZsOJNXK3zg+fKbKJFP/ud7ODatL5tx2bgDU3thoK
	xaG2VKde+MGHdC+JjREKoYAnanAJhjkiunUSdFxlNB5z0kp2LUXLm/10AOkV+ugFgwyQcAEKQFb
	jioH56qzgKRRK1lhfl2jzggMAW6TQf9UdELnm8TiL/tCfqLVtUhQ3
X-Gm-Gg: AR+sD12URBLsPZU5ic2yDVrMadMA2fCS+Qu7jPl8IA58s1bZxT/6cSiXBUbRt5s120L
	EyhB6AasFE1AdZWm+OVgiuz+7OACwn+je/B6U/mBr37+cEgh7uLfQalbhvxCev3k70ro+xhIf8J
	+mLRFAdbg8B0NF8uMUyAlZByp9ZTOGMCzc5ggKeUqosH6iGEmlefPtFEeVPRMQ9oFrvToDrE0sx
	INfnAdZZVsqhq4tObWamv2JfaZ5NwFZ6NrqRQhexiEsSY+CeihpQ/mKjjhNfKax6TUXoxhCrt+7
	a5nEDqIWP/nD5gypwjZRP1tex4KwqNCKTBY1jXAeX7Q8HmuyIKjXajn1vujaNlXBEN+ynM8fcra
	9s9NcZ7Vv
X-Received: by 2002:a05:6512:6d1:b0:5ae:c43a:c18e with SMTP id
 2adb3069b0e04-5b2e4f29809mr150278e87.23.1785521253260; Fri, 31 Jul 2026
 11:07:33 -0700 (PDT)
Received: from 713147890965 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 14:07:31 -0400
Received: from 713147890965 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 14:07:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emma Croft <emmacroft@getgardening.info>
Date: Fri, 31 Jul 2026 14:07:31 -0400
X-Gm-Features: AUfX_my1pbemHtBDCSVT_XJAQ1Xk0yRTtlra83VpCoFNfguFx3XZpJxOvYWbqS0
Message-ID: <CAKp8jRU1dGD7Q5T9vKmGubcst+pFu_Sj5ByyMvtRiuV-DZfhNA@mail.gmail.com>
Subject: Is This Topic a Match for Your Audience?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I=E2=80=99m interested in writing an article for your website on how to sta=
rt
and monetize a small farm. It will provide fairly comprehensive
information and guidance on the whole process, from financing the
farm's purchase to planning crop production to ways to make extra
income, such as leasing land for a solar farm.

Do you think your site visitors would find this information useful? If
so, please let me know, and I=E2=80=99ll get started on the article.

Best,
Emma C of getgardening.info


=EF=BD=9EI like to think of my articles as friendly guides that work for bo=
th
people and search tools. If this topic doesn=E2=80=99t quite land, I=E2=80=
=99d be
happy to plant some new ideas that could grow better on your site. And
if my emails aren=E2=80=99t your thing, just say so, I=E2=80=99ll understan=
d.
