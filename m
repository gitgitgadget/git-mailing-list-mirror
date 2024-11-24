Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B8EEA8
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732415126; cv=none; b=JvD2tpTv0I0E/PP1yWwr+lOjxWywmQ2ImtGtszzWXG7487Q32p+3Iy8qNrh59UVXo3T9eHBlzcNpHAqW8YHGIrwJtofxM7Ty9yu+USeHhMD0MVrxv94n2eznhrjLPmSbyHwuQq/ip2rU/Yko+U/dFOqY/ZwepduoyqOIY36Cy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732415126; c=relaxed/simple;
	bh=DidwPmj2fMvHo/TxkEPaX9aflo3OdxxG1B1sGy+hszk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbDgNLdEIZGGG4OGZzXhVqhIHENYA6pltlkqrg66TGmZLKN6VTmK+WbaXySRh2/nE5VV/6hp/9Sky9YJQCqRqJBhgnFUTz35RhY7fvYNR0lyhVxjdrOZ3k8gAwgzorZS+QdxcsU9Gqg4HCdlF9bxo4uKghH6jZVXEYFFKS7IJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kg7ws4V2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kg7ws4V2"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 08DDD13801CD;
	Sat, 23 Nov 2024 21:25:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sat, 23 Nov 2024 21:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732415123; x=
	1732501523; bh=xS8wrPH0tYeDdccwwUVW6CnQI2ys5RTJJMcRrZUwUWM=; b=k
	g7ws4V2R6btPps4L5NxgUyF+VFSe9BkPhsskcVa9AZO7gjILbKNFJ1VMpIpc96zo
	ULJmv8QhT3tkNTaMpgMtZZj7kNeLViKlwo/BKh7pSyixR9h10CstzgbCQGVLoBCR
	K+daIUi+8pF1UcBT4DUmlPBEDLH11/5jgI4mUB6GA4Sqlw3NzllHpIxshztxx/Br
	X6U3oSNgqKCLvhVe/vvGGAq+2LlnqXKTK+bc2Ly0TC1oljRY96/O393dasmBoTyK
	B9L+veAOySn7UGALN3tc0lzx+o94hRNcwlYl6Z5dprAM5Qkse4aMGE/6xKR3hAYp
	MskP7m6SdetpDL3OfITcw==
X-ME-Sender: <xms:ko5CZ_pwfPnGI0K2KK4BzoTbbI3ozH0hQgp_4AuD_Vgwqmnpu5_fPA>
    <xme:ko5CZ5rS6kH-_rLE9xNMKAwiA8aQHcAOuDaLHoFzUCNZdnOn73lg6bm4ZCj2Gl4jP
    UfOVFT8pjDPU-C2Hg>
X-ME-Received: <xmr:ko5CZ8NfirOS5msZ6wLdvia40zDbOGj-4J-YVUYeKFUTchv93snvy6afS8GaHDo2EUj9H3JsoyjpLRXQraDtlmYTPiCZfK1_CyRgvNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgedvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    gfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehg
    ihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftd
    ekfeeuveelgfelteeiueffffekhffgkeevheekhffgteejhfffgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ko5CZy5km2p2Tn4gpICKzTAGWgmdf5m9Zmrk-bamxXv3FWUsi67CEg>
    <xmx:ko5CZ-6_1nqT19lnrd0SVHBgswj_6Lub9wO1kShLnyttbLLYJr7nNQ>
    <xmx:ko5CZ6goLhKlrdoCZefwh8Hir_2eEtG-TAx-5ncyohivSQ0k58uG2g>
    <xmx:ko5CZw7Rq9PXu9rbEFNVJ6hPsJlPtZjzyYekM275LbP6rUFgbLi-dw>
    <xmx:k45CZ-GcFIMP78IQ38JXlkdo95vpDPMprS3vYygFGUmyS0_1yTfv5i7s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Nov 2024 21:25:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Extending whitespace checks
Date: Sun, 24 Nov 2024 11:25:21 +0900
Message-ID: <xmqqbjy5bc6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We have, via the attributes subsystem, a way to choose from a set of
predefined whitespace rules so that "git diff" can notice that you
are adding trailing whitespaces to your newly written lines, or you
are indenting a newly introduced line in a Python script with a HT.
This can be used, for example, in pre-commit hook to reject an
attempt to introduce whitespace-damaging changes to the codebase.

Which is great.

I am wondering what we can do to add a different kind of checks to
help file types with fixed format by extending the same mechanism,
or the checks I have in mind are too different from the whitespace
checks and shoehorning it into the existing mechanism does not make
sense.  The particular check I have an immediate need for is for a
filetype with lines, each has exactly 4 fields separated with HT in
between, so the check would ask "does each line have exactly 3 HT on
it?"  It would be extended to verify CSV files with fixed number of
fields (but the validator needs to be aware of the quoting rules for
comma in a value in fields).

I guess the best I could do (outside Git) is

 - write such a validator that can take one line of input and say
   "this line comforms to the rule".

 - add, via .gitattribute, my own attribute to allow me to mark
   the files that these rules apply.  Git does not do anything
   special for this attribute (remember, I said "outside Git").

 - in pre-commit hook, run "git diff ':(attr:myattr)'" to grab
   changes in these files with special formats, and have the
   line-by-line validator (above) check the new lines.

to make sure bad lines would not slip into the history, but it would
be really nice if I can trigger the check as part of "git diff --check",
which means it would be more ideal if we can do this "inside" Git.

Perhaps we could introduce a mechansim that allows me to do the
following:

 - An attribute, like whitespace=..., specifies what line-validation
   function to use to vet each new line introduced to a file with
   the attribute.

 - A line-validation function can be dynamically loaded/linked
   (here, we'd need ".gitattribute specifies the logical meaning,
   while .git/config and friends maps the 'logical meaning' to a
   specific implementation suitable for the platform" separation,
   similar to what we use for smudge/clean filters).  Perhaps this
   would be a good testbed for use of dll, written even in a foreign
   language like Rust?

 - In the diff machinery, where a '+' line is checked for whitespace
   anomalies in the existing code, add code to call the dynamically
   loaded line-validation function when applicable.

 - Profit?

Hmm?
