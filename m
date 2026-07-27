Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577605677F
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785113872; cv=none; b=JMuC+PdkXFJLSmfIPEeT22QPUJ0yh21WM0jOrvSzr9vUcdFEFQPLeTfE2t2mFt68Vtcz8AbNbvKIdbQR8JcHRXdUjl73242cgV6OOHp0BgbHy5+MOTH/L1Mq1cBqIHXzJ3xqnPW7vu3qBmV+T6CECYPfZnmbBZgVvfix9GIBweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785113872; c=relaxed/simple;
	bh=vuuIDxjwF4rFOqHDL//TkNi6fExgPHVQeoXzFLleBr8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P36q6CDkg/3oDi6548aNb/WZpR2impUm+N/GBjRHCBExLE8werq4mDZ7gcFGJW1ToXw0zg6RJMOgXE647FY5fyq88jKSpHI9XpTmtmpmBv5ySf2wEJiGfrVsVIjmxq+KVGhv22tlwhw+SfqtAso3dOu2y1KjGYQiVdN4nxPtqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL6ZRBpn; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL6ZRBpn"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bfb3347ce0so582157e0c.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785113870; x=1785718670; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vuuIDxjwF4rFOqHDL//TkNi6fExgPHVQeoXzFLleBr8=;
        b=bL6ZRBpnP4bpimLMZOC2Au729sz2eO7YADgdCJVrnXss8gMbahpb1z5P+MjvdQNdZl
         KkwILYyT39f84ee1ltTtVXb6Lj4E3jRaB9ubtlIA9BfqyXwwbvgt07S6fKozve1sN1u3
         dl03SjYDr/k8j4w/TP9tGtpDKmOo8G26sRkWT6b0qOTo+KthEkTu7oixLqGU7++/FVy+
         VjETuIP0ylWzU079VPzN1TljhF6ow8hZuwZtthkGyxEp0RVVGyRp2KlSs2heGCftBwDg
         LUWdDc9ejKy5kpqjALrXivBFr4CHMuhKrCFknajvt+pHuR4mN20L0fxbxlyWJ3UJ0t4o
         IgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785113870; x=1785718670;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vuuIDxjwF4rFOqHDL//TkNi6fExgPHVQeoXzFLleBr8=;
        b=KMgHF3T/dNktnOuaHP7cTxVFVVKer8xeAe5ZPiMCF/PB9nRu0bu6FInxZ4wAkML8qY
         QBY1dJPJNQzc3M3Qwh3vda0HPsacK0Zs9r/5xjgQOebsMU0MDSYOIHELY7lTeO50qXGT
         /JCopsACOFqPB8fp3qvGiZDLgZQ7Cu5jSzySHMywJZm0my2nsTra3+GmLpCa+oGT4mFU
         M2iQ5Da6Zw18jnqyJp+xIqoM8Jz6PuSGfaINzdnJnxVVtaXlwlUjga2VlfNCUfqUfCbQ
         ZBWGi02X3UgoJtbdzGlzAiQGQJXK6arEauVvolOYJopoW1HxSagEtEp8Z0ZSr5eHSIgr
         JNFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAS66BLf3P1CtOb8H3RpEXT3chTF73eMcFeIw+Ap0o7BCo+O3LpMPdg2b6b/La5J3UGgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn36k5G5c3XwWvToRdQSJzflgQJJ6zDszovV99rwRsqjqFgOZ7
	lic1EuZc3wHs7OFJ11PhnIfyhKZqL7cjg6afMJuj6+OEPfV9SS/fbnVC
X-Gm-Gg: AR+sD13k8mW0dnG3uv6wySZespGD6aGEariFi2nE3Bm6ffizlKz3HTI/FtEd2w/ICqP
	xNyNLSUUdgGCe0u78olT4xhD9FfPWhio7iI+5k4fNLJ9xCereWSMSx2WZcP6ceUN+1IAxeN06YQ
	1THSR7VxkCm8hpbRVK3SJ24+xqytXAyGgIIQh0xmuU5FkvoKNFv8Bem1GStR0GudueXAhyntoPV
	iMXdAu6VrRViramwr7aY57V5w6EvAP2ihIyYFuI2whsXLGo/criHJ3wzVY76a6Clbna8uGK3FL3
	E0yY9pn6AKuapuKCtuEk98Jjg5sa1aY76T+kuv90C8y9hkZlCIYhxYfqPWhxuzwhBBi8qmg/0i4
	VOk0e50Es3LQB89WWukgQZFqWGoQUZWu5ZGXoy47EZeMexwlGXAIPl9+q8H2W3wuWRtC9d7orxs
	3g8QE75NOgJmDEfFtEBAPb85dAtvms/Aj5iJNZCQsrow==
X-Received: by 2002:a05:6122:e184:b0:5c2:d98e:3975 with SMTP id 71dfb90a1353d-5c306cdbc0fmr2117385e0c.5.1785113870191;
        Sun, 26 Jul 2026 17:57:50 -0700 (PDT)
Received: from smtpclient.apple ([177.33.87.130])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3056cc14fsm5124625e0c.9.2026.07.26.17.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2026 17:57:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC Patch v3 0/7] repo: add more path keys to git repo info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqse55vhnz.fsf@gitster.g>
Date: Sun, 26 Jul 2026 21:57:07 -0300
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
 git@vger.kernel.org,
 jltobler@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <8933F9C6-DF8A-400D-AE1A-CC79CEB26283@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqse55vhnz.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> I'd love to hear real reviews from others on these patches, but
> at least I didn't spot anything glaringly wrong anymore.

It looks good to me :-)

