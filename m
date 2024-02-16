Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0C134A0
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708058890; cv=none; b=ULbpi3Uj4dWYihsYiggLljH1HffGWfrxgUvWneG1ij/Ot4o2ni52JGRgppU0eq23A4kp9TdnpjdWlc9/thOnL6RXqK3DF9FYo+8XZ/K9B2LyC4y8/KiY7amdcJIzh75kqWa7FEY2TD264jUsjWzzATfqQuxbUwkbEkw4VtFD7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708058890; c=relaxed/simple;
	bh=uTm2ThNjdiMFnJ5ihD8CZd2CtKz/8jvgRdAW2yIBBrg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ml0KADqWKcK62vJTlmy34ZgYtN44+uJUQporgdvGbaF36ppdsPvgHa1AitbvO+yalxyH6CjvreG5VtGMeT5eO37G32nm3f3FEjTzhrNljspuNPBYDDRd4/+T3Oba/xHoVCo6dmBh/IvNBGZiYa0rkDdV5QKpCeEbX8t8JMukd78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEo+j4/0; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEo+j4/0"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c029beb8efso51262039f.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 20:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708058888; x=1708663688; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTm2ThNjdiMFnJ5ihD8CZd2CtKz/8jvgRdAW2yIBBrg=;
        b=QEo+j4/0dfRw00IK1wbBqfiTApIEri9mgvJVb/zyIUoWYuPW+uzxWFC8FcZqnTDyYk
         BSN8zRKIwAnzMyX5Lk/2ZBNrLE6sabI6tVbSrcalU/SQNBFvBYLIOIzepd971/YWIxWA
         NBNPX/RtZUSzKS3D3WicoDwu9E8kR/AeeIxNE3C/R0D84/nurSl6Z0LPlYp6KbO1iEIi
         M+y/CgAGJjW/W65Op1gmCTzleyYnjshll20xDoxVbUAz0esYhCm/YvflfHxB24yin3jl
         U80IczY8o4FNNJJtpA1/tF7sdVYUNgkkdKamgLWPXkZjFX+cYmqw7SQMbkSSufIzEo7N
         defQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708058888; x=1708663688;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTm2ThNjdiMFnJ5ihD8CZd2CtKz/8jvgRdAW2yIBBrg=;
        b=WPieyt2HtK3bF+AkftKohky4JkO+HT9TaEQgqREM4f0+zLyD97PVU/ICMbJJ1ecNgK
         AKMX30NSfHJWGuM0zhkMGAtCyGezl5e5EXqCOCsIRqGs9Po1ZopZFlR8vwwan1lCYBSd
         EGL+1+XONssXKhSnGZ8J5/H2ZMyQmArkxEx+AFQs6uhye7qOdOldl74suXvC4d44Xjn8
         AIOVX1DFv/rSsSpiLnqwFKhrcyE6fFRBEF64iEO2Y+/6usAlZ8jkSBafDvHYrkwhsyIJ
         3ldnbgMJ8NUwsynMmLBs5izvtLBHILGK9JE7J56pqqjebd7aDXaDHosxj7AvBSL+hsjB
         CJEg==
X-Forwarded-Encrypted: i=1; AJvYcCVkyHwrR4ekMZw+EfrCXJJ9OkAS0FfvIlAyqjO7nIIWM1SNX2gQCtzgGIIjLzOgqgtfg6PNfK3xpc1TarOrTYVug1at
X-Gm-Message-State: AOJu0YwHcQDjWoHy8LCWCt+QbzYqQETCKPP/551i9JKbZztSdmGSz02l
	SIOl0z5NWNY8AxijiSR5Fq3/oyv/GK0iTf7vByzFwl84iq2vnOgO
X-Google-Smtp-Source: AGHT+IFRRD88oYuTpi7XQXSWLOdH5tcM6KuIMiHlhv4X0Dq5mUIA9g0rjhcjiJJ/69uaiDebpuHdNg==
X-Received: by 2002:a6b:6b06:0:b0:7c4:9e7b:969f with SMTP id g6-20020a6b6b06000000b007c49e7b969fmr2017779ioc.2.1708058888005;
        Thu, 15 Feb 2024 20:48:08 -0800 (PST)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id k15-20020a02cccf000000b00473b8ef33c0sm697362jaq.174.2024.02.15.20.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 20:48:07 -0800 (PST)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple
 kinds of oids
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
	<20231002024034.2611-2-ebiederm@gmail.com>
	<owlya5o4dbj1.fsf@fine.c.googlers.com>
	<8734tumekr.fsf@gmail.froward.int.ebiederm.org>
	<owly1q9d9sau.fsf@fine.c.googlers.com>
Date: Thu, 15 Feb 2024 22:48:05 -0600
In-Reply-To: <owly1q9d9sau.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 15 Feb 2024 16:16:57 -0800")
Message-ID: <87le7lkoai.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Arver <linusa@google.com> writes:

>
> I would still prefer the "early return for errors" style even in this
> case. This is because I much prefer to have the question "how can things
> go wrong?" answered first, and dealt with, such that as I read
> top-to-bottom I am left with less things I have to consider to
> understand the "happy path". WRT emphasizing the "algos equal each
> other" concern, a simple comment like

void_hashcmp is a function that reports how two elements are ordered.
There is no error handling.

There are in fact two cases that need to be handled with oid_array being
able to contain more then one kind of hash at a time.

The two entries are ordered by oidcmp.
The two entries are ordered by hash algorithm.

The order that is maintained is first everything is ordered by hash
algorithm, then for entries of identical hash algorithm they are ordered
by oidcmp.

So I don't think the concept of early return for errors can ever apply
to any version of void_hashcmp.


Eric
