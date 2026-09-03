Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EB4E80D4
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450972; cv=none; b=cdTZ72OCAMznCaOshhPRzuQ0BsYI+W+n4zvhHYf3yFyZWAmGGPFP7CpdA7EIWJdevOZojCfqYxm2O9HNdOEY3fMDgWtPJS8PZTTDaeg1vMa3b7LKwGChX4z6zZ8JNpOU43DKQWsM6ziVxSZ2guOzNBfzf5MP5kG5DbEpww4tMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450972; c=relaxed/simple;
	bh=AYtVX+oklnRJwgC3kVqtOxRd5b8Jmhe0mg7/iVveB4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwaAeVSEVIfkkzWob3/iG++EHl/drLFZDCWGHxzhdyMoBDAWN1v4Qz9nQpcPpq9sUTjVbQaLYKQhotrn2KVDk2Y+IrRZQtvaT8ZpKCXk5GcBozQAIM5DcMuIEZdSZFMH7kMyjE8om03DA4seakAWGsN2bx7U09ilD2BnLs81s2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WJ4CbzGB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/uTI6BR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WJ4CbzGB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/uTI6BR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7EF07A00F0;
	Thu,  3 Sep 2026 11:56:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 03 Sep 2026 11:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788450969; x=1788537369; bh=7yJ4EXQqDt
	F2SUKCoF7pF5D1RubNCYRQSjNsmOutyPA=; b=WJ4CbzGB6Q3Y4+15eVrVB4ABfe
	mzml3oJoVQb9udDIR/CRIQicwe2QLKyJL4MjQ8i3+o8R6iJ28Svbj7vObFpjLbZJ
	KSxRVMkiXQyIIxtV7afhC62SAvVHAw4jh6LK3HKwcc2IJStLgVVS6gw1qMqVwAeH
	YUuj8pv7W+c1mnOh8g8xVpRi+6vjk8YiqwvC+J71QMon3aOHRu2cu0CucsTc+T9v
	OvmPCv62129k+ZwbzPp57KI/PBLZrCcr0Bfy5T7hBCR7eRuKlvMlbBs/cZ2STfrB
	Mw/G/wibGh0Af2QfvWfuQi2imK18fAm4p+JnqqhxJ6wOnMUhl3/YZy7Rariw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788450969; x=1788537369; bh=7yJ4EXQqDtF2SUKCoF7pF5D1RubNCYRQSjN
	smOutyPA=; b=M/uTI6BRgQf0YiQQtw0s5gqSp9N5+tR1vhMcrFm2QTisMyDjKOs
	7DlvNNgIiaomAOlAaPGL6C/+yBuIreHadIlYN+PGFBnqY0CXzgTBTzHbTHJI6mcG
	DuTmazfCovtDEhUAwqmZfYbWYkKoOm6afVCZsAYAo4Upa+imGOxhmanSzV4iNLLp
	P9U+bSpkm3tvFb4UPSFX7B0Mu06IrfLQQ5VLFY4DPZyGjVm34ENr/j6z1vs9DeDb
	CwMkbXviFSwUX1KV9OHllwLiO4mjZxOUHbb42vw15E/fKuWBjdp1Vv8+rzWLsZkj
	wUPDFeHoqysx74szfE/UGoP305OhBNipN/w==
X-ME-Sender: <xms:mZiZatCLn07J8IhdwxqS12EdvWmTpVZAsNGNl4uOihBEnw-n_98QOQ>
    <xme:mZiZaqlitKNqKYXXD4GOuaMnniqW8vJqLEBbo_XH8nyD4D8pxv8Pt-A142Y34rKkz
    49WxDcJvarw0MnzUNqt8_SJnfHWrA_3JYTaWprceKR9ZdgfwNaLIJ8>
X-ME-Received: <xmr:mZiZauyVytnk_lZlpm5EODqWOBoY_ecjT9RTmLrrZUCbi57X4Zf4F-F4PQzC3s3XLUuCJe0yEtpK8Zsctf2X9Zeka8sIjoN6GQ>
X-ME-Proxy-Cause: dmFkZTFGj9rKzFYxyQSikzVnOqlJw6qfAkD5/gdppbYiRjoUhQ/DVlJOXX5TTuMokBKb+2
    5iEMorgUiBZMM7euY8Ft71kWmP5KdE1Whe0C4QsFOq5NaKsXBADKBj395pmoKeI1n63s+Z
    5zAD07Skl1G87aVA5D6ErY9wGG76PhoKOnM8Tnxlb8Ldj8GiS0lYQO4I6QPijAMQ79fJYb
    vxrpyGTvayxXSyYj67hZ7s/m1jFWn2ebJpQ/xhc5Ui2Axc/FyI3WK1g4fG6UZQoMAE07X/
    KxDV7+qjBqk2bYqGaLz4md6EC9gVxkvOwblltZqqYh+OnET2hehxf6dYMBbutf/NqpEiYl
    jFrMRNSTxQ9tkLd0owEP8D+wFInI3DaJe2RQb1VNjFgu4WgYU/ZZT5GrWjdYPEwnONd2ti
    S4kUIwGJC5+IcwljX6hK1BKmR+x7J8xLGWkYpcvrnVuV7LzQya7zF9ag0Y6mIuYmAco2YO
    rZpONAw3OIJsugxbvoQhbeMm98dJwJgJF2nTcfEZ5BFHfjJrhbA+RlxsDUhEjEXsneyf1d
    M+tod2HvgTGFdTpUgqW+Zhf2/9vhgbFvV2dAEE3Ml48cwPf6WhTny4NUX0yfe3gW0jH8Wp
    y8DCTRKsaYxDHBay15k7MxtU0uzRA3Q33oB2+2pbwaWbgZSwoOIPy8AwQkOQ
X-ME-Proxy: <xmx:mZiZakT7bBDl-aF8XXFrdZ5-dnPqb8d4IPSHDRCXwiGtQjs-zp9GdQ>
    <xmx:mZiZam-iFKthEr8VgkgVNOzKZ-c_wmvtgPQrlowAFlBuqdu1BGkvCQ>
    <xmx:mZiZaivhxEIzMcib2sNmtCqTBSOrU_llBhmKt1imuAoCOk5Zg0-ZxQ>
    <xmx:mZiZauPRh7CYDTqqfF1tx-wqx_JxDPuS74TqS0GFIPWJrSzK-P6FKA>
    <xmx:mZiZahGIKGUs_7ieU2-FvO2Qg3ltG3QboW7I7dGZB39etgVPLN-n1wWJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 11:56:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Todd Zullinger <tmz@pobox.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>,  Yuchen Tian <cat@malon.dev>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <842F2470-F158-4E77-AD98-DEA530FC4460@gmail.com> (Ben Knoble's
	message of "Wed, 2 Sep 2026 21:00:35 -0400")
References: <xmqqh5k7gy9k.fsf@gitster.g>
	<842F2470-F158-4E77-AD98-DEA530FC4460@gmail.com>
Date: Thu, 03 Sep 2026 08:56:07 -0700
Message-ID: <xmqqbjaefhwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> I still am worried that something that sits this deep in the
>> callchain can easily BUG() when working on a repository that is not
>> the_repository due to the use of repo_config_values(), and we might
>> be better off adopting safe default when istate->repo is different
>> from the_repository, but other than that, I think the series is in
>> great shape.
>> 
>> Thanks.

[administrivia: wrap overly long lines]

> Yea. See previous messages re: convincing the test apparatus to
> set this globally. If I could run it that way at least locally, it
> would go a little ways towards scaring those BUGs out into the
> light.

I am not worried too much about the current code.  I am more worried
about how much this will hinder future development of new features,
e.g., diff or status recursively going into submodules without
spawning subprocesses, which is done for grep already.  Testing and
seeing 'git grep --recurse-submodule' not hitting a BUG() does not
assure us all that much, as I do not think it needs to deal with
racily clean entries any specially.

Thanks.
