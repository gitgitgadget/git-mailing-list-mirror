Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794916579;
	b=cnbTZYCF0AtsG1cJCzXZ38ef6BdF21mvYuFAeuu9dZ1JyJamU8PPAEDihB6z6C5446YY
	 gW7SkjHx3pdUb78hDM2YmQKa7vKIK7VxLDEW28HWQsDjeVS7Jbczc5ZgPJwFDBFc/R7YO
	 DKFeWuerLcRBCvFRxyucnbAHczit7DDn9jwF15w2yTMyYVVvl6xj7HgdcJH4hJIs3FcJW
	 uU3Uj8IpImwTs6I/56AK4OGdHY6ckl4/eUVXyqf/PwTOVF4Cv0MpFbtwcQfGyI7440i0m
	 Z6XLp+9VgwnQPwfdGDdSEuq++lqmI+m4k7t+uubAXgO6vAmPQuwI6xEpBSDvYZtoV9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916579;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=ekGjFzOcuR9z+yNs84AGw0IoXQAziJJC63WSR8k6ujs=;
	b=LZzqOEtI32cEvIwGy/cwcpM4Fu5O9itAo/7N8u69iq54OUXVFQV8ena0YZb5mjArhGGZ
	 G/gn8jipACFigwVtYmKU7+CCILAzZ0bg0qSOf+2/A36rt1qyRssGN+41uFlWbqSUS7EfR
	 GDuzwN3p4G3dd9WbC7Z3YhZgLpgBSyU+MKzswatpcelwSpem9cQb2TukdklCeqsePOQsN
	 Ozd4opvhUWE7esqD2TdkHK2nohsQipo3XcniPaBaRYOu5I/wpIIszjzMwDiErzeAKgJ50
	 5pdIodvdaNP0cvOA/6+TIg+5auIsr2FUitHbAa8O0aX6vHRBTw87z4Fu0imptQ30K0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gqL5uCUi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C42606A329
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C42606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gqL5uCUi
ARC-Seal: i=1; a=rsa-sha256; t=1794916544; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M8c7hvNh/6oLZlgske/q1VDGMObxM+jxbwnVfMn9i+wZdNi6hCA9OYfrMGiKeidAeKafXrEDzKL4RJXa7KPUx2n42UwzhBwam1rShJbZ4VnaEowUNXqTYTzfo2xBpUQ32qKhvilCnKfS71nyDo3yC8BdPrjqHhWvGG/HgeMgEcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794916544; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ekGjFzOcuR9z+yNs84AGw0IoXQAziJJC63WSR8k6ujs=; 
	b=cV8Et/uySRjinxxCdHJRTmliQpobmgc+U9ESR0PC1VBjxsMIvAfPp3epL/LXvh02oaRBDdAEKJuxPlRtnGrKiWYDS3zC3+yTJC6MkYZaQR6PsKasT6gJyMnxDDlKpouV+YOGE8XpuP3eWCwg4LYxZZZqF0LbOWdNDoWhZFWIIZo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=gqL5uCUi1R8H7t9OtHr/12Sfi9hSCKqfPdlbVIGBT27ebprfA4c8YcQSGEVcofXddT9ktoelA18Gv/4HKNc/JazxZZUh2oj++zIQkPbmLDpDIAZxpvD+tHChrJ6MM4Hz66LazxfKfUVjfQTI549edNRP05rOCJanvw/s5oEpnEg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ekGjFzOcuR9z+yNs84AGw0IoXQAziJJC63WSR8k6ujs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794916541728348.29145203067446;
	Tue, 17 Nov 2026 03:55:41 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, "brian m .
 carlson" <sandals@crustytoothpaste.net>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Axel Rasmussen <axelrasmussen@google.com>, Emily
 Shaffer <emilyshaffer@google.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 2/3] rev-parse: die when --output-object-format cannot
 map an object
In-Reply-To: <avqynlDKnJpJn6RZ@pks.im>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <20261112195740.2834341-3-adrian.ratiu@collabora.com>
 <avqynlDKnJpJn6RZ@pks.im>
Date: Tue, 17 Nov 2026 13:55:36 +0200
Message-ID: <87fqwzk6yv.fsf@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 16 Nov 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Nov 12, 2026 at 09:57:39PM +0200, Adrian Ratiu wrote:
>> This happens because rev-parse ignores the repo_oid_to_algop() return
>> value. When no mapping is found, that function fails and leaves the
>> id unchanged, so the storage id is what gets printed.
>> 
>> Fix it to die with the same message as pack-objects. The other callers
>> of repo_oid_to_algop() already check its result.
>> 
>> This only covers a single revision argument, the one case where
>> rev-parse converts its output. Other forms, such as "A..B" or "A^@",
>> print storage ids whatever --output-object-format says. That is left
>> for a separate change.
>
> This paragraph is a bit hard to parse.
>
>   Note that this only covers the case where the user asks for a single
>   revision, as it is the only case where we pass the desired output hash
>   explicitly. All the other cases, like for example when the user passes
>   a range, do not use the desired output hash at all. Fixing that would
>   be a bigger change though, so this is left for a future patch series.

Ack, I'll reword it.

>> The test copies a loose object into the repository by hand, so it
>> doesn't depend on whether fetch writes compat mappings.
>
> Do we have to do that? I'm mostly asking in the context of the new
> object storage format extension, which may change where and how exactly
> objects are stored. So all tests that manually modify the object
> database will break, and we'll want and need to fix those.

We can do it any other way, no problem.

How I reproduced this in the real world (non-test) is by creating a
commit with JJ, but I tried to avoid adding JJ as a test dependency. :)

Besides, I'll fix this in newer JJ as well, to simply reject repos with
extensions.compatObjectFormat, which is not supported either in Gitoxide
or JJ.

>> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
>> index 30bf8a4d0a..c15d9953a8 100755
>> --- a/t/t1500-rev-parse.sh
>> +++ b/t/t1500-rev-parse.sh
>> @@ -241,6 +241,24 @@ test_expect_success RUST 'rev-parse --show-object-format in repo with compat mod
>>  	)
>>  '
>>  
>> +test_expect_success RUST 'rev-parse --output-object-format with unmapped object' '
>> +	test_when_finished "rm -rf plain compat" &&
>> +	git init --object-format=sha256 plain &&
>> +	git init --object-format=sha256 compat &&
>> +	git -C compat config extensions.compatobjectformat sha1 &&
>> +	oid=$(echo unmapped | git -C plain hash-object -w --stdin) &&
>> +	# copy the object by hand, so that no compat mapping is written for it
>
> Instead of copying by hand, wouldn't it be possible to write the object
> with the compat object format unset and then set it afterwards? That
> should also ensure that we don't have the compat hash.

Yes, I just verified that it works. Will it this way in v2, thanks!
