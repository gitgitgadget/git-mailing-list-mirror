Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA392F2D
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503405; cv=none; b=LdHAavIbPFXtQMY/6jxdKxxOOWPoyddMdENn+jl6EfvYcIW6vlvNRIv4J9uE8DoVFf93cyYRzw5Gjar8pb2ht2UgY1GgZl19ft4h9RfRjzIcPpTYsdAq340pkwFLgaeZgLSoSG+UTYkGKRz4xUxzwv1qNseIb9gOpuEDDQxAY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503405; c=relaxed/simple;
	bh=z+BGGYKhOcXfywcV4dfHWD8Dmur3v77FwqAkc/yWR3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNIz6puWWKpCvT2wZpHmENszBHOKoGxCcIsWvwGnGopklQg2nC9sJNt3GFm2W/vKGSoi84Pg31j3qWeJ+yrj71k4nxDCW3p73zZfSpgeVqcpzVrna7idRI4mCMPJaOEzRdsKPNem8uCk2fIq7zzNgQ3bgRT+ARVp/jN2lvfX9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2sFfW21f; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2sFfW21f"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E779A2540166;
	Sun, 24 Nov 2024 21:56:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 24 Nov 2024 21:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732503401; x=1732589801; bh=wjEFsBKxV/89jJQVxbcGY808v7rhtWlTptF
	CNpofTsM=; b=2sFfW21fycapZ2owhwKjWVhduuolFnaNeD14gmMHIgmW0Htk3Km
	tIYQub9VtvaqzsOxHjRIuSD18K2UmPSYQ9diiCp2GXUqrYTOqoh6DwwO8VoWlfFw
	nHGn42nKvF8aYASpEu/1kLRTAjP0BBxHxg1ZWnDRnWbLp90i/xMtgGg8LQvIk/h7
	02hQMVQO+RADpEYpWZxA0olURvvr1Pziq6lCUVOUgq7pmp390S61jYlkM3y7i2UI
	zPAdkyDL/TO99kjsqpBgclD8NQCJxXWuoDkpDfmuqqywyv5eZcLJTx1zh/VXEq+f
	AXG4yCYoZratpe9iscb1Ukjrq/8uxFByTUw==
X-ME-Sender: <xms:aedDZ-ZCT30_PX5-WhOTls3lfBYyBQ1bhDjX5FSa56ZDSJBgJ_w7mQ>
    <xme:aedDZxY82Pj9gmAtR7yq9ATFvIoBoP6R-TFTogQ7gVz9RT3re4sL59ZpDJWEQ1I4W
    t4gNtETNN4KV6D_Uw>
X-ME-Received: <xmr:aedDZ4-xtanyXsGXROnQDvsk1bQuN2dmvtTPhV8FEb3k0PStDYU_righpmKIJb9Gb-YPE7l-Wuwm7MRbhtrz9uKXb5Bask-d_nqR5LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeivdetvefgudetleeifedufeehffdtteevveej
    vddvtdejtdefheefvedtteehffenucffohhmrghinheprghstghiihhnvghmrgdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhsrdhrseifvggsrd
    guvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aedDZwqAmnZMc0YWTMmrxZx4cllt-uQYaLbd6m-UqwG-imKjJvhU1w>
    <xmx:aedDZ5pETUAjjdfOy5XgWfP5G6vlI8vS_b30a2DI05L5ceBR6PmEZA>
    <xmx:aedDZ-QtZxfCb0i6EHVDKIhej4a2K9TfOr7Fiwj5qPUMRl8CnU0Chw>
    <xmx:aedDZ5rz9iI1-Ghpc0OdY6lmz-OF6-amcC7l_aFetooR4cfiqqB98w>
    <xmx:aedDZ0231zNgLkhJAD81u703VaW_ClakklF90Snh9Ao-edLLP4c2jAKs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 21:56:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: "karthik nayak" <karthik.188@gmail.com>,  <git@vger.kernel.org>,
  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>,  "Taylor Blau"
 <me@ttaylorr.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
In-Reply-To: <D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com> (Bence Ferdinandy's
	message of "Fri, 22 Nov 2024 13:23:30 +0100")
References: <20241118151755.756265-1-bence@ferdinandy.com>
	<20241121225757.3877852-1-bence@ferdinandy.com>
	<20241121225757.3877852-4-bence@ferdinandy.com>
	<CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
	<D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
	<CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
	<D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com>
Date: Mon, 25 Nov 2024 11:56:39 +0900
Message-ID: <xmqqwmgs6mxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

>> At the least you should see `git log`'s output, but if there are issues
>> they should be shown inline. So when you say 'no output' do you mean you
>> see absolutely no output?
>
> Absolutely no output:
> 	https://asciinema.org/a/lsqp4e1bNst6cFWw9M2jX1IqC
>
> But I figured out why: the whitespace and the tabs were not mixed on the line,
> just across lines. As I read it, that is not an error to have tabs on one line
> and spaces on the next.

Our .gitattribute starts like so:

    * whitespace=!indent,trail,space
    *.[ch] whitespace=indent,trail,space diff=cpp

so, unless otherwise specified, we frown upon trailing whitespace
and space before tab and indenting with non tab is permitted, but C
source and header files have further care about "indent" (short for
"indent-with-non-tab".

So mixed or not, if you indented with spaces and not tabs, that
would be noticed.

> Anyhow that should be now cleared up, thanks. Gotta say, I was expecting to
> learn about internals doing this, but I also ended up picking up a couple of
> usage things as well, like --range-diff for format patch and such.

I usually have "--whitespace=fix" so if you did "git log" on the
commits I made out of your patches, it is not surprising if your
"log --check" was silent.

I re-applied your v14 with "git am -s --whitespace=nowarn" and here
is what I saw.

commit 75a6a3e6597d5f3959eb269122e8c5f4e4baac0e
Author: Bence Ferdinandy <bence@ferdinandy.com>
Date:   Thu Nov 21 23:55:03 2024 +0100

    refs: standardize output of refs_read_symbolic_ref
    
    When the symbolic reference we want to read with refs_read_symbolic_ref
    is actually not a symbolic reference, the files and the reftable
    backends return different values (1 and -1 respectively). Standardize
    the returned values so that 0 is success, -1 is a generic error and -2
    is that the reference was actually non-symbolic.
    
    Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

refs/reftable-backend.c:833: indent with spaces.
+        if (ret)
refs/reftable-backend.c:834: indent with spaces.
+                ret = -1;
refs/reftable-backend.c:835: indent with spaces.
+        else if (ref.value_type == REFTABLE_REF_SYMREF)
refs/reftable-backend.c:837: indent with spaces.
+        else
refs/reftable-backend.c:838: indent with spaces.
+                ret = NOT_A_SYMREF;
