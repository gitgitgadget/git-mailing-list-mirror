Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01D2D9ECB
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838347; cv=pass; b=AeODR/dzJW1WjFHmtZPj/A6rDcdOCsiRDDdD9O4VdPKruCaPs7MOLao+gZdFmN536afT97ZE9/hKOi+0v8aN+49vr4JPxBeU4t63FrJW2jTv0w2OQRFvixHMWLaeHCVD8SZk22b1qzE4dH4HfhMiwOlUAZ7Sze7/0S/2cgCB9Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838347; c=relaxed/simple;
	bh=gZSnA+RXzy9OGCLnoNSeFO7YzIgrd7InNv/OPahjOLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSIGXhr7YrH3Nmwiifj8bE/ow3PqEfiHJXtHOiVGrJxAqDlMxu/rsY5jCU9Fwt88CrDCTjoq1x9+VgdgVGt+AKhgw274EWRzV28KFhVAYdvESSnkvMRQHn+PSw/3udesxnCujmuHvNu0Qyu5P/y406CdNNT1SPAHiNXO8uO+se0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcK1AFua; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcK1AFua"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac768bda6aso7023540a12.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 00:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790838343; cv=none;
        d=google.com; s=arc-20260327;
        b=Aq4jMk6Lu46InVolYYoFEAtva47LX/yUU53Vyf3gQ84x9viMhHGFSfbwv+4fUgrLUk
         6eYJvRW3R+hZooWVwmoGXUfPWhhMFBCEvjKQuwS6mvJTDksIC6SRUfS0xUQJEYiz6vhU
         VB5SQisuze9A743iRuVieAmTYJEa21WG//o7UsTDO5C5GZWBwpgDkPIT9KnSUCVIIjMC
         NKjg7t/og9SSumUxitRtSkX+GrEPsvqhZp6HhyfOCiI7DWK2Xp4TB8ORuYAdQeOWXQP1
         lsDEeNjD0yFAcBc7TVm0a/t+5BvO3CpF3GI1p17Uoc6b6OfN39+1ncbCUeyV6MM+21vF
         6Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=stinmyi5JG9COK3Y92nUTggKV7UHOxIG1OEayExosT0=;
        fh=/TZgpA/UYoXs/S2oTJFHRgqb01eXGVMe+qF6gtAixaA=;
        b=ZTbqnsHz3ueHOsq8h+W6rLZ62fbOlU1tZIBMgxyIGVQlFjvarFUotatEBDip8XSqfO
         XtG37HqSvhQbeJDvHhhgyIEdd6eYg0RE6fAPvV4FJuxqypTbqb0pKDs1bN77xbvtNk2W
         aDIvpmokAOBSu+wWj9fHqSZxNIXIyMN8DE+ovmBNTNqX34bJXc3xxuB+uuJ6GXUoGOYV
         MgKXoYwLB9S/m4FyL5I5wBQbeeMDCPVwrrgLCsVEmkpmbAwxBrEdAuQJvBtBiVS4bq+Y
         v+WJOOzsmg1qsESn6zvaFUYn/nSZPjpadx6P8+59L4lXI1bXgYkCNl+zyF2crmDt0RnQ
         DjdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790838343; x=1791443143; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stinmyi5JG9COK3Y92nUTggKV7UHOxIG1OEayExosT0=;
        b=NcK1AFuaP6dcN8Bep4e7o2aGjDfY7wr2pHrv7FIphMa2/KYbjwW3qaO6k18nlKvOv7
         dsDAG5t2XIfUBkdBtPpvR5lJQ+eQJ8zWipSM+TKpeXVYGCL1vKuIz7Z4AXcWhyp+NcCK
         w3behc7plEjlIBaS9UQEH2DaDWWt/GjXa5GeNm18EAgt/P7WELRzDajgsQGAaGKwFuy0
         ryl7kIh8LT/N5J3hHowgDiWeD4ZRZhbwfL2/Y2ilSLaObpJk8oZK3s7b8gSyyHKseB8Z
         NWnfJlLhBWCSa+uBHa48QDvsauNJTWCtVTnmJFc0t2vANVBCQjXIr2N9iXCvitqTz272
         Ogrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790838343; x=1791443143;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=stinmyi5JG9COK3Y92nUTggKV7UHOxIG1OEayExosT0=;
        b=1l6O5R85aPOzSPS9n1h+n3Uj8Kz1EBmPM0TvvLLO2ulqgceGhbOe52WzGaju1ynFPq
         OCUMjQ5Av2rwUvW+TasnUF+o32u1oVjRDt1C3WrQesn8C9WVnTs2EzCErb1SBI/JItOE
         BPZ9OqAPq8ADywwirafzaHX8GhivXRMKLNcWchKpMjEApDLHW8nm7cGtPnrR+oKQbAA1
         3eR8d9CV6N8xc4SYLuJnurVoQGatfOyXDjzVXC1RCFOIWN+hBCn6IMddotVV+Adas9zS
         eqPToxW2hgwDyDPwq2MnX5I2duFn8EzK1vhKnmQFP1vaKH9FcN/MjosrRNYePmyBrJX0
         67ow==
X-Forwarded-Encrypted: i=1; AKwUvBxyEOxJ9b6fC54PWPQTXeEPCceqGchEI/zvvh4rGVPK/hhNaKGCOX3v7XzdL9JyKsFj3AI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLD05XigptFQY1s9Cqp/U1lFhZrR42bjjDSSqE55ejt7Xo1CYw/
	GjdTK8OAcq5PMkSozMwsxku1Zp96luVpHj6cPQrR3FlUAF3nhV0rTrZ75SqfpWMO+Xp87nbZ7Jo
	SynbyQ+fSusTa1NdsjKjEY6kTw8bBDKc=
X-Gm-Gg: AYBFou0y3x5VFRhtoWKOD2nkw6hP5hUyz0QIuhBtnVVd/zeB4RA0GYYrekYPKE0wjvE
	Xb8Eu4yTYY+3hJ/XDV0f0P3+mgbnPWUBzoLzIXKbV5g/1ogGJs2Hlpoq2+UnUg97+kj2uoS0Qyu
	wf+lIgEifku9Rra/ZDbKsEYKgkzQOjqFxjbXr2frQn4LBS38yaXkURZwW0T1Ls4UJfnQuw0+bFq
	H72Ppeu6SxPGV/Jz4XqQBQ+kUcE959vXUH154rzVY2wDLIbfTCdHzAxG5j4tBv+R7aNvZERaFAY
	CRHbg4RTTHMeFfRCvyWY54YyYTd9IzbqEgyy8ZTBBoUODBhg7lnCOuA=
X-Received: by 2002:a05:6402:a28f:20b0:6ac:9a44:d412 with SMTP id
 4fb4d7f45d1cf-6ae198f3b62mr2115657a12.7.1790838342762; Thu, 01 Oct 2026
 00:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com> <xmqq7bk28i88.fsf@gitster.g>
In-Reply-To: <xmqq7bk28i88.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 1 Oct 2026 09:05:06 +0200
X-Gm-Features: AclHuK8H_Kg2V20pHgEdNSe5yQ-4SV522MeguZkOTuiOdOGGJlbtPoaJNjjjAFE
Message-ID: <CAHwyqnV+63w6DcPm5ea0n8inqG_v4ujR2CiAbZr-h5SdZJsHOg@mail.gmail.com>
Subject: Re: [PATCH] object-name: accept @{p} as short for @{push}
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Typing "git log @{p}.." fails with "unknown revision", even though
> > "@{u}" works as the short form of "@{upstream}". Users who reach for
> > the one letter spelling of the push destination by analogy get an
> > error.
>
> That's a weak justification.  The same argument may lead to a
> different conclusion, i.e., we should remove @{u}, for example ;-)
>
> As I wrote in my response to Ben Knoble, I dug the mailing list
> history, and I think it is a good thing to record in the log message
> of this change what we can learn from the history.  Things that you
> should describe include
>
>  - @{upstream} had @{u} from the beginning
>  - @{push} did not
>  - the reason we do not have corresponding @{p} is not because
>    somebody gave a concrete reason why we shouldn't while the
>    feature was being added.
>
> The last one is, as Ben brought up, a very good thing to mention, as
> we can justify this change with "just for symmetry, add missing @{p}".

Thanks, I'll take a look!


Harald
