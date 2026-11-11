Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435028;
	b=qnK36KZZcOYmFhWM0pT/r9Ht8zKfJLZbECP7ksa84/ajJdTZtoAqHgmf8V7gHpuYHsJp
	 wsxvG+hX41QssGQDdSguReWdaKuofxknr2er92N2U7BV9OAM20LKGzeCPIGx+TRY1aNwB
	 OIeIpV7wpP5hXYSaJGNCLmn3bz7AxzmwY3vBnu3O/1EDLSAis+2meOFa7XcepgKIucQck
	 8Mml4gdtirbO68UmtYQm/nk7gSnyd7yWaHGFzfiJswoGoiTsVsuDO2LgX6q9KT9aP3Vts
	 FiqHQUtxuf/wIN2uO/ok0E+fvkSZXhPxR1XkuGlmBM8GDby6HtN/iHGZYm6oSld6xdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435028;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=77FDt8/9cTRf2m8nR2obLQGqmx3OtZdt6zhOhUx4jkQ=;
	b=LIzlw6AkgMcyAiqcxIgSkOYLpdkEbOxWsTdyJ2YwCpFwLbjkijqpcbfqx+fxCb7KZUs+
	 vbtDD73myhl2QTpDG91BmPw6ZPgTa3Ch2selGWojz9jHesk/6+WtiyyTo4ryS9j4sLpoU
	 cYxJ8kzOp98IgOdi0qQfM+8pHguSQ6m08jPpzBJ7y3GFEjoXGs958Zf9henhHbajnwEWZ
	 3/DlFB3gxAkiHYOO+HyGWcUEs2LnskT0zsHQcS0S+zaB1yve3qInh49sV221Mc0Yh9Zln
	 a1CHxIvnCDqUem3x7fljW2U4EynN5bUEfEMztS27bhGJQrJ1415OzrA3CeLEAdECJgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AGuww1Ev;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n1+2h2h2;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103D606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C103D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AGuww1Ev;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n1+2h2h2
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A54E7A0228
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 17:10:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 17:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794435026; x=1794521426; bh=77FDt8/9cT
	Rf2m8nR2obLQGqmx3OtZdt6zhOhUx4jkQ=; b=AGuww1EvVEcW4rwUJ4Hdz7Dlnh
	iRfN8L49ZO3T/PkPiP3iQjOd0EITL8L4j6tQtmN2mYsG8hPCRh0qYmrUIhZk+RqU
	eeONF6tD1rPZ7pfemLzPX5cIXOUZNfzsj+Un67fEWo9h3dMteC2esTZ+tKkxLwGG
	03CiPPbEBvlWF5DYQ0MMw4uxKjQjflG2PofBQwWAN/IlREqpHTfVgvyK/MUrewdn
	SXZre9zZbFtnfNdao+qigqU5+PAaXLQ/buI51NMQ3BgeOs7htdXiVQzKXVbraN2V
	Wz6O8QtsOztpLkc+ZxO1oIGxJUtbvb82dUPxsiTWB021kD3WUzn4TwYjCg0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794435026; x=1794521426; bh=77FDt8/9cTRf2m8nR2obLQGqmx3OtZdt6zh
	OhUx4jkQ=; b=n1+2h2h2VbH5j6/A/Jqz8CerHC4ht9K5dt5WPTJvg5X0wSqRUi8
	Cc/qNl/TJ7XLUKfhCOujOw2KXVQ2NXUoQINSAH3OCfPV9BUJzJ5D/Qq4RbuUecM1
	WXciEL67EDooiiiaYDtfVzWLVbCzVJZWFNR33pF3KK2CTZ2fodHKhE4Br3MB8N/t
	Z5vUDriRQ6U0W1CK7V5dBEE5iLr3iMfzR2wU+5IN4kd8sCAxZ8uhuN8Xqayzj7fM
	qS0JBvB18ZKX8TnbQiC5aGt2dBRIvRVArAfri3NEcEocW1li6Day2ZojIIcdF4dz
	aBUG73XiwhAOIifjMv4GLj+pzAqQp/12NAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794435026; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ObbasQmFPXju0v+0QAxbODbZfuhhJfNtQ8DBbI5biJepmPz
	kA+0vnfPMqhEjSrof/7X2JtHJ9HedR9zqt+LSd6oY7vF8u1epGVkCKLHUqLrvtoG
	C0MPJm/EGHYc6uJhN1HvyTV9R4dpsvVr4xRP7k0bfekF9LxQPErqUwzFUH98VGj9
	v+ffWxDg24OYkiAPgEXyspKZ0wyDXCdoVKr/6IUqyWEtSzXHRZ8Hm3F3cnQJiJC+
	05TXZKpqRjjnaHD1V5rBv8jT0G2sWsvuDkeTYLIp1CbVE6J96UI70avZ4YRRjT/R
	lqedKX6YUCuJPnK2KrbNuoXiHPjgNJXI1BvSQiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:a2DQ4SRAuTLy70KV1y2UwGcOX075GxeskC3LB+lcxUc=:i6HtcMq3rntriZtXdiZDGaYpWvugZOjxnE/OdVIOqNc=;
X-ME-Sender: <xms:0uf0aiRPiemhTxO73jyfZ9ky7OdNyBDSZGmDn_yf1ZCxDaPDE95W8g>
    <xme:0uf0ardLMvGQWp8FIk3t-AZ1uvrJCrgYnXWg3TZ9JlPZIoUfMAEg5LC174z--pFAm
    5aaVJ9Hlfe-KE5j-JeHXxZbPsUZR0bUHdPpKdFPO9WY9JwSo2HApJk>
X-ME-Received: <xmr:0uf0apoB6KnstvqMJoyvM3odUYJFY9Iw_h3TLMSFVYHe-CzJGewKdjfh6M7y4XeiS890uWDFsZOnyjpulirtZRj5I1R9mbgQErQq>
X-ME-Proxy-Cause: dmFkZTG3eutmiYRQHtT4xiH3kKh5m3jq9KJPnzRkR7EigNxcvjEKvCULjUNPoL67Omiln2
    47drregLB2YB+7PNxIgenCDtYCuR72+B+HF8xgFH82SrqQBYG80fBLtZIemmONqrOGpqmc
    8rmQH7goOKqTdHIyino5Yi8icj8lJEhmYXzdrvFEEP3QU8H0uua94gEkGjhNL4nzhsYK+b
    Ww8093M1UAGB/6qeW5u3KPvX3sfKJaq9TpQPG3q0PNXKRVjYm5I0CxrNYY80ynbqldhMxb
    ft6W38bndnpyTfa7FBaDmSxteXotQ5tJJ0iJy9/7Pf1O/fsh80fLTA5G+UTU6VTDu51lYl
    w1YC6HmUcGa/dylXQ02OaBmT0/ZfFfX8TB6pp9PpRRV8I87n1dAwyq00W04gXewI27RM2y
    1D1CIqewSymyZ66dgbmNZMb4JWOHFuNSU0SyDWMegAHvhRmm3Izp8NI5ipJD/fW9DkU+Ck
    0fgBRpO5JyJgFtARB3jOrAkv1Yt/zipD79CPboqelsw1L57XEkQzxDbjzJHPTK+MHlCE/5
    QnQ44ErIa2cV5rSgOMndwDWCEaeQ1EUoR99Q9KUi7JWGVDr48Qpl7O50YDhvgi0y5uKDkB
    01Nn+EH5eTqr8hjH0kpjMFuLmSoaVw4PlxkzyRfK51jxdGgJRlDF36+umTWA
X-ME-Proxy: <xmx:0uf0ak96HrOba_SGQ49GhVkTbEGf2vQG5S1ECKNd1YTRkkgkr5UKsw>
    <xmx:0uf0atfcJk_zILoh_v6ofaPv955mOXmUVyB5EjD-JciRguuzIRr1kA>
    <xmx:0uf0amJQWTVA2Ux6R_VEzFsjlLyAKpcDsGGgkSyy3NSt42otkFMMkg>
    <xmx:0uf0ali8nxljazcQKPjsazp5xpYI1rPXYx3kr97tVhQT6QepQUdv-w>
    <xmx:0uf0ahDT16MBlIVhw87SIwMzVoZpZ8JO0O9THN-PU5aNRgX3DoKcIVrI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:10:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 6/6] remote: resolve @{push} through
 remote.<name>.fetchRefmap
In-Reply-To: <CALnO6CB+AP=osF8mjkGGHWZz8YX322UoSjE6DCfYZkZ0rXxVcg@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 11 Nov 2026 13:27:02 -0500")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
	<25eec8d9676d4adf82570616ca88a2b38d20afa4.1793357550.git.gitgitgadget@gmail.com>
	<CALnO6CB+AP=osF8mjkGGHWZz8YX322UoSjE6DCfYZkZ0rXxVcg@mail.gmail.com>
Date: Wed, 11 Nov 2026 14:10:24 -0800
Message-ID: <xmqqeccrm33j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> A branch pushed to a remote set up with "git remote add
>> --limited-fetch" has no remote.<name>.fetch entry to map it
>> through, so @{push} cannot tell where it landed and fails with
>> "has no local tracking branch".
>
> I don't have the rest of the series paged in right now (esp. patches 4
> & 5 which deal with --limited-fetch), so forgive me if this comes from
> ignorance.
>
> Wouldn't the same problem happen if we applied the first 3 patches,
> then setup a repository's remote with a fetchRefmap and limited (or
> none) default fetch?

I think [4/6] and [5/6] would not change the picture, as they are
about making it easier to set remote.*.fetchRefmap configuration
from a command.  You can do exactly the same with "git config" to
set up the configuration and you will see the same thing.

> If so, that almost makes this seem like a bugfix
> for an earlier patch, and perhaps it belongs together?

Hmph, you may have a point.

I am not a heavy user of @{push} to begin with, but if the chain of
configuration through which we map the current branch to where it is
pushed to always assume remote.<remote>.fetch to exist, and does not
consult remote.<remote>.fetchRefmap, then yes, you could claim it as
a bug that is introduced by [3/6], I think.  

> It also would then be better justified in those terms, I think.

It is unclear what you exactly mean by "in those terms", but I agree
that tweaking @{push} to take the new remote.<remote>.fetchRefmap
into account is a logical part of that.
