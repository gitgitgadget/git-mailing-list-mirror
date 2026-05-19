Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5933F5BE
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179121; cv=pass; b=Q+yKQo+Y94T1qXjaM+U7O/KFPnxoJS8PTPs6gdWCHW21mUcc+LVeQXQJqffcvMVGC0z1QmnwJ4zij0PAkqPaiFRkoCswp0lHFOk9IRfY34HkTywnkJBhebmlpkvNRrPp8IEHL6yLZery7GHapv5hUqmZ2RCB4RJPodkJcRw7Ho0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179121; c=relaxed/simple;
	bh=Gv7EZsUbC5jacIrYIoxkdifcGdhJu8/m7sb65eBp0Vw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3Fa059m7PANUnSiZ7otV0EVlg4I22J1MXI+060xQnfj4lqViSH7GkuisJmJLl7ZWtaLXyESyQL9YFsImRzs1ZwAflCPOjrO6PN1A4hL/K13+VMJNluczQwMo/Z9cke+4Onc75Z++aeNbK+FR08nrnMbSIuZjWNXrcXAjMn2kT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZEp+QFN; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZEp+QFN"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-631ca15d35aso3290903137.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 01:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179119; cv=none;
        d=google.com; s=arc-20240605;
        b=ZNU4Bg1ui9AmUyeoVsc7FRgolS5FGcHCUBLc5KnIPUkNeoVc6+Blqn0PxRNjHsPoYH
         VKjKcLMhMt/Vug5CZIjNtUhUhC19YfQJUEfi+pcqYr6ADsNK5LpysdcyX1BqINEaEiRO
         A15lnCdEVDnZA6wrvxzJbNxmdqY6Vu71ruXZpvgtKh8i/go7XucgWsA6aL4B9Un/Wjcs
         O8u7XtdaVA82XvfCYkjkzHCv4xnazgbNjEdNDOm6rclnOp8lrFfYW4l0Hk+/TX8T+9LK
         +fgfR8k+GbPFV7F1tAM6yjDlvQS2QS6N0QmTBjyOQMb+DB9N+mSYcE85NpAMGhv8kYE7
         UMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gETwVWysTkIEK410sW1UlxrX6yJSuFi68oZcMsCFWjU=;
        fh=9oVxQG69QLxRm60I6HW2eZ8x93sNGxJm9mweoCQapqo=;
        b=GlnN15rdC32X61YjHGWCLyZYU/FVSpWMxO3wG9ajq8/cZK+wEARUJPJHUPfwnR++JD
         pjBd/NeUV4bAPhiyvoJqwJx5DCdacJs8Qqd60QJQMl+F+85cYsIhO3gjKsmxTafTchdE
         i+0tnVRU91B+AablgZ2y/XncgUbhWrFokSyLBu6Hp3VHyJ95r6Nf9DbSn2dI+m2Qr3Dd
         b4El6bMOTJdmtWYzlshjygSBKErQPxz7cOd9w9Bsvl7//A0DpbCKF0vYzY88da2oidhz
         nWbHv7yk6bpl/QrfG6/E1O4m5Bb8zXpALC+MAXSiW2r+wRQAYB42VMWWNCuihEpCqQzp
         ULDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779179119; x=1779783919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gETwVWysTkIEK410sW1UlxrX6yJSuFi68oZcMsCFWjU=;
        b=lZEp+QFNlaqs3QKdNZksjUBbfGjWRb9f1Pr8OmL0pt8O5SZPma830MpG1S7YC+eXPG
         ZGpvXctMKymOt/9Oxg9DB3808dweX17WfaRZpOzdUQCmA/vmrqesCsjSCXlDl5/UYE8Q
         ASX/nr/D+RNCIRzQn0ABvqxO95Sl41u/s4Q0uO+ISqJM3s5M/tZi5+lqiI6uX1WTHbII
         SSSaj/czL2WX9XAj2DrQc+Euan3xVzxmN+EIO2M1ZDpqZlXKxcom44W9yajea1Be5BmR
         nrZTfYP99W1wAdVTYDEG1+2OjzRqJgwO37HN78rBfGt77U4Q8xYRPyoReYzuGf6Y61wu
         FzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179119; x=1779783919;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gETwVWysTkIEK410sW1UlxrX6yJSuFi68oZcMsCFWjU=;
        b=SVQBYwDpLnPZYNOqzH8WNMhXlwxZm7S8c8d8fWdAW5+4zSjPOSAbwVJaSjUjVxL6/m
         z2rjeCKdjwFnWSaZrtBW+xwJkPD8xI+8C6v8ehVKgFnLWoTcoHfTche2+WXvjWSBsoTM
         TBuCglKTOCaLNdBO1R57/yge+vj0gr+idOdWsTG4n3a83WOTPf1O28QGT+DNomRuQnOG
         FXzQT9e5quNV84bIOjPM/Dd6SY6/fRmVzFxAsHNftwbSshBOvL9lEKd8dgMZeoPJR9xq
         ewAQ0SfG6+bTvS5BbUg+qij1SPnDKcoHyIIofcBhgRNokL3cbWfGn4ezey24UONlAz96
         BIIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XR1HfOG3ki8brs57wKpzE2HafL9FeC3iDoDrP5RpMHsFcAwpeBvfplgUcjI1aqKSsQU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCPQ+gpSIoy0ybM17HxTHd9hYRa+M+/qygqThmZe5mqlTwxy5
	EXe6lHnZXSWPApBec7ry3Kf4U/5pYCBn7Z6wnWD/NCHmRcOPcF5nm/na7GhfCF2yBlb3zcrrWQ+
	lFMu87WIyBAX2z8m3eSq6VSsHGlwUlTU=
X-Gm-Gg: Acq92OHFZ/DL5gtxMdKqCJNiCZdzYt+yzemeFEuAT4D9dJ6CXQMDF9WCemKyersZeIK
	70IJ3qyb8JqIro1W2V+vCpHJF9gfxy4WF4Zi0/x3zF0wl+uAg6MQzZQYhdbLFYeTIGU3ZeU6B3I
	nk2hCv5UAmkWUIPY6lPa6cu5b3LvN8mx9ovluHhmHnMVIis4K3fvFef9xv7SF4HC6MsGz1XutID
	S2zE0EJFRQpex4qmdI705jjpYKwO5Y3yddtmx7UhqZxpYNu5q97G8br8hR51k2bwM0VGWwsMG+N
	TjYLTzMhGkEE38a7+EvQyrGQfmRsBCypGpHX2JSbmdbVRUSnK/uloHeb0Oigj+qsBN2FhiTdYvU
	odXOwDA==
X-Received: by 2002:a05:6102:548c:b0:633:9ac8:6bfd with SMTP id
 ada2fe7eead31-638b4c525bdmr8877866137.4.1779179119218; Tue, 19 May 2026
 01:25:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 01:25:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 01:25:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-3-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im> <20260518-pks-setup-wo-the-repository-v2-3-6933c0f1d568@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 01:25:18 -0700
X-Gm-Features: AVHnY4K1Mr3lkLHOKeIk66AKs6DvKjqhnxXiQpdjQa5ykE2RMxL2dKhGvNfCcm8
Message-ID: <CAOLa=ZRus0wTn70xCusFHQ-fvLFHG5f+i3jdKb+j8PhdqtwZZw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] setup: stop using `the_repository` in `is_inside_git_dir()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
Content-Type: multipart/mixed; boundary="00000000000064aea00652276b0f"

--00000000000064aea00652276b0f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> -int is_inside_git_dir(void)
> +int is_inside_git_dir(struct repository *repo)
>  {
> -	if (inside_git_dir < 0)
> -		inside_git_dir = is_inside_dir(repo_get_git_dir(the_repository));
> -	return inside_git_dir;
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret = is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
> +	strbuf_release(&buf);
> +	return ret;
>  }
>

For `is_inside_work_tree()` we also check the return value of
`repo_get_work_tree(repo)`, but here `repo_get_git_dir(repo)` is
directly fed into `is_inside_dir()`. That's because the latter already
BUGs out if the value is not set. Looks good.

[snip]

--00000000000064aea00652276b0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9dadf929c278e9fa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vTUhtMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0h5REFDQ005YkZUcnRaa2RTMlYrcDFJQ1dEZkhMRgpWNnZVa0JTR2FQ
UStLSmxTQVBWYnZxMXFSTWpJNXRibGdEK1drODZ4TXo1SnZRZXBQcjV5Uy9vUXpXV2lwNittCnBF
VmRkakw4dnkrNVRXUTF5SzVuRXRSQnRTUlY5MVg5LzJUSjZ0WUdMRkp4Y2tXQ3NGUkRNVFJIUklj
dnZ0Vm8KbWlTYjRIOGtLWXAydk5IcWdhK1FFek9POTFyQU5RNTFuZTd3SXlxNCtZdnVXMWpJZTVh
RDJIS3cyS0E4NTRjTQo0NUIrZzJ5ZVl6VWEveTBrTFFGbnFSR3NIUVJTUlZ3L0g3TDZaaFNSdWI1
aXFOQmFvL01OcGJwMUVpbUQ2RE9CCit3dU0vbzBTM0FxbjVVRjAyT1NKNENlbjA0TFVMdjY2LzNu
L1N2QXdtd1pxVXFhdWVCWkdQdEkweXgyTEJlN2wKUW1xejY4ajJlMWw3a2tncTJCazhrT3BpZjN1
dmxmeGdySXd2T2tDQzkwRkpFN0FSRjNIK0N3UTRoRVZxQWxVcQo4bHRhRkx6ZjBTVk5ONTFCRzB3
VFVXVFVrTVNOeTZOZnh5aGJ4WGxjMHB3VVFrWnJhcFBWVTFEbHdneUlvczhFCkl2bnJkdGhnaXdk
LzkrZUNrZlhPcUJVdEtnL2FyS0pacW9PeEQzZz0KPWNrZnQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000064aea00652276b0f--
