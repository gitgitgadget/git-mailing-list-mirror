Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05D40849
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734804391; cv=none; b=XgWwKPc3HKPs+7z+zStGPT+92jsY7DRlc4PNHfsqR+1MT515OtB1/UMJ8IDc6ISUkPvmJgZphv37jgpHmntuIHl1X9IXwmlZkkgfLGpgcDpB2ehqE/RIdccTzwtr63mqhxapqdkZwt+hlSpJHY87MwRDA2Un7trZLwEa2qLlT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734804391; c=relaxed/simple;
	bh=eykzPbOFOcawFCg3oe1CZUA0PcQ/l677xtiOhuH99v4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=c2zhuT515Lwh2ugZv2NE2bvbDU0ZjtSiS9KzgXtNgwQl/+6q41PK2Kn+WoKA6ml6ruTKuaZqTmXP26EHBHmb+1fovMm75nU8NE8LooZphwPRqTFoErHMEu6j6NvBZIsGJzvsMydo48tUzckADIxxd1g0VQv5aPMfKQT5OHzGz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BLI6MMf2694604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 18:06:22 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>, "'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>	<xmqq34ihc4zt.fsf@gitster.g> <xmqqmsgoc42a.fsf@gitster.g>
In-Reply-To: <xmqqmsgoc42a.fsf@gitster.g>
Subject: RE: [PATCH 3/4] reftable/stack: fix zero-sized allocation when there are no readers
Date: Sat, 21 Dec 2024 13:06:17 -0500
Organization: Nexbridge Inc.
Message-ID: <01b201db53d3$0b5953d0$220bfb70$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL8gfJLxKZaOGUyuC/X73rZCkMxpgIWlImYASUs8ysCCezeGbCEdI0w
Content-Language: en-ca

On December 21, 2024 12:57 PM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>>>  reftable/stack.c | 44 +++++++++++++++++++++++---------------------
>>>  1 file changed, 23 insertions(+), 21 deletions(-)
>>
>> This somehow did not cleanly apply, so I whiggled it in manually.
>
>That is because I usually ignore author-supplied base, and this time I used
the tip of
>ps/reftable-alloc-failures topic, which brings all the text these four
patches touch, in
>my initial attempt.
>
>Applying these on the author-supplied base (ff795a5c5e) yields the same
tree as
>the result of merging my manual application of these four patches to
ps/reftable-
>alloc-failures into the same base.

Ready to test this. Please let me know when and I will report results.

