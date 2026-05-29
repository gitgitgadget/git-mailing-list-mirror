Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11F23394B
	for <git@vger.kernel.org>; Fri, 29 May 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059056; cv=none; b=LwpfedX97cELFMevn/cGP02pt5uDKxjTx5EWvlxGsqzzAIlJnBXFohPZ5BcZk3l+HYTN6N/AK9BkS7KM92JA9X6uNLpVomb+RANw5q6LU67qjTAQCijQ1pmNxaQTrbA3nGHv5v8F3cktfaM7pJgetJ1wsYEbyMr+O86y6s7kkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059056; c=relaxed/simple;
	bh=+mXnqfeGL+3eEW66xWygJeORB7IGFLjO57XE+8tSyUo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h9fh6pVzb7otOOBjvhSFh7rE5Tngu7k03lOQHp0WoWP4R9p/Ug2+TwIq273oelGximTLM3xEp4CQFvIOc0w2ER6xxfpWu2aUVhpNHbKqKUHfkLl3Q4O4HW9cmyEQ8vhBOH+trwPPRk9B3PldGFsyTVb9C+vYL83PsquOgq+X4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oHWngq7m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2PtPQY5; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oHWngq7m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2PtPQY5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E90F1D00151;
	Fri, 29 May 2026 08:50:53 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 29 May 2026 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780059053;
	 x=1780145453; bh=+mXnqfeGL+3eEW66xWygJeORB7IGFLjO57XE+8tSyUo=; b=
	oHWngq7m87eYbD6fdJ6O+rHrujIaiK8zMV+NQjvRsM+25xtFL1sFAFMpW/v1hJJs
	8ojEd/aBS19Y13hAW3BLUl+gQFyKdIYw4kPa1qYxyEa4BXokaM7RzMfoA6t3BGl5
	aWE0KHA7FcmtTvdeYQCd7W/I0Cf7aOyuF1pv2jY0nsAD1iiqfqPNpfyjY5MswFm2
	FrYUFrzug8B9yljDYiejtN+ziXWLP02xgjG6R7EQ8ERWOrS7bYnqZVTydELfpW49
	ZmSIp7xXe5UUNaoau4WXBQuItTvTcImxnJ4/s8h+EYLdMu23x20BTAvQyHxAjfU5
	otk6Att4GaOz74HIsXHyeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780059053; x=1780145453; bh=+
	mXnqfeGL+3eEW66xWygJeORB7IGFLjO57XE+8tSyUo=; b=T2PtPQY5GhpQ5UUDI
	HJSO78NgOl8zPY7rDjRRmgHKCwljP2kjJU2C8DeI1Ww1edW4g+JjjVBL+0876eKD
	riBIpZ/mbeRU2yDTxHo0x2Ot9ggO4Z+HHdIF/jr0nrcMZAMDHKv7psu1dElzfPlU
	6eovYJS7TN/sV/rWeNwky2gf7Nxk1YDZIgrbklBXj4Ww9kWhLUH8lWSfMDgwMZ/n
	rNWZQIPrpfRElC8dEXDqovxvZXc5Z47O5HSejz4VgfRzb6DTY7KRNLuHyN1hvyE8
	208LXYq5t93RM5C/+IfGsvrjbIgJoSuk8TOiQuH14j2SbvtpgEsdGW6GrzUrmrMS
	mazNg==
X-ME-Sender: <xms:rIsZasf_OQ6majYBt6I7xbguMGEP5b3JLSrkgHVoIyxPJULkbauKgGE>
    <xme:rIsZapCFgWO-1kKNkBNRqZ6AHxQpJ15Mws0ZOl27P84ZUiNvGFvDXMJaj-WBlS0v_
    v-SzaDjtFNVgFkd3glOeObgDr5KnnpS1Dvl50ZHRM9GGNTfdtw1f0c>
X-ME-Proxy-Cause: dmFkZTFbEkjOfFqLeOrNOywrzD5LOezsmks4pHiXBdaDNQpuuPySFhJ5fHWT7KmBD4D93+
    q3WGLakL+2kPWfndPxn2z9VpVUHBFzkhSNyM2lN7D2rEVl3Cl7NBpgwnoZ9rJThehQVht7
    +AFngwvImLBRrmbq22wvjAy0RrFrP5vbPe0Kaed90eAEYzxxJkc7p7XRsgnltC4yO2EmBp
    PjU/wBMAP8BLIS6XzQCmRsW+sv9MzF6n4yfbCJmOJRCHbiR+zshxLSnO45RFkdWR5ZKkB8
    NKS5zVMwuPEeX6f4k+Ug+kKSXCehcSvoGOmfiCaWYMSs0xV9MO4eJzvJoLR/Udg+nbj3KL
    /b7rnJRv5gU0OjqRtIYj3vKDybciWeUekc26v7pPIe0a3uEoieAJ81PsGZ/xsGCQd6jIpY
    hIofcl+J9WYd24sL1kc08Ya5phlSwRPNi4J6gWjLiy+JV4jdrXq3MmflUGZnFk6Tk55Grr
    Fm8zhG/7bwTQkihqmxA/t/zHHyPDVCQCS5395Rq67E4jm6P6b0GzHyAoKPviGS5AS+ycQC
    SGKfLS02t2beN44IIkQnFzkktuiZxBbOwlbpi780pcn8hYN9C5C06dvgxlq3z+9sduWJVj
    cBBhEfY9p+EyTtm0AfsbeC1uCBpMvxLB/MiRZK2IHP+Qr+Bu2yAcSDgnGbHg
X-ME-Proxy: <xmx:rIsZarLmL5LcNCjq6fAitdn5bBYOvnK6Dps_RVJ3AoNGF71duZYL0w>
    <xmx:rIsZatFum3cDo4esiRY8VDI-lTutK1mUYgm7CoVsny76ZZqG_BsQuQ>
    <xmx:rIsZarRyMOOMrKxiocytSZMBAxjA8Yi1XOI7pbg7rFEonvsGcpVMHA>
    <xmx:rIsZahF6NraIUPgoDL0k1z7wbux2jL5WK48JAGrpK6uPAKIZ8uECag>
    <xmx:rYsZah-k7YiyDmxtoaa6yNQFqIHv8qcLtWFXkRaSqc0CsW-EJA994-TA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA6FA3020073; Fri, 29 May 2026 08:50:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWtNUBR5tgCs
Date: Fri, 29 May 2026 14:50:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Luna Schwalbe" <dev@luna.gl>, git@vger.kernel.org
Message-Id: <a8e51dda-7b1d-426e-9af9-cf856c42342d@app.fastmail.com>
In-Reply-To: <fffe0ea9-baea-47cc-b354-5be4fff08983@luna.gl>
References: <fffe0ea9-baea-47cc-b354-5be4fff08983@luna.gl>
Subject: Re: [BUG] internal date format does not accept small unix timestamps
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 29, 2026, at 13:51, Luna Schwalbe wrote:
> While trying to create some test commits, I noticed the following issue:
>
> GIT_AUTHOR_DATE and GIT_COMMITTER_DATE should accept the "Git internal
> format" (displayed by git log with --date=raw), but this fails for small
> unix timestamps. A quick binary search indicates that it happens when
> the unix timestamp is below 100000000 (9 digits).
>
> So for example, GIT_AUTHOR_DATE='99999999 +0000' fails with "fatal:
> invalid date format", while GIT_AUTHOR_DATE='100000000 +0000' works as
> expected.
> It seems to be unaffected by the choice of timezone offset.
> Padding the timestamp with zeroes also does not change the behavior.
>
> The --date option does accept all the values, but interprets them
> wrongly and gives bogus results (most of them time it seems to act as if
> no date option was given, using the current system time, but with some
> inputs I've also observed things like "current date&time but set the
> year to 2000").
>
> I tested everything with git built from commit
> 2f8565e1d14d2de4cfbc9da0132131bf0d0dc087.

Apparently you need `@` in front for small Unix Epoch values. `@0 +0000`
