Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193B3EFD2D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410294; cv=pass; b=p6wkNei+6v7Jj4wSnWInuUVSbZpRH6w9HxSQz/bAueTO3xUslXNgfHvh2DwEqj+8mC/igm5ahxScECs4LLNftkayAMAFjjhhtVIX+44BSewftQHeNH/6Y+duOgcggubqisGojWNmOr75RxDlwfTeSO66vHGRdP0OAqyiEQQF+Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410294; c=relaxed/simple;
	bh=0fUETAuAOm0ZZs7SPJah2jijmlglbm178Eczj+OSoMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3iKRrx+hVO3hYTvDART6eAbHlLR46h0mnRGPuRPxuH24zK42SizlVb2aiE/niyymmsyNm6BxSDJWr4V4DLxWaS7aZD/WUeQxsNRTtuseva/Pr425RkQEok5KuKliR7TKHxGZtlNCHKL6FDOJVzfDgCMfwH6miT1u0zOEL+fe6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1VFybcL; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1VFybcL"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6d14aaef8so559504a34.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 07:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780410292; cv=none;
        d=google.com; s=arc-20240605;
        b=eqOOs6j9aLNzlB9X8kbv3egFhGGiqJ0Jjoc7AwkVb59bpuJTD8kv54QDYqX73XD6vL
         ptsT6WPSeBXmrb5UdxDmHGS+nMbE6dUeWMhicrmkBqFBk6Yg/MmSTf6eR+6DHgahBSXR
         BcobuDcyXqYHQpHv5E749qYcpmP2nxZ6ftJLT0JMvFpm48SJOD9sFB5bZXj3mXL1MnME
         aOwQkvE0ny73sqftMXsPpjFpRTBPxkfAd4WCd6/mDLHFcbt82pvFwPIq2K3xW6T2jxhU
         qpQPawuS6zvQHo8e3rACjZh82WShhJUsKKse40ws4TRj05QC0E8erIQM/VzcN7PR1PhE
         QJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0h9sDAWwTiC5JEkqQ5aaiOI8mMhgYvoBr6+ROKUzQ44=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=HPl/RbnRNrwRCk/3SDM8UygydIXGp1Xz1WLJGAP3dY6W8kvgWyOmIzet02bX2cJq2+
         HSKHsdlID0RWWs2/JotvntVcTmx6grMFg0G/ywkV1Iq4uRapywF/cBlKGupftq8pXWsj
         VuJ57SlQs71b1ScsMIENrt6gHdMAWsRx54tfhNWzoGAi9kMO3//9yMZZKL6n3ZMbP1Nj
         ys0GAzFypvlDP3+O0IBQoK1+s+OEqFs5NEFu0PgLaG0CPcVF4b6W0cxzIP6p7snN03LY
         D1ErriYeQuEJOjl3C793q/A7zpYiakPZbgBKU4Y8H9HkIyBtHM6CwjVM0D26Dwdj3y6c
         hMTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780410292; x=1781015092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h9sDAWwTiC5JEkqQ5aaiOI8mMhgYvoBr6+ROKUzQ44=;
        b=S1VFybcLFr9iDT4Eaed+t70Iu2yRdz75FjKxNIKkgB4+8DQz5jqlfV8tUl0jGbhnY9
         Tc4AoJTWSNBMMyoTic3Sxb/iw1NSvn9ll7vh7ywar9nQimkiEY8wiu4TUpDIttWGaIu+
         eUCIqxwT3W44NYG11omKxkzgVdg00TextV+7J9JtQP8aVGqZTya2stYquRd23ce2M0JV
         vC/yWCxFyEaYNy4WkkFjJ2X/WOPi0AkAoU+VtSV2DtaukJ+BFf9+FupK0SMuuSEKY/ag
         mGp5QleqtShyBxRS2QD1wjBx3kaktOvDwVESmAISFAreO1iUTVhnttOmWOtryBojHmVV
         N0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410292; x=1781015092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0h9sDAWwTiC5JEkqQ5aaiOI8mMhgYvoBr6+ROKUzQ44=;
        b=oK0mlHPzocfEkE+SqjbxapQ+VzY4QJdS7lkh6dOjUzC4L3T4EN0/zqsrvGP3RQGAFh
         a1z8nlXROpWUejBdVkem0qMwJRX23+PETkjl6Ie0+zd1YsSa7cC35SroObr0O+Hz/W+d
         T/JwsY+99yANDqWwuLdOdzRSK4P/5Kge67Iw181LPDelwlPr4E4SbAbptRhO56vosAMi
         zbSWj2c+NutR8R4W+r4uYz+28pkQhnrS4+MB3kFFgq4HIr5hm52Arp86J3Ds45wRrXju
         fKwTwfYsN6rYK7hCIRbM2rL/F6AzslKYmkFJco0VskFBJrGrziv9/LTQFEh3/ROAl/vz
         Rf5g==
X-Gm-Message-State: AOJu0Yz3HD/YIAXyG5i2rQ9n8ZYy1gb3QDlQDBLQfVM2yxvhJaOygUnh
	HYYhuX2i72EiSVxw73grzhGKGi7JVZEsFeT+IxrrYHe1h72TCDBrcuwnHGixwEJOg6WUFOnN73A
	l/u3582Yx5ugfkCpYax6fK3BeUDsdHpXOrGzy
X-Gm-Gg: Acq92OHF+wj9M5G0FPdWXSZz9Dgj57GM9VBfSWLT+WEQ1EtYXAYW4voHzzy9kjoAfOZ
	ebVnwsusX53VjOrTx/Ovj74XGrGuhbrXAG9Ppyv07WB1xiVZoh0jg7pxmNb2ZlZJCcKWYeg7h7c
	+JzLNsWh4iyQBZlM3lNHfoXbMUdhltpldAG041dJ0IP3Pp2OddY7y68FBKQdPpEMJcS2n6cJ3Jt
	qKksG1nTTDJYCtjYDTmXsZFtaLiyiMkdMAuF0OoktvEY2WeZkTwSouFb3lkbpGvc+tqbkH2BqAR
	DAKYX5TgEssOXjBtTHq/U+f8T6U00woXmrIldkdhOUUVApLNM7uE4mz1tGYefnZZzhYeTfaKwKS
	q1Fs=
X-Received: by 2002:a05:6830:448a:b0:7e6:6f9f:7455 with SMTP id
 46e09a7af769-7e6a1d1eedfmr9358100a34.10.1780410292325; Tue, 02 Jun 2026
 07:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602090808.87837-1-gitster@pobox.com> <20260602090808.87837-2-gitster@pobox.com>
In-Reply-To: <20260602090808.87837-2-gitster@pobox.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Jun 2026 16:24:39 +0200
X-Gm-Features: AVHnY4J8prwsU_QLgcuMiBn0-W0h3aQ_yTchie8cLd1BvnTt1C8OgHf8E94yVNQ
Message-ID: <CAP8UFD0ij4BTVTie1dXwTC8M_9gAvroXebFLmQuY7eUCgHrJhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] SubmittingPatches: separate typofixes section
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:13=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> The existing text said something about tests (with [[tests]] to make
> it easier to refer to it from elsewhere) and then flowed into a
> different topic of typofixes, but it was unclear where the latter
> started.  Add a similar [[typofies]] marker to the document.

s/typofies/typofixes/

Thanks.
