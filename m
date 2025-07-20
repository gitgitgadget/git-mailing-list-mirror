Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CD2AD0F
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752974573; cv=none; b=lPvtGRxG943cgExTg/UExEvNJfs3xhk4VYC0vnW8XfMLoOfMQCh4Z2et92O5pwE39wFGMrmJUi++VDzBldXoqyg/jkuVp1GPWCxueV923Bmmig0pmpg9/WIGXpyxJUdEx4MPUVBGf/musR6xZgbVt46kFpc05lABrAEemWe3eLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752974573; c=relaxed/simple;
	bh=IZ/eUGoC9QlbBOz+Jfyp12+LKfCS43imZDqN6GcSZMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fMMzYLml6VxtcRn2OGHy/Jo8k3Kpm5YW6jd8otbEReK9kP5jQrRj8TI3YXUT9X+g5Up0xKWeicLEGz5I3gkp9TsYEspoBCXRRupROiXW+51QuH3loF26SFQAOEATLSfrkd4iMD4xC2c693pq9OBV+kjypLaSpm08l9O1+8PQepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRqMjaDn; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRqMjaDn"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-710e344bbf9so30215977b3.2
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752974571; x=1753579371; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yj/kmkutWO8GVDMPmfo5jOeksr0EeGLq956sXiEYeNw=;
        b=CRqMjaDn5mjUVHblVCIPzjBYb+3RJ94z+HIvDSIKEQ0kr56mAFu0gaEH2rFjIpR81K
         Ije7QtZqcm/SdDJxc++vyK5chyLPFp97gMIpeXhc0iO4YHcgK4tQDFoexZGLCye+U5Rw
         k7CY088r9hZ+iNiiMYTJOZ1hd77dKvfilQmoiKTOUS1XTUQ/UMJOifxo1yILFSbc+NYE
         FkKecnv1OEusDwVe1dJ/tbHKFW7HPNu6tmq1ZFeg26a3WpqKinUVqcdSyK03e8HzIx3N
         JQLhBFZw2uH3Gaizv6J90bmo8nLOO9Oj6S/HiAR2/4okvbxL0bVe44M3XfqY76F6MNJL
         aSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752974571; x=1753579371;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yj/kmkutWO8GVDMPmfo5jOeksr0EeGLq956sXiEYeNw=;
        b=VCTZc4fUMukyM7QgEFrptVjAdXCeMdRQ2MRfi2BMDNETvYosb1jw9oAOR5LHDSD5Y3
         3dVs1DpBfnF8McA83WYUqfJ5Rxt4a+I0tFO7c2Wd2WaciSqjjnpka5saRWPuXIt8lFHQ
         W9KNq4vsHaIpKQY3+CXP0op+Vhi61njip7x948lPfSEdpS1oVpzuUP87EXNoLWOBycx7
         c6Uqy8yx+Lju21cUmvwv9fEzKQsWTnZvmBPCpIRuxEU6cIvXFbAB2arB5oY+X+fGuILC
         S38yNUxsthwyz2HWuZc1IbVQO3uZUtvq9DFxAF1i4At3pZvZtBZYby32KuoMsgJBnMeW
         JVGQ==
X-Gm-Message-State: AOJu0Yyr7bjQm7VvvxGASxgsx3qYmDyxMOSRBqESGroFNnU1+qi6ZFE0
	rMkEtwzaF2FueEsA4CRV/N38TF1XOkk3qICbqPDHNennkjonKGShwCk0G5Zr4yHT
X-Gm-Gg: ASbGncup4GnACAar9cgRCyE2KTVwE6m+xe+m04zC8PlV3VHKU+pLX5d5tnrX6n0DSFg
	xbhwMmUWzGLgcs/gKdgCyawmDikOhCmxeC9wgzknsHYZepohYnPGLx+/IBGNAginD1ACciBYhoz
	gA6jCKzHxfJ3y78d1cd2i4B054bWl1To7sGKiwUPWLUutw5PjpUna4u3SQubTV07ZqDq8xQ1izX
	HNC6TbjY5Wemqbj7RPR3KXC0InbmAhCGIFxYUXx4toDOsSOyL5TUz0GC1JFbZqDAV7rsSkc2izR
	HR0pNsZV3ZpgJEBhYPSuPAG4sp1kLzZUmZgbegsBQVjqc54LVqImvkKdgzfLt9hHURCFz6Yleny
	nVm6E44ZiJofgrQ==
X-Google-Smtp-Source: AGHT+IG1e9H6R3S4qKdr9kBT/s5aQstazYEjHD8/fQGsdgEBM2L5zAMjUGHJ5F+r9Or/Ftn8gsBxkg==
X-Received: by 2002:a05:690c:6485:b0:719:4421:70b2 with SMTP id 00721157ae682-719442183b7mr132454587b3.18.1752974570586;
        Sat, 19 Jul 2025 18:22:50 -0700 (PDT)
Received: from localhost ([2600:1702:5e40:2a30::15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719532c7e4fsm11557837b3.72.2025.07.19.18.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 18:22:50 -0700 (PDT)
From: Eric Frederickson <ericfrederickson68@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A Question from a Hopeful Future Contributor
In-Reply-To: <aHwZQFtMS2fk5FID@fruit.crustytoothpaste.net>
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
 <aHwZQFtMS2fk5FID@fruit.crustytoothpaste.net>
Date: Sat, 19 Jul 2025 21:22:49 -0400
Message-ID: <87zfczodue.fsf@arch.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-07-18 at 22:26:31, Eric Frederickson wrote:
>> Hello everyone,
>
> Hi,
>
>> I hope that this message finds you well! I'm a software developer and passionate
>> git user, and I'd like to try my hand at contributing to the project. I'm
>> sending this message in order to ask Junio and the team if there's anything that
>> would be particularly useful / appropriate for me to start looking into on that
>> front. (Reading through the last few "What's cooking" messages, I didn't see
>> anything that jumped out at me as needing a new contributor, which is why I'm
>> asking in a separate message instead of replying to one of those.)
>
> It's great to hear that you want to contribute.

Thank you for your welcoming response :). Excited for the journey!

>> (Some notes on my skills: working on docs or tests is always a favorite for me,
>> so things in those areas would be a great time. Also comfortable with low-level
>> code, and any kind of scripting. Note too that academic background centers
>> around programming language design and parsing related stuff, so I've got some
>> fluency in those areas that I could hopefully apply well to the project if ever
>> needed.)
>
> We have a Git FAQ because I answered questions on Stack Overflow and got
> tired of answering the same question again and again, so if you want to
> add any common problems there, that's of course welcome.

Noted.

> (Now, to be clear, people did not stop asking those questions, but I had
> prepared text and a link to provide to them, and then people _knew_ that we
> had a FAQ and could refer to it.) If there's anything that you think is poorly
> documented and colleagues or people online have trouble with, we would
> absolutely love for that documentation to be improved.

Sounds good. Would love to submit some patches to this effect at some point.

> One thing I did to get started some years ago is to grep through the
> codebase for TODO statements and to pick something that seemed simple
> enough to do, and then send a patch.
>
> If there are small functions that you think would benefit from unit
> tests, we now have the framework for that that we lacked until recently.
>
> If you see things in the tests marked test_expect_failure, then that
> means that's a TODO test: it should pass, but it presently does not, and
> that can sometimes be a source of good things to work on.  Some of those
> things are kind of big (especially a lot of the submodule TODOs), but
> sometimes they're small and approachable.

This was very helpful to learn!

I've been looking through them, and have found a pair that's drawn my eye: the
pair of known breakages in:

t3903-stash, tests 52 and 53
  ("stash directory to file" and "stash file to directory").

From some introductory exploration, it seems that that bug in git-stash that's
causing those breakages could also be causing the breakages in:

t2500-untracked-overwriting, tests 7 and 8
  ("git rebase --autostash and untracked files" and
   "git stash and untracked files")

So, a fix for the t3903 failures might net us a 4-for-2 deal. I've been looking
through the "git stash apply" source code and I think I've at least got a lead
on this. Will continue investigating, and hopefully I'll eventually end up with
a patch to send!

> Hopefully one of these options bears fruit for you, and please don't get
> discouraged if you wander into something that ends up being very
> complicated at first.

Got it. Hopefully the one I'm choosing here is one of the lucky picks. :)

> We have lots of those in our codebase and with time, you'll also feel more
> confident in tackling those.

Looking forward to it.

Thanks very much for your help, and best wishes,
--
Eric Frederickson
ericfrederickson68@gmail.com
https://emfred.com
