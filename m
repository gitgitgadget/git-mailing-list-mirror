Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37A26ED46
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405786; cv=none; b=AOw5DuAqkpt/Zdte7M5RAzDplwKs+oJqb6HM4JP9fnOf77ue1DQeH0ACfg0R7TnfT+qwhOimOJskX/hM1Zvq6XQevxJ8o/HEjiEm3dJ1FU5TTnmg0Nuz7tiAEOwJD6lOYKzDeqZ/77wQN05cPlREy7vVGfCrW0HuJz+KfRkqoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405786; c=relaxed/simple;
	bh=LLyQiIFo6XHMZNNtbZm2dfWa2ook/dyNEAUG3vESg4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAwfKLl2+WMblk4xUk54w/CSHbJI3zkxaO+hl5LK1RFD2ywekzjT88n3xZwkr/u3EBRG32hc4q+EhSTUTUc90L+niFnhl8O6Idx3Vt9eG31iEGnWOYynsOkVlwWsUoya4s+zYU6eJPWV2e6WAR628VzRjELy8/TFTebVf/KU41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1B+6dfF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1B+6dfF"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bf0170c80f7so33168166b.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405783; x=1781010583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GGpW9YnQSnNOE36Lxp9rgCIOFISj1yJ4pS4cjyWWzZ8=;
        b=T1B+6dfF5QFlN6Dt6W14o6LwlwZaFTcEsNBVPSl60E9yUWIh5TkKINnqkFiRFFVrdR
         XAjYKtZbNRseoHc6yHOHOnCZO5WDe9KMmDF+Pwz3TwIA5h8AARNqWqjinfmnB4SCq6Lm
         qRvko17BwrpEb90XOYzYXuVC8oR/S9kl5o8HYYkWCUVkbvDryL3Ei22jFIbLgke7L3aZ
         zFtmhDQfGOoQpdLHduXPLHGoqLp12uPvLVzvYnt8JUo++1S/jkSBb594z39+3vcuJr3e
         rQVFd5novNDh7KPkXg3NQWEXknytnJTc3Jb7Le024CCkEm5+FimU3sfS9551sPZ7aRur
         7POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405783; x=1781010583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGpW9YnQSnNOE36Lxp9rgCIOFISj1yJ4pS4cjyWWzZ8=;
        b=T5Y7YpRrmut+Q10Y/EJ60Cpy5RpKolRzZ03cRTBRmExzsGgE6udUjUvN/mvKXiKozz
         yUJtgJ94xoq4Aw+m18wPZohnugIHlszW9SEKzQnT+gE9LBDoif3Kc3y3+JL6aPGrf0q7
         N8hNaufGXruk1NZiIG8nfdaHTTvefj3siGSFsv3IZxfVhlN6woqSZ3xAegr6WXLZ9wk5
         c9QtfwsouDQCAUrlD1MPgXR7tQ/x4eHW8msMa6Ky65ThPRVzxN4tnioNBBecP8g8GJFZ
         RGWxN+HZIIZ90Wd6I3eydoHVcbOUL9rH+7dR9jcopAuWwoaGMPBrvvrBLitWWmlcA9ID
         eCrw==
X-Forwarded-Encrypted: i=1; AFNElJ+uMXSfPmrMbkLsqVEC2GZrvTxyzkG+r/UM6kIpIMkvF9K0IjfO5on1ib0IAv7OIJX/JrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnQAt+xXKCdcNN8MNKEu7gxelJgR/x8uqBjVTj76xNGYKYCoh
	CxkA9iR8Xj3awrCF0N7FcWgKK/bnTH9uU9SUXvFQSHBVMKs6SIqDNmO1
X-Gm-Gg: Acq92OHGr65FTlIB1hx5WTh2Cz1RRcM4GZfkM5pVIZucC4wGhKqF+1qMQa+eeam7f1V
	ymEJHUNgTsv/lBPGMXyIFn/9qANg3EFm2+x7HOi6w9zWZmroM2Fp+H+rHqmHKUIAdAeX340qzsY
	UU5NoUjVf53ap0mRjPibVEa1YY/hCzPFbID/jcI6XMYqArZrvqY8oqOiV3iOqidtWRwqVyRqDzG
	kccqm6RlUEZctrJOwuniQ6tlXVql8h2w/JivhQvyw+qPuThGSxZMjadj9WaCnVaj5JOuGrhET9L
	mucdGp3R5BULTn4rPjYrwgnAoaUSO1JzKR4bc8IhowT6+oNjc9wDZZ1d8iJ8wKxNG6xRvf4Ltxj
	l356PhPdhGSHHCSZRj8KYgP8ziP+2Sc+nApBsY/88pRECwKBtYg5F/QW1w2RQ7nursXgcRlaGVw
	wcPHxGVustaXr4goY/i4UJ4+hT197mMx35uA+Nk0l+3zYijGml6ZFT6w4w0Hj83cSCSVbopWdXI
	gXb4SqsX6gUXGNhhMX5yv8u
X-Received: by 2002:a17:907:3f1d:b0:bec:da5b:5a6 with SMTP id a640c23a62f3a-becda5b08edmr781906466b.21.1780405783160;
        Tue, 02 Jun 2026 06:09:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d62cbee6sm486476866b.44.2026.06.02.06.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:09:42 -0700 (PDT)
Message-ID: <336a4202-a55f-4223-b654-985d47233653@gmail.com>
Date: Tue, 2 Jun 2026 14:09:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im> <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ah2VL-ftCQelNoOc@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 01/06/2026 15:20, Patrick Steinhardt wrote:
> On Mon, Jun 01, 2026 at 02:48:05PM +0100, Phillip Wood wrote:
>>
>>
>> On 01/06/2026 13:10, Patrick Steinhardt wrote:
>>> On Mon, Jun 01, 2026 at 11:31:46AM +0200, Kristoffer Haugsbakk wrote:
>>>> On Mon, Jun 1, 2026, at 09:56, Patrick Steinhardt wrote:
>>>>> diff --git a/git.c b/git.c
>>>>> index a72394b599..6bf6a60360 100644
>>>>> --- a/git.c
>>>>> +++ b/git.c
>>>>> @@ -591,7 +591,9 @@ static struct cmd_struct commands[] = {
>>>>>    	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
>>>>>    	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>>>>>    	{ "init", cmd_init },
>>>>> +#ifndef WITH_BREAKING_CHANGES
>>>>>    	{ "init-db", cmd_init },
>>>>
>>>> This can be marked as deprecated.
>>>>
>>>> 	{ "init-db", cmd_init, DEPRECATED },
>>>
>>> Ah, indeed! Added locally now, thanks.
>>
>> Deprecating this command seems very sensible to me. As well as marking it
>> deprecated, do we want to print a warning when it is run? I imagine anyone
>> who has this command in their muscle memory is unlikely to be reading the
>> man page on a regular basis so wont see the warning there.
> 
> I was wondering whether we want to call `you_still_use_that()` here. I
> found it to be a bit heavy-handed as it's so trivial to replace with
> git-init(1), but on the other hand it's a trivial thing to do.

I agree you_still_use_that() is too heavy handed, I was thinking of 
something like

	warning(_("this command is deprecated, please use \"git init\""
		  "instead");

but that would mean we need to add a separate cmd_init_db() function 
that prints the warning and then calls cmd_init().

Thanks

Phillip

