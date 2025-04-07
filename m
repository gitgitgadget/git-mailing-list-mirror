Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B421147C
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744061773; cv=pass; b=U4HfimSxelY24lyZhZeCl/B3x29Fmvp7M7sR67nn3QMwAYQU084UyDQB9SXJOv2rlSkh3DAdOr3DOm1e9RBiIq8izAYazvLAVUvsIzJ+gxx4T24VOmdCTZj2pNTwNOaPiu9C9fnmItqBVq/ac1LAAzMdmpMPOaUuY10aLItp2M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744061773; c=relaxed/simple;
	bh=ZaiAxUGVC+0b+N5mbeC3ET0aav8EDD5XsmOk3wcENSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw+dxTbYU+Wj3huV0I8/JPd0m1RPdMpcHK9o00reYArNdJbYGZggJZVkBiowEUr5DC4sAa7/a8HMTCDuTA+mEyTYXXwyKO3uhDLHoYMhbvqMQHoaP5H6VALcAcoCFmEEqinV3knSyfdqLA98J49eZJYPQuDhQSjEwnI/poWD4YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=a7o31J+t; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="a7o31J+t"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8A2AF322802;
	Mon,  7 Apr 2025 21:36:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (100-99-62-49.trex-nlb.outbound.svc.cluster.local [100.99.62.49])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0908332243B;
	Mon,  7 Apr 2025 21:36:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744061765; a=rsa-sha256;
	cv=none;
	b=Jjf8EBN2vOob5LY9qtSHt66oJO+OhRYs4joklVwmo/Vuq5DMGJ70pOoa8Npt6D6UuPazFj
	uO+s7ZJy7t2hb6PVozHGytvO5sylXmuAcQIw6dR0IlK9vl11B+GMxeJLNV9cCzEnO3d16+
	F/G9VDltHAaFEhut/lRavKgb5TtHAUkKD7cdUWUbZ0yuU0USFnHOCjcfXhhZzOYFwT8E1Z
	KU0xEH8GZ6fmvdNmtUxJiB/sqV8T8+LRJY45zt+RkstmbIh8/D+HrZx/ZpNTSkvnK/M6mb
	y8FAoJuAQWB6xwZ9C1LCLqqPlQrhIDhEmhVD+Di8VlNS1G68jNVFkM5GoIBvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744061765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7A+Rmcq8ELmPucOcwB2f1T4MIYKD23h8xd9Eq7GEgEs=;
	b=GOLl3Mxgwexlef5VcdEGvXOty7v7a8WfRlu4sMSV4vgUlIjdoY2EZfvYDMFYxr9PhkvYwW
	udySU0E7nuxIzIXZGuG4VPQDHhPVIVAgK7J6Xx/k11T/lG3OLowO7s2OgP6fUvH2w9bryl
	Ela+NbEMqahvFaZHVNEh7o5XnxNzCOkN4vhaNG6dc2MUZPQLa7mnvcCPVDt0m0DqaDYPfB
	JLhvWGuN+aA0GnonEcwPdLEVI4WkHPyoy1joyEzX2IZALm5sxFnTQWx77rqt4EPJapDIZt
	Qc1pOUVM6Dl8DlfCD73UKbQoHJB23+i+KMQQ3JwmppLZpc+tFwy9hooPeGovoQ==
ARC-Authentication-Results: i=1;
	rspamd-6c88b8f79f-fqf6v;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Wide-Eyed: 37635f3948fe1861_1744061765358_3438809955
X-MC-Loop-Signature: 1744061765358:2686136348
X-MC-Ingress-Time: 1744061765358
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.62.49 (trex/7.0.3);
	Mon, 07 Apr 2025 21:36:05 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4ZWjFH5w5qz6f;
	Mon,  7 Apr 2025 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744061764;
	bh=7A+Rmcq8ELmPucOcwB2f1T4MIYKD23h8xd9Eq7GEgEs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=a7o31J+tdPadL2ne80XERNV4O3tyU6QoC4EFdgTyaSK7S2H1G7oXwsXCjXqifNiba
	 7VeKZTRzeXY0jUdcrEk3fGIA+4WBfnkm7wKv4nldc0Zt+/f5ozfv++VML6MZcohkpQ
	 NJPasixavx7MQYYaWId4sNn8uLj6XKaJJNpIG3vmiGQL2NJSncxpsdkNELB4ev0t7Q
	 JAxCLcgs7WuP6WYMFnvR0N9tFQLxeiHzzsxlXdeRfDpOPcaKJl8CbJEcHtrTkbzHUB
	 vffnb5gtTywxn0Hh1xQPYj+QAe/6HnALCv7nCGXaALkZZ65cUm23oOuZkqp29IDfXc
	 f+MJlqRmXv5pw==
Date: Mon, 7 Apr 2025 16:36:01 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z/RFQY433muaCW44@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4iyzn0vn.fsf@gitster.g>

On Mon, Apr 07, 2025 at 08:59:56PM +0000, Junio C Hamano wrote:
> I have more problems with the remaining 20% use case, where you need
> to deal with multiple commits.
> 
> Perhaps your initial changeset is a single commit C0 that is so
> large and does too many things at once, and reviewers would
> naturally advise you to split things up.  You'll come up with a
> series of commits, C1_0 and C1_1.  The net effect of applying these
> two patches may be the same as applying the original C0, but each of
> them is more cleanly separated to address one issue at a time, and
> the explanation given in the proposed log message more clearly
> describes the issue each of them addresses.  Now you gave a change ID
> to C0, and want to somehow relate C1_0 and C1_1 to the original C0.
> Which one gets the same change ID?  Earlier one?  The last one?
> Both gets the same change ID?
> 
> Or your initial changeset is a two-commit series, C0_0 and C0_1, but
> reviewers find that each one of them alone is not complete, and
> because the issue addressed by these two is small and isolated
> enough, you are advised to make them into a single commit C1.  Did
> you start with two change IDs for these two original commits?  If
> so, whose change ID the updated commit C1 inherit?  Or does C1 have
> two change IDs now?  Or did you start with a single change ID
> assigned to both of these two original commits?

This is why I suggested earlier that there need to be multiple change
IDs, not just one.  Perhaps one is a "code review ID" and another is
a "commit change ID".  The code review ID would let you link together
all commits that were reviewed together, so if you have to split or
squash commits they would all still have that one code review ID.  The
commit change ID would be shared by all sufficiently-similar versions of
a commit.  If a commit is dropped or split or squashed then its commit
ID might get dropped too, but the code review ID would stay the same.

I think that a code review ID is a lot saner to use as a ref, as in OP's
`git switch ...` example.  Though one might still want symbolic tag-like
names for individual commits in a set of related commits (e.g., for
forward- and back-ports), though I'm inclined to say that's not needed.

> Quite frankly, I think the concept of "change ID" is nice but it is
> not mechanically trustable.  Recording them in the trailers is fine,
> but I somehow feel that they have a clear-cut semantics everybody
> can agree on to deserve to be in the header part of commit objects.

I don't think they need to have such extremely detailed semantics in
order to be able to get a header.  The semantics will ultimately be
somewhat project-defined, typically something like "during code review
you can use these to related newer updates to an MR/PR/CR to older
versions" and "once integrated you can use these to find the approved
code review as follows [details]".  The [details] (probably a URI
template) for finding concluded CRs might vary.  The CR tool might vary.
The construction of the change IDs might vary.  The intent might not
vary at all.

Nico
-- 
