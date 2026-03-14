Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A071A6820
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773514054; cv=pass; b=f1wbrzU6EjVgiUoT3ZIUpRwFWHBFKORf0yCWNQoyduuS4lzbIZ//o5+qDkFkL88d3Qfa4NujY/3k3GjoDcYz3a/0jp3kArQrp2+RkCsInWsSyDM6UNX709anDJaJiHbeEXTc/Z9kBz6nh1aeJ9h69mVpHGjCiQyjD7IcxN1swR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773514054; c=relaxed/simple;
	bh=IbqptK6ahwcfZ/IrN5u6t2O7EkrzM1k0I5/tnjagJ6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfUvB3N6JqHP3iHMYqAT8/ru+KFMfgFxP1mqvWFUD6yfSWxWcYAMioE/zuw1msN1fLKetsssO3lgr363xunkbaEg5eEgStcjRw6y+5CRnoGxMLzufJzCAxT9zkR5izleRWuoETLdr0yizuKZ4zmjGVRXJ/wC6455o5oao+2FSKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZteaqVn; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZteaqVn"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986e538decso26516047b3.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 11:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773514052; cv=none;
        d=google.com; s=arc-20240605;
        b=BT5MwXmgAFfITGZDvBDRwR4Svws6dybngtIoGzrZGmxqD6Otluryt44sOJP2tgQTtU
         86q9ZwqEySGqRAKEmPHbBg3/SyF8oRqak+gB/58J5C5opY4aZlHNsyld9dju+lWmObtR
         Z2Uxu7zz99S9Fm9rsOhRm6HxITBZu4LnwCGtNOV2lb145VWk3yfnNaX2RVO1Ri9QGtse
         CplJM+h/Ep5gsXlZf1ImvuZwFyclGehN6lBWH9lFJXOOtWoPUD9NNsUA2FQ1btQPtN/5
         5Q9PBPmLq3JGlHsGkQs8nuXbM+wTm4RFBV3u918J+T2Tk7S8M/Lv6Rm0Sc2lq+AT0LI8
         Enuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IbqptK6ahwcfZ/IrN5u6t2O7EkrzM1k0I5/tnjagJ6M=;
        fh=4luLCxvjvRJAidDiWeOZYvCE9YrjL3JaNNhhUKH58QI=;
        b=ku0RlhQzIJ0EdcblyXw+srOVZhKSlKPZqr0tx0qYZRHzD7vucbjSkEfriRX2JGDt/U
         OEkuYF0vt4KDg+gVL2cc4om1qkIqItbzwutKPsZBO+Y7x4SBbCYfijUby3YqQzdqHoPf
         lYYQKFFz9Op8qThBy4abrT3fkYB5tgJTekoHWQ1oYYmaUvjAIHot81is7I7ybYrELOuU
         U7rVr4UMRU9Mcp3cCNxCNrw9/yi+9/qpnL+1QCuYskA8mqCpCDaEPEGtOVbzIreBWGEK
         MkKtd3wLAK3C0HxM8LjlS0nEDqbf8NYgRFkDF2LbTyF5+1ATntsxjsbQhPTUSGZqMBAk
         qPbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773514052; x=1774118852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbqptK6ahwcfZ/IrN5u6t2O7EkrzM1k0I5/tnjagJ6M=;
        b=PZteaqVn/twGFz4PPznPl01nqQMrLUso2SCSED353hMMTMCq3wxmvMy6eWFBiHpCpt
         Cvx4T2xBgqMySb6xVfI+4pw9pcshRnVF7P8nXJZEJbP8HvQSJRP8dS+fyakURLTbut2d
         BvIWXZWil5ie5RLCBw63QUijKWZQAv26ZCyvpdWJ2Eeij0MUzBUZTPqCs0z1hOcmDO8H
         3G+4ym9DUmce3RLMZlTB5kV9m05FZEat/jlgnYjMgwTroMePnGeWXX+X68Ou7eSAwo5Z
         oR6PCoidRqdHf6DfYetV7kzitgZDgd6GaRV5CpDvRfkgaJcy0OvOo9rbjnVxBcbsi7CR
         fjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773514052; x=1774118852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbqptK6ahwcfZ/IrN5u6t2O7EkrzM1k0I5/tnjagJ6M=;
        b=eEEE3FT2TLyodws9bhbXnADRrHrNw6Sj/MfFz/+hFOmLSBNRVDa29U4QjngCfMl1BE
         3hLDJLnK3U1BQPaSEFdz5OeYxGdHmXVo/k3mvajkf+A0iu/yfKKrlMPGEXW50S///b4O
         ZZkarTzKzrc4CGwgeNEI+6SD79b5nieg5vokWMShpttY+GkY0ztH3Ruy/hD+3lVEG1FB
         AsbRSamA1Y7fZwW1AnMPZIn5lFfKGAWvT6cxz32qQIABhlZ/pOo/y/rXos/cKwoZMqR8
         oL7UQcSZk/Ad1Pq5AGMq6TCMxya8rj4kSUQcGvlpigJe2mN256PuM8CBJD9xWZYOrigL
         TC0g==
X-Gm-Message-State: AOJu0Yx2KDh6Nm5N8MCp5qCaNlS9EEYl4nlPdU1IFf9PEzyl74CYwKQ5
	IL44+kAgASvCXsGkdG4Mmp9MFzdNj1JcxxqPdea/qf4gugbe3Wr5aZXsLdei6AchvBwE5R30W0D
	IDUS90D8AlCZ9EFfqUtlK2FOidhPQX59aVpH2M3E=
X-Gm-Gg: ATEYQzyXLg06roPMhb/QhSS1Oziw7CX16TidDYt0TBgDj9KC48ghWe4US/DHvNgBOOJ
	Nouw4/kHgGQMDA0m+krN14zvKh6mBGuf2/ohRVg7ozFgA9Cz1F6MJzJ89VywKBEXO21Q164N/OU
	EnDDs8UbE0HiOHL/1hfAz/YOGUHYcaG6nKDuioOPsCvHjt7Lvw6RaO//VrP4uyWaWQ8ez+RhTPX
	/PZpUqvddBjdZ1mH6hd/eZ1XP/rlaOuqk0PJIJBeJqCbudmLxEqBIARIIyC2+dGG4GN9oV1pN3W
	JyDoxR6wIMU05Dnr8wffcbcl0NLbpAeTlCVswXpJNJr7+5hyyTUdg7Gu8NjdxwWpAoHqZanUSj5
	21wqjqlgFSzWG383ozzfKxiQ=
X-Received: by 2002:a05:690c:60ca:b0:796:4b03:73bd with SMTP id
 00721157ae682-79a1c18817emr80317647b3.31.1773514051934; Sat, 14 Mar 2026
 11:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNSxS_A=XT7cmUiQ9bsS5vtzB_KAb8URCzc3X5AzkQci8w@mail.gmail.com>
 <CA+J6zkQMN0MnR7OG0vr6B0fa7jefOSP7B2qG=fhv_zYubg5gWA@mail.gmail.com>
In-Reply-To: <CA+J6zkQMN0MnR7OG0vr6B0fa7jefOSP7B2qG=fhv_zYubg5gWA@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sat, 14 Mar 2026 19:47:18 +0100
X-Gm-Features: AaiRm52M5v_rQUFJdNbr0AEIVLUs6WraBybf80qCPQSeUZu8RVIYeAFf1IgGWnM
Message-ID: <CAN5EUNTO8jez1Rc3t-27u29yUYr6wt265shG=QUiKC-65qDwGA@mail.gmail.com>
Subject: Re: [GSoC] question for an additional objective
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Chandra,
Thanks, I didn't know about the [RFC], I'll note that. This would have
to work on top of Eric and Calvin's work that has to be rebased and
fixed, once that is done I'm up to drafting some code about how it
would have to be.

Thanks,
Pablo
