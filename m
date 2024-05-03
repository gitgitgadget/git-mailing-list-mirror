Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E91465BC
	for <git@vger.kernel.org>; Fri,  3 May 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721476; cv=none; b=eOpJ+6EqTH9nwr2ab2P7xbecjjwarOBc3fKODq2cgmTcFQqCuqCfZa9zeKOS2rYLz21EQJqcic5mfRhjZGXSUd2xg6uI1ncYMSjD3kdMzFlmvPKNus2gFdcSG1j8KayLt93we6jUzbG/RqXa7/GAeA3Cc7IqzGxEhnq/bfZvspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721476; c=relaxed/simple;
	bh=Dm+ztdK7UVQ1kEsMrVvVEf9NH4UpNupN2zbY9NYJgdk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QMFNWIpsp2YfQrj5s/NmhP5AiOueodRZhgHWcDzBfwM0KCMT8k7VKpWE9n2hbT3G30HTp6dAbundkJWS7JlhIEbcutxStlhkSHZ9ZGwGCJ01D3Hc49MFOzayZNl3ckSjuGajQnSCtQSZvHyOXJS6mL3NIW0xyXWCheRU6TM848w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vVN9LpZQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vVN9LpZQ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714721464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FA38KHzcysg5U+1JJWwekSmjr/wIPbZeI75m04EV/Q=;
	b=vVN9LpZQ5sJDA/UtAeo2Q53pRLfnIqLAF8uZjuihLC5lecZti9HYFfkXTkR9NA0WuYxbMc
	4TOoMUIaTxZXOntjvC3y2ioYHyQt5OgC8LsqV3XkaGngYFZtnDKZvBxrCHSHami27PiJuU
	jXcd4A4oVdnLN828TphQtg907dlDLpUMuq4YnHIsi6+i2/FZKdW9RcWXEVj3Ie+E2i+Rll
	qwEmoXl6Q0Ea6X2FIgPHe2gdLJO6e8afZ1bYD/eHlq+nlESGikFJ+3m4yTh5m3/dshQQdo
	OzXHBxP5qQsdrvZdsi9WjaFknP8oy/PSukr4ViYj3N9NjtWVXow5O8BirOHTJw==
Date: Fri, 03 May 2024 09:31:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <20240503071706.78109-1-james@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
Message-ID: <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello James,

On 2024-05-03 09:17, James Liu wrote:
>  Documentation/git.txt | 18 +++++++-----
>  advice.c              |  7 +++++
>  environment.h         |  7 +++++
>  git.c                 | 11 +++++--
>  t/t0018-advice.sh     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 10 deletions(-)
> 
> Range-diff against v3:
> 1:  55d5559586 < -:  ---------- advice: add --no-advice global option
> -:  ---------- > 1:  ae3f45dadc doc: clean up usage documentation for
> --no-* opts
> -:  ---------- > 2:  1b0019026a doc: add spacing around paginate 
> options
> -:  ---------- > 3:  31e73e6c0e advice: add --no-advice global option

Just a small suggestion...  Perhaps the creation factor needs adjusting
for the range diff to actually be produced.  To be clear, I don't mind
that it's missing here.
