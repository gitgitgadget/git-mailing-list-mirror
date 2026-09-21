Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE31F5834
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956627; cv=none; b=bQ9+IWSx3Xhh/iyFklV8YeYuhUvSQZpugeT5X8ulVXgdTnFBvdA0dojzaUGyajzfuDZuV7A4bBgQFvkcVlyweK351E/DH5bqDc33N+2mqoYaDTf97oPGlpT5SYc7tylRhsIR1rwWO/vD0e+9goPCTwNBHNhbDg3wjAgDIssI/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956627; c=relaxed/simple;
	bh=fZWQDEmwvN4i9lvrMa8CULNTGH+IkE11nPrfLR6CnKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oob9JrnAu//PZ5Jp/4/1f8SIbyaJxV3s/1Hr6Gmnmf+5wBzmfEDaElFQP6IY6CrjpE2qmTlLxbAGNImNWdsjXR7YySaV4s3cGdKzEPNLhxoQNdijF5pUM/lFKQgJPylmcopNvvL5Xe7W/8NfAtjSHxDqgy1NcQzi1LbMJgdK5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=VefZYnAU; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="VefZYnAU"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4hp6Bg5GFLz8PbP;
	Sun, 20 Sep 2026 22:10:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=fZWQDEmwvN4i9lvrMa8CULNTGH+IkE11nPrfLR6CnKQ=; b=VefZYnAUQy4+
	xf4WLL4lQEiWXaKPLWFC71xoNCn7Kjp8umWSig/uEUHeQfO4wF5oB+GoFsf8WBq7
	nP5l3aoY0DH6quLp8FUGFeELNLxq7Oq/6AIfSsmUjSbEaae5ztTPqw8SIIy1y77a
	8TiVh/F2TlUfGa689vn6czTTnyqsPiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=LTQ
	m2v0JZyR+l6NKcddU/h4dsxjoFYIgQ6DT4bSqTZUneIRbZ9An+BVeNHgXDI2BhkX
	+pFSL9tt4xjkDhTcYrcWbFpOvu8KcnPwVzrfUlhYXvgK5teTnN6o6XcmHdQ/AJAc
	aSkgAWD9nPPKWeqwcQDCCDN2I//9ppGsNWXLp5QA=
Received: from [192.168.6.99] (173-206-113-132.cpe.distributel.net [173.206.113.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4hp6Bg4c7cz8PbN;
	Sun, 20 Sep 2026 22:10:19 -0400 (EDT)
Message-ID: <de116c51-b538-44b7-87d9-653b84a55088@comstyle.com>
Date: Sun, 20 Sep 2026 22:10:18 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on OpenBSD systems
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <aqthQ3u4eW1wHCn7@humpty.home.comstyle.com>
 <xmqqy0d0t2j9.fsf@gitster.g>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <xmqqy0d0t2j9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-17 9:45 a.m., Junio C Hamano wrote:
> Brad Smith <brad@comstyle.com> writes:
>
>> Enable Git to resolve its own binary location using getexecpath().
> That may not be incorrect information per-se, but lacks critical
> bits.  Natural initial questions that come to my mind are...
>
>      Why would one want to use getexecpath() over whatever OpenBSD
>      ports of Git have been using happily?  Is the old way being
>      removed?  Is the new way being more accurate?  In what
>      situations does the difference matter?  Is everybody on OpenBSD
>      able to use this new function?  Do only certain, and/or
>      presumably later, verions of OpenBSD have it?  How widely is it
>      available?  How long has it been available?

It's a long awaited API for such functionality on OpenBSD. Otherwise there
hasn't really been a means of doing so and one which has been using happily.
The proper API I would say is one which works and is more accurate. One
which works the same everywhere where as the pile of hacks has different
results and not happily either.

The API is new. The config.mak.uname check looks for 8.0 and newer.


> Your proposed commit log messages do not answer any of these
> questions, but it should.  The title can also use a bit of tweak to
> identify which versions of OpenBSD this patch is relevant.
>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   Makefile         |  7 +++++++
>>   config.mak.uname |  3 +++
>>   exec-cmd.c       | 24 ++++++++++++++++++++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index d4b775953d..9e3d37b5b4 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -378,6 +378,9 @@ include shared.mak
>>   # Perl scripts to use a modified entry point header allowing them to resolve
>>   # support files at runtime.
>>   #
>> +# When using RUNTIME_PREFIX, define HAVE_GETEXECPATH if your platform supports
>> +# the getexecpath() function.
>> +#
>>   # When using RUNTIME_PREFIX, define HAVE_BSD_KERN_PROC_SYSCTL if your platform
>>   # supports the KERN_PROC BSD sysctl function.
>>   #
>> @@ -2356,6 +2359,10 @@ endif
>>   
>>   ifdef RUNTIME_PREFIX
>>   
>> +        ifdef HAVE_GETEXECPATH
>> +		BASIC_CFLAGS += -DHAVE_GETEXECPATH
>> +        endif
>> +
>>           ifdef HAVE_BSD_KERN_PROC_SYSCTL
>>   		BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
>>           endif
>> diff --git a/config.mak.uname b/config.mak.uname
>> index e28870434d..270aff1772 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -343,6 +343,9 @@ ifeq ($(uname_S),OpenBSD)
>>   	CSPRNG_METHOD = arc4random
>>   	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>>   	FILENO_IS_A_MACRO = UnfortunatelyYes
>> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 8 && echo 1),1)
>> +		HAVE_GETEXECPATH = YesPlease
>> +	endif
>>   endif
>>   ifeq ($(uname_S),MirBSD)
>>   	NO_STRCASESTR = YesPlease
>> diff --git a/exec-cmd.c b/exec-cmd.c
>> index 507e67d528..5251da4229 100644
>> --- a/exec-cmd.c
>> +++ b/exec-cmd.c
>> @@ -129,6 +129,26 @@ static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
>>   }
>>   #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
>>   
>> +#ifdef HAVE_GETEXECPATH
>> +/*
>> + * Resolves the executable path using getexecpath(3).
>> + *
>> + * Returns 0 on success, -1 on failure.
>> + */
>> +static int git_get_exec_path_getexecpath(struct strbuf *buf)
>> +{
>> +	char path[PATH_MAX];
>> +	if (getexecpath(path, sizeof(path)) == 0) {
>> +		trace_printf(
>> +			"trace: resolved executable path from getexecpath: %s\n",
>> +			path);
>> +		strbuf_addstr(buf, path);
>> +		return 0;
>> +	}
>> +	return -1;
>> +}
>> +#endif /* HAVE_GETEXECPATH */
>> +
>>   #ifdef HAVE_NS_GET_EXECUTABLE_PATH
>>   /*
>>    * Resolves the executable path by querying Darwin application stack.
>> @@ -209,6 +229,10 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
>>   	 * after the first successful method.
>>   	 */
>>   	if (
>> +#ifdef HAVE_GETEXECPATH
>> +		git_get_exec_path_getexecpath(buf) &&
>> +#endif /* HAVE_GETEXECPATH */
>> +
>>   #ifdef HAVE_BSD_KERN_PROC_SYSCTL
>>   		git_get_exec_path_bsd_sysctl(buf) &&
>>   #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
