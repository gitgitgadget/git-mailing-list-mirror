Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C339B960
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119283; cv=none; b=cg7Cmi3h6n5uCjzmJ0e2Cu88tRdoR7yZrJGQGf7uh0wV9SzybzMZ0TZYcnAbfdMZMBH1frbDvIuo4BS6Ug/AE+MWCEueLldA3xymfNKSovRoyM7CfYrK/AGF49ZXVkPpeuaXcNYWZb+ZM6RAy2msTUA+Td+qpm/t4jzXkyqDbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119283; c=relaxed/simple;
	bh=2K4EF/MGZifH4slEA4MvX4CBsbatiI+/beInqpLiul4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZUUYoRjC78+IxFqg1NIFDvzimXyMb+K1GvcHhCS+15JAtZP1DkG6BSk0AzcnBCUqaLQuwIpHEnAkUwaR3Du997PY6cpPBQLTztd1P3vhJdhh0hPrtvhy5+ARQ+MJfXADuDMOcd4ZRIK034rH/kzYZCxtHljdSP94OxM8Ya0mFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUIyD4Fj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUIyD4Fj"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c08acccf4a4so413440066b.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782119279; x=1782724079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGCT261MCpeGLv9CqwWZ4Kw9XiocU/OVFUMWWSHZQsA=;
        b=ZUIyD4FjZU2iIjSrnAOjRiuUCFVRXmezn2dHenFknRVmFHdFMSPQldsueUCLAgTC8B
         7iDWU6TVWvedH1ozSxBy6e4QziVb/U4WIFLhYDFM8lTcWTDrXVsEzL1QmuqbngfBs8Hh
         rR8EDxRWhDplt4sosGNnl8FHCl/Tj6pZwLLFgWkCbuOLxVVsjhJxqw2GbtJhOPfZpJhF
         x4XTHMPzwUA07ofk5s7x2+mqUWD6FqOW7YV3DCSpAhpSMkZmHwKZJV0vjuXTVRpflcEK
         b1btuI2EZ8XUh2fYB1fk25TLaWEONRoTGZLeCAbC7PK7hMplOzE+Gu6wgIQkaBL6SU9M
         FT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782119279; x=1782724079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGCT261MCpeGLv9CqwWZ4Kw9XiocU/OVFUMWWSHZQsA=;
        b=HhPst9lSu6LLJ3FGmg8E4pCm7fQn68O+pFWRuKIUckE14h+RYFZVCN+GfVkCn2h/Dv
         bUHS5DUNeNBKeT7ukdSdXWgUHO8Ni2wxUx14u4xgxefkNu5opeWofR2ibWEeyK+IWren
         JvuU6rRhLIA5ln9bYQ+vT4tuHu/r9oqTgQ/LQtwyMMMlsg/XqDeRhPPZIW/D5YdHiqwQ
         qNkzYNzrgj8H9aMfH1H97lHNm7rkGUvN9qs3nfM8CTi/tU/FZAmiqz2k2Bsbax0cyp7M
         SnDBvM7EluTjeub3AATbdgwf4XhRbwEuGGalP+2aTFzgz3zi/xv8IFSDU+oTnkAck+fR
         0z2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+k9wl72nGzLdx1D1vLfgSIqEECOdG7qyj2aNU3LkCT82VYUsHmVbKLh8y8H0Jgwih+4Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRmZ+KWYhvw++LEzqNCJzpFuYeg5Z75IObXZcXQdA0wcY4+8n
	sIhCBiqnTuotSH0keCoonYtU0gawf3TAAj6LRY04bsjQcOJ6hTkRD+ve
X-Gm-Gg: AfdE7cmTlgnR512ElkZ4cIe94leFQcznfbMPNeqWGvCecdk0zy0cPKYiM6Uy5perPMw
	NPy2IuFpK8WUDtqKH+9uJtLCdxB2dRdrvf6LycgDU6Rx5WLR1IFRpflSQhw0suhztahGz7NnrDk
	lYk89QrCKGADo3b6MsbfD9WE0I6th59k5xq32dx1F9B7+K9IqPWjnWqJbWPp84lq0czPl378Vyl
	BNtU+9Bl/fE37yIrkh+a7FH+9ZaJdtoXNEOVehqiep2jLysEf2l0ZB1NV/OHtcYZPcB9jJqOVbO
	5tiX/aXfOT/zUq5MIbKqkN94fsT6wd5+JUNv9Bc5Ril+VU3nmY2Qu37KxZWLXDo8IN7ocmJoCS9
	j5AJ+3+lKBJv5VbJJeQ5yj0n0dYm5KjnROYn+47W4AnoLXbM8mCSb5TTslTGJdyv2cZJmdeOc9l
	T98i34z4dhX3qCYD1duK7i1X34Eg+w30uiNlwz2Dsd/o29z9bDFxOd9BVxnpk/Yik+rnZcag==
X-Received: by 2002:a17:907:9483:b0:c07:a892:8df2 with SMTP id a640c23a62f3a-c0b601ea88dmr658315466b.7.1782119278815;
        Mon, 22 Jun 2026 02:07:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e498ce1sm315514966b.3.2026.06.22.02.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 02:07:58 -0700 (PDT)
Message-ID: <55a8cc56-f015-4a1b-b830-79cf24870286@gmail.com>
Date: Mon, 22 Jun 2026 10:07:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
 <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq33yimsdp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/06/2026 17:01, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>   - Notice that a branch that is deleted (because it itself is
>     merged) is still depended upon by being @{upstream} of somebody
>     else, and when it happens, fail the operation (i.e., do not
>     delete the branch).

Not deleting is definitely the safest option. As Harald has pointed out 
we then need to think about what to do with the upstream branch of the 
branch we're keeping because it is an upstream of another branch that's 
not being deleted. Keeping the whole chain is probably safest.

> What are the viable choices we can offer to the user in such a
> situation?  I think there are a few viable choices.
> 
>   - Make the dependent branch no longer depend on anything.  Asking
>     feature2@{upstream} would fail.
> 
>   - Move the @{upstream} of feature2 to the branch that "merged"
>     feature1 and caused its removal.  Asking feature2@{upstream}
>     would answer origin/master, which feature1 was removed after
>     getting merged.

The second option is quite tempting. My only concern about doing it 
automatically is that it would break "git rebase --fork-point" (which is 
the default if you don't specify an upstream). If a user rewrites a 
branch, merges it and then "git branch --delete-merged" deletes it and 
reassigns the upstream of the branches descended from it, rebasing those 
branches would pull in some stale commits.

> There may be others.  And there may be relationship similar to
> feature1 vs feature2 that is not @{upstream} but something else that
> makes a branch still "depend on" the other branch getting deleted.
> 
> Do we also need the same safety around "git branch -d feature1" by
> the way?  The "-d" option with safety checks the same "is feature1
> already merged (to its upstream)?" condition, so it can protect the
> feature2 branch the same way, by saying either "oops, you cannot
> delete feature1 because you still have other branches like feature2
> that depend on it", or "ok, featur2 used to depend on feature1, but
> because we are deleting feature1 based on it being in origin/master,
> we will make feature2 depend on origin/master from now on".

I think handling branches that are the upstream for another branch the 
same way for "git branch -d" and "git branch --prune-merged" is a good idea.

Thanks

Phillip

