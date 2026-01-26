Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F31E7C34
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404492; cv=none; b=Qlxw/NNUgCXHILJFGdXqJz/jbgkZ+ic2XN2HQTASbLYMLEj/SJ0f3q1eBF0kL+6N7K745Mox7lrFWwq+p83VnemGVSz0VO1VKbvI9Sc5CTlBpnLOIfdJWD0IdWs6t/4a1JWfvMJJ9DAQnhGWje3pUxKTKWz7ck/vWhS3vn5EeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404492; c=relaxed/simple;
	bh=eWaHxCk9CbWbVX/MtNhmSQ4Em6AiZNaTSueBEowbJVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkgsuEZrwtM42boTM+UZWp8delqxQX4M3EKh7ualpJGCa9yhtTvJXKvNH2bqvc8k0jRjY+gmBqHaMe4t706BWu+gk/XzBiEM1Eam+uWGRWJmdzVlxpx0ZX8Cx7HtoHvivEdtqtJqVFA4WSN1bfEh/Nyo4X3h2lnvmQIUmX1QDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=T2SHiVds; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="T2SHiVds"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vkEvu-005ALN-Iu
	for git@vger.kernel.org; Mon, 26 Jan 2026 06:14:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=hrgfG+jxckZBMWzZc5POUVxO+WMia2tH5fodEHIZZYM=; b=T2SHiVds1yyWkhM/yeSjlYkSZs
	+FqzicfaW3lhWMbO8j1PhX4KxHSjlpmPM+tcgm1Msfz7xRgm79i//CU5qldAWSCIvchHjgpr4RjPC
	MXQEfLovqtm2oV9hCkqSNL24nThZiimYT285b2COeyJJwBXYQXkyUKEWF/LR7K5j8XHCQbx/O9qdA
	SCggpnGkW2AbD2MIltG5BBq4ovYBhUMoPLj6oGI6hklz0mLgq4D2QYJ1wsv5ziGMKxg197+oGS7HF
	KXkS2XNLaYlSWUaJ4BEsOK3fsmvzh9/PqquA8Xf303C8FkrLmvxvgnfdvxjT0/NBJmneKNCQPtrZb
	Pult9ngA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vkEvu-0006iH-2s; Mon, 26 Jan 2026 06:14:38 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vkEvk-00BKD6-IV; Mon, 26 Jan 2026 06:14:28 +0100
Message-ID: <023ae712-8f67-441c-aada-fb5b097ec617@howdoi.land>
Date: Sun, 25 Jan 2026 23:14:25 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression][bisected] git-subtree remote desynchronization
To: Junio C Hamano <gitster@pobox.com>, Christian Heusel <christian@heusel.eu>
Cc: git@vger.kernel.org, Christian Hesse <list@eworm.de>
References: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>
 <xmqqikcql8cq.fsf@gitster.g> <xmqqecnel2fs.fsf@gitster.g>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <xmqqecnel2fs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/24/26 22:51, Junio C Hamano wrote:

> Unless a fix materializes and gets verified before -rc2 (scheduled for
> coming Tuesday), we should revert the merge of the problematic
> topic.
Understood and no worries. This is a surprisingly complicated issue, and 
while I've made progress I don't think I'll have a fix that is mergeable 
by Tuesday. Feel free to revert as needed.

The "exclude other subtrees" logic was first introduced in 98ba49ccc2 
(subtree: fix split processing with multiple subtrees present, 
2023-12-01). It was intended as a speed optimization only, but every 
iteration of this logic—including mine—has changed the `git subtree 
split` output in at least one practical repo.

I am becoming increasingly convinced that any version of this logic is 
likely to change someone's `subtree split` history, somewhere. Our tests 
just don't cover everything that might be out there.

The documentation promises that,

> Repeated splits of exactly the same history are guaranteed to be
> identical as long as the settings passed to split are the same.

Maybe the safer approach is to gate this logic behind a new CLI option, 
like "--fast-exclude," "--ignore-other-trees," or something to that effect?


On 1/24/26 05:43, Christian Heusel wrote:

> 1. Update to the 2.53.0-rc1 git release candidate
> 2. Clone my monorepo for packages in the Arch User Repository:
>     ```
>     git clone https://github.com/christian-heusel/aur.git && cd aur
>     ```
> 3. Push changes to one of the contained subtree remotes (this would normally be
>     done via `aurpublish google-chrome`):
>     ```
>     git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-chrome.git master
>     ```

I cannot `git subtree push` to your remote, but I can instead run:

     git subtree split -P 'google-chrome'

which happens internally prior to the push.

Before the bisected patch [1], running this on your aur.git's master 
branch [2] generates a split commit with hash:

     e6f4613797c0eea5a8939441a1fb58211e9184e0

This is the result you expect, right?

I am also testing the other subtrees of aur.git to make sure none of 
them change, either. With the patch reverted, none of them appear to.

I have made some progress on a fix, but I have not yet achieved 100% 
hash equivalence across the board. The bisected patch will likely be 
reverted while I work on a more permanent solution.



[1]: 28a7e27cff (contrib/subtree: detect rewritten subtree commits, 
2026-01-09)

[2]: aur.git@29bfddf (upgpkg: rider-eap 1:261.17801.69-1, 2026-01-24)

