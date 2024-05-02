Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F715E1E4
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667397; cv=none; b=MgnGOu5H7hXFxpRcW8QiX9t27JHCMFA1qapec/LFdxD+oKxAX4tigeQo369DYWRDst46972rH2Ou2MEoYguBUA6uvI8xvMCJJvohuxN7VTg5RBYpRgOkgJcXzfjkq5E/WF84s5HFZF15M9bhjfHm0mwR41bx9lthIlwMDSA6kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667397; c=relaxed/simple;
	bh=wDdks73txfL0jqM/sObEDVOof2/YK5cmyMv0VkWslw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7Clj9YHpCTeEckBRfMR6Qds7zR7WBo+OvcuezZrGVyTPXjB062nhZ3Q4TsjtwJcWKB+6C5nZ8gvo00YRm6TdV9JsKd7Gjkg3VYskPuo60AOSPK2gyC+njgVO3h7li6zyLRgFSauyRcrRXclMQIj5CPpIe95vrTNqxRdr+aDa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OPF1cT8g; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPF1cT8g"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DB53305DB;
	Thu,  2 May 2024 12:29:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wDdks73txfL0jqM/sObEDVOof2/YK5cmyMv0Vk
	Wslw8=; b=OPF1cT8ghO6tLyLzJT2YR4DNclG67NZfRuiqpTB+nhG8zXbuChPxDB
	tZ9q2DUza82qVy4YOzhbLtbwJXE0jIBJD+hOATLRG7iMssHVFMKLpHm4TzG8O/Vv
	KX6qj8qRXlxTJ7bKhiy13cOXbq0fWhXvgiHMhV35w6vbDllOwBRec=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3667D305DA;
	Thu,  2 May 2024 12:29:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE5D1305D9;
	Thu,  2 May 2024 12:29:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH v2 0/3] color: add support for 12-bit RGB colors
In-Reply-To: <20240502110331.6347-1-dev+git@drbeat.li> (Beat Bolli's message
	of "Thu, 2 May 2024 13:03:28 +0200")
References: <20240502110331.6347-1-dev+git@drbeat.li>
Date: Thu, 02 May 2024 09:29:50 -0700
Message-ID: <xmqqh6fgfa81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 336CD4DC-08A1-11EF-B7B5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

>  * The color parsing code learned to handle 12-bit RGB colors.
>
> The first commit fixes a typo, the second one adds some test coverage
> for invalid RGB colors, and the final one extends the RGB color parser
> to recognize 12-bit colors, as in #f0f.

Thanks.
