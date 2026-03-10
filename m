Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26412F3C26
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153493; cv=pass; b=KvBxpF8CJ5FUcqau4wUQZf7TeX3JenevCJ+1h6m6ZC/F8LiwgtpMPDF65GjBd7z3gIr4XcDBfxxF/X6QtGbklIpEag9S9B4JrlmRcDPFz/MmYhakzpukPCAF2mSpArjBuhInlgu56O8iGxZslpLRe3OFGjBj6ZGztBa/JPN/63k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153493; c=relaxed/simple;
	bh=M804dpB3l//IwAFJhlmVlCChqND3yGBC9TM1QI8lark=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rA7k+Kk+mVSolZ1T/FjuVPHIs9cCJ+DW5BvOpcWnILkL+8z8CmjkJDsySOJ/nmTuBP+TZmHs8Tgw3DnhktmR3FnOw6chgDoUPn9ecHNGCVksmj0HZ8gjQfl/ACysrUs/3f4LKo98mxH2Zh6t0DQTyQeCfZng477SE7QI7bVY+hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YqgT3QOc; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YqgT3QOc"
ARC-Seal: i=1; a=rsa-sha256; t=1773153479; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DMsyUG8l6Z8nkQQJNnUC3eIGzmOeK8OvxenvoujJsHhYuLN2Wj9SqqdbWYlKq7woOLXiZqCG5sr108+baO+VXxm9dqc048QQOhf5cYuJfxN/emQoZcK9bkEnrGL/bU+mirAnVC1x9WGgLRu9gVRi7P+LdUFrpFPLnOQeBeSMTO4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773153479; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+txvWPIPrHEKIjmWmNCgXsDo+scplGFWQ1+/w3m2JvY=; 
	b=V6v5E9AqDPuxxxRqZ+lFHwWY8ZJ1UIGiSzDkBoPh9HjAxUiSBUZQeVn3d9DivEpbsUGKO6GBjfcgxWNhfVuwm8ajfFCO7FDeW+qGOroSSaGXcA+Ri4WmZXeOr1TVcC6Ptc4giC/YU1KFS/eUBx/WRgtG2B8aGi+IKzY7fz+tx4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773153479;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=+txvWPIPrHEKIjmWmNCgXsDo+scplGFWQ1+/w3m2JvY=;
	b=YqgT3QOc+euReIxG9PW+4fG9Z7vWNrT+oXw4vX8UWp1931N+uXXTcnqPAJcqGJ0C
	w2e/VTudcYyO15ZDWGw1tD1X83QQ7vcfprDhWaw3sZi3U/BdoN2lBS1xfjDuerbNIN1
	fIpQQIWuizsuIo3neM1+XZScwqOTq/BofBdNgaCI=
Received: by mx.zohomail.com with SMTPS id 1773153477040816.4923636404494;
	Tue, 10 Mar 2026 07:37:57 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Patrick
 Steinhardt <ps@pks.im>, "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/10] config-hook cleanups and two small 'git hook
 list' features
In-Reply-To: <xmqq1phs69qy.fsf@gitster.g>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <xmqq1phs69qy.fsf@gitster.g>
Date: Tue, 10 Mar 2026 16:37:54 +0200
Message-ID: <87a4wfg37h.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 09 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> As promised I've spun-off v3 of the config series [1] into its own standalone
>> patch series after v2 landed in next.
>>
>> This is mostly minor cleanups and refactorings + two minor feature additions
>> to `git hook list`, which resulted from the previous review discussions:
>>
>> 1. The ability to show the config scope (--show-scope).
>> 2. The ability to show which hooks are disabled.
>
> OK.
>
>> This is based on next because the config hooks support is only in next.
>
> Not advisable, as doing so would take your topic hostage of _all_
> other topics in 'next', and it will _never_ happen for all of them,
> including the merge commit that merged them into 'next', to be
> merged to 'master'.
>
> After learning from the output of
>
>     $ git log --first-parent --oneline master..'seen^{/^### match next}' |
>       grep ar/
>
> that ar/config-hooks and ar/run-command-hook-take-2 are the two
> topic that may be relevant to the config-hook topic in 'next', and
> knowing that ar/config-hooks fully contains the other topic, I
> instead did the following to prepare a base:
>
>     $ git checkout -b ar/config-hook-cleanups master
>     $ git merge ar/config-hooks
>
> and then applied these 10 patches.  That way, ar/config-hooks can
> graduate in due course, and then this topic can follow, without
> waiting for other random things in 'next'.

I'll do something similar in my future series and stop basing patches on
top of next (I know it's the second time you're telling me to stop doing
this). Creating such a merge-base manually just didn't cross my mind. :)

Thanks for the tip.
