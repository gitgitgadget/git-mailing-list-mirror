Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E876273FD
	for <git@vger.kernel.org>; Tue, 13 May 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747135051; cv=none; b=do6vq/e4LePDVugf5VYXiGexqu+li4JGPKDxk5bppzY9rKUdaZec4lyY4AY7PiMP6VeL0INjYQALX2RyJiu8RqR98wVfWlLVIXHXoMCXa2Pf+EYedoPm7nszI8GwBSGa7ssjYzWeOPkbNlKWgZO3MakWhCjv5CP8jYkjfsuNexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747135051; c=relaxed/simple;
	bh=y6rKQ1yE2Eus1BMMANvjkhw1Pn5Hs8NGKjsA0rxJLqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCWwxq+cjm3um52Vpoa7g0Wn10fye6r+gcFUMRnC9df9k80Pb65gWsvmxV+JSSm97+0J1WBklvhr2Zy/JEpejJ6dToENCawX/x0OrZTML7pv1V/zGOx7U/HyRVOUuMIyFIN75zQcO9rSOLWwGb55fzG6cbEkUlybFzH2y22gZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejrVqlX3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejrVqlX3"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a1acf61eso57867751cf.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747135049; x=1747739849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6rKQ1yE2Eus1BMMANvjkhw1Pn5Hs8NGKjsA0rxJLqA=;
        b=ejrVqlX3Il9YnDV1uoWhyxsSnvSFFSHeS+VxLKFZtoNO87s1b4ysmTiCbRyJcCu0BZ
         4n9tliK4z8Gq+izuei4TKoVvaJ3hyM2gGy57aP5KqDRN3pFHiXv1gyatjkZDYEXb/vrn
         0mvUqgA87fhirl7ab5eTVJHgfaLcFuwKEkXgnQ7516ZVkCpkyYOD9a4VWbcMT134zrCQ
         FBraLPA9rJFQ40rq7IG1oBC/PZst2qUFP7pAdM/v96/IOVJb9mdvD4/Tn8u9sHDsLBWR
         ZWccQOheHj1dy+DnMGVq2mkcvR0LftO81pFROkf5PtZpRP40jB0M5GYpWa2whidtfZSS
         5bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747135049; x=1747739849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6rKQ1yE2Eus1BMMANvjkhw1Pn5Hs8NGKjsA0rxJLqA=;
        b=hA0z4sSTNrsxg+viSUNBmcoJShSQ0WRpVCEF8JXgtmUfy/1NmEOYjCjTz913bkv7xz
         bwZ1x7Gx8tNm9eCjoV38cTM2SiFWG59QkBTEyteqS6pMOo1u3DWNaI1oJmbWOGj6sr7a
         VGoqcCFqhbdcZ2lx/ATLXEYkwI8HtnJhYu7nR3NwwkRa1hKmbpOwh0PwReTxZjnxAlnO
         5q3SQD3qNuclCcu7mDqWhWH8vXPXXYrHA7mR03BUNV4wi9/vKc/rurlqFO0vcBpovc9b
         8UgoBWBEvvSiibpZtadmE8KQxFBLWUhXlLNp0W+NtKbf7S/teR/4gLmaua3GlBdCdA73
         LlyA==
X-Gm-Message-State: AOJu0Yxhj9PF+fd3eADjJ1NDuWpO94syHizyDEU0dT0L4ivQbegx7DJm
	eX1p+lhXg9EUd4jO9AO5y0nWHC0mJA/Yvn3ZebvQmK5TZIO/bSuZAyns6ohMb0NyeLNJG+JPAoG
	tP1S6fOhDgacm3hSvGVWv6JTeZMS/LjOBe9Q=
X-Gm-Gg: ASbGncv8jqsKAqQuPPykqvJR8FI13PdRn+VKKwAs8Mvqi/hY+e0JqcEdIzLLkGB35/c
	JvbgESH4jLqEDwzvzIJwdofe1yvW5WnayKT451vWNRbUKzAg5NPVGBVSRPtBDEsccpL6CEeFVl0
	miZ+1u5R8fRQF0YfjX1vzMqPhpD8sPY6liads7LaSg3Oc9oNMYe1+hSWfK97HX2wdI
X-Google-Smtp-Source: AGHT+IGoe4FDZL2kPaoH2DuXHTgQNPJd8PbmbENjSplG/1KV0ibjDmS2w7Iw81ut3ore9IJLPqYmcV1Z+ZgGP1lpEXs=
X-Received: by 2002:ac8:5a49:0:b0:47a:e6d1:4126 with SMTP id
 d75a77b69052e-494527d5368mr251580671cf.39.1747135049004; Tue, 13 May 2025
 04:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqr01si441.fsf@gitster.g> <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
In-Reply-To: <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 13 May 2025 16:47:18 +0530
X-Gm-Features: AX0GCFudsHXc2zIZFdJp3jrZcayaW-tbzuiHWa2CdvFrCqN0bNUR5KvKoMJKE3w
Message-ID: <CA+rGoLfx1fmCPvTRTMijAWOYT8JGGBkH9gqYsqVjwAVHXoX3eA@mail.gmail.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey people from Git,

Looks like this might have gotten lost in the void.

Would appreciate it if someone could take a look at this series of patches.
These are documentation-only changes and should not have any effect on
the actual source code.

Thanks in advance!

-Jayatheerth
