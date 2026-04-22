Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92029ACF6
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881911; cv=none; b=tAu1XBkbiugPXQ58ajCXZq6p/hzu5pMkurgNutuE6iJUwgx32gdGJge5MFpb6Ul1YGGwGHrEHNXtYyS0uh/gCl9oV37rYMQrPbhjVAzrSuyreApifeORy5tAELIXXgGbEXJsLqcD27Ddle/JaKLwo7bynUt63Sh+9scckOA88gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881911; c=relaxed/simple;
	bh=5YC4dk4TjaQIEbwE5sJIS4QrV1mjWRDJOu9Bw8v2IfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrv1Qcf+3Pmk03XMcb5Qa7yl6IbxTLjGaPpOh1ccFQ0f28KUumgRACkbBJzyrCh6JpUD/oJIDbawqha5zA9hlDniDCXtVOXAVD7uFMfle6aPOGi8yy/7G7ZmfffyNH1krdwASn6a0y4XJ/rte1qefNckS76PqaL62B0l1TAvteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=PMixCxjd; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dL8Zss6W; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="PMixCxjd";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dL8Zss6W"
DKIM-Signature: a=rsa-sha256; b=PMixCxjdLv31pm7B8hoGrnr8nLM+VBZjObzekxNz3xRcag1RC5Z5bW93TM8wCgxHgRbE3m334IX5brR4s09mi3Xsace3qv4A+aSHLPRkaunnZ0qeGw8WaPpt5JWx8AgNCXZGvQOuqsxEawBxJrQBvCudAFAFalOXfcZXtIrQN6e7ecDTlBFGJu8H84vJaY9ltL/Uy/r4+e1ijpNdXoUsZchNKDqMN8F6OB0W+5hznf3T9+thumprO2Ekw0PU+oCr1XCilnNVHJWe0e1+e9wW/csKtWk0blz6tsLgoS035vi+ZTdSAsGDnu4UbXmitYXMQNAGgV4bc/XQTDuezm2h0A==; s=purelymail2; d=malon.dev; v=1; bh=5YC4dk4TjaQIEbwE5sJIS4QrV1mjWRDJOu9Bw8v2IfI=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=dL8Zss6Wjv71k53pXNkYJe8cqGDoYmLT9S/EvTliYefj4M07uQi4kN/PtMgEjZOXdRNCUvFif5rKsACKFdHBEMpSkQ7/kMmfxnKj1rL2SFGBrQCoCokxejdnCglp0pulgb3ItBvmqjs9zHTS5TDed++EhZ7bSVDArV/YZMycXpi6IIdcOenCF3ZBQNsVg0hyFaTK8vy0cLQykY59E54r4KMqXkyI8oDvQnQEh6hYWSkO26z0RlR+FMqqXupCmiaZX4T5CAzGBuR+cctbfE20BtiEpdl66+GqjLkHrURJDMm32x9QiD/8dqzkdbpi37kn9BxpP33xK2KjhSmfKCNUaA==; s=purelymail2; d=purelymail.com; v=1; bh=5YC4dk4TjaQIEbwE5sJIS4QrV1mjWRDJOu9Bw8v2IfI=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2102329899;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 22 Apr 2026 18:18:19 +0000 (UTC)
Message-ID: <d2b19306-71e9-4e17-a0c0-83309a00bd45@malon.dev>
Date: Thu, 23 Apr 2026 02:18:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] builtin/history: introduce "fixup" subcommand
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick,

On 4/22/26 18:28, Patrick Steinhardt wrote:

> Hi,
> 
> this short patch series introduces a new "fixup" subcommand. This
> command is the first one that I felt is missing in my day to day work,
> as I end up doing fixup commits quite often.
> 
> The flow is rather simple: the user stages some changes, and then they
> execute `git history fixup <commit>` to amend those changes to the given
> commit. As with the other subcommands, dependent branches will then be
> rebased automatically.
> 
> This is the first command that may result in merge conflicts. For now we
> simply abort in such cases, but there are plans to introduce first-class
> conflicts into Git. So once we have them, we'll also be able to handle
> such cases more gracefully. I still think that the command is useful
> even without that conflict handling.

Thank you for developing this feature. Godsend for lazy people like me ;)

Nevertheless, I seem to have come across what appears to be a bug. I 
carried out the following steps:

	create a.txt -> git add -> git commit -m "base" ->

	create b.txt -> git add -> git commit -m "feature" ->

	create c.txt -> git add -> git commit -m "tip" ->

	rm b.txt -> git add ->

	git history fixup HEAD~ ->

	git log --oneline --stat...

And the output looks like:

	3096a65 (HEAD -> master) tip
	 c.txt | 1 +
	 1 file changed, 1 insertion(+)
	699f610 feature
	0be07e6 base
	 a.txt | 1 +
  	1 file changed, 1 insertion(+)

More specifically, the output of

	git show HEAD~

is:

	Author: Tian Yuchen <cat@malon.dev>
	Date:   Thu Apr 23 01:57:17 2026 +0800

  	   feature

which is an empty commit. Is it what we expect to see? Sorry that I 
don't have enough time to look at the code in detail :P

Thanks, Yuchen
