Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5F337BB2
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392961; cv=pass; b=tQr71nbwWuEouh3rNmUNmnPDLB+OCn4wQUDfwUEFyZTGFPlv3xgAaVaLHk2zcafsoQZtrnxI518bCfecV2i8IW89vaH4g2P0RjH4uBCcBmQ4wbdk9soIzEC4AOmmFLxpG1eQoktoa3QQY81MqfaBDx8EIgixag2B3zRTF3Nb0UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392961; c=relaxed/simple;
	bh=aHg7pS7FqvV5EyWaXHJMbBquyIbJwxeDkSNY5ZpwSfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J9H9K9WkjXsjBePIAYT+Pn+Ogqh5oW6ukIfeDM/6zAeHN3UHRo/eaUgXdjFJF0kuO5RWkq5AKz7ZlwGQ/gGpZP1z2YkkBqEesx74+HsT6uBcaoG/W1/bNiNjfkwUmGo9IBIWzlqbcbS1R4KrZTqGZdKvUCqSVGKcS1qFyrq7Tgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=S04U7I71; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="S04U7I71"
ARC-Seal: i=1; a=rsa-sha256; t=1763392941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YvIro7q1jQlI9NcKGupXfrSqxX8WEECGQhU3PZKg473y3hWqQuaurUdliL5CUIceSDvL40GkCFPlwkbZtPL1UcPiBbDb5WF68BZcnrn3/zRogmuD4B+4G+2XOFBdhPq09XXwLY7ym5w0apzwv/wTKvze6SObKvudJZlZOorpK78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763392941; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Nt/Pe8HK+EdGRg1I6Fzn5tWaDHgSkoYna/YNHKGJhSY=; 
	b=lv+nxglE0U52Cd7nBdSAwHKYT1286LlLLCkJuKeXw8jvM2DA8Q4jyGcMcHyxDezQChkRh4aPK83Ik7zUaA3dUPjcTWANfxTdYBUgoU8S/TCP9UhhfvxXPuXOiDezmUJT9nfnK2od2W3ReiU93cr1PDQmuCnh0dQiZNQHKUUYszU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763392941;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Nt/Pe8HK+EdGRg1I6Fzn5tWaDHgSkoYna/YNHKGJhSY=;
	b=S04U7I71dPPHeTh2dBEchxGv8uvnx7g64NJ+wWSho6zvgdQagebSgNYJz/0PPu88
	t3tysojt5Yc3r8NT8jz5dRp+weIK9zjWIRyweD/SNJey8RTx7axg3341aAc8znpU89e
	geo39+DoPO4bcrEGWffl1Lc50L0YThl/maBOcWrA=
Received: by mx.zohomail.com with SMTPS id 1763392940104949.2299884219357;
	Mon, 17 Nov 2025 07:22:20 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 0/4] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <6m72swbxcm2gi2wtvgc4yxid3o64qbuckzzguzg3mzd6rmrvx5@i55v6c2nq5e4>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <6m72swbxcm2gi2wtvgc4yxid3o64qbuckzzguzg3mzd6rmrvx5@i55v6c2nq5e4>
Date: Mon, 17 Nov 2025 17:22:14 +0200
Message-ID: <87cy5gbs61.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

Hi Josh and thanks for testing & the feedback.

On Fri, 14 Nov 2025, Josh Steadmon <steadmon@google.com> wrote:
> The switch to using an extension may complicate our migration a 
> bit.  Background for the list: Google has been using an early 
> version of this submodule encoding scheme for years. We have a 
> lot of users' repositories with this encoding scheme in place on 
> disk, but with no corresponding extensions.submoduleEncoding 
> config. 
> 
> I've done some limited testing; the good news is that it looks 
> like using this series with pre-encoded submodules still works, 
> regardless of the value of extensions.submoduleEncoding. It 
> would be nice to add some tests in V5 that we can create some 
> submodules with the extension enabled, and then disable it later 
> and still work with the encoded submodules (and then maybe 
> enable it once again). 

Yes, I'd expect forward-migration (enabling the extension) to be 
very smooth. I will add some tests for backwards migration 
(disabling the extension) as well in v5.

> 
> The first difficulty I see is that there's not a good way to 
> automatically migrate existing repos to the new extension; we'll 
> have to ask users to manually set configs on each of their 
> repos. While we are able to distribute default Git configs for 
> our users, `core.repositoryFormatValue` and `extensions.*` are 
> obviously special cases that can't be applied from 
> non-repo-local configs. I don't know what could be changed in 
> this series to avoid the issue, so I guess I'll instead just ask 
> the list for ideas for automating this migration. One idea is to 
> carry a tiny downstream patch to force-enable 
> `extensions.submoduleEncoding` regardless of the local config, 
> but maybe someone else has a better idea.

I propose to use a build-time configuration option to force-enable 
/ set the config automatically for these types of situations.

This way you just add a flag to your builds and don't need to 
carry downstream patches, though it could also be solved with 
one-liner downstream patch. :)
 
> 
> A second issue is that we'd like to be able to set 
> submoduleEncoding for new repositories, without requiring 
> passing a config on the command line. Perhaps we could add 
> another config option analogous to `init.defaultObjectFormat` 
> that we can set in our locally-distributed config. 

This will also be solved by the build-time config option I 
proposed above.

I plan to send v5 soon and I'll include these changes, if nobody 
objects, along with everything else I've got ready.
