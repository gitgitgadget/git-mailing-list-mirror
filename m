Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755343031D;
	Tue, 21 Jul 2026 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661729; cv=none; b=OTmTW2NaT8qkxAMDI5Yv4rOOOEkcFgb6ntMBdyObjEoGv7KUksnHLGUOfp1C8bxO8Qbqe6Zog4ajIZj+YezzyQz1cer5orumK/rcPNFsqYRJQJYB254I/gK8K8Prc40vvuLaMZ7gZ2czJiZ6XZYTZuGX32JJJBbRf1A6FCrzvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661729; c=relaxed/simple;
	bh=J0sYA8dV4q4rM1hnamb7aK9oi4RqQ5FYt1mpQ7DmckA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwtaNOg6hAGG5shHSnqrA1kXIxnVMtcQ6ooiIegZtOjo3S3VaXkYC1ab9CvLwjWI0IY+oPYWiLprWydxxKu8lcONHnIqPyrEypWkQrufSerxbYN9Q4rHjhTQWYCCxvSfdxMqaB+okCjUPHCMO7v67r4WJbfdw0oMHu1mCAcRSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XnCcXGVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YoYmn0fR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XnCcXGVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YoYmn0fR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 78DC81D000DD;
	Tue, 21 Jul 2026 15:22:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 21 Jul 2026 15:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784661727; x=1784748127; bh=yYjhRW/D0a
	Ak6hnOcMEV8thduNzZR3FNXSDddYKr6x0=; b=XnCcXGVIC5Fa+Ao5bxpZCIDEwt
	J80wfdLvaKO+6tq+nSrwwlDkRTxCih3w34L9L/j33wzGB+GSGdxjfgWU3UFxY3xG
	NGIQ0+J1kd4LGU7C1RHSH5PwrkQPKx7wyduEwjXfXgBSaw0QEM5zTI8digZ/LXEq
	fygVtm9wIq/VymU6yEW8NyBiEbftMN7+UJwe9fQwgrkeUX4vJppZNoxhetZXPfy5
	Laeg/RA5EGAEZti4+Bpo8OOEtTbotw9Q4j2DI7eykiayK5FxoUWcNniXPVtqrPiN
	4QJ8MUPK6DWKVc9DmewlOpFNRAP9ll9FJ8m3ATn41pL3q2nvOpig4LhshBIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784661727; x=1784748127; bh=yYjhRW/D0aAk6hnOcMEV8thduNzZR3FNXSD
	ddYKr6x0=; b=YoYmn0fRYhlwkR1B7+1clBgjFhLTkUo/NR9F25abSJ0iALe1THA
	IBMxfChcGWKkr83p460xkkrxt84tYer6E4J7uFQmx3rk1cv6GEE+j3manz/PS+fE
	7BfdTbK5L/kOv3zidx1UlxY4bxbQu7I4eW7WFaGCBsotyGZpZsHpKCBT+g1PdU90
	Ma1f/UYjZnFqGPnLcWPrltl53Ar0/ZKQy2AmUCDLbEDVPfqx+PzjxVKD1kNaiOVQ
	EUwGU13YWLUA0SywuFufj+gSX0INPhwWtPlfb/oZy1Jhrj+cDsYyIN519ucLJUDa
	NNaX6/u74JpiixVacbrlfigpYD7WsYdJGKg==
X-ME-Sender: <xms:38ZfalYF-HX8V1j3HLzCPOnC_1zUEbPluwdIc6oLS3fKeeDnn1OFgQ>
    <xme:38ZfaveKIr_B7ePcKdg9s2aRT2ZEZh22VOKN46xdKH7Z1pIdh0dtVRWejdMv3zzeq
    2W3cAbPs7oMAU6_SI9nQTIJNhXtlhwrgd-g6hdRcFHWfGOpDFNx>
X-ME-Received: <xmr:38ZfaintYBTJuf304VN56WL7zBwk9vOlokGCqtThmG5pARBNpL8KgEGdrI3bJtoOz7G0SSfwZ_cnLyoawJn3Vmd3CAHyCTgCFg>
X-ME-Proxy-Cause: dmFkZTFxdR1gy0nDWXKiaI4Ef9fpOxs8+NSl6kCOpbEkkfU9VVynRAkugNGQaRpmNLUKl+
    zBtSBOMb2yEO0vabuLHK29I5Z8wKzqYcKQOf820zZiHFouhBNw82xPTWFiZCdN+vmqb20Z
    gRbRgU5XgCn5LndlDkF6U5l6a8cqauig5rvCYudpynehH8Se9D3cEBmTLmdO+6Jy+KVgBb
    QVy6aGfyHRV5ISeJssBT/ZGrCwcahw9UyryKxaRFHU0vIlCEA3bSl759kZXfTDCKvD5V9g
    DpkhCKfsEBoG4Ybd74BfBJRozrLk97vCPDSmkM4OYUtsKWPUQt7ZIR+DtPMED5/5AtXKGm
    AVYAu9N38o8KR2kBqv2Yf6Cj5hPCvIxqnhRiA98WsYAzL8D3RCQQwGyV0WfjORyaFIAoRL
    bsDnYUhpXRN3/CzlYyejxVVQ5tr0oa2KcER+GXXhm02jUSPkwq8TkSYCp78tNr6sq5UpxM
    V2hmO4Xd8B3JMcB3GJhh95Nyn6wGbelZPNOHhlkzpQcSppxen/GVgViK/R6xdsSj7q9EDH
    d3JX7qmucN2slo6RolNDoATqaTd3ATJmcExnkBvWsk6EoANoJJ8Sk/7qZr7HqYBHtSC+Fw
    K3ISeqCWfKJ2k4x63+VDdC5HBs0T6W0waNpMw32wU1x/jRU48Om7Ra4dZksA
X-ME-Proxy: <xmx:38Zfav1HJstLwbY4b_dbAfCR-9Jn_Q8CXDZHEzFoR2b5BX9eNLJi5A>
    <xmx:38Zfardd9jp83S1U_vZeIiaIfwg1LBolDz1DPC8Dnc22r7iMlvBOHg>
    <xmx:38ZfapZhPkzy2uh6p0MbCg10fWkLdeaBfkSP6tz26RoK1dwJ0MxbJg>
    <xmx:38ZfagET_xWqm0-fEg3nUQ5hfy4E4N-0AX3sKsDgle6bT058bxZMwg>
    <xmx:38ZfahO3Jd4YqrST9eMUkv-pU06PfN0PSSjsSc4idZFFKO1fO88mn_2a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 15:22:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Yury Norov (NVIDIA)"
 <yury.norov@gmail.com>,  git@vger.kernel.org,  Thiago Perrotta
 <tbperrotta@gmail.com>,  Philippe Blain <levraiphilippeblain@gmail.com>,
  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  linux-kernel@vger.kernel.org,  Codex
 <codex@openai.com>
Subject: Re: [PATCH] completion: complete paths for git send-email
In-Reply-To: <al-0ckPhoa-ZPhSi@yury> (Yury Norov's message of "Tue, 21 Jul
	2026 14:03:30 -0400")
References: <20260719134447.381835-1-yury.norov@gmail.com>
	<CALnO6CAuitGp_xLYkXpkQYV9oiXsNNfsXZ_OqzkW7_6ND49=LA@mail.gmail.com>
	<xmqqcxwgz2u3.fsf@gitster.g> <al-0ckPhoa-ZPhSi@yury>
Date: Tue, 21 Jul 2026 12:22:05 -0700
Message-ID: <xmqqqzkww3ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yury Norov <ynorov@nvidia.com> writes:

>> In any case, when both a '0001-my-changes.patch' file and a
>> '0-tolerance-policy' branch exist in your repository and current
>> working directory, running:
>> 
>>     $ git send-email 0<TAB>
>> 
>> should offer both as candidates, I thihk.  Since I only ever pass
>> filenames to the command, I personally do not think it is a huge
>> loss if the completion script stops looking at refs and sticks to
>> filenames only, but others may have a use for that feature.
>
> Agree. The test should create a file 0001.patch, then a tag
> 0-tag, then a branch 0-branch, maybe something else that is
> relevant; and then make sure every option is correctly offered
> by autocompletion.
>
> Guys please let me know if everything else is needed before I send v2.

So in short, we want the problem description updated to something
like:

   When branches and tags whose names share the same prefix as a
   file (or a directory???) that stores a patch exist, the attempt
   to complete that shared prefix

       $ git send-email that-shared-prefix<TAB>

   should offer both branches, tags, and files (and directories???).
   But the completion only offers branches and tags and fails to
   offer files.

And the description of the solution would follow after that in the
proposed log message.

As to the tests, using 40-hex is misleading, and 0-branch as you
said would be sufficient to reproduce and demonstrate the issue, and
that your code change fixes it.

Ben, anything I missed?

Thanks.

