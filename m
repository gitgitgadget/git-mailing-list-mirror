Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5D3ECBD9
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069182; cv=pass; b=Fe+uwNZzH46sX2B1yNNRguZESs+QTHsXMFA/0yY/iwhrzqNBlpzozYCy8IfqYjW/Meg5pUeeu1jTfTN3BNKuP7JCLtkonWgd1gfIqWGx7VGhAfJ+2s3ipQ4t1CtL4vIFB3wd4Wr6v5hSKboTWDIv4r6Qvr52EeqBJgyCncAK4gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069182; c=relaxed/simple;
	bh=0JQH9jyYQkM4NrTKqW0wCdo1CJ4uyxng7QA3huCrgPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml+QATywd8zuSb5aHFSY5AYmgRsSQEe0BLtX11DWVWzomjWdifdvmLGBYOtK+KP8IYtjEn0/WY3SGNqPTdLPZjZu5AF+p9MhroQo/7QABJTfApO/HS+m+Hj5l+xLTUso66aUSO2fmzpvvg9ZwFHtzDIO5q+etJ6Y0G229hrZSsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEZBhjKm; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEZBhjKm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso55329285ad.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784069177; cv=none;
        d=google.com; s=arc-20260327;
        b=X6I+Su/OWHTQvomet7ywciZtuAJYp2TxEy6ear2Ym20MaL+9vu1JoFmLhxLZcvfXrN
         Y0y2a63njUSwm6FKqvXTEeSMp27iGalH72s5sl/qtLFq2fDTEHuAurGTYJV+pmg1tXXk
         W+DnlWu200Ws8mUtShyJOXXrRgao7IR0ghXgKRVsPtzK33G0gvNfZHTQZ0iXzUQ0Mtyo
         FIfJKuABZR5gYRY2ctoB5gqqAJqv6bsiI67ItM3XmRF8mv77tmH/rkVzHQhANKqO1ezA
         ZNv+V626tSh+qTtLhFwr1AL3CAx+HKypevsHFBH/x9UrXByHMt+YKkLMT5E0QxHRBJ6X
         LBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3lb8F5jOhD9yb35jC/AB/iPvZ6QwsxmPH1zPEdle4o=;
        fh=tCUyJqOLakgPw8A8dLZhrj1ujr6d590JWTTwBSeSkfY=;
        b=NrZW1S3sNrJyGvYtaIwqI7PRAQ4hIs/wem0Vs/WkjWWjOhNwzjJQBgC+isheFC/PEF
         NMO+FJ9QkldT2QtAC29y0QlreOxwVV+t5T0ZE3Yf6aFsP9WLBEh78Vb42DdEKCeLHFKo
         Tqy5Z3ROn9v2L/RSZS1uJM7+wAHTw6taB3UEclArTSFXub7Lrsw/h/G5fxeXOoLhiyoz
         xSwMMMboL4QvkCj7nuAAZmKRgg+0G0o8j1TQpORnTS9WwwtTsJtvB4hJRMx/XBR4PCAB
         bWLjT5yUVvzsccObzGf/7BrFDyvKLSTR5Wjvs1/hz2cxX7Sjjq6LCVWe0kzSvhU09/pj
         0UMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069177; x=1784673977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3lb8F5jOhD9yb35jC/AB/iPvZ6QwsxmPH1zPEdle4o=;
        b=cEZBhjKmy/2b5SY4wAWvYYyDnY8X2hIWhJwguPbaaCenccFfyC0VE7bWeqAqUVpD9z
         WP8BiDY/2ZGbI1USpVVnijX+06qxljDpk3ViKQv2hvlcqn8NS2xw1wK22Yl5/bcPp2pK
         EgHf/lWvH6whYs/YJxCnPt/bhafsV5criORU39kMLLcn7ucXr5BSkpw+EFp+IWoFzfx2
         umZrdXLDXHQr1nY4z8KQay5kAzxvcAO8Y2L/wDViowD/tyEsbCpQrExiUhyex9pC3eQE
         BhD8fkWq3Rxi9PCYY1pEIjYvDorDKA+wGv+gaor74GpQ3Mii/JDGyM893g0ZUSXYacdo
         ipNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069177; x=1784673977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3lb8F5jOhD9yb35jC/AB/iPvZ6QwsxmPH1zPEdle4o=;
        b=HELQ4cUeKo6nR+M+FanReokgmUCxC86aaiMeF83asye4OdCci3vznLw8oTHERY/9YP
         +c607y7IVlZDAgDO0sQ3Wm+MsBo9OenZJYszkziQGExIBVlSOJIAFOk5RCyhnc+2xqmq
         xrgAa+PGhK8yGTYB64YS9SWLuX66mnwyD48IQtYPL7ArNO49emiyJ0L57HTs9zRH3bh/
         1uRKrwPFY0aifS7+jJuNWbgbutd5uqSTtK3exi4U+20c/lETZFA+29jFwMjUHGAMe8DC
         ApeyBeZoEW07SkVovuPZMHweTgK3opvhSJrq/TG/lIxp2d0rVAItSEBMjf1SaYTr95G6
         RY9g==
X-Forwarded-Encrypted: i=1; AHgh+RpCftZnK0T1XewFLxl4UoZAEufhXhd1igL5MiXjm0xWj4n7JDrTIzx7vCMDQBYMsPw88rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEk7MdPMArJSSshuJz9gQRKbvhXMldmEtvsN/Nvu8inhridA0+
	mz4AxK0dMHhujxYDXEUscMC+Loav403v07LjWQEXWuB2G22R8MRZlzNgUAzqJ7icFo9idBYqs3R
	VVZMt2WzZLT9348WVzX7tdc+qrrp66nM=
X-Gm-Gg: AfdE7cn8jDmIXRNtjmSlP5HNL0y3X17zt+ejDU1Gl8fKyOl8T/vPYo92PDX5f3NbPwf
	MY7Zt+4IEffhssMrRVfx7jRXiXOJ3rRS3Dwi04n9Qn7NIvUDkkXMU/VbFr92ZZelyQSZFwm5CRW
	2NMEXOeWUeszMCq9KBWfKTkKOyP1HIIrxaDa9d4lbdhhAxLgC5Sdj6XK5tiGgGoygb1QubJABup
	H7PDkUjmpaKTR+5Co8szzNYz8AGlwqSGqdT8ieHuMs+K7JmLrVx5Z3HDkFXlTXUq7a6OPnGZtF7
	/qjQNDSPqrhj1JTDsftSb6QqxlDPOppuSgLOdbrYyOQmtLyNyAQZTj7e6WqHjLft7BD/UkDObDU
	MGAAd/RgcguK70JU4smPEi37fLabgEYJZh92lvGvMjCTBwDM=
X-Received: by 2002:a17:902:f708:b0:2cc:f7c6:8320 with SMTP id
 d9443c01a7336-2cf03d80349mr3097545ad.46.1784069176994; Tue, 14 Jul 2026
 15:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711192650.2417665-1-gitster@pobox.com> <20260711192650.2417665-2-gitster@pobox.com>
 <CAC2QwmL05MbVS=jtk7ARj6jJUT461Ws7BcYqUAUrywvDDXjJqg@mail.gmail.com>
 <xmqqcxwr3g7r.fsf@gitster.g> <alTy306FaTAe2E8w@wyuan.org>
In-Reply-To: <alTy306FaTAe2E8w@wyuan.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 14 Jul 2026 18:46:05 -0400
X-Gm-Features: AUfX_mxHAgqUPuAD4pIsfRstCj7EjiyVMnUBSMqaFGeavXLG9UWU13AMJoYBySk
Message-ID: <CALnO6CD8HFWaeN-4Gccopy0nw601cMyak_LSXfTsAa8xwOjKpQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
To: Weijie Yuan <wy@wyuan.org>
Cc: Junio C Hamano <gitster@pobox.com>, Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:42=E2=80=AFAM Weijie Yuan <wy@wyuan.org> wrote:
>
[snip]
> I think this might confuse readers. Now you place these points in
> parallel:
>
>  1. Title
>  2. Body
>  3. Observation (The Status Quo)
>  4. Solution Design (The Approach)
>  5. Implementation (The Execution)

Without commenting on "confuse," I find this style of heading

    Thing (The Other Thing)

needlessly suggests an LLM's involvement with the text. That by itself
is not grounds for my objection; instead, I'll note that often the
parenthetical restates the original header in some way. That makes it
redundant. (In some cases in the wild I have seen examples where the 2
were not synonymous, which _is_ confusing :)


> But acatually you mean:
>
> 1. Title
> 2. Body
>    The body typically follows three parts:
>    a. Observation
>    b. Solution Design
>    c. Implementation
>
> But I haven't written much about adoc, so I don't know its syntax and
> how to write it.

This is nice. If I had to suggest anything further, it would be "don't
be afraid of long headings":

1. Title: Summarize the change
2. Body: Describe [Justify?] the change
    a. Observe the status quo
    b. Explain your approach [solution/design/etc.]
    c. Command the code to change [or: Describe the implementation/executio=
n]

?

--=20
D. Ben Knoble
