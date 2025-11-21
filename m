Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1782F851
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763683856; cv=none; b=iri0n46TzsmF/UR6q5nVage2qTTeYW39FY33TCNULISQs3x+pjhbDzJjvXmzbfV+EWgz9+tUf4BEbh8vCrpLPP2jE0BwswDB9k7MorNOfL/Aj4tKr2G/pwCuv6B1wH9UY0s++pebjgXukhQ3x/sEKNXBCiZRztP0scuUttq7aOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763683856; c=relaxed/simple;
	bh=jWDon53CFCBgH/a1MaPDPlrwyVE+5EAnMhnzuTzDNio=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=sq8tmPEsWxtEOEY7PCnn5ENIBCSaugy+dr+nwOpnHcJepFOuRADuLzdA/b21WqfymZG2O3KNSAvvtX2IbpFxr0Ooy4NJHVcKKAIQY41330+zlPSICvy5qnFl4UCuVN6brx+V4ze1q4ZiMX8Pm4TrUihWBtbCHQycBQlIm8iLLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5AL0Ah1a2099568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 00:10:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Lucas Seiki Oshiro'" <lucasseikioshiro@gmail.com>,
        "'Martin Guy'" <martinwguy@gmail.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>
Cc: <git@vger.kernel.org>
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com> <6F4B3935-7F2F-43C9-8E5E-12E2FB3331BD@gmail.com>
In-Reply-To: <6F4B3935-7F2F-43C9-8E5E-12E2FB3331BD@gmail.com>
Subject: RE: Feature request: git cp
Date: Thu, 20 Nov 2025 19:10:38 -0500
Organization: Nexbridge Inc.
Message-ID: <010b01dc5a7b$4790ee30$d6b2ca90$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQKeVr1azXVqaIaV7libyPMAwgOV4QKA73/+s2RBSRA=
X-Antivirus: Norton (VPS 251120-4, 11/20/2025), Outbound message
X-Antivirus-Status: Clean

On November 20, 2025 6:08 PM, Lucas Seiki wrote:
>> and would like the history to track the relevant lines in each file,
>> like "git mv" does,
>
>As a consequence of Git being based on snapshots instead of deltas (see
[1]), `git
>mv` actually doesn't keep track of renames. You can think of `git mv` as
`git rm`ing
>the file with the old name + `git add`ing the same file with the the new
name.
>
>As Kristoffer said, the renames are detected by tools like `git log`, `git
diff` or `git
>status` based on similarity between files, which are considered a rename if
they are
>similar enough. That similarity can even be tuned by using the flag
--find-renames,
>available in those three commands.
>
>
>[1] https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F

I know this might sound trite or wrong but... does this mean that git log
can actually detect SHA-1 collisions based on similarity checks of file
contents?

