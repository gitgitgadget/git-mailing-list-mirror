Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBEE3D5253
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999178; cv=pass; b=exjwtmnQv8S8QH3HkIyeWAXcoW2/6o+gd1nwgjKWrsk4hdo2RVubd+j7IEn+l7+LvxaltPm23jP6FVPF5EzI6av9aNVWe1EqVocqLsfXfrys9gUHvdZZyrJC4yidyB65Uh0bmsSXtDmd9jqssjd38BzvQYoxH8dG+edh2i/SRak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999178; c=relaxed/simple;
	bh=C1ZhTkiJMWHa2KmZIT2pDgW7rXmLGIqFWMlunv4CxtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr14r/BIFuNvYH4afIMrWHOiWb1OunolZZ2zit5JGszyuL4PRMKrUiqv/GEx0dQhiNpNOoU3Es9FHGJ/8PCe8Y4snncSOVcuvXBsjq9mFqAX1mzgtQzBo+oAa8V04ayow8Zs1CcmEg8z/7Qd1o+QnrjzKXlQmIvHeo/+C4e5LPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXTwnxhg; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXTwnxhg"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e2fc11088dso47954257b3.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 02:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780999176; cv=none;
        d=google.com; s=arc-20240605;
        b=OH/586SL13jpWIMSHTR4DumSR7TK1QxYhSBX3woK7GGE+zs4BG0SvFL1HKyIX1zOwr
         bct/PjrehtXpOor6SF8fTErXHFU0vKDYh9AP89v+PZ7bAiXiFXXCdns57QFUBA/tMGJj
         vBLzg7KPd7vR9iNuGKVnk23uJhDQN7tKZGapuPfB3VoDktzdSeac7cS0Zr655Uk6iWvD
         KelECKRJEIrkRXOMOdjtTupf35H0FeDay/ZuTWAqFYrD1CP5ehhtiWy2g/Ij6O+Fug2E
         cfeH+d70keocaJC2euQN0WzZSwN6iqi/wkuDWKJseqCQghLdK2l3tCQwmIqe9yXqdOwP
         eV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=esP1aeLdI7uGsOZYjHQdkKHYWwV8WkxY34zL2QoOWQk=;
        fh=MCC1I/bjThT6KrrYe5uGPPuXLc/NMtRw4+mcROQVCvQ=;
        b=dLFbfatdKJ0+yAD/U6ou6uooDZxtIX9oZruAJkkhQX6AKy0HiZpjkNzhBU8TboTFzF
         e1IfEd9tA+6TQeXFuQML8qc5+BO1JF0FQeIDiSKT0hsHOhunpwwijgc9bMzkqcgQMkON
         nTVxDyrssDcfOqXlBcOve6uzp3EknBEIcbnrQw3SW0Nkek16SE+dN71LP+jO/9tOCiU3
         AvmKG9hNLj/is5bm4JfpTysrBbY2EITysWqeLNQZFvoROd7j22u10l05NoCoSECGUDKs
         tYQdUd/Z7brSAFhInYfGzbcF+kvrlY9IeuqhnNlTL95b2iv3s89Ap991LqLfmUkbgtZ7
         WLQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999176; x=1781603976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esP1aeLdI7uGsOZYjHQdkKHYWwV8WkxY34zL2QoOWQk=;
        b=oXTwnxhghZ343tv0cFkvO+IQubkdwzYJ+n71qpCmOzC9d2uvqQN05JbuoLDlLqXeYt
         6eIfRlJw7jvt7tKP02kUwX+WLchJxwlJcaawN9T/Pj7CrnnBZMHEDXRQQsC91ZgYRTKA
         vWX8otzY4CVt5q9Xg5drIHCV6RZIgiRErRPUEJz11a/r522OW+7cLg33T6VUJY0QlHrz
         kl9VAwupUCcDqADu5JQHoqy8XomVU5+PPTrDraZo2EaharJGs0/Nu7FW86Fe6GwqEleE
         Yd542oBt+NUSk9iiBq7JxFMRSpcUs4bHfQFV04KBm5NDg45mCcteadi5F7oeY2twabKN
         UYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999176; x=1781603976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=esP1aeLdI7uGsOZYjHQdkKHYWwV8WkxY34zL2QoOWQk=;
        b=DVKZeXs02Vpc3rnGYYnfXoRW8exjdN0aVw7ONozj0l8q/JhzQE0w6yMYEcP0d17SVz
         59+IBNa//2MrFttWzd3T2IYmrpE5+FrgKDZsIN/yaQ0GzJbKcesafVJ0Q+YFdHixUKSU
         qF4rmqtOjpT1HWNktvL6ipyXGfDZHSIp7hEFc386jwzSmtr1O9FcRq8F/sVRKl5Zeja2
         jfHXs5YuzoQgmzNRBLXOJ18k7WOObPs1bXV3aBzrXJEaBYKgRosZiMe0x2kpNEskSz/V
         orP7M9jLEyFWxHTJwXPLYFTFK5rtA2/NEACS9aOtiEdL/gVYcoHmwJ4aU2e/JWN2o5uP
         pfdg==
X-Gm-Message-State: AOJu0YzkDE3QOi8o0YPKKQZJWLWQa57YG4ps0VP4Mro/KkYaAW28Mm0u
	ck7DtYkWdwjgZG26hXDrC9iLe9MzFoMVjsnljkh4JMr89lFD3+FjcMgRxqeTSlotJ2lr2aXGH27
	czdbF56DjTADg/t32+xvUX/upZYHyUX8=
X-Gm-Gg: Acq92OFmIGAPEGRksKAiF9hJF+1gxYZStKdoe3X5j1F3Ur+HX6XBGVxUByILYuKmL9U
	sQOsO+thlXCRx43yAORhSzD46aCkOkis+Cp5OHRusvBgqKdmK05yVRKPCM34QgtnoEegNpsxa4n
	G+zKMEWG7wdT0M7+BxoeO/TY29mf4ziD0G9673YcPPJrLcKuzAe7b9HWDGcHMvbsQehTAnKkPE3
	2qrbN/qQhowaWb6nSFv1QkpeBPb1h+BCdDr0i257QGsNKo2+Hx6jsSMgxDLrvsuh3RPl2Uw2kuQ
	VTAI4JA6itw4vJFnCTN1wkx3JYftdeDa2puRtQEb9VlYD9U4Ks9o313zUntF23tZd5cG1a8cXtH
	rfax1bKr+Et6sNfkxAIHq4CdF69WMn2vMKWz+SSX1MFZTTylqZhaBiLFlCcR3AS5ATcRZK456dk
	AcEbbPVip5IET+
X-Received: by 2002:a05:690c:698e:b0:7d0:261a:6bd with SMTP id
 00721157ae682-7ed0d8b46ccmr173743257b3.44.1780999176076; Tue, 09 Jun 2026
 02:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com> <9A2F74F1-66D0-4015-B387-35B107ED6F7A@gmail.com>
In-Reply-To: <9A2F74F1-66D0-4015-B387-35B107ED6F7A@gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 11:59:24 +0200
X-Gm-Features: AVVi8Ccp450f0tBIxqHmy6ze_CrWGv8SuEB_Vpf8AHghj2bG-ZbEnW5tTFYp7wI
Message-ID: <CAN5EUNRcMO-ZB9_4kdSb-ddhDdU1t6C_moAdg3NM7D26xKV7+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 8 jun 2026 a las 18:37, Ben Knoble (<ben.knoble@gmail.com>) escribi=
=C3=B3:
[snip]
> > +test_expect_success 'aborts if the commit message is the same' '
> > +    test_when_finished "rm -rf repo" &&
> > +    git init repo &&
> > +    (
> > +        cd repo &&
> > +        test_commit first &&
> > +        test_commit second &&
> > +
> > +        git rev-parse HEAD >oid-before &&
> > +        write_script fake-editor.sh <<-\EOF &&
> > +        true
> > +        EOF
> > +        test_set_editor "$(pwd)"/fake-editor.sh &&
> > +        git history reword HEAD 2>err &&
> > +        git rev-parse HEAD >oid-after &&
> > +        test_cmp oid-before oid-after &&
> > +        test_grep "Message unchanged" err
> > +    )
>
> =E2=80=A6but I think this test case could do something like "GIT_EDITOR=
=3Dtrue git history reword HEAD" and avoid the script?

It does work, thanks.

>
> > +'
> > +
> > test_done
> >
> > --
> > 2.54.0
>
> Best,
> Ben
--
Pablo
