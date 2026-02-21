Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F412BD01B
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771635116; cv=none; b=pt0cBIoWG3hX6EKlQcr3tolJIQoJg3tS0z4h9gxXzspH4BQad2SNwXr1Kv1oMEVR7smVBTtzMCp8htHhd5EmYsctCSJf9iVCp+HEiAXfen+2S+pQ4QJGKcftUExvWrx1Qvce7esapimbXorMhIB5+fdwUO/C2kH1GXH4xrE+hRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771635116; c=relaxed/simple;
	bh=i47HKkhWFclACTk7q2asu6lFFWm28rKmx4eottndgLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUGZratSANS/kT4NYIYalGHivPQia/DB7nbL8p2eYNiQTedxjrD9YUdgpIn2u+8izK4K1JyYYCcHpMIXmeygMEz2YQ6SVcYT8urgR8QUWShUW25vN778XZrx/ecJ1p3o6ATG56iZvEpehJNcdgT3P9AzHQnM7guEijcitlk/75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Rgqe7oma; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Rgqe7oma"
Date: Sat, 21 Feb 2026 01:51:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771635112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COlrJunha6hPnq8Wwez8ijOe6uKFmyK8tI6tSSwPBys=;
	b=Rgqe7omat8R/8OFO7KOwa8Ork9Ma+Kuh3iCjln6LSag8b/2FdF/TvtKaiMhQqUsWcxjSQQ
	Owlqe2zo9EUHhTMoRqgp3soy8bjCeqjg9PcYWDguWOyh424nyhnllcBbkyCcWlCjToMOge
	7sEU13ur98lNJ+Z4VgbI6nnn17kzAkqfctQr5HNdm/ZFSfUB4egtN8SaJvCKxV+EYBdT3Q
	iDQ0pnstCgA1oWv35HWxAJNArYIQ14pxSCEAXt5+z/VLhJwAkZneidfQj9J6clqO0Pt3ed
	JOVW4hez/6XfOHWQe29mMy1LOFWHjEfNw61jQLAXeRJgJYqP3Larpt3A6JHvBQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: Re: [RFC PATCH v2] format-patch: better commit list for cover letter
Message-ID: <aZkAo4_RmfKNFwow@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=mroik@delayed.space;
 h=from:subject:message-id; bh=i47HKkhWFclACTk7q2asu6lFFWm28rKmx4eottndgLA=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpmQGKkat8x49Q0CgfTVSE0T2ICqplkBUiIl9ZS
 k3GBcbwY4eJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZkBigAKCRBIeX6hnBm+
 0QMVD/9LVHqfRX6KEQuQGY1QzV9GdmJSchM2GEEFcDnLG3nCRT1oT80PmM1hqp76gmaDPA0hebD
 R5KMPGqI+HJKIaE4/yy0IWPHwANeoOMfoFvgqdMXMUhkaMMmUvvQ862bEhb2slYFgqeGXzCX9Zq
 H+B6hJPknShm/GzZyGsU2CocYYQvGGZeLcaALsIrFHNuNdhJloFQAMNxaTUcymOjdEG3097ImwC
 sgkjgsJgyHfGjkwik6ouHsKTam0JY/1CtecVSXyApFuLIRq+yWy4Y4bZyyh9Ya4GYk7fuB/4EDR
 tWCrNbCw0MouOnzCC/7NZ1dS2GW5fLB5eAUoQo5a9fKvETTy59DDxP6a8LhKgEb4If0H1SDuRtv
 AybKx9wd1z2sFZuCqYwC7Tu7jqYxLS7jv6Jko3Kpus9pNyh34GfmOEwdO2U1tbIPOyuyMDFZiWv
 oM0gSoSzj3U3oFmW/1qemO64HpXosWqB4kjwKmXN5TqfNQwnaqQBBxskpfEZBGUGZCsv+ciF3wc
 mIyrDizTIFwTUwLRRfybajmYgM4yR4mzONtZPdQq9fpFv0MR6LNj3yvhJjYDMiTWWnk8kRNQp7o
 +P431Mn3hiPMxajlo/F6//RClGee/C/joY4pGILECMV1RL+R/u2ZtCWvMYCV57zu0KB/inv+/4P
 D0JI/neTYNuawdw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260220235502.759002-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220235502.759002-1-mroik@delayed.space>
X-Spamd-Bar: -----

On Sat, Feb 21, 2026 at 12:55:01AM +0100, Mirko Faina wrote:
> +	for (int i = 0; i < nr; i++) {
> +		strbuf_init(sb_loglines, 0);
> +		strbuf_addf(sb_loglines, "[%0*d/%d] ", decimal_width(nr), i + 1, nr);
> +		temp = sb_loglines->len;
> +		strbuf_addstr(sb_loglines, oid_to_hex_r(commit_hash_buf, &list[i]->object.oid));
> +		strbuf_remove(sb_loglines, temp + 8, sb_loglines->len - (temp + 8));
> +		strbuf_addch(sb_loglines, ':');
> +		strbuf_addch(sb_loglines, ' ');
> +		pp_commit_easy(CMIT_FMT_ONELINE, list[i], sb_loglines);
> +		fprintf(cover_file, "%s\n", sb_loglines->buf);
> +	}

I also noticed it generates the list in the reversed order (and probably
leaks), but this was just a PoC and I'm more interested in knowing if
the format is liked by the users.
