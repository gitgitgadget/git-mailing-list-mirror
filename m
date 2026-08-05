Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E805472F65
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937360; cv=none; b=d4wcfXawA4Y8nmYMurh+aTOPB0mASRPNYxFjYMT74xW3CEAXMx0yHZ4sCN5+jfm5tubf/gF9zM6viFUniANJzZDJ5/kBeGz3o8YEVzq6xxU3n/04SfYpgmDwr73KietJdAPeeS65ihVXEDO3hDODdwAljd60Y6FLt2JafUqJOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937360; c=relaxed/simple;
	bh=CU+IlZc9lTVfDvy1U40z+CSa6Fh8zTAy2nC1c4Pe0Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q518uJtxSm3mZnQotEEfpC00IqUQo7x0bqp2Hkg8VY4gQx2cwRgVl7G5gmgQurVXeCubMgoCT2gVCH41ifMMBZGUpWQPC0VkDtfRT26+ZnjxOD+uj0ZM3/q21sTvpjYmY9vY1Z20+RAUIa/rAu8MlrFyFTr0CWTHgQ7Cvfhv1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQgwNml6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQgwNml6"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1f5208b38dso188121166b.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785937357; x=1786542157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFO14/BnGN5pusJZZAhw0mEtu6uEZDcXlpBvEP3fazM=;
        b=qQgwNml64D83w0KErK7GNaEb4aS40lb3/m/yokdXYW/qc+Meo3hKw/pCtG88SbugbR
         DM4/sHr1EIq3ZVoPqV75Nf1GrarYOwkGsVuoSckzed6IXyrg4+xgJwq6X4VQPjmKg1nB
         sW7h8Z89rehlQGAMk3jTe0UqpmaE5ZD6XcSRFEFQ5Z6LjHnc/c9nYYsYRB0cSGBbcLhb
         l9fDTbnC34ggpmiG6GA/Voq08jTbWHx/NWNPXxpzFJsLCK9LLPLDIkKztPGLT4AYAzv+
         7msvWb9VzXXix0weJmhUY1H5fZV8kqKqzNqxj7WpCvCm9eQfVE4DdjS9YRLoThcxXx/8
         J32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785937357; x=1786542157;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFO14/BnGN5pusJZZAhw0mEtu6uEZDcXlpBvEP3fazM=;
        b=Tl1z3P/7QWcLuOZkZitqAemlq/DpRs5lEWKte9XA2H1VDblOj5cpaV8Yq2tRst2cn5
         3yOGJhU0Y42ZINURsHaTZ0PTyv6QFu+ZgN3sux04auvHYItVKalAt+bnA3o92a3EmNGP
         CkyQoZfKvhFX2RXVVBe7oa+7WJ6pvGx62ZDcazDqYtsbiw3MY9uOtgp+EN0XE7uwomiI
         iPrbEnvma/0ri+uU+8LoPGstI2TYq+2rFfqp4xLZHHPehXFTOCB2ifQQk0QLcxhRoFWZ
         KIe66M0unfOkJtg7jSefEAA2upQvGGPcJRE+uXW+C8RXrAU2Lsd/fQwghwLE5hLY4tE+
         4v8A==
X-Forwarded-Encrypted: i=1; AHgh+Rq2sWLg8JCtvuw1e8qVEQetf3h0rwIFMwnap2TodrqzBb1Qgt8XrYgEzayGFQtkpIULsls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUtnMQZ5hTTMO1Q/CU8oqPxZp6MEwaUzvgc6q1MzWVJ+endAQ
	0ypsfljTG+WBuOcyDVPRWLd2N3kvPEbKc9wZhvhSXXCmf4dK5zD7O1WGBaQPug==
X-Gm-Gg: AR+sD129O+oxob6whPLLg2RQA7Qj4cWX4hX2zE4I7jQk0VawVDFiNlwdfr3vKrydbQR
	RRANE+DdhT7k18+nPXZqmOJbQCICZu/wQP/m4wjZwjn03J2PfLHjXeZxQ3NE01zukKX7dMCn6Wh
	bkGleeZXzulWtmxIUgC521O/xgycbl/M+lyBUSSu5irqS743a0QYUabYy/9CNOc4nbcNvsijRHj
	5jsTcMcIXwhy14xgi1aOBVee98w2L0GPIqCZrCnNPYUBsgNTiZ6v/XFGFCAQSBwjQiUp2ia/G/q
	5MqWH3IYCln0zNbdyMsUhZ850IPRD67x5oe+xcAGYnGqIEwyMiXvGL8xhj79NqKAeGhRMBtYce9
	NlZ2a+Ww7uxD9LC+7EgutKE1sfn1mDZeu6IEBAOB8cuSLYH9ZU8H5QDb/8rSGBs2VMVoBDnxvdS
	D76pzYLXKt72TfiZ0TlUUXeDonWgpLHtVa0lWTMJyq4dUPKgo2XvzXcT0HXxyaUi+QcNsSLmBf5
	LUtzJsBCM4J/bZ8rR5wuxFQGLFiTI0v9WsEUEinnwI=
X-Received: by 2002:a17:907:398c:b0:c12:b2db:873d with SMTP id a640c23a62f3a-c2039c03328mr376784166b.5.1785937356070;
        Wed, 05 Aug 2026 06:42:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c203642a663sm112441766b.51.2026.08.05.06.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 06:42:35 -0700 (PDT)
Message-ID: <307abaeb-b033-4c55-8edf-1ea765199dce@gmail.com>
Date: Wed, 5 Aug 2026 14:42:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: =?UTF-8?Q?Re=3A_BUG=3F_git_rebase_-x_=22git_commit_--amend_?=
 =?UTF-8?Q?=E2=80=A6=22_loses_notes?=
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
References: <CALnO6CDh6kbL5KH=Nt00ksZCaDbJAnjbepU_tyRTcbGekSyeMg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CDh6kbL5KH=Nt00ksZCaDbJAnjbepU_tyRTcbGekSyeMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 05/08/2026 14:13, D. Ben Knoble wrote:
> Sigh… I haven't minimized a reproduction case here yet, but maybe
> someone can tell me how I'm holding it wrong.
> 
> I have a local branch with notes in refs/notes/benknoble/commits (in
> particular, the tip commit has a note). I forgot to adjust my author
> email before creating some of these commits, and I wanted to adjust it
> to match the mailmap patch I just sent out, so I ran
> 
>      git rebase -x "git commit --no-verify --no-edit --amend
> --author='$(git config get user.name) <$(git config get user.email)>'"
> 
> Upon checking (much) later, I discovered the note was missing! It had
> not been rewritten. And yet:

I suspect the note was rewritten to the un-amended commit (i.e. the 
commit created by rebase before it ran the exec command). The way the 
note writing works is that as rebase picks commits it remembers the new 
object id of each commit and after all the commits have been rebased 
passes a list of "old-oid new-oid" pairs to "git notes copy". If a 
commit gets amended by an exec command then we don't record the new 
object id correctly. I have some old, half finished, patches that try to 
fix that by making "git commit --amend" update the file where rebase 
stores the list of rewritten commits. I think it worked for exec 
commands that run "git commit amend", but the effort got bogged down 
trying to improve the way we handle commits that are edited. I've just 
pushed them to [1] if anyone is interested (though the commit messages 
are dreadful so I don't know how much help the patches will be).

Thanks

Phillip

[1] https://github.com/phillipwood/git/commits/wip/rebase-update-rewritten

>      git config get --all --regexp --show-names --show-scope notes | column -t
>      global  format.notes      true
>      global  notes.rewriteref  refs/notes/commits
>      local   core.notesref     refs/notes/benknoble/commits
>      local   notes.rewriteref  refs/notes/benknoble/commits
>      local   notes.displayref  refs/notes/origin/amlog
> 
> So I would have expected the notes to get rewritten?
> 
> - Running "git commit … --amend …" (author change and all) rewrites the notes
> - Running "git rebase -x echo" rewrites the notes (well, it has
> nothing to do right now, so it doesn't modify anything; however, I'm
> 99.9% convinced that when I did a plain rebase earlier today the notes
> were preserved, just like they are all the time)
> 
> It's just the combination that loses them :/
> 

