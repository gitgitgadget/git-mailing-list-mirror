Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F662494D8
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460726; cv=none; b=iuYf0dgwTX0Jv3xGW8ubuHzgGXzjuyQZdK/hneiS7p2qii1O8PBj+ZjDEMBqcMvUsbV+KL9NMalrxgQ3NRt5i1WpzkmbHz/kuQ+QxHjgQuW2w/t+2sHuT5FIZBCHpRZtlSziKV2qTb03SMm+fx80zyB2qCmd1aNPUCjR8k0og8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460726; c=relaxed/simple;
	bh=T3lFi5dvCPAqFTiY/CFUGtdgPyiwsq9ewjVv2ZzaTyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LYFWAaVym4iFNgS1Qfvyvj5L6cZAVj/KNhnvG5ZwOAaUnXHLYCmVAsk7ujNpz8Xz9GSZUxkJmp4uksO2SQIgOBg4kskC+tASGzXpc4SYhgeNiaTMRz4H4HrE+tYkSycqVswHxXn5x5oCagRLCTY3iFfUrnjM1AVPVbSdC3u5wi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V635DEIk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T1iMW3KV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V635DEIk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T1iMW3KV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9D1A7A01A8;
	Fri, 17 Apr 2026 17:18:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 17 Apr 2026 17:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776460719; x=1776547119; bh=Lg8iDorqLJ
	eRJB1qyBLrYcGFmT1t27U9CaNQ1wKzjSg=; b=V635DEIkYpg5mwQFkYKUX80c9s
	/LWt89kCkGpTx8gQtURYU6g1+fJZOIyxZ8RoSUJE9IPU4DFNWjnz5rxcuBFIy0Pp
	LzQhcfZr3KlSRzYE05r0z1ZlZXwgN991TRpZrCr+Octtkzw8Cxxne2KH2pv1stNn
	haCa4R+kstv0kbSwJg2pxPoNGS7LU829Q0j0CbXqABJG6WevaMOg2IKgmJCKB12/
	smHG0xxcCPItBQCort8sGlxTlz2fzCEsv19BlAJ5FaX0fJw3d5BOJVXJ07/59by+
	cp3Il5L1IAzpOeo1YR7ckjjfSoooCHEu2n4F6SIhu0rdZu8QPl497hwPnQAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776460719; x=1776547119; bh=Lg8iDorqLJeRJB1qyBLrYcGFmT1t27U9CaN
	Q1wKzjSg=; b=T1iMW3KVk78Y6cvPQA72J1t+0dR9e4xsTtWBwtek7vz54L+Gl25
	R29s9TeeoisCHPeA3LUL/N6ZTJl50ud0kkniIrT99UkxllnmfJ06lTPsuNfDsdrC
	7WkhwkqEabaF2ESNTAYijqcnmcrMqUaEhGmFigEx1YV7oALOg8tMm/0D4v1C1cyf
	SwWXghglWYyt5rsPPZUhMFiMt1WNSOO+AzNFvvQCfokppecXHYnogE3iVQt8Tn1e
	mcZFQOsmuMiStSptX1n+xW3sCtJ2NeV1+qTkfJfdiOVYVBhHwfMSVjY9W/FeixSv
	INL1Vyz88vyK/7iryD4acMPVNGcbobF2pdA==
X-ME-Sender: <xms:r6Piae1tODN6SYkCBDevlMOMddy_-DEHY8L-AbtkS0w43fgBSVJWFw>
    <xme:r6PiaYF8dMGx_bs4xdfi9cM9j9xwct4iPaW5ftnPm18YbByxZ-t6zjoizVF5WwqOB
    04RzJSLLkhQOK94jAeCrwlWChVMH3iaop_1jN0yZhSG1NCfFvfbqg>
X-ME-Received: <xmr:r6Piab72Shnr7Y9kQPuRSC0Umc3DZywj_d_ZWrPF2po3aUo36u9d8jAeV3Ae-dKdCMz59XCtMWwkemHLH9BhD_gNz39JaEJjlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:r6PiaevQ4TLvSKlWbfb9fYY7bqcrrMLP0VPO9nBUhL-RJVo5iM7fpQ>
    <xmx:r6Piac5LvptdAq-r08Z0VTzvhcmYi6b_8njJLdvPs3KKdf_GCMa3fw>
    <xmx:r6PiaZWonxyEoQee-ZACmRXp-KvDqwtccMRPjhSh9ScFEu-Xj-7RUA>
    <xmx:r6Piae-4t8hCMp-d1Y7vW0wRVAVzssimBI9YM56bBcveQoM4hEKa3Q>
    <xmx:r6Piac-5W2TrvPDqHj5KO1dpX22gZvmQ1HhxuqGm-T1BAa8u72ldV3l2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 17:18:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <aeKHhHVPUxqMa18L@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 17 Apr 2026 19:18:28 +0000")
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
	<20260416-pks-libgit-in-subdir-v1-2-03afc731df55@pks.im>
	<aeKHhHVPUxqMa18L@fruit.crustytoothpaste.net>
Date: Fri, 17 Apr 2026 14:18:37 -0700
Message-ID: <xmqqfr4twaj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-04-16 at 13:24:31, Patrick Steinhardt wrote:
>> Introduce a new "lib/" directory and move all of our sources for
>> "libgit.a" into it to fix these issues. It makes the split we have
>> evident and reduces the number of files in our top-level tree from 550
>> files to ~80 files.
>> 
>> This is still a lot of files, but it's significantly easier to navigate
>> already. Furthermore, we can further iterate after this step and think
>> about introducing a better structure for remaining files, as well.
>
> I have not reviewed the details of the patch in general, but I think
> this is generally a good idea.  Most projects in non-C languages put
> files into some sort of directory structure which seems to help
> organization and discovery, so I think this would be useful here as
> well.

I do not mind a move to thin the set of regular files out of the
top-level directory.  I have forever been annoyed by my buil<TAB>
no longer complete to builtin (anticipating either .h or /) and
it would be nice if build.rs is renamed away, or builtin{.h,/}
are moved away, to restore the convenience of tab completion back.

