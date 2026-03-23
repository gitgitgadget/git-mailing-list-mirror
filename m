Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39202C3255
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244397; cv=none; b=Wv41QNojcNknnIPGjnbq0KCFf6GOdJg0GQnm/cXH0NL6lFn9l3DsFKq6eQxdud+mgIOXagu8tn9hMWsjAQi9EIi3ekwPslBCrvOQ1qleNsCYnEPYtWmbXOEZ2vyph49Uma9tTcPrvnTSycyDPY4UeOy5SxqbUQSuwCyKktvKtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244397; c=relaxed/simple;
	bh=QVc/qu49VZQ3EcrsE20osmvor+PH8vFT67wfZOIJcVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHzAygv0Rztx3A2FNTzHkAMduK/GwkYqX5kfutn+IcqC6xSy3bBuFA2/J/gsre94z108zhhcPAhlcEPKe7X1QrYEQdHSAGqqmPwZg6ZA9v3FoI0RGoDAgIHWbk5Flsiu4MCntqDIAENEuSukpCSHYmmwuxq3saoq0Bauhflxbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=fsgW4Ot8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nk1MACoW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="fsgW4Ot8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="nk1MACoW"
DKIM-Signature: a=rsa-sha256; b=fsgW4Ot8GMi6A1s05nw9g2jX+6+f2RcbXMgdzzeYWsu+iBHaUqbZttxltuOQ+B47rCVlgiOBsHPZ5qXFJx6GlkEYO30f1LPOQuWR1pahn/C6O6I2pXlNjj9QfadJUhKv+QFMFGcdQ385t84ZdqvTnzib2XKMp1/sW/VDlmh+yH0JYjFiI6EWXw6V8jyZmAqmSYZadWEjbAJp+1CAUwryizzkFp+ZeWdSD9RwouTQNBjHGjLjD936PffgzF8ElLAs0WXRIfpHWTFV/61dw4kpXgHbQpwiYZ6+QJbnLuvTUIY0nZI2IGnGHkPV1MZ8yx2/r/Dj4mpGjzbQhCJKC03Xig==; s=purelymail3; d=malon.dev; v=1; bh=QVc/qu49VZQ3EcrsE20osmvor+PH8vFT67wfZOIJcVo=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=nk1MACoWImKryKTLLUP4GKGfmA7+m4/gU13qq96SGduX6jQMhL9GZ4FvCIIoIQo2/23zhwvrCtD6/G04IgLYI+/jvjHDXu66uj1dNImU0GJdNPPb76KQiT04DOJ4VBM2djXAO5khbEapY8b/k9yc1EqhsaMUCWBhUtqj8XPRAWDbx3V1TQNk2Ops9hpueBLNVrb0pucmmcmaIXHKE18nH6N6wcfPTtQACLtZzbXPJUFOdyz7e6hLupDuew/1XMQ6m5yIBWDp3VAPavBQWyA9w2SjUCNU9GBq5PtuI3iVjMW6zKJtFRFv6g7+0T67Wmyak5fkNjUzarbiWFveuaCp2Q==; s=purelymail3; d=purelymail.com; v=1; bh=QVc/qu49VZQ3EcrsE20osmvor+PH8vFT67wfZOIJcVo=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -492045318;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Mar 2026 05:39:48 +0000 (UTC)
Message-ID: <9818e3ec-838a-4eef-8436-a395f2970d42@malon.dev>
Date: Mon, 23 Mar 2026 13:39:44 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] diff-highlight: fetch all config with one process
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Scott Baker <scott@perturb.org>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004856.GH3654226@coredump.intra.peff.net>
 <9d3633e4-6413-4932-a29d-e0347546ede8@malon.dev>
 <20260322204509.GA2047044@coredump.intra.peff.net>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260322204509.GA2047044@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 3/23/26 04:45, Jeff King wrote:

> I noticed it, too, but didn't have a better name (in fact they are of
> the same type, just two different contexts). Shadowing seemed less bad
> to me than using a mis-matched name.=20

Fair enough! Let's leave it as it is ;)

> The length() of undef is also undef (and documented in "perldoc -f
> length"). But either way, length($s) will be false, and we will return
> $default, not $s.
>=20
> I don't get any warning on perl 5.40.1. Are you seeing one on a
> different version?

It's mainly because I saw that you changed the required version earlier=EF=
=BC=9A

-require v5.26;
+require v5.008;

I clearly remember that in older versions of Perl, the length function=20
behaved differently than it does now.

=09use strict;
=09use warnings FATAL =3D> 'uninitialized';

=09my $x;
=09print "length =3D ", length($x), "\n";

In 5.8.8 the output is:

=09Use of uninitialized value in length at test.pl line 5.

And in 5.38.2 the output is:

=09Use of uninitialized value in print at test.pl line 5. length =3D
=09
In the first case, the code will throw an error and exit. Although I=20
haven't compiled this patch under version 5.8.8 yet, I suspect there=20
will be issues.
>=20
> -Peff

Regards, Yuchen

