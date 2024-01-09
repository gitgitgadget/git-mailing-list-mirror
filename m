Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD163B782
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rY786Ib3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B00836CE2;
	Tue,  9 Jan 2024 12:50:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SYSKVWV8/DDt7ySeRWWhHwvE7MqmmJoVJAjUxh
	Rv/Pc=; b=rY786Ib3FdA534OGCJxWkPhNtDrnYlpSK/zHnTl9Ay3Qr8HcE81qb/
	TdIPDYqRND/1jO+4E0F11qXjXD5BsnLd3dT3S1IzPKZC2XmIuG2SI/WKG3+QOcH3
	00s6P1MZKgIqtmjE6GgnWXBCq+I1jZuyQ3JlNkJQxWvYbQZcoBKbU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3302836CE1;
	Tue,  9 Jan 2024 12:50:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBF6036CE0;
	Tue,  9 Jan 2024 12:50:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/2] t7501: add tests for --include, --only of commit
In-Reply-To: <20240109165304.8027-4-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Tue, 9 Jan 2024 22:21:21 +0530")
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
	<20240109165304.8027-4-shyamthakkar001@gmail.com>
Date: Tue, 09 Jan 2024 09:50:04 -0800
Message-ID: <xmqq5y02iegj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 865E844E-AF17-11EE-B0D8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> This commit adds tests for testing --include (-o) and --only (-o). It

"-i" not "-o" stands for "--include".

Please write in imperative mood.

> +test_expect_success '--include fails with untracked files' '
> +	echo content >baz &&
> +	test_must_fail git commit --include baz -m initial
> +'

My comment on argument order applies to this iteration, too.  Please
write your code to help readers.

> +test_expect_success 'commit --include' '
> +	test_when_finished "rm -rf remaining" &&

Why recursive removal when you _know_ what you create is a plan
file?
