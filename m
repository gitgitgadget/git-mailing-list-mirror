Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC12FB6
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732151413; cv=none; b=fT3TSTuSdK2mZfR98gvUYGLoPmnXiWPkxUt1NszZ4Tmq5W0WC4wMnAXf9a5yky/4n7919kxfN1gTFCIcogTOUduEIZVkT6HbmSDFbPHl4M9HWVyX/BsSK3KfslVcmgJ7xWG+TUdwQ6qrV0/ks2mATEDgqBPxdeyEvM/BurbLlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732151413; c=relaxed/simple;
	bh=A0xLcaLMVJ2MvNf7ytBPvJTRn9BaC3J3RCI1LmJ7H3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1B+hZqvu8Jp0A1rGtia3swa0UwlrAq57BSwHS3KjgdBOQo4r4kCNu2bW98mcZXyGMvcw3E1+pDxkMmy15c3LZOytkU4GiJhp9se1kV67KoY/aICYrxQP2hpJQL/A9IPhEv3jfSaS2kcowZhhlsm0nF1LHf6S8PWImnrschDFio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZHUQ3IsZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHUQ3IsZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9263825400F6;
	Wed, 20 Nov 2024 20:10:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 20 Nov 2024 20:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732151409; x=1732237809; bh=Og7ebRfEKKUWUzgFXYcbZ6nrSQbHW15cw+W
	IQths71Y=; b=ZHUQ3IsZ58P4FUJAP+WqXAyAc1UyC2Wt1AxkYNmCTa83qxM2C/j
	xCHd/y5L0O71KCAkA+0H9Me8x/tPIxGwhi8sXg4YIwKHTTqwNB1lXRp+2bqspO85
	SynrYJfHVln6gBQbc4EyA9TTpCqcvxoPG/zpFNMVzosYRVpWHpL3hgsaPcktr36W
	JBkNtY+KdIv6l4gLfgtUph2hJWzWfeoLr6dRc+h57C5qEGdpNeSTY+h09ZNIfyCQ
	H2k6WxMDdpu559B4WVSG4L0I1AKzbckdnIKSvlo7nPRnpMyVj8fOH445UvsRGgW0
	FX0FM6xAt4e3Ia3iJiUYdjaiCbiIHXS7EGA==
X-ME-Sender: <xms:cYg-Z5OAfF994qlEu5hj3e4yKZ3c_Bz8hqt0hokD8RqSuzlVXfpsag>
    <xme:cYg-Z7_sAM0BazZZBaGrl6Ni_MHg0QBIoIjr2gIEaasS9CSM-FsYGsVctSLWPmLlN
    kinIWShjz2rauvYeQ>
X-ME-Received: <xmr:cYg-Z4S_jPc7e1CapRuQ5D8MmVBqMmd57RK75Ck02HzFneUl-RumlF-xYq8NQ_Z2Rohld0PdhyBv1CG6XK1ENdWcmtV-VpVqHuDF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeetffegkedtkeehtdeuhfdtheeliedvvdekuefh
    jefhteefieeuhfduvefhkeduleenucffohhmrghinhepshhhohhrthhlohhgrdhpshdpth
    hhrghnkhhsrdhpshdpmhhishhtrghkvghnrdgttgdpuhhprdhsjhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:cYg-Z1uPkSVKI233eCcKpq4r7yVTKqpYuKIQLAW3g-0Tc4Dr2pwG-A>
    <xmx:cYg-ZxeQ7RMfWHd6gMHkQ4HYmxHL368RD3ZuE8qL4OdXMaY9_ZxqYw>
    <xmx:cYg-Zx2gtTNPO0n_Sawk4w2fEj4jDJRsnofCeP5GHGVWxl0jHmYmiA>
    <xmx:cYg-Z9_LiGV4KUUaz23dvZh40aPgbIeMZTlizG1vGDCbUn2LHuPhbQ>
    <xmx:cYg-Z5Qwp0U0Z6VFUbBPXByl-uwN2nX8eEBXAdoFOQJoq3xDSxyt4L3q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 20:10:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  shejialuo <shejialuo@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
In-Reply-To: <Zz27kX159PKAmBOb@pks.im> (Patrick Steinhardt's message of "Wed,
	20 Nov 2024 11:36:10 +0100")
References: <xmqqo72ai929.fsf@gitster.g> <Zz27kX159PKAmBOb@pks.im>
Date: Thu, 21 Nov 2024 10:10:07 +0900
Message-ID: <xmqqmshtfl3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Nov 20, 2024 at 05:49:34PM +0900, Junio C Hamano wrote:
>> * ps/gc-stale-lock-warning (2024-11-20) 1 commit
> ...
> I'm never quite sure whether I should speak of the command or the code
> unit in this edge case, but this message here seems to indicate that it
> would be preferable to mention the actual command instead.

Either is probably fine, but when the commit describes a fix or an
update to an end-user observable behaviour, the command name would
make a better label to appear in "git shortlog".

>> * ps/send-pack-unhide-error-in-atomic-push (2024-11-15) 6 commits
> ...
> I'll review this patch series later this week.

Thanks.

>> * ps/leakfixes-part-10 (2024-11-13) 28 commits
>> ...
>>  Will merge to 'next'?
>>  source: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
>
> Toon left another comment that I'll want to have a look at before
> merging this to "next".

I guess we now have a hopefully final reroll, which I saw and picked
up.

>> * ds/path-walk-1 (2024-11-11) 6 commits
>>  - path-walk: mark trees and blobs as UNINTERESTING
>>  - path-walk: visit tags and cached objects
>>  - path-walk: allow consumer to specify object types
>>  - t6601: add helper for testing path-walk API
>>  - test-lib-functions: add test_cmp_sorted
>>  - path-walk: introduce an object walk by path
>> 
>>  Introduce a new API to visit objects in batches based on a common
>>  path, or by type.
>> 
>>  Comments?
>>  source: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
>
> I think what's interesting in this case is the incompatibility between
> the path-walk API and bitmaps. It seems like there is some push back
> based on this, but from my point of view the path-walk API still has
> uses where bitmaps don't matter that much, like in the proposed new
> git-backfill and git-survey tools. Both of which are of interest to me.

Yup, I didn't have a chance to carefully read what the new code does
yet, and didn't get an impression that anybody did either for v1 or
v2, but I may be mistaken.

>> * cc/promisor-remote-capability (2024-09-10) 4 commits
> ...
> Chris is currently writing such a doc that tries to clarify the bigger
> picture. So I guess we can evict this topic for now, start to discuss
> the vision and then once we're all on the same page start to think
> re-submit the topic.
>
> I've Cc'd him in case he disagrees with me.

Then I'll wait for Christian to speak up.

>> * sj/ref-contents-check (2024-11-15) 9 commits
>> ...
> I've already reviewed this version and expect a (probably final) reroll.

Thanks, I saw that (hopefully) final reroll and picked it up.

Thanks.
