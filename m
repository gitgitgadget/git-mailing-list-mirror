Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECF3EC6BD
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144498; cv=none; b=pBoPFzspScoEQaPTGNBLrVOT+5hMglNihbWQja9MYbNag9oBx8hXP3uHsq9R/9P1KO5lb4RT4nXw6Y1pSMqFiOITiU8bE5h6x13PdnytCvct31YRQ1sopkShDAqHY+0Js4CjiLYkC4G1JRq994v/adxk7aTz96QqoNIt0zGNGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144498; c=relaxed/simple;
	bh=9lId0gNTp8wl6ddqd7xrZRtUF4Mxj4d0AOw9ke3hW68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqTIFEEN8fG6Yq2Lhmhf1zk4U585WPMWBKUi47JRxp/9j+AIg9N3JjAUo6k5zLGbSj7Q7vt0Qtf6Gonlewevc/ZQUbfKEJFWcclROt2mXkKiy7ewHYUswVfS6IsH5WaSnpSqninclTqWLOvpPZtw8fYhZQzTn1Ya4XvWJdApby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcHRI6KB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcHRI6KB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2271155a91.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785144497; x=1785749297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvkYngJWIAdpEf6oxvaSaW+SI0x29g3yIoZ0INxYF5g=;
        b=KcHRI6KBxJbddKQOQGVpjpZa+l649sC4v+engKG6+0E+Qxh5NSe3Ncb8zyrPZrYGeQ
         OQxbXiOoIJLfGOgub2a/Zextbir7fefvOzIk/W/S13alu/cbNyO+D/Rmmn2iRPITwIxF
         LLiGiiI+sz6l9MyAyVO536bZ2uAINfXJcEVme1CsJlRLmLiUpzaoetr8ozw/kWlVpiHY
         hv5sLRXgflBgnpm+nFVSV9gw4mYqGQONFyY9X1R9XMb2qeUSdD9wsSQXORvCeQmsBZI9
         1Fd/n79vI1upWQiI/jrdLfX22y6Ihnd2AeXv3uK9U3b22+GP+FhaaLFQflZZXcEgTXrA
         V9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144497; x=1785749297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YvkYngJWIAdpEf6oxvaSaW+SI0x29g3yIoZ0INxYF5g=;
        b=XLom0c8b0q8zbm2/BZ3tAPTSXnamoVJlPgFXMv5uP0E09jHYg5fl3So3GDHvyHdQm6
         f1QMgsW2/vHNkta04fwpB3aUcVzZ7E9x3Ve+lTdFHh8dQf2Ia4oP94F+fqAO92OT7b7B
         jnOwAqXu3V2CIJSpWycwxWhETPI2ZUDAsHNPM3LYQpf1YexjdxIRMRZjsfZnqqPaErhx
         95cx8ryAsNI1Qlj9jNKJMdE22GCVF7nghhuskdgYyWr/Gy6p2ijAHPA0YdiUO7A+0Q2v
         wwLArjDVGemb3uzOE7EF/mvFUAh7CjE8WETDyx4bVkzMIYv2aUviua8icpKFPYsQINl8
         cWIQ==
X-Gm-Message-State: AOJu0YwxJcsSvWMwDlninuaP/lU05YSznDKpbt/C6PUhCuQ8hFzjKt+d
	lXLHohpofO+I16IEHYOV3DWuZi06Pyf0dIybrDKaeMTbUifudcqR6iU3
X-Gm-Gg: AR+sD11tioR7yV7+kS8Q6Ak2eyS5ziYQOkKsNTrA+4UrRfuUeq2TvEL0DdwS/GpdkWR
	P8y3vm9X8+eKBbN1bJ9zcPZuzpFlZVFJb/+P51X9eQHVAPnj5XE2/ohCyEDe8rVccCYZyfqwzLH
	Fm1VAfi7diuoyKo44ORdBRD/h0udJnQ5HnU+Id5Fx6CDriBl60H/nWfaCbKkqjq4ZrA3i4mAcIF
	R7vmtS2/P9fRpPGh0Eh5Pz5VugEL3RkL2cPZMS6Ngc1gAthp0CrrCWZKaQHbLIwR3h4Y81T1OhX
	WUu5w6CnN8RS1vb1TArDafB0m6Kqg6XpBPDQyyAt9HXz0IFoaqxE1LHotDdsQp/Xxi8MV+welBj
	xUW2+vtGjYha9gO7hKmCyPZN5g398w3VvZmCq4bwyQ4F9tA1+K4Q/2z+KMPYTFrCyQZ4xFDbKmP
	31UYyrfa+o1DG/xzlN3TcG0fdW7Ac=
X-Received: by 2002:a17:90b:1e0d:b0:38e:dc4:3f64 with SMTP id 98e67ed59e1d1-38f29784460mr6674273a91.38.1785144496698;
        Mon, 27 Jul 2026 02:28:16 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc57ae17sm26469351eec.22.2026.07.27.02.28.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 02:28:16 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: Re: [PATCH 0/2] t: add and use a commit_body test helper
Date: Mon, 27 Jul 2026 14:58:10 +0530
Message-ID: <20260727092810.71405-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqldawq24y.fsf@gitster.g>
References: <20260726224803.45131-1-diy2903@gmail.com> <xmqqldawq24y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Doesn't 'message_body' t7509 has follow the same pattern to hide
> exit code from 'git cat-file commit'?

Yes, you are right, I had missed that one. t7509 defines its own
local message_body() helper:

    message_body () {
	git cat-file commit "$1" |
	sed -e '1,/^$/d'
    }

which pipes "git cat-file commit" into "sed", the same
exit-code-hiding idiom commit_body was introduced to replace.
While rechecking, I found one more site with the same problem in
t3404-rebase-interactive.sh, a spacing variant of the idiom
("sed -e 1,/^\$/d" without quotes around the address) that didn't
match the four spellings I had searched for in the original patch.

I've replaced both -- the message_body helper (and its call sites)
in t7509, and the inline pipe in t3404 -- with commit_body. Will send
a v2 with these folded in.

Thanks.
