Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701C5DF3D
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682617; cv=none; b=qh7vP4XfNqgY7BG6WZIT6H9QEEIsd3g/vWagsH18PdA6uz6rZw3mfd1KFsZJSTmvzi25tp4QVX67TvlunbG7DTV49yVDCw7gfs+Q83uuwzuJ+9Bzq5Nu4VUkgsweUqVuf+Qny/Y7I8N5mQ7OOyF2KznDWBIAc0/FkKliIapFYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682617; c=relaxed/simple;
	bh=4JULHKczuipdyqoBwAgoncfO0sN9rtEs7xgGnkJRetA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oqv6ZVvi7jr5qyNrMZ00IdgtA/AuXh/a7M91bUyDQW5V6DtE+mPCXWdEGWLlYRJEd5pY37AjA1IYs869qSvvV/rXv9FnVSNIEZYjJvk3pDqQj2bZMTIr8ug+qxGLUM1akLBrqLvX1t7vKcF8lzNIsB/MCCBqc4SiOJD+J0dRg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tionis.dev; spf=pass smtp.mailfrom=tionis.dev; dkim=pass (2048-bit key) header.d=tionis.dev header.i=@tionis.dev header.b=hyxS+MCM; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=X3FzOiC6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tionis.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tionis.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tionis.dev header.i=@tionis.dev header.b="hyxS+MCM";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="X3FzOiC6"
DKIM-Signature: a=rsa-sha256; b=hyxS+MCMpQZKEYYGWgDl0Zn/gfm2P2bfZlE34cgT1x7npIpdqUZQ6hegjnRQ0gt6NgxzKVNeiCj7n2j4KYCus3mZ4sQSw9XwgWr7Zc/9DHgW8jGEUwAj9ixGGAlea7viXfbIGU56nF41h2SUP7y3WezZK5FgqRwRLQr3I3u6grfewTo1TpeTV7KlfNbxirk4uZgy8TUwv4/aWFX6N7vvtT88MheSIf80W2fBtoC2o7Lbn3xg3fhyyyi8kUTsWt6gJhjUoraoO4yhfvaUTwNlilfr9gjHzgkX6xe7iF/igsiVSLczGYlzlyILzoYnZ1WVqX/+SzaWv+Ax7uHBTOxW+g==; s=purelymail1; d=tionis.dev; v=1; bh=4JULHKczuipdyqoBwAgoncfO0sN9rtEs7xgGnkJRetA=; h=Received:To:From:Subject;
DKIM-Signature: a=rsa-sha256; b=X3FzOiC6kN1y2gA7vzbSoxuFVLaPljLMu0ovdKNlZP5ebvnBnc7aVTLmo3FVc+hU9C2iT0ClGK2KQDLoKAvbTmqry1vTU/GBy8CKLW5i62QqpUenb1YiIoa6riYD6/zHjpnCMvGxEEkZPR15wg/FnjWxKaQWXTEfh/JoQn8q33mkZUaH5UowbAMKfpC9CCmgB+YubH0YcRACLwmyCp3qYy46Ntbt4gHc5u0kY3clfBMRMBq2SRS0vQl28oDjBJDP9HOhXazwANmXxDVTaLZ6u/CT0qakxvxJ1nI7WaJcAIBJtcDDTFeTMiSjDhbHZFpvRVjjgu6/O7FHkc3Cj8PY5w==; s=purelymail1; d=purelymail.com; v=1; bh=4JULHKczuipdyqoBwAgoncfO0sN9rtEs7xgGnkJRetA=; h=Feedback-ID:Received:To:From:Subject;
Feedback-ID: 2034:545:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 239483542
          for <git@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 11 Feb 2024 20:16:47 +0000 (UTC)
Message-ID: <1d8fa22c-eb13-4cdb-8499-e19f0dea6b42@tionis.dev>
Date: Sun, 11 Feb 2024 21:16:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: tionis <git@tionis.dev>
Subject: Bug: git-subtree: splitting subtree fails when subtree was added,
 removed and added again
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I discovered a problem in git-subtree that I could also reproduce in a 
minimal proof of concept over at
https://github.com/tionis/git-subtree-bug-poc

The same bug was discussed some time ago on stackoverflow: 
https://stackoverflow.com/questions/68761778/git-subtree-cache-exists

It seems to occur when a subtree was added, removed, alter added again 
and then modified in some commit.

This leads to some error with the cache leading to an error message like

fatal: cache for $commit-hash-here already exists!

I'm unsure how to work around this other than modify the history or 
creating a branch from before the first addition and fixing it there.
