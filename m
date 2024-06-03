Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E442135A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450342; cv=none; b=f1a9vihfOE7fuJA+wKRgzNDRv8C/jnIDHmAbCZ47gZP9Nww3KhSkcxBh3/wc14RvBS9wN3J8pKuyn+QvXN/V6+TjlLedquyKu9v86LvWbW2mdwN3OrcH89LSy4+jeVbiosyoeEAqW8qxAMUS2tILyx/URwIVifRqXNpbx4aOwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450342; c=relaxed/simple;
	bh=GItZIzNlrFA8+xjKlOykTv5z0kjZ8NPXNFzMiR4C//c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fQ+o1uzsVJln9Dd45FGafVA9WF4SUgKcO4e4rHepLGwtneyghnYmUwMES1ElxJULtpwFMnxXssgVmS41Jal86OpVd984wv8kQOxjZngS7g6ziPtYjbT6R4sddn7NVSoocl49fLsc5k2y7gDt8AVSU7P7UrjE+rHySqzLudsBRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKRXWRyO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKRXWRyO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42139c66027so3173025e9.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717450339; x=1718055139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=liQQtvMHRFkYbnhRxNFRIfJSQ8olkgrSiZaGaS4RUt0=;
        b=LKRXWRyO1JO8qiRG0clmC1luj4moAstvK9mjJEmZ5Fmmxf/3NIE2zKE6+XLfWXHXF+
         gBGv1R7v3AErvW9tMxXRw6/gexBHHBUfXkwgCJtaz7anRc2yr3SWMiI42JzsoJo+WekU
         g2IgF97SdaLeymkFTQMJV9Lj1f25h1ftwJ8ZJ8c9R1q2Fxz+kT6uNUoweEgBxFsdSGnl
         /i3CY4gQ/VuqClbEPFyM6DMmg7CxlfUTo5yTdYvCpSFJc8sd+CA9sU2QMEWFSMEMmJkD
         qXFnZbupGjEAwUvrDzFZ8HnFjh3XKcPhr9KeqhUOpywDPYW6gOnbMOHE16TA/hI8Adlm
         Ro6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450339; x=1718055139;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liQQtvMHRFkYbnhRxNFRIfJSQ8olkgrSiZaGaS4RUt0=;
        b=Teo95QDwMjh4PbdYcvkL2jFPYBM4vfT4DBV6NJ4KbUbkpbz48jRc0L7s2Efe2Lyy4F
         CViGoKxtTkCmzCsPL7EPLnvYO9e8uPMHHoa/m85xcj7z/VsJyexgdj3I7gepzKG0/gwP
         ZGyluJ/Hn+R2+cJvZwh5YD1gJmywULalnhh05I7tcvA9KCAT3ut9cT973QA3A+u4dMOW
         Vjay8phh5XSIBY6fc3iMwuLU9d4DRUw8/IkbLw78MPIliSWcifNY5q1fwrUJCBT6oLoR
         EImdWspWIChe65VOQ2aykJ7Aa9V5Tx2VuhHbWsWTj1awIL4YwWJrPVdFZWnZTCPMo8m+
         8/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW7BrIA+7Ji8di4EqD+QCBwMwl43L3xghf9817iMn+qH5SI2fI3bVfGFSi1HPwrY6qxeEluSOo+Wngbdf0j8mqXbkwt
X-Gm-Message-State: AOJu0YwQkjyZDnvsBQ4pWxbE3A4dVZO9vFRIh6Nfioqje3uaVkDaxCJc
	0JCPYXUFmLfaorSUK/WSwEDpodU5CmRXxFjhZffLyaxW9rdvFtyc7+CIXA==
X-Google-Smtp-Source: AGHT+IGpCBn1oDZOx1AnmlS+MffcRwkylouvDNhxqEyBGO+WRxLIbNLJqD1OWDDZjeNOGeKamqHHMw==
X-Received: by 2002:a05:600c:3504:b0:421:3b74:9c01 with SMTP id 5b1f17b1804b1-4213b749eaemr37477615e9.32.1717450339183;
        Mon, 03 Jun 2024 14:32:19 -0700 (PDT)
Received: from gmail.com (32.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214a53d5f5sm2124215e9.1.2024.06.03.14.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:32:18 -0700 (PDT)
Message-ID: <511c8bf6-9dea-4bac-9f9b-fd400bbad7b3@gmail.com>
Date: Mon, 3 Jun 2024 23:32:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Branches are branches and not heads
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240603200539.1473345-1-gitster@pobox.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240603200539.1473345-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jun 03, 2024 at 01:05:36PM -0700, Junio C Hamano wrote:
> Back when Git started, we used the word "head" to mean the tip of
> possibly multiple histories, and that is where the name of the
> hierarchy .git/refs/heads/ came from.  But these days we call these
> entities "branches" in human terms, and "head" is still used to refer
> to the tip of the history each of these branches represent.
> 
> When asking "git ls-remote" or "git show-ref" to limit their output to
> branches (as opposed to showing any ref), we use "--heads" for
> historical reasons, but give the option a more human friendly name
> "--branches", and demote "--heads" to the status of a deprecated
> synonym.  This would eventually allow us to remove them at the
> breaking version boundary.

All of this sounds like a very sensible step, to me.

I've left a couple of nits;  none important. 

Thanks.

> 
> Junio C Hamano (3):
>   refs: call branches branches
>   ls-remote: introduce --branches and deprecate --heads
>   show-ref: introduce --branches and deprecate --heads
> 
>  Documentation/git-ls-remote.txt | 12 +++++++-----
>  Documentation/git-show-ref.txt  | 18 ++++++++++--------
>  builtin/ls-remote.c             | 25 ++++++++++++++++++++++---
>  builtin/show-ref.c              | 33 ++++++++++++++++++++++++++-------
>  connect.c                       |  4 ++--
>  remote.h                        |  2 +-
>  t/t1403-show-ref.sh             | 22 ++++++++++++++--------
>  t/t5512-ls-remote.sh            | 30 +++++++++++++++++++++++++-----
>  8 files changed, 107 insertions(+), 39 deletions(-)
> 
> -- 
> 2.45.2-404-g9eaef5822c
> 
