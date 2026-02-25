Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3828850E
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772000269; cv=pass; b=Lt05Cdf0DfhsWx6JaKfrUNj6Iy8r+LohbD/vXAnknif5LUYlCjBAlwaDgL5mOlH3JwHFlHxGALCxw85T8gY4oQim+HgUDjh3Vmgxv6xbYzowbn1g8T6fe8oGIMawYOEDc9jCKVV5dsXI8nu5cEuiRrvY6Bg0J0Asbqo9SJRsRVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772000269; c=relaxed/simple;
	bh=t/ewPb4eUVUyPbu39CpJgUbQ8sfgcSatCrgvyNFUVII=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lF22hAXiL5RDk41OlgUZgPCdmf9QBEZigL/fLXk30JvjlNjwOE4oDEMAcQdL66clD1aydX/hQ32L1LvQS8Fh4O4MNxIOgnm8XpVoLESNRRrecRqw4bQ7Uu1fOBvwZpL9Fr9VADnIIIBChtxr5aQXPvYmn/mr3tFCnbjKsEq4RRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoT37a7d; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoT37a7d"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79863ab8478so10548607b3.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:17:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772000267; cv=none;
        d=google.com; s=arc-20240605;
        b=YfnLeB0UKSMwUIINiCAyQbKjVLaLnXhBrf9hIz/bXE0BRK/SiaSLZtGEqAynLbpRGT
         cPg9RlKXxjbrhBYiuvAsFjPz10uMYF0lMV3dDUN4XPCJNoJ9fCFDRw+rcvC3UQMwmfcj
         LuNQK7MKTsoektTIJzSw/qYg1LPwloItzQb9S7yUOa189Q4EhEN0vf9z61QAARUBzdQC
         gTnSpq0pnqz0xiFlCG7QT+7PSn6CwBIbpdIO6K4Nu+iptpXCtZOivw965d0Djs3I4vXg
         lVl6QNMt1LChFet/cBqAk4k9xcxXP+qKKXttoCLWeBkF+7K9/XQPEEbMN4jRUu0fOkkC
         TR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3MmzNl7u6hdCAvCO88Bk/eQwtrrmM6QlH1H+7A6jzsE=;
        fh=dGTPn3PQ3NTAlbL6AZM/EXmZgWx7s3uA3uG1Xk/xOuA=;
        b=KHfPrzjEV1A4QPoEj7kjd80H+OgjsMCKcwsN5av9cUMH6OxllqmAjThEpEoilxG49K
         T9qFipr3mQCztGpRhf2u9xZXQ1xZrSIoG0GXqrtwIY8UCY37RzrGbkdri9q5doyE2Vaa
         h0LY3QVrsY91kvDVchaVNR4LlSu3TrWP+IhwynV2DwIxNxaMeAmpPQYgeayXpUDjuU03
         66rxrL6D3MR7zH4gKgIelDqyiuuirOwR1KOxxCCYncKtQgVsozcDnstJQtsLzGZ3e2IY
         eSUXrpv2GHxRSXay2onzllLTEpTjsI7cL/9VCz6ONIT3vPxHUrh9xlAM4wgIws+qihv7
         QIQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772000266; x=1772605066; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3MmzNl7u6hdCAvCO88Bk/eQwtrrmM6QlH1H+7A6jzsE=;
        b=hoT37a7dWFaQb9XIZ/4HVCUEKJlLCSnC/dngUwNkr4ouypK8JrQN4cVeISfUb4tTGt
         jRcZlx91BFcj174Ffz7Ef19iBUm37mF72CL1tbEa74E/lakbnMHu1vji8pqUxg9ksOfl
         a1S66q+k+7kizO30Gcqin4C371MsK/r4qRbYPlIrwC1Me9VXKqrrSmoCdrNNYq6p3hGl
         MF+uYz0oWVc+wT40jyg62khTAyTnaPjBdX+xOX9A7SvRsApCl3x441qOvUn2rbQ1tzoB
         xV1hgPSndPKH9fR3xMGE2ACGXVMg4ARC9oXPwMuyqw6F05PHljMmo6feplOGQwx8o3Sr
         G4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772000266; x=1772605066;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MmzNl7u6hdCAvCO88Bk/eQwtrrmM6QlH1H+7A6jzsE=;
        b=p5kni3+nuWWYbSQPRexkKyUTYjykOz2f6KkJZR11AWy/WzN8DgYJWlwnY7rqGw4KMr
         riT4uKWqqLC2QWbh+fGTRRSbdSWxwdJiOoEgv4if/gD6N+VH/DTyH00/iFZt8rg97uHW
         WTxdUSPRsPHlhUcFoQyaDG6KCCL18DgJNal6YAUzASAn9j63lbDLe8naPcZw7djLO/H1
         D9CgpniWin/IV3OH8qCNb8VfZy8/8MOiGw9pdnXnUyXc5y0Bgl8lNowCXMQ+7TsWEKjI
         NuappZMTxq8owGt9BvEWTVUxoFZzPezvBUomjJpW1X6PJ+Y2cF2tVMNCV+FHvDJsNfer
         ZOvw==
X-Gm-Message-State: AOJu0Yzdf6ksK33pFjDlL58PD91F0bJ7yf9e/bQFEicAD96WLzKSxD77
	q2Et0bTl9c01yLQXRU9A2zypa3MNkrkU/QWkk+qQ1GjhRwQGis3p6qX1MWA1blR7yKRlT1Tu/AG
	8OwjtcM3PxecJjvBwcBaNGn+7G221Kc/e2b8nMAo=
X-Gm-Gg: ATEYQzyVInkv5Re9A1o0QLywWTjIUhzTim49yFuyRaSHGczNYOaP3TTEcooYhrU5VeB
	IjTuEjjMunlSlSjpwqj4Hz9bZ79p3ibrCUrTB6fZ6XjFdr8TpgG5ifaach437ag6bN/LLgoukr+
	thsyEsQQfYlR+QKgKnc5nTKqDDHtyK0UiD5+8cuCBODXBIeNiy5GjQJCGEWbHHkEr4vWvPWVORS
	wLtnS1dnw1KBmmOjtqNz3tO/GSU2aRVC1MWuZHU+awhuqOo7VWmHo5WsR4hgKVfjv2a7JEg2awI
	4KGMLe2gnWa3m1bUNGioU/rAeK+9+nQew4Eic/BN
X-Received: by 2002:a05:690c:48c5:b0:797:de07:2102 with SMTP id
 00721157ae682-79828eec9e7mr148314537b3.3.1772000266549; Tue, 24 Feb 2026
 22:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Wed, 25 Feb 2026 11:47:34 +0530
X-Gm-Features: AaiRm52nnKaVJ0UP-VuHq8eEveddLFMZRXITGU_F_gdiYnhgUM2ulBHaWz0gnhw
Message-ID: <CAPvEtrfYtEvsxbsD2Q378R3e84DwHPPCSgaa1pQugrwchj9h8g@mail.gmail.com>
Subject: [GSOC] Discuss and Introduction: Improve disk space recovery for
 partial clones
To: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	"jltobler@gmail.com" <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello everyone!
I am Amisha, I have made some contributions to Git highlighted below,

https://lore.kernel.org/git/20260121130005.72375-1-amishhhaaaa@gmail.com/

sparse-checkout: optimize string_list construction and add tests to
verify deduplication.
Improve O(n^2) complexity to O(n log n) while building a sorted
'string_list' by constructing it unsorted then sorting it
followed by removing duplicates.

https://lore.kernel.org/git/20260129121220.69267-1-amishhhaaaa@gmail.com/

u-string-list: add unit tests for string-list methods
string-list: add string_list_sort_u() that mimics "sort -u"

[WIP] https://lore.kernel.org/git/20260221162359.43336-2-amishhhaaaa@gmail.com/

My time while contributing to this project has been very rewarding and amazing!

I am aspiring to apply for project 'Improve disk space recovery for
partial clones',
I am aware of sparse-checkout and surrounding code while working on my
first patch,
hence i believe if we are in cone mode we can easily free up the space
in partial clone
for files outside of cone mode whenever user runs cleanup command, however
figuring out what to free in non cone mode is a fairly new topic for
me, i would love to have
discussions surrounding this, i believe a lot inspiration about what
we can clean can be
derived from git gc and git maintenance.

I would love to hear opinions and ideas on this!

-- 
Thanks,
Amisha
