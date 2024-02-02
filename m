Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123D45BE6
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877412; cv=none; b=qW+7l+mgfDs1Fr6ZJikPtK8PdaK2cHQ72W3T6YhsZVFA5wrA7lYwXcNIBZArNHpo9WuWh9S0lxSbatsQQnotbtPBLIzCICoCE3k8X2XesmD7aXaAokGj8/m5+rRueYd+JC6O5HZL3rrt93IntnSX1n3hCUgDS0mnp6dLHXJbfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877412; c=relaxed/simple;
	bh=a9CegezYr6ZG1rWmL6eyfVJupM4G30bYwHNZF5swgIc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JiSa4hO5/zgJgb0ySl+Q6n6++elQlZaYe3SxGKLFEEjA1uqqT1bX50Tp81FWtIM8dJG0r5nWnLn0fb0Jxp3p/f3dpdfpK+SVoiGbHREyU09hsJFGA9eA67yA7h9h49oRTTXfNTbTUaebQXbza1oNR9zToAXZXLIOGFV99zC71eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EkG07Kp/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EkG07Kp/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706877401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvUK97HVYtCnYtepDeN/WbeGg2A3uTGGhaUZZ8G2Zaw=;
	b=EkG07Kp/LBaeGEcoU5FuzspvWNXcl1wk4idkNY2yjwysmTtyT+ekSpZzmV29wMlVE9xRRV
	BWHYh8kLeebSDXspfBo+x+xLLKKxdOdGfEbfYOey1dNfE2ZJVVHii7qqJ+pe9BhLwiAODP
	0I0O43F0aKjov4+310XLKgxrcrFS5de4rJDVqFB7oGNL05KV3a/rSbLQsf/9qFDtCgUcoj
	ryniqzdti/XwNbo2iH361kv8BjuEVzTV94KLi5hZyydQuInTZ6LajGcAENgk8BP3G+50te
	F9UGzQk5j/I/E/7msgezb8lx7nZzcsY6Ec8mFdcWTpQemJ+lJV9DK3tYXdPjAA==
Date: Fri, 02 Feb 2024 13:36:36 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, "brian m.
 carlson" <sandals@crustytoothpaste.net>, Hans Meiser <brille1@hotmail.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <20240202115004.GV9696@kitsune.suse.cz>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net> <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
 <20240202115004.GV9696@kitsune.suse.cz>
Message-ID: <46725c2b5defc9f819513700b66ffa86@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-02 12:50, Michal Suchánek wrote:
> Given the open nature of lore it should be feasible to provide
> additional interfaces on top of it that cater to people used to PRs
> on popular forge web UIs without hijacking the whole project and the
> existing tools and interfaces. For some reason people are set on
> replacing it as a whole, and removing the interfaces they personally
> don't use, calling them obosolete.
> 
> In a project with large numger of collaborators with varying 
> backgrounds
> that's not going to work well. There are many people working on git
> using different workflows, and adding support for new workflow by
> removing a number of existing ones will cause problems. The goal of
> changing the forge software should be to be more open, supporting more
> users with more varying workflows and needs, not less.

Totally agreed.  Augmenting the traditional interfaces and workflows,
instead of declaring them obsolete and killing them, should be the way
to go.  Having different options available is always good.
