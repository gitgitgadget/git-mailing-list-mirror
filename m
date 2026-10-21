Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620421;
	b=2zPjsiV2w0qxvTwQ3k6jKyB3wZz2pdmZnIq2uF23uVcRUGePLTDs7bLJLWEv0EfXrNUM
	 zliF1U56Pz35gr0Vw/xBfmciMAHOSAsmp+F+qlk9+P4opZzd4T5Hzbld1YMg5a6HlpEVQ
	 fuCsW4z1ELVYaG+7FCEt7xKbB6g/Le5oRw7ZuCkIWbLCyKzvGIqJraA/JN+ZeNl3j2+9/
	 ztDqRYXgSQn0L5V4xrAuqlR+8y6A8YJKb/ybIOBaAoAm+kXXbsyWnsgCNxmXI58mE0rBp
	 m8PDLtmPjLLUih3vayxJKB10dQaafjtCofs16OiFNCbSqBsnpzRchfSa/H2hF4BxkcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620421;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cBJIam4y5Q/CTwyN+Z+UabcpF9kl4K35Glgdi6J8USw=;
	b=vGrU1QBGUOmlw/lDnIaaILX1D5EqFz1HciJY1LtWix64ccKsji33xFrpkq5Ws/wTiL4z
	 +lRSp/Esux7ctCwF6Ig1L8GgRQVnmfa9ps03CbVuWRYKU3Z4mzu0vVDUL7YZfAnkZp6mk
	 x/pmLkaR/DSbmFnaDUFSDCFzpBKuIti7OArkJjcgAWOoOInqtclUBdSTNZTjwzwlzicTn
	 R8b3lx2LN4o430AczcDc4dcPv4wseAU9yE8pMttcAuFiOAKQ55m8HhoQhjhQ8rWpF4HGf
	 BHCAsKmbR/KATN51fdBJ43XXXjUE9E+pu8/daPtnqRU+OS5JWpq1RbQgBK+GdKGPFGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZKn5Qu4q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IiHIbFrz;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A8606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D13A8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZKn5Qu4q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IiHIbFrz
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E3887A0106
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:07:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 18:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792620419; x=1792706819; bh=cBJIam4y5Q
	/CTwyN+Z+UabcpF9kl4K35Glgdi6J8USw=; b=ZKn5Qu4q8ZK4S+1za8DL7xghDS
	IA7EidkH/H8Tm+Kw5eoaLeHURxW2+2cjdiu3pyn2SXwYOrRBk7oN97xHMZD2QD0N
	/8avqW0DU1OEo08Y4j1aG/n9h9yeBPpfFCoKSzUmV24SYx8WkLN309DOI68jpIdi
	Zjnp8rju0M+1VoWciYi4ne3vjnUvSLoEiv9gCWemslZ0kcglS65qml7Kc3fihqWu
	x3DN5Vbp/zz9JxhnOZnpzcbjZwMMOb5liHTGUSWjekYxJVTcMxhW3n17PTjguC9U
	9HRTou/VZeRg848MugPVs6nqm3pBRDUCT0cSRTzws7e5UzdIMgXMqgUgd/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792620419; x=1792706819; bh=cBJIam4y5Q/CTwyN+Z+UabcpF9kl4K35Glg
	di6J8USw=; b=IiHIbFrzRmmyATMG5NsdKivzzjueGzowe4q+q0F92TCvvKCYEDn
	U9UfnrvWfU6oF0+v7LmaZoAmQ5KOxWACACBPX/tLeI/wYb1+ISa2M+njKvvVXsL8
	D8xtgoLYYMloi4ZiD+oze8MLyhqkQvaR94UC7djx4JyoRqMfARf6+GYS7GD7vMpF
	KXz/rnv/btjvztCmVgDqoArPaIB8E3ZOsHH1V8lHyuZ1GdXZD2FXdU3Sk6+v0WMZ
	0PaT6RA2BXXkjO5FA2kydMLsIykLO7Mt6Anhz1P4CN7qw/pKubVhxSEKnF0a5BIi
	zFLb0iFJ/5xIxTqFbccF3176KjiI9YlECIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792620419; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:f55Xoo1rT9/8c/yHTmkJ4kq5LhvNUdmPTA2wNExyuBtFqIP
	kZwjNjhtrNFVcoIpcUNYHDkJN5kSt9stK3ziGJPkNHlg5MHeEB8q4ojbBqV9N2RO
	52v1Hck1UWRkndrHgwdIN0beDTHSg5GdQJ682fW7iTBkCwFhWohRV/QF4F+gVUDL
	ujj/J7EztxkpXaCeBi0kenew7gECZqhdt6i27q4wfP4b/IiLTFkCJIByBUqHZhV0
	c4golBYXyK0onB1Otzt7+t5KjNxJHgKQi5IXuz6arGr38CxGSpnRJ7av5puBZM/9
	lCCYh8NZZrGJVf0jklPle6VaI/M9/d1fISwdr6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qUADBAlo30FJu+wIMBmgAYiQcWcvM0S8+1ZnfZbmAFQ=:SS7jS8lHXgfRqqGoSv4RPYia6gORa3XaBYIY6ZUldFg=;
X-ME-Sender: <xms:gzfZamXNq6YDSzdhdpRdy3rxDVHSe-hT5bjIG5UkncFLmpLtuuVa5g>
    <xme:gzfZaqApnfJWvKLGc__oVC1KMTpBYGw_-XfxvyLolUPZsWVZEsB0xF2PK5dtG8loQ
    BG6spSeo6TtsgyuN7d8ls0tqKEUTNDZqHgmkobOmlPm4JlrQpqw>
X-ME-Received: <xmr:gzfZanyBTtR97eBaKPB1m0IiM1zb-i5H4btftZD8p3F7iPk7jnZZyHIE2JWhkj3WnKppWGdr2bpTe0kxABg9bw3onNrgB4pLFAZR>
X-ME-Proxy-Cause: dmFkZTFbXOHPylcM7GcEGZTa/5ll+ZLVPqwU9NuRB6e+XKm7SXhVNrVRDoGEh+NKtQhP8S
    4QAuSXqPSNvtXwzvVXNYzeBmnwhFFZmJ1GZIxEM61rla198jNFIeY+5EU7eWikV9VL0o9L
    DpHM2/lwE8ziev5s16fR6CHZmbai1rwaXEYCYvwAOXwd5h97giIQFsrxzBM005pqroXkNK
    VoQmzFAcwQlCYcHreTRElT6slri2I2I9on8B9HA3cZqt3cN/6awfKchxLJ22tiaAaULmAT
    /4SJ9iTv3LrtbpISN3WtLIhy2ckCiv+qhBkcUpyYwbO0mwXTPICnSjvCqvzzGGm9GOhoTz
    HzQKFK7K+N5eWRcbtGh1DIc5eTm4TkocpM1Ou/tO5Z32sU1VjHroabVBrsSE1bvdtJ3Eh7
    NVSgzPOgS2n3/L9WQhY1rjd/eV6cDVrJoQnm37Qe6PG4IQWXLiGyPwFnUMKonJ/4xI4j8J
    igRM0f72KDNY5z+rldBbutAblko7hZ4LKvAnYbu1/e8lrTsZayzvYF60S4wp4xhZCYanXH
    jzlZbDOtlDXVCEyd4rlOd/HuroerK0ycqjJ6CfNyY3qSNaveg/b89LOxJ2kxCrUVq/m7MW
    ST9E3fa6wMMWNr2xXW7SR8WiP2GihY6NCvJuA5Ua+GOPNNz7xSt3KBMjL9yw
X-ME-Proxy: <xmx:gzfZanAN3bzRKjC72qzyMoree6dn-6XWNd0Q-ZtPUyHAcbsV2WgutA>
    <xmx:gzfZakbU0vHDMnZ1HWI6mq4m0p-dXtP91E3ft39nf53clv0dWqdIeA>
    <xmx:gzfZavjGlNCX0KM_lvstF8dr_uN-_WD7kYNGWksJsgdj9zwD7CAVfg>
    <xmx:gzfZam6RjmSgJm5mFIjpDTLL9mdJz8eADUSAjDiIKzFyg3LgmfXfzA>
    <xmx:gzfZalv8I3NOSch_Kd71_LEOnUCgAc7Uf9L6zoXko5Igtco7c_DBBrI1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 18:06:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <20261021200341.378978-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Wed, 21 Oct 2026 13:03:41 -0700")
References: <20261021200341.378978-1-emilyshaffer@google.com>
Date: Wed, 21 Oct 2026 15:06:58 -0700
Message-ID: <xmqqfqxylnct.fsf@gitster.g>
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

Emily Shaffer <emilyshaffer@google.com> writes:

Emily Shaffer <emilyshaffer@google.com> writes:

> +Voting in the Git Project
> +=========================
> +
> +For the most part, technical concerns in Git should be resolved by community
> +consensus - either on the mailing list or in one of the annual-ish Contributor
> +Summits. Voting should be used as a last resort when the community really and
> +truly cannot come to a compromise on a policy decision. As such, the initiation
> +of a vote should be generally agreed on by the mailto:git@sfconservancy.org[Git
> +PLC] or primary maintainer.

Nicely described.  I particularly like that this prevents us from
putting technical decisions to a vote, reserving voting strictly for
policy decisions.


> +Phase 2: Voting window
> +----------------------
> +
> +The final version of each seconded proposal will be collected into a ballot at
> +the end of Phase 1. When the ballot is prepared, eligible voters will be able
> +to vote by mail for two weeks, to make space for contributors' individual
> +timezone and availability differences. During this time the proposals may no
> +longer be altered; the ballot should refer to a specific version of the
> +proposal (e.g. `[PROPOSAL v4] Require emojis in commit subjects`) and any later
> +version of the proposal will be ignored.

Or any earlier ones for that matter.  Perhaps there should be a way
to uniquely identify the version.  By the time the proposal is so
solidified, it is likely to be in my tree, so we can use the commit
object name that adds such a proposal document (or the blob ID).

Then we can tell people that

    $ git fetch https://git.kernel.org/pub/scm/git/git.git/ seen
    $ git cat-file blob $BLOB_OBJECT_NAME

would give them the exact thing they are voting on.

I presume that this can be used for multiple-choice votes easily,
and can be adjusted for a proposal with multiple things to vote on
independently (i.e., "allow emojis in commit titles?" and "require
CamelCase in commit titles?" can be asked at the same time and
voters can give answers to each question separately).


> +Votes will be decided using <mechanism TBD>.
> +
> +Phase 3: Implementation
> +-----------------------
> +
> +When the voting window ends, the winning proposal should be merged to `main`
> +without delay by the maintainer. The commit message should be appended to
> +include a link to the top of the voting discussion thread so that the
> +discussion can be revisited by history divers in the future, as well as a brief
> +summary of the result of the vote (% in favor out of total number of
> +proposals).

Do you mean "number of votes"?  Or are we envisioning that there
will be N competing proposals and we vote to find out which one is
the most favored?

> +Voting Eligibility
> +------------------
> +
> +Votes are welcome from contributors who have authored a commit which has been
> +merged to next, or who have provided 2 or more code reviews, and who have not
> +been banned from participation in the project. All eligible contributor votes
> +are weighed equally, regardless of the overall number of contributions they
> +have landed.

That is a fairly low bar to cross, especially the code review count,
as it will not be easy to define and enforce some rule that rejects
a response to a patch that only says "thanks, I like the feature
this proposes" without reading any parts of the message.  

As it is hard to track patches that as in 'next' a few release
cycles ago without graduating in the end and the authors of such a
patch should have the same voting power as those whose patch is in
'next' in the current cycle, I would suggest strongly against using
'next' as a yardstick.

I would have expected to see something like "two or more topics that
appear in any released versions" instead.  Note that I said "topics"
here and not "commits", so your topic that consists of 17-patch
still counts as one.

> +To prevent dogpiling, contributions are only eligible for a given vote if they
> +landed before the beginning of the voting process (the kickoff email mentioned
> +above). That is, the code reviews must have been sent or the patch must have
> +been accepted before the initial email is sent. The intention is to ensure the
> +mailing list isn't spammed with low-quality reviews during the voting process
> +solely to increase the number of eligible voters on one side of the issue.

Hopefully the "in released versions" criteria makes the above a
non-issue.
