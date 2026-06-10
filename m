Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AE408013
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095365; cv=none; b=nC5O8fzUi4Sz1GGZ/XYdvnBpBsw2q283iDuG5SqL6x08RLf6gR/p4d3w9tI9PRlwcFdZdQ4XnRnx1u/3aNl0Ts57j3JHsQFlNxAy1uyk8WESauIbmeXf5WoQHuw54W4jFjcR8BrNmyzz4Gi3trqil34+2THdQhvom6DgHE5RdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095365; c=relaxed/simple;
	bh=G6Rlb29nJ2876F2z/G8P7gbHJJcQs8ZSsGxGVqPKtCI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q276Ugmx/tAfoPx2jjkJPDGF+EFQtczWQRRQHJ/v1lKfDfB/aLMK0Kq1qmZpOsB6QfrIbi5xXjxOmx6GYtI6JP32Ohk0uR7Xcfkl8nDfo35SIS/7kRlab8Z6dZtBfxpHqkx8U1UYSMib/ozyO+katbABWFIwB96PQM5z1i3srBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FszdBacp; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FszdBacp"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5a1490272bfso4251798e0c.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095363; x=1781700163; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6Rlb29nJ2876F2z/G8P7gbHJJcQs8ZSsGxGVqPKtCI=;
        b=FszdBacpt4zq68Nlni0sNFBZKaJE+StwYSWqP+Okg1twjnj0MbBMHGdf3eCFQDhV4r
         R+FtE3lIH3/8yH7F5OFcSfbk0QF1WuWNEPqGc9fw1ZMBb+Grax4XTmZACJa3aNQsK9EY
         ywzTD51vG9vIpm8xRsMZv9QTuLuDeGAd/uzf9Lz5IWzhCt8WqQ9J5WEZza92BoQQABmT
         CvZrNm7bBuFt/T4KF97/RT4oBXVaKJ0AFqYqb3X2EkyZ8JzHyR/0PzH4L5DgA0MO3rk5
         AsDDktejZWHJfB0DJaYYvqbioF5OwbQhcTmpM1zFeA46G2CEfQLN1A6odYa7wf9sxDb7
         HAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095363; x=1781700163;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6Rlb29nJ2876F2z/G8P7gbHJJcQs8ZSsGxGVqPKtCI=;
        b=QMZ/Od9de3XIsd+2cjt+a1yKiqrzJYUPcgKASjZqGrAOtF2C9N/f5V8ZeH3yYFGxf9
         LK5FMFoOf2/YMUAuujRlXeyO5bPljloonPjlkwBYR4ZQcqRhsgeMR01HVXKyMk7+wMJm
         WulmfLrSCyHKaDIpnqAJVuZmhigpYtrhO0ygruKlISTu8//3kvOjWDDG1lpiI5gZDgf8
         KhL1uBCHiKGFGRC1b6WsWeV3ndyNyG7DFTKPuSs1qLSHS22BIxv0zzUM+cdYkzLyyvDU
         Ud7IJz9FYdFczq+e99nODbl77STwukU+ONMFmL+1ssYwUJk56fWCZRRo8q6P9Sx1ASuY
         01uw==
X-Forwarded-Encrypted: i=1; AFNElJ/MPRYddH9MG1LB+WhZOigqPPBuzn41BfrKoFSHQnmtn6sV0DjZosesJt6Rdh7+dQ3hdy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu22qMem8M6/ROgASHy1eM9ZapBwkJF9aj1xnsr3RYnCtp0vVQ
	DWvNYKFAMbdUY7xpKR15Dn9pg07+rY2jd6+qzv4IsLnBIQdqFOHBSvEf
X-Gm-Gg: Acq92OE6wOapT1t+RtX+CN9Ip9vlQgA5dH+8qwxRzGEC8Ugktw/Ns5z8DkoAI6Srgj1
	o2kxIvK0lG9IYNzj1nh5jPWUi8Kb3z20Z3pLu5en2zv2XwbYxsHqxlgMAMuL0ZCh1Hza5Y2k1wI
	beNSyWwvEvNCRIU/WyX89m7oT7NN+JkTfSXOhG5XHSxdmSqVoJ9wH0M3KX0FRNR1zVUNADqSViR
	rnHy0OqwAvb8CMghUoWacnHwkAF737juSRGwnEQt9leOPzLo3fugJLbPXaoV9pR5XDkSX9qIZ07
	o1cKpV2H2ob83+o6PNagrEMqadJK5E5qw61x3K/3ytDZhPxURy9Uvo9p5o4h0AE162cONP28gQE
	bj/XPa7rkYik52zj5Ff6UOh+7W/L/0cCHkqgMj4Zp0FgNj49Doj29hq71WtyH9xUQzbFAWsS2Xh
	mD7uGngoGJlM68du3fLh6MWno8ps7HcPDgyKigiIGtuFh84Us/wCNxaO5QfcvRLDU=
X-Received: by 2002:a05:6122:179e:b0:5a1:b296:78fc with SMTP id 71dfb90a1353d-5acd3c66af3mr5639638e0c.1.1781095363049;
        Wed, 10 Jun 2026 05:42:43 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d64139fcsm19776565e0c.4.2026.06.10.05.42.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:42:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC PATCH v2 0/4] teach git repo info to handle path keys
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CA+rGoLf39iQH9X-xKW7HeTS3sMv-N-QzGiqm0Y=RYGOAqDcaoA@mail.gmail.com>
Date: Wed, 10 Jun 2026 09:42:27 -0300
Cc: Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org,
 a3205153416@gmail.com,
 jltobler@gmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: 7bit
Message-Id: <F7C0E6A1-577B-4516-9B07-DD6EFB145E65@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqcxy0vevi.fsf@gitster.g>
 <CA+rGoLf39iQH9X-xKW7HeTS3sMv-N-QzGiqm0Y=RYGOAqDcaoA@mail.gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Junio has a good point here.

This is a plumbing command and we should design it
for machines instead of humans.
