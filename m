Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A443491CA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063944; cv=pass; b=orutDq1V6HIzXK1rzd8qvKMO7Svk5NEunDh+gS3hQkRFZbWlUeta44mseatSJqceloEie80Df+GIoV4VsoPvunswL3z5CJMSXBNaGwkuSjTz0rVJuQoC69y1cNN6hYBKvWzsGcux4n5C3HLd0MJKmiiA0z9HMqrm66CgOs2hmy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063944; c=relaxed/simple;
	bh=ssGHUz4oPslZ3hLFHYVomFXQhBU3AfEhQVl9auMtVzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OU3teq2rqYvqSBvPeG4jZYSz8OYCdhz8NohIAUJHA7Juf6G///4NAASWgVGd9DD7032DHW35FWVp9PrtZCYVUwx9kPXhjHBMrh1wr4seTb2o6fMDqeU1mZIU9jWW+gPNgN+qHHbhoIQnSCoeivlXmNFS986Q5ntYmUMIYsIEO+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=lSvM4D/E; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="lSvM4D/E"
ARC-Seal: i=1; a=rsa-sha256; t=1761063931; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T1xo59GBScFW+Sqld5imCxAYNP2XSbXxkye564aW+W11zVIaqh1zVwTtRxLHXR+F0sVVfHne44XifXZmhoKRR3aUCta0rXiInylTmIbarDtquBFifNGQO1zUOVouhTMcAfFJZM35SPfORxunJPSvMD6Xeq077E3NVfEwiu9DE2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761063931; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B/CmKXC+klaGV6LhF1iAOTcF5SQ6caPTb3syWN14dGI=; 
	b=Bnlcflc105mxMIlkJQpai5RFUMoKbvAmyxfOYWnak31/pA+oVIFjYDz0I53EB4Ryly6AMSeE40giVst8xLS0SFgl4bJmHiGcEGi9n67rNGmOQ+7eAJ2Oe8ZdXihUXlclUfvZvanbdv6b87vdf/nuxbMuyiV0jG9hFwCMBQ84XfM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761063931;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=B/CmKXC+klaGV6LhF1iAOTcF5SQ6caPTb3syWN14dGI=;
	b=lSvM4D/EBeEWslSq57rXbfWOdNkaAKgNtF8rIjz5WL2AngHyxisGG/kKpZfYhzES
	4N2RrkJI0BbyDH1BRwxpYfKDPfJYzAP+Iyf0feDoX0q9SsXF/AAyS72je6huDTa+g15
	3HbSqTxHu354kzPpfHxjIMA6Hp2OKJhqeIFJCivQ=
Received: by mx.zohomail.com with SMTPS id 1761063926654509.8134050205874;
	Tue, 21 Oct 2025 09:25:26 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 07/10] run-command: allow capturing of collated output
In-Reply-To: <aPc5JTxw5uVHEyjH@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-8-adrian.ratiu@collabora.com>
 <aPc5JTxw5uVHEyjH@pks.im>
Date: Tue, 21 Oct 2025 19:25:20 +0300
Message-ID: <87plagp6hb.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Oct 17, 2025 at 05:15:41PM +0300, Adrian Ratiu wrote: 
>> diff --git a/run-command.h b/run-command.h index 
>> e536ed7544..2c2484478b 100644 --- a/run-command.h +++ 
>> b/run-command.h @@ -436,6 +436,20 @@ typedef int 
>> (*feed_pipe_fn)(int child_in, 
>>  				void *pp_cb, void *pp_task_cb);  
>> +/** + * If this callback is provided, instead of collating 
>> process output to stderr, + * they will be collated into a new 
>> pipe. consume_sideband_fn will be called + * repeatedly. When 
>> output is available on that pipe, it will be contained in + * 
>> 'output'. But it will be called with an empty 'output' too, to 
>> allow for + * keepalives or similar operations if necessary.  + 
>> * + * pp_cb is the callback cookie as passed into 
>> run_processes_parallel.  + * + * Since this callback is 
>> provided with the collated output, no task cookie is + * 
>> provided.  + */ +typedef void (*consume_sideband_fn)(struct 
>> strbuf *output, void *pp_cb); 
> 
> I think the interface overall makes sense, but isn't the wording 
> we use here very specific for hooks? 
> 
> Taking a step back, what this thing seems to do is to take the 
> hook's output and customize how exactly we handle this. That 
> isn't really specific to any kind of "sideband", even though our 
> use case in the hook code does use this for sidebands. 
> 
> So maybe we should call this `consume_output_fn` and adapt the 
> rest of the code accordingly? Because that's what we ultimately 
> do here, IIUC. 

Yes, that is a good idea. run-command is supposed to be a lower 
level, more generic layer than the hooks, so it should not be 
concerned with concepts such as "sideband". 

Will do in v3. Thanks!
