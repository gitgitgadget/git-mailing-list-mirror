Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383225;
	b=eRTRUBw8cpuwcMY843wOsw+ykHPo/m6tEBBE1IiSNVDORiKm86PE/nz8LGZB7tmX+jxP
	 kj83iA54Dgke3UmWIKsSIa7CwfEk4uYiaxVYUiNbgUeFh7cmC3Lub7WGZiy8C1lFTR+Bk
	 yXEl+T28lMOlfjUBPQQyRSKAZmGm6M0REwvFO6NIlorWbWAam079UB6SHaMsa/mqDcz7z
	 HKfcypqWDGIyplmZM/YQr403CMesfVWuErHeO4Mi/zOx71T1m4zHMO3a6FvWpF2kJ+bCq
	 mvX/9QARzHD6jXXt4OHDKFlXEl3qzRCmbtz+fAIx4NTnsjwu3CbYxadggL6YseosFBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383225;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UqDa9Vbo5Nz+ODFTEpCyeejM6hPIjSLV0p9VI5lhcj8=;
	b=UuAsWYhpDQUmLZQ4qfb9SG7r/Hx18AJd6YRYwWBTpRQ0yegAV/RLckzwkZxsxQjQhv+G
	 DVdCTX1HzCfQL0ePO95ZGuhLyklJj/48LS3llrl4kXmhKstn1BVMpNszASH7pdF1KHMEx
	 1hItGPioqYVM6f58g+v9oQf2Lfv+B1iuMnQftIKMomVelLdR/bu68dttmD8hSl5iqnsK3
	 VV4gVgyupPyY/isVhiqR40d9UKOMMkQIGYsAtdraZGQzTWWt+tKEnG0Js5hou8IMZeBSV
	 6VYCYmhGr8KcfbKomLCu3jmBgN5XCpAzRXYM7x12r6wbKKxw+/VMtSg57NfUHVFS8pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=cX2ssOZ3;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422760A2609
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6422760A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=cX2ssOZ3
Received: (qmail 49199 invoked by uid 106); 30 Oct 2026 18:00:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ipGRbs8gZeJIqV5pFiIhjeyjFfR9s3/wPINf8OAlqKU=; b=cX2ssOZ3fXgscEWT/zBnMUybqJN6RYMb1IUYpotLhWbosaCJIZhPpofKlqSxI9/rbjW5l30I/Q4KMrvlFmYYiR7aeArr2+9HRoAMa25T76V6X3msRJrqeUIZbwxp6T4kvLdMfiw4Yndk/beZyd0cKXCAXHwUVR8/f/ui6fLk/oivasx+2prZPA67d4uWaaqPmq2bCqQkYbLT1cNq5uvZ5Ak2wra0GseDBlM9/fC5yOE8dfHsJKddyAdxmdb1vuPXLW4xOyjNpusYwF3WkuZXsWK5VJvyz+SAcovUeHFG7YGZrNaAElhwUuXITLRtFyjsbb+sMLPdaP/bQyt85Xg8ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2026 18:00:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 323260 invoked by uid 111); 30 Oct 2026 18:00:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2026 14:00:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Oct 2026 14:00:16 -0400
From: Jeff King <peff@peff.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Patrick Steinhardt <ps@pks.im>, Tuomas Ahola <taahol@utu.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <20261030180016.GA7582@coredump.intra.peff.net>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <20261026011731.GA3575069@coredump.intra.peff.net>
 <at8IBMQZtJP3bQ9-@pks.im>
 <CAJoAoZnqzKv8ocsi1a-nC6LaRnpKKCO0Bxt-Pdn0dDUziEcpAg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZnqzKv8ocsi1a-nC6LaRnpKKCO0Bxt-Pdn0dDUziEcpAg@mail.gmail.com>

On Fri, Oct 30, 2026 at 09:50:41AM -0700, Emily Shaffer wrote:

> > That sounds very reasonable to me. Though I have to say that we
> > shouldn't only consider "the number of votes we'd want to deal with",
> > but also the shape of the voting population that we want to see.
> 
> I agree with this point - I don't think that the number of votes is
> particularly salient, because I assume that any of the vote platforms
> we would choose can handle a much larger audience than ~600 people. I
> think none of these solutions require us to manually email every voter
> or to manually count the results from each.

My thinking was less about the voting itself, but more about the
management around the "voter roll": maintaining who is on the list, how
we get in touch with them, how we authenticate their votes, and so on.
But if the system is just "this is the (possibly mailmapped) email under
which you contributed, and we sent an auth token to that email and you
got it", then that probably scales without human involvement.

> think it really depends. For example, I could think of a few previous
> very active contributors on the Git project who I would still want to
> collect opinions from even though they haven't been active in years.

Feels like Linus should probably get a vote. ;)

> I mentioned this in another thread as well, but for full transparency,
> I'm feeling a little bias here because I haven't had the capacity to
> make meaningful code contributions to the Git project in quite a few
> years now due to my role at Google. But I still consider myself a
> community member and would very much like to vote in this particular
> policy decision. On the other hand, if the eligibility rules we settle
> on mean I can't, I understand and accept that as well.

Yeah. I think for any metric it makes sense to look at the list and see
if it includes or excludes people you expect. A metric that excludes you
(for example) is an indication that it's flawed or incomplete.

The "X commits and active in the last Y years" one covers you, I think,
but probably excludes Linus (depending on the exact parameters).

At some point, though, I think there are are always going to be weird
exceptions and it is going to be hard to come up with an algorithmic
rule to get the right set. Perhaps there needs to be some human input
("we all agree this person is an important part of the community, even
though they do not technically meet the metrics"). If the metric gets us
99% of the way there, then that keeps the human scaling part down.

Of course that opens the can of worms of: how does the human part work.
Which humans? IMHO I would be comfortable with Junio or the PLC just
saying "these people also get a vote" (with probably a big initial list,
and then periodic updates).

-Peff
