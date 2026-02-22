Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A8BA21
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771753652; cv=pass; b=UNAZbsMDqvQW9Viaml+D8z5aEW29ZJWrg5mK6DoCps35IsuHyVbaZtuuyMt7K/BqIPdvtOgYctG3Q/C02W6u6Gwt9yVCYZQv7TkiUQE2vPfM38vUTpAg+rEa/3+ij9qErTuSlCpMILGQLIVJb5qT5vIWlQ0H4l23UfIpZ2/3Cng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771753652; c=relaxed/simple;
	bh=1KLlLbLLtla//PH0mZkpDxfNWGcFlWVxFSavTXeQolY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrLe0w98AWXBGNINaKGjJu9vZ+uGxYAOUJczLRb56UNFeai7X2iYEIiThDkf2DwBQTOhumU82oayofs/YaG0A550X7aU0flquEzttq70ACbN2eG//F8O0CDgAnvgpmo2im3qcMsc24t2Xh+aXXgrNjbYq52c5Lz6hbKUsIIxGEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlEOwHuL; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlEOwHuL"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79495b1aaa7so28403247b3.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 01:47:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771753650; cv=none;
        d=google.com; s=arc-20240605;
        b=K7e4xhJtNE/lGd1WN3muMpJG9FAxmwg23tJsr6UaNcXHcuInDL5bu61JR402bVJHsS
         zeYQgw9dvo9M0v3vVDkmMXneNNYvVK56iTuugj2goJOGs7hNKj6sK6alGGUCD2SqJlOA
         gUdvd/686sSvRs/2PEIWsNfwPv+ru5qmHi7zvMsAGN+vWyYCkiptOVxu1mxUB7tjmpwR
         gQZCVS48DwlHeme3ApKO+so4QfUhEqU8vtvBZRrpOzbL2aIwiEwrSVEZBB+9wTKbuWHQ
         JKlE99yCs24EQmQ+cDqTu6vnvxhfKYWDISVq/UvohQgR2mwMsnWP/6eJbmlragWpugc3
         Qw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1KLlLbLLtla//PH0mZkpDxfNWGcFlWVxFSavTXeQolY=;
        fh=dyqx4q2bh8e/daHqA3J7TKDncsgY4Xrr5cVwvb8Heeo=;
        b=MJPx5SmrPGzzN5zdEf60lfnaSEM/LdBZrkXBy5yWi0IIZJT5e7c/mUeDS2bMmjPbAX
         9gr97zSmhWtdeJArXVPqpVqL7yvQabC+Atr/vV0HctCsFdedbXhT6QNTCA/bdRUY5deB
         EpQBO6zMpDUhWH/hEn6wiE9UjqQyJbhPp3BM6AjIQZ/ZPm/rR36Y5lRz6WQ6saooZOzw
         DO8paUMOsBgFJYL6jLKRjWK4jN8r5bfzk0bLl/5K/LnQs96m8bueoViO13bJFGYbpKvY
         Ra/jcoN15y4co24v5/pVpPaVzdcXvGdYierZhxg612S13+gWAocxzldpKYjsSiUI2mgb
         MtwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771753650; x=1772358450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KLlLbLLtla//PH0mZkpDxfNWGcFlWVxFSavTXeQolY=;
        b=SlEOwHuLSs7WbipXvEZ+UtVhEOvNPDN7rtIZ+06Ljs+4+lE1b67vsPYxcOOv+96qF6
         rp1qbXIpVmbPCmBTsqFFOZz76vh/DLUnVx60ZaJnwU1kVv24VE2RvWYwE6b9wQk+zDxs
         hDECIMHSdAcBC353jqaF9skqS26UBeZHOKl0qnfSshxhFW92BeyJgsn8FcmMGSskuuIm
         YAsv9o/9jeK/cjlikKAzlrZ51cI+ccqU0KhIoFj/WMsjIL5sAts+uMdXzN5NdlmHWZdX
         j/Qe7jJrpMyY4NeKdwKYaqlMR2qsyF5MqvJT1YYsJLXmRes3v+fW4ni2r+XkAHoZhHV0
         5OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771753650; x=1772358450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KLlLbLLtla//PH0mZkpDxfNWGcFlWVxFSavTXeQolY=;
        b=jxcGdFjd3tRFXZ20oT5x6tCi+LIc/Cpr1i3Y+dCBHsi4+HpplJAdGFvjYVDypMglFT
         aK6wEkZugzk8M88vKgENXKyfUNFmsj6AreCk4u4MK1JTXchc8bEWvHLQkzghtll2BJOq
         VAygHPJGEWpecskDFPqu3FBwy7rjtqIstyDuthGU/CBvUJKdmVuNSQ8F/frhB69baj+w
         sTAp5yEf/v1MgKuB3kJI1bVnpc1xb2s7EfCjWrD9m+et0GK7O/SEK1V7bj6Gy17by/We
         1OT60akmXT59C+jb7QSuCfXDClYEWi8dcLJLaYTtkCXgc9RkD4wnwaTCxMtmrypoNNp/
         tt0w==
X-Gm-Message-State: AOJu0YwizhgH2eP/RQQwq4vxZbP2PSbGjewqeppxc3eDLT4L6CPKE20/
	yE+F3178IVVxZ1NAem2bCMb6zQSkbW9JKxHM3+qWPKu5Wtm+4QmneTHtUh6j/RVEK3zqG/3uyWi
	Bc1xHNTVlnkiWlBEoIr0MDWjxSWw3pKM=
X-Gm-Gg: AZuq6aLBzi9RNv0M98PhCSo3rrVL1yWDok3vp6ItJ6ezOB0JU0ROvFvqgZS6Twe4xam
	sj4w4XqYcuZ0qBI5Z0sUjcUyvAiThcNfsY3BX3vAKMbcWyTdp3vPUcle2JL25niSYw/sTVbqcNJ
	zKsusUyma5Cq3QQ3addqUYdzxAqWSIlvmE1PN92n/rqPhPUjRZmqZbU8fprs3OQW37l4Al/vYf3
	xGrD1g1grPXkBqQEZiTApvSl4OBKh+UGDF6UZcv1w2BRz8Vv4k3Q7Oup4lVBrvJgX9nOr1rycl8
	PRNgPtzCLKivvX76q9nf2QDnLvQZQv1HhA7PdPOIOChEBsPZ4cI=
X-Received: by 2002:a05:690c:9a87:b0:796:2fde:5dfe with SMTP id
 00721157ae682-798290025ffmr40809777b3.38.1771753650135; Sun, 22 Feb 2026
 01:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260221162359.43336-1-amishhhaaaa@gmail.com>
 <20260221162359.43336-2-amishhhaaaa@gmail.com> <xmqqwm05qsei.fsf@gitster.g>
In-Reply-To: <xmqqwm05qsei.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Sun, 22 Feb 2026 15:17:19 +0530
X-Gm-Features: AaiRm52Fb2q3N31ERHHDrSmFkJyMGGirUirxJ2ZvvC5cXU9g9X5T2Jr4os0_XQg
Message-ID: <CAPvEtrfmgq8f2z7tAvR-oCEYoiG2B+Pj9EqjUsKuewnO73tVPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] help: cleanup the contruction of keys_uniq
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> The striking similarity of the body of the loops in these two
> functions bothered me enough to try writing this; the result does
> not look too bad, I think.


Agreed, I was also not very happy with the similarity present at these
two places,
especially the wildcard and tag part, tried to convulse them into something
singular. It again started to look like the original so ultimately
kept it like this.

>
> By the way, I'd really prefer to see contributors *NOT* to use
> undeliverable and/or bouncing e-mail addresses when working on this
> project, as I'd always have to edit the Cc: list to avoid getting
> bounces.
>
> Thanks.
>

Thanks, I will take care.
