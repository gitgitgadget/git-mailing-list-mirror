Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38228155C8D
	for <git@vger.kernel.org>; Mon, 27 May 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832360; cv=none; b=DdZ7daJd1YKIfgHjBPUQlaWoNv7hUYHvK7XmOMhJDcx6+BqqtwYkncV+Fl5xtILcLwUAMKglI1UGJyuuy5MNPZiwM2awDXV4HFhMDqfhvixM2jd4wMJuQT/LK7RaRJhWFEtlIT/hQCNErTfabYH1HrBmS/VZUJBiB/6zK8afpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832360; c=relaxed/simple;
	bh=CBTT9gTW64xOTBtvufQDgaAbKGdUVX/xUEQqnnbqamc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LffjMjCHN16tFp6/fXSZKFZmxc9SwqMQOUZjCIUfI0412bFXbV9NWXNU++vtfIBNI1cmWeSB5PVvjNxgqAMwbAqaAfsU7Bt6fCMDJCMH7YC5j1BeUPluJJ6f11Ym5fql/25P3NtI2K9RVn8Wd2Q5fJMXk3wnlcXLL8b7RXtKQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pGWYM7cq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pGWYM7cq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9B0032F90;
	Mon, 27 May 2024 13:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CBTT9gTW64xOTBtvufQDgaAbKGdUVX/xUEQqnn
	bqamc=; b=pGWYM7cqQUMKYsJtvNjwCcPy0M/Go5j1yNCUNX+3JAiYvYRRcsSCDd
	PMBdVMn/UHNJI75jOC+2WYSQrDC/tV0m7PuawUTpAkWPqU3wfhEKvrjVm+cUuNHj
	uyDXBzy6jy0DeWm/c4LE4tbPxf3R0ShUCDufZznEC81c/2Y0BtFqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C17BB32F8F;
	Mon, 27 May 2024 13:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A11E32F8E;
	Mon, 27 May 2024 13:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/21] Various memory leak fixes
In-Reply-To: <cover.1716810168.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 27 May 2024 13:45:42 +0200")
References: <cover.1716465556.git.ps@pks.im> <cover.1716810168.git.ps@pks.im>
Date: Mon, 27 May 2024 10:52:35 -0700
Message-ID: <xmqqikyz9m70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E75BAE1E-1C51-11EF-A69A-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the third version of my patch series that fixes various memory
> leaks throughout Git.

Thanks, let's merge the whole thing to 'next'.
