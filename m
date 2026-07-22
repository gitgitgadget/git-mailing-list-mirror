Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2A33374F
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723893; cv=none; b=LEDcHvYlEGmZROeQrlh3jK7DQKmja2EJYtx6yUoZgXiXWUuFJgXp63Dq8gWGhZOTGhgfrhuIV6I57dsq0ScfwU0OzREdbdWvUqWUVPQvVta8FNmq26cb/pJ5RqJU22irvwaQQsLiQd/rgMoOUHXwrjYBHyiKw7hgI52F0SHt8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723893; c=relaxed/simple;
	bh=3zGm4vhiIGnpCkhcAdfQgdUOtS51fL7Q25WLihfRcyg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=gJfR2NjMdCvzG5sy+HtZleTloJzHjVpYX+mbifRVO0fsfe+UAL6us3vSnVl9COhl9aGHqj8JZbzf4RGPBfbuOFJiKfrFvoRZgMa1BFaUeyFNVZkGd0ufSD67rm2HoDzyhP3piohUYWRU861/DzS9aYdRATydtp5AnQAsgl/y0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyuZCY2A; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyuZCY2A"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4758bd3731bso4862679f8f.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784723889; x=1785328689; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bigfe/Q2zqlTHnG0WZG0x0G/6Nst/YlzFIRrZVbeayw=;
        b=DyuZCY2ASwwTf47PN9oQMxv9yG1jYLKNl4xSjT0OdBdZRBnGNS4J30JniTjYg+A2F8
         Lw5AnZhFqgMNJo2znJ0iccLV1OZWWDduVW3tAq+wE2coLRIoOgk0fgt+wGNxzDab7eMF
         g0DnagUNdkHb2u5MEYoBtVMVsY/W1ntBXV8obyqESDKXm3pG48hQkH7bhRmEGuXwZWYB
         fvRZdoLkcn1clLb3gACr2lo2VJQXuO3vC/lhQL/yTPv3v0EpYtALFQ8/4aPynkGYfjZ+
         oIC4sPGTrHe80bd5lyudFDkkH9vmOLEqT0NUz6o+LFi6nHrePWnTLLUfnFGYGRUiOrPN
         XSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723889; x=1785328689;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bigfe/Q2zqlTHnG0WZG0x0G/6Nst/YlzFIRrZVbeayw=;
        b=BiNMsTXeTmRn+hE9iGBt1nRpbn2Sl6cP3uitGR+JF17vUU3//ItjOeZi/WTEXWtjtK
         jTkMxp5IqxvFwE8y3q80tCbix4ovJ/tStRUPwbN0MHdBgJl3UtSdbHx5T3L9iz3ZBmTU
         P3dmw8si3BdjCdP5imtsOG5bSp6gv8n4XzwP5QHfeydroVK1BFvRFD6UCo1n2DLE0A4i
         GLAz8QHRMHohCFNJvA+0fidEZat+VIotOE34Fhg7zIIIBYdHCI/+IdmOQp1U9Ynsc3Aw
         6gQmcU0hJ6pfvBCAW4AXYBpE2NsNjV7NJ8LHbZHvSA4YMznvnIks3F/Cs84ZGQ32qqEr
         CpEw==
X-Forwarded-Encrypted: i=1; AHgh+Rrg/IdG0gjFkpTjwpcUq8K/7UOGb9WyaKZkZ0wZKhed1hIUtnjp185NI8/4/W5i4q3oVKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKwJFeIMbPhk2ttvobzIuTqbwV3rRqHDbvRONkrv8WbmUnOcp
	QxxIQL1Seg0044XpIj4ostSiizCz6olvsLj62orMhKPwbb+p2aXvVjrs
X-Gm-Gg: AR+sD13b3MrfSgbYmgF1k1fwjttvlVnbf77Cmae/EpNOw8wg0N8cf8MCebau7Oklgko
	IqMqqJ6aMrnSDLs90rFsMJdRNpbc8lEUMmrKmmO8nD+rZovReaP1B76UlayrYGUt1pwYyFV1Ki1
	XYweA3SfwbWADHXJYjjFr5GwXDSxKQcsYclcF9na0WCu8/yYKLCwegXH0SV6IXwk6BSJoGPNuwV
	OUD/NAhVfMP6cIpiEYeb3U+sc0hAmscTfZ+r0TyaJlSkVuHZt5xZqTZim00lxWaO7hnxvOX6Hwq
	h2CRE/VCuupDCeflOqB8gzNeiJOoS22jriZPuhTI8tC2nWHFceL5Slbj2yL8abz3QNZyDz6eRcU
	YUVT7cAhZwtL22UJAAsSZ92AuAgyhQKhKW8yDLStI2kJ1EWOV6Ipd3DNp5R7zPrLU+MhYWa+OJX
	WtmhBJS/YW9nK/+6dzODuzRLR53Ac0ZZ+1+sas2umkP6XunRzag+aLLTDyrq8fd2iRWs3eAKFdc
	crbctyCaOvR6yFrr81nug9Q9g2rNBZjSbMBNWHii9caDkd09NhaLNmRdNuUe94AuluskqjeZw4I
	LEcbGwOIT03c5i1xSdIcEUusp1N4q4VwF1fvK0KyvI1jjapF9ZzCKeQk
X-Received: by 2002:a5d:59a7:0:b0:47f:8a21:b760 with SMTP id ffacd0b85a97d-47f8a21b787mr599854f8f.4.1784723889425;
        Wed, 22 Jul 2026 05:38:09 -0700 (PDT)
Received: from localhost (82.159.183.80.static.user.ono.com. [82.159.183.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm6218284f8f.7.2026.07.22.05.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 05:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 14:38:08 +0200
Message-Id: <DK53TFGRDS4W.3SYPSLD4HJWIV@gmail.com>
To: "hardikxk" <hardikxk@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Extract only the message log body from git commit.
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260722083836.744338-1-hardikxk@gmail.com>
In-Reply-To: <20260722083836.744338-1-hardikxk@gmail.com>

On Wed Jul 22, 2026 at 10:38 AM CEST, hardikxk wrote:
>
> The patch fixes the `extractLogMessageFromGitCommit` function to skip all=
 the metada of the commit object and only return back the message body.

nit: Let's wrap this at ~72 columns.

>
> Previously the function would return the entire data of the objects
> including authors tree and SHAs. This patch fixes that to skip over all
> that and just return the body of the log message.

This repeats what the commit message already says. For a single-patch
series a cover letter is usually not needed.

Documentation/MyFirstContribution [1] notes that the commit message
should already explain the change at a high level, and that any extra
context can go below the '---' line instead. I would drop this cover
letter unless there's something else to say.

>
> hardikxk (1):
>   Extract only the message body from git commit.
>
>  git-p4.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
>
> base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f

[1]: https://github.com/git/git/blob/master/Documentation/MyFirstContributi=
on.adoc#bonus-chapter-one-patch-changes

Regards,
Pablo

