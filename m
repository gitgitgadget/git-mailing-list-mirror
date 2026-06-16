Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94E425CC0
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603870; cv=none; b=ED9sVYLnuf76EH2j2TVjx60cus86ZWhcuykHT+l/JR6UCyIK7r1H+UJDWW0IT902euJihj3XTtWlo8h0jLSlQ5JDc+dowiHfvryhuXajeRe32klix2vH+pIEaCDNqehAzfqJeGcF7nMh79YqgiKjfBHHNTH/PTUPLexjWcNtD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603870; c=relaxed/simple;
	bh=uS5xgOdgIXtlNQKttAtl99eabPFrfLiqkWOLwDJUWDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dtl+q/3fiDnNDZEtoTWOwq1dcw+YDHf7lEX6yQwQ3jq7I0Qrlp5IWak0pvS/z4eaBMhJNFwYLszAmT3zVQ/HB8PYYqCgWzppyTfgV7H5U0SRLdRMjZq18X0Wl1IACQBIZEq/L1Gn7uS/Q2oxd5BXaiNncw4s71fJSxuWyrACAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3OwWflQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3OwWflQ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-beb7f26ed62so508917566b.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781603867; x=1782208667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzgeBavYzrwCiUWZS/q4sCSE4+CezGlYhgc0oYWRJ6w=;
        b=G3OwWflQCJupJ51fhgTIJ9FUMqMVH+s529SVUBQftxaslMdJVEHLpGElYgCqjwQYrd
         88d7sb4QYkYcUo24XQ7SDDcDrppXFJ6PWmrdNZNjTSt3Qn6VvFbRmWdbtFBmoxodut1p
         meCwCfNAtxf+pYBLSfoj+dq44uXF6WehfDTHVoLtmjNWsAmNdIho0RTGGksU70CCBQKH
         IE6vyb12gi2VaeeJo1dDlkdGmtl5p+QpAlZjJDPTSiHzEQZyqbRsg7SUD3sqfSYNZcXV
         F5IXpIKrUsiAL0p3lW2b3gvjdmurQ1nc5RX0SIQFoRVYcy7a+hxq+cO7pLMSAj6blmWW
         4XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603867; x=1782208667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzgeBavYzrwCiUWZS/q4sCSE4+CezGlYhgc0oYWRJ6w=;
        b=L7vsbvn43dhvxMeUEnis7LU+I8BDaL2WTVMPM1q/EuO9ORLKcvB1dKy41ULXAHtIKQ
         0sHRBRBMeunmFu96E/RcAtKKOK5Sioqi0dVYbUNktIVzUOHcYWlSrBOZxAPHofTkcFTz
         n7Izzq99AQXsNBe7pS+gn4hx9s51M2bR18eBy9pfiRMvkrFRINAkRG2hOU5s1n8sqSQb
         kkb+BeTmuYasnvTfE2CmdA563+SdFtEG76HlGjtzy1neg2jFbqCZVA7J8kvXIf8Qpgdw
         GgudVF/VVPfMX/cF5BhZ5uWRh1DwTXtcJHqPZxh8gLoH6+NZeDRsICcSLnHENKpsDq5O
         CYdw==
X-Forwarded-Encrypted: i=1; AFNElJ818bx27UdwlfK0oAFYaSwVn/GPdSbn4aLba3z5W2hqtOhSm8caLub5goqt6O2l5jhD2BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx887c2sq+xO/pdl0TfnoeYvI1htng8Z9hrpTgqVMQ84Y9II6kB
	8u7MdLdGlpRL60m8CYi+81fR8Ly65wS7HwlLkNCvLxRDJ73M2AJ5bZvsc6rF4w==
X-Gm-Gg: Acq92OH9wfsSlvoO1ULbYkGVk728pK893OGJTM5RdCsEAOxVe/pN934WhQbGAz/BtPI
	XffTYqL5tpJdehEQne1pxjbNXBmyA2GvkZlrQFbW+OLURDFfIm/i9iGUpDeHglUkb3BOVAxLfeo
	AGf116ezh5ROgfZRFiG56wx/vp3IuDBSV6pot4+1O/nEnawVgsuCfvBlPoWRSqKhuDdukuhEx3b
	jmw+956vqzRuTsyGg7jmRT1otVIfygpZdft6lnzS4SPLp7WmATNFMbfp9UeBQaID1fi/mKRF7O1
	A3ddnPFbEUC1J8NtUi4q0zW28/UZyzGiFXGXpy/JSauMVdr2hMhECwbLVdqOxrr255NEGhnld5Y
	U/o8FrYAhI3HCl5iId+pGamXHcJvOzLlNhUy5Np0XNPFzG+ub/vlgTWfB2Ezz82RqkdIDajQclf
	vQ6/s1rCpYVhLBc4lp8B31dnOEaze10oojtQ/KEXeyHZi8clPyNedMHsnD5v3/3OwXheoUwaHlH
	jaGBEblHeXYM6Ed8Gd5UQ==
X-Received: by 2002:a17:907:2714:b0:c00:f408:c8a8 with SMTP id a640c23a62f3a-c04148c0b50mr122956166b.18.1781603867001;
        Tue, 16 Jun 2026 02:57:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693794ae998sm4800914a12.30.2026.06.16.02.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 02:57:46 -0700 (PDT)
Message-ID: <fe752544-b076-4aa4-a9d6-d48fe15ce57b@gmail.com>
Date: Tue, 16 Jun 2026 10:57:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/6] branch: add branch.<name>.pruneMerged opt-out
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood123@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <d691d5051b35a569dbd3f4a0488030a7d84d72f9.1780999917.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d691d5051b35a569dbd3f4a0488030a7d84d72f9.1780999917.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/06/2026 11:11, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Setting branch.<name>.pruneMerged=false exempts that branch from
> "git branch --prune-merged", which is useful for a topic you want
> to keep developing after an early round of it has been merged
> upstream. Unless --quiet is given, each skip is reported so the
> user knows why their topic was kept.

Sounds good

> @@ -755,6 +757,18 @@ static int prune_merged_branches(int argc, const char **argv,
>   		if (!push || !strcmp(push, upstream))
>   			continue;
>   
> +		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
> +		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
> +		    !opt_out) {
> +			if (!quiet)
> +				fprintf(stderr,
> +					_("Skipping '%s' (branch.%s.pruneMerged is false)\n"),
> +					short_name, short_name);
> +			strbuf_release(&key);
> +			continue;
> +		}
> +		strbuf_release(&key);

As this is in a loop we don't want to free the buffer on each iteration, 
only at the end. You should call strbuf_reset() just before 
strbuf_addf() above and then move this call to strbuf_release() out of 
the loop.

> +test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
> +	test_when_finished "rm -rf pm-optout" &&
> +	git clone pm-upstream pm-optout &&
> +	git -C pm-optout remote add fork ../pm-fork &&
> +	test_config -C pm-optout remote.pushDefault fork &&
> +	test_config -C pm-optout push.default current &&
> +	git -C pm-optout branch one one-commit &&
> +	git -C pm-optout branch --set-upstream-to=origin/next one &&
> +	git -C pm-optout branch two two-commit &&
> +	git -C pm-optout branch --set-upstream-to=origin/next two &&
> +	test_config -C pm-optout branch.one.pruneMerged false &&
> +
> +	git -C pm-optout branch --prune-merged "origin/*" 2>err &&
> +
> +	git -C pm-optout rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
> +	test_grep "Skipping .one." err

Do we really need a whole new setup to test this - can't we just add a 
protected branch to an existing test?

Thanks

Phillip

> +
> +test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
> +	test_when_finished "rm -rf pm-optout-d" &&
> +	git clone pm-upstream pm-optout-d &&
> +	git -C pm-optout-d branch one one-commit &&
> +	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
> +	test_config -C pm-optout-d branch.one.pruneMerged false &&
> +
> +	git -C pm-optout-d branch -d one &&
> +	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
> +'
> +
>   test_done

