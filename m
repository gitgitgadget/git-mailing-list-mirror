Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988B146A64
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357706; cv=none; b=FhdYGcSjTa56b0voQXnRlqj1scGMMyWz4VxVL7gt8HY+ygVfDGon/9lH/4cBWRcwfvC6NB1+4uH5XVQ9gpRK2QmdyFtFy2tttV1uZbynmnY9JWz1lBA4IYzbislXnvICH8gsKsUERuGxIslub/9VAjqLAj70Udr06XJmvesUOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357706; c=relaxed/simple;
	bh=ewS0/kiI9KcUuo1n8Em1EnaFzpif+YAYLdCLZtD1wM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FNSWHGaANO7i2pZiDSuHOVJWfoN3qz2PnD2bSyIuTbCEP3etOLiWI1crzTieJRvrsezYnqWjLjfi7P+KzLWZK6wXTE1mxBqyy1iHIpUvo9A1bKVHdoTN21ho4Zq2lxOToDDlOMkmPPJt/56wjCRw4TcXAg0+DpQdt1ib9AiU6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g3N9xbE7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g3N9xbE7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3068C1D2D1;
	Tue, 25 Jun 2024 19:21:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ewS0/kiI9KcUuo1n8Em1EnaFzpif+YAYLdCLZt
	D1wM4=; b=g3N9xbE74uaFtgOY2XsQMDJCHOEkIHxLsLPg2Rai9IqVdBOXXYGTZ1
	Hhm1dsITbtec1POJLxAxJWhls9Qm8WOWD0Mm1n8nWMkuI4fDPsc1xNvN//sWHtAD
	g2asfocl1K8xiJnr3/f0bL3LhgVy8QeVkDzewAJ58aIH0+3UG1i/s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 284B41D2D0;
	Tue, 25 Jun 2024 19:21:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B23C1D2CE;
	Tue, 25 Jun 2024 19:21:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,  Jeff King <peff@peff.net>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH 00/19] midx: incremental multi-pack indexes, part one
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com> (Taylor Blau's message of
	"Thu, 6 Jun 2024 19:04:22 -0400")
References: <cover.1717715060.git.me@ttaylorr.com>
Date: Tue, 25 Jun 2024 16:21:42 -0700
Message-ID: <xmqq4j9g7gmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF2541E0-3349-11EF-A8EE-965B910A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This series implements incremental MIDXs, which allow for storing
> a MIDX across multiple layers, each with their own distinct set of
> packs.

So, ...  it is unfortunate that this hasn't seen any responses (not
even a question, let alone a proper review) and almost 3 weeks have
passed.

Any takers?

Thanks.
