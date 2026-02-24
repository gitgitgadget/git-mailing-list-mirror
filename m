Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81684EAC7
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905987; cv=none; b=qQwbRysQ+uJ+ELjH4uG0lFIFLIXlA+XWPhierW1xCUjOe62wCLActWlKz2UXhFTRD68p7gNFwqiEOKxaH3LpRWjfWct/mRuvSWSPjp72IugIEFevXnPXIEfHd5fZcqIqRWJEBenlNZGDWbDJ6iktve36QYcqxaoE03uWBiSY/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905987; c=relaxed/simple;
	bh=9BYbdhBCn0SzQbq6WCDBPX/IkY2K1teaJzWeS2Oqdws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMp9oWrcR6Ydx9j/TkizEV25MyAIdskcbU45DueuiT5cSF392FzogJILgXyHcrxhp6LDXftNQAlZ83Jusi1ZAQjkpoOE3QQF2Ge2C+Xj0HEJ0kIXcWl7xFLYeX9+4NZQH+HkXWziog0nLwRM1ap9bMbG1uc9lsYwsgSsTjlLBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=A7rTdlgF; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="A7rTdlgF"
Date: Tue, 24 Feb 2026 05:06:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771905984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BYbdhBCn0SzQbq6WCDBPX/IkY2K1teaJzWeS2Oqdws=;
	b=A7rTdlgF5A2MIi3dX8yj0cD4cuvRACL+h44iJUUcqnZjKJvjr5SpENBi0wqONvXq6uPDL/
	ELPLR/J9DOOFVHmowNeKnDqoTg9qVeAQLRtN/hnmHp7qNIYqM6rzZxQREFpezDa7A2bB4h
	UBjFa4AM/Ewvi16wfDAFFroEP5mce+F4iZ/DHwSC32HjIUp4IgsN+h1PG7eYcWr/dWC7RH
	qcWLMLFGb/6yByne+D8zUr2UlwR7HD9sC4eejVts1YEuPNFvAg1uiZyJTm7/KhfclPI56e
	RbzuzORfslTOdacJ6Y/8tAEJHXkIDGOQ7sPMzdqwMn+Z+YMPXCDiER8Ichb/ew==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] format-patch: add cover-letter-format option
Message-ID: <aZ0jdMHoSMwXpntp@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=30; i=mroik@delayed.space;
 h=from:subject:message-id; bh=9BYbdhBCn0SzQbq6WCDBPX/IkY2K1teaJzWeS2Oqdws=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnSOf9suSnCxHtl5d0oM7Mo0HWh4cTVPg51D3r
 KEHtYuonzmJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ0jnwAKCRBIeX6hnBm+
 0fGsD/oCniMgOiUtfgdD1xIxajqxQ+0rToDKnJDHffK3efP0GFzQ53gdO5048M8g98Gn1gtQ1x/
 c1+0UHsfwAOlH57ZhWtpJ+xTuZw2/tVSyjb5YNfM5XenHBFqNvivPg0h2kRwnPhb/4EmBKUarmE
 qbFwNIuxe37lfIA8mGU/rRwEHdWhVfyUD8igTZE+vByQT7pv4jVxJooUJJL/fNRt65jDfcGu0T9
 8S43fBmFjrjIKQTmoA8Q8JJEYtgDQgY9uDnsF8mDqir0q2dtthR1HhHcwXlMrgaTz25+fV7HFZL
 XxW0PcJh21aYNW6P/YrWWzI9j3JWAZayx1ncaaTn8VoXKVar/SL3/ePfJR3ZunfyULxnfw061O7
 6sQHpSQfBBD+OhRH2h+2c4EjLxoRgFM+nUF6WBh/+WlMq+U/hdqZgN6SVN4BM0Xovvac1IRMGi2
 WXLcXPP8nWxrEHN/8r4A56fjzVOiH3JtVWQ2Gdek5emOK2uJW3N5DOx79/d9zmHD2ttbVwgZARD
 79wPQvAgno8IHWPPrLYV5tSNUm33N3RLNy79DFUs2UB1OiIUO5GjtYB6VFhAr3kjk/wuEPfrsf8
 lsxTj9zBwrXjRHInmHgdOInDuDXxHr+algjW43qhiBwVNbV9+/exLi8zK8T65MUQs5bGekqFWGZ
 29Kd6/1OcLblbmw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260224040400.751247-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224040400.751247-1-mroik@delayed.space>
X-Spamd-Bar: --

Sorry, I forgot to thread it
