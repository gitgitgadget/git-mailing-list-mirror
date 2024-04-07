Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A53A260
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712502754; cv=none; b=u0RR1yZNBEdj8jqAHhVmd7z5NW8NhEjAcvRz92+dLObAaEBvAngMjz4HJf89wK0vklnAC9UjzCx9xVE9mbEGW64Zj4ruoD7KPztBgXqpx1xBvhUOuL+pMV/kgZcyvfXOnthckB/3Lfb8zPWYF7UYB9NtNaNPDB82lZtttQOY1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712502754; c=relaxed/simple;
	bh=23Vx+e0iop5J6NvP9s7ZJgi+1WQttyFuouaEzRRh908=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JAOpmNvzwbGC0ifynRaJIFnFescrXcSzcmSyhRnW27JO9vFNG4cOf1T04TNNfLL8K3plQg8z9DgVMN+LC0/qhSmwrb8v4ATn9SJVUBPeCvn+VClqOPL5YUwPdxtyGwvHnyipjpG52B8Dx+t52XHX8FO3/GoOkgSzUsRLNL2+lO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvwLK1bh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvwLK1bh"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso2156719f8f.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712502751; x=1713107551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IgWBx+cmnVx2mHfq1Ary02kQloKjdjNCPlKXdwNU20=;
        b=CvwLK1bhortZIGoLDk8sBzofi3iC0y7BXiAQ6CzafIQQUgVzyNAu3kPhmyQ40M4a7O
         vpbR2Zb0cq4l1ttbKNQUsF3IDYWZ2O+cPsxgnv+eQ0IcDEQGWlV8Fh/YyOh/nSOKXgbp
         A8iVwUabrCF2HDcZG++Y8k6XNv5Hs7241HGjffqMZhttDyAk6aNDgmKLd5oLKZCU7LKv
         nyTw2/lWcAuM5uZB+/T35EGOmIAuecUk9+MwcncihHX2nMMdhMwuru/4iDR5hZsKpnQo
         8sg+5MS1Yx9gtn0y1BSofjZx+6eN+wXdk8ui8znzoQzgB2oX0KkcI50pN+3m8T5zF3xq
         SCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712502751; x=1713107551;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IgWBx+cmnVx2mHfq1Ary02kQloKjdjNCPlKXdwNU20=;
        b=gtbv1gjW/u3B95bOi9BHz9U7jvkJsvG0FEPyDd4kKJ3xgBDJ9KxQLsY2Ek4+fAnCkL
         TojJwg/IxtAa0s9Y4xDLVwGYuVlKPVLe0zVlf8uF3cuzkXF5u04c5oNxRJdlrTMxW7lr
         EofVwU2wQ2x8kGqn/Vw6GXMFsRwa4lpMRfMEisGcHs/GHUuVzR7q5PDaAEq4HbcsRQgj
         UmseNIPHsmMMxF6ga2mhUXiq/cuNxCV1ZlXugo1E42eG9q1ZkSeV9g5CT95n/k2QxJ+I
         VcGQL7QL+cdu+dR4osif/Jh4zsWWPYX7vWEQ/BgM6HnP380bu9q9zKcnpXi6C3yYcIOp
         gekg==
X-Gm-Message-State: AOJu0Yx2CqWnAPvELfWyBAUQNb3nvVU7nsjCjY+fLxgxGFe/jf7KrLxI
	d+9sqqCYejyltghUx3n1YmWRQBXkdO9XI1yfcCj1LJpDQtmr09HG
X-Google-Smtp-Source: AGHT+IESaFo1kXDdfQPsm0+17n6ivi8161aQtHXJ3nsTh06QEalWpw4rxe9DR1UxcKgIoitv2ndyNA==
X-Received: by 2002:a05:6000:ed2:b0:341:ddb5:badc with SMTP id ea18-20020a0560000ed200b00341ddb5badcmr5061629wrb.19.1712502750689;
        Sun, 07 Apr 2024 08:12:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b00343300a4eb8sm6810862wro.49.2024.04.07.08.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 08:12:30 -0700 (PDT)
Message-ID: <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com>
Date: Sun, 7 Apr 2024 16:12:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Olliver Schinagl <oliver@schinagl.nl>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
 <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
 <d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
 <2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
Content-Language: en-US
In-Reply-To: <2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2024 15:52, Olliver Schinagl wrote:
> Hey Phillip,
> 
> On 07-04-2024 16:09, phillip.wood123@gmail.com wrote:
>> On 06/04/2024 20:17, Olliver Schinagl wrote:
>>> Hey Phillip,
>>>
>>> On 06-04-2024 15:50, Phillip Wood wrote:
>>>> Hi Olliver
>>>>
>>>> On 06/04/2024 11:06, Olliver Schinagl wrote:
>>>>> On 06-04-2024 03:08, Junio C Hamano wrote:
>>>>>> Olliver Schinagl <oliver@schinagl.nl> writes:
>>>> If you search builtin/bisect.c you'll see some existing callers of 
>>>> strbuf_read_file() that read other files like BISECT_START. Those 
>>>> callers should give you an idea of how to use it.
>>>
>>> Yeah, I found after Junio's hint :) What threw me off, as I wrote 
>>> earlier, get_terms(). I wonder now, why is get_terms() implemented as 
>>> it is, and should it not use the same functions? Or is it because 
>>> terms is a multi-line file, whereas the others are all single line (I 
>>> didn't look, though I see addline functions for the strbuf functions. 
>>> Should this be refactored?
>>
>> get_terms() wants to read the first line into `term_bad` and the 
>> second line into `term_good` so it makes sense that it uses two calls 
>> to `strbuf_getline()` to do that. It does not want to read the whole 
>> file into a single buffer as we do here.
> 
> Right, but I why not use strbuf_getline()?

Because you want the whole file, not just one line as the script name 
could potentially contain a newline

>>> So with the name, I started to think some more about it, and after 
>>> playing with some names, I settled on 'bisect-post-checkout'. Things 
>>> then sort of fell more into place. It is still a hook/commandline 
>>> option, but it's a much smaller change (since we don't have any 
>>> special code to check the exit code anymore) as we can (obviously) 
>>> run `git bisect skip` instead of `exit 125` as well of course.
>>
>> Does that mean you will be starting "git bisect skip" from the script 
>> run by the current "git bisect" process. I don't think calling git 
>> recursively like that is a good idea as you'll potentially end up with 
>> a bunch of "git bisect" processes all waiting for their post checkout 
>> script to finish running.
> 
> Well the process is inherently recursive, though that's up to the user 
> depending on what they put in their script of course. I don't think git 
> is 'waiting' is it? In that, git bisect runs the command, the command 
> runs git bisect, git bisect stores the commit hash in the skip file and 
> 'exists', which goes then back to the bisect job, which then continues 
> as it normally would.
> 
> So technically, we're not doing anything bad in git, but a user might do 
> something bad.

If I understand correctly we're encouraging the user to run "git bisect 
skip" from the post checkout script. Doesn't that mean we'll end up with 
a set of processes that look like

	- git bisect start
	  - post checkout script
             - git bisect skip
               - post checkout script
                 - git bisect skip
                   ...

as the "git bisect start" is waiting for the post checkout script to 
finish running, but that script is waiting for "git bisect skip" to 
finish running and so on. Each of those processes takes up system 
resources, similar to how a recursive function can exhaust the available 
stack space by calling itself over and over again.

Best Wishes

Phillip
