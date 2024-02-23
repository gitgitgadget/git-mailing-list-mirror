Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147114DFE9
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727077; cv=none; b=ky3o/+BxNccAge3ln62mAxlFt2zgit41Ja7sKrDc3zARSTDXP0sr3Dk9qnuTvaX6/L/dmQLdPSBf/KCFSlYo3FSlIX93GkxXmhhJI+KcVlUwA2TFCa5y+AF4fwhNnfmoPquio0W6ul189F+reL0x0NM+h61JYh/DCGW/JwrT39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727077; c=relaxed/simple;
	bh=cgd08eK2rhHq+x+lCd50gpWOwjKHEw73QjIGfU5FtEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFgwjP4HMtBCtsHP1WpEEDEeXU7OfF3BwoXqBaENLOeYZ3oqY0OPiws1sbOGteoNddPqUmK7EgWs75RQCKCNHyOhil0sov9GtfsbVNmspyIgotBz5JUhxXgvgFOgENq9buMZq1XG0fP6PuM1P8oCERpbMAWTHw2f/yJ/3AeGshI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmZ0bRRB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmZ0bRRB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so5726015ad.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 14:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708727075; x=1709331875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KkiD9Mz8GYeFpFoQNxxQbFrm1racajnIN7QIvJ+clU=;
        b=CmZ0bRRB6eWuUMTN8060Wy0ix/a+tWKcHMHpBqdEPM0dcugSSJ2sKRXkOraOHEIOgy
         fi0Z/eJ3KhIytQZ9VE8UhhDHoWns8ErXCn60hTI2oEa6/FRJU9YBu+d4VYXIiZdAuTVV
         +aZ/fbl6fYjG1BiMRgQbkGEBkCrHKDkg1ru0k1VKyZa22nvf4/nUkyTzNKK1S1OVjs+G
         4nErFI2s5Xw5XL+NMANCkL3tltZtXs1jP7jtqG+GmnCmmHruRXbhPhZUUO7vdehrSHeJ
         XFFOvxYJJHYT6L0L09yzdrZqfkfLETLdIoDUgZJyntOG2uRg+0MbaCkAspTvBQ+OWzLr
         /QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727075; x=1709331875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KkiD9Mz8GYeFpFoQNxxQbFrm1racajnIN7QIvJ+clU=;
        b=YTfquBuT5v/QrziqRjgjcoQpjF+NA9J15kJkRkUGMorg0BARIFvMdcQC8lRQrZxHhN
         JZi4hbsk5/j1CLx8Wq0IE0cO8BKsCXZMWSpKXB8NIqEYB4ruvzmpxJ+pv6tOwfWXEHZa
         i3ab7jNTsOmcGZw0a7E5pij2KeoSWHA/YqFJyTGH/FOhxRDP1zB+o9weU5Sg+UTzltZn
         QuSRX+8Z5TIav5y2HX230LHn5QQKVOK1kUo7+TbCZ163ZKAddwd9TMdGSbQusTLOSt+a
         cupVVzwA5PdGT0s+YsTc5Ca/SXSavzeSqe2XSzlgtE0hTaVoQCFscmtJun3lowhSE9cU
         saxg==
X-Gm-Message-State: AOJu0YwFBNDTGbY/Ayk9wOV8Jpsjndftb75cR0agRyfbYPNP3W8tHmJ2
	PsdhMXKpyvUNNIedhwRU4F2PczXkaWQRC7l+NfiKw/EPDEKxSRCU0fovYYS5Jmw=
X-Google-Smtp-Source: AGHT+IE6RoIQQEOklRo7bvABmjW5xt3I22ItjULR1k+MV/V3L7PwwRsnWH2oc7UhPN+S499Xy4dusA==
X-Received: by 2002:a17:902:e751:b0:1dc:693b:4083 with SMTP id p17-20020a170902e75100b001dc693b4083mr1265210plf.20.1708727074800;
        Fri, 23 Feb 2024 14:24:34 -0800 (PST)
Received: from [192.168.1.205] (216-71-219-11.dyn.novuscom.net. [216.71.219.11])
        by smtp.gmail.com with ESMTPSA id b13-20020a63eb4d000000b005dc9439c56bsm12591793pgk.13.2024.02.23.14.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:24:34 -0800 (PST)
Message-ID: <4dfca119-3210-4574-998b-0bee53e61464@gmail.com>
Date: Fri, 23 Feb 2024 14:24:33 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add unix domain socket support to HTTP transport
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Leslie Cheng via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Wong <e@80x24.org>, Leslie Cheng <leslie@lc.fyi>
References: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
 <pull.1681.v2.git.git.1708653536115.gitgitgadget@gmail.com>
 <xmqqzfvrzic9.fsf@gitster.g> <xmqq5xyfyyn0.fsf@gitster.g>
From: Leslie Cheng <leslie.cheng5@gmail.com>
In-Reply-To: <xmqq5xyfyyn0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-23 12:37 a.m., Junio C Hamano wrote:
> How about following that convention, perhaps like:
>
>     In some corporate environments, the proxy server listens to a
>     local unix domain socket for requests, instead of listening to a
>     network port.  Even though we have http.proxy (and more
>     destination specific http.<url>.proxy) configuration variables
>     to specify the network address/port of a proxy, that would not
>     help if your proxy does not listen to the network.
>
>     Introduce an `http.unixSocket` (and `http.<url>.unixSocket`)
>     configuration variables that specify the path to a unix domain
>     socket for such a proxy.  Recent versions of libcURL library
>     added CURLOPT_UNIX_SOCKET_PATH to support "curl --unix-socket
>     <path>"---use the same mechanism to implement it.

This is excellent, thanks for the guidance (and all the other
suggestions prior)! I'll update in the next patch.


> Unlike NO_UNIX_SOCKETS, GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH is
> entirely internal to your implementation and not surfaced to neither
> the end-users or the binary packagers.  Because of that, I suspect
> that any description that has to use that name probably falls on the
> other side of "too much implementation details" to be useful to help
> future developers..

That's reasonable, I figured it would fit as a cover letter detail but I
agree it's not relevant as a commit message that lives in the history of
the project. I'll also update this in the next patch.


> Talking about precedence between this and http.proxy is good thing,
> but one very important piece of information is missing.  What value
> does it take?
>
> 	The absolute path of a unix-domain socket to pass the HTTP
> 	traffic over, instead of using the network.
>
> or something, perhaps?

I like that wording, I'll update in the next patch.


> It might make the code easier to follow if you did:
>
> 	#if !defined(NO_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
> 	#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH)
>         #define USE_CURLOPT_UNIX_SOCKET_PATH
> 	#endif
> 	#endif
>
> The points are
>
>  (1) the users can decline to use CURLOPT_UNIX_SOCKET_PATH while
>      still using unix domain socket for other purposes, and
>
>  (2) you do not have to care if you HAVE it or not most of time;
>      what matters more often is if the user told you to USE it.
>
> Hmm?

Do you think this functionality is worth adding another macro to
conditionally include it in the build? It felt out-of-the-way enough
that we could just use the same `NO_UNIX_SOCKETS` macro to control for
environments that don't support unix domain sockets.


>> +#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH) &&
!defined(NO_UNIX_SOCKETS)
>> +static const char *curl_unix_socket_path;
>> +#endif
>
> The guard here would become "#ifdef USE_CURLOPT_UNIX_SOCKET_PATH" if
> we wanted this to be conditional, but I think it is easier to make
> the variable unconditionally available; see below.

Agreed in general, I was looking to other patterns for conditional
variables in file, e.g.
https://github.com/git/git/blob/3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0/http.c#L66-L68

But, revisiting, this looks like an exception rather than the norm.


> In general, it is inadvisable to issue a warning in the codepath
> that parses configuration variables, as the values we read may not
> be necessarily used.  We could instead accept the given path into a
> variable unconditionally, and complain only before it gets used,
> near the call to curl_easy_setopt().

Similar to above, I followed what was already done for certain
configuration variables (e.g.
https://github.com/git/git/blob/3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0/http.c#L485-L501),
but I agree with your feedback since this would result in constant warnings.


To summarize, I'll do the following in the next patch:
 - change the wording of the commit message
 - move the conditional variables and parsing to a check at
`curl_easy_setopt()` time

I'm still undecided on whether I should introduce another macro
specifically for this functionality, and I'd like to hear your thoughts
on why it might make sense.

