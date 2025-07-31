Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7324292E
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990631; cv=none; b=FfKGGjGdbhviZIPZGf0hKcA/2WPd/0lqJvjWg9BxzHhP4AAewcG7SI908Vkcf5dU9/Z+7GCF8nEijgl3KlGZWzraoPHxExa9QCu3DFGtbvQhkGWQn7KXOz1cvNkQ7gPbrBkBUB8cCo/iOMreok6ff5KGBxcfrXmCn1IcYzVe1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990631; c=relaxed/simple;
	bh=CRUHi6MD5GbOjBB3Se5KYNmKBgs/GBfxWplXkVCgkeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prL7irK/Nh3RuNwhpmMbET5mtx5QnOh1sU2D/96XAGl6Lhyul3wpOxDQJt397xWIcu5LuzOJh+TtnOCdsreVq06xMf7YkzSRUnNUI8s91O/xJNvhMvmzEWeRRG18ZH2sC22U83WAl1ugVx41jZT9AmeQh6/osPyy/zZpT+50JhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab57abe53cso2926991cf.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 12:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990628; x=1754595428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlacKcyTP4zASDAuTIpH/RweoxOqtYpG46MJWBzG8lU=;
        b=ubp+9DQg8Z8ML7cDQPYbwV/pncnExFTm+EpK61mh6OvfA3zCvEP5JjjC852Gl1BvAK
         EF4XiaZdUg0xD64+3O2lgMiYf2l6w2VXDl0FrAV4viyKaZbHtGP5D4Og3Y19emAm3SlX
         RrvqMblt/FihzApI0XGdvrVtKark/TMszInNhb0HYQOEgdPG2txDquk4oNCQf7Q6jylb
         0bI0AnHEBn9EATM03X8PMtWSZHeK+lmS0dXmkPijb/Tcs2A0bojtjDu3nR9zATyfgIZP
         YRCR2JwuB1s7jRf1U4A9mQAOT3SKUVNSGh0T3g5BhF+2XRKbkIdn6gStpPwZuC7ltkQG
         nVZw==
X-Gm-Message-State: AOJu0Yz/2bM/RVk1gpWGy1+hhPeXgG/sBCVkdxn+6CEr7LrO3osZM5yG
	ak2OJYTT9HyQC+pK2B9787DTUcfcvhscT8X0jtAVXw3iJ3Ja1pLA6QtOW3/1yB1zGT5XlG7vnq1
	GuQeCtsv7Xw70LAXnNNILzRqfMlpg3/EIyA==
X-Gm-Gg: ASbGncujWfkdbOzWGWr6slagZGEqP8dU33TwHD2RShII0SXgEiaZjcOmjHpjl8fAIsW
	1xmXlBs437xKgWPlUmX4qgZgIblmqRtF9yOmyHUNC7617CikSl3zbqjVaqSvgiItPgCY1LTRlx5
	qGxPL1xThRiG+Kux4q79D8uv/pSRzyoGFhJRszCI+ALH63I6VzfEmGVvkQZmSdG4++CTMFpK/iL
	OwOwzrCJypz6oovp16bt1LTXS1o8eKDIPgrGiJUYSc3kTnOjYU=
X-Google-Smtp-Source: AGHT+IEKzP1FMPzCWRGon7gaQtjy+KgAB5ioTyE6FlVKgsHUBWwOWFbbmHg31bHnp2YM+gS01CnWOtoyrQRuQRD+CGM=
X-Received: by 2002:a05:6214:519b:b0:707:6347:b6d0 with SMTP id
 6a1803df08f44-70766e1373emr52312746d6.3.1753990628455; Thu, 31 Jul 2025
 12:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731063949.1601669-1-gitster@pobox.com> <20250731063949.1601669-3-gitster@pobox.com>
In-Reply-To: <20250731063949.1601669-3-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 31 Jul 2025 15:36:57 -0400
X-Gm-Features: Ac12FXxbOg_1v5oPSTa-t8V2Qad216QfZm9VRLOCxsQV5M2yoYM4LZMg1E86RgI
Message-ID: <CAPig+cSh9gFOd6hyFSJTL99pRMU294P7xnWxuko_nqz26M8DWg@mail.gmail.com>
Subject: Re: [PATCH 2/5] string-list: align string_list_split() with its
 _in_place() counterpart
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 2:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> For some unknown reason, unlike string_list_split_in_place(),
> string_list_split() took only a single character as a field
> delimiter.  Before giving both functions more features in future
> commits, allow stirng_list_split() to take more than one delimiter
> characters to make them closer to each other.

s/stirng/string/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
