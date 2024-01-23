Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBA7FBAC
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028046; cv=none; b=dyQ7MGiTlzrd0WZjzqquQliYDl8axtAjg7NkOivLaYnfDnyRzHbalFVeWviJ+hZAXXNRoNJD3U9lC/fyYHOaFvQS1occsddlCozYogRKSMFQkyN1I7nuCdCXxC410hIu2lOUkGxahFEE0keMWyINND+p6ErxK4P3Fkp+5CHUASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028046; c=relaxed/simple;
	bh=CUp9L3SNACWUXj5gvfJ/q8X3a7A3bvNnI5dZH+3xnLM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F1aY6YX+dJIa9C4hkBQ8XwWf/lrMl6n75ANbJKHV2HD1IYE2uUMLW8hTXLNPuuus6fgIqjajY34xEbMcIPw3z7uDQfuXd8X6jgJNi7azUQpKM6ShSqcG3cro0or6BJTGfu3ORDstm8q/jmOApjwQbK56m8UvnG/nwgeDuP7sasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBy0qpX9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBy0qpX9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337d6d7fbd5so3303810f8f.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706028043; x=1706632843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=inbe/sntK4G7sP8MB84nOUo3m6RvLYcx/2M+K1EQ4DU=;
        b=XBy0qpX9yqGBmIuv04NWm5drlxrWNPEMXJDkoolDXIxKqzGacERNyyHZHYg7iNwpWt
         +DxaobLLy7qeL7eWDMPeMW/NEmUz++xo9K2P4niQMAoIUkQQgIzbfx243oUFqiWkHxjl
         dpjVnVB44a+iVe4y5IH7t+dCp3ROcKj+R8MaJMi+Jn//B16NAMqMVWRPneiNwkwjDZze
         5ziZvWx3GBXwXeONPjCSRSuyKbYuQ12UMNXNDa5vZ6lsx7IxtEW3m4lCbaeWw1LHDc3a
         ki+bsPOnpOgihHQ34PSOBlMp2uHPe6YuUwKPdI8GJ3biYCFiLYgfTH1lB7wkodWBX9Pl
         hORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028043; x=1706632843;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inbe/sntK4G7sP8MB84nOUo3m6RvLYcx/2M+K1EQ4DU=;
        b=gQJYKHV3OXAPggNq8O2epmzNydNrz5O8ZcsolPfwpWQyjPByy00LTnLTNv3bisDkO8
         WTGy7ppBn7dEa5JHEWm4eGA/gTUz3KL4WQ3UFzWqMA74fvO+rqy79RDX0/opD0DaaYa5
         3cKlqcfOoSb/vC9ztvCKwMKeX/wxyBMHRun7l9dN8zsgypK1JdBZoFTQR42SnZiTuvB6
         ELkbyto8SKuIjUzIUBfOrSHzqxCAZQS3WQv9g2BqHH7A+kfD4aF9NJe/z52T74oiZJL1
         TMNV2CX9O7nKSXUZRgj6Dxf7nkkTIvUFbtLS4sydLon7sIud5DfA7FeWRRDy9Veongau
         5pkA==
X-Gm-Message-State: AOJu0Yyzg7MA2jIk8lnmlOKfKcGOpzyb+/XWc+5cALMPNgU6QUNOedbv
	0yowL08tEpw0uKFd/Qjkp0/HNBhoqFFDfJhWdufgl+nxXSc04bZE
X-Google-Smtp-Source: AGHT+IH4Qu62YgRJ8JUUYM8A/kIkzugpauMw8ExaUyhNWjWnzd/x64qG12Rl42vgiI8ontF81JZqiQ==
X-Received: by 2002:a5d:65d0:0:b0:339:396c:5839 with SMTP id e16-20020a5d65d0000000b00339396c5839mr1860177wrw.16.1706028042761;
        Tue, 23 Jan 2024 08:40:42 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b003392d3dcf6dsm7612360wrt.0.2024.01.23.08.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:40:42 -0800 (PST)
Message-ID: <ffb41e0f-f787-439a-9afe-8dcda5da21a3@gmail.com>
Date: Tue, 23 Jan 2024 16:40:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Content-Language: en-US
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-3-karthik.188@gmail.com>
 <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com> <xmqqplxtrucm.fsf@gitster.g>
 <ba721840-7b67-4822-8046-c0da4d3b9bde@gmail.com>
 <CAOLa=ZQOcqGBJOSehok4BYGUE8RKtnE9eiJYogeT8E6NWZ25xw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQOcqGBJOSehok4BYGUE8RKtnE9eiJYogeT8E6NWZ25xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 23/01/2024 12:49, Karthik Nayak wrote:
> Hello Phillip,
> 
> Phillip Wood <phillip.wood123@gmail.com> writes:
> [...]
> So there is no way to make `is_pseudoref_syntax()` stricter without
> breaking backward compatibility. While we do want to reach that goal, we
> have to go about in the other way around, that i.e.
> 1. Fix all pseudorefs to have the '_HEAD' suffix.

I'm wary of renaming user facing pseudorefs like AUTO_MERGE. In the 
future we should try and avoid adding any without a "_HEAD" suffix

> 2. Move bisect files to '$GIT_DIR/bisect-state' (see [1] for more
> details).
> After this, we can safely make `is_pseudoref_syntax()` stricter.
> 
> Given this, I think for the next version, I'll do the following changes:
> 1. keep `is_pseudoref_syntax()` as is.
> 2. introduce `is_pseudoref()` which calls `is_pseudoref_syntax()` and
> also checks the content of the file.

We could perhaps make is_pseudoref() stricter from the start as we're 
adding a new function, it could have a list of exceptions to the "a 
pseudoref must end with '_HEAD'" rule like this patch. Being strict 
about the pseudorefs we list with "git for-each-ref" might encourage 
users to update any scripts they have that create "pseudorefs" that do 
not match the new rules without us making any changes that actually 
break those scripts.

> 3. replace use of `is_pseudoref_syntax()` with `is_pseudoref()` in this
> patch series.

That sounds like a good way forward to me, lets see if Junio agrees.

Best Wishes

Phillip


> [1]: https://public-inbox.org/git/20240119142705.139374-1-karthik.188@gmail.com/T/#m6e3790e30613fd68349708faaf5f4d9c704ba677
