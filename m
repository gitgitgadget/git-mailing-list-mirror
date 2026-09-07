Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F84382287
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761215; cv=none; b=Grm940GhfGoMDjMn5Owolfiy8sE3mEEyvC1m1J24yc75YvHnsnNcLphewWaNsGsX1NZLiqIEtzr7UWwgN2QHrZ5capXieXPGWRyE/beKJqscheBeioFsqj5Q3s9VWSqrkkXbK74sckNHPx9v3ejvZPFO4lCRFiS2ZOCWLbuw91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761215; c=relaxed/simple;
	bh=UBXelD9zwW2slJ75R6ix7HZXwQT5jF6j1rMwLDocWfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMkrXlLB2LAR/aI1b/ZUSBzrCciV/l/M/RX091DjNF9D7qXivlvZZ8rmlNcV4NKCQcRAdRK728ZYjeIlRWnCdUV0OpfXjDZZ5uq9TaPwJviVU2ngBgz8Prngq7o6Gso3cQpMyM+TeyV3QGXW+scVe5hchZb5kSh7A7SybDp+Xfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bre8Bc5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1tFJLYH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bre8Bc5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1tFJLYH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7C0B1400217;
	Mon,  7 Sep 2026 02:06:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 02:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788761212; x=1788847612; bh=e7iNYal3/S
	nIvJqhyvAE0nAgRLdQJYc8VU028u955Wg=; b=bre8Bc5qmaD3F5s2yXJhTrA9i6
	6yuXflDT/Wv+ZL5qcCBRr8u6H0Akq86DWzCWmZrl7nlXuVMNozciRl7moZtLx4bX
	W4U6xiQxbsMhB5L+RW4/nuPT7c/WcHJ1jnsIft9ngbFv0lQ5VaHYpBEy9ObXx5v8
	Bvaof4Jg9PEkU0YKXiZv3sbWzqGM9utSQK+pVzHaWIZuIQMxmWRasv+CPE/NSe/J
	GBqoZQekI+Rw5G6V4kH7roDNX1ywDgbA9Fq70MPD2VCflz6ng/xm+zbE9DEVC0JS
	DorICdTX89nfdDiGOgz0J/6QhWxeRaq2dH1RKzhL3Q4sDn9mR6/pKP5AVWDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788761212; x=1788847612; bh=e7iNYal3/SnIvJqhyvAE0nAgRLdQJYc8VU0
	28u955Wg=; b=O1tFJLYHxUR+PGZQJPNwmlQSti8LZYTzDkmiDUOlTMZi2UjdUuA
	x8p1btjuV8rdKreaOSXYjtSnA/MKzHU9RVKYsG7VvISU/GnZoBNLiIimmxtPb4Ki
	7agbnk/8YmpDGj/DyxufBD/u7Ne4OhioZQq0CdOQjcj/rcbgVX3nkmtfg1kdajJN
	AdRED3FRV0o2yMrM/V4rFEZT9I0z2BKNRjQI/lCRQP/Gd2BE2C/aMSpvsxWI2VLN
	fHKV4S8DPEI/xUij/vKdoFulodeCKaBlbDUJJsPPsV2q7Q0X6Mbn7TJCC1v8Gwqf
	5GgFyT2NFLLPkS5T8CYiHGmOfYAbotw8RwA==
X-ME-Sender: <xms:fFSeap_BWe3k4q19gONew5RZO-uBBo8Gn4ySFskULULHOk4Fgx4u0A>
    <xme:fFSeanC6rfd_026-bQcma68iY6qbzS2u_bjQD05hOqUoiJyHvzu9gHoD4EA1KGNoW
    kBirzjdDd-37ZzCPtiFJYqNuG8Z5Sl571DuYD8rY-yClZQqr6SwQA>
X-ME-Received: <xmr:fFSeauTQLvD8T9PMyXxQ7RQtoxeT74mVaETXhl0eGkREn7P_Sy51Yg>
X-ME-Proxy-Cause: dmFkZTEZvjga4sh47PMSNBd1SflTlOkqRN6u9d0juEQgEclRclVFYRXumXEeq1ppBnVQyv
    IQqVabN3yrPrEMxEBNehwYe/snfFUr4WuUupKRebNuZRMk5CkLqIjymP/nEw0VjlGVyZOn
    Pf6m6im8/f4Vy8j1su0iNqo/S0TcRdnZSMiJKq8nhvf8zHijVCOjWb4TDYX7mun5SDzB+/
    IaL9Vy5Hs6UUaNbYYKredl2EqakwlL4mS3lbRolnJH/IAt/yBgnX0WPFXmOhEuQGu4gaBL
    9p3YItvopZsGEVzJWJnbYNM2K2LIMyweWoMhyTFWfZub8n2TKYVpQ/rEx3bu4ohn7nRniu
    W1SnkgK7jisLDM3FQR6fYPSDVvt9QJpom01vz6NnJWQuiVt6Y0JQGaWL3nctmroYTbmI3e
    1d3ltkvZjgq7ND0tSl12p1AuYld0AAbzafDYyX8BO3cX3WHQjH1zy49CKxz/bjGLCSrMsO
    68XivC4+2xHg5TXbdT5ChQoTI6bopD1I/2MOhpj47I/NwarU9j92JlMdX7KEsKV3fSaGsh
    VROWhJWzE6T3yuNwTtZTZSjRLZDAPjj7yJ6rVxSks9Ry5NswxCJwKx6oV7kPF6juadHbB5
    EjPTrKV8t54LA6VBAtY3XqKZ+QkUSR/i3RQ5HgA3ucHsXzIuUHr38OsfmyMA
X-ME-Proxy: <xmx:fFSeauvn-ywNDIp3IVLXBVA7oUdOTluvLjJBkl1aELs_Gb-MQqyPFQ>
    <xmx:fFSeaq1XSx5UUt9TvutQEIsbUPdYweakgKWWLxUH6kLZUGTKFjSHKg>
    <xmx:fFSeavXGI284nNtnbjqNrD4f7PVDIPZJ8esgW9tC0SIw1S_RMbkjiw>
    <xmx:fFSealKwG0LcXk_2kXz1MqS37e_8Am7doOVUV0mTXt7CNlyIR6TVCg>
    <xmx:fFSeah9VVF9E9MkUTTx4MLeHPsNv1mMxKCPgsEGhwzn3PFZcO4FvHKXb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 02:06:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e326d94d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 06:06:50 +0000 (UTC)
Date: Mon, 7 Sep 2026 08:06:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 0/4] hook: introduce the receive-report hook
Message-ID: <ap5Ud5OW2NXRuDoO@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>

On Fri, Sep 04, 2026 at 11:28:48PM +0200, Karthik Nayak wrote:
> Changes in v7:
> - Removed report_v2() since it is the same as report() with the new
>   changes.
> - Used a switch statement instead of an if/else for the enum.
> - Removed an unnecessary curly brace.
> - Also rebased on top of latest master (3cb9185f65 (The 22nd batch,
>   2026-09-02) as there were conflicts.
> - Link to v6: https://patch.msgid.link/20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com

Thanks, I'm happy with this version.

Patrick
