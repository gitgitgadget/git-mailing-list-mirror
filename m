Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C333B6DA
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734276; cv=pass; b=EdbRDyCKySgrBkvdvz0RCkeMaGI9FTKYtwtn5uXJPXBVqcInua1DuDCxAn3hVxnP9cbxFBmXkNP3M26X475qaLUGGwBBKlJsj/3vshgCqFO2gYvKS31+NI5zL+1ORIjk/JMH/cemn8dbHXYcOZgCPqUasro4TcZjVodyegeSFDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734276; c=relaxed/simple;
	bh=jkc0KpQZ06IQFqvfo5weLiE6jD0FlneInSQgr76gC6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JONMkUK9W29bK/ws+63PIHUATcrv1wPWYgZY+TMbuXk9nWAlsPfd/2PY2ShA3+xEZx1ICQOVSyOiItixU424aDGCxOLJUZKQaWFfa96IXs9ZMx1ga9HsQZZBF0LFKFeY7jv1CFmd3jrtzgsTYGwUMFllyhaKj8WoCfJT1IQ2HkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/DpfXKe; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/DpfXKe"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec423a5265so33606966b.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 15:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781734274; cv=none;
        d=google.com; s=arc-20240605;
        b=FQRMd+hiI3AilC0t2oZMjtcwv2qQ5m3DfsFREQ18QAOiDJ+PE9BT6Qo8IgWDtvZjI1
         6m9o8ZTdj+VeLcGL1qqQ6KHyDbRpAlyhe65K72RQx0AcL6Sbfn75YzQKq2IKV52XHDWY
         6Xj+xSUUIp3o7HjLns3ArF3Z6lD4LnB0drKO45/h9nxg7Ckb877Yos3KT+9dFEy+roPS
         Avt2cpgW08OFaiemNk6O1Uk+0iqAZeqbQY6oFUrBD29xznGfM83ZNT5T0WFJSn4bOH/z
         8KrQ3FPpUhdAyxbt7BRrkmMv3oHgUHVJ1XJVoIq2NFkSkTg2np1ejblCJR3cEXUQmmyH
         KIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jkc0KpQZ06IQFqvfo5weLiE6jD0FlneInSQgr76gC6k=;
        fh=S4tTSywxdxLfdk27UINuh3gy8Mj9s91UUFskeSJWWBA=;
        b=CiPa2D2pTfEZxa4lUrhDGZFR2iqUyx83wpNXimMILYFdQqeYvTjkRKT9W1WtLdCmoP
         hdwad1ecDQJU0pL/rsktfSCQYcArh/SWQ0a7/F7lIPFlshNyH0j8ApVdX74dAxMrozOL
         6/TW6EJcCkdRX+MDRmIjAYu1uMynP9ggP3XT0nt13npJQ5jxNBuXCsJcdimzw9S8Slsi
         o7JpOdCxd+QdvSg2/rIy0zotlTaUsYEI5qm3ztvyRi6j39O3q8r24i0O+L5c/oWoQ2mX
         o9p2dluhKYR8OefVOIRijfNoRs8qXku7rMbJdUBV/qx9EZ0nW8zVCQjyoaG4iGPvyPPD
         ju1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781734274; x=1782339074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jkc0KpQZ06IQFqvfo5weLiE6jD0FlneInSQgr76gC6k=;
        b=P/DpfXKeizBmz9TqTR8jXrG2Er6iKP5PyuN6IEx49Jq0cUamdY9NYrtK1ls+4NDdFq
         +ehmGL5J0FgnO9zyT+6tzzgmaht/Lh/WfywIvzVOUxq2oaPtJrD11Wh6T1ZDIzcEG3mH
         2DAl85k1/gfDkv4eR5P1xaNywWKggu1yLQINaWDKl5n17TKecO5mcHCHnmRU+EH+Ybs7
         f5iZuSwC34O+5Y47at1WtEahO6hxqgMFdEAP8Y7VxN1JROtRe9uE/jXN/VDhBuZ82DVE
         bEB87A4U379o8c3Y0TKGjFAHziEnFLWStiDpzACiYQdf9+KQLFTte5SRL9xabfMNDkli
         dPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781734274; x=1782339074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkc0KpQZ06IQFqvfo5weLiE6jD0FlneInSQgr76gC6k=;
        b=eaHj94GIyW7uU/RFpkkpNQUgkElCcFqThkM7JAtO36s+Z4JWDiU+z9Hgchzl5Cb//g
         i1OAL350afLuZBWp4vV6uqXYJ7ZRBhakhuNgEhu5QyDxUHLTPyjJlZzdHBp8b+UpJkvj
         98DasAvAYKZtGpLi3QuCMYJ+qHfhHthxcgiU5k5wzcJKzoS5SM473lwvW+pkVBVkjEFs
         arDA2c+u+NPKjgMGT667Ok4/B/CMUuU3FtXPhUshyGa8kEZ5C5Vs5rBOJN/48B2uBN7n
         PmRBqv/7HWWVnEz/HSXqKc1qfLducy/abx1fMp8sJfjbTD0T+Ku3Yo2V3G+szjXSk5QY
         oREw==
X-Forwarded-Encrypted: i=1; AFNElJ9BtkqOoGdKjiEQWzAphHcteQNHiiX0iNJXSPhdNCjjcAjAMMx794/faieM79/Rfjc9zNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCmid3Hmwag+Nyre5dw7eWxNLFxfRjfAEUZzHZDrIDrbVJzN0
	vgHGeXd72DIb5U1BmPRLAjgv4LEtxEu1o/7FiPxKKBTOrWyAwdEHAsqktMl0n6/MCcVzcbpbcFu
	LzpYOIN4tFOUfHkq3Z9EYmY3lN/0YbdE=
X-Gm-Gg: AfdE7cnARFD5lT5Yasob1cDAy9rVHbU0GXhUubQNPWo24NPC//tOQ6FZGMxs+x6PZp4
	ELd1wvAT6tJW0Zx/9nmdHrI6jD0p33drbrAaX0VIq3pxWX1g1tR361S3oKYyKgObPvT0sMjyyUx
	xQxGgbj2eRXlSFTUKzK/nB15iUNYHfblVbbvLn9ZiYYFRzyxHRJUrPVqAguqmVQ/14Y3EyqSQNE
	T+0f424KyOiOFZQIWsfpc8/qpTgIFdAgAHKTSX0RqshI8NK9mPAE7mHrm2fj1Tsn0Eb90A8
X-Received: by 2002:a17:907:982:b0:be8:c839:3c4f with SMTP id
 a640c23a62f3a-c05a2f3a6a3mr368691066b.23.1781734273372; Wed, 17 Jun 2026
 15:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
 <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com> <xmqqmrwtuggb.fsf@gitster.g>
In-Reply-To: <xmqqmrwtuggb.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 18 Jun 2026 00:10:36 +0200
X-Gm-Features: AVVi8Cc9WCvGPZHNCJCaVrb_M-IiLgkOfEeP1K3zV9HOOzUvJ3-i3JQ-481kez4
Message-ID: <CAHwyqnXLceLXzRrW_7TB8JM+Ur92gw5QkYeKjzOGbWX+f_yLjw@mail.gmail.com>
Subject: Re: [PATCH v13 0/2] checkout: --track=fetch
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

Thanks for your continued attention here, I appreciate the help on all
my topics.

But can I offer some (unsolicited) feedback on this review process in
particular? Given that it seems unlikely to hit 'master' at this
point, I want to say that it's the wrong order of things to dig into
code specific feedback, before deciding if we even want the feature at
all. We are wasting each other's time. I have pushed on despite
initial negative feedback, that's on me. But I also cannot lay flat, I
like the idea so I keep pushing. Now we have v13, maybe soon v14, of a
topic that has slim chances of passing.

I would have been much happier if you shut this topic down directly.

Imagine all the review time spent on this that could have been better
spent elsewhere.


Harald
