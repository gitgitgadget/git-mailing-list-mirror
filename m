Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82161B85CC
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965375; cv=none; b=OGqbm3qi0tVnS1OdvwhMS4UAin5NJ1FE/FsicFHyE25hSz+U0eT54zTQVQhSmQY+xnH6b4LBLHIlF5Q1/lo63ZMld2+69vp04vJ6NHNfrE+8gnB/Ykp85j9+BkLrALDLkqSSg6pJi+aszZbr+v0u5gzG/qx8zZ9Hkumc+qcZRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965375; c=relaxed/simple;
	bh=S8V+ONTqQleJFYffrLUPykm7ecdnbW8GU1aWpPyZNlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e93B/SryYVWdJxjwJ7/ELvETQYNkuB39x1mDmeUyWQ2oFa22KgQvbMR91C8mBNq/F1+p+kmQSqx/oWrUJDrz47fQj/6MVCGDBRQKS5nbNVDoPZ9Rche7bsvg3K8mHJT8PTTxuBi0/DuMRC0Oqx3t2h7ek/bCSc5arSEmW2/fqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.103] (089144220218.atnat0029.highway.webapn.at [89.144.220.218])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4YyZJP6DxSzRpKn;
	Wed, 19 Feb 2025 12:42:45 +0100 (CET)
Message-ID: <67441cc0-ff56-4159-b080-868161605bf6@kdbg.org>
Date: Wed, 19 Feb 2025 12:42:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] gitk: extract script to build Gitk
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250218-b4-pks-meson-contrib-v1-9-c3edd292beb8@pks.im>
 <xmqqeczuj3fc.fsf@gitster.g> <Z7Vxx_yQSMlXfteX@pks.im>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Z7Vxx_yQSMlXfteX@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.02.25 um 06:53 schrieb Patrick Steinhardt:
> On Tue, Feb 18, 2025 at 02:25:43PM -0800, Junio C Hamano wrote:
>> You would want to coordinate this with Johannes Sixt, who may still
>> want to maintain the subtree arrangement.
> 
> Anyway, Johannes, I'm happy to evict these changes from this patch
> series and create them as a pull request against your tree. We should
> then also be including the project as a `subproject()` so that it can be
> used standalone.

We can do that.

But there will be a time frame where the Git repository already knows
how to (and wants to) build Gitk as subproject, but the Gitk repository
has not been pulled, yet, and is missing the corresponding Meson
instructions. Will this work, or should we wait until Gitk's part has
been integrated in the Git repository?

-- Hannes

