Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A42BE656
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780824626; cv=pass; b=WgUEIMnJtmuszUJ/teqPHggtw7I6ISOI9W9xxO+a8AEfIr/lOVmgurTQZCWMxMqqmF6XEBKtAjc+Jqa0z7KHLlolo+W2w8fHnITw0zmiIut8YgezEsmxW4WNvp9Cl344DLyUK4Vd5VO4U4KPg1Zpqf53RKt6ylDb8itvdMeGVVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780824626; c=relaxed/simple;
	bh=Cd21Eo0jDKPywi10WMwuAgYlfHjnrfL6RWJuQIaD9sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dhz7B4CNnhom3NHfMJ9qz7v6HkwKTwIwTHXptRDjMkzNk8WAVliq4A1lu8A0k2JP3Y0elrPfF3bp4z/3ky6DISOEyK8V68qu8TrRDFLKznaoHWJ3gj+XkXjr8Llu8JeidURonaBfDfVtBI1vpeirPDTZ5TUdfOMvLdb7pw+yaeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=ETnOKScg; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="ETnOKScg"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7ea16f090b4so43323807b3.2
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 02:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780824624; cv=none;
        d=google.com; s=arc-20240605;
        b=c78DQyM7Grz4bgh7LpjU3UktIaI/DXDw7lrzYVp/XNRR+BnskCqN/Nb8xst4sy3ISu
         pjCGWzTHFVWOsxNddJNYODJaCv2+NULiyiuSGmK4YrfGGuXWkfmY63jRxy5VDKX76a8t
         ivUjrRXg5ra2BXa5BRbrPRIyUEPrBLL2SCyEV8AxGbPVzZzIz2zG9zBCS1HyI/izVUO3
         CVqX+Zjvf6uL6IMkFL67uHYl56fYz1D6y5Yeel3Ml8G9LuFjVOMNo6mdsji2Ze26N67v
         mMe8H24uLSuCt2nsQxC8Ze01S1wGzLKfgsCDqwS9TNY7QR/gQqqOjafXvAv0YP9R4D21
         mf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRIhbsfVSNWx43ABvOeNCZZVtGu2KgdDUPIgljKjwIE=;
        fh=xfsZVwiM/ioGgqvw/pqpaX/VOi8mXsK5PkhWlDUnvuE=;
        b=lIK/qHIzjf0nKg3u/264RxbQuvmyFMEG7+S2OtT/rpxnvkxXd8txmknQSRUmYjRkX1
         j53rUxr7RngMtFOPwhWd47JTM3CUlbvzlKF5GYJWC2+mYOTbC/KvKFvWmhSdi5YT307N
         wTCyNZgCihdnD2mMQkDoqPiuXPXRFHa15fbKzEfZle/KnNMdwksrKyAnxnvEZLD8XnLn
         09+/ifZBYt1PFHTwHaAJ2xprGukEco7EVNJjKuKl4Kxb58Kr2PAGeZEwLdm4JygDolWL
         N+xR0qNrCbhuyaAxuODutYIxVRm8KSxcrCe4U5sy+RMcrlTKwLUIl+7LZJC96kyVmHs6
         5IhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1780824624; x=1781429424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRIhbsfVSNWx43ABvOeNCZZVtGu2KgdDUPIgljKjwIE=;
        b=ETnOKScg2TkXqY5K3CsgLYN/tbzh9gWK0hV7zvmPI6BRn3XmtMOvHLKkn4BLkvdNTO
         XwVjxzgaZcqSc4QU34frJZvhFs0ObC24BhKiBnmlEQxKI6wGRkW1RAVoJvK+dFdTWjSt
         LSq3m7RGpnZllFsZQ1mb2SfcD1ZGANw7/i6JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780824624; x=1781429424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRIhbsfVSNWx43ABvOeNCZZVtGu2KgdDUPIgljKjwIE=;
        b=bWPwQhA94KqrzNI/OefkalGd2TW7OElgzu1zFG9t0bzikc6mByNmGlkQUj/qyXN6dy
         9eFOUfqfVfMdlpmb4MmvZ9aTB5yWDLHfySIA+3O9MAOUOMkLD9L3g8CZRXm4cMRhxwKL
         AUqQbRbhDvw4SbDQ2qYi3YTrRt7KskdseSdNESzoCa2mV46DwcxqVK8d6Jcfrbrb22Nf
         5148DoceLT2BSZ28fM7wcCCglQ3TWQwswin2jWEiM/8vCPccl1fBunX8qOe4ewenMtBR
         buuKStcv3bg+rKR7z0suuGVLSnXtiRyI4+IoYbr39RFfFXP/IE1jtKaVj+WSUbU0RWA+
         crdw==
X-Forwarded-Encrypted: i=1; AFNElJ/wcwxmEmSA2UMFJNYURrxcbQRPkh/WFR///PMsuxxVmTzL/zy3TrUOKDmHFLleTdnXGgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwclpBjCuSFrtJ/0FOjuuKqoNQ58Y1eps8dx8UdjKXwKO4ZZgfF
	8RN/8QkLhn6EhNMHrwsQy1Ufleo7ah5RwQA4O8/qZFBcwwpg5Wz4abEcoDsPmcFDNQeQPJtZqrq
	Z3JdkwTPcXYNrvzt15UMoPNU3z5kH9dSmToeifI1oXg==
X-Gm-Gg: Acq92OE8CtnkW06IkJrX1ayiK8pT44lv2afhmGtr1Tq/0dtiiu8ymBFDc3/5IWWvv0U
	2NI1KxMIS7Bsx5ZGdFlOpD12eKn9AW0XRQcBhUQCkN7KSn32m1etkLon5mwdtY0nOVBJc6lyOKC
	TJp+D6LCnTJXSlH3c5zAj20q9VgAwKoLVX9+paErKstkSe0Mm1uHqekyXQcFBBTBhoHuwukbbop
	sv9Pax7s2p1oxmqlNls2j3TYipe393mp/U5cLPTxMPAIOG5nJBnIcOO1wuwDMVxNaY1jqPPqHdS
	0sgvCrp1phfP6NuIxTbFws0uX8KB
X-Received: by 2002:a05:690c:6902:b0:7cf:d242:d963 with SMTP id
 00721157ae682-7ed0dc9df69mr99105477b3.37.1780824624441; Sun, 07 Jun 2026
 02:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
 <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com> <fe20bde6-9e86-4162-9bbd-af4d058e499e@web.de>
In-Reply-To: <fe20bde6-9e86-4162-9bbd-af4d058e499e@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 7 Jun 2026 11:30:13 +0200
X-Gm-Features: AVVi8CfjULJ2N-xZSxGH0pYaM4LxbEV5lPJZ5ZXgrujL98QlW8sTPRwdkJsHiGA
Message-ID: <CAL71e4NDJtMN+i6E+BwQ=rvM4o8gwuDRUAn5fuQhYnQH_CzCxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jun 2026 at 09:30, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Calling flush_get() later, when we know that we have items and a
> compare function, is cleaner, as we never need it in LIFO mode, and
> is also slightly faster (patch below).

Thanks for the benchmark and the suggestion to move flush_get()
below the LIFO check - that's cleaner since LIFO never sets
get_pending.

One edge case to note: without a second !nr_internal check after
flush_get(), two consecutive get() calls on a single-element queue
will return stale data instead of NULL. I went a step further and
inlined the flush logic directly into get()/peek(), which also
removes the forward declaration.

> Still there's this 1% performance gap to the current code that I
> don't understand.  Do you see it as well?

Yes, I saw a similar trend on my laptop (Core Ultra 7 155U),
but with very high variance - the results were too noisy to be
conclusive even with 20+ runs.
On an idle server (Xeon @ 2.20GHz) with much lower variance, all
three variants (v2 as posted, your patch, and the inlined version)
came out ~1.3% faster than the baseline across 30 interleaved
runs (p < 0.01). So it seems CPU-dependent - possibly branch
prediction or code alignment differences between microarchitectures.

Results from the idle server (30 interleaved runs, paired t-test):

  Variant               Avg       SE  vs baseline           95% CI         =
 p
  -------------- ---------- -------- ------------ ---------------- --------=
--
  baseline          2002.5ms     9.2ms   (baseline)
  v2-posted         1976.6ms     3.2ms      -1.29%    -41 to -11ms     0.00=
19
  v2-rene           1977.7ms     3.1ms      -1.24%    -42 to  -8ms     0.00=
71
  v2-latest         1975.3ms     1.8ms      -1.36%    -46 to  -9ms     0.00=
69

  baseline:  9ac3f193c0 (The 11th batch)
  v2-posted: v2 as sent to the list
  v2-rene:   v2 + your flush_get patch
  v2-latest: v2 + inlined flush (for v3)

Will send a v3 with the inlined flush shortly.

- Kristofer
