Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D212F5485
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770442541; cv=none; b=JMLV3k+k7P7QX5s9aK8JNNWRZuTAznWgI+TaUmzfmrg63ZsnLdv5O2hpI0/4jxIjT/nBQ9zDzcFyoBMG2Yna8yr1moojgAJP5wR2Qa4AKhWdZ8aFHXu8jsxvZH56YTaiCa8z8h3WhDAfr9w9YQBi7WbuA96mpdATe8JZe2ZJWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770442541; c=relaxed/simple;
	bh=9D698o55/UG6l3q/LNFXP4iK6jKlwimU6Or5LV3ZD2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeRp8sK1OeyioIO1E6vJ69IZu308LszAEG0P/qjvJipBtsfZ5DDXHSxNANqePAU0X7F6F0c3Yrw8m44YVBl8H1aOPCmoI1NHyiu5APRdzoNKiJIfuJgHPPj4O0J70ou0smKIapbEUhMnn/QP6NIvnP3DDdJPF1k/WJuIVkspwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=h27exLIH; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="h27exLIH"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1voaym-008nXy-4B; Sat, 07 Feb 2026 06:35:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=jF2N+f5MQ0BOzt227zSpbVmXMPTYGrmcd52MvxLVCho=; b=h27exLIHePXB27inDU5DI0jr7s
	hHku2tm8FdM/54+K5qECctQDlToHDXMKuZMYvnQ2eLliRI6rTcH8mBlEDd5IPXL/6QJ+V9RDBn4tC
	sjE2DmKfuPQx2LRhno9aEDirCIATs1SAFs+/002pkpQjyLMNM+OfR+oBQxlPDrsDq9L9vObqifZXn
	SLmfcCB7iXAX/E7PmebSw75aRCUYy7+5i2LiZsmOYQlXBPzpYl0F9cKIR+Swxb88ffb20wIvwuQ9G
	ZWow6V6cDTWozEVdTrXRyHVZ1rXg3lODzixoj9GXK1/dpWs59Xsl/e8YSxj0TIyJ+zGSFUz5VK7jL
	yfvxI8Aw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1voayl-0001gK-Kf; Sat, 07 Feb 2026 06:35:35 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1voayW-005Noo-Oi; Sat, 07 Feb 2026 06:35:20 +0100
Message-ID: <aac216f7-5d3a-47a9-aaee-5ea3a330fc95@howdoi.land>
Date: Fri, 6 Feb 2026 23:35:17 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: avoid ubuntu:rolling in most jobs for now
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <xmqqy0l6khkd.fsf@gitster.g> <aYWaytvnR8wOdc1s@pks.im>
 <20260207042703.1180704-1-ask+git@howdoi.land> <xmqq343dcfsy.fsf@gitster.g>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <xmqq343dcfsy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/26 22:56, Junio C Hamano wrote:
>> +	if test -x /usr/bin/gnudirname
>> +	then
>> +		ln -sfT /usr/bin/gnudirname /usr/bin/dirname
> "-T" is somewhat exotic, certainly outside POSIX, and is not needed
> in this case, no?

Correct, this works just fine without it. You can omit it.

When requesting an ln, I usually know and specify both filenames 
exactly. I do not desire directory behavior as I might for cp or mv. -T 
/ --no-target-directory is useful for this, if perhaps non-portable.

The coreutils info docs [1] highlight an interesting race condition that 
is avoided by --no-target-directory:

   when the command ‘mv /tmp/source /tmp/dest’ succeeds,
   there is no guarantee that /tmp/source was renamed
   to /tmp/dest: it could have been renamed to
   /tmp/dest/source ...  if mv -T /tmp/source /tmp/dest
   succeeds, there is no question that /tmp/source was
   renamed to /tmp/dest.

but I avoid writing to /tmp itself with anything other than mktemp or 
rm, for this very reason.

[1]: 
https://www.gnu.org/software/coreutils/manual/html_node/Target-directory.html


