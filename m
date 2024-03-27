Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09AA13B5A8
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553040; cv=none; b=GtmyfKJALIA26xuLDRlJ+0gnuTl89N6bYnj9AYty5uUOOjcRbFeiA3TRwdFb21eo95OBYBKJFfIPs2ieb5lZpvaBuAi2F9qv2nvhNTIAd4wDToumzOakkZGmjmTCRaGgd+eI3PsycLHp71fDXlHepKGXQc4cx980Jn7vvS5ZyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553040; c=relaxed/simple;
	bh=n6aQiVhx88L8m/rjHkagVbDCMzsxnaj9KvjtxHY3Z24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FXPIoK0PCxD6DWJWrQVlslgyA1kammEc7t84tsXjFtNPm1OqCl5TZWI3k3MC9AUueTFrR2dEThPHOBklNcNbmbB9oMs+5BUydhznS58Joo4eLPfvsKVo+lzB4RIRcf72ZXItBDjMadq8NLteZCDSBOSyosTNf8OdOL1b+zNZDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k60l/+45; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k60l/+45"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AEF9F1C90EA;
	Wed, 27 Mar 2024 11:23:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n6aQiVhx88L8m/rjHkagVbDCMzsxnaj9KvjtxH
	Y3Z24=; b=k60l/+45s3WkSCAx6Nh+SXcKtH+5AoHYcnuTiVDsxQh5Fs3Y2d1e85
	R87eAQKJzrw1b2N5GtK89BZdviy1XNQ6j4URL4Sw0U+MamA6RmI4rFjn/otI7gCY
	w7IVYqCR9e7IebYwSFs376MEs2zMk2cB0bSCsQZ54vtdSGom7cAcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5FCF1C90E9;
	Wed, 27 Mar 2024 11:23:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13E8F1C90E8;
	Wed, 27 Mar 2024 11:23:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Aishwarya Narayanan <aishnana.03@gmail.com>,  git@vger.kernel.org,
  karthik nayak <karthik.188@gmail.com>
Subject: Re: GSoC 2024 [PATCH]
In-Reply-To: <ZgPrLXjB5mVXitXu@tanuki> (Patrick Steinhardt's message of "Wed,
	27 Mar 2024 10:47:25 +0100")
References: <CAHCXyj3Now+ZrA+w+L-sQAtAMZ8REru=3uF_Y3Xdt=7CSf=pYQ@mail.gmail.com>
	<ZgPrLXjB5mVXitXu@tanuki>
Date: Wed, 27 Mar 2024 08:23:55 -0700
Message-ID: <xmqqfrwb4s1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 07692E4A-EC4E-11EE-BD29-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Please not that patches are supposed to be sent as mails directly
> instead of being attached to mails. You can use e.g. git-send-email(1)
> to achieve this.
>
> I would recommend to have a look "Documentation/MyFirstContribution.txt"
> and "Documentation/SubmittingPatches". These resources should get you a
> better picture of how a typical workflow would look like here.

Thanks.  It is very good that you recommended the documentation on
the contribution process.

The tasks for microproject are designed to be easy to solve and the
changes in the patches themselves would not be the interesting part
for new contributors.  Rather, it is designed for a new contributor
to experience the contribution process from the beginning to the
end, from coming up with an initial patch and explaining it well,
sending it to the list in the established way, receiving and
responding to review comments, and move on to the next iteration.
