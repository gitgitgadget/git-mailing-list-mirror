Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA217C73
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720890245; cv=none; b=urohWmJbbHoFmlAl0/JeuRdKYxZeCWnl0tpgNv5nt4DblyCz5cu6dYE6pz8Q/r1JMdif58nk9r8xiN6EWwNqlAEgW4dktOgnd2W8rKTQhakyhiLzklod9gas7o68jck7IsOaTbWz6QcE1+hImXTJOqjD7dbMgXYLJjRIoBMxytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720890245; c=relaxed/simple;
	bh=UFs8/tVqodXubdJl4Dy5YR6E2BmQPx6Jqv3njPS9iXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox6ix8/7koxMRfLZurfB4OjK+5u8HLGoQ93SN7i74B7doo0Uzy2yy2Zm+HuiUXD3CMs57ul5oQ1KkbV5YAHsTvOtZCbsN6MbObLoMKF3CTJuhssI2MRL6eyhrLkDLqILuPW7CwzuuhjhacnaUdyi7rVgiJDi52UXQsoF9BfhZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=0q7rLhSS; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="0q7rLhSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1720890240; x=1721495040; i=antonin@delpeuch.eu;
	bh=SuYltWXnaMGeNU3FjB8nUltmh2DtXKHNAn7mLPDqqfA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=0q7rLhSSZLj7vOh7hDYk8vQ4wBqKBiq3FeX0OENTg2uQTQHeAQxhfo50yR6XQM1q
	 JWsQ0tqAwKN4MUv9kbIHgZbABFp5HQSaQ+lD1Eu+7o/MNt8jjuN8t1BBy+f5823zZ
	 UTDkVEfDMNq69ByqJzlyKSRlKZkFqmc9bHuiyNdmdGgvVOxygK9n+nqyZZ5BOpDcg
	 RO8iIe3CwBO09ky6Zy4udCoH+5INm94YatGeRI3xagIa+OljEBqxBHYATdhAFpRWz
	 54/cZ3cZqnjBzphQ2P7iX9tvHV/f9Dbw7T0k0Dppi5sRJxD2w9FcDqx/0ziJn2LAV
	 wkMsQH/n2E8pkX2j/w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.21] ([79.246.85.203]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MD9jV-1sbiUy1DSj-00B2Lw; Sat, 13 Jul 2024 18:50:49 +0200
Message-ID: <9ff7c0e6-af29-48a2-bec7-be4554681671@delpeuch.eu>
Date: Sat, 13 Jul 2024 18:50:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] merge-recursive: honor diff.algorithm
To: Junio C Hamano <gitster@pobox.com>,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
 <pull.1743.v2.git.git.1720551701648.gitgitgadget@gmail.com>
 <xmqqmsmpw2mp.fsf@gitster.g>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <xmqqmsmpw2mp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTx57mvc1ZQUhVZT1TTzhrL/Jz5+gX0URiiTrCMEfOr2/AtN3iz
 cfJZzSVbaNm6Yglj897g0T8qL3yH2uZwRiOQlXGudpCnsMEPkX8dlbOQ3bTCeWSnPNaAxTL
 aYtuklOIo81klxk2MpdvBVAtUOy98XNohZ1gyouYt9NzVFdOBgMIjBljLGnJhmpWCRBQKuD
 ykYVnHVhvJQkMQ+x4LLwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:czGsfrMeYmw=;ogfEQ7hPaYPr9AMjEM/qMhal1S9
 g1J4PHK4OVnzb210o/Eo7lgKjg5EUi+5wniAjxF9o3bT/bbsal7yJeQup8EtLoVeftksNHL+l
 3qS9IZ4Krjc6ObFjgaYYQKFm7WIiFUSIe3mN/nbu+qYVV3XkPIYY6blJEKTAbqRQvrSxpzlyF
 fmkY5QDv1HBY0eJ8lqc/ecEIVeGhKB475/HmA/gro8eCw1KlY/kNq6rZamn7PVijrLhlCCLcq
 zQyh8fSFKm3LYFIB4VvMKvc0oHLiy3XU4Lhl6TExUZCvFKkJoo5/ex2DgNWpXZWPewfIH7CX/
 0nXWtFAZdFIfQIC8F3a2SbVBEG3OaKLrt7ypKqttZre50yS24KOBM+yBIHnm4FP5cFypwV3ey
 ctQdvJsVwmuJSxn+FUmMMBYbIRzsMGn2DBYlw7MkAB+8kL4EQHJKMV132NioiLCcahTs/4tq9
 HhrzdICda5uD2QX1CNBk8WnfZZPqG+2efMUKNRqpEeS+1ZkaeJ2nfdFuJTdqbkZ2874tpMBlE
 82e7mBK8cJRWm/83fr6I2KAXUs+YLWwWmX0P3sVv2Y4DF0vPwO6kdH0YICdRBYTiDAKXjDPEv
 TqscMCV3oqA5ZMiVIxneIwWz6DmpOw2BQRjj88vDFglMOLriWAih3m7NiW3QGAq4o5g3euL92
 dLhG95Bfv5UbnpFUeSigdEuMXXEoEnMpXbKuMyuPwm3Z6X74Vy1jOanlaEXEIBVtvcHxUuQPH
 pMhGiqDNhTkbSs/bIaiymJqdFH4p75B1g==

On 10/07/2024 19:58, Junio C Hamano wrote:
> Since be733e12 (Merge branch 'en/merge-tree', 2022-07-14),
> merge-tree is no longer an interrogator but works as an manipulator.
> As it is meant to be used as a building block that gives a reliable
> and repeatable output, I am tempted to say it should be categorized
> as a plumbing, but second opinions do count.  Elijah Cc'ed as it was
> his "fault" to add "--write-tree" mode to the command and forgetting
> to update command-list.txt ;-)
I'm happy to change it to use the "basic" config if you prefer. I have
to admit I don't have a good overview of what's porcelain or plumbing.
> Isn't log-tree shared with things like "git diff-tree" porcelain?
I'm happy to also change this, but looking at the call hierarchy we seem
to have a complicated entanglement of porcelain and plumbing commands
here, so to separate them is probably more involved.
> Can't we save the scarce resource that is test number
> and make these not about "I test cherry-pick" and "I test merge"?

Yes I agree, let me submit a new patch which does that already. I wasn't
sure if it was worth including tests for different commands anyway.

Antonin

