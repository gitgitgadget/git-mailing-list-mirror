Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6E25D1E6
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760654474; cv=none; b=nozsGxRoOOw1Nax3RPkDjYCstPadb9JwlxByYnkh+CUzzHZqLAfIdWHznPOj79/+ld9K3mhvazUNRlH9Gl3jHuR0IbX1OvgIZ1LgI0x6p59lvm5j4egUZKBbDMPoDt2MoqLeYzWJaY5OVh4xnB3Jx0Ln88K2ewDY0GssOvYRpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760654474; c=relaxed/simple;
	bh=mFXz57JLYGPbTJsA3g/C+6bWsivEKpM/jnL7b5W++7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACtIlHc78r+ILP0ebcWyhFq4PuC/hdtctWpbdq4PXP8kXFUffDeDMQWp/ea9Ifd8Oq/INRqRSbsMPK0SsyNHKNoFB6wfVHmAgoMRcsyZ/srA+Nq1pSXtC2mRyaZkMsb4EtE7BDipraoftwZ7Ul59tJCKfBQrMxCwND+zHN/agno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OXfNQJn6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OXfNQJn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760654464;
	bh=mFXz57JLYGPbTJsA3g/C+6bWsivEKpM/jnL7b5W++7A=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OXfNQJn6bKKn4ZLJFQUx4b34zAaI7u4vjaNtOLE3VHwdg6E/YFEwJF6r8y/qYUunW
	 MXsXd+AXWcHAgj7BTN2WHLJwIRh9YVEHJHzq1SLjfwCchlYPkW8K5gqSVp/6TFKxKe
	 3ULiLZrrQZUCcjPXRs0W8r6K900WA+qBVKD72d4X5lFvUFFptCivzsK038HLQ+04T7
	 rDPRY3FJmUrj5E/mB+Ootbavc10QVyzIMfW9ynKkNjaU3tNEzpogbPOwFU65AewA91
	 nt1dVs8T4REjjpnA0N9HxhiwbkmRTVeFMV5JF3JNKQY0uCBLhpfwwhNpo21Kl0WL04
	 wyDwekVKuChOu8DkgJNRfffxO5/krMIlhFhEEnpgJVyA0042wmj8BdzabB4Ca+TEi/
	 MzTv5T9e7nW9UFktobVKPWLf+mVJf4286dasJ783H/GZjwFy8OYQOHg0KrEl6Wtx1/
	 7nQQXd2iLplrEAsCYtfxl1tQWDR8HZpqJVwiuD72f8sBVSyHyr7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5c18:db3b:8800:f1b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0B512200BA;
	Thu, 16 Oct 2025 22:41:04 +0000 (UTC)
Date: Thu, 16 Oct 2025 22:41:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] builtin/am.c: add a message-id commit header
Message-ID: <aPF0fmxsPQvxHfCu@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	git@vger.kernel.org
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
 <20251016185758.21996-3-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/WBwnJJ4HqKTXHnH"
Content-Disposition: inline
In-Reply-To: <20251016185758.21996-3-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/WBwnJJ4HqKTXHnH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-16 at 18:57:57, James Bottomley wrote:
> Now that mailinfo is updated to collect the message_id all the time,
> use this in do_commit to add a "message-id" extra header containing
> the message_id if it exists.  This means that git am will always
> record the message-id if it can be found in the commit.  It will still
> add it to the trailer if -m is specified, keeping the behaviour
> backwards compatible.

This has most of the same downsides as the change ID header.

Yes, Message-IDs have to be globally unique, but sometimes they're not
due to implementation bugs.  It also allows tracking of changes which
may be a problem for privacy reasons, especially when it's always
enabled.  It's also a side channel where people can exfiltrate
information (e.g., cryptographic keys) without much visibility.

In addition, it is not guaranteed that message IDs are suitable for
inclusion.  They may be missing, malformed, or contain unacceptable
content (profanities, discriminatory content, EICAR test virus,
etc.)[0][1]. Silently inserting them into every commit without user
intervention, especially without a corresponding fsck check, is not a
good idea. Commit messages, author lines, and committer lines are at
least reasonably visible to the person applying the patch, but many mail
clients don't show the message ID by default or at all.

[0] You may think this is not a problem, but someone will do these
things if they can, possibly in a major project, because people are
inventive at causing chaos and we need to provide them fewer easy ways
to do so.  People already intentionally sow discord by pushing commits
with timestamps beyond 2^63, or even under 2^63 but beyond the expected
lifespan of our solar system, which then causes havoc when languages
like Ruby try to parse and interpret them.
[1] For instance, one of my servers is named "castro" (as in the San
Francisco neigbourhood, the Castro), but people, upon hearing the name,
are usually horrified to think that I've named my server for the Cuban
leader.  That name has ended up in many, many message IDs over the
years, and I know of still other much less savoury hostnames people have
used which will also necessarily appear in message IDs.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/WBwnJJ4HqKTXHnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaPF0fQAKCRB8DEliiIei
gc7fAQCl2N81jR26ptcDIkwwkJLmWL8oI79RZOIBPPEFnzE49gEAs1APycOb+XHh
5poJbWL00HmTdPqSjsKFwOsA+Hqm4QY=
=PHlA
-----END PGP SIGNATURE-----

--/WBwnJJ4HqKTXHnH--
