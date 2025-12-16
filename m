Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADF1494A8
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876219; cv=pass; b=QUPyDhGOKgcbhHXYIdgy/KFjKYh+ZemIH15pWJzr3gTg93eJ704cJK0n9PVk/HefgGl2pU0XxZc7bOjtZI4wGwtKclUF6F6ExJpaWUTfju8AUej+20QFX+kNrHdgLXh6vdV/y0liiUbvb6t6gDsaDYGiczm0s4STZE6B0qXQxEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876219; c=relaxed/simple;
	bh=1FHUersy65xj3QEpTa96MGKAV4vzAUv/L8lQEqBq+uE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MP2RrbOsxoBQqM1SZAh3EKUCjXtMl7kneyNg6dEeGW6pkFEdc7AJAZ9rdiUAKIfol2ZMqy4Y7INdrQdydqFf9G3v0CXZZ/vX2CBB/+/JN0cOFqmGBMOksM4sjjJi7cn1qAFiw5/xUBANUNAiJFYdBlfGsTmebwbdvDkQH1sARiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iSM7eV79; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iSM7eV79"
ARC-Seal: i=1; a=rsa-sha256; t=1765876203; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E5BD64EeC5w1HOm7os+2AUavPkURF8GSGlfcxLvEvI+f1EnE2C1cjGzZy5epQtCPCOUfXGsA9wM7ZPIKMQeXFlZbmiGcrqiQhsWIinsRy8IKKxc2A+FU/p7fi9tYb4GjkDvafb16T/FIdA9KJkcN/6mW6jJJG7gL8zDZe/CJrS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765876203; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ez36vj1hE3tEkYe7VgThbl00i6nf6e+q8bW76ms5FM4=; 
	b=Z2xqEyjkO23zfV8eUiTA/fRrgKtYr19VBJXdejg+yKceQ6d3Ik3sHDL7jyP+YtyfAOhSqQKPtEKZr+jlWRnfm1ohDi9mE6UWuNbfxkuDsd5q4Z/j++mKbUWDdwUky479E/06yTtPS1QX/lnFIazDigOIirGP97skFCSrUjlkUFw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765876203;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ez36vj1hE3tEkYe7VgThbl00i6nf6e+q8bW76ms5FM4=;
	b=iSM7eV79tkVNWvnt2GqA6/jnUD1Erk0qEUz9fLYR6XavtGMZWkKsBbEN5Py7oDOY
	gpyVVtb4X9HjvlVHs0YIQoQUyNX6m5vjv5s2+UwadjJrjx34IF7x/I1FiVe8j0hegb4
	jGM4MHrj+jhrGEdVEI5Q3irF3IqG2SieVVdjZ6JE=
Received: by mx.zohomail.com with SMTPS id 176587620180892.08553135878844;
	Tue, 16 Dec 2025 01:10:01 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/11] transport: convert pre-push to hook API
In-Reply-To: <aUETgWJ5DJaEpugO@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-6-adrian.ratiu@collabora.com>
 <aUETgWJ5DJaEpugO@pks.im>
Date: Tue, 16 Dec 2025 11:09:52 +0200
Message-ID: <87a4zihjxb.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Dec 04, 2025 at 04:15:29PM +0200, Adrian Ratiu wrote:
>> diff --git a/transport.c b/transport.c
>> index c7f06a7382..047f2cefba 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1316,65 +1316,71 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
> [snip]
>> -	if (start_command(&proc)) {
>> -		finish_command(&proc);
>> -		return -1;
>> +	switch (r->status) {
>> +	case REF_STATUS_REJECT_ALREADY_EXISTS:
>> +	case REF_STATUS_REJECT_FETCH_FIRST:
>> +	case REF_STATUS_REJECT_NEEDS_FORCE:
>> +	case REF_STATUS_REJECT_NODELETE:
>> +	case REF_STATUS_REJECT_NONFASTFORWARD:
>> +	case REF_STATUS_REJECT_REMOTE_UPDATED:
>> +	case REF_STATUS_REJECT_SHALLOW:
>> +	case REF_STATUS_REJECT_STALE:
>> +	case REF_STATUS_UPTODATE:
>> +		return 0; /* skip refs which won't be pushed */
>> +	default:
>> +		break;
>>  	}
>>  
>> -	sigchain_push(SIGPIPE, SIG_IGN);
>> +	if (!r->peer_ref)
>> +		return 0;
>>  
>> -	strbuf_init(&buf, 256);
>> +	strbuf_reset(&data->buf);
>> +	strbuf_addf(&data->buf, "%s %s %s %s\n",
>> +		    r->peer_ref->name, oid_to_hex(&r->new_oid),
>> +		    r->name, oid_to_hex(&r->old_oid));
>>  
>> -	for (r = remote_refs; r; r = r->next) {
>> -		if (!r->peer_ref) continue;
>> -		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
>> -		if (r->status == REF_STATUS_REJECT_STALE) continue;
>> -		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
>> -		if (r->status == REF_STATUS_UPTODATE) continue;
>
> The new code looks a lot nicer in my opinion. But one thing I wonder
> about is how these statements translate to the above switch statement.
> We ignore a lot more `status` values now compared to previously, and
> the reason for this is never explained.
>
> Am I missing anything obvious?

I thought it was obvious when writing the code :) it might not be.

The reason is the list was not exhaustive: for refs which we know
beforehand will not be pushed (status rejected), there is no need to
feed the pre-push hook stdin. It's saving a few cpu cycles in some
rejection corner cases, which were missed previously.

I could:
1. Split the extra *_REJECT_* case aditions into a separate commit,
   highlighting and explaining this better.
2. Drop the new cases since they are just a minor improvement in this
   series, not very important for the series overall.

Any preference?
