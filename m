Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535153361
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767533; cv=none; b=Bxw97Hz904Z8NmOt+w9eQewHctZ48fnGTp8fSqgtSY91SOxocpLl+a3ElCyjHlieY++qrzqY+dgYdefAdbW/SFXpHXFHFo7SOHxk91Z7xLJR0CImUK/Je/0XvO5ov4Tg6EPGWsoU4T8V0PAmcbKcNhNAuGQjcUmnHm/xwPV5Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767533; c=relaxed/simple;
	bh=DCU9kKomYOprjC9dfw+7NytlYfikqQp2j1NgaY4jYX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1WGFEGyIRHe6BO3BcwfkU6gSsc62RUQVecYfC61cKCIMDiXmuQ7aaCVamNiDbZk2wATXV1+qnnXheJ0NGjXeY8EqN2cofANSUBI6Cvrb/WIxa5pgzWHpy9T0QXz+LPgFkhO2A46sqJfnAPkf/tho8/SqdcDC+MFlY+eBNIKPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gJlTXuuN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gJlTXuuN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 27D082F7A5;
	Wed, 10 Apr 2024 12:45:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DCU9kKomYOprjC9dfw+7NytlYfikqQp2j1NgaY
	4jYX8=; b=gJlTXuuNdJ3ZSPtqAyrAjgOD5MB3XBhGL6GdzaHlp8XlQ+nWwd+e29
	N9C/dVrmuroAx4r57qwG5UogpfPUAs2BWcTnhsRrc/FP1Jf8Mw2COPaOMF8WzPT5
	gxyfgxZa7Z/F4HtMsP2IMDny57MzSA19UZ5FkeV2/P/GtM4aaG6rM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2032A2F7A4;
	Wed, 10 Apr 2024 12:45:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0D9532F7A3;
	Wed, 10 Apr 2024 12:45:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] t3428: restore coverage for "apply" backend
In-Reply-To: <5e0ec9eb-2e2c-4cb6-91e2-eef6b5c4300c@gmail.com> (phillip's
	message of "Wed, 10 Apr 2024 16:23:55 +0100")
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
	<b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
	<xmqqzfu2yw00.fsf@gitster.g>
	<6ab115bf-7b78-4633-a64c-9a0925d68e3f@gmail.com>
	<xmqqjzl5z4a9.fsf@gitster.g>
	<5e0ec9eb-2e2c-4cb6-91e2-eef6b5c4300c@gmail.com>
Date: Wed, 10 Apr 2024 09:45:23 -0700
Message-ID: <xmqqa5m1w4ik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAA7066A-F759-11EE-9939-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

> On 10/04/2024 15:22, Junio C Hamano wrote:
>> phillip.wood123@gmail.com writes:
>> 
>>>> Hmph, doesn't this lose coverage for the merge backend, though?
>>>
>>> I don't think so, we had coverage for the merge backend from the other
>>> tests before 2ac0d6273f as all of the other tests in this file use the
>>> merge backend. We're no longer testing "--signoff" without specifying
>>> some other option that selects a backend but it seems unlikely that we
>>> could break that without breaking one of the other tests.
>> OK, so we have "rebase --merge --signoff" tested elsewhere and we
>> are replacing "rebase --signoff" with "rebase --apply --signoff"?
>
> Exactly

Perhaps we can write that in the log message to help the next person
who reads the patch?  Something like...

    t3428: restore coverage for "apply" backend
    
    This test file assumes the "apply" backend is the default which is
    not the case since 2ac0d6273f (rebase: change the default backend
    from "am" to "merge", 2020-02-15).  The way "merge" backend honors
    "--signoff" is already tested elsewhere, so make sure the "apply"
    backend is tested by specifying it explicitly.
    
    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
