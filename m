Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF034DB58
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064474; cv=pass; b=JM9JZe6hffx0eTXCS/ADo4xtyc+Cr2mvv1OAUxZ9Q3Ja5GzGWROjFr4+j1Ykn++h2zDe8+mE5GMBIDpdbf8mvlCt/qHoYj7dWdX2uub066xs6vA1Iq3T+6mOWFEGC3dSx51j3lZYG3MxhhoJbdiAcTjKKNnNk/zysyPWjj+9ODE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064474; c=relaxed/simple;
	bh=qOPy6/7v87VyJlcYEzChd8cxXHYaHIEbVqgwrSuBHkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQkKHbXRYbogbHu4bu6krcCzfmx0byn2y3xI9G510RqQsPW94K1UFnwZ8iuXFn2VSmwSr2vPUhxPZtj0gPtCux7OFFOi/xqtI42ATVaq9HGklXQy+N/xtIi396QqnzEDKGJroS384qrpLG5Hku5yKPISLMNMTm+OaOvtQONcW9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=UZUdQx9B; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="UZUdQx9B"
ARC-Seal: i=1; a=rsa-sha256; t=1761064462; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=btLBM2s/fxgFl29mC9lIMsplJqTA8cNAGwR0SeAlTkbu8kbSNetFHV9WsaMY8o4m1XNsF1aP7viJV3A8u22yjFaXQZL7jKVZ/J21N3GWCrrYHmhxtF0inZpdx5wBmf91ptOauHssKaJIbTufhKKPRjCVRg5Lqmme1i79AgP58f4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761064462; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XP8Cxrmo+AvB54Z1m1Hgq6Hz+HlZYK9rFD3KBwLCCZ8=; 
	b=FhsAytDrEDSBfF2Y96ec/LpwFl4vS4iJE6+LpkQ5eX8S4sTPFYeQypso3j3TMCHI/0KDFHEB7xjf5muBXage/TQoGryOWRhUO0BuVoWnlpFQLwC533lscO6Q73wDgL0M3XRkADmtOYk6a49PPGs5ddSobnhlzZjVmN0jKsu176I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761064462;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=XP8Cxrmo+AvB54Z1m1Hgq6Hz+HlZYK9rFD3KBwLCCZ8=;
	b=UZUdQx9BhivrpP/3kd/2DIvpVcOFD+a3ikdwLDfrT529YIEcmszuVSHlMVP3lvka
	p9zCsUjyY5/LBqkMCmiUX3h4mDF3qfnElpbnfRfvws/q54ygBkdYRk+DFdoW/+aCBAq
	+9t5KWPmmC1Aj3gXso6XQv0cVdZy448TImvnVcig=
Received: by mx.zohomail.com with SMTPS id 1761064459876106.54946922711383;
	Tue, 21 Oct 2025 09:34:19 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 00/10] Convert remaining hooks to hook.h
In-Reply-To: <aPc4_Pyd37epd0j4@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <aPc4_Pyd37epd0j4@pks.im>
Date: Tue, 21 Oct 2025 19:34:16 +0300
Message-ID: <87ms5kp62f.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Oct 17, 2025 at 05:15:34PM +0300, Adrian Ratiu wrote: 
>> Hello everyone,  This is v2 of the series which converts the 
>> remaining hooks to the new API.   I addressed all the feedback 
>> received in v1, with two small exceptions (the ones starting 
>> with "Opted not to" in the below Changes list).   I had a minor 
>> conflict with an upstream change [1] which was trivial to fix. 
>> I added 1 new commit and squashed together two commits (the 
>> simplified update hooks), so in total it's still 10 patches. 
>> The plan is to follow this up with another series which enables 
>> config-based hooks and parallel hook execution, where possible. 
>> As always this is based on the latest master branch, I've 
>> pushed it to GitHub and ran the CI pipeline [3]. The Win+Meson 
>> "missing libgitcore.a" and doc "invalid escape sequence" 
>> failures seem to be unrelated, since I get them without these 
>> patches.   1: 
>> https://github.com/git/git/commit/22e7bc801cd9c5e5b5c4489b631be28e506fec42 
>> 2: 
>> https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v2 
>> 3: https://github.com/10ne1/git/actions/runs/18593709082 
>> Changes between v1 -> v2: * Added a new commit with a mechanism 
>> to override ungroup options (Junio) * Addded a BUG if hook 
>> path_to_stdin and feed_pipe are both provided (Junio) * The 
>> feed_pipe cb can be set independently from path_to_stdin 
>> (Junio) * Simplified the post-rewrite callback (Patrick, 
>> Phillip and Junio) * Document that hook caller owns the 
>> feed_pipe_ctx (Junio) * Removed unnecessary "child" -> 
>> "notes_cp" renames (Phillip) * Reuse strbuf inside pre-push cb 
>> to avoid multiple alloc (Phillip) * Simplified pre-push hook cb 
>> logic (Phillip) * Rewrote reference-transaction cb logic to 
>> mirror pre-push (Patrick) * Simplified the update hook cb by 
>> removing the keepalive logic (Emily) * Squashed the simplified 
>> update and post-update conversions * Iterator types, if 
>> conditions and other small fixes (Patrick) * Fixed a conflict 
>> in refs.c with an upstream for loop sign compare check * Opted 
>> not to use -1 to signify no fd value instead of 0, because I'd 
>> have to 
>>   significantly rework the run-command.h .in/.out/.err API 
>>   (Patrick) 
>> * Opted not to move sigchain_push(SIGPIPE, SIG_IGN); into 
>> pp_buffer_stdin()) 
>>   because it will called too many times inside the process loop 
>>   (Patrick) 
>> * Added Helped-by: Emily Shaffer tag to the 
>> reference-transaction coversion * Comments, typos, stray lines, 
>> commit rewordings (Ben, Patrick, Emily, Junio) 
> 
> By the way, it would have helped to have a range-diff here so 
> that it's easy to see what exactly changed between the two 
> different versions.  Could you maybe include that in subsequent 
> iterations? 
 
Sure, I will include a range-diff going forward.

Thank you again for your very awesome feedback,
Adrian
