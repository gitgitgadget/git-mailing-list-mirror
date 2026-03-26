Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4710F2
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483439; cv=pass; b=mwi9B1sOFgyZKpQGx5FwEBGE08bCXSfPJgwvFpoagaAVY4LwjjtdOHJQTDPrhrJSZASdQpelydDSxMlTG5uENm+5GYnfsjoKN2Au2bOhRYA04Aj/v6ocztDqC+4fv8NoV7v9dE1mY7K/GpxbtKGlhcXsFklrRmR5/PDi/eYrjjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483439; c=relaxed/simple;
	bh=BiHxPrAQoZmZV2GxL0oR+IRq2PY0+tYW2Hh0iCHV9lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmQbQZPVDAZ1aFIl/GnNJ8FZIRqA7Z3I0FSQ64fybV5Ysy4UxDMSMzKfxKK6Niz0TEqyXEfIgpi+p/a6nRiAKrdkRo4o9YRSv4se/mKahNV1WunKiWFqyodZ0DSQVfkFO/N66hOpWQ5mazHRUC9MIFj7OjKW+OVEHp7tgiOTD48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POgJV0lH; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POgJV0lH"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfc085395fso52656185a.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774483437; cv=none;
        d=google.com; s=arc-20240605;
        b=ijLK8aUGKEHefuIGTb4Xe4AWA4pC3KqCzkBo6pbuImFhRWULGhMwXzP1goG35dBXAL
         Q530swNi+8L4IF656E3hT3D6HqlTnKV1kQTpMJJKcI4aT40LQShlkq4GRio4SF7Cm3sV
         CsAM42SO8wpO58Uj0MlVkVPgxQ0Vlm7QgdF9smthPcq90fBFGAdvb3Yw8vk1QHbs42WB
         ZKxJYnGrrsUZGW4uR58bCcVkbX8FkDL76gfAQZsVhzO6r/cm1JmCjyrPzHMqsH8Acg0d
         NsFiujNmIvqpDMtEnQ9UNDc/BVDG8RJ8Eo873St9QsuZMWSbYZ1cBeBgBgP75UBILgAY
         EX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w8wxRSMqw5aCCZ08sZ1oR8HRy5EKh+von+NZeOuc/TA=;
        fh=0DBOcLC+jFSg9h4rrMrc2R8mJCQ0T8WRqc1bO8slrvE=;
        b=dBVP4Aylj+cFfO7sX8q25+jRsM7pGTccAEHbANQz0/pJO4lJYi73dldmfszG8HC/TL
         EFQIhL9mWd/JzdAPQIkIXxEG9DZiQo0NkoBnoj6sAf91cRibnHMGV4qMPiN9xhfZhKTi
         4zlmxgVhJN1brWdNPkuzehV+czEZvpfAdWuBHAwCzvz93F2CC+LiiQZnDdw2rISOwTHq
         0KoEEcGubFVbY2AWv0hyFAcN1PmhGWoGU7gTsXCajnECTSEkGxUhA5TMI56buR2bylfT
         QdF2LezSC/DJgEKlj+YC0vtnKgeqmtF43zDHV8ot5IsNA7ziXd6l0wxc9mjfYQV71pmb
         F4Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774483437; x=1775088237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8wxRSMqw5aCCZ08sZ1oR8HRy5EKh+von+NZeOuc/TA=;
        b=POgJV0lHKoBn6hLPNxM+1Gb9899CN/417ndt8CvfDWI5llwmfzWaL/Wa8ILq918G+n
         i+6DhmeQtRdJEi8mekpph6sCHsBkwpoY7P8mWNCvW2UzgRcqXsiRH4jONEE0/T4Fkzuc
         wG4JNy0eYYpx02GQvBEh6zfeTJWNCv5296PduIl5FyBfQCIXk3FTbqVKponN/L49Ae5d
         wWLuCYq4POJ6RcGGOUUP4zvPY6MHzg2VgMK+D1xlHoTPYGU5vRMIFPG5I00/XezXy4F1
         uYKEbBAXxq+shtIrVOf3d9rrWw/yJg3K4OXrBG5t7a2QlqLr7dSaORhTWo2wFUnMeJm2
         Fihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774483437; x=1775088237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8wxRSMqw5aCCZ08sZ1oR8HRy5EKh+von+NZeOuc/TA=;
        b=ORe+YHTEGtQkWE4utEYTIcA2Olo8i9F2kvidWfMwzLimjiTB43KJgo4VDfH1uwtTnp
         yrd4MJsTKv+pYH9QRcmDgtBT9X6gG7J+EIlgY4UiR5Wlg48HgunAniOLCrVH3JUrsJIB
         wvi8U+P5JiGRB8ounHeG393R3WK1Ga87kmyJQfu/aTMUM5KCTZtLgxOQryCBFuA8csTS
         kflFRE+vXT6HRX/KHuMq7wYlX8hvfFMay0wgaFFQp562UngGaeG1SK7v8S5NgnIVGqM1
         UXrQqPNN3vX+qRZojPotdKvqy8NxeKE3TQEncb3yPw8E3T4NC6jNbtSnvlJ3YS44AQ+7
         TvDA==
X-Gm-Message-State: AOJu0YypShsVunwrLJEj4/o+onBf9ZIyJBnqjBxTNSFMPJ6q/SvOYSeM
	sNCneE2nqpt6I7sm7Abm1ub0c1yfSQSWz9T9XGwq1dHq+SOHIx0L9/WMkjXHxZivXnJivEe8QrB
	U9UEeMBSh3iDAiKkw6uXLsocPNT5+/ISVC9L6YiEF1Q==
X-Gm-Gg: ATEYQzzXrULDGVcFXJSVBe/kajZqtOz4HRs/pdk6EBSfZRxkyxRDY23iho0mWXWPXlp
	PYSxd1iLEUKSIomPp8JjoQ6f5POUH4bEl151sSX5Gko/fr+iojaPIOBd2C9DC0H8xnqPqmNQtk0
	9SCk3AD18+RubfU/3YFM1wqf9STvKehb5K2kOTUqBoYIBS0f7yg12bu0Pmpy43G7brkXxAN2oFA
	yVvXtaw3PZyV40XIITO93ojYMHM2F+rDIw+EViblyKztULSWDcCHOhpG2vbMyIS36cAfNEVVyQY
	TQDDbgv6N87kmFvgWF9S3t+XvnaML01i6YE169QSYkN/p3TlTHx9dZjmI9rad1i/BqnYaUckxMG
	aqo64kzvOI+y0/gBYGQMwySY=
X-Received: by 2002:a05:620a:4591:b0:8ca:2cf9:819d with SMTP id
 af79cd13be357-8d000f218ddmr833150385a.26.1774483437183; Wed, 25 Mar 2026
 17:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcy0rsfgo.fsf@gitster.g>
In-Reply-To: <xmqqcy0rsfgo.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 26 Mar 2026 01:03:40 +0100
X-Gm-Features: AaiRm51dMVlxaqWGIEG3XIaSvpDw4cxo5EeaWbMd2f9HVwtH0pHeiZefm6oE1W8
Message-ID: <CAN5EUNSM3Hyb-6M_cSis_KhofhgjaEe=kwcXmQ_oSeZ486DbiA@mail.gmail.com>
Subject: Re: Tonight's pushout has 'seen' broken with "hook" and "replay"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, adrian.ratiu@collabora.com, toon@iotcl.com, 
	nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano (<gitster@pobox.com>) writes:
>
> I didn't have time to figure out which topic is broken, but here is
> the test summary in my local environment of 'seen' I just pushed out.
>
> Of course, help is always welcome ;-)
>
>
> Test Summary Report
> -------------------
> t1800-hook.sh                                    (Wstat: 256 (exited 1) Tests: 83 Failed: 24)
>   Failed tests:  57-66, 70-83
>   Non-zero exit status: 1

Bisecting between master and seen
This one comes from 58f670dc7a (hook: allow parallel hook execution,
2026-03-20), ar/parallel-hooks.

> t3650-replay-basics.sh                           (Wstat: 256 (exited 1) Tests: 48 Failed: 3)
>   Failed tests:  46-48
>   Non-zero exit status: 1

And this one comes from 76457c38ae (replay: allow to specify a ref
with option --ref, 2026-03-25), tc/replay-ref

I also saw three more when I ran it:

t1301-shared-repo.sh                             (Wstat: 256 (exited
1) Tests: 0 Failed: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output
t0005-signals.sh                                 (Wstat: 256 (exited
1) Tests: 5 Failed: 2)
  Failed tests:  4-5
  Non-zero exit status: 1
t3600-rm.sh                                      (Wstat: 256 (exited
1) Tests: 82 Failed: 1)
  Failed test:  36
  Non-zero exit status: 1

Haven't checked for these ones. Are they already known in your local ?.
I've CC'd the authors of the two patches above.
Hope this helps :),
Pablo
