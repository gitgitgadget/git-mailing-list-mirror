Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3293A9DAE
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814035; cv=none; b=fhJiDu2Rog7/C6cpjw6VtvS3Bwn0g/2e0mpbEhUGRz954+Hgp1/IBs4b8C5sRKZpD/9iAazBHfFk+1yZIe7JiNzlXTBPPAyi7G37M0kL04OFszl8ETTG9yJtpafZLmdjthtTL3dTIjzVAz+TUP86pKq6NmV8e/5TO7QnJbkOD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814035; c=relaxed/simple;
	bh=pFtwt/yHB6K8avb0MVY4MMCeMXxfTGLcopOmFEIn5m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWt4jvZlQFk2+5usWejhXFvAVl3YLYKUO9ijpKFs0Y1GXlON8sMTz4MRKqfK6bduoyZiSUNG+YuZD7zewDR5AzRQarnYYUbcBvwxLkLWUGwTg5YxSPSfH/c4CkFWbG99DplQ25XT+ZF1q4d9uUnTubhA/7RZ+OBDNECYJfhXebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdWMqKRQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdWMqKRQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so3536414a91.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772814034; x=1773418834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1Wu31tOvvhr3x6y49GNitgzPj1qENUC0vor3lb6ZlI=;
        b=gdWMqKRQ7G3IbwPRpvDttLKqF5F9iCs3VcwG53T0YOf5JL1h5ly+vwB3YdwJbe9/0+
         Bjy7kXEQIoTRxZ1L6pL4dnSCNNlA1MfJTU7RRrf/xd++POLzmngsVRikH4z1oDB+1ZiE
         7FyBhg0SCaNdEohevX2WzKW1+Lif1RMOGAIWRyQ23WVV4ojz370VQueK8vcD1MexirxX
         jiozORf/ynDVp1ebUob7fKS1kfpwlPy1m39IwSp2/W+kaXv1aNAa47mzSxZXb3D7jut9
         Al3fOLOdlvMbmN1McjPT24Q/7UQ/AJ9qVdRpGId38O3AcdW4vC/ybzsE8aZcXn2WTXch
         G1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772814034; x=1773418834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1Wu31tOvvhr3x6y49GNitgzPj1qENUC0vor3lb6ZlI=;
        b=EibbNIrTSTZapX16t9xXCM15DAvQmLLZGGDiGEG5fDmW+RlGdWldDqpV0qXdb4GxUY
         hCPhjHQs9IV/LWerHTB13ZzCvtmvW8I6FWt+uqqYoQdrKAt2Xs4dRYFIZb0KPC+F9jxY
         PWqD8VKOimOvigBMWuuMlw0XP63FTX+LhxC/SVE5suKyjvmMtOmSNOJ5+P77wOcNm4+V
         0eIpiOg3PstItqO4T59LhjT87qSLt9irXmPapKqQ35YUvU5w7pnlw4b7mwmKMR63KQB0
         hwWS6h59P9NNFda5WXF1t9Cko9KGPziHrcO+QUcntZuq6KBXTFahwyAHWwECmQdD/8rR
         n75w==
X-Forwarded-Encrypted: i=1; AJvYcCU+GX/Zff28/0utPSv7j3+OngyKDkpistcPzklaZLFcrtbW0JuS81X56xoS0rEwpNx8iSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFnvJJ+uX30J2+Gg4P3q+d8k6Y6yxFmCQFfo8e0m6b5FPVOJ+
	oIfPk2POkEWBMWoExwrgOI8ge7LpDKAtQQhds8qMOcDYQE2aJ1ZqCIur
X-Gm-Gg: ATEYQzzH6d6+eGoP6SpnH9cXfy3Ngk3J7FNN9YrXMLc7m5uItI1Kl1p/3ZdSII+oDvz
	ju5e/gXCtS0Ey9cwCuJ29VpRoLq2VWR0curr/Uy3No0MEknrxMIhMNnifBengkUiYZ8XXJWsqlD
	L2MUjSCjxVFdSZJ5KTBKXEgn2C0sOaB0JpvhD0EyiOzbBIRhShq6vlNMEvn8R4MxdehefWEVj+d
	jO+AlxNZZwXAqUo7Y7mM0xYQ4a62hhKxMkagg39kZCL9g2p376N34/Zg73hj2maKxIymk8C5i4i
	EH6vSLT5vWHfFoAUDKVfypOnC12ISkL8UvYtW1fe4FyenwLcxd7N7l4dE1z60Lvgc+2c4i5j3N5
	Szot4PJ7eS8e5EyAXCEFS0yZuRgsXiLWjAukWO8cUh1SO+HbfEOS8FuICkyqN/SQG9kXPOGEQ2e
	uSm01ApJI9tBVS3NGx+cdV3rGUzqBno/x3Cn6ouLvF6XEcIu+d6llr+Q==
X-Received: by 2002:a17:90b:5346:b0:359:8a78:569c with SMTP id 98e67ed59e1d1-359be374e1amr2422103a91.25.1772814033780;
        Fri, 06 Mar 2026 08:20:33 -0800 (PST)
Received: from [192.168.1.58] ([171.61.173.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c005db95sm3147115a91.6.2026.03.06.08.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 08:20:33 -0800 (PST)
Message-ID: <45bf9ad0-418d-44ee-b06c-d2b546f54b7f@gmail.com>
Date: Fri, 6 Mar 2026 21:50:24 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit
 changes
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de,
 toon@iotcl.com
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-3-siddharthasthana31@gmail.com>
 <405b0d34-c2ad-498d-93a1-2e7925ae11f1@gmail.com>
 <77fa95d9-3ea3-4a32-b8fa-22c05c048160@gmail.com>
 <ed9818d8-fe30-4967-897c-edc83c83c299@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <ed9818d8-fe30-4967-897c-edc83c83c299@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/03/26 21:22, Phillip Wood wrote:
> On 06/03/2026 05:28, Siddharth Asthana wrote:
>> On 26/02/26 20:15, Phillip Wood wrote:
>>> On 18/02/2026 23:42, Siddharth Asthana wrote:
>>
>>> I do think we should seriously consider reverting commits in the 
>>> reverse order that they were created (i.e. do not set '--reverse' 
>>> when setting up the rev-list options) to reduce the likely-hood of 
>>> conflicts when reverting a sequence of commits.
>>
>> Good catch. sequencer.c does exactly this in prepare_revs() -- it only 
>> sets reverse for REPLAY_PICK, not REPLAY_REVERT, so git revert 
>> processes newest-first.
>>
>> The complication in replay is that pick_regular_commit() chains 
>> commits through mapped_commit(base, onto). With oldest-first, the 
>> parent is always already in replayed_commits so the chain works. With 
>> newest- first, the parent hasn't been processed yet and 
>> mapped_commit() falls back to onto -- so each revert be independently 
>> based on the original branch tip instead of chaining.
>>
>> The fix is straightforward: for revert mode, pass last_commit instead 
>> of onto as the fallback in the main loop:
>>
>>      pick_regular_commit(repo, commit, replayed_commits,
>>                          mode == REPLAY_MODE_REVERT ? last_commit : onto,
>>                          &merge_opt, &result, mode);
> 
> As we only allow a single range of commits with --revert that should work.
> 
>> That way each revert builds on the previous one regardless of walk 
>> order. I will do this in v4 together with skipping the reverse=1 
>> override for revert mode.
> 
> Great
> 
>>>> @@ -226,25 +269,46 @@ static struct commit 
>>>> *pick_regular_commit(struct repository *repo,
>>>>  [...]
>>>> -    /* Drop commits that become empty */
>>>> -    if (oideq(&replayed_base_tree->object.oid, &result->tree- 
>>>> >object.oid) &&
>>>> +    /* Drop commits that become empty (only for picks) */
>>>
>>> Why? What's the advantage in creating empty revert commits?
>>
>>
>> Consistency with git revert, which doesn't silently drop empty reverts 
>> either -- it stops and asks the user to deal with it. 
> 
> So does "git cherry-pick" unless you pass --empty=drop or --empty=keep 
> (I was surprised that "git revert" does not support --empty, that seems 
> to be an oversight)
> 
>> Since replay is non-interactive and can't prompt, I kept them rather 
>> than silently dropping, to avoid hiding that something unexpected 
>> happened.
> 
> I don't think creating empty commits for revert is very helpful, when 
> cherry-picking one could argue that the user may want to preserve the 
> commit message (though I think that's unlikely in practice which is why 
> we drop commits that become empty) but that does not apply to revert.
> 
>> That being said, I don't feel strong about it. If you think dropping 
>> is the better default for replay, I am  happy to change it. Or we 
>> could error out (exit code 1) like we do for conflicts?
> 
> We don't error out when cherry-picking and so we shouldn't do that when 
> reverting.


Right, will drop empties for revert too then.


> 
> Thanks
> 
> Phillip
> 
>>
>> Thanks,
>> Siddharth
>>
>>
>>>
>>>> +    if (mode == REPLAY_MODE_PICK &&
>>>> +        oideq(&replayed_base_tree->object.oid, &result->tree- 
>>>> >object.oid) &&
>>>
>>> Thanks
>>>
>>> Phillip 

