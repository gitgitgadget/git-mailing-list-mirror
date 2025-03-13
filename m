Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F129235371
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876010; cv=none; b=FRHQtmDYNjI2Nz4B4DzrXp1+cEdmQC3z5CTd+Fi78QnK7Iq/0AAtG6Q88MwV3s6d+tUrvVITXYDCdJSXA7n8BfP3GGGu0gClJmnIzcGTCiakiERBo7U5G1b939Mo0Tv4R161zoCaVgeTSENJ98vIUB+WEAQ32Y+IEQyLpHizcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876010; c=relaxed/simple;
	bh=s9+exw78DpA3y7+kfcybh/b3oLo4+lzvzO4ooTrDHEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6kNtdcDA0V0eL7xAduPPLQOByaWXPswiWZy7Qewebz0qUTQJZdKfzoCFtIa+/ouEGjjvx86JRKT+lczmbfT2APlS1kk5AFaT6ZcZ0UKrbS7xlbCUzV8bLrpX0lJ6CrsdzODUmSB82jKbM8/DsR1Eif1Bu1KkHQJBrwE/1TGza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjocq4Cm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjocq4Cm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so19320025ad.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876008; x=1742480808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEu3Z5E8XPpP+47DIK1/BXRD6A/b38PVMpYNgpfzsd0=;
        b=Vjocq4CmtkAf3xQmGVIB5aT7VqwOhaFQN7H9HsEiSmDL1QG6R2w4N5BNf4GvHQOdEQ
         yHQYn+gdIR9RpDuOGI7vfPL5UMbg84rxHC7RNOU++QRV2k7bdM1OxjRJmQN/tkk6ZoDi
         RKnleLbQfEVtQv5jnASJhiogKiHgKwDNPo2oghYCAd2/lWQ5P4k+ahGiG8I3BSib/TQ7
         QpH50UMsKkT8bScUNxnwzeEfr2E8yhIe/rOp1A3hLhn9S8nj9xXNq1LIaCO9tHMn+aj2
         0XL7AYLdm58FaV0G0c+nXdSQ4ehx2O/e3kL05eZhFVpWDewEGejIl8mtfsSrgoxgzhQ/
         JXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876008; x=1742480808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEu3Z5E8XPpP+47DIK1/BXRD6A/b38PVMpYNgpfzsd0=;
        b=jvHZxjq2gw0Dz4IYioPeRXpt82LxDZZERoqHYJr72q3LveCJE4zBK57qJx0KuCsP6L
         jOnBrli5Myhs99wZn7D+KenXRiKy7DV2eLd2MU+vELlNRv31Q+VuWTKWL1u3U+1SR/2h
         G6uczCubawF4oJ4bcLVibLquiZJz0xjhlNIu7uqQzGwxD4d46o4Konv84rFQNvva5H6y
         HSqrFXqECR99N/vfFe8C6MyK1GPx1Pot2mzakJ6/mUDZFkDM73F5Byf/WBthN+fs7m7S
         KBX9BJaXl0ASns0QqGRqKOUdDctHiqVY9zdTmX6r8Smcn/xUf2XFaDfnsa50ZRKCdLAj
         pn0Q==
X-Gm-Message-State: AOJu0YxGbxdPp/SfTYddD0NAcDLppxl6DTQADXKfhK0rFfq7uyLunZIG
	bL1x/Q/Gt9M/WFrmGJOzpzu12FaQlJc2euU0id4YSJWeSVtjB85G
X-Gm-Gg: ASbGncshm4I0LoJk6IWMvby2PYQumTA3JPzJj0HW+myttOLPFlGAII1yRv6ytFWC4I/
	yGjxZWxIaURkTqMAmLg99wK50+6QBXbxm2OYm/FEdSBl9au6AGO0aHkDCoTlYHOCtnW8I4YGMTB
	czdjVrLwsD26CDvMv8P+kHS/BfonoI0WFvKJdM0934Pk2OpC1CJ1uepxiI6OL9o5n3TSuLXloyX
	hObpJnzU2eS7bIC7qaoO56SsFlSKrFihH9j6uK7BgimRT3YKFWFDqSzcEBrHA8EJF+6s1sgbqIw
	MeMyBBlIMP0SJOmixZ4hhvcU845ywz3irfl+zZG7O5CVd1SvaIohAAic5w==
X-Google-Smtp-Source: AGHT+IGTwpXFF/Ob18XClz3CF3O8Mosf324NeNyclZ5HH2qKTPHmr4dc2BhYAjWAs5OS4Gs85FtmFg==
X-Received: by 2002:a17:902:d2cd:b0:220:fe50:5b44 with SMTP id d9443c01a7336-22592e44c9cmr168689475ad.31.1741876008361;
        Thu, 13 Mar 2025 07:26:48 -0700 (PDT)
Received: from [192.168.1.6] ([182.48.215.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7d9sm13636865ad.195.2025.03.13.07.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:26:47 -0700 (PDT)
Message-ID: <a4d33c35-a6c3-4f42-84c7-80a7ecdcbf96@gmail.com>
Date: Thu, 13 Mar 2025 19:56:45 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] rm: fix sign comparison warnings
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <xmqqy0x9s8mg.fsf@gitster.g>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <xmqqy0x9s8mg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano <gitster@pobox.com> writes:
> Arnav Bhate <bhatearnav@gmail.com> writes:
> 
>>  static int get_ours_cache_pos(const char *path, int pos)
>>  {
>> -	int i = -pos - 1;
>> +	/*
>> +	 * This function is only called when pos < 0, so -pos - 1 is
>> +	 * greater than or equal to 0, so it can be safely be stored in
>> +	 * an unsigned int.
>> +	 */
>> +	unsigned int i = -pos - 1;
> 
> "Can be safely stored", sure.
> 
> But so is "int i" perfectly adequate to hold such a value, no?
> 
> This is one of the many instances that demonstrate why the
> "-Wsign-compare" warning is of dubious value, and invites worse code
> than necessary.

While "int i" may be adequate, this, in my opinion, emphasises the fact
that we do not want i to take negative values, so I do not think this is
worse. Karthik's suggestion in another reply is also an alternative.
 
>> @@ -58,7 +62,7 @@ static void print_error_files(struct string_list *files_list,
>>  			      int *errs)
>>  {
>>  	if (files_list->nr) {
>> -		int i;
>> +		unsigned int i;
>>  		struct strbuf err_msg = STRBUF_INIT;
>>  
>>  		strbuf_addstr(&err_msg, main_msg);
>> @@ -271,6 +275,7 @@ int cmd_rm(int argc,
>>  {
>>  	struct lock_file lock_file = LOCK_INIT;
>>  	int i, ret = 0;
>> +	unsigned int j;
>>  	struct pathspec pathspec;
>>  	char *seen;
>>  
>> @@ -314,8 +319,8 @@ int cmd_rm(int argc,
>>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>>  		ensure_full_index(the_repository->index);
>>  
>> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
>> -		const struct cache_entry *ce = the_repository->index->cache[i];
>> +	for (j = 0; j < the_repository->index->cache_nr; j++) {
>> +		const struct cache_entry *ce = the_repository->index->cache[j];
>>  
>>  		if (!include_sparse &&
>>  		    (ce_skip_worktree(ce) ||

-- 
Regards,
Arnav Bhate
(He/Him)

