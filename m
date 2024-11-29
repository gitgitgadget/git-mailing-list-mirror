Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A8157466
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869326; cv=none; b=TLX/e5H42czkvafRw+OM8zD0NMiVjyNQleB8/2qOKAGL34p0DiwwBt7R2cqaJpWQwACrWWAR4ZuxqwY38PH15+A3CKkOvLxdrlrG45Hp6AxUU4qakJ8zqB+bQYrD2ac6mkXD+EnmZv5/Y3RGNACpxJySIKOYBggp1P9QeF7OhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869326; c=relaxed/simple;
	bh=eSNokcmL7/D5MANP6j9xAzBHdXAkAPaTVfO7w9QvUY0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lkV+VSs20U1hraUmgsnoYitL4imCn8IPCHtL6EKbKI/l+MBU5mpqsSmPzxP0Ix4jEoSqGn2IJ7AoXlm52MnDE9KVQXXeOgynyIhSEUNqiPX4cEAAeIaXlBaq+QOpScrbSfkXsDIxl2P17THCSczYY3N1NZVhhc9L7SeSLKsrrYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfG7PUNL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfG7PUNL"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ee7a48377cso16827827b3.3
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732869324; x=1733474124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eSNokcmL7/D5MANP6j9xAzBHdXAkAPaTVfO7w9QvUY0=;
        b=LfG7PUNL1j+bq/8hhZCd8E/bbeZ9ah+oLiLe11vJb2lsXLgYSRmYrp6uwZyAyrAAfy
         S9Ycy+Mkc8rW84cIVaQK9rFlZ9AjdEhJGnptkR6YW9zOPZitqt5v1M8+pPk3mxOlebrS
         NDi3UP4UdxnpRKSRiHBINqAUATw1NKH0Bsj6+o4ijHo/+PEYXyKvL/6qBzge3WvMfqoa
         qcBSxIRSHi5QJAG52hy9sshH5//0MLHmqaHy++u9aMgZHKni0Y+VheinBSO7xCSrJbuZ
         PQqPHhacs6r6BIodNTZEd6JhdfIuDl5qvcyWqiMPCmC4pRilo6FlASfErU70yYcYgsUb
         XgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732869324; x=1733474124;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSNokcmL7/D5MANP6j9xAzBHdXAkAPaTVfO7w9QvUY0=;
        b=EcwUDeOzmrMRba8h26/jk9ZH9QbFB7s345U4TvTlmBJnMEgxfup9dR6GuITwiFxPvQ
         hbHlKD0GLaX1RwykBAsQP4HhERb/TAWiUzvh4+qD9fUJt26Q/kR9UYKLQQaININfu++y
         uI3dQ+x+0G44/0xjNUzd8wZNbYQDZvt+/Yf/v/rwc9ihdPs8E/xw47ENknr4Rp/d5mvj
         pxjRUwbATV5nVEs1pKxccQlZqEt8uhaXby+XLQVq0T9xSFbI5HHjdhXpfuGsx+0Aoj5G
         LPRsx5vkd+iTuyodVetyvQipXYpMAv5cCjrSMcvI5ctmwfDV5lc7kvWaIAOEdq7Ncqv/
         lLXw==
X-Gm-Message-State: AOJu0Yz+eb85cwFG+av33F9wTieYQPyZ9DGQbwv8eyxpGxE4enaU5h8O
	iy+cINpofqIGtVEtvKRQu60g7+UyYJlzGTG3Et3wdKyOunthQlvZGfpr6/YaCzvrs4bVo19Wbmw
	P8EHYh/Azgia0in0PIUZ1lCtzq54sEXeRGQ3FN85x
X-Gm-Gg: ASbGncvbyGxRX4Muixqy+53Y2Psp0vdkFLjSusflHlr3IvLphgDtf3zuN9SPss7dlq1
	37McyfXrGC3SKSoQT6IgqPod/wQ0CkA==
X-Google-Smtp-Source: AGHT+IEu0gkknS2cTtwri0ZqJBS7dZ2KoQj1a5c4FZ1bZPZzJ85uKb6dutxuSScPiRmMqWIKGk++JLPrUvbICd2poJ0=
X-Received: by 2002:a05:690c:46c7:b0:6e3:1b52:d8d1 with SMTP id
 00721157ae682-6ef37234fe9mr126952927b3.24.1732869323946; Fri, 29 Nov 2024
 00:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Fri, 29 Nov 2024 09:35:12 +0100
Message-ID: <CAGedMtc9aKKemVZCYnzPH9rgNfMHfvukwLW8KMof1ZD+gj5MRw@mail.gmail.com>
Subject: [Outreachy] Git Internship
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Christian Couder <christian.couder@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

Dear Git Community,

I am absolutely buzzing to have been selected as an Outreachy intern
for the 2024-2025 period. I am incredibly honored and excited to have
the opportunity to contribute to such a significant and impactful
project in the tech community.

I can't wait to get started and learn as much as I can from my mentors
and the Git community. This opportunity means a lot to me, and I am
committed to making the most of it. I look forward to collaborating
and contributing to the best of my abilities.

I thank everyone who has supported me during the application process.
Your guidance and encouragement have been invaluable.

Thank you once again for this incredible opportunity.

Thanks
Seyi
