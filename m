Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253456B79
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183305; cv=none; b=bDVyJi5GsPkAUcC80DiojScNjVJr8Qm495yi++vMiSatyVCc6eEgiBj/C1UKschJI79BMy0pfY1CrkcWFMA/Non/QPLO+bHJcPlBJfJhPFM7VVCQ3tr/Tp+klkFQZzVH6awfmwwGdHDag+EnYQddaH1LoKrGyocZqraPTcFTyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183305; c=relaxed/simple;
	bh=plJl9yISY97C9LOWan0s+TyOAQuup1QyLFGYP+ZQ/as=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CVN+3Z3a/9Y7goXIo3len8q+Z8JJpOzR04FRkdGMlKw2nrMik2xfeLSuEdBublX5uItU+BeSbmlv4RERrr4N37s8chuHwv7+zkIFTH0gyBy61Nk4bbLCLnibkT0nWiZUeVAqHJjsGGEHeLlwif6D04OojjOc4X11L0fNBCYvYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rWGHf22W; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rWGHf22W"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710183300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axkozOzRUF8dvJxXikC4zsmMlULReDD8gWoI3Pw6jq4=;
	b=rWGHf22WEGpiBSmjKiCDD00moi0E6EE94qP49v1Ax9/RgFQcJ1v4QbrnqtOqx8y3XxVJ04
	mqMGYdCpQTe8bOEwMMQt0bRkthPtCkIRVHVw5nT2/19Z7EHBiASQnoPPxCMHRdH48uZ22W
	gED6I9axKizBkCAtNSO8Iy8790quR7k/lwP/o/s0paOOF0InfQSxphLLeh507StpQGnAhe
	itOdq479aBN6kMI9EPUtKkZj+JpRLazj96Nz6tHVnv/AwMhZ+jJOeVmm4CjDDtbAHBB86s
	pLL5vlIgxX29mgUomZo20M69/FPI1B9YUnZF1H7g0LnWcpOe/Njt0L3+uyjRXg==
Date: Mon, 11 Mar 2024 19:55:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Ralph Seichter <github@seichter.de>
Cc: Junio C Hamano <gitster@pobox.com>, Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org, rsbecker@nexbridge.com
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g>
 <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
Message-ID: <52cbdb9d1cbdb254dfdac467711becbf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 19:16, Ralph Seichter wrote:
> * Junio C Hamano:
> 
>> For readability, you probably would want to have a SP before the
>> given string, i.e.,
>> 
>> 	variable = "value" # message comes here
> 
> If the user wants a whitespace after the #, they can add it in the
> comment using quoting, e.g. --comment " message comes here". I don't
> think it is necessary to enforce the extra SP, because it is not
> syntactically required. Besides, readability is quite subjective.

Perhaps that should be documented, so the users know what to expect
and how to ensure extra spacing, if they desire so.

>>> The implementation ensures that a # character is always
>>> prepended to the provided comment string, and that the
>> 
>> It is unclear what happens when a user gives comment that already
>> has the comment introducer, e.g., --comment="# this is comment".
> 
> Unclear? ;-) I wrote "a # character is always prepended to the
> provided comment string", and that is what happens. The current
> implementation is meant to be safe, not fancy.

Perhaps that should also be documented, to avoid the "##" sequences
from occurring unexpectedly.
