Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BED12AAFD
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720286306; cv=none; b=qDPkCUEiMf1D9eLRDkClGDXVOO0W09STerwNyNquWmzVrwWVljc4uBk0nL1uxOKmuYY41nQ9ZgwAjqofS1pIsnwrkiJFHiACqK9sxz3MWd4vMhtBJImN2qpUDh5R0TjvExCblj8co2lVo7t49Y5F5zmcooF28HVjrMqJUFLBP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720286306; c=relaxed/simple;
	bh=wUXPA+V37pPCahqhgnq/H9VszezFokn77s+FTjZqtJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XxERDQVJnl6yJbs0xdx4WhQo22RMX4DwWcERcMs0HZkY8uZsFbYHzgJBpo1riLfHNcGJk7bN0NATc/pM8HSyYmotTxYAm0cX2nsW8xC0lv1x0BVeWqoV22onYVTA6elQDB+etTeR332zHkN4CQGOfyF8rXuCzf6Vq4j/Bw8fD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gHq9E9wo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHq9E9wo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AA6A2ACA5;
	Sat,  6 Jul 2024 13:18:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wUXPA+V37pPCahqhgnq/H9VszezFokn77s+FTj
	ZqtJE=; b=gHq9E9wofek/DXZmuxJOhDNoOjwzV/2m9x0LQZNymqjO6RR7c8YVuG
	3o7QsPryND5NlK5R63AVEEbt3tonNDwksLrV5yHgtXQ4gxyc55+NhFuZQp3E8lLP
	yLJ6gtE9qP//Md2aTMqe7Lc1L+n8LMI67/90okwZttXZt+DebR40I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 023C32ACA4;
	Sat,  6 Jul 2024 13:18:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 837AB2ACA3;
	Sat,  6 Jul 2024 13:18:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/4] Additional FAQ entries
In-Reply-To: <20240706064758.GG700645@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 6 Jul 2024 02:47:58 -0400")
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
	<xmqqzfqx7muk.fsf@gitster.g>
	<ZocS0NgiAbg5Mnzp@tapette.crustytoothpaste.net>
	<20240706064758.GG700645@coredump.intra.peff.net>
Date: Sat, 06 Jul 2024 10:18:12 -0700
Message-ID: <xmqqjzhyqw17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA7EAD9A-3BBB-11EF-906C-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Jul 04, 2024 at 09:23:28PM +0000, brian m. carlson wrote:
>
>> > Buffering the entire thing will break because ...?  Deadlock?  Or is
>> > there anything more subtle going on?
>> 
>> When we use the smart HTTP protocol, the server sends keep-alive and
>> status messages as one of the data streams, which is important because
>> (a) the user is usually impatient and wants to know what's going on and
>> (b) it may take a long time to pack the data, especially for large
>> repositories, and sending no data may result in the connection being
>> dropped or the client being served a 500 by an intermediate layer.  We
>> know this does happen and I've seen reports of it.
>
> Additionally, I think for non-HTTP transports (think proxying ssh
> through socat or similar), buffering the v0 protocol is likely a total
> disaster. The fetch protocol assumes both sides spewing at each other in
> real time.

Yeah, beyond one "window" that a series of "have"s are allowed to be
in flight, no further "have"s are sent before seeing an "ack/nack"
response, so if you buffer too much, they can deadlock fairly easily.

> ... So I'm OK
> with just telling people "make sure your proxies aren't buffering" as a
> general rule, rather than trying to get into the nitty gritty of what is
> going to break and how.

Sounds fair.  Thanks.
