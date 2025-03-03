Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70A20EB
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741045740; cv=none; b=HW0UZYNRVURDBPvzgOLY3ZuZggqZG9y6vRBiw5u7vory7P0t9QWwGWShf6lxu7/jy+QO2dwQ597X0gW1wplVQ+o4hMyRRsVo7o+ZDWQ5Pgh3Wgup734lzrbqLv4OJR47R+dm03xHmC62aXl2AiXtWgUOjU4Sz1u+SRqlIF6EscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741045740; c=relaxed/simple;
	bh=bg9cq3Rq8De1amjAvOHAdVgENc4bMY1PdcoXCdVQ3nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZ4NIr/EhVuOe0ItpOiPFpnXJcquWVjD2JUIeh8BJToQevPCYHgh1WPr6GVsGDPO2bST/TuZX5rleMz7Dyl1F6INwoqSZ5iVJK63ZUWJ3BsI2SNTwv+r9VVLfnLRYqWGWCGhX4EUUSxikYcg8tjzAEpFf+2yvSYFeViuhfFYWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rJPlADsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSALKKC9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJPlADsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSALKKC9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A69B2540270;
	Mon,  3 Mar 2025 18:48:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 03 Mar 2025 18:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741045736; x=1741132136; bh=sIUcFLcZhT
	gkjNQJZKxxOBnMh2vYTJpV0si0m2WGGyw=; b=rJPlADsZTHYGhULL90Owu2KP3e
	12EUJqwLfPTt3HBfXC9H8OKiNPIaINz+GMPMrUSxTDoIseVIX2IW2C2b5ZDi6fg4
	6EY7/h73unVcxtTcKi9axkVBJBcdFM3HUrOwXpmOv+PHLhiLlZy67VEii6a3x1Et
	TaLRwoy8C4anznqRWvlM0jL+GUYj7QuoN1wLzxUhNkdnV88DF13bpSCqcM5qH6I4
	x/MMlprYvz20Lr3ynDgLUvOx7EcxDXdbhHvYpeCqh6hLdX7fSctcHI986fSASTGj
	J/dtkpWDgMlfieUm0+rZ+duLqfMxaHla1jlbrQ29BOJBHQStBP7E3jKhiRXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741045736; x=1741132136; bh=sIUcFLcZhTgkjNQJZKxxOBnMh2vYTJpV0si
	0m2WGGyw=; b=CSALKKC9stO1X9a3BqnRSpLMQI9gUVYHytBlDPLy/UAl6pBnyrp
	Zcyagz0tC8cvFPl5yJRGG3l3R42Nammp5yHnW6GVF8Q4kMRZS4VE48v0HHIp+jlg
	9ea8jxDCb5w5NoRc5Nqyay7CxwR6u6O2kq+bD0nNW70+bfA9eXvCKiyGbzTGa9YK
	UNFFew0+z416AExIsd5MtZDpoiiwuzIRZL3TXuOwVUv0JaBnBbPMLuBlu9kEZYg7
	s0Q5E/vQhirO8QNR1tbz2et9d8K7Qx4rvu4mvdNu9/n75STNyeSygIYOH9NmYz3H
	/ppStuVVuW4UVd1oQr8pkpOjZ21u0n8jreQ==
X-ME-Sender: <xms:6D_GZ7fuegbi357TNtfWaLLSG4qqXKtRix4wqOFbd_CbFwOkLaC2Gg>
    <xme:6D_GZxMqej_q0oaOT0PGiIutVz8loZGonnt7MJ87q-PsMVpPYrM6IqynzvPt9XQv1
    WTkbJRO3y3V1laneA>
X-ME-Received: <xmr:6D_GZ0hUtQPqFjajjLcjCqOdaPCSLKqoTKt7HnrSyQV4lHYlYDfCmO3IduaJ9ZW8eO9kNCR_s0qAgof3O4oLpfDBWrhgqqtbDLKn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:6D_GZ8_-MOXdhHo6OI1vvOz2uc5ILLn4eeBo60mvBDd_Ip46HGP8uQ>
    <xmx:6D_GZ3s84j_2pyKvmjnuq-C4HGijgRx5ftj9wCzbikpbTG77OhlKxg>
    <xmx:6D_GZ7He9GEGnEWvZ5-8kIDVs6V6G6VmEzdag4LKhhCihDrPBvfZMA>
    <xmx:6D_GZ-NoH_HwIXF3PtKFeAUh5aMqhIhK6ijLFiCkIrbFkazOQb1YmQ>
    <xmx:6D_GZxIR8hFzsgyhN7SaXEsxIQUtUjX4dRkGYeaPY3JD7JGnzs54O89->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 18:48:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org
Subject: Re: [PATCH 00/34] misc *.txt -> *.adoc fixes
In-Reply-To: <Z8Y_PxXsYndBV64C@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 3 Mar 2025 23:46:07 +0000")
References: <20250303204443.360595-1-tmz@pobox.com>
	<Z8Y_PxXsYndBV64C@tapette.crustytoothpaste.net>
Date: Mon, 03 Mar 2025 15:48:54 -0800
Message-ID: <xmqq34ftvfo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-03-03 at 20:43:58, Todd Zullinger wrote:
>> As a follow-up to <Z8Ni0EyQYgD8uWJ0@teonanacatl.net>, this
>> series aims to fix a good number of the remaining references
>> to renamed *.txt files in our tree.
>> 
>> The first patch fixes an actual issue, where we were
>> skipping all the tests in t0450-txt-doc-vs-help.
>
> All of these seem reasonable to me.

Yup, I plan to merge them down before -rc1 (or -rc2 at the latest).

Thanks.
