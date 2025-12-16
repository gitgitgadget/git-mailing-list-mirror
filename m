Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E043396E4
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876998; cv=pass; b=lNwSuF3CUas/A7HrFG/SGapac1EUtWY2ZDDiQ1v6TXhPQAxyMlVUit1fo7oMg4a8mk4/vVc51yJ1S5l1FvvcDizHXzl02+wvgZXPPLOqRhkfROmy92R1vcYGjJtWYAyok8d2phbPkwv7IEFgMfp0fdt7Pjt8HI45yoIIvvqqZQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876998; c=relaxed/simple;
	bh=E0Vf0Wi9zx3X0qe3W6n17wqkmtQISxRzdxQTnZ2F0WQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KvmIHJgzUpiqezl0kbNrw2GbcC5jovPF+N2vQouUZm6Tof0pO4mV61dC83X/ovexhK7y0x9EvJpEvSFNLg2UjrBLY2kS1k+sXXEnEpVjs/0eReVGRaQzhlicKihwAlRt7aw097nU6xqmUFst8jJHK5X8oWy/2CUQi+G5LoMyF0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bR9WUqPH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bR9WUqPH"
ARC-Seal: i=1; a=rsa-sha256; t=1765876984; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ctw5MCv5hHMa0IA6e99ZTAB6ozQJ9UxKMyL5rkJ+Lik9CFgQxyUN1A+6HhCPzeOcCa/kkzUyPHku+jwaBTVtFXyQo9lMaFBlC37gr+NBwzEIjOZbMMbNMQzJVWVMMEBxpdJWsFN/L652pdPM+LX+ukFSWiTCoRZgUbZjklgISU0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765876984; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N6kQGqG3JxzL6+bATAyOg/UgRdtHh5iEoQ1tW/YixRk=; 
	b=DInxbBPiX+cooHrsrk5/9/qloXJDzQ/xoZmtDWGp+dkOBvBMZ7sxIwkzNGNniMbohHl0AXPIykhpnRugLuRLOmAaKeca6Fpn/8v4JqDROmDG51ebJZ8+X576MgaFoKXw0cfdemVSdbDAJWGq2uRPxfTq2Xa0eQgPHbXXTHjyWSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765876984;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=N6kQGqG3JxzL6+bATAyOg/UgRdtHh5iEoQ1tW/YixRk=;
	b=bR9WUqPHtqk+DTrk5WnW/+iSfwnNjsHel/BZ8y207RtTLierv9/RdZW3CjLErsj9
	mOdM5onsw6vD1E6LWOx4e+wVC0yC4bYcc/mc+21ZZ1pEM1rhZ2WRbzbEk42H61YGO/6
	3g/I42qcIsACPDSGlUTfB3Hs8mhI8LgMAWiQWVRM=
Received: by mx.zohomail.com with SMTPS id 1765876981506813.9216042186428;
	Tue, 16 Dec 2025 01:23:01 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 10/11] receive-pack: convert update hooks to new API
In-Reply-To: <aUETkJZe_qCS6ZV0@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-11-adrian.ratiu@collabora.com>
 <aUETkJZe_qCS6ZV0@pks.im>
Date: Tue, 16 Dec 2025 11:22:56 +0200
Message-ID: <877bumhjbj.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Dec 04, 2025 at 04:15:34PM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index e8ee0e7321..d95df748cd 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -938,31 +938,26 @@ static int run_receive_hook(struct command *commands,
>>  	return status;
>>  }
>>  
>> -static int run_update_hook(struct command *cmd)
>> +static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
>>  {
>> -	struct child_process proc = CHILD_PROCESS_INIT;
>> -	int code;
>> -	const char *hook_path = find_hook(the_repository, "update");
>> -
>> -	if (!hook_path)
>> -		return 0;
>> +	if (output && output->len)
>> +		send_sideband(1, 2, output->buf, output->len, use_sideband);
>
> Nit, not worth a reroll: the buffer shouldn't ever be `NULL`, should it?
> Checking for `output->len` does make sense though, as we may receive
> empty buffers for keepalives.

Good point. NULL output should still be checked to avoid unexpected
segfaults but it should rather trigger a BUG() than a no-op.

Still pretty much harmless as is, will fix if I do a re-roll.
