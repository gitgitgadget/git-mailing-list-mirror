Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE510364958
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861736; cv=pass; b=XvbJb6mVD/tDJRPvkVjGRXB9hV8wlfOfIIe7zf8myyUraEjF6IU4lKl7AAPjakUVHvspKN4TzVCQyaN9bIDbzl+yTLHRWqdz+xVb3mBkkh/i7ns5+BmdvHGnDrIjoGdUVmdqaaKYzkuQMzgMLypjqbVcJNwMi9od3r7lTAAHWLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861736; c=relaxed/simple;
	bh=85mDFKoRIJzLVeuWDInw0EnOuqvuxW4qyJuADo59aAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXi/RDS8ZpXnC5+96i2GNB8inG0LOQJuusm1s5/MbpL1V7WKdj8Wgo1N1XuYuPr7bW61T5GqrUUM0kTtJmKEh1M3B8QStuVMtQboqxblyYuCNcJn3Qz3CpVL65jAl+/MQWTQG1xEc+yzYsx7jsVkV4qlScxs/SpOkIKzv6ouVr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Si6QC87H; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Si6QC87H"
ARC-Seal: i=1; a=rsa-sha256; t=1773861716; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mkm2ClqrzxroUB4W8bgALqRP6H9iHpBugaLFNzbNIuHhj9bUkLaFAcXUdNK74uYvnDlpQmYG4AcmvwR6wNHtWCI7w0olBtPSYPzlanpdzTtiJA8e1u9kr+9kdF87efAD3MjSRa4sL9pOTDvRletYOU/SK1mHqcnJKOHouGxmMZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773861716; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l2uhrziDFxvCwOmtU1rQpCtKQ0A4AH0YfHYXP46H9Sk=; 
	b=UVtc4JMkYp1Ni2iZeBGdT3dpuqp8+ZWaDhgiyqfC7CbmQYDbIPRSvkfhBEZiUm0abdAyc6kN2PqXLyGDsxiG6+nERXr3KOeSIebiPu34hOYIxZH3dLXoD5QXWEjgapVBsqihug49LVTOfevkUSQ7eszB3FGnBXytfq6E4U1aRWs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773861716;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=l2uhrziDFxvCwOmtU1rQpCtKQ0A4AH0YfHYXP46H9Sk=;
	b=Si6QC87HU5pBOZgkRNo36oubO3a5jN8stpTWhxmy0cxk73NKFMOytjhszwAqqo8y
	4fATc0AVWvrmqD5i2tEVADAT7/qtJlEC8USwsUmWFFIdcLvK7PlUXM5xmJX6Cb0s0bw
	DIRILnJb2HXaBUXdMXEclLJ//W3zx06nZVj+Q96U=
Received: by mx.zohomail.com with SMTPS id 1773861714011441.04104981579223;
	Wed, 18 Mar 2026 12:21:54 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 7/9] hook: add per-event jobs config
In-Reply-To: <xmqq341zpqhv.fsf@gitster.g>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-8-adrian.ratiu@collabora.com>
 <xmqq341zpqhv.fsf@gitster.g>
Date: Wed, 18 Mar 2026 21:21:49 +0200
Message-ID: <87se9x0wqa.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 16 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> +hook.<event>.jobs::
>> +	Specifies how many hooks can be run simultaneously for the `<event>`
>> +	hook event (e.g. `hook.post-receive.jobs = 4`). Overrides `hook.jobs`
>> +	for this specific event. The same parallelism restrictions apply: this
>> +	setting has no effect unless all configured hooks for the event have
>> +	`hook.<friendly-name>.parallel` set to `true`. Must be a positive int,
>> +	zero is rejected with a warning. See linkgit:git-hook[1].
>> ++
>> +Note on naming: although this key resembles `hook.<friendly-name>.*`
>> +(a per-hook setting), `<event>` must be the event name, not a hook
>> +friendly name. The key component is stored literally and looked up by
>> +event name at runtime with no translation between the two namespaces.
>> +A key like `hook.my-hook.jobs` is stored under `"my-hook"` but the
>> +lookup at runtime uses the event name (e.g. `"post-receive"`), so
>> +`hook.my-hook.jobs` is silently ignored even when `my-hook` is
>> +registered for that event. Use `hook.post-receive.jobs` or any other
>> +valid event name when setting `hook.<event>.jobs`.
>
> This design is unfortunate but cannot be avoided, as we do not want
> two hooks (i.e., two different names) that react to a single event
> specify .jobs value differently.  Naturally, we need to worry about
> what happens when somebody gives the name "foo" to their hook that
> reacts to "foo" event, but that would probably be benign if there is
> no other hook that reacts to "foo" event.  I also wonder if we want
> to sanity check and complain upon seeing hook.foo.jobs set when
> "foo" is not a known event type.
>
> Perhaps anything that appears with one of the .command, .event, or
> .parallel are likely to be <friendly-name>, so having .jobs under
> such configuration key is safe to flag as a mistake, or something?

I think this is reasonable, yes, and it helps avoid confusion between
per-hook friendly-names and per-event "name" values.

Will do in the re-roll.

>
> A careful reader who is reading this message from the sideline may
> notice that I specifically omitted .enabled from the above "clues
> for friendly-name key".  I think hook.<event>.enabled that acts as a
> master switch to prevents all hooks from firing for a particular
> event (when set to 'false') may be something people eventually want,
> in addition to per-hook command hook.<friendly-name>.enabled switch
> that can override it (or do we want to forbid overriding it?  I
> dunno)..

I think this is reasonable as well.

Having a higher-level switch for all hooks in an event should be useful,
in addition to the already implemented lower-level per-hook
"friendly-name" enabled key.

I can add a new commit for this in the re-roll.
