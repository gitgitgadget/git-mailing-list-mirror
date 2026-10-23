Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791507;
	b=IV55YiflYZ6EJQP1dkaGS9ySysKqRjNKTmEh1hjX45V1DgzWnE623A7ePBzdTUAiWFXm
	 Jbqh5uL9G98hfyeMwgbCnnHGMt7y2rLv/i5V0Fe/u39BB//QEk//HVc2pLq2xKCEp2Wvw
	 ruyNzLIuktel5VLoBzzLd+mlnhJ97byj2GwWsRebaF6/zC8Kb8WlUESCgS9malgiySqDN
	 c99o4gGmlc4xebxctOOjRNT2LFpGoBkO72BVmd68GOHyv87cEAXSDeiCXZ12bYy8fsZkV
	 +SBt54+XPDkaLb3pbUFKh36wTc3iuGdphudtwTspWWBQZ0yB7ReHGW7qW6uUViC0KOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m/nYgpnMW3vsB+T521TQg7zuOXpnXv9shKV1EwrfMaQ=;
	b=DL2u1WTAyn0wHeZYLB/lXiU+9+1IJwDDhLSlfR7pDbCZWdNWfNwgVGsggvStfgRwTwTF
	 +6WJMuABgoaC+FrEr2Pg0Z1d3EBNuBiFB5hQGOlxYjD5m3gwlD+2zJS4jKFYWnSjcGUmi
	 2wQnpIkithNwsBrAWPzXe3OfcInot2UFCtILYIB8TccBbHaYI7XlmtMIX9nXqz8f2xCCO
	 C5W4B0OGV6W6jvZtXZDTQylKUPNgBmSOuAupdX5ahsGVml++bZV6BjhhEiXM+rsp3S9SA
	 rcvwBRvaxyCm4UUmKs5QxyBXaenFFRkTmP3skhONZicMpcTnxh0VVc/EzUK1qenId9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="HNb1/kG+";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5D606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB5D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HNb1/kG+
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e20edd106so1104145f8f.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792791505; x=1793396305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/nYgpnMW3vsB+T521TQg7zuOXpnXv9shKV1EwrfMaQ=;
        b=HNb1/kG+0uzM/e287pNRXsd17IgWoBr/Q27KrbN3blyPlVv7Id+uL85OysAfKHE0EC
         M8XjA0jS8JWvtClRq4PmKHGhAiXe0Tw/7R10n4rUgoT2pD9IfuNy9b3ztVP/zE27MpS7
         o5viDM+eHzAZ03jsjoiv3kPGDaUXtq2kEH03gcn+4WE5ns7UamxdiQF3J5v+Rg9N/3JW
         tHsXPdThYxS2468CZIkKbuOOK9uQKN1wd6kKdb+nLNifJ2PWirKSv40IxACEFZNcwr6S
         96c+N1mq+2qpLO3HzjRvKJ3eu32r3dsXiQ2LVvAPzy4yOJ7TnMUSU/JklL63rSjHZuga
         zbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792791505; x=1793396305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/nYgpnMW3vsB+T521TQg7zuOXpnXv9shKV1EwrfMaQ=;
        b=rN+VmunPtBIUsGBYQtpdMZslDe5oFX5l5eomBXgQixqE7MEvKEpvEjlhnVzvyhQfyC
         vmaTdW2+1gJBs9mI9lEd6E9RH3LHMKEkNLc8VsUwYL6VxlxMpTQaCq4ZGOzWHnJHZz7V
         b9W0UA9Tt8cE3RXH/+MVZmHO7c1KJg3r2aqo+445QpmRUn3Dpgurj+AftARtqnArv7sn
         dK1LGF/iliYDMfAZxnQ7+gfQYvdK0KNCydInXb8q6UZx28HqZIVWPx65D7udu75RhIzc
         f24dS+60VaQ4UJ5H+/97mS7ty91bovTroVDc8xf+SFE+ewoYGf1I+ZRZAJrum1o6/Yei
         GMNw==
X-Forwarded-Encrypted: i=1; AKwUvByhUxgtLiq+hfXExaT81rQF7TRdfBmFWOeyPXFude/MDPH9Gv27s0Mfxe8PmIcGkNpUtoM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKG7i5xn4n5y/Vp4EyUoSkLzzvLlQEeTDdjkBglIbuVUe1MID4t
	d5R2eXzIgX4fykDCaoeZLDkRLvhqXKLU5ch23kzZFHAJC60CMmh0nVws
X-Gm-Gg: AYBFou1JgWjcRkOXQS09RllPyIjX+IsoldBHSEv5XU1Q2zPzC7hMpRGgFAZ8xXMeM9x
	jUH3+XWX5gAG4eo0vO5wpHJ0TMhI4djiqzQCnctuDUyx9RnVwH4IMYTE0XLoKHq8LQWhy93kYxa
	b/WK7dZvDKSHZHV18DibuaDrVRW5M5LawxFiCkKBckxZZ91i8SYu10OUelDuK1MKhkMj4hhbMtI
	IUmlftnn3ejshbmWrjsQyrhQa4RDUHtBr16a9877UC86RcJnaVu7kuc827MND7KOKzB+roWrsO0
	J1nelAiJ95Tb0CDs1fsL8koZfR2scFkY+taF+JDZJOkDvE4Pa2RhR3y4JrS1Snlnmu2aP4Y2f8j
	QnNNA5RvbirhSdiZA9ZH4Aljs8Of6OK1Ssgl++ygqet5bJRgk9vhr9VSLbniQDSM3SqmJU/0RcJ
	z6SjrTYai0Ugf+RAd/PhYYTrlNc4nWw/BsR9EFS1ziPQab4rJqWqxiiT89YRBhG77mrrLs3151R
	HMb4KzxeWDJ64DjJz7moGHZ4U4DJf5OthkOdmrNAj+goV+GmboLLw00oMeBcN9hpnm3pYlAK+an
	59Ry
X-Received: by 2002:a05:6000:2a0a:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-48e3eb82390mr231170f8f.23.1792791505319;
        Fri, 23 Oct 2026 14:38:25 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc4d76sm476609f8f.12.2026.10.23.14.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:38:24 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v6 0/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Fri, 23 Oct 2026 22:38:12 +0100
Message-ID: <20261023213813.3318-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqq1p9hhbue.fsf@gitster.g>
References: <xmqq1p9hhbue.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keryle Fondji <kerylefondji7@gmail.com>

This v6 addresses the feedback from Phillip Wood regarding commit
structure and patch applicability.

In previous attempts (like v5), the diff showed 4 deletions and 4
insertions because it was compared against prior iteration
attempts. Since this v6 is flattened into a single clean commit
applied directly on top of master, the diff naturally shows 2
deletions (-) (removing the original master lines) and 4
insertions (+) (adding the complete Q_() structure with correct
tab/space alignments).

Summary of changes in v6:
- Rebased as a single commit directly on top of master.
- Maintained the exact indentation approved in v5.
- Cleaned up unrelated modifications from the working directory.

Thanks again to Phillip Wood and Junio C Hamano for their guidance

Keryle Fondji (1):
  archive-zip: refactor 'path too long' error message to use Q_()

 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.53.0

