Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513471;
	b=AqusriFcjj+eKfZOcNaKxXzEH6Lm0yI07sxYFzKnquhaCiwfki0/lhooOYhzW7Zu4ZCh
	 k0HrIpkS/iFS1DPLWmxQ98aUdf/2jZQA7TILt5V/AATkbsYGKVV9U+UIAdugnhunXBXJI
	 W7qjuOlLbmRhtqgGuAuFeBkFPBP9w/n5lD9Tc/6eTRCpM1ThjunqLJYqjJnNiRAXkJH4y
	 dZ5NBgYjDBZFP1QEiyyuhE7YoRs597wF2qKYUHpCX36jrQ3R/rQD4Wi6QYj1NfoSC02Ew
	 vKjSebMf7MRBzlHvdByEbMcVv5HilhkId0eKLgwkaUJZ7hXjfXj89HbBCiMLAp1Nx+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513471;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bUq9CcWCteIRcY14NIomW9pdtbaPHYzG1Lsh1qjfttM=;
	b=V9HpTPqrfeIIRBNXG7L4hwgYEvE6jF82g2WILDQsaYQxSl/xfI+t3Nojo938zhjhfTBZ
	 upuQLsBeeDaLKpvRGLM+nZxEFSKDh7Xlu4X/J0kTOnR82X7+rh5da7REhmw3xyyi+NBG9
	 82M8qny+bYlE8gFMiw2sFatr73oHZlaBv1ZK5igd+jgqZzeUbuijnkzrbBJp8nPzEQusJ
	 qL1NfHmO3yqp6z2lcMfLLH/Ltymx6gcVJZepFGWl8T5icprEJHKv3fkMA1fX4XAgXdT21
	 5hc5GtNlPg4+V3GZRhkZUF2vKACfCeSHteLAxeISPUQ/sos8zA1nSJ+mo0BpnXhZECg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=B+9QAhY+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qlV3V1GE;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00928606A31F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00928606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=B+9QAhY+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qlV3V1GE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 38C70EC0202
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:24:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792513470; x=1792599870; bh=bUq9CcWCte
	IRcY14NIomW9pdtbaPHYzG1Lsh1qjfttM=; b=B+9QAhY+AuJFyBx6bTXJEuVGp6
	KC+hIPrXMmzaRo5FCXdvf897uKG6iFvoODWJVJNuc3DOFru9ISsbcyXLf4NhiEX5
	sDq/kQyIsA2khwGQRqWzYdwC3/k0gcgQIg/8uhf42/bJl/+gqy3kiOJw4PoPNxnM
	HXyUvy37Nh6zLVdLA7EqIQNG3B2T2CKKLBag1qq1EZCzYjbA5DA32AHuP4XcfaTt
	ozJHY60On1Se0NKJxTC1f8Nip2RVjQHy/GDGCesRcuK+SX77/2bjaz1Z8hefNkFe
	bOfieeDtzxRXMdm1lIJVXSmZZqVIZny6YvtVOUGXDg1ekiNMlwHTkkyop0cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792513470; x=1792599870; bh=bUq9CcWCteIRcY14NIomW9pdtbaPHYzG1Ls
	h1qjfttM=; b=qlV3V1GE8kAUL+4u3CQ/DGcGCGdNZgZ0F+zODJOCuGJ4y/JFoGN
	Qe3I7omNmqPcCvO8Vsqroh/tlSMlzmzwsBkXU6ufd4VYUXPCYcrdAJDVKT076UJc
	MoSFga8O3/wNEMDhWXAYSm55zVoByikoMwaDKUgRfBOkXFOF+p1qbaYFBS0yLKs7
	JhLImVQEWhO075ISxCvoFhNz18zGWkgVyNE+4++a/ZS7mSIBFMDNCLg9xCrdPoaO
	J+k0MW9RDvwnJdix2zfcGP/oXigope76l/s5xN3uNFsK7UZWu2prZtVvcbSE8xIF
	iGmIyGL4J6AVpstRvMDioBu/0g6icfvcknw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792513470; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NVRl7TANlojpHM8YinYS8MleXUoYZ75gVGPR+Q4BzE7WrUI
	40qeSvkVNPzC4kEYlmZnCAvfECnXIFfr5oOUsgPhKwIlEXsDeG8NVZT1DNd2re5/
	mAQagtwbEsBnP51jmUPjnq4FnlzOjLBJu9snfHM299J7uBZ1QnD53N3Jcs/D+jF5
	87kMBDF260rNGZyewJqb41eoxdeh5azvMpuqQMaCwRB07Qq+2wbr00d3aWquiUob
	xhEmelSkC9c8DBqXfDCaTLlK/mgthvxMcIk0knfJl6oLCnPa/3QB4w/W/DMXgjgk
	yv84whVnonBHrPMEtUlPs1U1e24IrgtdjdCTzNw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:82QePMlkODRBDfeDG26r7i45duY6B8GhL0xQ/+dE0Rs=:n2eVcpgt3ElVACsT194IJV2CP3G8yItJFHXDTYrPIkQ=;
X-ME-Sender: <xms:vZXXamNdK7fOusY7YMCFkDFnw_TVrMYzTgl2NqlFcflv8O9yS_oNyA>
    <xme:vZXXalojUXN0RkRAJOP_NiSI5ziH_MtVFesnRrLL6i_N7KBaW4BZp69ilYEOSoLmG
    EORb2swwysBNVfN3yPt2hPXlLIksl5feVlXwJ51AaAanBlblynD-Q>
X-ME-Received: <xmr:vZXXare9--lY0ha4JGv0UuNr2YJKkSzdm6R22r5znVMBTKV19tBsng11VFqySjIkRLPlUpW5Bzo9Pk5AYKkm8vrF9-2egCKIYuAw>
X-ME-Proxy-Cause: dmFkZTEiPNYtkW2lVr3db64PPpJBse6ndoeuvdIjZpicWW7/9lr4Y4orcSq9yfQU0Quj0X
    ho0b3qMDIB5UZZ8mgz44DZxVsIOYgDI2ZvemgQJ5gSIs0FX3SAxNxPj7BIqko2xwK/F9BP
    kVUVXU9878IjHEfKE6WOS9j6vSzk0n4wR/JPt7jP+V0EUyfAiSN5/sPArjIg+4Xbu4D+r0
    58hqhX0gwBJcj17tjix2/HbGR2Hqkn+WzvLQuN4SX+qCLknGgWTqENWEAIX2ppBFSmCqHd
    0N3318UqSVOrnsf3oHNUQPQhcnVjbylmIbXp11k6G9sJ7lEHdRJvx6k2yoJU2eJIO34kMo
    NyiydoH/OIi73fnqsQ2+FQuI3lkEZr/w5CG/6XeU6nKa0DgypCPmQ43198ZZDlYg+0srLA
    5eZ0QyRTSBvjG+bo/+XOcq6YOgnw5s38o412ZP1HykFCk6lsHPN4O4tzXluXj4shC1CH0T
    mfLuqujciqvva5qHs0PRQsDPXuANVWXhrrKHfW0YGRnCKi3ENDGNsoE7QDGaK6G3SdnJKC
    ogy4wloxgn68QJTEbxDOuRPY24SWoXMn34udm6q9GyUohZa+29vmKipE/TWmfntPIm+55K
    px2vb24SAmufbFL1lBBlNr7d03LbX/mYQS8g1WGRdQZmad9wUIOYzFoPeflQ
X-ME-Proxy: <xmx:vZXXarSQo7US00yJOhK35z1eWxSDJ9fAcFd8bxsrHT1sMbml_y11VA>
    <xmx:vZXXakawcDyW2ljJGCklE1dWbrF4N5YzojwHPDyZ4rxn2aHuD55Ypg>
    <xmx:vZXXaufsSr21Sbfq-uDN_f35iOySSv4PgEV5fqbj-0SSkfkCFoh9XQ>
    <xmx:vZXXalImPzSX032u1unHKcsfTKgKuls4Cg7rJGX0K_DLNRnjaFbn-A>
    <xmx:vpXXapqHH6ni18YEGeMZAnB_OCJYvVMDZwK8hUPNQ3Vue-wrmQpxOM3J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 12:24:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Li Chen
 <me@linux.beauty>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: git-rebase: update incompatible options
In-Reply-To: <20261020150923.5595-1-omri.sarig13@gmail.com> (Omri Sarig's
	message of "Tue, 20 Oct 2026 17:09:23 +0200")
References: <20261020150923.5595-1-omri.sarig13@gmail.com>
Date: Tue, 20 Oct 2026 09:24:28 -0700
Message-ID: <xmqqjyncxrur.fsf@gitster.g>
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

Omri Sarig <omri.sarig13@gmail.com> writes:

> Several options in the rebase man page link to the "INCOMPATIBLE
> OPTIONS" section when the option is no-longer incompatible with any
> other option.

There are several options listed in the section, but only two of
them are "no longer incompatible".  So either:

    Several options in the rebase manual page link to the
    "INCOMPATIBLE OPTIONS" section, but a few of them are no longer
    incompatible with any other option.

or:

    A few options in the rebase manual page link to the
    "INCOMPATIBLE OPTIONS" section, but they are no longer
    incompatible with any other option.



> - Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
>   incompatible opts, 2023-01-25) removed "--allow-empty-message" from
>   the INCOMPATIBLE OPTIONS section, but did not remove the link to that
>   section from the option description.
> - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>   2021-09-07) removed the `--preserve-merges` option from rebase, which
>   removes all incompatbiilty references to `--ignore-date,
>   --reset-author-date` and `--signoff`.

After seeing the explanation for the above two options ...

> Additionally, `--onto` doesn't link to the INCOMPATIBLE OPTIONS section, even
> though it is incompatible with `--keep-base`.

... readers would naturally want to know when this happened.  It
seems that when the '--keep-base' option was introduced at
414d924beb (rebase: teach rebase --keep-base, 2019-08-27), the
description for '--keep-base' had the "see incompatible options
below" but the one for '--onto' was not updated, and the manual
stayed that way ever since.

> Update the description of these option, to have correct references to
> the INCOMPATIBLE OPTIONS section.

"these option" -> "these options".

Also, notice the commonality across these three commits?  They all
predate the latest tagged release Git 2.56, so as a fix, a change
like this should be prepared to be applicable to the maintenance
track for that release.  When queuing the last round (v2), I wiggled
the patch to apply on v2.56.0 while running "git am -3", but perhaps
it would be simpler if you prepared your patch on v2.56.0 on your
end?

FYI, here is what I queued for v2.


diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..b84b14f02e 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -217,6 +217,8 @@ OPTIONS
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
++
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
 
@@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 -m::
 --merge::
@@ -487,15 +487,11 @@ applying (in terms of the author date).
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
