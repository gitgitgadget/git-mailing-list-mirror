Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964753E06
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893250; cv=none; b=nLOLLUf+hHEP9XogRvcBojTLBzLlCbNEJtjGDFYf9EGLTTuiRnUM+Qj51C/cQ5qyUOeX7he0o1OzngRi1wk+rA1llxdtBZIZnd+0MamkQU7mRLCOoRzenj8c76IKJLICMg3fI/6CxFPZ7jTAwZ4E93hW/ZqyBdPM1CNKrOwgmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893250; c=relaxed/simple;
	bh=Qe5P3gl5aIBv6LnRMf051EiO2bC3IYMzPRdVXmLm6mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9YlhqTstHy+6GjWB3UgZ/rtp8X+JRyDOWYidDSnk9c+Sqfh3sICI+/SJML1WPiExv8B+Rn20mRR4h+Revtoi0Dyjb4I3/S+sxCMQpUsQ2SEyMmwdL+lqqg4Fp/XDUz3u3cE98CGwI7IPXs8m/DrC35A0aFV6QQO2sPJ8FFBhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5+dPFeU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5+dPFeU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4130ff11782so4750315e9.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 02:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709893246; x=1710498046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iiLXofH4kf/VK49KHqSnaMCC7e1RKUm3ji2muCiyASY=;
        b=M5+dPFeUEHNf00Y29LVq9/CUW9zaVopdgocob41SUBZvPDdTzJcRzgAD63pfMOQAUv
         AChu/B51dVNzgEgk3TjEnWBMZyeRUMZbZdn1f73BFnnW+4UhfRxajdI+LWHWX800z1D5
         8+xxanRLh/KreaFjtOkzTUxz3tHMABe4TmnSR/aIIjx+qzn1crGpaw0MrqIkUXabk/XS
         4DWJsvK39J7qAc1sS5WI5Ne5QE2BXpCrF6FAnafugnpLrbTifpfJ9eJjFPg26SiyZhQU
         KyxLyhrAhb1dyECG2WtVFsLgewQh6NxFUfuY1MQJsGbe62tJuGxXhHZ7aUWasTo2tElZ
         v/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893246; x=1710498046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiLXofH4kf/VK49KHqSnaMCC7e1RKUm3ji2muCiyASY=;
        b=fzVy13RS7Q990yafbDaOUbdWB5Jn9C/Qf5ZrT+BySyGm0/PTAfLv2xUS3RW2DDe95i
         IbIs369DHxQWa4fGK1JL1PsYOz9fCwu3DjlWjPHecxogBDBGp+BjkK/wsA/DIeFsDFEn
         d1Y2QaWqSo82QDPLj3a+rCaiapjqHt9DSwQAwJsQ4NboiOH/9kaLsxnbgHqYfnKjeCZ3
         RvUuBpf3naacw0pItobb0A2yGK5PmlFlIS35LhjMYNsUeQ/jt0PhzRQ0ROY2IjlVBOAB
         CoE7OfGGjvhBg8e9cCDMRQ4T62xoQmaQp+GAPqmzYkaPvJq4CjVZXI/KyiU2nz5+yEZg
         it6g==
X-Forwarded-Encrypted: i=1; AJvYcCXDLiHBlbBzvp48cMSL/Rm6q3ujY2eSHj4tWOQUbr/UGaSINfeyR5beaCty9e1d6khg3soCwtNBQ6W7stzVRYOpggY+
X-Gm-Message-State: AOJu0YyVFQ53kkCy86iNnGj4zlUgdLlUitK7iyrnDC15m/i9RcIDK/IH
	sqBWWUNnq+VYu2IMuodnFc95cG0G3km5sEN8d6VwQN8xa8LP8BZ3
X-Google-Smtp-Source: AGHT+IEbPH8EPhw4Oigu4blyNI/YrccgDHKZUz8v1NWeA7iwvRjM06S/YTwdWlAhrpX3ZcTM1Xllgw==
X-Received: by 2002:a05:600c:4449:b0:413:c1d:af44 with SMTP id v9-20020a05600c444900b004130c1daf44mr3942495wmn.41.1709893246371;
        Fri, 08 Mar 2024 02:20:46 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b00412ea52b102sm5627332wmq.34.2024.03.08.02.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:20:46 -0800 (PST)
Message-ID: <43b7b21f-8d11-4c67-96a6-ff2c8f037263@gmail.com>
Date: Fri, 8 Mar 2024 10:20:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 12/15] sequencer: handle multi-byte comment characters
 when writing todo list
Content-Language: en-US
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092747.GL2080210@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240307092747.GL2080210@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 07/03/2024 09:27, Jeff King wrote:
> We already match multi-byte comment characters in parse_insn_line(),
> thanks to the previous commit, yielding a TODO_COMMENT entry. But in
> todo_list_to_strbuf(), we may call command_to_char() to convert that
> back into something we can output.
> 
> We can't just return comment_line_char anymore, since it may require
> multiple bytes. Instead, we'll return "0" for this case, which is the
> same thing we'd return for a command which does not have a single-letter
> abbreviation (e.g., "revert" or "noop"). In that case the caller then
> falls back to outputting the full name via command_to_string(). So we
> can handle TODO_COMMENT there, returning the full string.

If you do re-roll it might be helpful to emphasize that there is only 
one caller.

> Note that there are many other callers of command_to_string(), which
> will now behave differently if they pass TODO_COMMENT. But we would not
> expect that to happen; prior to this commit, the function just calls
> die() in this case. And looking at those callers, that makes sense;
> e.g., do_pick_commit() will only be called when servicing a pick
> command, and should never be called for a comment in the first place.

I've checked the other callers and agree with your analysis. The fact 
that it used to die() also makes it pretty clear that this should be safe.

Best Wishes

Phillip

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   sequencer.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 664986e3b2..9e2851428b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1779,14 +1779,16 @@ static const char *command_to_string(const enum todo_command command)
>   {
>   	if (command < TODO_COMMENT)
>   		return todo_command_info[command].str;
> +	if (command == TODO_COMMENT)
> +		return comment_line_str;
>   	die(_("unknown command: %d"), command);
>   }
>   
>   static char command_to_char(const enum todo_command command)
>   {
>   	if (command < TODO_COMMENT)
>   		return todo_command_info[command].c;
> -	return comment_line_char;
> +	return 0;
>   }
>   
>   static int is_noop(const enum todo_command command)
