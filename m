Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296714F61
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt7/JsA1"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F7A3A9E
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 06:08:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50906f941so41764381fa.2
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 06:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699711687; x=1700316487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2cFouVTuEQcl7+HEppv1i7ANZ6XcTiTihyyqjE4axI=;
        b=Zt7/JsA1MPcCURejl2gmfB32PdmUlqkro5kGP6ymWPfggXIIVFhIROIMxISnDnyicM
         suCwHqZCeyGXpqxa//ud3vPae0QyUIKYpyXfAYxsyA4Q5t050Ge/cxD/fb3waf1rMTb0
         ZLLdNozx4CTYGHljeYvH7tgmNBDcoRFxDSxP99Xc1ig2ZonLpFaberhiMEKkGmw7GxLe
         W5zvKTLwp3b8siWvRjMCK+Ub7M3oWKueVypjQE5zLvMZjeKjKCWsVlLTu6VXATSwUAJv
         DEYg8oxSZjt8hX9CKzxd03mtshrn7S6jT+wKwjnFP45030RSD/1N+zM8yoTK1CljcqPC
         Ydig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699711687; x=1700316487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2cFouVTuEQcl7+HEppv1i7ANZ6XcTiTihyyqjE4axI=;
        b=RVZNOsrQWPRwf4Dr0nszm5ScOf2NB0fz+o/561bvgruR2tJhbtMTVMe4j0LKckteB3
         /DMlUgPkk+1HRnSqMFups/v7jM+NJf+EjIGlNg1KbXsOzclAJAnee0Mo5hc6+Nrp6NkH
         Ysp8XRDTNk9X/cMDCSLvR+g5OeX1SSg4Ew6Q6lM4kq/9Pd4IojvAh/67OOhVMgDXiH/b
         RViwJDNPzgNMhsjcQFcgIv7HJV8z5p+5EZnWcid8XVoC2r/pAFe7TLyvux8SWS3oiU7n
         P3FTe3hpW5YxH7ykdd72j0pkk7gk/NeZGynLjOSnDR6aa7WWa8qyr16u7wnqmhe8+VnI
         2mKQ==
X-Gm-Message-State: AOJu0YybqzZP3VZjAuDLyuQskTX7svDtmEMWWII/Unlwsiy7ZQT0HY3g
	hSxUyFtOGU/x5vvxSfumLlPC1dLy7QsfoA==
X-Google-Smtp-Source: AGHT+IFE2ZO1cvdk8/rA0TpQNslRCfc/SIr4213ritSf6AqSlFy3I9WVxlEQeT+iRnKQ1lkYQyHPPw==
X-Received: by 2002:a2e:b528:0:b0:2c5:2184:c53d with SMTP id z8-20020a2eb528000000b002c52184c53dmr1308047ljm.25.1699711687055;
        Sat, 11 Nov 2023 06:08:07 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id g26-20020adfa49a000000b0030647449730sm1566678wrb.74.2023.11.11.06.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 06:08:06 -0800 (PST)
Message-ID: <8dba0a09-d5bf-46b8-835b-9855f4f4326a@gmail.com>
Date: Sat, 11 Nov 2023 14:08:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rebase: support non-interactive autosquash
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231104220330.14577-1-andy.koppe@gmail.com>
 <20231105000808.10171-1-andy.koppe@gmail.com>
 <8c2bb219-127c-4128-99ed-158bc64b1dab@gmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <8c2bb219-127c-4128-99ed-158bc64b1dab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2023 11:06, Phillip Wood wrote:
> On 05/11/2023 00:08, Andy Koppe wrote:
>> So far, the rebase --autosquash option and rebase.autoSquash=true
>> config setting are quietly ignored when used without --interactive,
> 
> Thanks for working on this, I agree that "--autosquash" being ignored 
> without "--interactive" is something that we should address. I think 
> there are several possible solutions
> 
> 1 - make "--autosquash" imply "--interactive". This has the advantage
>      that the user gets to check the commits are going to be reordered as
>      they expect when they edit the todo list. It is hard to see how to
>      accommodate the config setting though - I don't think we want
>      "rebase.autosquash=true" to imply "--interactive".
> 
> 2 - make "--autosquash" without "--interactive" an error. This would
>      prevent the user being surprised that their commits are not squashed
>      by a non-interactive rebase. Users who have set
>      "rebase.autosquash=true" would have to pass "--no-autosquash" to
>      perform any form of non-interactive rebase. This is similar to the
>      current behavior where the user has to pass "--no-autosquash" if
>      they want to use the apply backend with "rebase.autosquash=true".
> 
> 3 - make "--autosquash" rearrange and squash commits without
>      "--interactive". This is convenient but there is a risk in that the
>      user does not get a chance to check the todo list before the commits
>      are reordered and squashed. I think that risk is fairly small with
>      an explicit "--autosquash" on the commandline. This is the approach
>      taken by this patch. I do have some concerns about extending the
>      config setting to non-interactive rebases though. If the user has
>      commits that look like
> 
>      fixup! foo (HEAD)
>      foo bar
>      foo
> 
>      and runs "git -c rebase.autosquash=non-interactive rebase HEAD~2"
>      then we'll silently squash the fixup into the wrong commit due to a
>      prefix subject match.

Good analysis. My order of preference is 3 (obviously), 1, 2.

>> except that they prevent fast-forward and that they trigger conflicts
>> with --apply and relatives, which is less than helpful particularly for
>> the config setting.
> 
> The behavior to make the config setting incompatible with the apply 
> backend was implemented to avoid users being surprised that their 
> commits are not squashed by that backend even when they have set 
> "rebase.autosquash=true"[1]. I think one could consider "--autosquash" 
> being silently ignored without "--interactive" to be an oversight in 
> 796abac7e1 (rebase: add coverage of other incompatible options, 
> 2023-01-25) that introduced that change.
> 
> [1] 
> https://lore.kernel.org/git/pull.1466.v5.git.1674619434.gitgitgadget@gmail.com/
> 
>> Since the "merge" backend used for interactive rebase also is the
>> default for non-interactive rebase, there doesn't appear to be a
>> reason not to do --autosquash without --interactive, so support that.
> 
> I think making "--autosquash" on the commandline work for 
> non-interactive rebases is reasonable but I would be open to the 
> argument that it would be better to make it an error and require 
> "--interactive" to allow the user to check that the commits are going to 
> be reordered as they expect.

I found that once I got used to and started trusting the feature, 
particularly in connection with the corresponding git-commit support, I 
no longer felt the need to check the todo list as I'd inspect the log 
afterwards anyway. And of course there's always resetting to ORIG_HEAD 
when things do go wrong.

So I think users should be trusted with this, especially as it's not a 
particularly dangerous feature, given it requires the squash markers to 
be present in the first place to do anything.

>> Turn rebase.autoSquash into a comma-separated list of flags, with
>> "interactive" or "i" enabling auto-squashing with --interactive, and
>> "no-interactive" or "no-i" enabling it without. Make boolean true mean
>> "interactive" for backward compatibility.
> 
> Please, please, please don't introduce abbreviated config settings, it 
> just makes the interface more complicated. The user only has to set this 
> once so I think the short names just add confusion.

Duly noted.

> I also think 
> "non-interactive" would be a better name for the config setting 
> corresponding to non-interactive rebases. Does this mean the user can 
> request that commits are only rearranged when they do not pass 
> "--interactive"?

Yes. That doesn't seem useful.

> As I said above I do have some concerns that the 
> "rebase.autosquash=non-interactive" setting will catch people out. 

I think you're right, so I've gone back to interpreting it as a boolean,
but officially make it affect interactive mode only.

> Having said that ignoring "rebase.autosquash=true" without 
> "--interactive" as we do now is inconsistent with the behavior of 
> "rebase.autosquash=true" with "--apply". One possibility would be to 
> introduce "rebase.autosquash=interactive" which would not cause an error 
> with "--apply" and always require an explicit "--autosquash" on the 
> commandline to squash fixups without "--interactive"

I don't think different error behaviour is worth a separate setting, as 
we can't change rebase.autosquash=true to do auto-squashing without 
--interactive without surprising people.

>> Don't prevent fast-forwards or report conflicts with --apply options
>> when auto-squashing is not active.
> 
> I think this change deserves to be in a separate commit (which probably 
> means separating out the config changes into that commit) as it is not 
> directly related to fixing "--autosquash" without "--interactive" on the 
> commandline.

Done in v4.

> In summary I like "--autosquash" working without "--interactive" but I'm 
> unsure about the config changes.

Thanks very much for the thoughtful review!

Regards,
Andy
