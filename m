Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702521;
	b=CGSs9/wuK1okzYAeyacJ2mgEQboE/w9R9YkQlkL5Pq6FzatlBad2bui76t5V2IiGrLdh
	 rCUA39sU99XzQyR/AWKfj9bvbGAZz1BWjsAfhILv9FGoQWYjh+HJx5O0qw15f+M5f2QTj
	 xAkP52JpGIsk7rk0S+1hCyVxHQIKaqqHwLH60tnYFcrl8haF/P1VcyN+EqyzOx8cj6BHc
	 lCMmeXbUNRSIYV3pXTbl3ZOEG0YHC14efMr7Daaa1IAi/frujqLyrMK4BhQEmj+z6k431
	 XKiipSmeHiQmXEUMjZqTSzzfRd9ShaIZzeV+M3JHYEdJaqs5dKXusiSSAmJnkCDQIRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702521;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=EyD9D0oCjcpzFwxqXYaAIqsw5abC1O+kX+qs0u+PCCc=;
	b=3xZ6VWhSupgzcxOMqJikKUdGZ5shl2j0UwvtKCJEWstU6nvrOo2ZA1oTVhGJsGHKbA9a
	 S4hRklJQJ8QVQbUEa7RG7EqSVObl3ym6URYAl/+fLjq1sSp/7454rtBcnrUB/aAbjvYdQ
	 cFTk1KjaquBOaPWHunPxBmn+u7F/8C/1ajUrLUKxiF56LOD+URrcai4ciUQqpXnIu6tfP
	 JZFr94ZkYzPT9voGPhp1c4LN63Hm9VFfn1tONQJjpzUroSltFb7R0oBfcwLG9PfNPhWHQ
	 z6Gj1E8QnuiIiiXgRQJ2GxYT6IrcsC9O3T5VaWd6vNwAo3QQR0NjyjI50Pb3XWgUW1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=x+H1VmAK;
	arc=none smtp.remote-ip=95.215.58.163
Received: from mta1.migadu.com (out-163.mta1.migadu.com [95.215.58.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E9606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C86E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=x+H1VmAK
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=du65nxhyipW9Ycct6hIhLt/iO7a0D4AGFToF4wtsCp8=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795702518; v=1; x=1796307318;
 b=x+H1VmAKRkk4AYa8Df36I7VzuDtHu1Yy1bedX8QXZ7hrVEn+H6/pj+4DaRp3Ib5ff6naF8IO
 ihbQ+RlkdtPf2pheaKdItJjP5of4kSg7VCO1JTUKSD06Ow6e0To2zQBjDB8AfQsiV3yJAcC/X0+
 6rQWVwPUvGV/2nC7lzm4RZRE=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 00d95735579bfdcd;
	Thu, 26 Nov 2026 14:15:18 +0000
X-Mizu-Trace-ID: 00d95735579bfdcd
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] builtin/fast-import: stop reporting packfile
 statistics
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-1-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-1-19beb83b145f@pks.im>
Date: Thu, 26 Nov 2026 15:15:12 +0100
Message-ID: <87fqwnsmq7.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> By default, git-fast-import(1) prints a bunch of statistics about all
> kinds of internal details of Git. This includes for example how many
> objects have been allocated, the number of refs processed, or the amount
> of memory that was allocated.
>
> Reporting this kind information is highly questionable, doubly so as it
> is done by default, as a user really shoudln't have to worry about such
> internal implementation details. For some of the above metrics it could
> be argued though that it's indeed interesting to learn about the number
> of objects processed to get a rough sense of what git-fast-import(1) has
> done. But for other kind of information that's not the case, as it is
> without a doubt purely internal implementation details.
>
> One of these reported implementation details is our packfile statistics.
> These include information on the system's page size, the number of packs
> that were opened, the number of calls to mmap(3) and how many pack
> windows were created. Reporting that kind of information, and that even
> by default, is just completely uncalled for. This information may be
> useful to a developer, but a user really shouldn't have to care about
> any of this.
>
> More importantly though, with pluggable object databases we shouldn't
> assume that we're using packfiles in the first place anymore. The
> current implementation of git-fast-import(1) still does, but we will
> convert it to use transactions sooner rather than later.
>
> Let's just unceremoniously drop reporting packfile information to the
> user. If anyone complains (which I highly doubt), then we may consider
> reintroducing this as trace2 data. The same is arguably true for many of
> the other reported statistics. But for now I care about the packfile
> subsystem, only, and hence those are left as-is.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-fast-import.adoc |  5 ++---
>  builtin/fast-import.c              |  4 +---
>  packfile.c                         | 36 ------------------------------------
>  packfile.h                         |  2 --
>  4 files changed, 3 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 5201e493345..6afe14b650c 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -48,9 +48,8 @@ OPTIONS
>  
>  --stats::
>  	Display some basic statistics about the objects fast-import has
> -	created, the packfiles they were stored into, and the
> -	memory used by fast-import during this run.  Showing this output
> -	is currently the default, but can be disabled with --quiet.
> +	created, and the memory used by fast-import during this run.  Showing

Tiniest of nits: No comma needed here.

-- 
Laters,
Toon
