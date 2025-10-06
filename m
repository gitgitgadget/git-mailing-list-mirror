Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1041DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778431; cv=none; b=MOeX+QfTca/MHzGhqGr3KFmWkh+D1Kk5qEQ/YY+XdgIx3DITVJtZE+ekimBa4KrOfjtoM7m+RIwzncT4cu7yAHZ0qr1Cbdb1mkg/rL0peou4n6IEAIc3UNYQxPLiCFxh2pOFaLcrqsguFSBehsXiR5tkhM8HOS+AtEt2nsoobRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778431; c=relaxed/simple;
	bh=2BgK33glsf7pMZoF9zp7ERalonX1inSDVkVzq4hUhGs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN7k9vFkTJpM4LrLRlUva0V8QKAVLZmX6R/hOo4IcNBVusIZZeVV4dC8oktTz2HhdsSjIW6qpsu3sv4iP0QHJOV2IZh4l/KKU5Q3bM/lMwYuHRHBGKe31LE3Tw0s6FpHPzC/6IosHTLCKDjfx+O+7bxHKob8iao7rucZvOljKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hQUFSdyB; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hQUFSdyB"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42f5e9e4314so36547695ab.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778429; x=1760383229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4M5RdSK+xm2cIc/BWSZZs4JgOMMHeSxjuj6CjpTENw=;
        b=hQUFSdyBf940A38Q0Rshvj97QA2FYzaQFfla0LC5xpOeuZxuwuZsaYInP8rsZf7gz+
         MgaNCnkHOr2eegxuM4hPqyElnx/3uXTo/XOOXDkEfzpc5IBgY2z20Pu72xkykWfQKl4n
         Bakq3JsA/xQUa8KqdbYfhySy6uwYZ57MgQmrvS3lHyYQB9oKDgZmvxr9GiLSuks8VwXZ
         8oAY4myvfDDXt7XiEQ0hqGlP62VXGINppRg/YY+pDq6+PSBrr2QiKryRDi5HDK5PIEMR
         Qik0jEB25xwgOihHoBZ+eMR+5xetjRYUjMEHIY9fx9nMy3BizGk3eeRPon8wWNCNbbnY
         YwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778429; x=1760383229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4M5RdSK+xm2cIc/BWSZZs4JgOMMHeSxjuj6CjpTENw=;
        b=oUGY3tQRyDMpZPbOUviUaXOYn/9fLOVUhlN3LILhMcdZQWqF2PDDxtto94LMdiTdFM
         TQDV2WWiqFZCQqEfX9Pvx3pKw160bpkUsOvunH0g0jbeNunqReXbC8BUJnY6V07LOAWp
         HRY2DG15YhHnowFUa4+J5FAjX4jYNPQMN57YEcXovHBSKLj2z0pjI4/x60VtMQngGL7X
         orC3B0JSwjl9+VfScCuhE4VCzumuIjfV75Sl9m5LUA7gPrrVM9FDOYbBsAEvaC6ECkD6
         m76xW1cFgNd7bjuxSrWcMYAi6o9OU5rexrmnbJP6YGJ0bHMRQZETEWw3krXfQBwd9US8
         ZZQw==
X-Gm-Message-State: AOJu0YzCYLCj6j55LEfGkIcPNzMYoAq7diPMerp69Q6LvjMumP4cS6Vg
	MLJoIItmi4xMbNkY83NHPIYLi8SWEzzcT5SBoaFkJKsO33QuOst/yam/NyRAJ79MOG+TYw1RgfC
	6fWyypeo5AQ==
X-Gm-Gg: ASbGnct2LVjzDWg/igm78f+ngY0maJZ7NVBizp9BxtH2ojfNh4Q+fsC7PJutLZ1dFs/
	MMeuBCYNmE9M/w/SAbtITaxzOl03fC8xv0unibQi4V0GumHx9sRp0RXssWQopiabS0Gc6K55UFI
	mjURRATjI/W5wCW/eh720oe0rehZW9nPzFPaOMsvT6WwkuYStuKnND7onMyxy3WjGeTpqdN6cxY
	y4UXtQ37Ft1jUdWbl2KmVZfUPEjI8Ak4fWuy5WfA6Cb0MxiCkZfPYFHRmk21Vj+tNzt7UDLsqBZ
	ilUyhZhF6bdvzI/2JBU6WKTqVpnVtTLyU02F3TLCtWsCkTM8SWAeDUy8LPxTPkKhuggK9UZ/szN
	/CWZhhyHi/Y6AJUoTKxY1yHIKjErX7DcOMVvvlxLecwiw19urnqB/RDDHV2QWbTR7hmUMK8oKHp
	5U6p31FFgQRJsrzvTtSR0FTrq0nkzwceLXN+6H6p+X/oMz4pj0fWkioH9mivYp
X-Google-Smtp-Source: AGHT+IH6Mqn2kbV2P4hBet9T80MZNEyX6J4e1AfIv6Z9miKBb8M1588dmm4XnNv3lbEYaxoXhDX7/w==
X-Received: by 2002:a05:6e02:1a68:b0:42d:7e74:2fac with SMTP id e9e14a558f8ab-42e7ac0b9d2mr184100775ab.0.1759778429126;
        Mon, 06 Oct 2025 12:20:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42d8b1f4f0asm55462455ab.2.2025.10.06.12.20.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:20:28 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:20:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 09/11] Git 3.0
Message-ID: <aOQWewStCoT10jDf@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: Git 3.0
Leader: Patrick Steinhardt


* Any questions?
* Emily: Patrick, you had proposed the end of next year as the cut date, are
	people happy with that?
* Taylor: we've been using that internally as a benchmark for when we need to
	deliver SHA-256. If Git 3.0 came later and we had more time, certainly
	wouldn't complain, but also wouldn't ask the project to push it back purely on
	that basis.
* Caleb: we need community support for SHA-256.
* Emily: feels like everybody is playing chicken.
* Taylor: ultimately the users need to tell us.
* Patrick: is there work going on on GitOxide?
* Caleb: nobody is asking for it from GitButler's perspective
* Elijah: if we don't push a date out, nobody will ask for it.
* brian: the cost for creating a SHA-1 collision is roughly $10k USD. Don't want
	to spend my bonus check on it, but could do it and spam us with alerts.
* Taylor: sure, but we could just silence those alerts. Also, who would spend
	$10k on this? ;-)
* brian: fair, though not implementations are using a SHA1-DC?
* brian: we should include this in Git 3.0, and we should set a hard date for
	it. We should plan the interop work around that, but can't guarantee that it
	will land by then.
* Martin: what's in scope for Git 3.0?
	 * Elijah: SHA-256 (and maybe interop) is the main thing, some deprecations
	 * Patrick: we have a BreakingChanges that lists what we want to remove.
		 Default reference backend is going to become reftable.
* Taylor: we should be doing brown-outs for deprecated features
* Elijah: we should delay for interop
* Peff: how important is interop really? What is the use-case?
* Elijah: will forges actually support SHA-256 once we enable it? Do we have
	people create SHA-256 and then have them not push them anywhere.
* Peff: how do we push forges versus not?
* Peff: When we release Git 3.0 should not depend on whether or not interop
	works, but whether or not real-world forges and plugins support SHA-256
* brian: smaller forges aren't there yet and won't undertake it until it's in
	3.0
* Taylor: sure, but not the vast majority of users. Ultimately there are always
	going to be some stragglers. Reality is that what “we” consider to be Git and
	the rest of the world consider to be Git are not the same thing. So if we
	release without good support on the forges side, users will be mad at us.
* Let's figure it out on the list?
* brian: I'll start that off.
