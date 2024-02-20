Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61CF76049
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454376; cv=none; b=CyOPkps7XcAOW+hjjerlN6z4BAicINmWRXY986I/hx9ILQWnBNYG694zmzelWZWz0iYEIzZHJgg/WbBrvNK1CQJbaq9rL5ux7TwuuLuIQ+/pWJ1AZIaPC/1BjXMqKwAZGxSCF1/lz/NyQ33UKbMMWAv1eTx/2vVoy1EcudyEAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454376; c=relaxed/simple;
	bh=nUwWqKvfHJcqnJr3SpSO1g7jH+gC5H0ZN6BTDEkInD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuxbSR448Cd0J1Tk2tFIfrZpdTcAjZGuRbqCufmDosP2kZQgdBfs4YjuWuGrH8Kp3kfy3TwbZbJcQ2akr7I6qGdsR3EzrW2PVvxXx4Fjsjssl3+j1lYdV80nD68AOn+2sLSc7Dqy7ezxWiacKuBeV0UOrkuxHvuhuC6Kj/k195M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcfvZYAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcfvZYAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C459C433C7;
	Tue, 20 Feb 2024 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708454376;
	bh=nUwWqKvfHJcqnJr3SpSO1g7jH+gC5H0ZN6BTDEkInD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AcfvZYARSgvM8E2gOrI6w6kQ+Mv27IzSRLTkuYJ5kI/Eb5a7aRnPEe1MPQJLx5B+l
	 9fmim7XpB3fikS4mHeM5Nm/Trv8upjWtSy0wdvHuM6BMEeYrmR6pqr/7WdLptLB4Pv
	 +XLWcBjhgmlDIxFoOKh1TmKyyiKGfCTpn1i5vJr3g9VuCqMt5lhDvgw1Oe5NEKzvW9
	 iXVXYCjZfUGWBS1/DidvIqVYhRWycv81w4oWzcJ5DrxmfdWOxOaP6ml6P6SPbe2b1X
	 vnLdDIQu6DuCPT45BuZEvo++uzEVwaq+jiuieK/MEliJGWGq88N+SWYfgdbG1kH7V2
	 gSfoRS/sOSQHQ==
Message-ID: <0174d19e-abc4-4d2e-a60d-e7df52b74d0b@kernel.org>
Date: Tue, 20 Feb 2024 19:39:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Declare both git-switch and git-restore
 experimental"
Content-Language: en-GB, fr-BE
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>,
 git@vger.kernel.org
References: <20240220092957.1296283-2-matttbe@kernel.org>
 <3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
 <95eb92cb-7954-41c0-b542-5169ed5f9892@kernel.org>
 <920a0f61-d30b-49f1-87b3-fb947cb3c33d@app.fastmail.com>
 <xmqqzfvvovva.fsf@gitster.g>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <xmqqzfvvovva.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Thank you for your reply!

On 20/02/2024 7:04 pm, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
> 
>> The only reason why I ask is because I was vaguely aware of some
>> discussions (don’t know how long ago) where someone was skeptical about
>> changing one of the two experimental commands, and then someone else in
>> turn expressed some frustration about this concern since they are after
>> all marked experimental. And the context was some UI/UX problems with
>> the command.
> 
> There was a discussion to further make "switch" deviate from
> "checkout" by taking advantage of its experimental status [*1*], for
> example.

I appreciate the references, thank you! It is interesting to note
changes have been proposed a few years ago, but none have been applied.

> Being marked as "EXPERIMENTAL" allows us to redefine the behaviour
> in a way that would break existing users, like changing what the
> "-c" option means completely (so that folks who are used to say
> "switch -c blah" will be surprised next time they type that command,
> but they cannot complain).

Personally, I think I would complain, and go back to git-checkout :-)

> Once you remove the label, you no longer
> have such a freedom to even imagine departing from the existing
> behaviour (I wrote essentially the same thing before [*2*]).  Are we
> ready to paint us into such a corner yet?

I'm not involved in this project, but I think after a few versions /
years, it is hard to still keep this experimental status. I understand
it is tempting to keep it, but I think it is now too late. Despite the
now old label, you probably already no longer have such freedom to
radically change their behaviours, no?

> Is "switch/restore" perfect
> and do not need departing changes anymore?
To me, they don't need departing changes. If they are still experimental
after 5 years, it is hard to recommend them :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
