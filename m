Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE51917D9
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174845; cv=none; b=Bw+CfTbAdPxURKBSHnqAFN5qUBQu7lHrQaMsC2KxvQdZgQObUovdLV/WC1TVfkPOHANxVGB71dOtNAM3PahvsinaeKW6jUyCOMvDoE7al3H9uAAycCw9eVzTjwFewZVm7RgW6llUR7Hej2/Hzz0HFygFpaDhVnxCAl6RO3FgPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174845; c=relaxed/simple;
	bh=w7Ii+C/2XfY4xQId0AEnMZYdRAmrxaNiALdmaC2i0ww=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZBCGx6v3Lk9abVeVB1EZSRd1RlSBCntZ5RFFmpliwLKLddto0vosqVfHpmfvFKvBZY7WjkpnG05k3So5EPg5U+2L6Fo54/mu7Lp3FMvPiX77a7RtNsxwoM4FozP6W3rRtPn7ooOr9V5zt304re94n8tV9GehG30bfqojTxJmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50TIKdfZ1982370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 18:20:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com> <xmqqbjvpk1wo.fsf@gitster.g>
In-Reply-To: <xmqqbjvpk1wo.fsf@gitster.g>
Subject: RE: [BUG] PREFIX environment variable ignored by git config --system
Date: Wed, 29 Jan 2025 13:20:34 -0500
Organization: Nexbridge Inc.
Message-ID: <008501db727a$80b08430$82118c90$@nexbridge.com>
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
Thread-Index: AQN9fsp86lG5K0M4uVvG8mjsU9to7QHrUQSBr9qcrQA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250129-4, 1/29/2025), Outbound message
X-Antivirus-Status: Clean

On January 29, 2025 11:42 AM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> Thank you for filling out a Git bug report!
>>
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your
>> issue) export PREFIX=/home/randall git config --system --list
>>
>> What did you expect to happen? (Expected behavior) Git should use
>> ${PREFIX}/etc/gitconfig instead of the build location to
>
>But that is now how PREFIX works, as far as I remember.  PREFIX is a
build-time
>thing.
>
>Perhaps you are looking for RUNTIME_PREFIX build-time option?  I do not
know
>how well it is maintained these days, and if it allows you to futz with the
paths at
>runtime (without _moving_ the executable and all other installation
material en
>masse), though.

I did try that at runtime. No luck. I think we need to fix this.

