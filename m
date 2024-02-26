Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80126129A74
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963215; cv=none; b=W7rUfgOTvx6WLZWoLvpugOtKaNDcm39Zsf12I6fDa/6fzuR/5fhHru/0HdVzqCHj9fpScVC+ecFd/hSn6RAUyJBk5znsAOszNx2xiCOlKzx6O0U5eTYs4I2jo1tE/MS9mnrjG9/2DSmiySGFhvS2jPBvC+DT9FZI31JL8vJ/KP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963215; c=relaxed/simple;
	bh=RneljrjkpNObwEuZuz2cvxbYqEo8uH3rw4ZM9CNZUH8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Id+uEBgihgw8KGZYJTTHcr8wfbkYIkVgbi/XLCYx8BHmPQgHbvYmhxCVuaqwn332w8rSMHUePxlXCStPnL10tW8q5G5K0bHjiPXNNdWOVuVfmj9grqyHj1yrWGwVCD4isUWTNcxXXWlWb8ezcnlcyWLXoLAxu+kwyqpjV7AJcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI8Ok/IU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI8Ok/IU"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso33662591fa.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 08:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708963212; x=1709568012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAduktLI7NZQg/m1Set4ih5T0GIgXt3TPrANHMVV1rI=;
        b=TI8Ok/IULTWGth/86j6GG90sxgcL915F9ZarbTAVHoGOpsGXtIyqYa/9g+Xifkn9uL
         QpBns59ML8/XY6UZdonuPMXSm8mEsgBrZurTkIEZBS0c2MYPepeKhp4gSPdNlEWG0bDB
         TQQIQR4cC0UKKUHeD19sDMo+IYk1Bddx2hsDJboOZ8iYHyuBbU1gFp8qT1JtttCMPylB
         8msa2H8KELBq+F6h2wd9x6gD+8ddEL86y74T7JBUNIstiU5pGCJ0Q/GRY8c5dxClWu6k
         Y4IAcYPrHcOtFNlxFW0SmB1XvrHyIK6FCEXT9VR69dy74Mi2TKOVnf0NumXT6RS0MQvo
         mtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963212; x=1709568012;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAduktLI7NZQg/m1Set4ih5T0GIgXt3TPrANHMVV1rI=;
        b=NVTe5lu6Wrs+UGWbANUe567sBhXnsKLSYrnicj7xdTUn/5p4Y6hXkQSgsc52Mwu1YQ
         +XKMWDyLGwpJocCJwGoE5i63BuuP/DXJ9398KirqzPWfHLIz/pt6LtCYLk6ujE97UVMy
         oVG0C9bm2KaLG8XHO+KEDAWVUalj9zvFgxW3IRvbWEBK1RIE0S0ytSVL3BBgaasXkS6f
         EM45EqZ+TOGxoE+6MSjh5pJ2cfAaQlASrl9Es/Ra/5SNtHEu8LB/31qoykCY5+TEHLXR
         hzr9tNzgOIlur4l8ljqP128UXBDoj9aevTtgkzBOYp2Q0aKvWn2bOWHQ5W8EQJH+kTCm
         jjgQ==
X-Gm-Message-State: AOJu0Ywrz8nIwaA7SpGsPL5rCzJjQAUzTBCuLUq2ORj1JjSJWVq8fQ0J
	34FS0aMHPAQvO7dTvpowe7ayNuQDtLrnvCzhSROsVMoa+2OAkJu0
X-Google-Smtp-Source: AGHT+IEjrPqkuYbUUl61hxoIRm1cZE3t7IfcY4Yt+fMb1TD6iMsPCF8/Lo2SA76uJmTNR4oacn98YA==
X-Received: by 2002:a05:651c:2221:b0:2d2:6c9e:1035 with SMTP id y33-20020a05651c222100b002d26c9e1035mr5624291ljq.5.1708963211471;
        Mon, 26 Feb 2024 08:00:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c450800b0040fdf5e6d40sm8699533wmo.20.2024.02.26.08.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:00:11 -0800 (PST)
Message-ID: <76962a0c-adfd-47a5-a017-a117ba14ae09@gmail.com>
Date: Mon, 26 Feb 2024 16:00:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
To: rsbecker@nexbridge.com, =?UTF-8?Q?=27Torsten_B=C3=B6gershausen=27?=
 <tboegi@web.de>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
 <01be01da681e$0c349090$249db1b0$@nexbridge.com>
 <20240225191954.GA28646@tb-raspi4>
 <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
 <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
In-Reply-To: <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/02/2024 15:32, Phillip Wood wrote:
> Hi Randal
> 
> [cc'ing Patrick for the reftable writer]
> 
> On 25/02/2024 20:36, rsbecker@nexbridge.com wrote:
>> On Sunday, February 25, 2024 2:20 PM, Torsten Bögershausen wrote:
>>> On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com wrote:
>>>> On Sunday, February 25, 2024 1:45 PM, I wrote:
>>>>> To: git@vger.kernel.org
>>> But I think that this should be used:
>>> write_in_full()
>>
>> My mailer autocorrected, yes, xwrite. write_in_full() would be safe,
>> although a bit redundant since xwrite() does similar things and is 
>> used by
>> write_in_full().
> 
> Note that unlike write_in_full(), xwrite() does not guarantee to write 
> the whole buffer passed to it. In general unless a caller is writing a 
> single byte or writing less than PIPE_BUF bytes to a pipe it should use 
> write_in_full().
> 
>> The question is which call is bad? The cruft stuff is
>> relatively new and I don't know the code.

I should have been clearer that I do not think any of these calls are 
the likely problem for the cruft pack code. I do think the reftable 
writers are worth looking at though for git in general.

For the cruft pack problem you might want to look for suspect xwrite() 
calls where the caller does not handle a short write correctly for 
example under builtin/ we have

builtin/index-pack.c:                   err = xwrite(1, input_buffer + 
input_offset, input_len);
builtin/receive-pack.c:         xwrite(2, msg, sz);
builtin/repack.c:       xwrite(cmd->in, oid_to_hex(oid), 
the_hash_algo->hexsz);
builtin/repack.c:       xwrite(cmd->in, "\n", 1);
builtin/unpack-objects.c:               int ret = xwrite(1, buffer + 
offset, len);

Best Wishes

Phillip

>>>> reftable/writer.c:              int n = w->write(w->write_arg, zeroed,
>>>> w->pending_padding);
>>>> reftable/writer.c:      n = w->write(w->write_arg, data, len);
> 
> Neither of these appear to check for short writes and 
> reftable_fd_write() is a thin wrapper around write(). Maybe 
> reftable_fd_write() should be using write_in_full()?
> 
>>>> run-command.c:                  len = write(io->fd, io->u.out.buf,
> 
> This call to write() looks correct as it is in the io pump loop.
> 
>>>> t/helper/test-path-utils.c:                     if (write(1, buffer,
>> count)
>>>> < 0) >>> t/helper/test-windows-named-pipe.c:             write(1, 
>>>> buf, nbr);
>>>> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
> 
> In principle these all look like they are prone to short writes.
> 
>>>> trace2/tr2_dst.c:       bytes = write(fd, buf_line->buf, 
>>>> buf_line->len);
> 
> This caller explicitly says it prefers short writes over retrying
> 
> Best Wishes
> 
> Phillip
