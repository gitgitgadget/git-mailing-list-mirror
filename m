Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81442405E1
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935153; cv=none; b=EOQWBLB3rGB3Ri4wmEihrwAkmBFWdkG7xUaRYJ9F40jewO008i5lgisbk/WLZWq9D3KLkiGoc5ufDuvq9bRbjlmlwLL+11fb52TDkJh17hVO0m87Y4RB6VBZMAFbIYi9zQqguZw18uEF08hBVcwEJUk6Uv+hV1D9eFeYrmPfBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935153; c=relaxed/simple;
	bh=xe+KgwGf/YMELdisxRkvj16MC5ew9yXp5+9Hx5CXzfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN5Swg5ihMMIbkr8FmheIQ9pKZ7/MSzMqF04bVyD3IDE1Ke7vyRyc+eL0Cg25y9sxgnLqbn1tDsrnrHgCk+rjTjAu198xDgWaK2odDGHohV1OOjxQ4AWkKJWcW3l1fTfU+oOCxwbQBBMI656IYL3UvBSmChUmPvUQ2rzVhuZWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBXcm9Gj; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBXcm9Gj"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50334dd44d2so65419031cf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935151; x=1772539951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSer00hkICqdTtOh74x4GHeUMdbbaX51M8M81r9Qm/I=;
        b=KBXcm9GjXrFLFtpaLNeyfmK59g9ojyGg8lQhVT9hDwhLb81F6H2HwyLC89F3qoID4z
         TWWpVw6pxlUtmTfgEp1ZiT0Vbjr2o/Z0ccAw6kz4NNFiSeseePMRRmWbF0ojWvJc7AMz
         WFo9n+EFxHz+PEWrVuqFKpY5HzLoC1jhB+/ltWOo97ObDKHqPbT+gL63sCnJ1iZSAo6q
         8KKfj3jSd9FphmXVhjOc0Kkoi5mvUz43LV6pVQYqygdi5IM8kDCQ9xaZ+FQ/gkVblAcr
         xsxlXeHMQ22Ajm9TupGHWnkuDUrB9iv5Zu9A1SSpvJ+wpO/vfsBixYkJ+mvjVil7i7LQ
         jZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935151; x=1772539951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSer00hkICqdTtOh74x4GHeUMdbbaX51M8M81r9Qm/I=;
        b=c012L8m6xMPUZBR7kRzHBmZXgp6ww9G2gYJy2GDgejobGtt/aCClE1y/9WX8NtQIbc
         aM0ICp7EE1+wT3OOdfzxDovv5iK5GhC19BDe431Ba41r5txi4coM9JWh2Q8o3EDy48PD
         mPnyGcSuNLIB5yUfAFV2IjFDL9/hutx2b/bPE5Y/L5gwlnBa9CveXbW7eGpZE9WyIbTB
         OYISPnBPMwfhOVCfoDuVO47Q4jRTcc4zBU+ph8RZrqbygp7U7jOsDhcy3l59rhGZy/A6
         QlQoZ+K0AqyVWYbOd8HnoUapL7HNcLEz2gjIOlFJtTQTR9yd7nTxOhi05toKcTnuiluh
         2rGw==
X-Forwarded-Encrypted: i=1; AJvYcCX4g+EN72gCQ7x2BLxA7IaKcSTXSW0WhH2olEkRpl1eJeGq+XOLCVZDJPf2Abcu3YlONVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0Maj/J7vQU97Ai0yLm1JzZteVAzms56RL993yJeR85OSCeSZ
	/5UnR5P20a5yTP02dQ4TnzwA9JrSdJiZERQCRmdpCPZjPJDnacjkEnprBWVKnA==
X-Gm-Gg: AZuq6aJFpjekl29bT6YpYjexpT6SYAvFZ+z8jL4+wUJUlFXWf34KbAy4NYWGmtUYLTk
	iyR7hNxKz+h/0ZyBOVPo5JHfvRd92dJBqHS+8569V2LxsRuQ1yVMeXbwMxNgNJUQ9K0FQdBePq7
	BoyyQWMlmmkyMf6ir4qgFq1jQM6iDRDrltxWp7FfVZDUGhqweOnh4sFiUimA1/TNzlavOc68xae
	2A6K373I+wZjGfAOHF+I6uMdZMyY8jrnvLJc9kB8SKlijrG5NEkw6DUjHEX/ihYAdNpaVTr/Rq3
	WKv81jqYTSH6u9AyLWP3HUITvl5jPJWZQ3XLRVlOkIkpR+bzpNkwjz3LQ2Cbe7Vuco84DWzoILO
	JhcbLPJfuCyfulaOBPQ+BcymR4g8xYmBOGTLxrESmy/+FMGtTrxg2W8WY83U756UfRD0Nj6b74k
	x4DBBWSta5Mmu6GFoHsOaOrx0K+JZ9Y+t5+vypfcohprxKSkWEa/Mmkr4lvd71UuTqPitjQjVJK
	leDw+27GGsXiD7SICqnr/hDO5Lixdj8TN1vl8cx+w1rzMEC
X-Received: by 2002:a05:622a:c2:b0:501:4647:3883 with SMTP id d75a77b69052e-5070bbd9bb2mr174222311cf.23.1771935150798;
        Tue, 24 Feb 2026 04:12:30 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ac09e7bbsm7451296d6.29.2026.02.24.04.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:12:30 -0800 (PST)
Message-ID: <20282180-d018-47db-a44e-93c53af10d00@gmail.com>
Date: Tue, 24 Feb 2026 07:12:29 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] builtin/maintenance: use "geometric" strategy by
 default
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
 <20260224-b4-pks-maintenance-default-geometric-strategy-v2-8-8657338c6fa1@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-8-8657338c6fa1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 3:45 AM, Patrick Steinhardt wrote:

> @@ -30,8 +30,7 @@ The possible strategies are:
>   +
>   * `none`: This strategy implies no tasks are run at all. This is the default
>     strategy for scheduled maintenance.
> -* `gc`: This strategy runs the `gc` task. This is the default strategy for
> -  manual maintenance.
> +* `gc`: This strategy runs the `gc` task.
>   * `geometric`: This strategy performs geometric repacking of packfiles and
>     keeps auxiliary data structures up-to-date. The strategy expires data in the
>     reflog and removes worktrees that cannot be located anymore. When the
> @@ -40,7 +39,8 @@ The possible strategies are:
>     are already part of a cruft pack will be expired.
>   +
>   This repacking strategy is a full replacement for the `gc` strategy and is
> -recommended for large repositories.
> +recommended for large repositories. This is the default strategy for manual
> +maintenance.

Thanks for these updates.

With this, v2 looks good to me.

-Stolee
