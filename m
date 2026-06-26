Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82736F915
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493433; cv=pass; b=NqnmDDJfCwoUELxqBYGWs577YuBnM1hQ7an6Hjc8v6n7ias9idhirBNG9mxqbMsWpkxEFUle27nbgqb5JrM/OAEqC3eIoKnnckQ5+R4WKPyOWf8YxYwhPC4H8v259jOY9wa5anqfEDpSwlp3FmNNYmzFGzWwGsBIvHpW9ZCqMOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493433; c=relaxed/simple;
	bh=MT/NhyBaxa68fsEq6L1k0Z2YPluP0kkeWxVIh27U1B0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCR7rTYphO/FtqYsITsIBMEX0ocwwNb/WuqYdPLqOL3q64Kt4CB6FiKfUv0tMA859ypr6QHoVAB8jzVgmjPxT4zjscbvai1RSehzEi5dx1IjzlcCyzTMggLwHT1fvxsN4dsG4kj2bSd8CpePwzr3O55a0mpoLyy4NO9rm6S6ZP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGvjMyjr; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGvjMyjr"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-966e7380109so846228241.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 10:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782493432; cv=none;
        d=google.com; s=arc-20260327;
        b=E8RB8EBi/4yg8vDnRAKUZUjJhjvpL7M4f9v4sVr8jW3so/sXMnneLPuMPsQWwXdE7G
         i/5rcvA1AfT/0wVJ6L6fPP5EpPk6dMBk9X2w6nv1njxqhSrEY508bLE//JPwAQHM6j59
         EbiCoavLAlTq3eq0CYufHRExpJ/2YEmTL6HBYGeXHVdRII8i35Y3Yj7y+hYJcDY9TdT9
         flTXjPntH6iX+CM72HQYQxQ194dt1IQUlZE8H4ksLV+AcjEHbZOFfldW/X1gLxp9yv5P
         zHmRaKndnUVtSHNIifBLitgqhX1DAxrgXxLwVJ8hMdkKTUc19HLX5przLA50yoiALfmS
         KsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LZJaWBRTY8jx/2hqxdPo7vfsfHK1eSTfygDDTC2emz4=;
        fh=GUh9c/mJjbOgqmK38X6ItxXCmynk2ZoR6178kkEARFA=;
        b=eX9EWsxOPluo2Dk71o4/zq8TFiclMtjlriEE9iNxRtj8bXtQVlHDlUjxXhN/fdW1Ea
         Zo/WTJyHinJ01W4rOvxZ6bzvvnxiLocZI502as5a2iw189Y4DhZOKh2iByt98QuekH2A
         ko3UuDgmlMzhquLbaQzJPE7w9O7fVBd6bKppURKxCqJW0DgMn5I2shLQ4qWof1HM2KYK
         t/hEsirIfZV39jkdrdxnWvg8fmsLNZdpCd4pFpgonfl9sUi6tlgqyGxUGeaxKVoJ3Bx3
         qEecRfQgccR0LgImszDCJm/biSTGD9SDn/J2YMwY1c4M1E/C1LSG9mUEvqZHNw3x7qdT
         iJbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782493432; x=1783098232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZJaWBRTY8jx/2hqxdPo7vfsfHK1eSTfygDDTC2emz4=;
        b=HGvjMyjrpF8NmigzOugq5AJ8ftzFXHnneJA3UQ7y0pQCtkJyOkMHt4gKYHTq7wwN6p
         51wyAnAe+VI3RvAVZ2/2/J8dc7NaTFHVM8ZqbWTbpET6ZCUJBfiF74Tu1W02qO7/2DTP
         /+j2i3UTPBkSfUUHkVWjpV/TwhzhqV9GSIJdwKsBXszulAG4bxIDpm0sA8RIs15IPqeD
         tf9rmZiIWRIEMvhncIErHMyE4CXiUFj2QbehLEPY9Ahm+Kbu8/dgjbNBfDEaJ/fds6IV
         5uvLkhq0TB0O66Wa1F/eTvibp4IvsjrHbIriELePGwBlMCNP1fGnwccADJKBpbbXA875
         iI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782493432; x=1783098232;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZJaWBRTY8jx/2hqxdPo7vfsfHK1eSTfygDDTC2emz4=;
        b=S7derkRRUTgJ5W4X9xGzkUlfUfvVix9fS/2niMLj2oTtkYwmeb3k7TX4gK0K3RpJFA
         mz8sEGDdGWR9aXCmtPXYJjGj5jnCig/MWHHYd4ySsd8qG+C7Rir9whi50EfEDMLyAh6o
         bQh9LQ5Y1cyXh0uwJVr77dbJb5eyvFuLVK6O0WmLgZPU7LL7KdI1J/ZmT2mQ9BRVYEyw
         /Q1k5/zli2hIolg122NgkpxpneXEs/kxbGNg/t63lfbQNjYDYu52NUrcs630JeLyb/2y
         e5rnt5vPy3gDJ6AT+eTpSAWj8bJp6DraCRK49KEMxxD3zV3L9ULCpvPQscKe/55572RZ
         85Dw==
X-Forwarded-Encrypted: i=1; AHgh+RpzHbSbHG099LFLoXNKV/sGc5H1jUYlR1Qa0+N0U39DE+bXleyyKmk869gu2hBZ61n/MIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8yMZxN7SXLy6EpZ/YxlLRz2Ho1WswW1bt2cuTkwIpFnfyuHrn
	e1NUyV72XDP32fj/fdQqyGjyEUGYN/DqoECnTw4FhOIXU2toZRfuca/VLjSjT8QQ8xR+dr6g7MT
	syetTXUwTjCt5Zzg/FAFZOF5P3Mzn/d0=
X-Gm-Gg: AfdE7ckDnDEOgqJrQvEJ7Kka8aq9UO3D1P9H3x3e3E2I6n4ES7SzGSg7QJGIzFU8MtT
	gEh+eQx8mg78mVx8qCSzHl+9lPaRKb43v0sf8xpv4SuGRoSCwZ0HGE16K3RgZL3FnzS69+WcJjd
	s8y/+AMkDUuj6ipX2IeUR/hijyyCp0HhIYhQkA662BmfeRKa8XenKt982856fxV5yfWXRB9PFku
	GcmYv7YwhKf7395eieF5Ifipalss9p7YNrzbZRvzC6fut+W+GYJwg8NeDARRm+99A+owJAlcZIu
	69Hqp4JQlywNrVODBULleZQH8rU2gTcj9IrbBR3uVlLh9xupQAC+g6lxYvzE2yI=
X-Received: by 2002:a05:6102:6897:b0:631:ff40:22b2 with SMTP id
 ada2fe7eead31-73433e3dc7emr4103694137.2.1782493431677; Fri, 26 Jun 2026
 10:03:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 10:03:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 10:03:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-7-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-7-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 10:03:49 -0700
X-Gm-Features: AVVi8CfJjydvZr4JxUXXmIBVezNJjZK15E3qK_-J9iz76Rl7XrBh3HL0EsUe4sY
Message-ID: <CAOLa=ZTdcg47nmZs2t1FvyOgG9S4Ap3RaK+C0Dhku6cG+wj_Kw@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 07/13] connect: refactor packet writing
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="000000000000cf776506552b17e8"

--000000000000cf776506552b17e8
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

The subject is bit too generic no? Maybe we can talk about the function?
Perhaps:

    connect: make `write_fetch_command_and_capabilities()` more generic

> Refactor `write_fetch_command_and_capabilities()`, enabling it to serve
> both fetch and additional commands.
>
> In this context, "command" refers to the "operations" supported by
> Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
> subcommand (e.g., git-fetch(1)) or a server-side operation like
> "object-info" as implemented in commit a2ba162
> (object-info: support for retrieving object info, 2021-04-20).
>
> Refactor the function signature to accept a command instead of the
> hardcoded "fetch".

[snip]

--000000000000cf776506552b17e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d6a21c77cd1884ba_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vK3NQTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3hxREFDQWxaemZoeWxQWTVHeTdpcFVXb3ByUmZVbgpvSTgrZmxxbmxq
bVlDa2hXVDR3M0xabXB2TzBIenNQQ3djRlNRckhBVEQwcDg3RjJGdDNhN01rYXY4OHovS1BiCjh1
VlFabXBVWlFPaXAvSHM3Nm1rRnRvaGhJWm92K2hMZGVNVDBLT2o1aEFnOUM2RDYzT0E3ME9XMnNl
RFE4SUwKNE9tSHY5aXpsWndBeHRiajcybWxXK2l6N01Cd09YeWZwNitBTzc4dHd0V3h2NDBVSGNr
M0JPemFpZXowcG9XbQo2WjY1Ti9KZk5rcmdtaGh6ek96U0pTNC9VWjEwOXNQeDZ0VWxndHA2dElj
d1FiNjc1VTRlV1hacVU2QWxscmd3CkVvNmZ4TDE0MDhJNmxYNUx5NkdkTXpxMm50R29lQ29HNks3
ZVp1VkxWdTU3V2dxMjhJeWlXZk96OVVBTWV0ZHQKU09lOGJFeE1VYlhuditmeXl2WmFoUE5ZbjZL
YkcrdnErWm9BRFV5elBneDZIQWZYUTVTU2tqUkhyWXZTTEl5YgptWlBCWjkrWXVCSU1QTWNBWnA4
UFo1OFd1Qm9VY1R4TkRISG83bXhYbUIvRlo3ZjI3UGpSQVl2Qlg4N0VUSW85CldWTzdPZ1NKTmdq
dWNEakY2L3lvcFdwdVY0TmZ4V1BZWTVXMzhkND0KPVQzVUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cf776506552b17e8--
