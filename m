Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4687182BD
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065051; cv=none; b=jjr+wIJKWJLJ5VfvBFEJTb56yTAsp0F9MU4EL53zGoqgBZQX+ijoemxgnCVkwpmitvSsVjemHlxC4RWmoG0r6TAWFCL37hg9NDwAnaoAyh02WtoGJQ0cHeto41TfxsbY3F/PI4U9Y5/sEy48xgsYXc+DSMxsXDfAaKbI9HSMljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065051; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bswc2exaGa2Q8LQAHZ3m8oZE7CuK2zicr64gKQ7crVqMUm/Fg5dalLAKmtaHIYDvxFWkVcu5QYp+28c8Wpe/SilcgZc0Bdn4nPcrPdIeVEOibL/j4M9JeMZ4cr+5HT+LMZPWgAYDmyWb0yNsmMtaaK3o1XS3oVt6GnbEWPhSp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D47csyKx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D47csyKx"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA9BA25400EE;
	Tue, 19 Nov 2024 20:10:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 19 Nov 2024 20:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732065047; x=1732151447; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJW
	ZG3hSuFU=; b=D47csyKxZ+RKo+dUPw4jcpz2vb0XN4kj6FfIHZYYKu5iN40lQ8u
	5ddhU28Wi6Tjao4af0SboThIpbdeGkmk1FiD6tfbY1WwLOqg9YOJuHILmgGWKmLi
	jK5+YWGaHvwMoPsyVmZCHFAX22QNnGy6+ExZ+aC5r0VBHRA8EYIUNaY6ASXMN5w1
	C/ttzkdMZuQosKDUIDShUp8N5kyieqEqit/bvHVl3tqO8xFCY96HoOgpQsCVvRS2
	TMa/7aBtJBNGFkFbOZu6P+LuMez92nU9RkI5e83SLJWdFj4iYnT7sHuJ5IxrpXPR
	/Nf1w8JVjmSYT/P0n1qsZbPNC7vktA9hT8g==
X-ME-Sender: <xms:Fzc9Z0vlXkVnCbnvLJTpJ1Tcqt3CWVSFDG5ahnqeWnSTWCMkmv_JDA>
    <xme:Fzc9Zxcfg35XfGzWY6lVteGeUFImvYO3FtZGNAM62F3sgGevbGyTlMuMwAph9LZ8l
    DkndW9LxBM9NKGlhw>
X-ME-Received: <xmr:Fzc9Z_w-Vz7znm5SqqzNG1sdy8LaH9GEZN9FPgP_-c2pPXO3DF09JzA3swUjvhraFtFMMocOrXRrcPZeuzG1_lqHpRXa6ZeYUD2n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdengfhmphhthicusghougihucdlhedtmdenucfjughrpefhvfevufgj
    fhffkfgfgggtsehttdertddtredvnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnoh
    cuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtgefh
    uddvteetteeiffektdffgfduteejhfeiveduudeuiedvlefhueekffekheenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopeigvghnohhtvghrrhgrtghiuggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Fzc9Z3Ol78oP7R9krQwAg8aM_KiEzcmkiMkZJD2xQ96S7W0Y9gHLyQ>
    <xmx:Fzc9Z0-I9jLwyfJACg_LAP-87HWWrZhDLeoMTGl0gOFIrBYf47FOGQ>
    <xmx:Fzc9Z_WfKd0MSUkROPK9rDxAIdvvUhmg6OFrx49Y1uQzYRuSTZhSew>
    <xmx:Fzc9Z9fK6O4As3fkoFu9RpdqM8qw_ECps1khkvczDkcy37nNfllcNw>
    <xmx:Fzc9ZzmMC-GxqzT9Vy7V2meXVlodsE34OLTZuXVV0R1inm5pKrcXqww7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:10:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb Cushing <xenoterracide@gmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: git remote set-head automatically
In-Reply-To: <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
	(Caleb Cushing's message of "Tue, 19 Nov 2024 10:40:55 -0500")
References: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
	<20241116033616.GB1782794@coredump.intra.peff.net>
	<D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
	<CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
Date: Wed, 20 Nov 2024 10:10:45 +0900
Message-ID: <xmqq1pz6btgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

