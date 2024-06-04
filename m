Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520F8F45
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509501; cv=none; b=myLgq0YL/RO+P7SRpVgyxtyyGN9FW30knxUUUUwrlYVnaXiBdUnqY8HxVQJqXNT1gabHGjr5hukvjMXS/SV4RK/mrPOd9VYPuY/zDmaBHGyJV0RNs5I+4L7swxNZCZ5ehqiQNVfv8aoLXsJcjvmT8eZhVONjknrQ8JttkO5riGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509501; c=relaxed/simple;
	bh=85JtnAeEVmp12uxCFPf3Ojsg8yHGBOguqKN80o3hVtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzd5mFJdTQ/yVHp97cynZEvmWZuuMc/av8+VlYA/4IcAdUZODqakNw7WDZfEAtS3FGzJEr6c6g6eu6FhuaQFY9D9ziJfwhn9PwAh2RY2wjnqwWI5lKemPLrQBhBYgEtsfqcHSwPRC/6E5KYeFBFxarVe/RscgqzTwuc5Ksxov8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOvxceJp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOvxceJp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4214f52b810so8801515e9.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717509498; x=1718114298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H0pAhEVrywAP3fslZjeEqZ9zBTe6qXUsFq/23mz3ZoU=;
        b=JOvxceJpQOv4P5LjUKkjMghInc3L+S8SjkO6TIGimmhD+VC1go12LV/q3Gua5gWKQb
         NRO4C4Q9XRr6i21tlzhPS1AFOHKffdSfvj9afGOMj+MXC+jLgKqNXOqCfONZaQ9mtMh4
         557/pgzt5tGArSDETq0+rjLW5s69vN+5f+V+SwM2vW5nscxXVtEUYBw+0HoX3IVhv1Lh
         W7l5DFvt0eDR5fa0da1tqjMSX89vjwqpuuITrUG6N1stFv1FXtWgqGvjgSaD5pUshO0U
         Z6ZH6j79hEBmWOz5oCAYXtS7YQaI73xN7QqRvHSgNVX0GqoQiXcHmTXFoCC6pUkk7HHl
         W+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717509498; x=1718114298;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0pAhEVrywAP3fslZjeEqZ9zBTe6qXUsFq/23mz3ZoU=;
        b=NjKerspWrv8g7CEUx3YVgunEP640uATmIg5HpMYfDLApJR4LjDvM67E537evItgS2R
         e8a476s8crzBH40GvlSFKkLp+zfs2xz8TTrRqTzy2f4BHpqccJVqpfD8K3oRlOaUCIXp
         1MKyaW18WtM5zKsJ+5UiQibtMFKzvcGTMQTSJQTFsRTVJ70nPsGNMui0LnlpVK2qAnU8
         2jjPhPk0SFj34ORns7pNCjB8LWDHkkSakYKPpAGUYmJa3n1AUwdKr1jgCyHt39zyFgTy
         YYbquXF/9ZxzfIJxyFniotMneYidIR85wFab3dKVOawbrehaGzDqPpAcG7iJeJ/wHWLp
         5cbw==
X-Gm-Message-State: AOJu0Yy1ikn9VCebRYREKusSVo/WQjWLOlshMOawIiS9kMmAlVsenQZc
	JNBFNVWVSx0V1ayJeKpvOGISctMT9srMfxysYX1sGCZsMswkwDTdPgnz9w==
X-Google-Smtp-Source: AGHT+IFayRlaelkINsXov1BtBcRpMxndJ34HD5VeEANy3IPc1qFasyuyclN0jtddyXSUxAA51MNzqw==
X-Received: by 2002:adf:fc50:0:b0:354:f612:5f7e with SMTP id ffacd0b85a97d-35e0f325acfmr10086817f8f.56.1717509497965;
        Tue, 04 Jun 2024 06:58:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:124f:b55:b414:cf29? ([2a0a:ef40:641:9001:124f:b55:b414:cf29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064bbb1sm11603854f8f.101.2024.06.04.06.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:58:17 -0700 (PDT)
Message-ID: <396e6893-80d4-48f5-b43f-a30684a64bac@gmail.com>
Date: Tue, 4 Jun 2024 14:58:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 20/29] sequencer: fix leaking string buffer in
 `commit_staged_changes()`
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <cover.1717402439.git.ps@pks.im>
 <48bcd0ac80ee0b60eeda2bcedf55003a5049f289.1717402439.git.ps@pks.im>
 <758f2321-dc63-4209-8b54-99b74b6bb897@gmail.com> <Zl6390B6kUu5TlBM@framework>
 <Zl6_6Z6Bu-zgOmPs@framework>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Zl6_6Z6Bu-zgOmPs@framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/06/2024 08:19, Patrick Steinhardt wrote:
> On Tue, Jun 04, 2024 at 08:45:11AM +0200, Patrick Steinhardt wrote:
>> On Mon, Jun 03, 2024 at 02:14:20PM +0100, Phillip Wood wrote:
>>> Hi Patrick
>>>
>>> On 03/06/2024 10:48, Patrick Steinhardt wrote:
>>>> @@ -5259,12 +5277,13 @@ static int commit_staged_changes(struct repository *r,
>>>>    				}
>>>>    			unuse_commit_buffer:
>>>>    				repo_unuse_commit_buffer(r, commit, p);
>>>> -				if (res)
>>>> -					return res;
>>>> +				if (res) {
>>>> +					ret = res;
>>>> +					goto out;
>>>> +				}
>>>
>>> Having 'ret' and 'res' in this block is a bit confusing - we could delete
>>> the declaration for 'res' and  either replace its use with 'ret', or rename
>>> 'ret' to 'res' in this patch.
>>
>> Yeah, let's just drop the local `res` variable here and use `ret`
>> instead.
> 
> For the record, below is the diff to address this. I'll refrain from
> sending out this whole patch series again for now to only address this
> one issue, but will include it if there are more things that need to be
> handled.
> 
> Patrick

This and all the other sequencer changes in this series look good to me

Thanks

Phillip

> diff --git a/sequencer.c b/sequencer.c
> index 9e90084692..cc57a30883 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5253,7 +5253,6 @@ static int commit_staged_changes(struct repository *r,
>   				 * We need to update the squash message to skip
>   				 * the latest commit message.
>   				 */
> -				int res = 0;
>   				struct commit *commit;
>   				const char *msg;
>   				const char *path = rebase_path_squash_msg();
> @@ -5266,22 +5265,22 @@ static int commit_staged_changes(struct repository *r,
>   
>   				p = repo_logmsg_reencode(r, commit, NULL, encoding);
>   				if (!p)  {
> -					res = error(_("could not parse commit %s"),
> +					ret = error(_("could not parse commit %s"),
>   						    oid_to_hex(&commit->object.oid));
>   					goto unuse_commit_buffer;
>   				}
>   				find_commit_subject(p, &msg);
>   				if (write_message(msg, strlen(msg), path, 0)) {
> -					res = error(_("could not write file: "
> +					ret = error(_("could not write file: "
>   						       "'%s'"), path);
>   					goto unuse_commit_buffer;
>   				}
> +
> +				ret = 0;
>   			unuse_commit_buffer:
>   				repo_unuse_commit_buffer(r, commit, p);
> -				if (res) {
> -					ret = res;
> +				if (ret)
>   					goto out;
> -				}
>   			}
>   		}
>   
