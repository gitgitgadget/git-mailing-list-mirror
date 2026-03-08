Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47687288B1
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004135; cv=none; b=hyJvEOSpJEh1idhMmwQmYUMAWirTNQm0Jihh6Ltz9z6xOkSFmgrV0AiKnTqgHvgpVK7uJK7O03UpZXu5U6w6/Vd+jdhudFPbxV3dQRVNV8ux6oJl1JhZF5gY235HucZCjg1JmEhJ62cZ1jI3U3sLLp4oVwzXibqtT6Wqk8KhkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004135; c=relaxed/simple;
	bh=xDzdSCZ0fzqVeTpCLR6NOtDWjlLLqz/lMP4gXKLDiyE=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=Vt5txaXiRb9+aoio9UHZ2qAnzC5i+8Wz009KKjEZw7dazcvBzxsidgFi4161AsqCR7NadK1X4tFs2lAZlwV6bdnKdlQBTMRvtDAMAFIIviXPMrA+aVpT61BJoZol/NLcZgF9myQ4kfnyN/Vxuyp8Kc52xXzQei3kiuI0g6vfJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=JKdyeyII; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="JKdyeyII"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fTXn66l0Rz448W;
	Sun,  8 Mar 2026 22:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1773004122; bh=xDzdSCZ0fzqVeTpCLR6NOtDWjlLLqz/lMP4gXKLDiyE=;
	h=Date:Subject:References:From:Cc:To:In-Reply-To:From;
	b=JKdyeyIID4QmLYv2KEMtIkpUFd/mz/ubuVjKR1H25pe1uGj9ise8r4nHLebPYlFf8
	 XJyaZJENRjYWrk85fhw/ZcfwJM5evsF/ba0jnJpc+l5rLJb+u98Fvc2fbed0fqx1F5
	 W0nFGJvNWXUtjaY+wF4Gv2asilnOyZ+FbmL47Mwcw7hUcBua1QDL13YxNj0rSX8Bwc
	 A2gLlI7zSuecrBFD+FVYvAtCzgvJopFfavYXJmAQsW/djbgltq/zwUSFkiXlt69uVI
	 lg666Pc43nNJp4PbgxgiqjCJZKLDdfHVbPGLw/+G6hnzw5x8CPyD072kApMIB4hqu5
	 rPBRuAVexGpew==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fTXn661vrz448T;
	Sun,  8 Mar 2026 22:08:42 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fTXn63YDbz8svC;
	Sun,  8 Mar 2026 22:08:42 +0100 (CET)
Received: from [IPV6:2a02:3102:8e00:2a0:8ecc:2276:9230:1c82] (dynamic-2a02-3102-8e00-02a0-8ecc-2276-9230-1c82.310.pool.telefonica.de [IPv6:2a02:3102:8e00:2a0:8ecc:2276:9230:1c82])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id DCAF11001C1;
	Sun,  8 Mar 2026 22:08:41 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2a02:3102:8e00:2a0:8ecc:2276:9230:1c82) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2a02:3102:8e00:2a0:8ecc:2276:9230:1c82]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <0ebf757b-eab5-424a-a58b-e654b1a2942e@rd10.de>
Date: Sun, 8 Mar 2026 22:08:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-fetch takes forever on a slow network link. Can parallel mode
 help?
References: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
 <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
 <1d6a8eec-20b3-4d6e-83f1-d18b7a3c0145@rd10.de>
 <aazUlMBj_IK41Ss2@fruit.crustytoothpaste.net>
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: en-GB
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <aazUlMBj_IK41Ss2@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177300412208.1859243.2037433060864120031@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: DCAF11001C1
X-NC-CID: 4tD3ZBAKF8pRUfcyDn8rNVmUE7h068BClE8CTOGM

Hi again:

>> The log talks about "upload pack", but I gather this is actually a download operation. It wouldn't be the first confusing item in Git. Or have I got it wrong?
> 
> upload-pack refers to what's happening on the server.  If you contact a
> Git server over something like HTTPS or SSH, then it will use
> git-upload-pack to send data to you (a fetch or clone from your
> perspective) or git-receive-pack to receive data from you (a push from
> your perspective).
> 
> When you perform a local fetch, upload-pack is spawned in the remote
> repository to serve data.

My client computer has an SMB/CIFS connection to the remote file server. That means the client has mounted the file share with "mount.cifs", so in this scenario nothing is happening on the server, as the connection is not HTTPS or SSH. No process will be spawned on the remote server.

That is the reason why I am getting confused. From my point of view, my client computer is not "uploading" anything when doing a "git pull".

But I guess Git is designed for all scenarios and will probably not use the correct terminology in my case.

In case it helps, I am using Git version 2.53.0.


>> I added "export GIT_TRACE_PACKET=true", and then I got a more useful breakdown:
>>
>> This takes around 13 seconds:
>>
>>    pkt-line.c:85           packet:  upload-pack< 0000
> 
> Is it just that line that takes 13 seconds or is the listing of
> references altogether that takes 13 seconds?  That particular line
> should not take 13 seconds because it's literally just writing and
> flushing 4 bytes.
> 
> It would be helpful if you can to include the entire trace output so we
> can see and analyze it ourselves.  It's very hard to analyze data from
> the different sections in isolation if one is not intimately familiar
> with the protocol.

The log does not really say which operation is taking how long. It does not say when the listing of references starts or finishes, which files it is reading and how many bytes it is reading from each file, or whether the files are read sequentially or in parallel.

Thanks for your feedback. I know it is hard to help without the whole log, but I would have to ask for permission to upload a log with file paths, hashes and tag names. Or clean them all manually.


>> 7 seconds are spent with "upload-pack" and "fetch" operations, mainly for single "refs/tags". I'll check whether that improves after the next "git gc" on the server.
> 
> Okay, this is helpful.  You probably have the `peel` capability, which
> means that when you have a tag, you get a line like this:
> 
>      4a76996b9c60ca3f21e644d78e1e5089a06c6fb3 refs/tags/v0.1.0 peeled:b4c993704e90881bec9c217749be813c70ae2bb6

Yes, that is the case.


> That `peeled` directive tells us what object the tag points to, but it
> means that the tag object has to be opened and read, which makes things
> much more expensive.  Unfortunately, there's no way to turn that
> capability off, since Git doesn't usually have capability control
> options for the protocol.

OK, but there is no protocol here, Git is accessing the files over the mount.


> _However_, if you pack references with `git pack-refs` or you use
> [...]

OK, I'll try with "git gc" on the remote server the next time I can.


> Git is already downloading them as efficiently as possible.  The
> protocol has both sides advertise the references (branches, tags, etc.)
> that they have and then, in a fetch or clone, the client sends a list of
> what it has and what it wants, and the two sides negotiate to come to an
> agreement on what needs to be sent.  This shared understanding includes
> _all_ of the objects necessary for everything the client wants but
> doesn't have, and then those are all sent as part of one pack.
> 
> Parallelization would not help here because the limiting factor is the
> speed of the connection (and in your case, literally the speed of
> reading data off the file system).
> [...]

I don't think that is the case. Git is accessing the remote repository over a mount (a file share), so there is no protocol or negotiation, although I am guessing it is happening virtually with the current Git implementation.

If I understand it correctly, without "packed references", Git will have to access a number of small files on the remote server. Even with packet references, there will probably still be a few small files to access, in addition to some biggish packed references file.

In the past, on rotational hard disks, issuing many such read requests in parallel wasn't beneficial to performance, because of the disk head seek times. That is, jumping around would thrash the disk instead of increasing performance.

But that is not true anymore with SSDs, and especially with file mounts over a network connection with a high latency. In that scenario, issuing parallel requests (with multiple threads or async I/O) should actually increase performance.

Is my reasoning correct?


Another question: Would it help if I only fetched the 'master' branch? Something like "git fetch origin master". Most of the time, I am only interested in the main branch.

I am guessing that "git fetch" will download all other branches by default, because of this:

[remote "origin"]
fetch = +refs/heads/*:refs/remotes/origin/*

I read the "git fetch" documentation, but I didn't understand whether it will fetch by default everything or just the current branch.

Thanks again,
  rdiez
