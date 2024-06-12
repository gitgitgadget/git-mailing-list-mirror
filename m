Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27001C14
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218888; cv=none; b=KxeVcR0/ACXNHAAUTmPGAO7qVf0YmvL4pKatBtHaVKiBXwqtfKxe8Q0E1DzM/yW0QlsFlkSJxWAiuDupOTZHVBxP0PfW7iUsWF7ovzz/MEWwcSVTR43bMUy/XLO0CbdLlgH6ZV3uKrbmrtjN3FBHyi3Zje1qTNstDKh+j0RfzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218888; c=relaxed/simple;
	bh=vcht/wq1yyWm8Hr0BnJzzOhYaUyxO/q0xwUzAivQZ90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmniEzGJejx6Jzy++wWMlKTwEWk2WoqfbiJaDSNTGy9ZkI9DoCjo8soDAJXz50KfE3dPXREXyQH9o2lIyzOMHEPpkX72gC4NvtjbR4Vv19mdyBHEhdkbgTSLvLOaJwloZrc8trD6hg6Y9kxxU65hBnaC4qzvo935gvH1Du7O1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=VkjXPhEg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="VkjXPhEg"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-704090c11easo116568b3a.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1718218886; x=1718823686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Nx2B+UTJIyYdUYs5NG6QHwE6B+uVZPZWtViF7y6GTI=;
        b=VkjXPhEguYWkeoesUK17Ah90adHynFN9ksR21An9SRqi88HNB3+tBn+XxZxCyPMyGL
         QxQW6MKghIIxpod9yEEw0th/cHe20zsj3E52W6bcDZ92aPA5lU8AUwfx/V5mS1j0z0o4
         vkL0UkwHi8DpPj+9C6zklvul92jMLQdEN8hwEVg84rXNaw3af/MndvbatqHupD0AUuwa
         EpH3QJkIIxnmez+QZNRfEATYKkip295ZoOaz+o6rAYMilxu/odFeaA3mayR0zlKd5HRU
         B42/Tpz7X98Vqz3Lc+MdH3G4TQuK8MWi9tvMPj1cfweW39sIDpbo/9OEt2RdTTuSGgc8
         RjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718218886; x=1718823686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Nx2B+UTJIyYdUYs5NG6QHwE6B+uVZPZWtViF7y6GTI=;
        b=DDnbbMeQtYgKvxCQJEOjRU7Pv3C/IILZGAZn5E1RQAqey50K7yAYnqLOx+QE6Y0z2v
         xA2OB26aefyRkXorNPlfEaaEwfA1jQNbBI8HZYHf/n+1Mgm51z2KnHeAMWSVOZPpDms8
         MkDwiY23s9wJuunebQ4mSkYVfyiveWMWtH2jnYZhg5pUqbd9H9VbQMtwolBAbsPcSMuI
         LRSnc5bXOZar36gsW5IHUpjSxoOozDqjEUrDAjJEIIw2eyWDpzmRjE/0JTp8UTzL+0V6
         WHIPQu5lGR1jTD19GWz195nX142ZKMsr4H2YRRgP8LjyX8HuNTOm1CnRvPgI/oEdCVYK
         SHAg==
X-Gm-Message-State: AOJu0YyQ3J2I5UJR7fJBsb23H6X4VT/aQkvQxg0jzzJ0kstGhTTv1Q7p
	BJI1RMuDILUgQU2yEfAhkabJjXGxojUNUYXM1Icun6Q9Iq4+Khc/WDKIRAXG
X-Google-Smtp-Source: AGHT+IEz2Vcrq861Rcr2zsYZX1vj1+BFr/KuZobZEel/d+CNz5E1uYNOUxCM6GNReUhgyrCq52eOaw==
X-Received: by 2002:a05:6a00:1146:b0:704:1fc9:a859 with SMTP id d2e1a72fcca58-705bce43adbmr3267090b3a.20.1718218885953;
        Wed, 12 Jun 2024 12:01:25 -0700 (PDT)
Received: from [192.168.50.41] (syn-172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041d383a46sm8722500b3a.93.2024.06.12.12.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 12:01:25 -0700 (PDT)
Message-ID: <63fd367e-4246-46a8-9b95-6353a5a54b36@github.com>
Date: Wed, 12 Jun 2024 12:01:24 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] mktree: validate paths more carefully
To: Junio C Hamano <gitster@pobox.com>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <4f9f77e693cfc4fbe72a2ae739bc7e236a3b82d3.1718130288.git.gitgitgadget@gmail.com>
 <xmqq34pirj51.fsf@gitster.g>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq34pirj51.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Also,
>> remove trailing slashes on directories before validating, allowing users to
>> provide 'folder-name/' as the path for a tree object entry.
> 
> Is that a good idea for a plumbing like this command?  We would
> silently accept these after silently stripping the trailing slash?
> 
> 040000 tree 82a33d5150d9316378ef1955a49f2a5bf21aaeb2    templates/
> 100644 blob 1f89ffab4c32bc02b5d955851401628a5b9a540e    thread-utils.c/
> 
> The former _might_ count as "usability improvement", but if we are
> doing the same for the latter we might be going a bit too lenient.

The trailing slashes are only ignored on tree entries (with mode 040000), so
the latter case would not be allowed (and triggers a 'die()' as it would
today).

> 
> Let's see what really happens in the code.
> 
>> @@ -49,10 +50,23 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
>>  {
>>  	struct tree_entry *ent;
>>  	size_t len = strlen(path);
>> -	if (!literally && strchr(path, '/'))
>> -		die("path %s contains slash", path);
>>  
>> -	FLEX_ALLOC_MEM(ent, name, path, len);
>> +	if (literally) {
>> +		FLEX_ALLOC_MEM(ent, name, path, len);
>> +	} else {
>> +		/* Normalize and validate entry path */
>> +		if (S_ISDIR(mode)) {
>> +			while(len > 0 && is_dir_sep(path[len - 1]))
>> +				len--;
>> +		}
> 
> Leave a single SP after "while", please.

Ah, sorry about that, thanks for catching it.

> We do this only to subtree entries, and all trailing slashes, not
> just a single one.  OK, but I am not sure if the extra leniency is a
> good idea to begin with.  "ls-tree" output does not have such a
> trailing slashes, so it is unclear whom we are trying to be extra
> nice with this.

It might be a bit niche, but 'git ls-files -s --sparse' does print
directories with a trailing slash, and in a format that is otherwise
accepted by the command after switching to 'read_index_info' for input
parsing. 

