Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A03C5558
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837787; cv=none; b=Cfb9vDAaHleqR7z+QmceB33M9//4VdT7Sv2j8wPbaE4d4x5rMG+mRGFNlH4RriIUNvr3ajLuvRxI8VxtLSc3C11N8An4nbY3Yvag69J1Q2KnmrXxlR2W+0FG9FqEk+Ly2zOJ++X/p9zgSu2CcAvbQRluqXr7lpjA6pqUxwWmz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837787; c=relaxed/simple;
	bh=6/DdGiwpzfbjVu+3T6ypqlIHuUcOAY7dQEEDNuGy7Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLwxMxtw6yMJvijKGvXmYs0D0a8ePtTcR51j3eHfQgyQiwpD5nSylsEW+0mslnTyJVQq2g4gEF6aGLE+ACFeXnD2wBLLnH100d5u0+xab/ElD7e16ysyv1sj7jmfSFIFDVleDBJ5tgv8IyRoT0ZPdrxfW02u/qrmZcpogcznBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wPGPVseP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2h2Y93i; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wPGPVseP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2h2Y93i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DCCEEC01C1;
	Fri, 10 Apr 2026 12:16:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 12:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775837785; x=1775924185; bh=SPM3Pg1MS+
	OEfet99Sb5OJ2g8k5uIZbpUpnddxrisJY=; b=wPGPVsePO9G5IecXdXNUh2ul94
	z375i3UQOl87DGRoaBRqXdk5FvUcZ5/BhdHxwOZ2s3SQeOB7d1TcbGRfzEur51Ga
	xfm4cELalvHGNdoBJOmlGBpo8osYBxZ1YwWnAyR8If6pHnfN7HZFmVfhdM1HT2Ku
	n0oIuFNItqB/PRvqEyLhW2cTGEUk0J0tR/vvHIl4qpBdSqnHQHNb3WNERJf5B07b
	YJFih55PrxgSgEedQk8P+eRxwwsvcaDTGl2fLmxPJFMQ3R4wVCYgVnRoYtGdYeHk
	i/qvzB5uqnzCfH1ar1s2oxgqDydFANkh5hXOpog7PUq7WcIRdh7PJEAEkt+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775837785; x=1775924185; bh=SPM3Pg1MS+OEfet99Sb5OJ2g8k5uIZbpUpn
	ddxrisJY=; b=T2h2Y93iFCCF5wiSv5VYigzC59uBD85jVyDNbyVjYUXju6OR2Q3
	fyGc8oIawXjOGHX9CGDQRilGdBshE/WML7a+ISTjZw7a88aVVhBP7p5BX40Pysah
	1cE8Wa6sK78w0JzuefAyfB6rm0wdsMTcNFwQw+U5gnBbwMeKRjEGxIcrxgNQxqJ6
	aFvdb2Xf/5LMY36mH/WtSH9eQMuwDxJv4OURbKU3UtzQ6lj7zjtCviCp+HWDpKqa
	lgOPdVe2K0a8lldoyQZopjoBHPayjKHgG02HWEi4XarmKKfbHn9D2DkMlsm2V5GG
	qWM3Wn2p6ETOAvd+k0TU/urq1TvHnCkkSVA==
X-ME-Sender: <xms:WSLZab0fyibPVwUxx9Qj-SYhKhGGwrQqLDefa4LbJOVDHlJ1zxu2Sg>
    <xme:WSLZaQ84_F_O_VEfPhwxu4hPvC3h4ME8SHC6m1RAQNoxImAWH1Bn-TwJFOpcY0GRW
    03J8vKDAhPUaKUeaclcyOTEu9klMmIz36uepRaFQb_5hnRg7dj9>
X-ME-Received: <xmr:WSLZaUPrp8s2JQ9xnRVDibD8x_l5tmqX1wdFU4q0jIYsl1ynU05W3RzwjB79YyXyFmZ3wV3MXiW7Q60vnRo2Q6wjh860D5r3lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrg
    hrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WSLZaceHQhU3o5ZKXib7Uf2k5eQFvIdD-nMzTqsgj-McPookMmAByw>
    <xmx:WSLZabVW2sUUq4uMA6iRqUiB4olPahxvPDIYH0JEK_7GxXWqmnhnoA>
    <xmx:WSLZacjitVA4S0AXwXxijhDkAKFRLRDGixA8qxkSk8GHIaqanhASOg>
    <xmx:WSLZaS-Hyp20DSsje80rZp5UK2FEnqg0rIncnEsIj64EHkNQRmik3g>
    <xmx:WSLZabvIxncOjeeXEoexwM_OrDH7m-BWZ6fWrrU_DqIrK4tWhhvspzVd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:16:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 2/4] sequencer: allow create_autostash to run silently
In-Reply-To: <f8902ea9-8b18-48b2-9daa-08c7324e60f4@gmail.com> (Phillip Wood's
	message of "Fri, 10 Apr 2026 16:39:27 +0100")
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
	<86cf68d0240ef90ce941cc162ada658a5058795b.1775762235.git.gitgitgadget@gmail.com>
	<f8902ea9-8b18-48b2-9daa-08c7324e60f4@gmail.com>
Date: Fri, 10 Apr 2026 09:16:23 -0700
Message-ID: <xmqqeckmpz8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Add a silent parameter to create_autostash_internal and introduce
>> create_autostash_ref_silent so that callers can create an autostash
>> without printing the "Created autostash" message.  Use stderr for
>> the message when not silent.
>
> Why do we want to change where the message is printed? It is not 
> necessarily a bad idea but it would be helpful to explain why we want 
> that particular change.

Yes, this is a great point.
