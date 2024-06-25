Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B0145320
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336835; cv=none; b=mavJ1gosWEgPi8aH8xMFfB2ewXq5T+EwAnDU8mkdG/hBbZbgB+dLRO1SMaVTcjHb5enMhnnczPEhB80yfwG7lRxYM4IZW2ITd8Ty2NCYnKOHrP/KqfhDJ5WwJ3BfmrXwV8/X9sYXdokT8mxmiSanYfCxI/xHr6AQDeqQuFGpbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336835; c=relaxed/simple;
	bh=c9jO2hWdUJlSLUx5uTBdduEiAizNNZ1TsffLmrKN/MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uviWTPFBWEPAeqZeO5BDez2ki/hr3wf7mI1C7kbbYQv4lP8S+t5ztx0GrQt0TrbOEefclz1vbGhBv85d3z2zCCfIQ3RJcDS/9PiiDt7ug8OIPBzgZO6OmZCQwWylPSFMTnYjpeaF0S8r53Mc239GTdTDCf6mjVW5t+fMVeENY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrF1nEfY; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrF1nEfY"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36da84df7adso16161075ab.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336833; x=1719941633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycfj1Auemq/I5GZc/Z+nI5R8MytVAVEHNO2gV6Yxsy0=;
        b=DrF1nEfYNs6jYM/0NSkWMsi1Fp6Sh/jYzeSc/4E5+etJ4tzIlNB+ZLSeSTb5rkyTds
         xdP6XxaYCrh6+8EEGMFkxM5o8okXyRMaDOe+WfFzPU9cYM4riFmoAqn5j4ijAKrtFQwv
         4FnoMBZWCokXV6/ZR23/mv2/UtAAe0LtJ0J8CSY84wI+uQKJksgQtlKEIXAvL/bsrMtA
         9SE7LwqzIbQZsoP/2CvF228ny10nUCi1MdzsriJSZEWGiyyGjY+JYb45YIEseFVfS6bv
         437ddXI58wHlmJTlV6jY8HnaZDItvus1svjzI12cfFNSpiG80R7cNKwyZxl1ih9XFRKp
         VQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336833; x=1719941633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycfj1Auemq/I5GZc/Z+nI5R8MytVAVEHNO2gV6Yxsy0=;
        b=WW886plBqooVPNL5aWOzKn3NtaamtvDWp7fEXpoRlzzyty+j7G/syFgCaZXOqNt5fl
         /ZztZbBoMe9BdCs3cQmxxK28OKIiE5pAXwxxql3/zK5YCl5u7svgUGb6YPVWg/PYZU60
         RTbX0qZLii4dpW5mG8MrmGtFFGe3i9QQwpIhEO4o73LQBkjwvqmeaA9dDrwekATYBgh7
         6tYUPA97KikuLOTG2i4xqOtYvgcce6EP4jtOgsK4amPUtSU62vF866dCEYN4KzxFlp0d
         Kx9rZ8T4oHxii/TLCl5ghTQAio7OExcjfszdTR2SEsiIQPg1jsHtuwtJTQ9OOl9uCfcn
         xWtw==
X-Forwarded-Encrypted: i=1; AJvYcCX7gmpRhs3e20szR9wdGy2zRUYsNWtMKVjfOJb10Z3yZJD44pFHz56mHMSBspnvaz2vxQ573wmi4LBKXevYC00aCi9i
X-Gm-Message-State: AOJu0YzUy/dkwPDbJDBb1MJB8EwC6r4w9jukkMV3CcQdAO7zXEWCrSvJ
	QYHyjfyZhLxoxQuQk4WGNhiahLhBOUq3FPhUCoMR11+zwJSdEeCwFdRv/3pg+SbHbea/WM9iM/y
	/39aQHkzmbWHzxHEd+Lb7+/UHksE=
X-Google-Smtp-Source: AGHT+IEQZG+neYR6eQMM1hJXidTN7xvwf0/DgQXQd6L6FkWKbzdlB9qxsZubtoupfpCIuJo2vqStdhxXNINLYxbXABs=
X-Received: by 2002:a92:d387:0:b0:375:daa0:ce46 with SMTP id
 e9e14a558f8ab-37639fa0f28mr38623835ab.16.1719336833384; Tue, 25 Jun 2024
 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102439.GA222287@coredump.intra.peff.net> <20240614102909.GE222445@coredump.intra.peff.net>
In-Reply-To: <20240614102909.GE222445@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:33:42 -0700
Message-ID: <CABPp-BHFmNXyV-7S_CcQLqW=J+1fPA6xOVsYGQvY3quusbzD=g@mail.gmail.com>
Subject: Re: [PATCH 05/11] remote: simplify url/pushurl selection
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:32=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
[...]
> There are two spots to pay special attention to here:
>
>   1. in builtin/remote.c's get_url(), we are selecting first based on
>      push_mode and then falling back to "url" when we're in push_mode
>      but no pushurl is defined. The updated code makes that much more
>      clear, compared to the original which had an "else" fall-through.
>
>   2. likewise in that file's set_url(), we _only_ respect push_mode,
>      sine the point is that we are adding to pushurl in that case

s/sine/since/

>      (whether it is empty or not). And thus it does not use our helper
>      function.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/push.c   | 21 ++++-----------
>  builtin/remote.c | 69 ++++++++++++++----------------------------------
>  remote.c         |  5 ++++
>  remote.h         |  1 +
>  4 files changed, 31 insertions(+), 65 deletions(-)
>
[...]

I like the simplifications in this patch; it all looks good to me.
