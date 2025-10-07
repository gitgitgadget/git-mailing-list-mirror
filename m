Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD52E1EFD
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857716; cv=pass; b=hqJoaRKb13YrxS1mvJj27i+EuCMkkK9qsVcKG4nqlfZkOEEavAlrw5DyVnS0mhpA0bycYUAiTVNL5QnTGRzRngNh8E3NrWC0B0YPIFy7yhPcaVNULtbXd5fRBsoKfipcjZWIQePwwxBX7sqJluHL44FVdbX30e4HTzfLSVzlSm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857716; c=relaxed/simple;
	bh=5/4CzbUx31XJXs4GtLc7lZyyyPuRpoiKDfpRrQuZT14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NZkNpDXsMTIzaFTFLR2y8GgUJ2SwcKBUhorkQXBobwzbbtXGPuQt3RbZF+QMAScr+ST9sNA2Gd06RYFfSAwFrUOVA8lEozJ5AkpAJil873fMZcIHUf0BJMw04b0O+vs6YnMlQ2aSzBJ1ceniL0PcRqv+Pn9bdKSfXYcmVqZw42o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=e0pty22/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="e0pty22/"
ARC-Seal: i=1; a=rsa-sha256; t=1759857692; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I5l3IQkR1PzSxJaWVBjs8h6iR1BzMlN7S6BGrGQESXZ3RdheQalyeT7PWHe9WKqUZGkN9FfmjLgzxW9l1apQKV4TLUIAJqSf0OoPt+39AvXDzd9IT2ygozBoHQ5CYePQYpvwXjMOjyxt7tZdxKdEHAwtIyOGrPPSrnBL0Q+a64E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759857692; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L5cKrDEU72ONtjHK7xzc/iIxhflgvOf++3rfss3LdPk=; 
	b=oLMqGeyq74Yseb0rjM8NNt2aPpSC17Wwop6KxH/P1mQB7VR9+B4ehOFoRyI7lmSX79+CB3H1IbHsODk7WdFfbdVZV27sSiBbTLQq+DHUX9gifafnNNfU56A2oq1Dvsv5RJ+KE5bqDC7+tSX9OIEIGC/0U9X2fnZ3xOklR9ctO3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759857692;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=L5cKrDEU72ONtjHK7xzc/iIxhflgvOf++3rfss3LdPk=;
	b=e0pty22/HUyYV9jS6NlKGUR8bW6X3hmhxI6hjcTHIpM5sZfuV18EHTRc1EN9PDe8
	N5Qr5NCANke+LJ1C73qFcaPFKVOkR7bOFgacfe6s6x6hkJZRTlFIvEBmTNNBBc0zfV7
	lFzX62tUebW0q2acPpUHmTQnrgUv+zDnOJ/eALps=
Received: by mx.zohomail.com with SMTPS id 1759857687985170.35216116976846;
	Tue, 7 Oct 2025 10:21:27 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <xmqqldlmlm1n.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <xmqqo6qkq9vm.fsf@gitster.g> <87frbv3qyr.fsf@collabora.com>
 <xmqqldlmlm1n.fsf@gitster.g>
Date: Tue, 07 Oct 2025 20:21:21 +0300
Message-ID: <875xcq4oha.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 07 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>>> If you already have submodules creted under the original 
>>> scheme,  then add a new submodule that needs this extension, 
>>> do you  enable this new extension and write the new submodule 
>>> under  encoded name, and move the existing submodules under 
>>> their  encoded names?  
>> ...  We could do a migration of existing gitdirs to the new 
>> encoding to  ensure consistency when the extension is enabled. 
>> 
>> This will simplify our logic and assumptions a lot, at the cost 
>> of  the initial up-front migration. 
>> 
>> Will do this in v4 if nobody has any objections. 
> 
> Let's not. 
> 
> You have support for submodule.<name>.gitdirpath already, so it 
> is far safer to use that mechanism to etch-in-stone-fix the 
> existing submodules and their gitdirs without touching the 
> directories for migration. 

Ack. I'll follow this design path in v4.

I was actually preparing to do the opposite :) i.e. drop the 
"override" and do the migration, thanks for clarifying before I 
did a re-roll. :)

Will leave this a week or two on the ML in case others want to 
review or have more feedback.

> 
> One case you might want to really move directories when 
> migrating is when two existing submodules' gitdirs are already 
> overlapping, e.g., .git/modules/A and .git/modules/A/B are used 
> for submodule A and submodule A/B.  Depending on what "B" is, a 
> project with such a layout may not be able to upgrade to 
> versions of Git that newly starts using .git/B directory for a 
> new feature.  Introduction of a new directory or a new file 
> directly underneath $GIT_DIR is rare but does happen 
> (.git/reftable/ is a relatively recent addition, for example). 

Yes, though I don't think this is a big concern because 
submodule.c already has the validate_submodule_git_dir() check 
which prevents users from creating overlapping / nested dirs.

When the rare, deliberate clash does happen (like with 
.git/reftable) it can be treated like before: do nothing, let the 
user fix the repo, or we could add a small one-time migration at 
that point in time.

I really like avoiding any kind of automated blanket migration btw,
thank you so much for your feedback Junio, it's really appreciated.
