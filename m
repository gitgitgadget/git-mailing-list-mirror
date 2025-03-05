Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212E24BBE1
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184808; cv=none; b=YAjFBTyVgvYCe4D0z27iGYQNJax6crzbxGD2UKTfk6iW0hyFds9UBmrGZHhpYq7Zyd4rnjUB6MnWrgAo9mhxMPMmF0+RUtpbAPYtZi5NYsx8VftOWwCI1zyzS8+Pklwksvv6DDFZmgpHW045TpCUilhKtY2z3/t2Ep3vU7CD6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184808; c=relaxed/simple;
	bh=l0iFWFjK8Kr068l2q86L2WAHRMHxsdxg9nsUrioHack=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u2MyzgJRkVxD7VOn+c3c8jq1wp6W6+hFmUsbrKRjCx6EJv3FoxNALK66BvuLytXYOqSYN2x7RcWO0SA32IjftS5WH07IIvEjmcvqeO/5WrpYp+YLseOVZS6QxcF/RskvFicBOkXo3gt/Nr3qd1BwcYb5Qm24UaxyH1bGoCcyPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l53f3dXN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l53f3dXN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22382657540so83884925ad.2
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 06:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741184806; x=1741789606; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0iFWFjK8Kr068l2q86L2WAHRMHxsdxg9nsUrioHack=;
        b=l53f3dXN6IRMYenaXNHDXBdj7PyYqjNDdi+3zMXyAyAhw05jfKkbG2wC1lohAtbEPo
         6ECGoDHzzaSgHMpWKskPolKxh/fw8lTQJYt9w6t3A2FGhkrMlLvzrsmMbbQfm47w6OMe
         0rh5sHQsatNBs6iBe09mjjhjQNUtUDgVzucCmMK0nkFN2/uWDczwKegrlm3sfj6L7y+y
         wg1pkhMu0iuO4ybVwn0zysG0LbSyXgq8U3hjWJv9x2JD0D9+GjXO83wYIhEAPfJClFrE
         TXJMaaGgucppp1KLaZArmmq/HL9bzheDzcZyi0obvEZ/HuAcdH6UjZUnKJWVOtAQEh5F
         B18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184806; x=1741789606;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0iFWFjK8Kr068l2q86L2WAHRMHxsdxg9nsUrioHack=;
        b=Ezn1w6+TQtNxHAltU/lqPgoCj+vW16hZQ6uBYTuZkwX5mdcFUWi/KJwzz9LUj9sG22
         M2EaETT7aj20YNTwoHyMn+aWeZuRahhuBVTuoYjXYDcbUV8VgTqZHrATJlDAyM/gtEM7
         ZcJLmQ9mcDrdYEFcIvshUNhjnkp5RgzZ0nTrtPwYZZ/aMH44RDyQn7/IEpxV+vx6X4LX
         FVwMWGul11nFxT8WSO4ndP1tGYOKkIPeTHjUsGiIwY61xW4SFISp+hXUShOinBneK+r2
         7NgMAAiNkipH3kiUgNoW7ums1MjS3DXD4JdPPaq5ZpQyA1KVZ2mJ1L8arKXy3/c8Qqn5
         EN9Q==
X-Gm-Message-State: AOJu0Yw0JtAve3ZI6j8KZHoGbjw3ihetbqCNKEERv3XI3rc7Gb0ZbQ5Q
	9oM/J13qn7KXvcvcswKRa+KShsOyMowWGl5+8XKA2NAhn6cXyNjELHnS5Q==
X-Gm-Gg: ASbGncuKiWYpMCA8cwl6U/fxbB+dplQKezk4nWMp/Ij1RAZW4qQf89y0jIWoWA9qmB7
	+DQP1VNNqaBbEmkpch5OWl+VoUky/Nj0KfpEMPhT2bhY8Vdz3XkGkp4yrWtE2NJwozbKtE/nxKx
	cTI9vDUGfKCJw9woeGWd42Hw9qhmF0IDFXtthLxoGisz/SqyVKTQW1vB7fMiUrPwcxXJUnLNMAh
	Svy2RtcfsmWbeoVFFupSVHryVhjE5ZMDFNRQM5gVQBWOuR5iI5s6j8BRoS1IeW/MLtO8YGs0k9f
	vfSFmXc189gW0ROQ2K3kpQABIJubChM+rl9gQw7szKBRa2pWg9Ds7ZbYD7J4EeFH1l8C2c/WwpD
	1GqA=
X-Google-Smtp-Source: AGHT+IGxx7DKw4NTp8z9IcMnKfqUiMctE3oNvgmfTtFe1NAnmoJKJ4GFDGtFwlrVv/4/RKml+ObjmA==
X-Received: by 2002:a17:903:192:b0:216:60a3:b3fd with SMTP id d9443c01a7336-223f1c6a902mr43189615ad.3.1741184806092;
        Wed, 05 Mar 2025 06:26:46 -0800 (PST)
Received: from smtpclient.apple ([2804:7f0:b77d:283:3159:a06a:78cb:36b4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22401c0f7e2sm4616685ad.155.2025.03.05.06.26.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:26:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to
 format-patch
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqo6ygmdst.fsf@gitster.g>
Date: Wed, 5 Mar 2025 11:26:32 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A65813C-4D58-4817-AA84-A2449AF09E40@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
 <xmqq7c55vhj8.fsf@gitster.g> <xmqqfrjtt084.fsf@gitster.g>
 <7350D94E-39DC-4C9B-926A-3FA2A4C76687@gmail.com> <xmqqo6ygmdst.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> Yup, I do not know offhand who are managing these descriptions, but
> having extra moniker in the same [square bracket] as PATCH is a more
> common practice, and we should follow suit.

Ok, thanks!

I just created a PR in git.github.io <http://git.github.io/> replacing =
the mentions of=20
`[GSoC][PATCH]` by `[GSoC PATCH]`:

https://github.com/git/git.github.io/pull/756

