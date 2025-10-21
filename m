Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFA224B04
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061478; cv=pass; b=OkAl91wLRhHyWjladFkU1y+mjvUmOvgmNcN0BrjcCEGNSVUDmVT1tjlwYi/uAI9UHiJozq6va60SdkfEcbbyYNtCK9wqAMEoDx7nSBzCMN8nueb/UHhwtHzMZ/JzoGypc0NqFZfJxwDtoyp21jApLWV5F8Q3YN7ixqMo+MskVwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061478; c=relaxed/simple;
	bh=pX5j9O3dsHXiDEEstRcTNObZRt2vrpPMmOyd77Q1Wp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fz1IHjRM7igUFiOQsLr8a/CgbV8fUpScvSGAZrXx5P5cE/gHDqQE1Y5Kv7kAhO3LXAQiIoPKwZ+bZqrVLTfhXeZW9HpGc18cjgHYdp4ldkm9lQrbmu04umj9B10Fy3y4Z6jnwygGF9OFlwOYMrS0VNGGT4rvavxgw3Nx+70bEpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=kBwwESTj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="kBwwESTj"
ARC-Seal: i=1; a=rsa-sha256; t=1761061466; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BVLXPG7EOPLLjFr9Y3k7aw+dtFDPybLt10ErX5FfgCx3NwaJAnruT9F43BWMbpka/yLx9wORw6lIuBD68jaSHwkXdRnzbyRSoz8aGRvP/18bfSxzu01+Su/laH4jeufrFw/fJIEBhT5fEjt1YdX+biSSBdSx0NW0ttc0HwKZbgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761061466; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FqLzyj+PQCTl4dLclN/StsJ35sFYvCZsL+T99DYdFl8=; 
	b=jfa6pRFhyMW6lN4EcmlQ1gB/V8JaMty8yaR4tCd0dJOj3toi0EUZ8zUmEhaj+ggaPWvbOf0n0QCGvzYJYkVgbbsznj7BoBtmGpcBDFDOUjxwNSQIe2cLKPVLas63lkCBC5vYEg5JoqOcvn+xC6HScMMEUceZ4k0TW/guv3u2Rpk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761061466;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=FqLzyj+PQCTl4dLclN/StsJ35sFYvCZsL+T99DYdFl8=;
	b=kBwwESTjQZPTEnAXVPQxA/RcEF4bY2ivoMSn+X6S+xdchqN3Ys8rgHfRYtRcfJPV
	6TmWOK4Z66JEH4Y8IBjkWEm1E1Nce5IbcVsHTvGc02s+CC1Ggn6J/VvL86ENhKVbIFq
	CbPn5jgPk1Dev/7wOmWLt3XAEBtuDACwOEKnGAis=
Received: by mx.zohomail.com with SMTPS id 1761061462994552.7597736794866;
	Tue, 21 Oct 2025 08:44:22 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 03/10] hook: convert 'post-rewrite' hook in
 sequencer.c to hook API
In-Reply-To: <aPc5EzFRrDuI-0XH@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-4-adrian.ratiu@collabora.com>
 <aPc5EzFRrDuI-0XH@pks.im>
Date: Tue, 21 Oct 2025 18:44:19 +0300
Message-ID: <87v7k8p8do.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Oct 17, 2025 at 05:15:37PM +0300, Adrian Ratiu wrote: 
>> diff --git a/sequencer.c b/sequencer.c index 
>> 5476d39ba9..71ed31c774 100644 --- a/sequencer.c +++ 
>> b/sequencer.c @@ -1292,32 +1292,40 @@ int 
>> update_head_with_reflog(const struct commit *old_head, 
>>  	return ret; }  
>> +static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, 
>> void *pp_task_cb UNUSED) +{ +	struct hook_cb_data 
>> *hook_cb = pp_cb; +	struct strbuf *to_pipe = 
>> hook_cb->options->feed_pipe_ctx; 
> 
> Not sure, but shouldn't it be possible to set 
> `opt.feed_pipe_cb_data` instead and then access the context via 
> `pp_task_cb` here instead of having to reach into the struct? 

No, because they are different structures. You can look inside the 
existing run_hooks_opt(), it does:

struct hook_cb_data cb_data = {
    ...
    .options = options,
};

They're different nested options structures. :)

Maybe we could simplify these, however refactoring this options 
API is outside the scope of this series, just like refactoring the 
1/0/-1 fd values used by run-command.c accross the entire source 
tree we discussed in the previous version (I tried, then I gave up 
because it's too big & risky for this series).

I'd like to fix all these APIs btw, however it's a big independent 
effort. Who knows, maybe some day in the future... :)
