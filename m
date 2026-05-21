Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BF2F3632
	for <git@vger.kernel.org>; Thu, 21 May 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403828; cv=none; b=aDNT0vuO/PpxzJ3mQUFIWeUyFr9P2LSLFH+LsNJeuneJpHPCGJpVmWgus1+sjiy0gkawJqzsbchmTiKbSFGjPej1iKhS70xwa11oGIiyNwT5Bu5cumctW7+W1jA31Y1cHMmFXgd3MJ3u6VdcGvi53Gv5dCFhzR6iIxYZ/xmexLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403828; c=relaxed/simple;
	bh=Xb6+jzumcs9J6IMn9/UBLNLRXHtpkRFyH1hzt9x6wUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRbszle/BcwgOW/p5LvjnSztV66gH8LSyr2rUF0G3/0fPUThqOzWHZc+OUiTFNdcuNFXikSg3/C2r9GOF0m6LTXH+eFR6g7DUQl8cvX3IA9Xb1A/j3uM8Jv06Y5PG8MBgH2NctV84IDmr2kJhQDvA/opbIsKZgrifMnnh0R5t3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qc9gwP4T; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc9gwP4T"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5165195c8b0so74398651cf.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779403826; x=1780008626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJ/DrSvyvfsDtk/OUT8rHU5fbzN8I2OhrGYDq+kJRWY=;
        b=qc9gwP4TTIrQcMeYKPs8ZuAhqpguDvi5vragUuFt8KZvV76YvDtPAU7eqocDcBBC8w
         aMFHIFE+wXNouQIqnk+3rJkNVTIz43qgNzyNKKkEPGp+ObiapbdFJQnyTkAJ4sa4YSLm
         gei5Hla38ApkSTMgCZZjPsd5YkXkiNrsYZriyiORXJss84tDSJgi6Y4VN+iNmT4CT5dR
         8F9NOILBXcn7ExwzLVnNufDqmF4y0lFnTnQpAWBcIpgoOGsMPPAXOduA/xEk3Y3CJrph
         5w7m6nE9AjI8/zdGkUWyCC33mxJ4tnQMYx8Ui0vVH/tuWTOE0N+mlLAgsE5CNib80a0H
         S+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779403826; x=1780008626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJ/DrSvyvfsDtk/OUT8rHU5fbzN8I2OhrGYDq+kJRWY=;
        b=f7Hegphp9EPy/O08ZfMkWWwnh5ynDK/NMP18AMP5+kFRDVetu9ZUq4eQlOY7Pj0Kqd
         gYnfatHyageeTA/u6R/1vmaFzxlpb6p2BSalg6+wHsmrSHixtCGSLVNOOPjQPZhRL/s9
         28BFIEQK2rtZAwcJFl8SSyYeulMK8lfBUDjMuvqPfipwJP+yThvY9RHvSdNX+28GhOj9
         q8v8XnkQ2/fgpuIK8LxdFBkKDn6CR0Gu8S0hqwsRR55Y9NT5bAAij1Ak4tt7WtNKHdMN
         20qjQ0uA3CbZ8kIuwe6K98wYdYLz3Ip/ICjQ1N1aWAsXe05Lv0CzCPlcOgZFV8igUixe
         Y7lQ==
X-Gm-Message-State: AOJu0YxmKJWWtbEj+P5nipHgBvQTPwY3mcm0vswAdhyPBakiTGTP4t+y
	4dBJQ9yY6idXq6QL47bTmYpc87dHBrCk3iGyoetiT99qwT5KUDzzTFts
X-Gm-Gg: Acq92OEea7rUBaAOoOjdNjs8BkXQ7tfrmFLbu9eKTUwFe8EKNUrgTl/6RlhSz1Cd1H1
	oMNYHiL0v9s30PCsIMvGKASR59eGm7c3Bus+7cPNa4CY1xwO566i0oLoC1dqYKHpgiZxMyRDWH/
	Y5cUrcxXYtQqR9SIAPapTop6bq6Eqwdqde6B18RopkFrc4tYS4hKGrmKelhVJ/5QMn412Rc8isP
	zrF7i8Up9+NZtBnE83pVwIXO61R4fQ+pmNjfBzRxc+LsUsHcTDPh3w6YvH8/ZrCYyBSfAO+XvDx
	GigYDSS+jHS/Ux+qNVfwJdhw033KaLLcss7x6wtws5P6PbxawOqHL81OOOte4xMVgMhQqzPIw4J
	/CZ7MwoJpzYQMVYVQqLhWFScyr38s81Y+7D1J8uXJnIY30Ip90ee/OUET7oqWsn6SBP7L5zSGsa
	AjT6vbgTH8vLXz2VieN/gNg184N5ybkVMNWAUFW64+Bq09ivAs1f52aAsbgdL2bt0acWMxe4pmA
	um8Bwlxh/ZOoS61H1K4MkWiNGs8P9PTDMoS7xapyFiQV4ITFC+/S9SKO54=
X-Received: by 2002:a05:622a:c4:b0:50b:4e60:93b7 with SMTP id d75a77b69052e-516d45c8db0mr20409091cf.43.1779403826611;
        Thu, 21 May 2026 15:50:26 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:b19a:969:106e:4f95? ([2605:a601:9b88:8300:b19a:969:106e:4f95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d6471fa7sm3660941cf.25.2026.05.21.15.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 15:50:26 -0700 (PDT)
Message-ID: <cdea34a8-6f20-4ebc-ac75-461e0f592104@gmail.com>
Date: Thu, 21 May 2026 18:50:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] commit-reach: use object flags for
 tips_reachable_from_bases()
To: Jeff King <peff@peff.net>,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
References: <pull.2116.v2.git.1778922993480.gitgitgadget@gmail.com>
 <pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
 <20260519010354.GE1612961@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260519010354.GE1612961@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 9:03 PM, Jeff King wrote:
> On Sat, May 16, 2026 at 03:59:39PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> 
>> v2 of this patch, addressing Jeff King's feedback:
>>
>>   * Replaced the decoration hash with the RESULT object flag (simpler, no
>>     extra data structure, handles duplicate tips naturally)
>>   * Fixed early-termination bug when multiple refs point to the same commit
>>     (the decoration API overwrites on duplicate keys)
>>   * Removed the now-unused index field from struct commit_and_index
>>   * Diff is +11/-12 lines
> 
> Using the object flag here is so much nicer. I see you're reusing the
> RESULT flag. I'm not sure offhand if there might be any conflict with
> other uses of that flag bit. I think probably not, since it looks like
> it is cleared by the other users after they leave their respective
> functions?
> 
> Using a direct set-inclusion check with the flag is nice, but we still
> look at min_generation_index. If I'm understanding the code right, this
> is mostly about counting the tips we've seen. Which at first glance
> means we could probably replace that code with some kind of counter. But
> I think maybe there is some notion of "crossing off" commits which we
> don't actually visit, but which we know become un-visitable because we
> traverse past their generation numbers.
> 
> I think. This is really the first time I'm looking at this code. So
> AFAICT your patch as-is is correct, but it would be nice to go an ACK
> from Stolee.

Sorry for the delay, but I finally took a close look at this version
and I'm happy with the use of the RESULT bit. You clean it up and
shouldn't interfer with the 19th bit being used in upload-pack.c as
the HIDDEN_REF bit.

Thanks,
-Stolee

