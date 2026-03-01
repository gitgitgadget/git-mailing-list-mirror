Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8427CCEE
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382164; cv=none; b=b07rn4f/XykddqPpzv4pyqfrRN2e6nfJOu/mxkHArqGA31KEz+yuzOTpYOwspyy+M9xd1KpMQajj4CVQZUDZ2cvAfOOKy0w0LVkLPT+fFd2sMbB4Ov4uHKNugIboCLvgbh8LOo3l8yE12Q9y+8N4wa7MjBxv4RfNXft3UYfVf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382164; c=relaxed/simple;
	bh=ubo9ib2gEDQzp1GI0Rc7hN9zvEopxhMTkFskAMVJ3EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIvTe6SGSyEz/NvlZQ7NqO98CwefC/owDNJ99IVr801RyC1PnU3YY09pR450LmV9fQ6scG6cngmu1xByT/y3uXBuZllp0cY8WwVNDwvwMH6lWnHxey8UxPWoOTHzzPJ8jH3DDvZ7iZ5hhcpKFyGUyzvEVl6mo2J6GxUx5u12D44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTFukPO0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTFukPO0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-436e87589e8so3583843f8f.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772382161; x=1772986961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+lp6P0Gzo/9SnC01FXDHApiwyoGjTo7PWSjqApfwxCg=;
        b=eTFukPO07JxzeJCRtVZUQSkPssmaMJ60i+q0qqgDxHl1uPHu0ROigNGTYLfNUtr8Jn
         WOb39eE/HmmqmRAEFnGT07G6pmHjniYQxKDNKXRIVxKFvc4Y6qUQsKKZoBYyBAplL5e2
         gDPK/0IEWBG/WNfIBmzH5LmpIRgB/sGboBXCa45JuIlf3GTATELeaPtpiU6AmNkTbLQF
         VxPJlSyZMAJSDtOx0WHeZ/6UM5Ro2XigMKlbT5Q2m3Pm37Lp2GLrkd0h27jb3DUNjjKy
         SjKrdgcXrxS77wWR1BoW5hPuFrmLZkHE8Slv8oZYBwLjje984yqF/7ZaJkWgWT9iMPsE
         +k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772382161; x=1772986961;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lp6P0Gzo/9SnC01FXDHApiwyoGjTo7PWSjqApfwxCg=;
        b=ndWMwU+fbJ6EWQpNimShEpZwnT8dBHBreOaW2aQyfxEqJqAyLknt/Eks57H3yXze5V
         2ZT8y3e8SB3/XxZqV54WzkcaY5xy0F7QxrGmWmJNElCqu7gRvwDb5hbqcGK9vQ45W66p
         PaO2H1CnAJs2pYI6tnKsxfjd+yAF4pzgbnxzooKJqblW8XJIkKgKuZkYPdWEe2MmoR9H
         cyoJpraFMwUy13ZAS7X7kdF7zYGXlUyE9bFeY6CinBo06HGwB+eH6QU5bzZ12tfcgp1P
         +XvdX4xyicy9yY1jEzrQSLj04TRndq0CVYSv7jNW0gKh3nNXoHGYNXxKhV2aUIKagejt
         jBfg==
X-Gm-Message-State: AOJu0YwFfutIe/gxYRuE1LL1FIKZAznneM+YpuBrb/qRrayiPNBza5pg
	3UCa2v8bg8TsC5aKAZxUhpF9q9gOo0MJG1pBqVkh1u3uPetaDBtsdofQ
X-Gm-Gg: ATEYQzz8TUgyQrfil8Ub9yuvekzbn7hZsJOnLTESYamSB9XaWuQ5q8veUdEOlZ1Md60
	57tlOKebaZXvnXN8CSoebH8HcDE04qh8Zpg+An3f27jK40qLevJfweQ/CDuZ1+pyxZmEsxzTKMU
	TVaF9t5yB4lmwrkVi7re/vC71GL7hmGkUwhQbL0RCqwyZRHZHAuHLPyIWwSmY16zoOH7GoqdaiA
	Di5ASf3XCjLx6ABaYJIFE3kX9kHHVebLrwwblGhdiYhQQ7GXEcIaoiT7jetfhJaVOCfdgJydIdj
	MHWjJebQOBzQwYctjGxS2TvtwrAYZtxMpg5apohe9y7I6D4O9uCupw2np+oKhq691ucTP5dCgQX
	FuCDH0lmIwtG9ShkLGPQDLVEa+1T3jWVkNPyAjcx9VTsMJRagpnnhgB6Mh3DaicxpSxObCeGpfu
	6DDbIksxzWKAjErXCFKx4KrmUDxCrBuqs5rXuTEylJK9V9hi1F7wHmxYIW3MKcVAOgyUGohHsxv
	jbAWg==
X-Received: by 2002:a05:6000:40c9:b0:437:6c23:3458 with SMTP id ffacd0b85a97d-4399ddee887mr17465797f8f.21.1772382160873;
        Sun, 01 Mar 2026 08:22:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a523sm20912524f8f.19.2026.03.01.08.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 08:22:40 -0800 (PST)
Message-ID: <8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.com>
Date: Sun, 1 Mar 2026 16:22:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC][PATCH 1/2] editor: make editor_program local to editor.c
To: =?UTF-8?Q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>,
 Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com,
 siddharthasthana31@gmail.com, lucasseikioshiro@gmail.com
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260301105228.1738388-2-shreyanshpaliwalcmsmn@gmail.com>
 <aaQzlE2lsq4WfFxt@fedora>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aaQzlE2lsq4WfFxt@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Burak

On 01/03/2026 13:19, Burak Kaan Karaçay wrote:
> Hi Shreyansh,
> 
> I am a GSoC applicant like you. I just wanted to leave my two cents here.
> 
> On Sun, Mar 01, 2026 at 04:12:58PM +0530, Shreyansh Paliwal wrote:
>> +static char *editor_program;
>> +
>> +int set_editor_program(const char *var, const char *value)
>> +{
>> +    FREE_AND_NULL(editor_program);
>> +    return git_config_string(&editor_program, var, value);
>> +}
>> +
> 
> While moving the global variable from 'environment.c' to 'editor.c'
> doesn't cause any behavior change, it still relies on global state.

That's true, but does it really make sense for this config setting 
per-repository? Why would I want to use different editors for different 
repositories in the same process?

Thanks

Phillip

> I think passing a 'struct repository' and using the 'repo_config_get*'
> helpers here might be a more robust approach. I know this means we would
> catch config errors later (right before the editor start up). However,
> since it doesn't seem like it would cause a data loss or serious issues,
> this behavioral change feels like a reasonable trade-off.
> 
> Thanks again for the patches!
> 
> Best,
> Burak Kaan Karaçay
> 

