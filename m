Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46018A934
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652223; cv=none; b=X9CxaCPmDlmstx83Thx3WiqvWnP1Hd1bM9FyTtnh0ehs8rduP2zSZmHnucJ8s4EYgRw6Ac0lWqjqb2700/fULGw5XwClApc2TUePc1e6tlWtJcx6o6QRBzegUrzF1StrKTeWvpMPjjXDl3a4ObZAhW6Lc58X7ivXK9qTzX0ISXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652223; c=relaxed/simple;
	bh=9lIYyMNL+pk3PIy4xPoEMaKrbAmcsYD/uasWkm8WgSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrNoohq/KJoDatRsW1BtCPwRlapX0GBXQqRA1VTf42qX1uwOwTvzboy3Eh4S+jY6hQCpCW3aV+mJpbLgvVQqpI7j9etiFS7K8Nf9VW5WimoxSvLFtSHIdqNogFCy4NTN/cElkQEINYJpmfmIc6VxeOzUL3AYeJhJKtyIHYirUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ezrDKPvE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ezrDKPvE"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-705ff14d159so1149054b3a.1
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1718652221; x=1719257021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiDXLtVAp18sdlCsCfsjMQizbOano2LTEmJPm6oyEvg=;
        b=ezrDKPvEE4nttJXwP5JBfdGx9798P7gexv3tNoNMFt/6pkWOEuwOIRiM3QY6/toFRW
         FCbueW8cGWVUdA+6/Pgs3OIoUv5cFGLGJbWJsv5Nozk1BmaVzFvs6LWGA7kEUpRivdlq
         3Bzw4lgGbNx7fgcDA8DeSeVRfqYpztPfsOWKdQVupfGOLrmZJO9MW+3TGBJt4TUSTCpq
         r352ndEs/bJtF2KDFKZ8thOWwbUt/4sAFctBiQNP5QafXkwEHn4rPeLJSKz4e5e/O5g6
         UNpOEf9d3IzU2JLKaO7KyQLeKCzBiIPZoEd92Lsd/KouDlEVJk56h6zxPrGvoMN0n26h
         ftRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718652221; x=1719257021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiDXLtVAp18sdlCsCfsjMQizbOano2LTEmJPm6oyEvg=;
        b=g35vlkj5CABHBsmbEIJ72Y2014qUhPncLiNptG2f3DwZaT5xQfgaYgV0LrqvvcjVpg
         dIyL9IArwfB3Ct/zLAjQOLgdyio61K8Jewg8tFzzmQaPhtYJaEk1tBrOunmQ9EGFA5hu
         o9aIFnyLhBO5SlPKtXhTYCcvEO6jsfmvf676E3oF/kmnht3FSySxJqcPDCizmAkyalnO
         fso5IWhHkxN9pKJ90RCCHUDbcUForOVveONl//umrCGTLC7xxUYFjPbqt+iweyNifZPA
         oi0E2F2D/y4v3VbgBQjhG1yBKpG/X/qehdPaCrUqXu6kGRXzLekC0OrsvxGMDGrWhmEM
         /RrQ==
X-Gm-Message-State: AOJu0YzvRezgKpIBP0CKRSAvvy+CDCGNu4Vt1t56BzB6bpmcRXMPyWAu
	RdV3rgXWRw2DazGKHFLkonp8A0+f722kxC4VSoe1HNA3pSYqwij3XvRpMIhX
X-Google-Smtp-Source: AGHT+IFsVaJczGNtWIbHZ8Gyxiz0yPH31QZv7/TJ7fYODnWDFL5HrHkQdwNU+RxAWmyodMqQyOPGpg==
X-Received: by 2002:a05:6a21:3213:b0:1b8:9933:14d7 with SMTP id adf61e73a8af0-1bae83c6cc0mr9747304637.43.1718652221110;
        Mon, 17 Jun 2024 12:23:41 -0700 (PDT)
Received: from [192.168.50.41] (syn-172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf59299fsm5850571a12.55.2024.06.17.12.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:23:40 -0700 (PDT)
Message-ID: <55e06e1b-580e-45fe-a914-d1ef252d5981@github.com>
Date: Mon, 17 Jun 2024 12:23:39 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] mktree: optionally add to an existing tree
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <df0c50dfea3cb77e0070246efdf7a3f070b2ad97.1718130288.git.gitgitgadget@gmail.com>
 <ZmltKHI-Vz1L44r8@tanuki>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZmltKHI-Vz1L44r8@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Tue, Jun 11, 2024 at 06:24:46PM +0000, Victoria Dye via GitGitGadget wrote:
>> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
>> index afbc846d077..99abd3c31a6 100644
>> --- a/Documentation/git-mktree.txt
>> +++ b/Documentation/git-mktree.txt
>> @@ -40,6 +40,11 @@ OPTIONS
>>  	optional.  Note - if the `-z` option is used, lines are terminated
>>  	with NUL.
>>  
>> +<tree-ish>::
>> +	If provided, the tree entries provided in stdin are added to this tree
>> +	rather than a new empty one, replacing existing entries with identical
>> +	names. Not compatible with `--literally`.
> 
> I think it'd be a bit more intuitive is this was an option, like
> `--base-tree=` or just `--base=`.

To me, the positional '<tree-ish>' is more intuitive; it's reminiscent of
'read-tree' (but with '--empty' being the default, since there's no
equivalent to the existing index to overwrite). I consider 'read-tree'
relevant in this case because the updated 'mktree' allows a users to create
trees like:

$ git read-tree <tree-ish>
$ git update-index <entries
$ git write-tree

without the intermediate on-disk index. Conversely, there isn't really an
equivalent option to base the name on ('--base' is a bit overloaded, as it
typically refers to a merge/diff base), and I'd like to avoid adding more
potentially-confusing names to the overall Git UX if I can help it (even if
this is a plumbing command).

However, looking at other command documentation, I should at least drop
'[--]' from the usage string. While that is a separator used to signify "end
of options" using 'parse_options()', it's typically only included in the
usage string to separate different sets of positional arguments (e.g.
revisions from pathspecs). 

> 
> One question that comes up naturally in this context: when I have a base
> tree, how do I remove entries from it?

In patch 16 [1], entries with mode "0" are removed from the tree (similar to
'update-index').

[1] https://lore.kernel.org/git/a90d6d0c943283e9e7bd181cd6e9bb6d4572aaeb.1718130288.git.gitgitgadget@gmail.com/

> 
> Patrick

