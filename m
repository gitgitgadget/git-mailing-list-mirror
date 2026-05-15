Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660D3B38A3
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859636; cv=none; b=biq+CsasZN4LLqdklQQbQs5vTbAWpDqAHn1r2efULA0L+RL/sM8H0L+Wezm5CbZexR052Q0Oq/QiUZj43zlMhoERfkwPKsSgLfZX4tPVrc8KRYE8h+CNdCoW7TkbLcwvzx8zHhxHF8EoFlK49WANtthxwdjzYuEY2I6GsS20G+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859636; c=relaxed/simple;
	bh=ZDFidx8dYWhVLFlo3hfrvIJtvMJ2IYOszwAM2EzoIPs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fBjr+BOCvKsP1ffqEy6l4x3ykD0y0J2oYWbyV3M7ejEYAf36IkB5Yom4ZNdvsClO6HMtG8TTUDNDlXaioD5Ub7kHPf4ng6xaZAFVE00J/sV1gNB90+g0FPxnfS1uPhWe1YFhVx4YkLeIsFVGSD6boNAp31uiQEDmZK5es/No2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwbg4Z47; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwbg4Z47"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso41046025e9.0
        for <git@vger.kernel.org>; Fri, 15 May 2026 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778859631; x=1779464431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQ5NYfkEftbtKMqC2MJIzrHnJDUbsuFfYMOupdY+Zjw=;
        b=pwbg4Z47G+9RflbOMD4HMltEgjLwix8p7UTkvls6tsKfVNdIuigWNf8d2nQ5RnkllV
         fO6+uFTLAX67MsyniacUW0HoXJAntfW0+Gp4zOqZxohh95zFJgrbDJZxMNB5jKNooAoi
         nh1maBX5cnzzlG8tY6Q7NmdKtPZxyrEjLt2TJ89sqxJdgW2N8l+tTGoTsQEV6gmM6lfM
         dCcTssQE05qji+kveBIrslYrhb4RVDjGkwJqimZNEpDxxgD8lMNAUEeFX9O4i1KpRisR
         ptT45iqOc7pCLf+m7S/sWKiexiKOWgGZPLMdR8tWKEM22uPVu6+PMWc6mr5+rpue7ImG
         LzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859631; x=1779464431;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ5NYfkEftbtKMqC2MJIzrHnJDUbsuFfYMOupdY+Zjw=;
        b=KK0bFx8vlGLDljtWrKrAzKUBeR1RK0vsO73VnssStV2fGmvifjdfez1EkNZ90B5pRD
         /FlusPtnSg2YeFlFLFfjOVz1KwKxc+ZlFoop1Wep5M3A+fbNtJ2z4nuRVQ6lNiUDoSdc
         8C8XVNLah7cP99c2nLhpeMvZLuPSCXDfEe25/T0VmXpel5JTpDofcAKAlzXwKWRz+4zX
         /Qt4cw78xjYtMU2zvlwzAqfIkTooyV3BzQMwx8CJAFmMW+FOwsLPPzL4JEKVI2EpqGFz
         CW7j1LQR1cSjVjUqpweKWJWcz3SXaCIm3TI5FflN8fEcWhuECStiZdywhXzJRnh6qaDd
         GTvg==
X-Gm-Message-State: AOJu0YxtGCQcOfvkHMvOcRx+ESowXW1halqxQxy13MbOtF6pWdHGUGbB
	ppMY2EFhuhaa6RyyVEEKMd4gJBgogmGe4SpzDwChN6DzmJ4kT3T/AJMU
X-Gm-Gg: Acq92OHTd6zMijmXYBVFPmIYqvdLC30/47duybzZXn7ny2u/2h48swBKRU7/tmen15o
	EHXGQkrtV1PptUdIS53g146+WP8BEMjWeb4ddTaU2K7dmbdREviH+4iu4/ZYLhKhzCVfrg38Ox4
	UugoVG0aYO7lMJv+rLA2ww9vUksMofmB7LptF+GW3MEu7wi+gYXSkMJsW7wnl8SLfiuyI9CIU1V
	ndbgdTZ/s2YWfoPrEEkQIoI7VNx+PsBG/He1k6ogobbCdNP1l+fDAgdJ69GSj9Qvd/b8tEusWFw
	e63PEPHfM0FHQ0VVz2NMW8MDrK0MMqA3hGvY57lF4tO1geXUHRmGmOGCuC4GrxzUWHnuKOLF+JD
	fMuIVrXYWRhKAkiy3eczC9x9nBUHbpJRHmKvu04esuq73Ck5np2Ah2pwPcXqR9FZn8SuEEsrgvF
	AnysGi/FBvp0hX0kjFqEDw68yJUH0cyrFxV/BB6p4E17kOjVbwwr+kN+FKlLUoQJEjdj7Ki0yMQ
	u1COQ==
X-Received: by 2002:a05:600c:6383:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48fe60ea4ebmr63692525e9.9.1778859630953;
        Fri, 15 May 2026 08:40:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:662:5a01:509f:d84a:9a5e:1263? ([2a0a:ef40:662:5a01:509f:d84a:9a5e:1263])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab290e1sm30547635e9.2.2026.05.15.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 08:40:30 -0700 (PDT)
Message-ID: <956baa65-6448-448f-9f02-fc90068a9413@gmail.com>
Date: Fri, 15 May 2026 16:40:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, mail@abhinavg.net
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <20260506023944.90691-1-mail@abhinavg.net>
 <xmqqqznk9ih8.fsf@gitster.g> <0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
Content-Language: en-US
In-Reply-To: <0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/05/2026 14:37, Phillip Wood wrote:
> 
> Looking at make_script_with_merges() it also calls 
> load_branch_decorations() so we should probably add something like the 
> diff below. Having said that this patch is a strict improvement so we 
> can always fix make_script_with_merges() as a follow up.

I've just had another look at this and even though we call 
load_branch_decorations() after calling setup_revisions_from_strvec() 
and prepare_revision_walk() we only load branch decorations. It turns 
out that "%d" calls load_ref_decorations() the first time it formats a 
commit and because we call load_branch_decorations() before the first 
call to get_revisions() we haven't formatted any commits yet. So we 
don't need to worry about rebase.instructionFormat changing the 
decorations that get loaded when generating the todo list with 
make_script_with_merges(). "rebase --update-refs" without "-r" only 
calls load_branch_decorations() after we've formatted a commit which is 
why it is affected.

Thanks

Phillip

> 
> Thanks
> 
> Phillip
> 
> ---- 8< ----
> 
> diff --git b/sequencer.c b/sequencer.c
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5982,6 +5982,15 @@ static int make_script_with_merges(struct 
> pretty_print_context *pp,
>               const char *label = label_from_message.buf;
>               const struct name_decoration *decoration =
>                   get_name_decoration(&to_merge->item->object);
> +
> +            /*
> +             * If rebase.instructionFormat includes "%d"
> +             * then we to skip non-local decorations as
> +             * we're only interested in branch names
> +             */
> +            while (decoration &&
> +                   decoration->type != DECORATION_REF_LOCAL)
> +                decoration = decoration->next;
> 
>               if (decoration)
>                   skip_prefix(decoration->name, "refs/heads/",
> 
> 

