Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F62AD1E
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077225; cv=none; b=HyHnulHbpVj6hiQEO6Bl6XiSmBLnTJTvYPQVNzOnAF6TKqZi6DsgSeKH7gyqYqUqHO24MoDZMBzfI/IBsr22G4bp/WoF0NBudwHaN2dPkaVUHM1nWDSRGvHAZqShfzw+4SNYttHjzez/Q3TGaQ8VkmrhDtQ5Xyzw0lqgWHOoW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077225; c=relaxed/simple;
	bh=XO3UFUap2/YYVhM94eeUGcHswn8NwIBWvV8V6z4Uo68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Acpnd8VXNklaCfLJt6A7/9PKrrZrcmEEGogoleyE43Is1MfWufTBmarTxcemkXPl2gt5yrpv4FELek+NyuBs5OnTPQnq9VpVjpiw1qUh9TLOQxGyiKtubYoEALnSy9jX0Uh+R+X9s3v7M+ofOCmFDxHHiDwgGcpnlB2DLrNDd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWQGVR4C; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWQGVR4C"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F13891F154E;
	Tue,  2 Apr 2024 13:00:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XO3UFUap2/YYVhM94eeUGcHswn8NwIBWvV8V6z
	4Uo68=; b=cWQGVR4CoqO9Wozpx6zisSHIequhLKOb/5TvGZtlRHpAEWIZAaI2zk
	PFs171iGB9TSik0Z8EglO4EJaGEM8Tt7Sb68XsVgSHb0eXRd5C0qG70rEw3QhOp9
	y2yQO5zGpOIWudzs7uBSK12j/SRdGlmXHCTMZL/D7lbFAuheEleJs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E905C1F154D;
	Tue,  2 Apr 2024 13:00:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D4DC1F154C;
	Tue,  2 Apr 2024 13:00:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Linus Arver <linusa@google.com>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] RFC: add MAINTAINERS file
In-Reply-To: <ZgutC_ddW_Psmlcl@tanuki> (Patrick Steinhardt's message of "Tue,
	2 Apr 2024 09:00:27 +0200")
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
	<xmqqsf0gvjrg.fsf@gitster.g> <owly7cho1eh4.fsf@fine.c.googlers.com>
	<xmqq4jcr6bx2.fsf@gitster.g> <ZgutC_ddW_Psmlcl@tanuki>
Date: Tue, 02 Apr 2024 10:00:21 -0700
Message-ID: <xmqqzfub66oq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E3203C6-F112-11EE-AB9F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Mar 27, 2024 at 06:29:13AM -0700, Junio C Hamano wrote:
>> The development community has been fairly loosely organized so far,
>> but I'd like to see responsibility and authority spread a bit more
>> widely yet still not too thinly to compromise the project integrity.
>
> I guess the main motivation of this statement is to reduce your load in
> particular, right? If so, do you have any particular pain points that
> can be spread across the community that would help you? Or is it really
> only spreading the review load by relying more on subsystem-maintainers?

It is not for load reduction, per-se.

I wish people spent more time and effort on reviewing and helping
others to polish topics as much as writing their own topic.  We see
corporate sponsored entities propose a feature, polish it with
reviewers, and then after the topic lands and collect their perf
scores, leave it bitrot, making it "the community's problem" to
maintain it.  They may even have to leave the project due to reorg.

Somebody comes with a patch in such an area, and receives no
response.  The only two ways I see to reduce such "abandoned parts"
of the system are:

 * Those who are still with the project but their interest moved to
   other areas in the project to come back to help in the area they
   were involved in, and

 * Those who haven't been involved in an area to grow expertise in
   it.

The latter is far more sustainable than the former.  People forget
and become no longer more expert than others who have fresh interst
in the same area.  But for that to happen, we first need to know
where the gaps of expertise coverage are.  If we try to spread
responsibility and authority, we will quickly identify these areas
as we find no experts in these areas.
