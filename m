Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FA349CEF
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160106; cv=none; b=VIhC8Vhp4RKK0i3f93xzM0JWiIqvxeyEPsRTef+e6sT9jZQfjqh1bt1zsA4QAMGYXLJWx84qoTsRmGMk6jo4bFVQNcxl5T9w3XvuRCd2aBbhm+20mgxGR61buQQGGJ+wtp7Az53J+gkDUgxV2e5ap2VrfoWk5b3A2aaqDjhHDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160106; c=relaxed/simple;
	bh=CzLDJTix7qNr5/w9ubsFXG0esXvIPkZ3zp4654dmF0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1RJD4rqLkWdgn1VX6+WXuFqXFaAJiRUEYZ1l+IRwLeMjZHKQjjI0t9lJBV41bzqE906kR2Nf3eQsc1TvT564eswepHB6bK3IKIzvj8HSr9tKGEtPDMe98aPanpBVrAtJ/2cappraUJJXZBhL7dun4qek16zLrNs5RSzciAMHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N01qoRxx; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N01qoRxx"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6efdb57db0cso1473563137.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782160104; x=1782764904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54f0swcPw7+TdXC+Nf2IgC91nKxBYET45t1TEwUaxgE=;
        b=N01qoRxxBPF425U416XdNt1exMNs/btjLU6ccuZa/Z3mbG70/JREYdBkdp7+mGNPGX
         m9ru6fC8HUHR4dp1FgaySpzkGEyUUZNO+9ldH/Gb2ErYC94sxam5yayAWsNXQLVviXBO
         tKWFJksIapkYG8QvJdsuLXIRxWavR5gI3Fa07Yf6lYnAwoztVb3gQvpFxyEcOvAeWX5j
         5i35fwzdvjOY8aTdof8CCFUIBALou9D9wvRNmbGRfYfBEG1pouDTUeZze8Rna+wgi2r4
         tOaGnRTci6jWxIq2Hay0oH3IxB082uCo3Xv3oeS9mpPGs8ZIrxJc8N0WsGyV3LX3FUXD
         gd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782160104; x=1782764904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54f0swcPw7+TdXC+Nf2IgC91nKxBYET45t1TEwUaxgE=;
        b=OmT7cWSJsode+i5BJ3ngIbs5NyCFHuiHKj2gvLYXphQM8RzN3l0Sr606MH3b+3IPB8
         qL1YWuUawyK9UrgIeEt18EP8wqBPDKjLjK4cAwAGu+LtXrTKdG5XY9T0DVMIgVAJjDUj
         JOGj92ZkvM9AlqJ8Z4VuRyJWN3YBNPmeq86/J4dBgekVW1AU0MS2muGS56vDLCJbh8Hp
         z5F6GSg3JaZ3lvS7Xrr2tvClExngDdWfEdm//CpC/qZQag/W04JQ+GWM+a0RtsJ7PR/A
         4EznB3bB8UAodqXfewwHAvUWSd5qGuLNZkfbr04DoIEiOuxaG0Vd7o4m/HlB1/kz1VPc
         NcrA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZV9JcyiEM9/4b5HXrT+VnED/hvx7Gk8xHkp0bQeECJNlB8DlEFp6I5RZ2BdxLapuDscU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUd/R86t9FA2AsuP7vRKIobS9I256cFCq61JvM5lOZquSRA9s
	DWkJ94CPHrTLxI8lse1EXxCYlP7pZFpah2JFBuI5mCow5/les7mLcjbc
X-Gm-Gg: AfdE7cmxQfz/45FvOQ9VMBLBegZpyoUgAsVnT4qAyHX7ukYPU14L3iyiqh3JhaO5WWx
	u7ILnVOqoNDOn/X2z2KfStZcu7MaP3nNoQ5mpZWlWRVaank7IZCTOoyPlwKpQvHnokH3LPkgUfS
	JSWFZyO3TeR4ch/nFwB4XKi0xZKvvUZxMIFtsTTR0q5VelQu2FhU+UIojQkR30aw5EY/ZA8oILc
	Oo5CXgl4g6D8yUmZp445xOffm5AQogNzS7YG+i+bFk3bo0pn/VHR1EBd/3+x2q+q0hafTXayEK9
	KOCtMYc+pMWepyAcGpP+M83EEzRrdo8nsyd8da3J2ku58tDjCFxULnc/HxM1cT12PGpDIycEsWv
	LScuF34AVqL9EXEph5dOP3qtEuJmhqAVpcqLruwwC1LlNpnzhUla0Pjy+imdqC/VRqGWNO9QfGZ
	GTrA+vfODmv8iSNnk/XZ/xiWIc3mPmiiUajlEiZgtkFLEP702/DuQ4fUu/IQ==
X-Received: by 2002:a05:6102:1489:b0:6a2:b2a1:f16a with SMTP id ada2fe7eead31-72a75fa3c2fmr8370649137.2.1782160104072;
        Mon, 22 Jun 2026 13:28:24 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c0a45sm74893085a.22.2026.06.22.13.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 13:28:23 -0700 (PDT)
Message-ID: <80a0426c-7146-4212-a8cd-d884f4424b2c@gmail.com>
Date: Mon, 22 Jun 2026 16:28:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 4/6] t6600: add test cases for side-exhaustion edge
 cases
To: Kristofer Karlsson <krka@spotify.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <91372b975fbe102538c05c7d2cdae356539d1bbd.1781951820.git.gitgitgadget@gmail.com>
 <1588b53d-9576-4752-9459-da48276e4b2a@gmail.com>
 <CAL71e4M0T4fFG4JuYTp_ZPHzNcHXf342Xkh0n0dt4LVKsuSu2Q@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4M0T4fFG4JuYTp_ZPHzNcHXf342Xkh0n0dt4LVKsuSu2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/2026 3:25 PM, Kristofer Karlsson wrote:
> On Mon, 22 Jun 2026 at 20:15, Derrick Stolee <stolee@gmail.com> wrote:
>> It's usually my preference to see these tests show up before the
>> new code arrives, that way we can see that they already work with
>> the old logic and continue to work with the new logic.
>>
>> It's minor, but putting them after your code change may be adding
>> enforcement of a change of behavior.
> 
> Agreed, I actually also prefer that in practice so I am not
> sure why I ordered them this way - perhaps some attempt at
> making it easier to review (show the idea and change before
> the verification). I will reorder to put all new tests as the first commit
> (or second, if I will also introduce a status-quo technical first).
> 
>>
>> One thing that could be helpful here is to consider tracing a
>> count of "commits walked" in the merge-base code, then you could
>> have these tests demonstrate the performance benefit by checking
>> for that number changing.
> 
> Good idea, I actually had some of that locally when developing it,
> but I removed the ugly traces before submitting this. I will try to
> re-introduce that in a nice way. It would be neat to let tests
> inspect that side effect, though in the worst case that could make
> it fragile. At the very least it's good for human debugging though.

And to be clear, I'm suggesting using trace2_data_intmax() calls
to get structured data that can be parsed in the GIT_TRACE2_EVENT
logs during tests. It could also be picked up by teletry tools that
listen to trace2 output, if desired.

It will show up differently in GIT_TRACE2_PERF, but that's a nice
human-readable way to debug things.

>> In t6600, that tracing number would not be the same across the
>> three different data shapes (full graph, half graph, no graph) and
>> that could be valuable to demonstrate in tests.
> 
> Agreed, the number of commits visited would be more interesting
> than the relative performance numbers since it's an algorithmic
> change rather than a micro-optimization.
They are both interesting, but only the commit count can be
guaranteed rigorously in the test suite. It's possible that a
great improvement to such a trace doesn't result in great end-to-
end time improvement, but I believe that it is true in this case.

Thanks,
-Stolee
