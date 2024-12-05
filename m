Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26C21D5A0
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424330; cv=none; b=FPIQ7r9L2oC8NQPn1DRfBnFZD14xoHnC7cpJqki2jfgK5V0jJL9BUPLAnwa3oFiVfRrmk0Q5cEtet4pgcYxqiojLEpNR4DcyhUL0nitx8juuOSOgtkhMgEAtjArOJHD2FOpAmhiTXXUA1Ve7ptOFRcikzUH49nGYqwSD/WSrLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424330; c=relaxed/simple;
	bh=FoxdF9XzRkTsGJOFlWKTkQVjm+mKIlWsoKBBSdbypjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfPQy95DPoi+F1QFYEo+JfhwT0VTboOcl/MG5GfS9RHRnHWhrc3zDDQ4JejtoIfRjiQne8lQmIn/+dq+h8ue/7m38tuZnsP/T6SpV8NMmbsIyqgjSAlafWnNPODMA2yC8X/+BIqfq4g+0MtQ9aUKIr2IXt0r/T59fZSWfz14eAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=54LJZQ8R; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="54LJZQ8R"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 10A111381CFF;
	Thu,  5 Dec 2024 13:45:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Dec 2024 13:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733424327; x=1733510727; bh=SR44pG+ag8QrQj1O0W825Qv7BEeBhC6BZZv
	0lvLmQ/s=; b=54LJZQ8RtDFUnP6XH++aRYR/j3aZ9awv6jecXY/UuSZGDUnP58W
	GziV4diNZTBTr+HyDWK7MYOHM7xgmWvTmBYuInq5ejt9wrYT1KwNRV46sQVgefgN
	Z+DSUfV0jr7HJlE0ru/VpDil2qJzjQfIUFa/OyhNZIsiQTkmpD7+2g9GRyrrDDOd
	1O3AGN9W6rV08q2rsl1cOb0yJCthTei2ykP6IrFRdV+GWHOfr5O+rRftv1XhLGPU
	rwklgUh6zKOl0tnnmXQ8Fw+Gymltn+410PFZMATEjVaFBzIsLPdbynViNR3qmX1E
	jmjs0GHFU4wn50MVG4QTBMmR+9f4pwZYaiQ==
X-ME-Sender: <xms:xvRRZ3aVIFXb-MzucG3BjWRMa3UBVOaaqauaeBdbzmolojBCztRrPg>
    <xme:xvRRZ2bD5enO3b6Q9HCSMV0eFGy1SzVYNJPSjnxoNtFYnydHOjXXJtoZWt7Kx5oft
    1IGw7rWGDo0jA7P7g>
X-ME-Received: <xmr:xvRRZ58uypF7TZ06PJm0KVP5ipvc6Wx2vZyFmedp4yuI9bELLnNYR8BiKuHIZO_s6KVjG0qbw6rW5R334udCmrhkDMXJBkToKEDm4vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehs
    rghinhgrnhestggrlhgrmhhithihrdhinhgtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xvRRZ9ofcNr6d6dFvmdDg9bSgubZZCCtN4Kuuk4zogGSm_16LYYrhQ>
    <xmx:xvRRZyowl2PBluLEc3mgDaSHEexYUWle7H-eXcYzfX6pRTP_Fuo6lg>
    <xmx:xvRRZzTaQ5CKisiMf8xmf2pOkqpTKmxMbNlz2vqnnPEFOq8JB-tOaA>
    <xmx:xvRRZ6oxfBUxUn0vv9FPTf0bN_e3yYQCFw4G6pZEXjgqd1VTyv6pog>
    <xmx:x_RRZ_Cpnool1HlnIzdWkVdg2xbntZ2B1TcCxoIVfNVWypzn-ETeeJos>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 13:45:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Sainan <sainan@calamity.inc>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Some feedback on 'git clone create'
In-Reply-To: <6okfwtbgcve77xwjdqjnvsa4yigo5tymlsrypjgztbrmabjtrz@o7dfhaltih35>
	(Justin Tobler's message of "Thu, 5 Dec 2024 09:27:15 -0600")
References: <AfLIcOv4X1AxLOaODNS89HA-bMeI7bj0xUGsLD-6xmVAS_a_2xOzy2uX-wXxpNA7kCpKYudELCEKv73roW_-HTd83Fcz3FZ_yJQOswQHW48=@calamity.inc>
	<pgz37cgfssouykfqxvmjt6pc2lycta6tmyjkovsceqwibww4fw@424usnt3dlh2>
	<Z1Fma7OLPOkxRncd@pks.im>
	<6okfwtbgcve77xwjdqjnvsa4yigo5tymlsrypjgztbrmabjtrz@o7dfhaltih35>
Date: Fri, 06 Dec 2024 03:45:24 +0900
Message-ID: <xmqqttbi0y0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> When trying to unbundle an incremental bundle into a repository that
> lacks the prerequisite objects, Git fails. These prerequisite objects
> are also listed in the bundle header. Maybe it would be nice if we were
> able to create a shallow repository from this bundle.

The prerequisite objects are required for two reasons when unpacking
a bundle.  One is to ensure that the resulting history is complete,
as the central idea of bundle was to "freeze the over-the-wire data
transferred during a fetch" but it predates "shallow clone", which
allows a clone to be lacking history beyond certain point in the
topology.  The other is that the pack data stream recorded in a
bundle is allowed to be a "thin pack", with objects represented as a
delta against other objects that do not exist in the same pack---the
recipient is expected to supply these delta base objects to ensure
that these deltified objects can be reconstituted, which is where
the "prerequisite" comes from.

In order to allow creating a shallow clone out of a bundle when
using revision exclusions (see "git bundle --help"), we'd update the
bundle format to allow us to create a bundle using "thick pack",
which we do not currently do.  And more importantly, the recipient
must be able to identify such a "thick pack", as the data currently
defined, a bundle with "prerequisite" by definition is "thin" and
cannot be used to create a shallow clone out of.  Which means we'd
need an updated bundle file format.

> I'm not quite sure I follow. According to gitformat-bundle(5), we should
> see "obj-id SP refname LF" in the header. Inspecting the header of a
> bundle created from `git bundle create inc.bundle master~..master` also
> shows "refs/heads/master" in the header.

Yes, if there is one thing I regret in the way the bundle header was
designed and wish I could fix is to that we lack "HEAD" unless we
force to include it, and "git clone" out of a bundle sometimes fails
because of it (you can "git fetch" out of the bundle, naming the
refs you find in the bundle header instaed).

> It looks like when creating a bundle in `bundle.c:create_bundle()`, if
> the call to `write_bundle_refs()` returns a reference count of 0, git
> dies with the error seen. When a commit hash is used for the
> rev-list-arg, it is not able to determine a reference from it.

Yes.  It is not fundamental, though.  There are occasions where "git
fetch" that does not transfer any object data is still useful (e.g.,
when they create a new branch that points at a commit that already
is included in the history of another branch, you only need to learn
what that new ref is pointing at, but you already have all the
object data).  As the central idea of "bundle" is to freeze the data
that goes over the wire for a fetch (to allow you sneaker-net
instead of "git fetch"), a bundle that says "you are expected to
have the history reachable from these commits, now you be aware of
the fact that this and that ref points at this and that objects"
should be possible.  Such a bundle would have the prerequisite
section and the ref advertisement section, but there is no need for
any pack data.

