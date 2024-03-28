Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591B37140
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600310; cv=none; b=IQq4XGdCvHmRCjYayGw96HGW/EwBcl3L1RmNU/+8vq/YubwYVF/ob0KGIqXDyh/g8KSU6K+aApq0Jswy5txCkhN0zW8BxJrhtQaqxPp7EGsKKrvIZw7wLapGUf/cM6sPxZW20Rr189JH9UEuz4Mk3fl7Dlpbd7Hio/9Wd3T8EPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600310; c=relaxed/simple;
	bh=UsO1QxG6TT8lLNQ0CIDfPJNT+xc4crdToXtOx8U6xGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qg9K8FRm7/hNj5Jn9d2hhQGJsaimnGI2Gsq0oRissuK6lFAxqqhZh2oXco0aM4HBhBcsYHwPqObmzgYRil1GbEs65nUGddbj/8ROD3WB/BynSWpBLh0fUY3DVMp9uk2F6LfsdoQ3LuVLUd0mDyb4NGXMEEi8uheT0VZ/0mAh9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k8ibzPth; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k8ibzPth"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D78D19CBA;
	Thu, 28 Mar 2024 00:31:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UsO1QxG6TT8lLNQ0CIDfPJNT+xc4crdToXtOx8
	U6xGs=; b=k8ibzPthxIxlqP4b859C5MKA1WtcvK1JJgvjnmNk1mcBn9ngiZXAi6
	KurK0LgD/7z8OtJ6ixNf3v3F3ilBjFNw2SvCdTS4m3tOp9epPRtV0dVHDGahxIm5
	6QQ+ULUrdEuj4AoCLXlKZ24D2ycvfZhuGkGyGDb2J+JIrDiqSoOe0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2671019CB9;
	Thu, 28 Mar 2024 00:31:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ABFB419CB8;
	Thu, 28 Mar 2024 00:31:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: vk <g@vkabc.me>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [GSoC] [PATCH] builtin/gc: Replace run_command with C function
 refs_pack_refs
In-Reply-To: <0a149be978e68271c251e80f8eb571f4@vkabc.me> (vk's message of
	"Thu, 28 Mar 2024 12:12:06 +0800")
References: <20240328040010.40230-1-g@vkabc.me>
	<0a149be978e68271c251e80f8eb571f4@vkabc.me>
Date: Wed, 27 Mar 2024 21:31:43 -0700
Message-ID: <xmqqedbvyo28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 151BAC16-ECBC-11EE-99C9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

vk <g@vkabc.me> writes:

> I forgot to add this --auto optional logic. Will add it in the
> following patch.

Please slow down a bit.  If you notice a problem in the patch you
just posted within 7 minutes after posting it, there is a good
chance that you are rushing it without carefully proofreading.

You'd be better off if you give yourself some time to think about
what you wrote, after drafting your patch.  Sleep on it, if needed.

There are issues in the patch.  Trying to spot them yourself would
give you a good exercise.  Documentation/SubmittingPatches and
Documentation/CodingGuidelines would be useful.

Thanks for your interest in Git development.
