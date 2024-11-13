Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86517C22E
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485452; cv=none; b=Wqb5mFc5KuXpmOW1ik8y68/MICoAOpukv3pYvxSQrkoMp2gT6w8eTlOYPxUSNakTYp5JBP6He4aRpwBDO/WOp9KNwPZbGIwAfKaI5T9+Eb2HI1iKwynibUdljfNVPzem/9CfrTZ8fA2EgK3Gx3EyKCoDr2MdQ3ld7LcpmsCXP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485452; c=relaxed/simple;
	bh=07v8iYfYgnUxp5DEQtB/q6cMAL4984RtQjNRwbZ6ges=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf3fZtqdwQBo/9OrbLFTBsBkZvBg2E/bxfAQYMPjA2tRwSJi5p1Pb+F6NIsrlkozk1KbhcC0SsAWOcF4WaF5lLh6hgc+Nng2c+b0mBBCaINMNMUbaLCW7W/U8uEhy0I1OrSeSYJIHW96+6XabNsMQt0XUfuYK/G7cKQhyho1rU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HCKBoHSp; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HCKBoHSp"
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 19BB16013E;
	Wed, 13 Nov 2024 09:10:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1731485447;
	bh=07v8iYfYgnUxp5DEQtB/q6cMAL4984RtQjNRwbZ6ges=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HCKBoHSpbqrLSZV2+wOcMbowTiFoL1DhWJiVwoyOA/dVdCqwk/J22Q9E3JXYtbczP
	 pyj/g5b3us9mnZ8rIwMNQq2aFFh6C7wwzcG57uaxyTGmWWnaYUXJtvqu1IhQrPzrse
	 XkfOrSoJOD9tuSUzzRILwajI2QocVbSIvGCP0rJFcLBxyRxTYJJ8cnO5fE3jXTqHw8
	 DChHGraFC394hRqeDX5mD9Ikkshq39nkKpsDxTH4wHcE5987mCH+7iFJR0JACF9IAX
	 CRu8wBnoDBefBaIphhyjs2fSoj/mQUNjFG0wO5MAKzoSBi/M2Srgdu9Ro8vO+IKz4e
	 TWWHvWhmFnfJg==
Message-ID: <c9653435-d884-4aa3-8ee1-cabe19a2c552@free.fr>
Date: Wed, 13 Nov 2024 09:10:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] doc: git-diff: apply format changes to diff-format
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <8fec37ee17481039998af65ce1abec753cf30897.1731343985.git.gitgitgadget@gmail.com>
 <6c1c1ae2-f38a-4458-a9ad-2fad3e56fc32@kdbg.org>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <6c1c1ae2-f38a-4458-a9ad-2fad3e56fc32@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2024 à 19:51, Johannes Sixt a écrit :
> Am 11.11.24 um 17:53 schrieb Jean-Noël Avila via GitGitGadget:
>> -The raw output format from "git-diff-index", "git-diff-tree",
>> -"git-diff-files" and "git diff --raw" are very similar.
>> +The raw output format from `git-diff-index`, `git-diff-tree`,
>> +`git-diff-files` and `git diff --raw` are very similar.
> 
> Throughout this document we see a lot of commands with dashes `git-foo`.
> Does this have any significance, or should they be corrected to the
> dashless form `git foo`? It could even be a "while at it"-change as you
> are touching every instance anyway.
> 

OK. I didn't pay attention to these points until now.

>>  
>>  These commands all compare two sets of things; what is
>>  compared differs:
>>  
>> -git-diff-index <tree-ish>::
>> -        compares the <tree-ish> and the files on the filesystem.
>> +`git-diff-index <tree-ish>`::
>> +	compares the _<tree-ish>_ and the files on the filesystem.
> 
> Now that the backtick formats the content as in the synopsis, why is it
> written _<tree-ish>_ and not `<tree-ish>` in the running text?
> 

With the new processing in place, this is identical in the result. But
for the writers, I would still push so that the form _<placeholder>_ be
used to remind them that keywords and placeholders need to be
differentiated.

Moreover, in case the special processing macro is not applied, the
markup is still correct pure asciidoc, while generating a "not so bad"
output.
