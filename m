Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D959173
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183015; cv=none; b=B+1NN5brS4U90adZLTTot8ls8iaJcM+OjTKqExH5b4eO/+mAKnOjzIequiR5hu1Ly4lryBdxfuTwtJS5Ki5Oz+FDEZkEOd2Nnr5CdACLL1L1+MjL3uJzLpXXeBg48TbITM8OXxqmI9+FCK3dbjhqy4EkfrWDZXjkP/NaezInqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183015; c=relaxed/simple;
	bh=nR6plZCEL6LPbvmxzq3OaWmAhlrT9/V7zx+vl+azuNI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FQQnp1aaDUnn1Fbmc0yWGNxHXQtVpFMuoqn86QOVpruqIPgg3jzpyJab+WfsimfUdOm+4+/NiMjulxcJbdW93ypzZ8LqeKJZnHkmzWfzj+mhlVXXRDbTQ0u/xFrpIZaNez99s05oDPkCxxKQPXP3QaBoR0Ed7O7tfNjpH+l7gHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IPjtFdod; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IPjtFdod"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710183007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhlNQP51J/sZVXkQSs5dKM2tVO6FrvopbrNHWO4/8yA=;
	b=IPjtFdodGii1ADlWi6W1F939KYfqIreBvm65On2AOZI5+x33fnkZ07ZWffB7ZXBlqeWNF9
	hz9V3X2jw/c7xEbxirOjkS9606ym1SA71GplkJ6Zi8uRZYUcO8Wxvord9JEYdUHIibO/7G
	GhV/ZGjC379YM68dd6KuF1ouOkXiZ2VbAOHiPZMmqf9ow3FgSEnCnHnX/SUXyLUerlrFhJ
	8QZJNo7w4ZwuZ+UDvuENYWsp45UhnaN0r14wFnDSB2TOnpHBn7KyVaTBppBKb6zZ3mpqcF
	w2y0pVsSsdJlmTKRpjqlf+dFPfmNJ7+dz002A4ppQjT91lxwqmNGiXjahGXeIA==
Date: Mon, 11 Mar 2024 19:50:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Ralph Seichter <github@seichter.de>
Cc: Junio C Hamano <gitster@pobox.com>, Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org, rsbecker@nexbridge.com
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
Message-ID: <265e5b2d352c34dfe0625904b3356000@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 19:23, Ralph Seichter wrote:
> * Dragan Simic:
> 
>> Let me interject... Perhaps also a tab character before the "#
>> comment", instead of a space character. That would result in even
>> better readability.
> 
> I'd rather not open /that/ can of worms. Tabs versus spaces, tab size,
> and so forth, are too much matters of personal taste for me to want to
> spend any time discussing.

I see, but please note that everyone should be prepared to spend some
time discussing even seemingly unrelated things when contributing to
a major open-source project.

I mean, perhaps the whole thing with the tab characters may not be
the right example, but I just wanted to point out that the more major
an open-source project is, the more discussion is often required.
