Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAE419FDA
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190516; cv=none; b=Nv5rGbNdtCN0h7cQ+ADuhLtoG3E4mu27i8mXDzC8NZQTkcJwEtlJF0XS27Yvtl5Y8hRf/C3adsOLf2p56v7ih9AbpeTZgFGTF4wfI7umzVDJq+qr8J5SXhggj96NubDiBmz4qwFZdNMCvUICOPxLfs9xpkCRUPl0l31kTnVRwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190516; c=relaxed/simple;
	bh=izBk78L+E0rPEK9ILCvvwjhXoCKV50SqBQ3+FiRbRMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVeWadZYbiten1/StROl6AEv5tY9L9XTvnV6pMnMOrQVOoYR3DuYauPjgz3jhSbyDrLNurr5GxjHuy+7+3ig/A4MvLNm61ywQMDV9Ri3Titw8o5gbzxoCo3XZO5DAM4x5N38s1icOfKLuqX2NSVWSpAkUq6kCY0KkEct/AqkSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hysm86XnLz7QXvr
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 10:21:12 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hyslz4Ks7zRpWC;
	Mon,  5 Oct 2026 10:21:03 +0200 (CEST)
Message-ID: <7012706b-516b-4cd9-abf3-0144093e0779@kdbg.org>
Date: Mon, 5 Oct 2026 10:21:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through
 remotes
Content-Language: en-US
To: Hanan Arshad <hananarshad619@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net>
 <20261005055337.7579-1-hananarshad619@gmail.com>
 <e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org>
 <CAKPibBx6364BcB2nqyQ7jhTaQMaUuR2TNKzZ-9H8VopcRjXbZw@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAKPibBx6364BcB2nqyQ7jhTaQMaUuR2TNKzZ-9H8VopcRjXbZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.10.26 um 10:03 schrieb Hanan Arshad:
> The use case I have in mind is narrower: temporarily handing off an
> unfinished working state to another clone or developer, without first
> turning that state into a normal branch workflow.

Understood. But you don't do this ten times a day, so...

> The question I am trying to answer is therefore not really "should
> stashes become collaborative objects?", but rather:
> 
> Is there value in providing a small convenience command around an
> already-supported stash transport workflow, so users do not have to
> understand and manually compose the lower-level ref/export/import
> steps?

... why do you need convenience? A simple export plus a push or even
just a single push command are all that is required today.

So, IMHO, there is zero reason to upgrade stashes so that they can
achieve the exact same thing that we can already do with branches.

(Hence, if indeed you do share your half-finsihed work ten times a day,
then, please, by all means, use the right tool for the task: put your
work on a branch, not in a stash.)

-- Hannes

