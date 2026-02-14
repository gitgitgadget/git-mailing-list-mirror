Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F31E5B63
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060971; cv=none; b=QMit0Xu3wtbg3IlHomX4kGRQMainJIbcE/23mzfhhjcJlJn9JS4dbag8+Zo40i+Ndd4egYGQZ1RJk3fL9frLcfKb3ImGyxK5WaglNd41oeg2ERPjOe+ajG/27F5DiWjAhIBkPlEuYK04pEfU6zrzD76fLaLkTe3vQDf7n9sqIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060971; c=relaxed/simple;
	bh=hQnTEAvqyZShFPRmEbQ0K4J+M3ej9ebIK4kgZZd7J98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qb9+qxtoAafFQACoC3BGi0GeUL9b1hfhRfbFaULo9k+wRuXk1G3S9++l1ckUvdTJQmblFzUKcVAX2TwKOz6P0YqghPtLNyvZ+aHzACO7h8AYIi/3bwsK6QM0qbrQzwsGx2ML+M5yMUcIGd2vm3UPfTXY2AJQm8tlN4J6UJRo+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=jlclQS3O; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=7EO4J/Wz; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="jlclQS3O";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="7EO4J/Wz"
Message-ID: <e2a5c920-7f15-4ea8-9390-cf42ac33082d@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1771060966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ekFlZr3TA9mCBxVCA0v+8n7jWNiQWAYY6scSaIjH28=;
	b=jlclQS3OdWjomXLjIr2ZH3wR54Pfa6mynUCkWzIPTzsma+AKIGqUK1FMiJGDTNJsRPYSyO
	167mc/XQJoIWAeN88PVvd3n3QqQ25atRVW3kLFlP5cTLJptjhLHwUvHMDwKcUeCP+Fmnl1
	znK70wJC/xV9Gkn2rq9jAZErnhSlCwvVR6oGL7+VfysLZL/uwBqpANO4aGqbax7MwbOIP5
	i0QxX0ptMt01vXAFVfzrOUKYIfvPAuk/qkLmjg7NBGS73rRDAP0j31AdnmN6OYsIT0K3+O
	ecpemNXvnip3PmU9Q+6W0T/vhr1lGQ4f7rRQLLjlbd4/XwuZEfkxUxeX/GRJLYHN8WAJ4o
	2GHJjoH779UHR5VzTNKjjjXM7FNq39i92Qt3w4CnkTzaHAEt5QZsSfvtPv+jq5lE+PTeZL
	Qf3lue3pNkkRTavYahBofzXIHenvOsarvta1dlcQ86oQ3V9mXTUwUGVGNnYzYUhx7Ef9PH
	DMR+/kZAOSqovJi6eUWnzzJt7H1Zkt4lZmyTqnBJbcVjwyM1uU75eS1Nei94tGyBZgOirG
	FdilAZaN6vb5Y6VDaRUZsT5DogZiNCxxrIWZDEY/hAN3Bg2pDwVhmVAW1elhw4mvTc2Bkh
	3S8L6C3MGjx1XoON3O7oekAbJA+AKw//P7XT5toh13bLQYyHMYWnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1771060966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ekFlZr3TA9mCBxVCA0v+8n7jWNiQWAYY6scSaIjH28=;
	b=7EO4J/WzyHvYje+BFgIq46OO3iLObPZpU6uW2r0Bp3lFMaaSbelY9yEh+yCzbieSNCDue1
	z2tKGN4m++89rPCQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=integral smtp.mailfrom=integral@archlinux.org
Date: Sat, 14 Feb 2026 17:21:59 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on
 Linux
To: Chris Torek <chris.torek@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260213124656.218396-1-integral@archlinux.org>
 <CAPx1GvfsnZiUkkXJSAtt4HECT6f+zb1+vtiT+UikcAq0WuFR8Q@mail.gmail.com>
Content-Language: en-US
From: George Hu <integral@archlinux.org>
In-Reply-To: <CAPx1GvfsnZiUkkXJSAtt4HECT6f+zb1+vtiT+UikcAq0WuFR8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/13/26 11:36 PM, Chris Torek wrote:

> On Fri, Feb 13, 2026 at 4:47 AM George Hu <integral@archlinux.org> wrote:
>> The `sendfile()` system call copies data between one file descriptor
>> and another within the kernel, which is more efficient than the
>> combination of `read()` and `write()`.
> sendfile() is found on other systems (notably BSDs), so perhaps ...
>
>> Signed-off-by: George Hu <integral@archlinux.org>
>> ---
>>   copy.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/copy.c b/copy.c
>> index b668209b6c..d4b7cde764 100644
>> --- a/copy.c
>> +++ b/copy.c
>> @@ -7,8 +7,23 @@
>>   #include "strbuf.h"
>>   #include "abspath.h"
>>
>> +#ifdef __linux__
> ... this and the subsequent ifdef should be based on the feature,
> rather than the OS.
>
> Chris

Hello,

Although the `sendfile()` system call exists in both Linux and BSDs, 
their semantics and APIs differ.
The Linux prototype of `sendfile()` is:

ssize_t sendfile(int out_fd, int in_fd, off_t *_Nullable offset, size_t 
count);

While FreeBSD exposes:

int sendfile(int fd, int s, off_t offset, size_t nbytes, struct sf_hdtr 
*hdtr, off_t *sbytes, int flags);

George
