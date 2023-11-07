Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138FA49
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="e/xSeJB3"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623B11C
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 18:48:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b44befac59so4729795b3a.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 18:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699325311; x=1699930111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L3LqB2T2xWtbbmMh3/+7uHkiJJ8ol0+OV90dYs5AG9o=;
        b=e/xSeJB3M7J/QmJjW3VoJqOXeOCGLX3irt+DYKK1TUMFem7j5M6pU1VEx0kGb7VMM5
         zhu0sJrwObYqF5E+wBPTquf8VrWeWsKIHu94tXsv6gQZswTqGKb/B+MINxq/PQGSVX3p
         BHUb2jbDxHbLt8oMAZHT+DY8E+Dsfwb5IeSJoDt3PSxDCn3ZW5yzuGe1zYGhKRvaxaoF
         r6ZOE1h+aS49Tfx/RLKCHzWGzFiK8jT8pzGCEOVjU4lUV26Ji85LKZ3X++NFl0rzgTJi
         mXNyIChJ87DxWZDqHBcRbhIpuTjIzTyAxJK0P3OJKGmwvPlHCFDx3h3w+Z9yQPWf4RqK
         s54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699325311; x=1699930111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3LqB2T2xWtbbmMh3/+7uHkiJJ8ol0+OV90dYs5AG9o=;
        b=iGtff1PIt5DClkBuRpAJmPGIGW1YtPI4Mfjtr8/jObqmrQAXKZ9ZkhB6we95k9QPEB
         fiM29Su1MtPGu19x1tXcuZWZnJjA4+mDthvitx+bho7I9afnYGdZ5qHc6f3hXclVQ5+E
         qNSmd4n0eSpncY+CLwvXK3efzfL6yggOF19TFbFI6WovReSYD+inzIBkXiKNqdMXN5+U
         osJlOiGy+vSAcrN9BoPOd6JMgs3MoJSupjEoo3Pwls3NOlhWQculk+nP5V7CVZzrUsuh
         IILHRca22wtpf3vGicMSpnFfXPu1tlLZRCFJfMbeEwPIEVflVkhOO+jMCJCKgbeQnrw+
         /hHA==
X-Gm-Message-State: AOJu0Yyox++vZM921M7BZjjoIrUdM+oU7F5SZgTWYh4cJYaVD1S7zDp0
	pRx7HNxuM7yz/KBDlwQ1ow91
X-Google-Smtp-Source: AGHT+IFBJHXPjRH20g1DdUr60XBQUifSeigd5Z+wACK2wbYH7QApZVdk7IOxuFqswMJD3bKYH1rbyg==
X-Received: by 2002:a05:6a20:3caa:b0:133:8784:15f7 with SMTP id b42-20020a056a203caa00b00133878415f7mr1905996pzj.14.1699325311308;
        Mon, 06 Nov 2023 18:48:31 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id t12-20020a65554c000000b00578b8fab907sm302677pgr.73.2023.11.06.18.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 18:48:30 -0800 (PST)
Message-ID: <dbcbcf0e-aeee-4bb9-9e39-e2e85194d083@github.com>
Date: Mon, 6 Nov 2023 18:48:29 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] for-each-ref optimizations & usability improvements
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <xmqqo7g69tmf.fsf@gitster.g>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqo7g69tmf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series is a bit of an informal follow-up to [1], adding some more
>> substantial optimizations and usability fixes around ref
>> filtering/formatting. Some of the changes here affect user-facing behavior,
>> some are internal-only, but they're all interdependent enough to warrant
>> putting them together in one series.
>>
>> [1]
>> https://lore.kernel.org/git/pull.1594.v2.git.1696888736.gitgitgadget@gmail.com/
>>
>> Patch 1 changes the behavior of the '--no-sort' option in 'for-each-ref',
>> 'tag', and 'branch'. Currently, it just removes previous sort keys and, if
>> no further keys are specified, falls back on ascending refname sort (which,
>> IMO, makes the name '--no-sort' somewhat misleading).
> 
> We can read it changes the behaviour and what the current behaviour
> is, but I presume that the untold new behaviour with --no-sort is to
> show the output in an unspecified order of implementation's
> convenience?  I think it makes quite a lot of sense if that is what
> is done.

Ah sorry, I over-edited my cover letter and accidentally removed the
explanation of what this patch does! Yes - the new behavior is that
'--no-sort' (assuming there are no subsequent --sort=<something> options)
will completely skip sorting the filtered refs. 

>>  * I'm not attached to '--full-deref' as a name - if someone has an idea for
>>    a more descriptive name, please suggest it!
> 
> Another candidate verb may be "to peel", and I have no strong
> opinion between it and "to dereference".  But I have a mild aversion
> to an abbreviation that is not strongly established.
> 

Makes sense. I got the "deref" abbreviation for 'update-ref --no-deref', but
'show-ref' has a "--dereference" option and protocol v2's "ls-refs" includes
a "peel" arg. "Dereference" is the term already used in the 'for-each-ref'
documentation, though, so if no one comes in with an especially strong
opinion on this I'll change the option to '--full-dereference'. Thanks!
