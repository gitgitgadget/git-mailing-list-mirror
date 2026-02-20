Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA9260565
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604867; cv=none; b=ctxbVWebiFXHPWIZtb+uEO4ltF2JjOvTU18bLWgLyJq4NY4hYGhjaY75NNuJJN9/VgqeJMdMQxTMfCuzmH/zxaedpTl4talkAfNWvYFNIdiZIqf6qxvVBpJPbxdc1+Hj1HCNJYRuiq6K3nciwoFzEG94piRp/k7pmU4JrKpYq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604867; c=relaxed/simple;
	bh=TE9Z2/qHDB5bO2cURft+D4Pk7usHHN7YUc/cg8lEg7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBqgkcrM4nKkVqasU7whu7LU/eEsXjBAPSPTqVfEAkQdW3VqyqQM91eWUk9KmiosfQlAlktJxRA+Cic5XkS+5xrhIGMgppSPoVSLTLfSfQRjp+F1sYyytoozpv1onwvZP8PFZgX0l88gHIpo/Obmaj8njSvBQsigBSLYxw3FwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkkTR1Ct; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkkTR1Ct"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35519fd4d59so112897a91.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771604866; x=1772209666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kER/J53zbOC00/8O36WVNbbYQOULZRq2aqnJstFinvU=;
        b=SkkTR1Ct0XOaIfYieUYyXadaUuItgBHV2FEX7ioujq84Y3IgkuNSRLuMRmAJbfyEGA
         uawm3D39VHeQYXR8mv8Vz1Tf2Ktf651SUYmqOEPbaBbuDH4+ctr3lCmWjxhsqPK/aX4T
         VPYxU4bV4vKcmVjQZnqeUM9/of2giyi7S50Yf1NfRKNqoysZsJF1sK77/jTP7l2IL+c8
         5FL8aUQhrLJPFjMZPTPHfUSkF86HV84oDK3/hhuPjIAE464wYl+04WAepmKM4FkLBNaI
         ksNicchGZJWA27RW1H8PLTHd7mGkRhJdZnNsEb1JiyymPwJQJ0MN3A0qu1aMkZzRzw9U
         AsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771604866; x=1772209666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kER/J53zbOC00/8O36WVNbbYQOULZRq2aqnJstFinvU=;
        b=Bcis+rS4YddCekp44++i8w6PynVbdRbsUEWVujrRAaAWfRB10sqFSe0tGQtuqActu+
         6IvluZmQeYeaB0fZp94BeH7WH1Yd+TydtcPCZHeGJZbxWMGGB47SY8r/9T98slHAIclg
         n9GoLD3eGgqjYl55riKFnSD716EOQVCawk9wp38oEg2YHGqdRDVWFEK3Z+OAZWV9i3kH
         Meb2iK3AzpyYubLCr81jA6PL+CPE/Awkv4WNz6SDb1NnapQbabsHvL+HMFK0iQdwJMlz
         RBCNFdaStI9NL4UfdK1bcMGhTLWSApH1dqZZGH6BWQKKfT/5NU3DSKor4TgXyVL9wIHC
         ZdVw==
X-Gm-Message-State: AOJu0YwRwQaIQ4/ItpdgybT74eU1NvjtTkgJ0t3ebJ1O1FTk+pkDWyl2
	Ttqcb1DE1+Vsyf7lPsU3Hzq2bp/kwVdKWTKZ8FALmMZvWRcowHO1C9v1VbdqmQ==
X-Gm-Gg: AZuq6aKajHvglbheyIdKefDLkoNtGD5lQ5xHn6IVbHjJgIGpCNyb+BG7qoZIh1nqR4C
	pswsmrtI0+wX1TR25AibNZkl/lqrmp7OG6Blnap7Ts3Q/b5+Tmls918h36a8jwHDV9ov3q5rOgm
	LcY0fQR7/TKg4qC4DNsFwf54vUh6TxNoL5hERTK29BXrU5G+DaU/RCnHAInjvr1iCp1aat8ztH8
	Fm6f46czKSorzr82rWU2zEO0AMqRSlM7XKvh461C4kbY4Do63W/HpIvZNHscrXHpTsRu2D4y/OI
	xIxhGJM9n/lBDv48WmUSV7O9wtqMZjAAwjFeUDgjd/gJgttWFmxeb6KCRs6Hlg4c7kXLGm+2tnk
	b/F/yu1UqMU+dzQKAyoqrVwc60/+33MYUE5LuvgX511m+MS6fdszT7Fq/eYljM9TmvIzdfp2mn+
	caD7weTxMPKtSuTlkqhLmrfY6xcw0=
X-Received: by 2002:a17:90b:3842:b0:356:2c88:1e77 with SMTP id 98e67ed59e1d1-358ae7c0e88mr199290a91.1.1771604865931;
        Fri, 20 Feb 2026 08:27:45 -0800 (PST)
Received: from [192.168.0.103] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a1a2cb62sm1886441a91.0.2026.02.20.08.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 08:27:45 -0800 (PST)
Message-ID: <12cb054d-71f7-4df3-b052-764b62d32f54@gmail.com>
Date: Sat, 21 Feb 2026 00:27:42 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] setup: allow cwd/.git to be a symlink to a directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260218124638.176936-1-a3205153416@gmail.com>
 <20260219071650.208074-1-a3205153416@gmail.com> <xmqqh5rc13rw.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqh5rc13rw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/26 11:40, Junio C Hamano wrote:

Thanks for the review!

>>   	case READ_GITFILE_ERR_NOT_A_FILE:
>> -		/* non-fatal; follow return path */
>> -		break;
> 
> This comment is now lost.  Shouldn't (at least /* non-fatal */ part of)
> it be moved to those two new non-error codes we see above?

Indeed. I made a mistake here.

>> @@ -1578,20 +1587,25 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>>   		if (offset > min_offset)
>>   			strbuf_addch(dir, '/');
>>   		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
>> +		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
>>   		if (!gitdirenv) {
>> +			if (error_code == READ_GITFILE_ERR_IS_A_DIR &&
>> +			is_git_directory(dir->buf)) {
>> +				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>> +				gitdir_path = xstrdup(dir->buf);
>> +			} else {
>> +				if (error_code == READ_GITFILE_ERR_STAT_ENOENT ||
>> +				error_code == READ_GITFILE_ERR_IS_A_DIR ||
>> +				error_code == READ_GITFILE_ERR_NOT_A_FILE ||
>> +				die_on_error) {
>> +					read_gitfile_error_die(error_code, dir->buf, NULL);
>> +				} else {
>> +					return GIT_DIR_INVALID_GITFILE;
>>   				}
>> +			}
> 
> Is it just me who finds the above harder to follow than necessary?
> I would have expected something like

To be honest I can't find any reason why the above statement is 
difficult to understand. However, replacing it with a switch statement 
does make it much clearer. On this point, I completely agree with you. 
Will change soon.


> 	if (!gitdirenv) {
> 		switch (error_code) {
> 		case READ_GITFILE_ERR_IS_A_DIR:
> 			if (is_git_directory(dir->buf)) {
> 				...
> 			} else if (die_on_error) {
> 				die("'%s' is an invalid .git directory", dir->buf);
> 			} else {
> 				return GIT_DIR_INVALID_GITFILE;
> 			}
> 			break;
> 		case READ_GITFILE_ERR_STAT_NOENT:
> 			/* no .git in this directory, move on */
> 			break;
> 		default:
> 			if (die_on_error)
> 				read_gitfile_err_stat_noent(error_code, ...);
> 			else
> 				return GIT_DIR_INVALID_GITFILE;
> 		}
> 	}
> 
> or its equivalent, with the top-level switch rewritten into
> an if/elseif cascade.

Point taken.

Regards,

Yuchen

