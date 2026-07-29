Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1A4432E3
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317502; cv=none; b=UKK9wpQbaYkJbafs6VOLz7bRLv4HqaN27mmEitSeSJRtGJK2SHp5pUD6BfSjFf/SQnIkr/VnvMsbReJDB0Mm3RXl2tWlbgZ+bESc9kCoDiQqlLSTCqWryVP42HjzIy99IlVI40K9gjnD6Fg4Rqceb2YH6YbarkAizX7V2NI+4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317502; c=relaxed/simple;
	bh=b/imunS0UMqJDnT+m9eWhBvw3nvuf+qtlVaSeHv2NT4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l/QQhVIe8jcOkNadFz6xYptWqiJxIrPLVJTrkK0EhAIv+oB2Pv4UjuHSTO+zgaWWuCIxekFHG4/rf0vgI8QHp63wSESQ6VIhisJXFGi+4h86SYzydXwNS/b163W2I/59b6a/D/NXu8+hBI/2zdmdkHwKntDJlvHN+2dQFQZVw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvbwcVaT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvbwcVaT"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1671ec8692so93958466b.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785317500; x=1785922300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDhQnq+3Ww+r1HfHesrC3lqE7LgI1gB71iSlb9FtbXk=;
        b=JvbwcVaTLjIxaRbB1nOCjQQz7Ho6CPrjaZ8B1Bzjtx0kJ6Bu1arqLpjve8gK/PqcWY
         lE3xy/xVT/0mOb7Yhj+VBT8MosJdZlIfheBMvw9OS3M6TBLs2Lx2mrpZvV/NR2BEb7Fm
         7Gs3UK8Cm0by0Mjr31ppFhme1vm190N7DJl4kW58XW/RA1QIJR0jv7YTUyH085sxxE/n
         EGk9MNGOUT12IVrp1pKN4ppR4QlHC4PHOLgRPMdLdhiimSyh0Sc48GGuDhbCEy4pcUtE
         uALBS/+6+AsdiCbWXT995cquwQS+WD31F8Him8GR1uW22CBprw9rOrAvHMwqwZEUDT/U
         7tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785317500; x=1785922300;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDhQnq+3Ww+r1HfHesrC3lqE7LgI1gB71iSlb9FtbXk=;
        b=mNWS/APc9ZBCTBtNeZiArej3+MtTyGYvNgxiSCqmfCz7olJCIBYDhxeooyxMc0aRP5
         7o+Jh6ZLO0K7GkKVIg+bbTGaVxiXsOs13ttUKVjKm+xGL41YJSIIIq9owdWr9+2zxg+X
         Muj6qfBDiyWyFIgnlhqRyj6bj8/BD9kTcJtqGZS0HuoSGKzO+q3rZSBVd7pZZWM7OSYc
         ZVxbvlx2P6V8GjdDLVfHcIWnhm8xxYe8RYiltSQzLw/uyMrQnUKi77s8Ie3tX11Q4umc
         FUq3GZcs9LfIWfCqSxBxG+j3yt2ie5/xdEwAUMQzREqIW0rnVdYz6HCzrUg3Yo6iXTSI
         T4AA==
X-Forwarded-Encrypted: i=1; AHgh+RrUb4QvxXeifLj/eW/PRaWL7z1RGnTKuv/exmQqpTGezy+uOmiWoQepg6MC03TnIwP9jgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzVwQq+q1DmLsajkXhy9yLq6AN3E+FWXb60LsesxbX+B+wUDh
	AlBK0z8n8G3hXl62/xBQOlNgHxGMqBglnp8ouRqTiRZoenafmg9wdNrw
X-Gm-Gg: AR+sD12FCiE6NQpGc087zS+Lrr4l3eAvveprpup4KapvT4Q41kXUmB3vfVOQjZs2Mvt
	VP5zLl13TxVSVZGRZxw/2PfsMnKXmBl7KnT8nu3V8bjy5x4vecTiom5EJHugsXa6Wh7IgEzu9U+
	WIKPGh9NLpDbqrckesVmn7MocfOOadsxL0SifA3KhfldGBPoQdT6fCtpLCsKvWt+CzeFm4Oub6u
	MVQdhXuAFpHi7GGs5rOQ/KrKTCbB94gKWc39aIE6f3WHpVgH6POlbgIujL9M9+pJRXUAxMKHHv9
	cEOLOaFgmIflkCDGU/9+u9/oC0ReSz0VnMy2gd/NG5NEkg65KUE3XjCaFv2TDXKu0cNa/PYvimq
	igaghmbrjKz5fk7S+qtZV31Zo9uNtLxkQyNwpdKgt4AQWMfMn+lQuxHS7d3gt0wpeO4Q6dMU3iR
	jw54xn8s24WfEIR6BukENiSk0/NQzmkaM2fAO2qtOAckD7UnlE4pXv4emEZJN0jWEO67XjylX8y
	7QYi3RlT9puWvlt5o+M7pje8pgMeONk/oiRH0qCBY0=
X-Received: by 2002:a17:907:9617:b0:c1c:62b4:1ebf with SMTP id a640c23a62f3a-c1f721913ddmr348384966b.60.1785317499341;
        Wed, 29 Jul 2026 02:31:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8400fad2sm87019366b.55.2026.07.29.02.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 02:31:38 -0700 (PDT)
Message-ID: <61291144-60da-4e37-83ef-fe09e91c4f51@gmail.com>
Date: Wed, 29 Jul 2026 10:31:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
To: Junio C Hamano <gitster@pobox.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
 <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
 <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com> <xmqq7bmhycxq.fsf@gitster.g>
 <8631114b-aa6f-446e-9710-92c400320eac@gmail.com> <xmqqpl07fb1u.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpl07fb1u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2026 15:23, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> But stepping back a bit, is having a HEAD that is a symref and
>>> points outside "refs/heads/" an invalid state?  Why are we catering
>>> to such a configuration to begin with?
>>
>> We allow HEAD to point to anything below "refs/" - see e9cc02f0e4
>> (symbolic-ref: allow refs/<whatever> in HEAD, 2009-02-13).
> 
> But that was about a low level mechanism that must be more lenient
> to be usable as repair tools to recover from such a broken state,
> no?

It checks the new value of HEAD, not the old one so I don't think so. 
The commit message talks about topgit using "git symbolic-ref" to set 
head outside "refs/heads/" - peff had previously tried to tighten it to 
reject non-branch refs but that broke topgit. I've just had a quick look 
at the topgit code and still sets HEAD to point to "refs/top-bases/..." 
by default[1], although there are plans to start using 
"refs/heads/{top-bases}/..." instead.
>  I thought the end-user facing commands like "git checkout" have
> been tightened long ago to stop users from getting into a situation
> that needs repairing in the first place.  And that was why I asked.

Yes "git checkout" detaches HEAD if you give a non-branch ref, but 
external tools can still use "git symbolic-ref" to bypass that. It 
appears topgit's rebase command is built around "git rebase"[2] so I 
think we need to continue to support rebasing a non-branch HEAD.

Thanks

Phillip

[1] https://github.com/mackyle/topgit/blob/master/tg.sh#L2683
[2] https://github.com/mackyle/topgit/blob/master/tg-rebase.sh#L56


