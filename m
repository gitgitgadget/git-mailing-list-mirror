Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936741760
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745012480; cv=none; b=VtRTO8gHUn8Kpg5Uf/9BDjFf94VSlWfVaYdNWgyj3hZZDKkU2ADI0QzG8GbW0S7yxTegScaJJLzztgihwhmt2gvKTWj5LlMWlQDNPizLcZSETjvUnlashDDO6P7dXjiJKJL9Dg6u+dbqN1LnL61V8N5bcyDRHdyg+RqR1B0igbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745012480; c=relaxed/simple;
	bh=D21IVyZOYzjgK/ZuO+YbQWnk4lOwcqxucfYHWwEf8Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/1QLIBpw2ovmIJwtT6s4bEgQAb9SYSFcw58is27fiNnJuV24HVA0MpSjMQUiwq3utLcqtXZGASsSzUAZ9WTPzh59xI1BeI3gF2E2xxyVBPISfk+8lR4EA3CsgVBXbJdfqBlbMwuMzddGHxUhr1sbm1xGb1XX4qKKNGgBwhpQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ed2172c58eso2695776d6.2
        for <git@vger.kernel.org>; Fri, 18 Apr 2025 14:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745012475; x=1745617275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBjYGEy/kK13simP89mA6ImYk3k1cYa1xy7tN9/7hrs=;
        b=Wd5VH1u5hBe6G81Lxth3DQekatnVOYvIYhAeDLvxSyXpkbzkWXSZgECM2hLW/fCq8e
         NCogtEE379nHgkoTkzmoYze69RgDZi4EYF/i3X1EgyXPTpPSDsuxhyB5HExZi+yBM9Qx
         56kkHQd4MEiQwwT3Q+9KK+EG87iRJg2YAPk1jlsZKPzZ0eyV9qqYQO7A1eGd8eftm9o9
         +bVwRVKUfdDF55z5Pyk3Zgs5/Ym85iWtN0secDnl37Vy6yz4pZJK5YVc6PX/fmBGNkvp
         bnKJTE6R8xhPQCtyhCrTDfkl94wXDNMnO0jzTpluJdA1tJ50/wb6W+AvernifUodIw2z
         UyJA==
X-Forwarded-Encrypted: i=1; AJvYcCVNpP0nk3AzkmN/rGd5xOtFCAxijAWzn+UVUou+96t7bEh1OFFKu15hYFvhf1YmWN56MVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rTq0pJFMCGg1yr8ako/hGeB1k3DZvpWG6X7F8XXheJBElCCA
	7wggI4nQ8OFvF9P/uvFOCi5ZzPQmpc5FlhiT89QcILl/AY0l9Wc/0vOdIxV6QCZV/qqEX+i3A8T
	/iDA1Zs/uPoD2YN/3pMfaRrq1GhE=
X-Gm-Gg: ASbGncuqfBdWpQVmhiHx2ieJtofJDYRQRDgZRKBBF1E96jdyIue390ywIHPk37rtn6T
	bh+E/iMs3cIzQ0m0DQtkfuozStPj2xI49t1MPF0K82pxt1q7Z40rwHgcwDojlvtjYH5Z8gLQksF
	GQVSeZtUMVbOjJGCHqlYmpZ6KV2jGgyAqrc+0VB9LMpFHmzHCPD6GF6g==
X-Google-Smtp-Source: AGHT+IF/fDNYSFD3ia6SzKcgW8qtFPqXW+NxOEUK9Lq/GVOBBJo5DZrpUVn8P4/kkMMn7yxgglVz6XbgU35lh4qZ3wg=
X-Received: by 2002:ad4:5aae:0:b0:6e8:f88f:b96a with SMTP id
 6a1803df08f44-6f2c44d5743mr29746816d6.1.1745012474950; Fri, 18 Apr 2025
 14:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250416145939.24207-1-anthonywang03@icloud.com> <20250416145939.24207-2-anthonywang03@icloud.com>
 <xmqqikn1bapz.fsf@gitster.g> <xmqq34e5b2s2.fsf@gitster.g>
In-Reply-To: <xmqq34e5b2s2.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 18 Apr 2025 17:41:04 -0400
X-Gm-Features: ATxdqUGYTOBl8PE9e5FV4ZHxIMdFH7fGZs6H1aN0iLBXQO5RFxgJw2ohxfazNZ0
Message-ID: <CAPig+cS79mpfStmBBN2a-PeQAwrgtbj6HJmmuv6C1QEDFcOUgw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v7 1/1] t9811: be more precise to check importing
 of tags
To: Junio C Hamano <gitster@pobox.com>
Cc: Anthony Wang <anthonywang513@gmail.com>, git@vger.kernel.org, anthonywang03@icloud.com, 
	christian.couder@gmail.com, karthik.188@gmail.com, ps@pks.im, 
	shejialuo@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Subject: [PATCH] t9811: fix misconversion of test
>
> The previous commit started to insist TAG_F1_ONLY to be missing,
> which was not in the original.  Let's not to be overly eager in the
> conversion.

s/to be/be/

> Aso, the other hunk in the commit introduced shell syntax errors,
> breaking the test to fail.  Fix it.

s/Aso/Also/
s/breaking/causing/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
