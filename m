Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792769364;
	b=jJSxKmMdaS3g6ApCzhf6REV1HpcN5zAeOmqEbng3OdfiFUVY4guE41bUGZQccJe5pLx5
	 1C1dwI5WCOwFpclUCP6vjiCWgQCSRws7mnr7WciVWEFYl2Mt5ZbK6/V6nZPeOUvSGxcIe
	 6nT3tLsQiB5LC1EnskFRXemj0CFXk6aakL7PSkhi/fa6APTgRaMWANzG247G9c9ByH4yt
	 PLzZf7TaZWfHhp+U+bWglwPUYG3Ic+wvxsCY6612hqbEwjF+HvuuBaN+0qQOZQLrlzo/M
	 sRGCpVb8NbIqUyrj34B5XwnLa+Md3oFCs0waTDUo4P91dwDtCIiMwHhDUjId0ySt4Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=+jm7BAEyHdyRUaLhF6VyE5LALzEYlWp6M8Sici9bouM=;
	b=xtDnZdYFpirOdxIQlc1Fl0YNrFBl61S+Y4OXJjl0xZlA8BRwfRzvtrgqN86lkX3Ou+Vo
	 oI1ztiCXq43ljLxmv8Qlxgp1VaRfLh9LAM+wrElSTbXmo4Vb2xGrdEFCY0SapOK66I6Tp
	 L+uysTz+NNlmOMQCPGWlu81cNCFTRnJ/iFmPQHnXWCdWLurMhFjL5fsUXobk6p34ucMHz
	 aIE+oW2zodGwHyOvwp3RqVK7T54De7gZemnkxxNjxbgqM+KZcDjFJUfJXuUy/xFiwg+j4
	 WXuVZ9a+FVFVW+xeCLuGcX5ZRvD1/oldDRT8rYVMhMr434rotKosA2Omd5A4s7D+8HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jC8MwRB8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8F606A322
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC8F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jC8MwRB8
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67992884b02so783837d50.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792769363; cv=none;
        d=google.com; s=arc-20260327;
        b=PW/YZNFECmejo/GE0ZWxJ2L4z+wOwr2T4ui+gwcxtgdVc8kQWMFOqFnjNPHYoz0MM4
         OZPv7Y7WozvVXxN9KYDhT8GX9Z5IXPdp+obd7L++uNl92zPa6ARE3C7X/vOybX3WRSym
         51UcVFSiOhf4qcf6RUjh1EIrMjRbMq1hzJZrJy/Pm/OSrEzFR1cGvMG/V4B2xFrXYL6P
         LCBHM9AOPs4idX2A2t9oyxWUosIVYerGH3oYh5sbK1XCNj6bPpTXKIyBloyK2E0XHg+l
         48T0NIvKuYTU7/VMw0Yu++sWrAnolD9EW0+RX+3Uq6CIF013YIj7nB4E96erlbpMzUEm
         TPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+jm7BAEyHdyRUaLhF6VyE5LALzEYlWp6M8Sici9bouM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=czFvil7WQsEVfW3oMx2XufYxfJ9L50nJLx4/JqvRSJ8ZT+K0CYK04HJnTs7Ayrdq7E
         TQocNA/Sna8UgyHVY3Lz1jcxlrf8XYdu+Of2X3hDgFnpScA9c6qiaOdD3CYWchEhv18P
         Su0PzCr0cRvgZlNb03sJhu5dlrC7S/GagQsNkLxBQxdA6DRrDDewKzxirACdxioSk+Gk
         F81V/oSqtGnS0pHxbiZZSywfA9ujIlydmJEpRKHDJoieppu6VrfK0NIyjyyImr1JC5G6
         hQvT8BRG5kRgujDYFdzZwp+6g11Kj6+5vq/dRXGXgljUQ0XOMAsIymooXNMhlp6TaRxA
         Mitg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792769363; x=1793374163; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+jm7BAEyHdyRUaLhF6VyE5LALzEYlWp6M8Sici9bouM=;
        b=jC8MwRB8WK098ypHEeXoNiYM6AiSx/vu5NKQ4fNL3Zb0WZujZJCB3N30Ui/l8Zr8LM
         /FYVaxS+cvlCJluOJ3rTEj6TgAVhbyhUeckMFLAYRO4l/2nfABJEili2+tW8EglC0yT7
         4znK4yle5fUDwWMAj9T4Y/kjBS57MK5AXXjBHAAsMS+6wvQ8E+Gy++pEhgoH6m9gpWWq
         sd/uwA1dx2jtmsVdkv5UOgZ8bfyEL0MNdw4P9cQ+HC9F1B5Gp7j6U9iRSFgr2mP+WJ5l
         8DWFGJgbIsV1AWcj97RDfIbSNfbeiAmtGu0H7tNjzu3A90sDd7OPbHO1v9zL941It6Yg
         2YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769363; x=1793374163;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jm7BAEyHdyRUaLhF6VyE5LALzEYlWp6M8Sici9bouM=;
        b=bQ07IfX3nkAXCAik6jj8lnfjwJ3WNycLOsZ5+0vHZ4OBDSaEhghw4qb7WOeiPnrtiu
         /VEj1lmCRI2BQvI4CBRA967DTl7i3T6DfTG6EH0VUmOWfeSJ5wW6MR4sO5rd8jql+t2r
         Q4bvI7B4Kg22P9uh64TdynK4xPbP9iE8qPjqIa71F+hFoYJMIIXT5NIUTy+mJ8nhIrZZ
         7eUYrj7H0gGkq5ZtfFgDMR+y50F7GvSYvd4hpNP4QagMGJaP07+ziEVuIgePBL8OdSLq
         NmVhlQm7Lzc1T249GyzD2pu3wTTYvlPc4gpBJqq5dSuO62UbmbHabi/4+GQfQd+6Y5fs
         AyjA==
X-Gm-Message-State: AFq9FYKoqcXbYYONj7uadb9FhBQ6Q7O9pfehHdOX61gHPNawA2q1J3sW
	/5nrnToHh7SiJk2/DQVNIp+JZUky+rl36BJfiGC6oL9wmcJtiBMYOygOmGZbGRFa9rJpx5K+oto
	1huseHuHHAMU555TFe+IOy5scel7Ovrnk02i2qNSW
X-Gm-Gg: AYBFou0szMerxZ1Me04bCMySAzicE2ANCPkxtLctKn/ezXV6XZ9msYODR4mDL0tTV8L
	awGu8GPFRw/lQTR01GkO+mXM5nU8YIQxslWoBrvKQI8ehRAmkCac6OUNmH7/06xU/zSijuqENAW
	QU9Vw7wk2JVrvtkW0OyQWUnhbwpWwxtsTvjM8LZNa0TfkiuQnYunejN5+3frI0YESaHctTtpg/w
	5a1J3H7ZGeWZvouR28Nh8/q720uTYGIXqS53EnzSp7M38HLiQ2lpBDCw47BchU3zg0nuQkWpg/i
	ihHh/mydUZEN2kCM+NPGhO+QAeBlxPkwpPohavOwurRSEfv5/x4934n9GBTbbqibTcrC+aP359z
	KZgJ+4wbYIQFqy81sdpqfJgS0SS6FzXIf/g==
X-Received: by 2002:a05:690e:80b:10b0:679:c759:a450 with SMTP id
 956f58d0204a3-67a35be55a9mr943721d50.19.1792769363313; Fri, 23 Oct 2026
 08:29:23 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Fien Dora <fiendora5@gmail.com>
Date: Fri, 23 Oct 2026 16:29:12 +0100
X-Gm-Features: AclHuK8l3aMEuIwoM7h0pMKOmMahnXmZfbLTE7eO8ULX_8S3aXuRdnGPlwjqwVc
Message-ID: <CACWAS-X4BqnMa8iJKTakF5E=zYkkyr=qsQ-=c3bxoAJ+Kpcfiw@mail.gmail.com>
Subject: [Outreachy] Question about check-ref-format test coverage
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Everyone,
I'm called Fien Dora and outreachy applicant for the December 2026
Cohort. I'm interested in the git project "Improve how command
arguments and options are scanned and parsed."
I'm new to open source generally but i'm ready to learn and contribute

I've been getting familiar with the git codebase, I've successfully
cloned and built Git from the source on my Mac, ran the
parse-options(96 test) and check-ref-format tests (107 tests), all
passed.

While I was exploring builtin/check-ref-format.c, I noticed that Git
supports --allow-onelevel and --no-allow-onelevel, but I couldn't find
any tests of --no-allow-onelevel in the t/ directory.

i tried running

./git check-ref-format --allow-onelevel foo

./git check-ref-format --allow-onelevel --no-allow-onelevel foo


it returned with an exit code of 0 and 1 respectively.


I've also gone through the list archives and saw an earlier outreachy
work converting check-ref-format to use parse-options.


Would adding tests for --allow-onelevel, particularly how it works
with --no-allow-onelevel be a good contribution for my Outreachy
microproject?

I look forward for any guidance
