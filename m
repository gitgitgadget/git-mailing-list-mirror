Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB1926BDAB
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291364; cv=none; b=RWuKUCinuA85n+MKJ8LUZptw4Pzuv0bObLtk9JbLuwQW4O2HdMUAaSFsSIyxwII25B4Jy0prwZAVzognzHrIqnl1e1n4IU30adWUFcS3gqirgt4wNeNG2+AIk+VSW+/mwZmjrPaFSW0wPLeksvls/fW8TMxAIakIYIxXBzyqKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291364; c=relaxed/simple;
	bh=YTPptlEMrmS7y/4UWM9vjGq4vh0nWIJ77yc+18q5VUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lm++ViplBxyA69Xw7g6oVzsbQwZ/ZeYW5pA3vEE3DVp5mFCJ4ngjgTE89E7Nuwcy0iJmZs3ugz+bG2vC+41vYELKBCS+rFoXaNqywoZiaW4dqKPBLuUyQ1mT6r8Xjd21V22uaVTlQyHkUZMYxGzeQH13179gChcb7X3L/IhjyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q5AmaAAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vf8z0pNk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5AmaAAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vf8z0pNk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 508AC1380A31;
	Tue, 11 Feb 2025 11:29:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 11 Feb 2025 11:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739291361; x=1739377761; bh=kFs3fKlh2d
	2nXT1OWnY7QZbtJ7/IzOgOPlXYN5Qgqgs=; b=q5AmaAAVSHWZ0yvH3HVMZWBARb
	fKnYwvoTs50WbaRU9ywrtScT8hI0wCyfybiGdDZjjqz1sRgN7s/BoFEyLnUvasZ1
	Wn9bs7X9aZbm/V1xai++vc31rGKxu3YQljA+uwuYa1rPs8R/+3EnZb0U7Znlb1zn
	oIk6J1Bh+jacDS9FjPWl2W6CAbvSrb/gYnxKU/qF8p9EU1m6krRupazVkkpkRSfA
	KQt3690WUA+fw/aGGC66Bu8DR6nM6dxOnrNua7G5Mr+XyRfCYDAGDeiPD1s42IpH
	D7xifIYFGrujm0osMmUd4q+MBTYoK9J1il6SEVmkqtExEFWZtqXZZE5nerfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739291361; x=1739377761; bh=kFs3fKlh2d2nXT1OWnY7QZbtJ7/IzOgOPlX
	YN5Qgqgs=; b=Vf8z0pNkCbyDC7AraPgwn+xtZVyZ1L9KDPpKokZVkEBNPbr8jWk
	1S3J3C0J/HaAY5P5cCf8oABCyNWc7CaPMdFA+IuSxGrBlOH0tKMDHJPbBtVzWx5P
	n2QMfBu2izz3l4cxHRL5OSioMw0d6q/QsHLdq0UQF/KYNAD3Gx6JWp9GgyPkdWW6
	GgA6rsbgu6NAoD0dMZezuziFMWVUGxmNgLfT3R1ZyV/77VCe4XdxJqp9MyRYF19T
	X3o3EjFq6BOcMfwIFP3J0BosOkW0vK2Wu9okWi5TkeldEuUZJBbW++Hd9Xf+xxIk
	V7rZDdXcJFtxpkpdkj5Wl4V54cp/OUaCs9w==
X-ME-Sender: <xms:4XqrZ3D6nfaBFr8nAAjECop4ZFUZ-Er5MwLZZchw0XIcFa8ZfD8Ayg>
    <xme:4XqrZ9hdejei9jFHQvMH2Bu3rg15ZtWihkABxOlaBQSlcoYe_XTvTPtvreJ_ykZM0
    kZJb4diIgm6xDh-JA>
X-ME-Received: <xmr:4XqrZyld6ll1mBcTcZRFSd4jUa64rTPClunrHI5ll0ptrwzxl-I48QjNuqxczQvHx8aGj0LQjZZf5LCX1zYmKmd9p5yFfsSctbNihP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4XqrZ5zsK43nHYN1-qW92zgIA__djDG85VIUixeNXwILw80GCsoHUw>
    <xmx:4XqrZ8SqWzaUgSRix3TjBDh8ElfmnEezFp-Ebei1ZjFVVpe_JTTmlA>
    <xmx:4XqrZ8ZpCma8l-kTkP333I30MRrXwMKg4K6lv1iqlN8tOqSKb5UprQ>
    <xmx:4XqrZ9R-nHa44EvuWmK-mXOiWDUwpkpnUTiDHZfHCJ_FL9l2mm8jeg>
    <xmx:4XqrZycCUMhMT9MdAFBE5ah5arKO2OAL8A4uUqAETuYI9CTGYokcGD4h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 11:29:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] midx: show progress during QSORT operation
In-Reply-To: <CAE7as+YPKuBd+ztBerim6e1kZXZwUHdb_qjcMfZSBa4LkiyJow@mail.gmail.com>
	(Ayush Chandekar's message of "Tue, 11 Feb 2025 17:53:58 +0530")
References: <20250210074623.136599-1-ayu.chandekar@gmail.com>
	<20250210074623.136599-2-ayu.chandekar@gmail.com>
	<xmqqzfitbuy1.fsf@gitster.g>
	<CAE7as+YPKuBd+ztBerim6e1kZXZwUHdb_qjcMfZSBa4LkiyJow@mail.gmail.com>
Date: Tue, 11 Feb 2025 08:29:19 -0800
Message-ID: <xmqq8qqc30o0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

>> Hmph.  If the implementation is correct (which I cannot tell), this
>> needs to explain why it is a bit better than saying nothing.
> While going through the code, I noticed the TODO comment: "Measure
> QSORT() progress", and I thought it might be interesting to explore.
> For big codebases, being stuck at zero would make it feel like there's
> no progress happening and that is why putting a progress might be
> better.

That much I already know---otherwise we would not have that comment
there ;-)

What I meant was that the proposed log message did not give readers
any hint how the implementation given in the patch is correct, the
assumption it makes on the behaviour of sort(3), etc.
