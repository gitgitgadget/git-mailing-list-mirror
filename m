Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C739FCD7
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418705; cv=none; b=mY+vQwDHFX6p1lnh1s5w0IhwiPylQMhL0bN/Cyvw2irNG7LY/LLFXkZFQb34v9tS4vPjpFtJrFZDDUtih1ri7euX1hsBfppcHobZAJGohjEG2rknFGaqwnO8gSNu75zE6YFqkr2NnYL8Bu6gb8IXqEotyiTTMoDc3ZAliIzlpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418705; c=relaxed/simple;
	bh=vRenIEK56IP6wxiGtv/GFw50h0YBvgF/6doH8GNwWTw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g0EqOkj9GBRQIghb6dAbxUBn0/XGH0FYzPXlFvDFdscjeI0Ipziirouwsdd7DgDjbopna+407UlunyrhHbue1nPi/AAOZhjAi7xc2KiWNgHWO0PuzZYH4gbCZWCcJ86k7cKSWqWpXFD7P7SH2a8GVJXxhe6biJF43LAYXnUe+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxWgXx6x; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxWgXx6x"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso5826805e9.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776418702; x=1777023502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nj9DslI+NsDfJdY6DIKb3gc4J059xUELqBPkkaL8hEo=;
        b=TxWgXx6xoDa34GP6HXA5o+PYS4janRrzjZy0m4vra55FR0Gj7yJ31/NWB6JbQRkD/B
         nh560/gHzCzcLDgaT3/Ee4LpYHaTRrNJgC22co5PZ9oFAyOel/fPit8G8gtDEz8wDaLV
         r6PsHB+bTu25O2Glpes8JrWubREP+qOffAwZHylqBlxqG+uX2zuwp9/tIBUPo2N6n50D
         AL1pCgJcA7/2qsvLm9sciaCyOov5qHQPlh1QDkGT7gUG1w+pI4e8PonYLIhVEg71nOKa
         IzLjXcqgRMy4kBo5XyBin+uJMmdC0mgEcHrLmYn1+TCrWmIsYvypfbDyZ5wAscM9/znc
         IYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776418702; x=1777023502;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nj9DslI+NsDfJdY6DIKb3gc4J059xUELqBPkkaL8hEo=;
        b=V8In0akwwgKFkq6NRDbH+NKd6CdhhXs4fnx1oTbYu/y+JkFQMgONlYugJJVvH5njJq
         1+ICurQCoYbdGH7jKuWnEDkozGh3H+ZKnamjCUtfcOQ2rxhLqT0fRc10/RPVbhJCg1s0
         Og/sLwsfMdqW3H4Y+Tcddek356R1g7Vev+WoCK+pbRDSlpenJ6XL+443ohc5cCDiQuGz
         JGXHOA4nQIyV/PknGEj0JE2kQlR6Gxu+6KGUp4gMzXFPa/Xb2nYkPLJJ3YdjV7HK9cU0
         R/FP85oLOdadYtTw5WtrfJBZoRY8/N5wf7+vCRnsB2HJq9M1OBafr378KegJhw+e7h1j
         Gs8w==
X-Gm-Message-State: AOJu0YwHkdj9LLe7sMQlA2KTcKizR6dqB6ni0ArHPsGjH9Bsj25uCtIL
	y2jVBQ0qwgyDTb9kcJlH4SL5SyX7SEbtO77l1zOu8e1/0Tw0DGMAKEcBjZmZJg==
X-Gm-Gg: AeBDiesPorshWbAPfR/O63kTFnsmk4PS2eeM/654NCWq71+NT3ZbQKY6KhbxIokPXSI
	sc7brdWGUZtMg8cRSWkSbJz9FS2P4mHwsWUgeAnv5nBCsqP/mqd8SFfvCOu9cg8q1aEvxF/x3SP
	BTUzr6gRRJ+z8G0+Fl5+2yORJTz3xap1iiYkdzA7CAUM4ECDwuHXAlReBXvPja1VvpwPaDJc9hV
	hhU9ZOmnEiL0HShj7DAvsS2GOh/UpE4sBC5mPAmHML8ADuyYtf/CzrF6O47BeL9KSTLle8gOssW
	ZCBjO8zVMwV2/8xCkBaoBRzyx13DcuiIF/7CdZzBgaMLEPem/+Ii7sO3l48smcQSoZ3IGrJu9nO
	X5NTk37+KFT6jVESYaNvxL/szh3uScBjj9WeSPA1ZoSiw7PzSWxqIN01Rks3Yk17d/FAY/unGgn
	8WhMpWjRZG+72kID3og0IJqAXRgcn3JLf7CdpPXVazIdQ3yzqf+t5yARAh6dNZmYvJy4RC0Jx9/
	fTZ6TRz29JAqkQe6sI6ex9z
X-Received: by 2002:a05:600c:5252:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-488fb768483mr31871645e9.18.1776418702003;
        Fri, 17 Apr 2026 02:38:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf7besm14412905e9.34.2026.04.17.02.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 02:38:20 -0700 (PDT)
Message-ID: <9f46e619-2f34-465f-8bb8-6688f8b56cc0@gmail.com>
Date: Fri, 17 Apr 2026 10:38:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] worktree: add --recurse-submodules support to git
 worktree add
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 Jimmy Aguilar Mena <kratsbinovish@gmail.com>
Cc: git@vger.kernel.org
References: <aeEMU-ohKz2tnSWq@RTX> <xmqqzf3225u1.fsf@gitster.g>
 <19b86e02-6842-42f0-8226-c86ad6669ec4@gmail.com>
Content-Language: en-US
In-Reply-To: <19b86e02-6842-42f0-8226-c86ad6669ec4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/04/2026 19:38, Phillip Wood wrote:
> On 16/04/2026 18:05, Junio C Hamano wrote:
>> Jimmy Aguilar Mena <kratsbinovish@gmail.com> writes:
>>
>>> The approach follows Phillip Wood's and Junio's feedback: each linked
>>> worktree gets its own per-worktree submodule gitdir under
>>> $GIT_COMMON_DIR/worktrees/<id>/modules/<name>/, so HEAD, refs, and
>>> the index are independent per worktree while pack files and loose
>>> objects are shared via hardlinks.  The gitdir isolation is the same
>>> model git worktree already uses for the superproject.
>>
>> I do not quite follow.  The point of git-native worktree support
>> (which improved a lot compared to its precursor, "git-new-workdir",
>> is that it can work well in a hardlink-challenged platforms.  You
>> shouldn't worry about "hardlinking" yourself at all.
>>
>> After the superproject successfully did "submodule init", you can
>> move the submodule's repository with "absorbgitdirs" to
>> $GIT_DIR/modules/<submodule>/ of the superproject.  The primary
>> motivation behind this feature was that you can switch to a commit
>> in the superproject that does *not* have the submodule bound to it
>> at all (and obviously you do not want to lose the submodule
>> repository only because you tentatively switch to such a commit and
>> have to re-download when you switch back), but I think it gives the
>> single instance of submodule repository that you can share across
>> worktrees of the submodule.  Because the single directory created
>> with "absorbgitdirs" looks like a bare repository, you should be
>> able to create two worktrees off of that, with their own HEAD etc.
> 
> I haven't thought much about it but that would mean that "git worktree 
> remove" ought to remove the submodule's worktree when the worktree 
> containing the submodule is removed. Worktrees avoid hardlinks by 
> creating a "commondir" file in the worktree's gitdir which contains the 
> relative path to "$GIT_COMMON_DIR". I think we could probably do the 
> same here and create "$GIT_COMMON_DIR/worktrees/<id>/modules/<name>/ 
> commondir" containing "../../../../modules/<name>" if we want to store 
> the submodule's gitdir under the worktree's gitdir. That way removing a 
> worktree's gitdir removes all the gitdirs of its submodules without any 
> extra effort. There are probably other tradeoffs between the two 
> approaches that I've not thought of.

I've realized that creating the submodule's gitdir under the worktree's 
gitdir means that "git gc" running in the submodule repository wont see 
the per-worktree refs and index file and will happily prune those 
objects. Junio's suggestion avoids that problem.

Thanks

Phillip

