Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655432;
	b=EPONmgBOPgXFZep0w2gy70Ksfr/WLs7PBUIaEebu4gDJmUFr5wUaa/NKJ1ZeZyOxTyAO
	 D7bzhFPPzix37mPd4OHYnVihdH3tiyCfNN/SneIbFD7WFSVeJdhFgadH8LQvX+t8csMlz
	 Aebkdcwzuq8dNKmyPAaSLokxoIazbSDJvWsf8rj5b6Df13ZIl7WTsw+TQLdsoxXT0L7Ja
	 EHEp18DLyqQtPqjsbGCafCtpmT3Xgaix/LSCduCF09RPKEfIyhhtW8XQz9/L4MieyHH1/
	 qLZx5AtuZXSXFCLl19clv4q/JKzWmlCWD4j/uVFLE3okQET/iaLWqFEt0msl+eiOiOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655432;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=A8RFHVKGQo1HfEnKGv9M9+AAZZsE8zNvWrzDUprqC5s=;
	b=lnn+zYNOq/6Bx5frs0rPsMHcjrMaQ5j1pwOliPDURrDdCPHlEdJa3VDNI8IZ3Q1d8qZ8
	 EJ2x2y3yAeSqFhL9QUh10u64B2S6VcwQ1CRkAtOKEBl2A3lzf90oMT6MIdnHcK/25Kq/+
	 +MSXAqqlbmxwlI2IdNuoXyYHtC3tJkXZnvP3IMrsLIkf8r83AhOVugMX8kTpudbOtGXVz
	 RoSAyond2jM+BJtVyYv0V2QWwlO3NPdSQwCIhP54v8OCHdG4Uxr2IMR6Aw/YeXu8AdJrE
	 Pp2ABOzvH3kt8FA1smoQnEuRW8vi/Gt8ObIRNGDCzHPGa4vUgtCMNS4jFgZxIcVZ2ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=e5y9ZcFY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vb8XjdfF;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD168606A337
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 01:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD168606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=e5y9ZcFY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vb8XjdfF
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E01731D0046B
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:10:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 20:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795655430; x=1795741830; bh=A8RFHVKGQo
	1HfEnKGv9M9+AAZZsE8zNvWrzDUprqC5s=; b=e5y9ZcFYuaJlU5ejQnTAJgAYP+
	+BKsiSH5iZ2OcoJ5IsSbAcmt6UApZUs1hljhr8fy8nw+e5eg8Jgs+hU6GbVapy0d
	uKA9flG2qfwnN3ivXvC1rB2gQ8QHPNlEW3tDguXUs0J41u01i0CiQ6w2ugotp6Eh
	Ptr1sjdcDOvSQz5ZuVnpq9jkDljNs4EnjFX8V4L8JiAtSZutEBeIeHApE2Yn0OUL
	h4Rq4mYxxAaGLyBdCpdmB9J+3Ndb18n4nfBGvDcfl124uAHdwxrmTvJ97nkgmQdN
	NF5qrJo737OreJJbWCPgYaait1at+QaYPeu3tluTrFaYGsPZSuRiH745uwHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795655430; x=1795741830; bh=A8RFHVKGQo1HfEnKGv9M9+AAZZsE8zNvWrz
	DUprqC5s=; b=Vb8XjdfFJY9noyn8T+xriYQAvBid8lUbmUQMuvTogxN03tfyFY5
	jN4CEx5g/rgLCySSikoNiCYHwl3glQTWFBJ2hNBL5ZeDkOanl7rd1O5ddP7lwkG4
	xQ6iLkHi9nomzcBxIyexHYI3bUmrVxWAningvVw8KHym3TqLvie6agtFEUM6FRYc
	It9F/OrR64fHSOIpkvo0pVhH+xrbLdtghzTwwHTejCH+NP3IDrZLERqlrl2TmBrb
	REkrojnemMRqLJtD9NrLyFKq6vcy1kbL4fIxXaGXv4len4PKA/rEtXwMXwceBWEr
	KKieXuIh2HuevEvRY8wEtEvOwtXW6S/zogA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795655430; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Tbc91hCUcH3EeVrSL4OgrqFes+AqijyQO1e3uOooa43d1Du
	gBKbir4xVRgE1U2GBmHJcQOjC30MkeRqSqvmUk1RzaWuhyvTA8F9btbY93k8oEF0
	06JGawOMQvoebhWZqiMMubywEv0q+KWZiM457z0kKzinE9BCvhyvO4yhpfR0qDrM
	HXhjD1H2yAIbzuDf61cvetrRSK6l3266xcL5ChvhHkyvOu+0Jk3ygvJc2k68LWA3
	nsTomFZf7oiNrySm49j2WRjT+ulvRJkkM8z7RR5KdhoxqO/R+k+HxbW86NhsRQSz
	y0WjlkIG5C0vgU8e7bPZIRVJV5+y9tb1O9oW9lQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rY4tBNRcZQ4LUNmE7s+X3jFQFLWrptiTGYQd+w+L2ao=:vvHx6bNQ/qRq2ew/AQHLnFSrvLfmTDDLlGk/u/bhr7o=;
X-ME-Sender: <xms:BocHa2TcdowRwRAhcHPl9rX-oP69nuOaPgB2d1VXFNOXd5Yq4-1eYA>
    <xme:BocHayxv_N8HGwCiI0um7DissEfWSwPuOq1_8CxEkwALL5Dr7lwLp33e_71e4bk5h
    IvuzqpwdLmQ4nZD9yE4RL6afyNFa0DC9MtVtBT_fT1ThGveL1IR0WE>
X-ME-Received: <xmr:BocHa43r1jxH2ObTulLOQ4Yk9OfSZWQNWs3uhXqfpG8D1y6sbfa-BvTaLx6cXAhAdnZWErLe2_f4CzUDDO7s6kfe0wgddzy5nHUaUV0>
X-ME-Proxy-Cause: dmFkZTGfq9GOG2vbyy0rSmEltQ8SJhhdL6pNMEcBfFLScIZtdQTGHESWfT8tEVYLAhwPQR
    dvj7wqWgYfxSElxYMO9ZTuZzuctpsmKYIDvuZ4xC/Hl4Q0nbg/IDm5Kr5VFfB7poTxKcNu
    FW2AklzUmLAoq5vaSelNws8kWKXjuDqZeHmDIU9kt6iG8Z9qKAAuWFq2ae69LCpZRxc5pQ
    qgoPRQZXdqQAIbPo/70Kgm7gHDQX/2ah8ykxeNFBKfsN0prh/2G+iN7LcLAsOOFsdhyq+6
    Mg6+jeurFVlqE2Rh6tGjY3igxPzPY9tUzAswqEQTwAjg6vcPbk1S5DQmUC3JujEvefx2K5
    xRwWbh5C2E27R2VXpSsbRzU6o8PutkkIby429IFJ1KO4/KQeJdt2yxwZQDNYFD0HkT6Dms
    NL7vp/Khmfzsjh9ZAQGlhnW7hoDx2SpCF4ofvl2uyQcEf6DYIMV0SSs8vUkcO/qt1+c4dL
    TC2AHZhBn2YN7C0OKHdbt/b1efbL3OdYDO/N1HBNnBMuHGDE66YiF9E+WFt1N/hJEy6RCa
    rVrTkXkHPoXCblsvWtHfxfExfEluClVk21jPBwgGNJTU/SOAclLiqiv/n/mdsRJpLJRCrJ
    bXbJNUqgFxV3HnnlKF/RRfnr/SjzkYUk1u8fIzsbFTAvXYJA4kMUWxiOtHcw
X-ME-Proxy: <xmx:BocHaw4HP0StZC9eNG3XpJMWKbO-V-vrmAbbMpYr3FP8oMqwDJRJXQ>
    <xmx:BocHa7XKVQEaIknr7cGWXIefWYPZFFhO_-5w8a5GNtdpKkSGgz7VkQ>
    <xmx:BocHa_A6GMluL5dYCkKJIPhEpfp7CPirvA6E10ml_Pd-3DO7VYiwsA>
    <xmx:BocHa67Lb2EZL4V_7_A00VT0j49UU3WUGdRb1Vb9_-0KYnG0ppEBYA>
    <xmx:BocHa_3KZPEG06FM0pmE7x8EWzIb3bjP_R197A2PHGLw6yZo0iAXtpm0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 20:10:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alessio Attilio <attilio.alessio@protonmail.com>
Subject: Re: [PATCH v3] pack-objects: handle missing promisor objects
In-Reply-To: <pull.2333.v3.git.1795648282594.gitgitgadget@gmail.com> (Alessio
	Attilio via GitGitGadget's message of "Wed, 25 Nov 2026 23:11:22
	+0000")
References: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
	<pull.2333.v3.git.1795648282594.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 17:10:29 -0800
Message-ID: <xmqqpkvsv1mi.fsf@gitster.g>
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

"Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alessio Attilio <attilio.alessio@protonmail.com>
>
> Objects missing from a partial clone are expected to be absent.
> When checking whether an object is in a promisor pack, do not BUG()
> if its object info cannot be read. Such an object cannot be included
> in the pack, so skip it.
>
> Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly so the lookup does not
> trigger a lazy fetch.
>
> Test filtered --unshallow and --deepen fetches, as well as a subsequent
> fetch that repacks links to promisor commits with missing trees.
>
> Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
> ---
>     pack-objects: handle missing promisor objects
>     
>     Changes since v1:
>     
>      * Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly to avoid lazy fetching
>        during the lookup.
>      * Cover filtered --unshallow and --deepen fetches, and a later fetch
>        after unshallowing a filtered clone.

Here is what Documentation/SubmittingPatches::[[patch-flow]] says:

    It is often beneficial to allow some time for reviewers to provide
    feedback before sending a new version, rather than sending an updated
    series immediately after receiving a review. This helps collect broader
    input, gives reviewers in different time zones a fair chance to comment,
    and avoids unnecessary churn from many rapid iterations.  Waiting also
    encourages you to polish each version before sending it, so reviewers
    can focus on substantial issues rather than typos or other small
    mistakes.


It is not considered good manners to send a new iteration before
first finishing the discussion on the reviews you received on your
previous iteration.  You respond to reviews, saying "I will fix this
point", "I think this one is fine as-is because...", and so forth,
wait for responses to your response, and eventually come to an
agreement with those in the discussion, so both sides know what the
next iteration should look like before you start working on it.

Only after finishing all of that do you prepare and send a new
iteration.

Thanks.
