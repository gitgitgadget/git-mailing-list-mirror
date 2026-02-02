Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC13090D2
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014768; cv=pass; b=qJ3EFCp/1h4VHjmHcOUR4LWOKXui9XU+jwZPZAYZucIUw2gvVoGscnTixbYAyMlj505YnLBudUNrKpyuSC2Z8/60y28KX33deGE9zrvsPovMoyR8lOtOHXenDpaIFgdzL0MQuM3FAWCI6Zj8FmhjEikD4Ncp15dMXKNlnX36j+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014768; c=relaxed/simple;
	bh=L5Vh7pjEWyFa9wIEs22+rQZKVZc/HmSM40+HEzU7w4A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tr2jsKPm0M2gaX1O1Xe4rBKbhs3ajVn3j3LTB7JcsUUes8FwTOsYZVJ/vPoDe8tPtvtxVZVy1hlqtQcETwxDU0Mk864tjnWcRCLXOb01lY50SjgFMB9HFbDqxZt7cMAiEkWZG6BgVMo6WMUt8VqJfBQ5aZI5tYj7U5xxXNYEWoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbB/hG/C; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbB/hG/C"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1248d27f2b9so5120576c88.0
        for <git@vger.kernel.org>; Sun, 01 Feb 2026 22:46:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770014766; cv=none;
        d=google.com; s=arc-20240605;
        b=Zkec1IsTOTQRNr0qx3KtOPyHeNmXdBrEhc6kJ4HDd2MOGBFomvA7xx5a41bO3mCQ41
         tP1avZT8FPvn8BJKsyomy5wj3QQxHFmHwkLuHX/zVl47Oj5Gtzi0U1nMMmLaSslIxtQ8
         HxrCiOZvRhVU/8jzPesmdM70TiX6W1mr2cH/goVlNDRx/dB7CHd6+jJQxV/2JIrg1ExB
         oxQGVWP4XB8bzvZOrUtlmqfcaHOxRvkKAxvbIPNUUY6yyyyeH47b7k7YlPZ7klpkNepD
         Lhf6UcLQTZAtZnhjRZ/puxRJs5uXqWTYwcESVRkItTZcOLQ7+nr171SzB98zxM6Eas8e
         cI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FODzpoLyILkP3gh3k2SIvEgadXa5xlWtZIOXWyJGxWI=;
        fh=DQcWdXvNWggLp4XCaJPRfMIVc816XpvXmPZ5FL6ExTQ=;
        b=PDOHH7bsjcU2wJJtnZctNAjPzLcLybQk83YjQu14+2qjWjn55D0/cIcFYnLf7QBvNx
         rjfhWoSjbS7FqpkPtU0Vlc8niKSvLJum70Fv9sPZJiVKnmXLWNwrfz4wAafXO2bXcQUe
         F6MUoOzWZyw9aDJ74tfm2rGBfwt6xt2UEEkRWYXZ3AWigstvLJf3Igp7wU72FXfgHYeS
         PtWVxUE5FLzCiwiHhN18UsUMqznGNPlq3PxxA1bT6rGoJ1vAoOYZRIMaW/DPZ4k3EAQo
         zhLsg3IcCNZhgD85epKVuX5HrtQ0F5tCmwaPAKq13Fnl1p7gVEMeQUk7GvXFmroVFFY8
         Oliw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770014766; x=1770619566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FODzpoLyILkP3gh3k2SIvEgadXa5xlWtZIOXWyJGxWI=;
        b=dbB/hG/CLVPde7thV9EEDthSUy9k7tJA+e7LSgSQE4WjMZC1ldXoTB29dSw2uSh8/j
         UfzeSQtl/dueh72LKVNPm0aodGh90KdSxQbcDdEwkgY8PEQPdSu8mzAbeUiXHs39TeeI
         P3MPHUbXLHT0DNdikx2NiDiXvrsDuN585nPTIDvD80h9D2N6cQEIKWiuWBN5JzWH+FWw
         gobZKNdFP6uklejrqlnBFURXLtjF1gWwP+l0Gj/7bJ1WPjY6X084x49NW5vTezTFz3tP
         Jp/1Gwb0hPaK/alKwGF9AUU2gUT9gJu/pHS3kPOX8zr+mNGkWHcMQPvy0MD489KDcdqD
         EV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770014766; x=1770619566;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FODzpoLyILkP3gh3k2SIvEgadXa5xlWtZIOXWyJGxWI=;
        b=jJkjCYFmfcn2VQM5Wplu2S4UcXAsUpoy7rwL8P/egG9xfsSezatAUwoBm9sy/3lGHb
         um34/6K/9J41O9wDN8IbEK1brEidAyCm+XiFBN6hCRNBdt1b2RSUVOVKkYtbVPv5xFUI
         AfUp8HdRy0Rqo2qACsUSkMt6aki5XaKjh0JyrFgPf3sDmpHgfGQszYA/rhE41SGzSHvp
         aIBjLnYSBcfmGJeK0T9c4q8ZTnHJP6vCEFqp5WssrfG2wTCLrYOrwpz1m0Iw+elQJLGm
         DvGW9Qv7Fve6jDsU7AxQQqUUP2J2qypAXTXERF2H9xeKsFFoqGtgI3tIKkc0aWKNuxYe
         U3kQ==
X-Gm-Message-State: AOJu0Yyp9y8MVJsd3JvSTYTJpMLocmROYyrnrgt1by+1N4fmqnnYRmAb
	JHlNgTfPoje1vzY85L6EtSCZfQTDRRIwjLPgl02Re6rjEc1cyNtudDlQwz3Kqb3xBZ0QOkiW/Xy
	EDkwAP8AePfqQqNPARyBZI94RJnLPQq1pd6d+
X-Gm-Gg: AZuq6aIdsAK28VWZ/XK4tnfdcNJZ1F7sFsMVUhLTepCfm5C7A1yqWEfO/YzjFrZ9o8k
	pcPO8X/mDvTgYR7oTvH4T/wEAYK+pxxFcwTXbacmG0nbvlQ8m/wbxaprkqkzRpJbjZQe3qnrBqP
	qsuOl2kKiodAQc/M6Sn8+ZC91RBpLDh7tvqj4IZHC1HUm6zhKIaYeqJB1cPjAJ2QtUPG/Xclcds
	LJpDZ8Zj1ahz8CNYYJdW8fz1FNn5eNM1GNcqQDCEeHR2e4wUE9xMQEXMqeGDhx36xqRXEic6vXZ
	DHQTfauLEFmb9U1r2msgtq6E+L442gk3GcI7RriiJycgDh3SeZ0Pxvdk
X-Received: by 2002:a05:7022:1283:b0:119:e56c:18b3 with SMTP id
 a92af1059eb24-125c10009a6mr3759199c88.27.1770014765759; Sun, 01 Feb 2026
 22:46:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Feb 2026 07:45:52 +0100
X-Gm-Features: AZwV_Qg4EwY14p0UaSfMt0r1uGHcoqlncRu6NY0LSkvFlo9raAAmksgGXDihq2A
Message-ID: <CAP8UFD2eGzRHj5EiSjEL4Ds1OkMjxM+SPcWW8E7tC4TA-4c3sQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 131
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Stefan Haller <lists@haller-berlin.de>, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Collin Funk <collin.funk1@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The 131st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/01/31/edition-131/

Thanks a lot to Toon Claes who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/819
