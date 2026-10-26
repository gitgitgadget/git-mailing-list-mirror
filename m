Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793009008;
	b=wRKso/zm6fTa2HgA/YbA08feekLiGgIvnzzvjjDYDG52JeaPVXA9xvDYc/BMEwiO5BHX
	 6T6t0XfwXSwGMQGyjYNQyrw9St0p7Uf0z+9knin9Boe2opQNIbEupuBH8iI5DLGXv1SuD
	 5bJI5EqJScx4IMAplhOE2rJWCYUM19/+JzuNtoGiQSgxvNtohLsUHN//OJRAy97P90j1z
	 xG36KzcBv6HtQ8EMsL29pYxWcPwLR90Dq8Q1FSnkamWh6KOSSfYhtSBWFZyJvwnftmE8A
	 w40sW4CeeNP6gRNySMfDZAdkofKq0e+VmQI5hpVoZKA96iw37Up39FFYdz3OlE0enOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=A/jeKJGuSdIdZnGB1UtjKaDmplc6H+swTeB1fG9iJ50=;
	b=T3lihlfiU3rwq/jgTes77j+f7eMvfovHkVyyDH0BflOvDAlck+sJRwIBp02DbatRCwoY
	 QDpFpzJcATz5EqUQiUWvuYVCC8dSTr+zxkJ0WT8SVilwBOeTRPe4R+IvaVvO9XU/9iPLY
	 pEaT66OQqrtDnLt9RdhGQDIbbs/rCDL7FRN4FRACBqvr1v/fxFAkrM1A13vs9WmYRpWfw
	 a2OQfhTQRvcGwpmKqsSKR8Xk7rSgGyHyVvssIlbdBb12C3K3E6A6hDT1R5CFlozJz3fSc
	 fQCIqswfIGxC7iuE8rwDOR8Nhq3qbCI3PxNhyFXJ6PXudyQLgvJX16m51VhzmUJsz/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Wb8z/zn7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DE606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 314DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wb8z/zn7
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso3618056a12.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793009006; cv=none;
        d=google.com; s=arc-20260327;
        b=nVz9Q0twe5XMWoX3Jt0xo+a5qDc4dbvvUzwJc6Kvh7leVz4LAFoWheOCTlvHa39RY/
         MKCL5clkqvKaHHWwrIGESxGKJkhM1jD2iO74TXA6EFXRgDsMZcg5gl4nJ2MhNE1gC3cV
         e4DSTIbG3/P58aiEVOlQjlV3JspcIVCLQqwDrf/+HchmP8+4QezWf7cgxMne35C3JbdN
         iVj9fxQFTqB44ImEmk0N1pwRST5o4oev26pZHLn2TjDB5MhLYmpbdOWx2xkty7PE8FTP
         NJOGE0uruh2l8C4gQyrWHTHrVVkYBoqQiPP0VnyTE30OfV7E1Zzm56AS0ncCFTHdVcXO
         uLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A/jeKJGuSdIdZnGB1UtjKaDmplc6H+swTeB1fG9iJ50=;
        fh=fgPXkrJSFe5Cm9e8GBQUqIjUXgK411EA4FLhClZuKLM=;
        b=miG2nXF+DNGalefefsSjs1qQPP0c7s1A/0XbK9NEX1tQWjgmcCE3D+2tquXu4lEemr
         OohYnC8IO+Liz1E3Q5VUtkgGHtHuJdqqzW8zXb6D9h+KWYWzjLYHN2iiat3JbMZfYGfn
         2hs9Nrj7wUFnNARzgGHowizG26d3K1OJq94zLdiH9IjO5iDSCVDaJFtiqbWNabtXYVt/
         e5YueDGR6Y5rTV7lcIhcLlutxg0AOEQDAv29FFd23/wz2/bhjYXRkIqPdlqsisbiw9n1
         un3oz8COPyc5mVK/UNffLKj0BBbGYcNgJQpWkdMaPTrrqMicorTYmlLkE/dA7GJApQv5
         PpWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009006; x=1793613806; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/jeKJGuSdIdZnGB1UtjKaDmplc6H+swTeB1fG9iJ50=;
        b=Wb8z/zn72rxoCbGKVXKr7N0zTdhix10w+a8VAjeiHir9FJJeq2NL4pz8JZ3kxick1k
         6yKCgS8WT86pnTARkAiNVqGNkn//V5JMlDligc9+0w5hGAUvbwLUcZagALYxMal5r1Wm
         nVvCz48MeJyMaNjgbu3Cn5SJ1WTrAbUZOQEl8KGy9YVO/7+HS5KMhNk01YHXXQ9cd0cq
         0zDfLRiPt8JF6IECMScXr4tPtx0LromK7v3iFlIbHu/MhJL59QKTCM8knjrl+uu/zA6M
         CvwlpcQ5n1/1YMyDSGzl8r2Sv6/Q1JveuRabZXnLSAotgtqW3rPldZQS0NdDbEXKwrM0
         u9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009006; x=1793613806;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A/jeKJGuSdIdZnGB1UtjKaDmplc6H+swTeB1fG9iJ50=;
        b=vb6Cmwps/TjYl/gFbavW2UZ1USFWN6s2ei8r59beAEHHmzJjNdlLvm36J3mH2KHoNp
         6T6tZzV293HmNkhVJ1jhuG4q7zL9UwBZKsDVlNMFsdM9k4BAz9NLv7tOO7ENYPH3SVq+
         BlvgiA8uRceIL+6nzIyxprkZxHMVLwNZhxkZXOrXjsTdzbMEVdLxnsMNdA1viH8tTlKI
         1NVcaSvaWMZ8i0xw+Z1Oi+ezj8zosjVPfpxpaLuPyjgWWx+7Hf0ZJ5BF6tWr5EYrpCrk
         IAH8uYYfZtu0VMyhCd3bgeIBV4HPhcC2BEMCAHq9D/3DAhMKuWuzS8RBIragEhNloW18
         AUYw==
X-Forwarded-Encrypted: i=1; AKwUvBwOzL+UzbBIv5YNdl5TGQ5j0Fupe+mKayYKnCYOGBq1hAjDLIhPzu1zRb0s/o6luFb13fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+xziicnsyv4ro928syuGkPEljwF9fj7HNNKWHOthg9vNxWD9c
	8Sb0x5C9taGmAXP4mJBcArOuiIvrj4GVR2d32sNjeWhDQwl6GRf+fjsKxnyrZ2W3D+JiLCkuH6J
	T05fBkH3kEHbCefEVOgjsYnoHRNVRsvE=
X-Gm-Gg: AYBFou3G3gf8+j8pMYCQUDyBG6MgE8lEVtpklYESAPFgbmg7k2pclcsl2dHohJevErI
	uroniY/RL/enWV0Gc8JBM4Odz3Lx7Lk9aMxtKs6QRN4RuuBmQYLeYUW2/ecUgXw8bWTDEDfZWHm
	Vu2OXI/0b2bm+/cKTrvdmFj/2rkQX5ZGvHyiFk0lcvgmZR7zg6MJe0GncnTJuCCIRJP4SdhoKEN
	SyziypF3YHWXIKOkCRGi9d4Xl7fSFpa1wx2nMp6aFxmHCWeYxtJd5TJg/8hWCU1UoqxxTazYoGj
	6Zi6EPYV1AVwiKMXg5Y3qEa4Axgn41ouOTYuOqyBHqts4Q8FHhnd74lerBqtzDY57bNlOOLBKC7
	dfip8RXpCp8tqa8ZX66Y0u7uKuWr7Pw6/HoX2Ury6X84ipsWZuh+ORTdFI7rD4lMpYN3TQw==
X-Received: by 2002:aa7:d78d:0:b0:6b2:e2:d965 with SMTP id 4fb4d7f45d1cf-6b44300edbcmr5546544a12.32.1793009006274;
 Mon, 26 Oct 2026 03:03:26 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com> <213c4950e053441ad81a0d5f6569e7a2ea63e25c.1792652185.git.gitgitgadget@gmail.com>
 <at8gelQLS3vuidF4@pks.im>
In-Reply-To: <at8gelQLS3vuidF4@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 12:02:49 +0200
X-Gm-Features: AclHuK_PLYshmnC7qWX4bCCQqyyvwe6vgMZT-n-pgALu6jHZd6VxM4Tqp_qpwZo
Message-ID: <CAHwyqnX=pnrhATbZ7UmkYHabFZ0oKyK45Mfp+Zh+2U=gj2Ei9A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] imap-send: check git send-email copies like other messages
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The copy that git send-email --imap-sent-folder pipes to imap-send
> > starts with a "From git-send-email" line. 04133f5bc4 (send-email: add
> > ability to send a copy of sent emails to an IMAP folder, 2025-08-12)
> > made imap-send count such a message when it has From and To headers,
> > without looking for Date and Subject. Without that special case the
> > copy would not be counted at all, because git send-email writes
> > Subject before Date.
> >
> > Now that the headers are accepted in any order, the special case is no
> > longer needed. The copy carries the same headers git send-email sends
> > over SMTP, which always include From, Subject and Date, so it passes
> > the check for other messages. A To header is no longer required, the
> > same as for any other message.
>
> You argue from the perspective of git-send-email(1) generating the mbox.
> But what if somebody writes an mbox via a different script that doesn't
> write a Date or Subject line? Based on RFC 5322, the Date header is
> mandatory, so I think it's safe to assume it always exists. But the
> Subject header is only specified as "SHOULD exist".
>
> Now we probably don't care about such edge cases, so tightening the
> rules is likely going to be fine. But I don't think that's sufficiently
> explained.

Thanks, very valuable to have another set of eyes here!


Harald
