Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC6481FDB
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129766; cv=none; b=VVAIMMlIQSA5//olWGMEIKgVV7eQmk0o7R1Nah6IeUvUXB5hdWDQMPK7Z8r+wlcmPJWWRseXs23cv20jTuMn7SayhFumEJrcsEVPtOy8qzz6nXMjlX1m3IS1a7oMFtBkTLkIn3eJaq2Hp1mCfb/Ra9wk4UNu31zT3rCtti+cmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129766; c=relaxed/simple;
	bh=iE9KcVYPvGg0rlpK2eMSHDOrTHsv0rfVOpHycnj4PAc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=snltgCoCPFyS6hMYG1QbP1M9HUHOD123yh20MUZMQO7m4lZO1IKETq8vfW2AYqaNZXxVAW4GNT//f8m6AGDCRT8j1xnt8WfLdhHVwk5oLMZI2Ndh2LWyTRVp3nh09XQmOTlOyZ2qOOvvVU5Yhtd/r81Wp+K21L5983459dcqniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3FX9nPg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3FX9nPg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso33317655e9.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784129763; x=1784734563; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LtoARTK+oey4JnyG0nfGZA1nQ1a4XYQO7rB51KCwWss=;
        b=L3FX9nPg05uDASukhFzeEKr+TXjmoyXNWfmwNnVhN7iWB8ZSDuNOghTu0L+siBy9P2
         1i+GbmVF2ivJx+vNfcxAyqvTpD/RVnHtgDzytlK+9VWXUnVZO0HFEhkTZWbRcJgztHb+
         zlugy0HhkNQDqRvBi1JnzPqbuZD0UKjrHr0SIQ6h8iVgmdrEoUUrmORPedQAA3GZ+D0P
         kNwH6euKIZuJu1NcObCjcjKK01oWQaPGWDkB/lyXjhiPKIDvNih/JRHlYJSRmpVD65OV
         bfh1iLaoXSnSJWv+bJmvQChLRqUerSbEyek6vpbw2q7Nogfpm1qcpJKnpk2UCdDpZWO0
         +yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784129763; x=1784734563;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtoARTK+oey4JnyG0nfGZA1nQ1a4XYQO7rB51KCwWss=;
        b=crMbDypr0bmMEdzadDUsJNds9OqxIi8Vsw2NE0r9+oVuf5pvVshhyqr6Ypqn2mddG4
         hpFHoFG6MiGODW1HAC7cM7NxZ0c1oY65zIOq90Bbdyk3yZVaEWpYiMyUW5nevuo6qq4l
         ZKj0BfWwElzF20YuiMrhlpVF9qUuWc/0DQSXTPbKULaRtGGmS+xsfxjziX7j1Xgh8zsN
         S67I37x5wEUfwZjClso6pcX3/fkuRREfmUjofGOb6uOvyE6WOYRv8u6mhFQJKsAwRMvD
         js9zPTno6aPEeMyUXQ06AaIwbzfAYYntOKYeWHwFvR6srAVHD3gnHLMWbb/ckI4jT7j3
         mCqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1iIYadqaqybzrtrZ2ZGGwIPl1aLa2b25PtT0HHGwonU+2/ojlnhutu91xseqQDH2PgG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAqI6dg1rtWnxmeA8tw/U8My/yttHsstPljiivw74IM9iLv16
	ECwAYLB2mYAn8/FcyyQOY/JYD2zMFENdmsG1xh4XyAfy9CkkrC59476A
X-Gm-Gg: AfdE7cliacEXdmSQgRphnt6+oy3d2UNzHBChnjjiJ80DFYIaQvIbMcnA7yx39oKtWxp
	5E4q1oKmMt4hESCKjMTaeFbhvNke05hW2FdCUa1htwFeWQxjXmhcdkUutrYqbhgCwJPrXqnCfqw
	13VND79IWrlehyd73SGspIgn+GF3CYelxGRclyZy2WiUtmsNuresfkKXFB7yYny/VNJAT7HfRUQ
	lUoq5ltRR6DQPrbL4dgK12d2bOxWWBr4vfvMaFIu6APYa5GULRu29EU2LzHbZVTamkzMSIbcJKh
	2VI85wCdK3ePTdWWIz0wtJPZkSgPRuaY5gCKNsIT/qD9/DI1uzsKt/9fH9GKDEKqUrAe4fZudRx
	0Eq3kqs10AOMMRxaMHdZni6BvC1G2AuetXBEcn2DRuF66AjgPHL+w62r8R32fyVv4wDe4UTpnzX
	3gh12LLPKndjp5enGJCWwoUuwYBlpkUEdG+4/Xv+Qj+jcV3nVESVo4aPveQsznHBRvCVo9xeI43
	daYIRjQnKnmg8BKSbJlESqrF0XRFQFSSAqQqY+993dAYROzrCqK9fY/uzctxEompRDBGH/MqJGP
	nqmcdiPJCEBmwNU6noWBa5g9b6yy8yrSlQDkERX5YksNgxx7SO1XKFRJNuac3nNcBDbn1FCFjQ9
	5K6ra
X-Received: by 2002:a05:600c:354e:b0:493:ad1b:b38d with SMTP id 5b1f17b1804b1-49538a1f68bmr74288905e9.37.1784129762527;
        Wed, 15 Jul 2026 08:36:02 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm17742292f8f.13.2026.07.15.08.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 08:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 17:36:00 +0200
Message-Id: <DJZ97T45NIBC.11YZMEJI0NNEG@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <git@vger.kernel.org>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>
Subject: Re: [PATCH GSoC v17 00/13] cat-file: add remote-object-info to
 batch-command
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <xmqq8q7dto8d.fsf@gitster.g> <DJYNU7D4A7C8.3Q2Q4DX27RXC0@gmail.com>
 <xmqqpl0pqdag.fsf@gitster.g> <DJZ0JXIP13UO.DH1ONBDEVF3N@gmail.com>
 <xmqqfr1kp98u.fsf@gitster.g>
In-Reply-To: <xmqqfr1kp98u.fsf@gitster.g>

On Wed Jul 15, 2026 at 5:23 PM CEST, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>>> Thanks.  How close are we to the finish line, by the way?
>>
>> There's one month left. Final evaluation ends on 17th August (more weeks
>> can be asked, if it seems too rushed, ...
>
> That is the deadline to wrap up your work, which is not quite what
> I was asking.  I meant to ask how close you assess this topic is
> to completion at iteration #18.  Are all remaining issues just
> minor nits?  Are there still large gaps between the desired and
> actual behavior of the new feature?  That sort of thing.

Oh, sorry.

It already does what it's supposed to do, the last rerolls have been
mostly cleanups.

If there's anything more to do it should only be minor nits.

>
> Thanks.

Regards,
Pablo
