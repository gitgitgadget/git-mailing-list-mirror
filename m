Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123266;
	b=TzHd8vJuA9kwjgukI4jfzDzjlQoLMsl/PKl1Kh+A+ObV/hPAsgTep/5SFeyCXWhqWQZy
	 KY8Z/vjD9+6o8jg66LLgGJxvbFudv6Iqm0AzqTJvn+ekEjiPcDEI7VTNHIob8Vdqx3aeB
	 SWXGotCK+77FKIVt943THgtTIyJpxnfk6OwFk09K58Z5gN2flZbt2HGThKE8JudT1rPvP
	 lKaPym97w62W+pBgh3vjx3yCPiMoWJ7nyx/ivYmLIRE1Y01TTq5f5Gs3wBTH0bHXmD26d
	 Ow8RTft3MMZzLg8oS97KXBOWkLMnZ8YeDssobVjdrvDacea1XFfrIjPY0CdStLN9GkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123266;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6Sn/NSI9IMwiHH4xuFYKEh04owI+rU17zBl7k3zkcHE=;
	b=nYI3hq2m6W0sC6VoxTE/xOdl02QAZmjf/dZxfxhSrbVKuK3sRzKp2IjodT8gK/8sfeFv
	 6q1+8qmAtAlJKtEAjmFw7cSRdXZC04uQeFE2SzvWyrPd3Mq44c3GYVIOD2j/z4nemskhh
	 oFN/5RsOsXflEkoBDIRwRkslvbqASJRyW/oyG79qzDWcf+fxuFuX3lcam3an2LCQQAsGp
	 iG6I+zKELdpOGGI6YBqqFauYp3+gtj4y9YPh9BO94k20M5qg08+iFXBwcVn+e6ZeojiLy
	 fHzDfGrm951i7JPY9RjoqFOzE1K4ik4RqXKAQAkyEfkjgujwOKaRb9Ox5FgosIbhPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=M7FaVQVS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="Ws9/rAEG";
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458A606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E458A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=M7FaVQVS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ws9/rAEG
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 44D041D0014A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:47:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 13:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793123264;
	 x=1793209664; bh=6Sn/NSI9IMwiHH4xuFYKEh04owI+rU17zBl7k3zkcHE=; b=
	M7FaVQVSHud4mTreO7If7FHSOtrrHLv7N+qg0FqNLLloRX+3/kkMCCA2DOezgHD/
	LUoo2ldKkOVirXO1Qr38WR4sS52/eH4yvVTgEFS9mBWk9ADph0ZkRmBz4P5erUSv
	q/CaAtjTs37qorBsM25Dbc/A1z36S6N1rJZB77XcJXTQf0eiLLXbR46x+npZziZ8
	zD5mjXyJw8wSaiCT4rtPAc1p4QQswje0UIEGk2tP5bY4quJ/IkNZudkHNq6ruBf4
	0R1BbGphZzPasL3h277zsE1Kgqi3IrchWW+mcZ6pqr4CgFp3Kp3njhZnENM8+jvw
	3SF/aiUslBanrgKf5gC7nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793123264; x=
	1793209664; bh=6Sn/NSI9IMwiHH4xuFYKEh04owI+rU17zBl7k3zkcHE=; b=W
	s9/rAEGpQjsU5iAj4dJ5TKlrYqVNydFMNXSQRVr5yMWMeIGLzmkExrcCTtim7AKY
	sJcjNKE5540nIGMxgWYEO9s/cjqrjedeO2EAS+wc27zcmhO6ypolYtct4Lr6AiJR
	rlby5ecA9S4sMl734sFBOwMILp+yGWZF+a+cpmZnJ6IGZoeUE9GcF9BuLur/RZ23
	Os8k1q6jQuxTg5sa6UVr+HX321QGSwAr/AcJSvXQ38hUw4uFe3aivaMDnN16lRJb
	chRq6VuEpsIBJghytoLmrHQwq+Ve4DQ1/aeCJW7UDbJkOQAZb3LKfETS/raTN9vd
	nhvLT9N/qZ053kzlQ2CaQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793123264; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:O4SBHPdkfJMBnmPfT833q24+ZsNO/qXpQ3kP16CgLoE/pBR
	jtFaEc9oJWao7mTEjkSQy8WDSOEX8MFqg4QlYx6xRUZlRSWAr9YebFP1x/HTKfvs
	eY7/dyAICKzcJs5uSL5XuqsJHVlrBUdpkLSZW07AlO5BP69hxkadHa+lU5ztZjpR
	WWyjLahpNJueqZQkvb3OokSpEmerVJXl4EOsj1B7Gx+yr9eMrHSjmS3LbdnZ9nvv
	kJQwWexqSNB3HAR4Yrd6TheqQAEmaxw4K3jXjGkkjorN+N7lGV0Sr2nXoBCWm5nO
	UH6bOIRGI7cBW0ZQ1AJ2B4TAGPhzv1TrZskVGbg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:cCFNT6d+MAkp37qtvLaWC0TVDhyyCllmgHYdwwCeAt0=:QEfhSTSP3WlKkvzEc8ju5BFLIKUQbWmDUH4xLtpnYbA=;
X-ME-Sender: <xms:wOPgaiLSU2zbZSWVustkUZZGKTnbQihyrQwjfmiXw-sBX--yJI_XbQ>
    <xme:wOPgat1FRJm7vEFzCV9u5Pd3-J8qcvLL_0h5zZ6j-iqFZSQvy7_4DN5xqIYG2V0Wj
    nrM29RQJNehX-7-A-hbs146hNAXGqkt1yohP3qAxlwlP9V5mTLJ-Q>
X-ME-Received: <xmr:wOPgasinVe8XliZacsOhP2MUz0Q6lc23NrKACdet1UtYPspwrNrdoSIm547Bj4De7p9jjIaSa_cJjbL4taxTV1qq44QFEgbl0J3f>
X-ME-Proxy-Cause: dmFkZTGfM88QaPWzf/d4YSmWCcRbo51DJDK3H+tBknW/eWAvCBUWHU6bLnu60dkYTN/0ml
    OBzkp+6WloOEmdDHMKJLgY+Px9YTNnFv2SmhXGgWMjBxPjin3/4ztxWWUtfkUHq8E27wJi
    dd2eEmilCQrUwzl8xHLfTN85O07jkqFqRM1FDs6xOn2n5Bqujf5LBO5k5QvucFV9iW61tg
    odhPTGRU3n7weETy5B2vsunfFwUYPufh7GgD3enq8LPt57xN4DTXQZFYUMUbY79jXzOfIE
    Dith80YEjvkSj1xaBkEyJy9IoskhKUGaLYggo6m51f1sHkvMU+xdvDm+BlFsc50pYRU6Y5
    hcZuQ14Oi8I/PagUWLikt9kOgXA55qt6WN+QhEUBfNTFpMDSRyxElXXM+EAbFGY+hOmQPv
    pmPc/j0rCfU7Ya/Bv5vqM2Vqm7sf9Euzt+nQuHmkdqXoLT9QVNWlVTjDTABND6OOK/zVKP
    KWx6ZOcss8sRl6mJzXM5OZjijuObb9KnXYnAun4Fata2y3U7OzALD+y/c6QMMdTBgdpmBk
    MbIIasXoyVtYgEf15smUlHY/3+fYHHtmNOp4bNkExaQzrv9Cg5azIQkdDr6M0hlj947Mn6
    ex2qJzqDQhllNclfk+xa7r7YlpmW2iArDOMn2/Ltu5QSTwEP+xhl99+uKHDg
X-ME-Proxy: <xmx:wOPgauWPg9yjnnI2zKtU1lUlmiA2sgxPK2V3mlk4a6KKt865g5yCOg>
    <xmx:wOPgarXR3br1gxuIKcqGUxjWehGxVvRuXWY5fZjk1-BQlzPgKOaY1Q>
    <xmx:wOPgaugG57KIotOAwGqoo3Pq-PdfdkeCv_Jul99wu8AP4B61Y6yOJw>
    <xmx:wOPgambXelhzOf6dK3T4lr7d1SeyNog2G_5MQgGfmW3Lo8-paaUXnA>
    <xmx:wOPgav4jxGxQdS-4io1UAhWNMSxF33RNLdlynnsJtfZbe2ESpEI-pcpC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 13:47:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
In-Reply-To: <E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com> (Ben Knoble's
	message of "Tue, 27 Oct 2026 08:15:42 -0400")
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
	<E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com>
Date: Tue, 27 Oct 2026 10:47:43 -0700
Message-ID: <xmqqh5i7kpc0.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> from gitrevisions.adoc:
>>   Here are various ways to spell object names.
>>   (lists <refname>, HEAD, etc)
>
> Perhaps « notation »
> would be the better word here, if one is needed.
>
> [Let me just use « 40 » as a magic number for the below,
> even though we know there might be other lengths.]
>
> I think Junio misunderstood your comment on this? Or perhaps
> the intent is overly-pedantic: « spell an object name » might
> mean « these things all represent the 40-digit object ID and
> are thus interchangeable », but I do think I find that interpretation confusing.

Think of a blob object, say a sequence of 6 bytes 'h', 'e', 'l',
'l', 'o', '\n'.  It is stored securely somewhere in Git's storage
system.  You can call it up whenever you need it.

But how do you call it up?  By specifying its name.  The name of
that blob is ce013625030ba8dba906f756967f9e9ca394464a in your SHA-1
repository, or 2cf8d83d9ee29543...b7e3f3a183d337639025de576db9ebb4
in your SHA-256 repository.  It is like a fruit is called orange in
one language while laranja in another language.  Different names in
repositories with different hashes, but in repositories with the
same hash, a name identifies the object uniquely.  We give names to
tree objects and commit objects in a similar way.  For example, a
commit object whose name is e83c5163316f89bfbde7d9ab23ca2e25604af290
is what everybody with a full clone of our project has.

Since it is so cumbersome to write an object name, we provide many
shorthand ways.  Perhaps e83c51633 may be a unique prefix among the
names of objects the repository knows about, in which case, you can
use that shorter hexadecimal string as if you are giving the full
object name.  Or a reference whose refname is 'refs/heads/main' may
record the object name of that commit, and you can use 'main' where
a command expects a commit object name.  Or that reference may be
recorded in HEAD (i.e., 'main' branch is checked out), and you can
say "HEAD".  Your HEAD may even record the commit's object name
directly (i.e., a detached HEAD that checks out the "Initial
revision of 'git', the information manager from hell").

In many (but not necessarily all) situations, refnames, branch
names, unique prefixes of object names, etc., can be used where
object names are expected to identify the object you want to name.

    Side note.  You cannot necessarily go in the other direction.
    When a command expects a branch name 'main', you cannot
    necessarily feed it the refname 'refs/heads/main' of the
    reference that is used to store the 'main' branch, or the object
    name that the reference 'refs/heads/main' records, and expect it
    to behave as if you gave 'main' to the command.

By the way, the story does not change if you forced people to use
"object identifier" instead of "object name".  If "Here are various
ways to spell object names" is wrong, then "Here are various ways to
spell object identifiers" is wrong in exactly the same way.  The
badness does not lie in "object <name|identifier>" in that sentence.
It is that the sentence does not say "Here are various things that
can be used in place of", and that is what needs to be corrected.

Long ago before we standardized on the phrase "object name", we had
mixture of phrases in our documentation and it was chaotic.  We
seemed to have big discussion about the terminology back then, and
with f1671ecbfa ([PATCH] Assorted changes to glossary, 2005-08-18),
we finally got it sorted out after having a firm description that
"object name" is the canonical word to use in the glossary, with all
other "identifier", "hash", and "SHA-1" as colloquial or historical
synonyms.

The patch rubbed it in the wrong way without appreciating the effort
that went into the current set of descriptions.  I would not be
surprised if there are pieces of documentation that use "hash" to
mean the name given to objects, either leftover from olden days or
newly written without paying close attention to what the official
terminology is (the recent "gitdatamodel" documentation also commits
this sin).  But I'd prefer to fix them to continue the effort
started at f1671ecbfa, not the other way around.

There may have been other discussions, but the discussion thread
that directly led to the said commit is:

https://lore.kernel.org/git/Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de/

