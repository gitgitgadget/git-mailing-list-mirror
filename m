Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2C3E8342
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141946; cv=none; b=DkwjAPap7txWReM8Y6tb0fbHnUN0i4iXd0FQFWiHBXyk4nJpvbMxMKYRdOeKWHcf3ADZsCRCqb73YkbnovjCPBrkcl1dF9/qQQWrHbmkUwkvNe48CwhMZZD0EJT20U4lRP6yyWEqRdtzv4HYTFViQ/cfNGq5SU1siVzIS/djE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141946; c=relaxed/simple;
	bh=NmqP43Zf3jJCw2iEEq/2BqrkGJw34/Lj3tgXhC7CpI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkjiYptH9U7jaaOnPAN8wUgOhgm/qZPGpQvxyLJ91mu/yRidTfIPdFJEM9T2DSUZMdcdKYFlmzhelPJ71tNZQ55rqfqkoV7lxnsF3lKIE4D/Cd6k//jVOsjNcdyhZq9sctEBQSwbMQmd4m3wAXtZdIEPnLCqkaVxtBB+rTSihlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gNmU5Qu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZEYEe7d; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNmU5Qu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZEYEe7d"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD13B1400147;
	Mon, 27 Jul 2026 04:45:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jul 2026 04:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785141943; x=1785228343; bh=3+H4PsSSLK
	oIey952m4AIST1wXuxzP0ojNkw+M1o9vI=; b=gNmU5Qu/oRL6K4WcKr0GukEaUi
	fWU/muMBBtiRiV2dp+4OXWpSrH0Gcsp5Zv9+6tHgn28kjFpmE+d+fiUV+jMJid3o
	pYNzFq2BGR3MvZcmn9J2jENMECji5CrI3flPUzSEHOh9hfZo84+tg+FT3jUXjaU/
	xSVQxOTcpbooKPw7IguuGovnmVFpGocEHXjxoV4pOTU9A4j7txqMBUvLm7xOBKDH
	MKHAQeQbJo371p57uIui44kCMcE4suZC2xYcsRLlccGU+Q+h+K3UwT8ezRtiXK0c
	pPKsn0XJIW+7QW4h5VbJG0e0swPSRafHSRoK5Fa9FztD0E1y7tEIXOM/ujmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785141943; x=1785228343; bh=3+H4PsSSLKoIey952m4AIST1wXuxzP0ojNk
	w+M1o9vI=; b=WZEYEe7d1V5a+vKlBj08091t9z7/5Vf6EcTApPnbm3I9XgkRZgH
	/s3HOfV7W44A1VRHFGtC/9v4scNp2PCTvCwrwZY4K9/MC9XTFV6BspLqD4HSExfc
	/VWoh4K9+poyOu5OhvsWBnkd9yMFnryUmZYyi8vbQmhoUoq6Xdwp7t9LSv/pIYTT
	sydtKzaegthEBX+qyxpPMd5aKV3aBgfEs/2GBccNT7t1bvGbCJ6BRRR5Ws+iKZV8
	W3+IXm43DuwG3Q0Ywk99Qo2TryWz3syntyQPmuSRl/KwftK7J1vjysaevypPy3+6
	Xhz+dWd0c2GfhvAUGYdj1LNMvuIkRLdlB0w==
X-ME-Sender: <xms:txpnaoCSepx2aB0D3OrDOg99eDkXKAmQH8tgjGYo9OhOzZMKL5RHmQ>
    <xme:txpnahZH_OgOs8Cf2NJWhvaZdLe98Q-vXcn_1JzlGMrU4Cn4ih06Guy2kGP25Zfld
    QsuKpH2GsLQAgAh6W_PAHJsEoeJ4vGgbv8Pgvwf0kdHMFd6H7Ov>
X-ME-Received: <xmr:txpnaj6bohpqxly11pAwL6oMtFUSrFLTjvzCxYXnjPBXcxuxgvwdS_aptYttYEIt4cPLxVLZ6rjPCnixdc8zHa4gkaV0yH5pQg>
X-ME-Proxy-Cause: dmFkZTGYQwPdVC/G9mR+0fZIrOrl36LYHEWPbkbgS4a9menAOKCr3nbGmUWcukq8GuiROi
    XlCcKKDv32JdBOYCSzkQULcyX1WHI/3wGNY/809vsm4SKhrftMpe5EKy6WAfjpbupkTWjb
    0aLUvmYADCyShrXIazhr8huTJXgi611NC8Dnhwdzn9c/W5mY3qBBFypa0xY1JqYRtsFyuH
    Mqa5LWXpCShD5BHI6okeAZ9fkY5bIZhDzU3JGuVm3d2aBC/JpDZB9TptCLQxRV4684RA6C
    e9BjqJdA1JfeIGU1rHJwIEBh9RgMTwFQ3OWYiSL3/IbIWvNpIRzPvKCpU7yzD32sGGf6R/
    S51wsInC4qLHKLCtmgnj23rLOQF8DW5wcUOGgCJ05SjD0cgQxnl58mxuk51I5uVMcwAESy
    TVj4r2cBFOjCY6cSQ+5WgWmrY+A6cQtO2fF4/4cgpH3MUjzjq+Lx9VVbpHRZhzUGxWLUN+
    iWZAgbKwm4dHUOeoNX2XwnJVZuYcFiuEmhXxsdZxrkmEJrPI8DZStIpCPPWrzbq3gNAND6
    nkwZa+jj9yUyhV7y1XnE5I67ZhEpiTz3hCouOief/Q+Sycp2zwNLm6WdZrO2dsFLdpWroq
    Y1suT+BmDukOpT+86WFh0f/mkGWTUeowf0A0H81KHXLP/93mgzVQc/xdNebQ
X-ME-Proxy: <xmx:txpnaqb3ftXQ0WqVcnrPWLr3Yu7DvXh_Eq5UOwf67i5IJBjdKo9quw>
    <xmx:txpnaqhSrG94_l4gokmChBehmTBALT8UkqFRAZJZE6LBGc_xBdOvaw>
    <xmx:txpnaj97fkVw63rrlYLtBoCkDsjnPlx9zirj3HKeCHuar0eH69iVew>
    <xmx:txpnatpb4s-e6a77Tadj7RQDAOGB_ZXep-Zdb5Yq_pD5AoHza-YbSw>
    <xmx:txpnah529cZZjl6a39rpJB8JcxgNt6kY6lCmlgFxWNeNfrTYM8M5Qx2->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 04:45:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 1/7] repo: add path.toplevel with absolute and
 relative suffix formatting
In-Reply-To: <20260726104343.16933-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 26 Jul 2026 16:13:37 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
	<20260726104343.16933-2-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 27 Jul 2026 01:45:41 -0700
Message-ID: <xmqqh5lkq0qy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> +static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *work_tree = repo_get_work_tree(repo);
> +
> +	if (!work_tree) {
> +		strbuf_addstr(buf, "");
> +		return 0;
> +	}
> +
> +	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_CANONICAL);
> +	return 0;
> +}

I can manage to wiggle it in, of course, but I thought we lost the
'.prefix' member from 'startup_info' in the recent tip of 'master'.
As the topic is not targeting 'maint' as a bugfix, perhaps we want
to use a more up-to-date 'master' as the base of the topic?

Thanks.
