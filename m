Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356C1E0B9C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633475; cv=none; b=hlLAPp3C65PT+rKyzydQgpAsd6lqVY4SJPeHkjpcNGXtQ+FugiGmG+yiYy5zf0sgmy4tKdKbWThYydRLnFPVEXKbnk2+9wBO5tpwTiq7NDWtNsCGLdW0u6OjiYnMeseAIhX6tbBIBhQM19l2N0MsNjhqotMJvRrJFi/KSQKHPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633475; c=relaxed/simple;
	bh=L3nM/m5PwE+KTAeSzA8GC0d+BFJiIb9L61b3zWSK87g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HW7p5puhPQnRykf8g3UI2o4UGhjDFBhEZ+Juf6Mul3qaiVWE+RejlBGCs3QUJBs4idTCqBKtfHeYWuo6nDIJKI0dfikG/uA9CNAC3p0TYpZVgEBfSBKt83rR5Vg/Ciaff8HE0b6rN6rv33qmP+NWR3/sSI9KYtInt9+UaM3Jn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzMHJXMy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzMHJXMy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445826fd9dso67539255ad.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755633473; x=1756238273; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74rnLyAwk8WzBn8egLR5DG3CecBjeDTJRDgNQurZP6E=;
        b=YzMHJXMyDteBC1OalKKalaxcZNlSydbYhSMejlwSB527DaeAcJdLBJE0yYbGlzICQ+
         AeSMxcz/l+uvjRxKnvmQfvISOxsVXxiOw/uzkLshtgeVPNlBHd+L6zag9JHvmfwcwuuF
         SdGEG2APTnUTMSJ3JAURhd3jPOgBf2zUxZO2PLe5SnCqDmDZ9DKAaW7FxRtWBPKXXiFt
         OM8os6YU3FJ2UUm+TOZTzeZQJnkG7G3M7NQ76c0pmhK9SFTeA+ISrz71PcbuWWrsCfHN
         w1G9kfDSr/5KPsf9SSt+F6+qw4uSrGcfMHhmSmAOiQo7MqMG/1UD5QgclLTza1KGQeWi
         +Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633473; x=1756238273;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74rnLyAwk8WzBn8egLR5DG3CecBjeDTJRDgNQurZP6E=;
        b=j1ZIOQX0QoME/HdxK5sl83Owgz+dcgiikgNoMrPkmfWtRAfIBWqABfu31NCImvasq4
         KHGeSyzAdgcTDTWacZ24+TWfOXRlfz/a+C+hLxT1tIgdHEAHbOzJwo+xLH8ej9FjQyuI
         7qu26pxfBwWAZnlV3naExrDxOkW9VeS+LM5CkABaosYoYVghxuA4klknWvtE+cYy+/9f
         hAzhNyd0SEtBYQEypzujXWlkuB+/PRk9Dn+C/AAFqHq27YCJY1msL9Rzj7GhM7aH/6RX
         HHLAAekPdV4Gjz5X2QLf00fb4VXyA31VsHuN8YJkoDUX9sE9m6MCSgni+EoTkJZ7jdJr
         omKA==
X-Forwarded-Encrypted: i=1; AJvYcCVf/igqVq4mGWppexOxddaniJwgyc8iA7SLzpTxPXosWc8Fqyr1pIU+IY+bIldAvOnIvOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxibFczHTxwurome5DrMQElehKcieySfIYuv7qhqaU2o3Mjwggj
	knFxzb4VyM6/QoCf/bMib32FWbUFYDXyN/2UyMD9XUXlNXgSazFwTVb2
X-Gm-Gg: ASbGncuIBtF8r5RGnK5l8DY8YTuedyvNzcxwqQkTbEZq4j1XpNUveaQNaZd5yI5NXZj
	t7Jxr01+Cvv1M9SbRyUeGVd9BuCe0Bw4z1Tx4mWubX6kpPH/Vpa7W0N8x/yJip/Wn5rwnTWduoI
	RXxCtlxn9YZDw9oVXg1WT/NCiNMv63l5tHNARrEfS77ABGYKR9rb79rCp0ivF8zhUT7pTdSgm7w
	ro5HakAuReaDcuPx+CWyEmK3KGFoqCKrAmsZApq6wx96JImEp8oM96ocJ89KhYztsvld4bLwHhO
	zDiRaERkqlUz0VaP71tYAp6wMjKHXv/GNWgZj9wWl8ztD5TmwxVvR3ucQn+pVWJapGx04SHQ/Sz
	m8uc=
X-Google-Smtp-Source: AGHT+IFDouERkC+Xp1ix9ohq3VfPa4z3KfO9QX5BqVXnJ5HLk0fyd31aYXldrJyb1THDYT72JGEH0Q==
X-Received: by 2002:a17:903:4b24:b0:240:1850:cb18 with SMTP id d9443c01a7336-245ef286179mr1907005ad.53.1755633473412;
        Tue, 19 Aug 2025 12:57:53 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::e9a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7489sm5110925ad.70.2025.08.19.12.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:57:53 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Daniele Sassoli <danielesassoli@gmail.com>
Subject: Re: [PATCH] doc: add discord to ways of getting help
In-Reply-To: <xmqqsehnccro.fsf@gitster.g>
References: <pull.2033.git.git.1755630128134.gitgitgadget@gmail.com>
	<xmqqsehnccro.fsf@gitster.g>
Date: Tue, 19 Aug 2025 12:57:52 -0700
Message-ID: <871pp73wzj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> The joining link was generated with a never expire policy.
>
> Now we cannot take it back as the link is already in the list
> archive, even if we wanted to retract it?  Then there is no extra
> harm done if I applied this patch to my tree and the documentation
> update becomes part of a release in the future ;-)

It may be better to use the link already shared on
https://git-scm.com/community .

>> +==== https://discord.gg/dxGanGcBSP[#discord] on Discord
>> +This is the unofficial Git Discord server for everyone, from people just
>> +starting out with Git to those who develop it. It's a great place to ask
>> +questions, share tips, and connect with the broader Git community in real time.
>> +
>> +The server has channels for general discussions and specific channels for those
>> +who use Git and those who develop it. The server's search functionality also
>> +allows you to find previous conversations and answers to common questions.
>> +
>
> "the unofficial" -> "an unofficial", perhaps, as by definition an
> unofficial thing is not something the project _endorsed_ to be the
> one and only one?

+1 for that wording.

Collin
