Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E6303CB0
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747921; cv=none; b=eKm3oW8rkltSsPXt3FZzDFuQy+dobDE9LTKdALIm7lX+3RqVeIKRaDyLaV2Z4ThC9tJam+0N34EvMD5x2oxik0hqtWW5qK+XU8ET4KqUv5D2xfzzqrhyyrGzKCWeHKoRW3cRcYruI+NDmhs2NU6DGAtQQ7XEyuth1gEdqEjmsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747921; c=relaxed/simple;
	bh=epqaIYSDmnf9rA+BdQ0S3oU8DmGWtI7bQkAualXXTOA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=faydnFw11DGo9U5eG9Rp1kvfIJgBfokSK0yownxDKUyiQMSAYRRlPMrdjG+shUz1LBVe7Gl4mZ55u1juE5J4IJ6DGvib+UNOwiLy0lWohlqLl0Mcxtjlk4LmwyDBhBqZSVk+hz0jRpd3g7xTjkXtbOw9AxyLHJRJmOObe4rt1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewatntm6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewatntm6"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a18180so3620695a12.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785747918; x=1786352718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFdtDLaz62YKu7v7asx1WUzVcD/PjS3ZRRGq3DBMIiw=;
        b=Ewatntm6X+1XwmJLjcYOQZaWfncq9MjkUaW1/pRyYSaruT+BOCyw/WMKm6o8vH31v+
         dHxYcmHsPMogIatUHE9ekAEYFWFSnozxjbpMAS39FTMDQSQiYfA22Hy6a9y6e5ZQm9q4
         uJfWJUClgeFx9/X95lDld4eG/WUrDCL4BxY4rco1D7Kk6mAqn3Nvhu5buvTQUV+plGVI
         z1y/RcXmfNmT0exfiw4RmD8Xo/Zk6WwolgqTFcFNhPzTyq102AEYQeKd5O2Ap+Q7aWmc
         +R1zX55bPtcVnxVGeZ2gSn0DHvYrN/tkTumdNkIh2nAVlzoz6Y1b/B3xrtAir2PL/zK4
         4nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747918; x=1786352718;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFdtDLaz62YKu7v7asx1WUzVcD/PjS3ZRRGq3DBMIiw=;
        b=JH1gDoz6i/hfbrOvYp7BDkWUaXSS35KQ4al6QokRWfSS2j4lLXZI1TuZwQeJcHJ0lm
         xrz6GgMHd+RyLAgL8aYU328qBFhspeQxwbVD2hfmrDBb4sp5Mlzkt+t4dP6enECGy80C
         fYdQkw7CT1Mnk9LnFzCwHSjEBjKGeqGBexP9llz9wzvUOlhZuocaSJmFJFcpWrWe3zqK
         mFdo+Uc+Ls9Xmr91ettt1EFVzOtjFdmUHh2vLg1Pm+V+RJdzfNYfoJkZMcFYqNwupc2D
         DHILZ7s3pZDxZOcuYdXnaKHhF4OSyq/6mye6kFoLj17azx5NR+NSSImCB8X3suKKzViE
         9Dqg==
X-Forwarded-Encrypted: i=1; AHgh+Rpc7CSP1ab68yt5ih7nrZnZMMxTzt1WekZJnFDhgi8bwoRgnMw1miJc+QeSpmtBXA9uaJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybn12m9N7eaLYAasaGM3CovVsQt6j3iWLy+gFtLy3AOdtgYmKS
	4or1w67EJuW4Vq6Iy/S9ba+iPg2yxvQiS2VQCpNDA0SzaraHPlkbvmsQ
X-Gm-Gg: AR+sD12+jVBj+1CnTqox1CG/+yp1j9o855Qq5fjLcT2GK5vBo7+kOcTJ3wC4KLBqRP/
	vKpeQvzVzl76XaXriCcXmrdHAgLNH6rqp3WM/RqZa0hykyzu67jGqqaLI1QiLOv3UWy5NIn8kJM
	yyacTnhoEEqaqCg8lQOwd0Q8YUjpU73sWVjVsX+oTIy7p8EMJqOGb+L8AgEoqNDo9b4UwwO4Ehz
	8Txn8ijIE3mvSC8907H8b/7h9j7MOFLF20U0xlvr36bOtDw1QXEOH/BzKNC+EI3iBqpGmweZj/u
	yf9dHEYIhX4BTb9KduHqo0Ls5NfY39JoaX/cBlWTHFA9a0MGluKzhhI8OqmFQQBf5+adA8DSvnJ
	O/U394lfpAAMQZWu6OojEBzFOVtLhObr6+b4u0uHAoIzlJjzygOYCCL+TYdmdwpfRMr5qLSjdF6
	8dxOHhzKbFZkUWTj7JUu6Xh7HC+JtlU+ZJM5LuZrQzlmMDWsxv0uC11ABLpETiLYtoWgvjQZEZQ
	n5LRyCjgWJD9UYu3KCpI2ckm2OjdCHItejPGoooDvA=
X-Received: by 2002:a17:907:d85d:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c1fe81e7085mr607809366b.24.1785747917987;
        Mon, 03 Aug 2026 02:05:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3cc3b64sm491076666b.27.2026.08.03.02.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 02:05:16 -0700 (PDT)
Message-ID: <f00673cc-afc8-4a4f-a668-e22c53b46181@gmail.com>
Date: Mon, 3 Aug 2026 10:05:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: Matt Hunter <m@lfurio.us>, Harald Nordgren <haraldnordgren@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
 <CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>
 <DKCKB3HW6VJA.19CQLPOHR6WTI@lfurio.us>
Content-Language: en-US
In-Reply-To: <DKCKB3HW6VJA.19CQLPOHR6WTI@lfurio.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

On 31/07/2026 08:02, Matt Hunter wrote:
> On Thu Jul 30, 2026 at 2:11 AM EDT, Harald Nordgren wrote:
>>> Without "--reedit-message", it will happily discard "amend!" and
>>> "squash!" commit messages even though the user creating them is a strong
>>> signal that they intended to use them to reword the commit.
>>> "--reedit-message" is a rather verbose option name which does not make
>>> sense to me as we're creating a new commit with a new message so we're
>>> not re-editing anything. I've commented elsewhere that I strongly
>>> dislike reusing the rebase squash message template for this command
>>> where we can squash fixups into multiple different commits at the same
>>> time.
> 
> I also agree with these points, but given that they were already brought
> up and dismissed before, I felt it wasn't my place to try to dictate
> high-level design.

If you raise a point and it is dismissed without a convincing 
explanation then its fine to raise it again asking for more details so 
that you can understand the reason behind the decision. That often leads 
to a productive discussion and an improved design.

> I may be misunderstanding your current concern with the first sentence
> Phillip, but this was (at least in part) one of the recent things
> addressed in this feature [1] [2].  If we go with the assumption that the
> default behavior is to squash all the changes, but abandon all context
> outside that provided by the first commit, then accepting amend!
> messages for that first commit seems to drive the behavior closer to
> what you describe.

My feeling is that "amend!" and "squash!" commit messages indicate that 
the user intended to use them when they squashed so I think we should be 
a bit more careful about dropping them compared to other messages.

>> Should we always do "--reedit-message" then, i.e. remove the option
>> and have it as the default? Do we need a "--no-edit" switch then
>> instead? Maybe not, user will then always have the editor opened and
>> they can save and quit if they don't care.
> 
> A script running 'git history squash' may have a harder time with this,
> though something like 'git -c core.editor=/bin/true history squash' is
> at least _some_ workaround.

Can't the script just pass --edit/--no-edit?

> It would seem consistent with other git commands to offer both an --edit
> and --no-edit option.  If --edit is the default, it may make sense to
> offer the option anyway, for the sake of some potential future where
> there exists a config 'history.editSquashMsg' (for example).  '--edit'
> would then override a configured value of 'false'.  Of course, the
> precedent is --reedit-message so far in 'git history'.

That precedent is unfortunate, "--reedit-message" makes sense for the 
"fixup" subcommand because we are reediting an existing message but 
that's not the case with the "squash" subcommand where we're 
constructing a new message from several commits. Given how new the 
"fixup" subcommand is I'm tempted to add an "--edit" option and 
deprecate "--reedit-message".

Having thought about it a bit over the weekend I wonder if the best 
solution when squashing is to default to looking at the commits being 
squashed before deciding whether to open the editor or not and allow the 
user to override that on the commandline like "git commit". If we're 
squashing a bunch of "fixup!" and/or "amend!" commits into a single 
target then I'm not sure its worth opening the editor, but if we're 
squashing other commits together then it probably makes sense to open 
the editor so the user can check the result. I guess the danger is it 
ends up being confusing.

Thanks

Phillip

> 1: https://lore.kernel.org/git/DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us/
> 2: https://lore.kernel.org/git/pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com/

