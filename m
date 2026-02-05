Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35D1E3DED
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302744; cv=none; b=PC13//1Albo2gb4ZONCVuW8CcTVl2AP4GggWuXad427mZXUWl6NFRoGCCy/rza3L+zWC0vUtwL/SyOJsU+jsUjozZHuSnQPAzNaO91pGNbZZ5Z8tqcOOt2Q8dqqG49ctgsLs7/PYwFtxaeFSM6H5P6zu9FYavHossVWVukZgvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302744; c=relaxed/simple;
	bh=81KqhbO1/zEvJ12RT1BNwPjgBmp5eXay+M7MPSi/hKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2F2g6RBofqAQj2bXVXjQyLgSbUWLCGUW3cJBtEBO0Z8jfFTVmGEi7Hm8w2u0hmh6w14FyR4Usu+LwtPc1tGWyL+wRaUnb0BJU/D31TBs2m/65XzxRdM43Ubs8VvXrkwtHMQBEqf1t06ceky9pKkHanrTbgIOEMerYqpcOjv5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5Iqfwhy; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5Iqfwhy"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4806bf39419so12761015e9.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770302742; x=1770907542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDNdz+iUjJem9TnrPy1BDerUPf7AoUlU7mu+iOGpnNI=;
        b=W5IqfwhyLUfhkLB2xX68yy/gdd7TvU+/6JkB+UjqBUsdln/iWDUH6c9uFh7I5sqJeK
         CG2TBR9334hvu47SumUKVzmtJjgx/vEJ1/lvnwBtdU87IbOwtxM5qB1gsWahNyjckDnO
         EOCgg5Xv+TIRmTqXUsD5iYcgfNWJ81lcytPGF2w2uJ8GUzg6EtZPtSeDtE8jdXl2jZr6
         4RAD0Ll92qB9PXhx3ff14nQvd8tz5i8MtERcqHQlojWL52PwbgSzaPeXzShKQ/yG238o
         QFoJjGpVieXmmI/Wo2/7PooWMgSyRPjzSoh+POnnlyUqbiI1t6cGheVQbNyfFqEtQpNy
         JTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302742; x=1770907542;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDNdz+iUjJem9TnrPy1BDerUPf7AoUlU7mu+iOGpnNI=;
        b=IZ9werUGlV/IXimxifMj6lpUlKlqzC4IhUvf9l1+Yg6L6QLskhGfWyobpUqeK4huqa
         JyG/zzZ370hfXQgAAp0Fjri0Lt0hae/mOkhPMaRNE39DPtLN489lQ4zh6SJiMFrBbivz
         hHhxrHyJCX2SgSaU877KjOwvGWUKhRtD7+1LDbwzm6CB/R1xLTMUKsNqhp7mqSMiuVLh
         NXvdprpoRoJHizbZlQqatbef1vPrHZ1pxFmzRXoLROynhkrS/+Nbuhdk66Nt6xiGUaFE
         uXgAmVSFwIhCl69k6RRjwU9EZMQ5L+WSJ6oa7QfYe6n0TiWVh33a90D/F9wgR2nsS5cp
         0WhA==
X-Forwarded-Encrypted: i=1; AJvYcCXmzw+khZFyCzBQ3CUaPJU2HuTu5RDfdIKIjllFKzjEsVHu+Nf2pbh05E6cr5cd9B9nLas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbOQd8yb67u7qQrZtOqtTgJ6AvolauMuFh9EbBH6O8QsZvaVH
	NOJghBozdF5vT97CR9E0O2kAmaGKPnUrJyXLiEFyLlpfxo7KVwXZC1AV
X-Gm-Gg: AZuq6aJ7uxpMF6baL41E6POOC5Hyal/XEIrR8+mXivNHBQsSrmotpcMBXH9UbAQHcIg
	IUNasljkUS3O7mKdb0h+k5q2NjtoII5LuhikgFjSYr2SDm5fP120Qm8/RJu6WzOsAO4sG01QFr9
	/1KOpLrF62AY0SCm6aTPbBSIoZPHtjFgFNQqNewKP6ubKP+/BM6l3j6teC0tny3AnIoXuBuQ6Ui
	fMDCp3hZTTCPXYm3T2Hm8ZRdhT/N8UPWSmv66z0JEX6RjGnOsga1WR0APvxgMMxFW4Zhfqw7H+j
	Yi2/kOuTR3I41USPyPy7D6NAbS99/wt2dC5Aqt5EfU/Lich53OEY29UKmKQxHhCt0wP0wEAsrls
	NErIRsHGeNvRUbxEnOexWDDnHKufgF4ehAdGCYtDyxUo7DqPLs5phx1eyWRxr3mgYCsphbcPzct
	o11Ajg3j8v3Egq8vP4EBI3FhrLaKyX6V9aWe/J9rp3XyDjCuLKzUqky+EAP6zsF8nE6A==
X-Received: by 2002:a05:600c:21cc:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-48317917835mr28359305e9.9.1770302741722;
        Thu, 05 Feb 2026 06:45:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d4d030sm90566975e9.13.2026.02.05.06.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 06:45:41 -0800 (PST)
Message-ID: <55e2e1f0-da51-4413-a20b-542140004fb6@gmail.com>
Date: Thu, 5 Feb 2026 14:45:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/11] [RFC] config-batch: a new builtin for tools
 querying config
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stolee

On 04/02/2026 14:19, Derrick Stolee via GitGitGadget wrote:
> This RFC explores a new git config-batch builtin that allows tools to
> interact with Git's config data with multiple queries using a single
> process. This is an orthogonal alternative to the effort to create a stable,
> linkable config API. Both approaches have different strengths.
> 
> My main motivation is the performance of git-credential-manager on Windows
> platforms as it can call git config get dozens of times. At 150-200ms per
> execution, that adds up significantly, leading to multiple seconds just to
> load a credential that already exists. I believe that there are other
> benefits to having this interface available, but I can't recall any
> specifics at the moment.

It would be helpful to explain what the advantage of this new command is 
over using "git config --list -z" or "git config --get-regex 
'^(some|section|names)\.' -z". I've found those to be effective in 
programs that read several config keys. Elsewhere brian has mentioned 
that git-lfs does something similar and I believe git-filter-repo uses 
"git config --list -z" as well.

One potential advantage would be if this command supported specifying 
the type of the value. When using "git config --list" it is a pain to 
have to normalize boolean values and parse color descriptions into 
terminal escape codes.

Being able to set multiple keys at once would also be an advantage if 
there is a convincing use case for it.

> This RFC adds git config-batch with a protocol over stdin/stdout for
> executing multiple config queries. The implementation has a limited set of
> potential queries, but also creates a model for compatibility for tools to
> automatically adapt to different Git versions.
> 
> I'm submitting this as an RFC before I've polished all of the details
> because I want to make sure I'm going down a good direction. Please focus
> feedback in these questions:
> 
>   * Is this a worthwhile feature to add to Git?

Possibly, if there are clear benefits over "git config --list". I'm not 
sure it needs to be a separate command though - I agree with Junio that 
it would be more discoverable if this was a subcommand of "git config"

>   * Is this a reasonable protocol for stdin/stdout?

The protocol sounds quite complicated with capability queries and 
versioning. At the same time it looks like the line oriented version 
does not support keys that contain spaces, values that contain newlines 
or retrieving settings from a file whose path contains a newline. I 
think it might be better to have a single protocol variant based using 
NUL delimiters like "git merge-tree --stdin" and "git diff-pairs". Those 
commands use a simple NUL terminated protocol without the need to 
specify the length of the input.

> Each command has an associated version, in case we need to expand or alter
> the functionality in the future. This includes the potential to deprecate
> and remove certain versions that we no longer want to support, such as
> replacing set version 1 with a version 2 and making version 1 no longer
> available. I do hope that we will mostly be able to move with new command
> names, such as a set-all command including the options for git config set
> --all ... instead of increasing the version of the set command.

It's good that you're thinking about future functionality but I wonder 
if we really need to specify the version on a per command basis rather 
than as a command line option or simply adding commands like "get-v2".

> There is a -z option that changes the command interface to use
> NUL-terminated strings. Two NULs specify a command boundary, which promotes
> compatibility with a caller that sends an unknown command.

That also allows optional fields such as the file to read the config 
from or the value to match to be NUL delimited while making the end of a 
record unambiguous.

> However, this
> means that we cannot specify an empty string as a token within a command
> unless we add more data. 

Is there a need to do that? Can we require key=value pairs or possibly a 
fixed number of positional parameters if there is a chance the value 
will be empty?

> This format uses <N>:<string> to provide the
> integer <N> which specifies the length of <string>. This is a little
> cumbersome, but the format is intended for tools, not humans.

It does seem cumbersome. I can see that it might be helpful to have the 
length of the complete query and response to avoid deadlocks when 
reading and writing but I'm not sure requiring the length of each field 
is helpful.

> I have a test integration with git-credential-manager available [1] for
> testing. This includes a model for interacting with git config-batch in a
> compatible way that will respond to certain features not being available:
> 
>   1. If git config-batch fails immediately, then all queries are handled by
>      git config.
>   2. If git config-batch starts without failure, then the first query is for
>      the help command.
>   3. As queries come to the config system, the query is checked against the
>      available commands advertised by git config-batch. If the appropriate
>      command is available, then the query is made in that process. If not,
>      then the query uses the existing git config command.

This seems like quite a lot of effort just to check a few config settings.

> I have a few concerns with this implementation that I'd like to improve
> before submitting a version for full review. I list them here so you can see
> the flaws that I already see, but also so you can add to this list:
> 
>   * The use of arg:<arg> to specify an optional argument creates the
>     inability to submit a value that starts with arg:. Consider alternative
>     ways to specify arguments or to specify that the remaining data in the
>     command (including spaces) is a final positional argument.

The protocol should be unambiguous. Requiring key=value pairs for all 
fields would be one way to achieve that

	set key=my.key scope=global value-regex=my-regex value=new-value

or we could force all optional fields to come first and count the number 
of fields to figure out whether any optional fields have been passed

	set value-regex=my-regex global my.key new-value

(I've used spaces above to delimit fields but we'd want to use NUL in 
the protocol)

Thanks

Phillip

>   * In general, I found myself implementing behavior based on the deprecated
>     forms of git config that use the --get or --unset style arguments instead
>     of git config (set|unset|get) subcommands. It's worth making sure that
>     any references to equivalent git config commands use the new modes.
>   * I need to add an --[no-]includes option as a command-line argument that
>     signals whether include sections should be followed. I don't believe this
>     should be specified on a per-command basis, but I'm open to suggestions.
>   * I have an early draft of a technical document detailing the plan for this
>     builtin. It has some lists of intended future commands that have not been
>     implemented. This would also be a good place to document any parsing APIs
>     built to help contributors adding to this builtin.
> 
> Thanks, -Stolee
> 
> Derrick Stolee (11):
>    config-batch: basic boilerplate of new builtin
>    config-batch: create parse loop and unknown command
>    config-batch: implement get v1
>    config-batch: create 'help' command
>    config-batch: add NUL-terminated I/O format
>    docs: add design doc for config-batch
>    config: extract location structs from builtin
>    config-batch: pass prefix through commands
>    config-batch: add 'set' v1 command
>    t1312: create read/write test
>    config-batch: add unset v1 command
> 
>   .gitignore                                |   1 +
>   Documentation/git-config-batch.adoc       | 214 ++++++
>   Documentation/meson.build                 |   1 +
>   Documentation/technical/config-batch.adoc |  70 ++
>   Makefile                                  |   1 +
>   builtin.h                                 |   7 +
>   builtin/config-batch.c                    | 772 ++++++++++++++++++++++
>   builtin/config.c                          | 117 +---
>   command-list.txt                          |   1 +
>   config.c                                  | 116 ++++
>   config.h                                  |  26 +
>   git.c                                     |   1 +
>   meson.build                               |   1 +
>   t/meson.build                             |   1 +
>   t/t1312-config-batch.sh                   | 372 +++++++++++
>   15 files changed, 1592 insertions(+), 109 deletions(-)
>   create mode 100644 Documentation/git-config-batch.adoc
>   create mode 100644 Documentation/technical/config-batch.adoc
>   create mode 100644 builtin/config-batch.c
>   create mode 100755 t/t1312-config-batch.sh
> 
> 
> base-commit: 83a69f19359e6d9bc980563caca38b2b5729808c
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2033%2Fderrickstolee%2Fbatched-config-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2033/derrickstolee/batched-config-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2033

