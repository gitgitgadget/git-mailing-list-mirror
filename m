Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD91CF95
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="anJWT2Bw"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423D10C6
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:29:40 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C45C03BBDF;
	Mon,  6 Nov 2023 18:29:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YC0hBLcSlWbpNJv3+QetDYKUkWDg4nLBECj1RI
	rQPgU=; b=anJWT2BwGsqc47dPhazZeH2jtInPoStaOHkU8FWHimXPGxTA8mk+lT
	2UOiQB4zi6w1h1khME1s5i/6JyO7odgwJkj48EgTxZvTcQSl39rMUTke/dKMs3yN
	mv9owVkclDLCdZWMmLO7Sx2ryGFK/yE6VvUb0fGYM04myqjTSymEU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BC86A3BBDE;
	Mon,  6 Nov 2023 18:29:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 542813BBDB;
	Mon,  6 Nov 2023 18:29:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Joanna Wang <jojwang@google.com>,  git@vger.kernel.org
Subject: Re: Bug: magic-less pathspecs that start with ":" not processed as
 expected.
In-Reply-To: <20231106173133.GC10414@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 6 Nov 2023 12:31:33 -0500")
References: <CAMmZTi-JJ6=Uw_+r50hKMYf34D0NtqXhaA=f+11+wAQBjqA7_g@mail.gmail.com>
	<20231106173133.GC10414@coredump.intra.peff.net>
Date: Tue, 07 Nov 2023 08:29:34 +0900
Message-ID: <xmqqfs1icvfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 591AEC2C-7CFC-11EE-90F1-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> PS It took me a while to figure out where we document pathspec syntax. I
>    wonder if a "gitpathspecs" manpage would make sense, like we have
>    "gitrevisions".

Yeah, I came to the same conclusion (should have saved time by
scanning the mailing list before I started writing my response) and
wondered where we wrote it down.  The description you found in the
glossary, as far as I recall, is the authoritative one and looks
readable, but I agree it is not as discoverable as it should be.

A simpler and more readable workaround than ":::file" is "./:file"
by the way ;-)

