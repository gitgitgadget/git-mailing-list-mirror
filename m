Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B125DB12
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479237; cv=pass; b=GFwcMp6GpxeXJsYLbeB1NzMD9cq+4HLdT7VggeqihzhyRIqtNeLGDG/lqyhkhY0ivFmKKmZfGI2i1hILCu/kPcnDK0BYd8usxhNAoh/TpdFNyJ2O/VCkAkp4dg+TuF58vz/4TYSKHlPEwlfx+59CMVqxpryyBUpIHn3Rw9wxBPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479237; c=relaxed/simple;
	bh=PlIhux+x86Wk+JEBE0HhswvyrwexmXSjqSnUpDuq+jI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKNATnAkE950IH9TXh7td6uIAqXDmr0Py2rKVlePMOhnrnjL/r7MvWex+/STgQ+O8j8PoLTo3N2XApHLTIbTxZZnX/H3jhRhW1JoayxJrsCHlW7KD1vL0CZXomdeji14WQGKw/HXBmi0EpGqSmn8wzRqf7IDKqeyGP8ORU2vZK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YSt8mvfW; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YSt8mvfW"
ARC-Seal: i=1; a=rsa-sha256; t=1772479227; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JmzeNJSuIGJmnZiuq7Y+0W1+BNcPewjweiAFibLXQbMD2GS1wf2WJdrOlsmgm/DTh1NnS0ivgLrQ82gO4D2VtM5i5iDpLDVI5sYthaIumN/rwKC/6yCBtyCVu8tfow0tFT27Z05C2JUbpgy6cfXEuqSjnthU9MElNJAS2OKKrjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772479227; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MJQkkpadr6UuHmttdNjTr1SIrwbj+pPO4UGfGfaZ9B4=; 
	b=W0VSYyWW0QQGhx44I4s28haK3/+ZdWhFHZXEOUsGMCJp7kRxfDC25jByGFT70krgDhB7JSHaSq+Pp2PqcNZd0RNdDsRBIdHCZSwQFSM0V0dUBtnWBd/IUJiXOlZzpdddH0oEhYX8TEAiuhtooTjruSw/8lbIqFGcYelcHwplDog=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772479227;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=MJQkkpadr6UuHmttdNjTr1SIrwbj+pPO4UGfGfaZ9B4=;
	b=YSt8mvfW9+2LoI/DBdklxnlnuAWupTnCnkFRhGAASZ/Guz121gFOUqSmd98ptREE
	ol7wDc2td00owHtHrfzs8OcXJd29RS0XV6SVgo8aAa9AONXhznuzebJRPsVqilx5JJM
	JsH9Ep6p3E/MZhHrTT3InjztcOHmzl1TN5vKWG1E=
Received: by mx.zohomail.com with SMTPS id 1772479225809287.9009812796214;
	Mon, 2 Mar 2026 11:20:25 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #11)
In-Reply-To: <xmqqtsuyyrrc.fsf@gitster.g>
References: <xmqq8qcdof3f.fsf@gitster.g> <aaVPY9b37zY8SLup@pks.im>
 <xmqqtsuyyrrc.fsf@gitster.g>
Date: Mon, 02 Mar 2026 21:20:23 +0200
Message-ID: <87cy1mox6w.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 02 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Fri, Feb 27, 2026 at 05:02:12PM -0800, Junio C Hamano wrote:
>>> * ar/run-command-hook-take-2 (2026-01-28) 12 commits
>>>   (merged to 'next' on 2026-02-22 at 4aa543f115)
>>>  + receive-pack: convert receive hooks to hook API
>>>  + receive-pack: convert update hooks to new API
>>>  + run-command: poll child input in addition to output
>>>  + hook: add jobs option
>>>  + reference-transaction: use hook API instead of run-command
>>>  + transport: convert pre-push to hook API
>>>  + hook: allow separate std[out|err] streams
>>>  + hook: convert 'post-rewrite' hook in sequencer.c to hook API
>>>  + hook: provide stdin via callback
>>>  + run-command: add stdin callback for parallelization
>>>  + run-command: add helper for pp child states
>>>  + t1800: add hook output stream tests
>>>  (this branch is used by ar/config-hooks and ar/parallel-hooks.)
>>> 
>>>  Use the hook API to replace ad-hoc invocation of hook scripts via
>>>  the run_command() API.
>>> 
>>>  Will merge to 'master'.
>>>  source: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
>>
>> It would be great if you could hold off merging this patch series for
>> now. There's a rather steep performance regression in the "update" hook
>> caused by this series, see also [1].
>
> Thanks.  I'll be expecting an incremental update for this.

Fix posted:

https://lore.kernel.org/git/20260302191704.1814567-1-adrian.ratiu@collabora.com/T/#t
