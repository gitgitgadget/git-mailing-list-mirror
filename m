Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371B3630AE
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134678; cv=none; b=kPQH+8Zsn4ssdV5+EVttANoo5yM619BlpY3JRA35G4rvoj5dM4LPo11AVLSOuY2KQxQDeI+wyIukqUhHPsKpVRoaGdSr0pI9G8+t96Cz5QLVG7IbPBM4cCIP3a1ebAFYIibGHpXfzU+3SJaQlEehKPo/4onK18Bvc7y2uMhLSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134678; c=relaxed/simple;
	bh=Pw58hJSUh/P9Z5nOIFQTh8cVNYRyyHIdr4eFZCIRlKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpVvliTMVKMygBf2ZtRe0rO7zEX8YPhZJuSXDN7LxFm5XBomq846UaWOcBzpNeqs9w0gwAhYoDAy1pto0HBsx6uC2d/3T/N6kMCuwNevrICMuR4OFe6GCYjufGJ08ldw+jRzKT9/UNRfHxowlg5GEkwfofjuNNr+D30GlWmOSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-225-9-246.nat.highway.a1.net [213.225.9.246])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4h7pwn3flnzRpKv;
	Mon, 27 Jul 2026 08:44:25 +0200 (CEST)
Message-ID: <734cf745-ff32-4681-be2f-ad3225c80bec@kdbg.org>
Date: Mon, 27 Jul 2026 08:44:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] userdiff: add support for Swift
To: Michael Montalbo <mmontalbo@gmail.com>,
 Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 "D . Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Eric Sunshine <sunshine@sunshineco.com>,
 "Scott L . Burson" <Scott@sympoiesis.com>
References: <20260717140232.6722-1-diy2903@gmail.com>
 <20260721065736.8747-1-diy2903@gmail.com>
 <CAC2QwmK7HVma7HMxmXvC7qa4XQVomteC0x7PpX61MjpDLbvDzA@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAC2QwmK7HVma7HMxmXvC7qa4XQVomteC0x7PpX61MjpDLbvDzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 27.07.26 um 07:03 schrieb Michael Montalbo:
> On Tue, Jul 21, 2026 at 12:06 AM Shlok Kulshreshtha <diy2903@gmail.com> wrote:
>>
>> Add a built-in userdiff driver for the Swift programming language so that
>> diff hunk headers and word diffs work out of the box for ".swift" files.
>>
> 
> I noticed other languages add a test_language_driver entry to
> t/t4034-diff-words.sh with corresponding pre/post/expect
> fixtures. Should we add something similar for Swift?

We could that. But since the words are basically run-of-the-mill and
nothing exotic (like we had for the scheme driver), I gladly forgo a
test script at this time. In the past, these test scripts turned out to
be non-trivial to get correct and it was a burden for both the author
and the reviewers. It would certainly exceed the scope of a microproject.


-- Hannes

