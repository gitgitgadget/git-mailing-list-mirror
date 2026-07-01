Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B62DA765
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929685; cv=none; b=hhOOCC5X+gfaLLRe5WhHsUA/fWqfeGbkhH54OBFV0q/VBL8N+cpsd4sSfbw4NCyAj336QR39gkN0gXVFOlrMJxBCUOOr6MtFkWdJSIDJR19U+tijZ+XWb4ESur6nqbHDwIi1MnumYUiYbFAtNhLAnsCso/cO757H1/RQeXqVmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929685; c=relaxed/simple;
	bh=BbdZXsxdPyLF+3aOeSix3Mecv5AgqrE8Wmj3kit5s2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rKm/4I7UAQZiacrR+jZOHnJm8nrgXaUpkVmglZ0LBHm7KWyFMxn3wJZL28tJ1Upc7hiDUqemzw3C6F6tucu6fFUgIZySrkH8d4HopU9MG54muxUj8RvHMMrNkl/5G2ob6+x/6NBadOyRoZKiN/QgbTQCnyT7XX7LRBEIcaTWlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=GXllrwH0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=G1X9x5cr; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="GXllrwH0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="G1X9x5cr"
DKIM-Signature: a=rsa-sha256; b=GXllrwH0JnGjQgsnP69DBZEDRhyGuu9fgRNyUzSuvYhWGvMaLPOpV4y1qngWJpDIvEWw9GxZq+GuXC0Lr89CxqvF84tcYDKw/jiGdLbtwTIDRGq6Y8utRXxMc2Jo20/h7dpd278JmLv2/bUAmKJalLTIrj4Yee+L0vkWTz92DDySdzo3SklTNfj5adjgVg1Kos+0NFFEXrtmbHRjCdIqot1JFlX332DK/FRtUR0GSSuD7eqpHGb/lJ2WrX2lqKDERBsR3vCGM6imlblQuwAH32+W17P2xFVmqCi6M/KsFVIud7/t7vYbyoJ5MUoPzNlvXA+VxB4F5/yN+8ebxg4uTQ==; s=purelymail3; d=malon.dev; v=1; bh=BbdZXsxdPyLF+3aOeSix3Mecv5AgqrE8Wmj3kit5s2o=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=G1X9x5cr6TzngdFOI+OHVNNep4ja3zfUKB9NR8rcMK7TRxaFMLH4Ky+kh0O/5O7rInyP7N5g8j2oXeVtQMJywngYcPAL0KubAt+kbs9ANAKepEJ/mkWQoA/by6vvOePX0ijHgJr8UcjXn5jP6ZAwyxC8gTBGJF8InRYY7IwMSt+xXRV0ll6XYbnIkviBCBttj0og3qXaLD4j56ovUVsKOfq7V6Ptq4fxURdXjapjIQVtxvC2cPm1u6/YHLSw/w9wLLsfgoB119ojtS1THg8rGEnqNmqUK0wqq9CT//kW/eWlX1qF//QChrViSZXLhrMQJC+IJkf9eGcq7mD5eqROzw==; s=purelymail3; d=purelymail.com; v=1; bh=BbdZXsxdPyLF+3aOeSix3Mecv5AgqrE8Wmj3kit5s2o=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 187319238;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 01 Jul 2026 18:14:40 +0000 (UTC)
Message-ID: <0462af01-3b81-4c72-9c4e-5124c6f1ce02@malon.dev>
Date: Thu, 2 Jul 2026 02:14:36 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
To: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260627160813.1074201-1-cat@malon.dev>
 <20260627160813.1074201-2-cat@malon.dev>
 <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev> <xmqqv7b34snt.fsf@gitster.g>
 <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev> <xmqqbjcv2h3j.fsf@gitster.g>
 <18ad7c1c-5ddc-4f62-ba7c-5cda53f5a48d@malon.dev>
 <CAP8UFD3Z0M_1NEXGcAxNZKpRUQiSkHZLTEvNNYushKA_PoPgjA@mail.gmail.com>
 <xmqqbjctz9mh.fsf@gitster.g> <054b3fb6-0e69-473d-9778-b1b11ea82b3a@malon.dev>
In-Reply-To: <054b3fb6-0e69-473d-9778-b1b11ea82b3a@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/26 00:20, Tian Yuchen wrote:
> 
> Thank you both for paving a clear way forward.
> 
> For the upcoming V5 patch, I will implement:
> 
> 1. Revert to the shields ('return NULL' for the getter, and bypassing 
> 'repo != repository' for the _clear()).
> 2. Add 'NEEDSWORK' comments above them documenting that these are 
> temporary changes.
> 3. Update the commit message to reflect this.
> 
> Once this initial migration safely lands, the next goal will be to 
> investigate those failing CI tests.
> 
> Will send out V5 shortly.
> 
> Regards, yuchen
> 

Sorry, I forgot to test the repo_excludes_file() and 
repo_config_values_clear() with/without checks separately earlier. As 
for repo_excludes_files(), I found that the check wasn't necessary, so I 
removed it in v6.

In other words, we're now only filtering out calls that aren't passing 
'the_repository' to _clear(), which is still a task to be addressed in 
the future. I think the current situation should be fairly satisfactory.

Hope this helps.

Regards, yuchen

