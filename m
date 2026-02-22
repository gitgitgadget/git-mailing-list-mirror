Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6D2F872
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720757; cv=pass; b=ld0259KQqrh/k6w2EOz9uE9OELyePRzUN15WqJJG/qsgCWX8mFhWkulBDEFAUKaXcvfMLmSit4ypGYF13MUKwpA6OPE5Vgg9/VzHIltdK6ihH7mEGIq36/MIxrcuSP7QjRx0SuaJCf19bSdcFbl1XFJZ3NIGJJR+4ZJSMuaV07Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720757; c=relaxed/simple;
	bh=FJ2NzTxm9NwmLCSayNle7UhMb4FgGJn4nwT4LdwV00k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J5/tATSORG2OnWDxms4njyWqZFY4m4Dh+o3SHJOQkAIOvJDe1EFDpQ5BSY4f19wbvJJFnX9TQqvn+VZT8Pt0Zj1tCElGJDhe7pKGQqPh74Pk+fnvu8Kvq39h39dMw8iokzkStCiOC0qFB4t9bRBeHZANQxEwsxPVlS+aKQGBt+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KvaS5ok+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KvaS5ok+"
ARC-Seal: i=1; a=rsa-sha256; t=1771720749; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CFP7chkvrBBtyhmH1hnVwDUpfiqzJyaeeFlIrrHYBXGeh5mqv7UI65UaVr8ifXmAn+X1BWQWAE0q13QGh0Cy3PXUtBkMhQ17kVQlmoNpxrdvhFKLwB3XTD+1o0br3dThoXmF0D5nHF42zplNyALWs30zFtqJsjNZvPQVg1f0ZX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720749; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J+zOxQMOpIhutGDnDOKpmTLWuImNRo0RUK56axla8fw=; 
	b=lSCdsjtxaSNN++FyCdilnSxJfqJAU4BP1ErVNJJb4BNc4Ura56nV92ud6LrcGNwQce8ky9ABD2NC6rY8gHOOsbu+zlXJthzcLePNzAQzuMW8EJ8GSh9cXHUBMLaf6A2M/3tIFyTWlt9bRiToIDnKyXd0w1QxAqg/b9etz6VpiFo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720749;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=J+zOxQMOpIhutGDnDOKpmTLWuImNRo0RUK56axla8fw=;
	b=KvaS5ok+TaZp3cSoh6+oW0FxLIlqBwHCCtxDSjHBC5KH4hi/02s8gYuk1mcT9Gv2
	TgiFCI7lSFwMvMPEyYcxQD7EcIEZlLDh6yf0tBrWcmxQkED+QMD2+aLwhm+gpMqdk8N
	UAkj9vmmdUlc/LRz7Fa6JAdo121Ta2JwEWtzedH4=
Received: by mx.zohomail.com with SMTPS id 1771720746557671.198346061356;
	Sat, 21 Feb 2026 16:39:06 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
In-Reply-To: <87o6liw4s1.fsf@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <aZjuTSopOMvwR4hQ@fruit.crustytoothpaste.net>
 <87o6liw4s1.fsf@collabora.com>
Date: Sun, 22 Feb 2026 02:39:04 +0200
Message-ID: <87ikbpwr13.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sat, 21 Feb 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> On Fri, 20 Feb 2026, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>> On 2026-02-18 at 22:23:44, Adrian Ratiu wrote:
>>> Hello everyone,
>>> 
>>> v2 addresses all feedback received in v1.
>>> 
>>> This series adds a new feature: the ability to specify commands to run
>>> for hook events via config entries (including shell commands).
>>> 
>>> So instead of dropping a shell script or a custom program in .git/hooks
>>> you can now tell git via config files to run a program or shell script
>>> (can be specified directly in the config) when you run hook "foo".
>>> 
>>> This also means you can setup global hooks to run in multiple repos via
>>> global configs and there's an option to disable them if necessary.
>>> 
>>> For simplicity, because this series is becoming rather big, hooks are
>>> still executed sequentially (.jobs == 1). Parallel execution is added
>>> in another patch series.
>>
>> I'm interested in how you plan to make parallel execution work
>> gracefully.
>>
>> We've already established that it's necessary to preserve stdout and
>> stderr (including wiring them up to the TTY) so as to not break
>> existing, widely deployed hooks, such as those in Git LFS.  That means
>> that to get parallel execution where the hooks don't write over each
>> other's output and fight for the terminal, you'd need to multiplex each
>> one, including providing a PTY if the appropriate descriptor already has
>> a terminal, such that the output is at the very least handled line by
>> line and ideally batched into per-hook chunks.  Is that the plan, or do
>> you plan to do it differently?
>>
>> I ask because situations where the hook output is not handled gracefully
>> and hooks fight over output or where the existence of TTY on a file
>> descriptor is not preserved will result in bug reports and broken tests
>> for tools that use Git, which I think we'd all like to avoid.
>
> Hi Brian,
>
> Yes, this is all done already. Phillip Wood actually brought this TTY
> issue up in his review of the v1 parallel hooks series (many thanks). :) 
>
>
>> Of course, that's not in this series, so it may not even be written yet,
>> but if it's not, then this is something to keep in mind for when it gets
>> submitted.
>
> Yes, that's a separate series [1] and I'm about to send v2 very soon.
>
> Please review v2 directly when I send it because it will contain
> significant changes from v1. v1 is not worth reviewing at this point.
>
> To give you a high level description:
>
> All hooks continue to run sequentially (serialized) by default, just
> like before.
>
> To run some of the hooks in parallel, I had to introduce an extension,
> because we need to break backwards compatibility by combining stdout and
> stderr and piping them through run-command's muxer, detached from the
> terminal. There is only 1 known hook requiring this extension (pre-push)
> but it's trivial to add more, if necessary.
>
> Patrick's idea is to leave it up to the user to decide what to
> parallelize, because the user knows if their hooks are safe or not (eg 
> if they write the same file or call the same program), or if it's ok the
> enable the extension or not.
>
> Some hooks are known never to be safe to parallelize, in that case git
> will always enforce serial execution.
>
> Please wait for v2 of that series, it's my top priority to get it out,
> Adrian
>
> 1:
> https://lore.kernel.org/git/20260204173328.1601807-1-adrian.ratiu@collabora.com/n

Hi again Brian,

v2 of the parallel series is out if you want to review it:

https://lore.kernel.org/git/20260222002904.1879356-1-adrian.ratiu@collabora.com/T/#u

P.S. I think your spam filter is blocking all my e-mails? I get this
reply from you:

 sandals@crustytoothpaste.net, ERROR CODE :554 - 5.7.1
 <sender4-op-o12.zoho.com[136.143.188.12]>: Client host rejected:
 CONN:SPAM

   Original-Recipient: rfc822; sandals@crustytoothpaste.net
   Final-Recipient: rfc822; sandals@crustytoothpaste.net
   Status: 554
   Action: failed
   Last-Attempt-Date: 22 Feb 2026 00:30:10 GMT
   Diagnostic-Code: 5.7.1 <sender4-op-o12.zoho.com[136.143.188.12]>: Client host rejected: CONN:SPAM
   Remote-MTA: dns; complex.crustytoothpaste.net
