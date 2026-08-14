Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3841A5B8C
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688723; cv=none; b=p/mTBlcVB7Pg2vvkDFxjKslfwLw2x0/7NNLZIuZsJUKI1ydJ3S94+1PV1jhT/XLwj/djmo+zQDruEjNamIvk4IGQByCeIGB8sUGe0NRft0vKa//8W4UxO3zMTIuK2JkoL+flu7Re+3rTNOa4xUz5IS9W92ioQXrpAgJrWhDqboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688723; c=relaxed/simple;
	bh=5D/AIER8gspkXXPToMuvj66vjCiHIoDjNeDj/5026HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anHsUMepV/HohAib+B9XWyGDpAUpPOEx7nO7MOHv67T+5P1H15z/OsLDves5EZ4sJKz1jl8u0XfD5fG63orMYRfNo0JSGifn0IZu3WbVYAcDutvRu9fYmY5FuqOE3nLVd/R2UIeIV8GiMkWjTWNozAg06pqtSk4fYw4bBXBFKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDdKvFzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDdKvFzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5631F000E9;
	Fri, 14 Aug 2026 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786688722;
	bh=JGgJaL1p2w0vgiUQVM6Aww7KI7Fu6wdqodHSi82XjxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IDdKvFzikeRF0HfuqC3Pe7SxmMHa0pZVOjL45mJoa/9xpHgXyb6chBEp52X0/RVtV
	 9RCY3DNWolvPgFYvgwpBp24kH5EHMbnTrwZKtamDS6Z9YqbobuhBKhAbttU22uBzV9
	 0S7hzUwVsp0URNPxQc2kXiHtE6yXLx6sX/lixnC5C4EC/r8wcLyZ1lqdwqQkCUMA/f
	 siNG+s+0qnrUfcZt1tFbo5QrjZ07nNpxKrpA/v09QjVH7jsjUPTAe5xv2XWYT01nIw
	 k75bIB5WLtTAQc35zZFrN37FPyxyo4FaipGOpV/dmti4FQC00mrai3YJiIknp43jiB
	 ZP6GZc7Z8NSzA==
Message-ID: <3d0e8944-c17b-4665-88e0-2f955d52e8e9@kernel.org>
Date: Fri, 14 Aug 2026 08:25:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] completion: add support for 'git history'
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
 <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
 <bd3707a8-70ad-4308-bc93-5aad84e028d6@app.fastmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <bd3707a8-70ad-4308-bc93-5aad84e028d6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2026 at 22:30, Kristoffer Haugsbakk wrote:
> On Thu, Aug 13, 2026, at 21:05, Vincent Mailhol wrote:
>> This series adds Bash completion for the subcommands of "git history"
>> and their options.
>>
>> Patch #1 adds the basic subcommand and options completion. Patch #2 and
>>
>> options. Finally, Patch #4 adds completion for pathspecs accepted by
>> "split".
> 
> It looks like one line was accidentally deleted/blanked. But I think 
> it would say the same thing as on v2:
> 
> ---
> Patch #1 adds the basic subcommand and options completion. Patch #2
> and #3 take care of the value of the --empty and --update-refs options.
> Finally, Patch #4 adds completion for pathspecs accepted by "split".
> ---
> 
> Was the paragraph reflowed with 
> "#3" at the start and treated like
> a comment line?

Exactly.

This is the cover letter as I intended to send it:

  completion: add support for 'git history'
  
  This series adds Bash completion for the subcommands of "git history"
  and their options.
  
  Patch #1 adds the basic subcommand and options completion. Patch #2 and
  #3 take care of, respectively, the value of the --empty and --update-refs
  options. Finally, Patch #4 adds completion for pathspecs accepted by
  "split".
  
  For each of the completions, add a set of relevant test cases.

As you guessed, b4 removed the line starting with #3. I didn't see this
coming. From now on, I will stop using # in the description.

Should I send a v4 with the fixed cover letter, or is it OK as-is?


Yours sincerely,
Vincent Mailhol

