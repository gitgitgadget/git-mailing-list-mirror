Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EC1AC89C
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198178; cv=none; b=gzE/pOmAsop/OvHtnegllPWumoSiUaxs0jjA3MClk9gFARf0WeYw3FoCNXjEPMOeEX4rSa4MLDdnJpJ7HGBDwa0HweyXSoQUw61wvYvtKA8zLJHPzOHzmETBpEOVkwUgSKsnOuMnb2/lHJ91Fm5GpGrAjf3GVZK3ARSq8I7+Yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198178; c=relaxed/simple;
	bh=DFUNXdVeq31sCumCIBRKuIhucrriBPOEbEo51iPnnv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nSRFQis5lsssL8GxA2FWozWjEv0czzjrDK4TNaXDvyhxXAcvt0w7xl9P6VKW36UyuEXI/iNT3PC8wgmZkh+IxXZR0cohKR2NMC1RmMSYIWw4s6ki4Swtn0LvkoPGbJuTJt77kQgcIJRmG+xeJWAZmg2iGDBsq4ZCnUPGpzMLwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RysKzWId; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RysKzWId"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F598365A7;
	Tue, 24 Sep 2024 13:16:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DFUNXdVeq31s
	CumCIBRKuIhucrriBPOEbEo51iPnnv8=; b=RysKzWIdLsLPpd31+leZIQXA1qHn
	iJXgWs2yl7ryY/iwG02ZHyXt4lY5AB5kyZBE5czTLoEa/zUyM0w5fALhyAjvWvp6
	m4jem3ioCZH983B1rbl6pqoqKqbzvJeELPHJDrdf+yz3r6APTgaxyiTyxW/J6G8c
	8EpyB+cD05FhhiA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E51D365A6;
	Tue, 24 Sep 2024 13:16:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C541365A4;
	Tue, 24 Sep 2024 13:16:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>, =?utf-8?Q?Jean-No=C3=ABl_Avila_vi?=
 =?utf-8?Q?a_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Chris
 Torek <chris.torek@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v5 0/3] doc: introducing synopsis para
In-Reply-To: <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Tue, 24 Sep 2024 07:08:47
	+0000")
References: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 10:16:10 -0700
Message-ID: <xmqq5xqlug4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B3A10DD0-7A98-11EF-9E62-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since V4:
>
>  * used BRE in sed filter
>  * rework the processing of three dots

The topic has been deep in 'next' already, and I wasn't expecting a
wholesale replacement.  But thanks for updating.

As the patches are more in the technology demonstration phase by
converting only a few pages and making sure other uses of `` outside
the synopsis section in unconverted pages are not broken, we can
declare that the three-patch series will not be in 2.47 and will
keep it in 'next'.  So let me revert the merge of the previous one
out of 'next' and queue this one afresh to 'seen' to see how well it
works.

Josh (or whoever is taking over this week from him at Google), can
you see if the breakage you saw that stopped us merging the topic
before it causes us trouble on 'master' reproduces with this version
(either by running "make doc" on the topic branch by itself, or on
'seen' that merges the topic) in your environment that had trouble
with the previous round?

It would also be highly appreciated if other macOS users try "make
doc" and see the resulting git-init and git-clone documentation
pages are reasonable, both for the previous round that has been
cooking in 'next' and for this latest round.  Inputs from folks on
more mainstream platforms with modern asciidoc/asciidoctor toolchain
would also help.  The more people we have who look at how the new
way the synopsis section is written and how the resulting documents
get rendered, the more fairly we can assess the value of this topic.

Thanks.
