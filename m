Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396518EFF3
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097509; cv=none; b=j6pHP8cVy1BYRDGcI+V3RO8z3k+opvemsfyc1t4fgSWnDFd4kLEX47+AkGmjsdJHkKGCFk3M5ZGs44Zszib1paoiTFf4GbBLLvniFHTnUbLST3AoEjLN2QhDlGPW4KxA2MZHI6GBYx19aWAv0vegccCxl+PFEgDQtruiCjgaDxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097509; c=relaxed/simple;
	bh=dLJey6cCjZfOEGJp7a26x2//6GFZj9xG586JT0N7lfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDbD6tKS1uJG8tJxnbLqoRjaIZYWUqco0T9yg0p2O8Wkp/QnfOr1oskEI0eWQeX0wW37ToCBb4J0kEtWrDK3UGWQg89CnYZaglNUmUb8it4r4+NxnelBY1a/cuJOoZ0TTTyoE4NaWHhzhuXxwInSqcur6ltbu/BjyvzxUCIUx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2KyXHxA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2KyXHxA"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso608972466b.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730097504; x=1730702304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+3zN8oYriDH2ik9kW2OZ31FHVwr7G5WD8ju79fj00k=;
        b=d2KyXHxAs/sI8KncwGGFAXfyx2529jq2uW21qJlzYT94U1qIpkpqBhK4V4Y50mS/1l
         dVLNgFiqmc/fvfHAB87fvV6QM3ftwbT8FXgxAf781cqkIJqvd6TSbH1I7tyaYBG6QPDr
         icGiFqZbEfiMkfFfj5sXBo+gzi2dVnzVtPTmrAsJCDV43r7NB8FkC6baXkyOBhCTEclo
         C44gEwjBwssqd+LBdcgB1F6ehfWTZVkYXOj0odlug8JhedBw2yMLTzhXBXlfi3+CBh5P
         s1Blzx/bFN7/aBgSP2g//F1bT6zF02KjEFPaA/ypmrIedjljDAYCPebOfYZSnG3jczwc
         lvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730097504; x=1730702304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+3zN8oYriDH2ik9kW2OZ31FHVwr7G5WD8ju79fj00k=;
        b=Zebobkwa+UqrQ1VxZuzb8Ak9ttOc7OiCE2Qf+ayg2fXWr3TZcrUDCfmhbr6wQvyHoU
         XJiJZG96E5NFvFRkOUhNICJzAhyhcQd8DTwRCYEwenEb1zTLgMzIxkBt9EyU6ByGe8gi
         I6JkjWmvn6zjYl2xU7lvb752C8AGWuDuOSRqiiI0yxJU0RjkQkBEkLc1xXq9qzX/4dKZ
         8qY425qzV5sFLSj8oAAZdVGhgT6YXe2ZVVKftjv3bfw51Rc3i7ohFWA7CfoSiqxaTZcZ
         WzYcyGASfN93VBv23Xp8FA0X5bn4lWufqA7Vbe4XIYyp/3nK3hLIyXYvD4JzAdsOq1L1
         qQxw==
X-Gm-Message-State: AOJu0YwM9u6rWyOSZx0v2lou2TrnJ2Dt226CgKoVfueVMZhPtWNwtlb6
	LpJU9Le1kOFky9lG5hrbILuvLNo2pXLUbLo+PFu5Y/CZ7t3JNKHqzzwi3kO62Hwm/vQ+4K4TS65
	7qxjreTUf6szj1RYetZgrStlt
X-Google-Smtp-Source: AGHT+IG5KF/5R0pOJxWBlq4qOhxOBvZ1B8DXF3b4V9jngWahv1ym4Bze6xLNlITi6DIO1eYy+2OOxIeREZ8pKcbIImw=
X-Received: by 2002:a17:907:7dac:b0:a9a:bcd:b726 with SMTP id
 a640c23a62f3a-a9de5d00417mr610932966b.25.1730097503992; Sun, 27 Oct 2024
 23:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACwP9aqFY6kPOSzv2JWWZejwAiYbMEJJx2qxomEnyxnxKFvkvA@mail.gmail.com>
 <Zx8ouGN5ln_VtsHw@pks.im>
In-Reply-To: <Zx8ouGN5ln_VtsHw@pks.im>
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Mon, 28 Oct 2024 07:38:12 +0100
Message-ID: <CACwP9aqXr8+VLEQFHmmbmCaXAyec=84+m+fO_W5JOZO9+CrcXw@mail.gmail.com>
Subject: Re: [Outreachy] My Final Application
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,
Thanks for the review and correction.

On Mon, 28 Oct 2024 at 07:01, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Sun, Oct 27, 2024 at 11:48:39PM +0100, Chizoba ODINAKA wrote:
>
> Thanks for your application! If you haven't done so, please don't forget
> to also enter it online via Outreachy.
>
> [snip]
> > ## Timeline
> >
> > Phase 1  (December 9 - December 30)
> > Community bonding. Talk with mentors. Read Documentation.
> > Write backlog.
> >
> > Phase 2  (December 31 - January 27)
> > Begin migrating unittests to use Clar framework. Send patches
> > implementing the migration, get reviews, make changes based on
> > mentors and community recommendations.
> >
> > Phase 3 (January 28 - February 25)
> > Look at implement additional assert functions for Git-specific types
> >
> > Final phase (February 26 - March 7)
> > Working with clar upstream to improve shortcomings discovered during
> > the integration of Git with Clar.
>
> It's somewhat funny that your timeline mentions backfilling missing
> functionality _after_ migrating the unit tests. It's likely that some of
> the unit tests will need to use such functionality. So you'll likely
> have to:
>
>   - Investigate the next batch of unit tests to convert.
>
>   - Figure out whether these require functionality not yet present in
>     either clar or our wrappers thereof.
>
>   - Upstream potentially missing features.
>
>   - Migrate the tests.
>
>   - Send the patches for review and refine them based on feedback.
>
> This would be the core cycle of your work, and you'd probably repeat it
> multiple times.
>
> Patrick

I would like to know if I need to send in a second version of this
proposal to the
public mailing list, where the changes are implemented, or will implementing
them on my final application on the Outreachy site suffice.

Thanks.
Chizoba
