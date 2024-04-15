Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2082D82
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201020; cv=none; b=ktAODfSyqvuMWFHWm7gOaWhM4nilBvL8xuKpsIKF4K/36fQ/4g9fgds7s9XnvIbLtURSyX0mkBe2m7iDa3KLbv3NDSHQpec6TPKyFpwoiSUl2W5kJpIlDP5RMa14DDYptXkzBazcvk0Uj2xKLKCOsniPrBDToB029rsoquxJPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201020; c=relaxed/simple;
	bh=H+5Yy4n6XAsQlYPRJVo6frzin1XivGHR/3YqZH1JOKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IVqdroK2JOuUetk9aiaUkHxpEU9lobGRa5xOJGiKptcIMufEsbDNgNuejV+VM3qO61NDAjynlfu5kZRhgB4leXxX4p20oN0CNb/K8dDpiRvjjFw6ofKw291vsbo5M7usjr4y6bLoYCy36z8bUmDx3aJAcxxPnIfOQNf80Y4MxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yGwEL+rW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yGwEL+rW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2960928AA5;
	Mon, 15 Apr 2024 13:10:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H+5Yy4n6XAsQlYPRJVo6frzin1XivGHR/3YqZH
	1JOKM=; b=yGwEL+rWUXGDHvaqs0zPwb2de5JifkxTn/EDPh9cMoN0v7UA16MBhD
	4qsKGcLG3pveuXjoQBdxhq/WM4CYuN9VctY7Sqq/dU3FOx8SVAgOfS/RbPGOLS6Q
	0C2YpDpsRntNxA9TiCLfx4Lt65HPjmJ4mUk429Pjez+nGh6raP1u8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 217EF28AA4;
	Mon, 15 Apr 2024 13:10:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B42828AA3;
	Mon, 15 Apr 2024 13:10:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Scott Chacon <schacon@gmail.com>,  John Cai <johncai86@gmail.com>,
  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
In-Reply-To: <a34826be-a16c-ebb4-0450-274dcf75c31f@gmx.de> (Johannes
	Schindelin's message of "Mon, 15 Apr 2024 09:29:18 +0200 (CEST)")
References: <ZhcBJSP4MxX0AMFM@nand.local>
	<A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
	<CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
	<a34826be-a16c-ebb4-0450-274dcf75c31f@gmx.de>
Date: Mon, 15 Apr 2024 10:10:13 -0700
Message-ID: <xmqqle5epn62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06E60176-FB4B-11EE-BFA2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For the record, I would _love_ to join and celebrate the 10-year
> anniversary in Berlin.

I think 10-year was held around April 9th, 2015 in Paris, France ;-)
