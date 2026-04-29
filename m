Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E07347518
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456977; cv=none; b=ZeEtEFlD/R0aSkZKFrjSc9aUZv73lcWmj6bl7JRs7VqYN1UOlsLpaQwQcLhx1DVAA2pr4RBeWczSssJNJprc/MAp67hBVhQRMrblej9mL7xG3pXpIM6Lzo3E6jzFrWNRfOeMGauv0IxBYF6O6L5poeREmsqzpzLP+vylrlzoR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456977; c=relaxed/simple;
	bh=2VOHcCe4qOc8RuDwJfDFeolbojUMNbJkwoEv/sVeAK8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UxHjaHztrBPykWGvB7eLdOSUgkjWAL9oh9tztGB0kALYTPDfjH3F70zo09x3bqtbtEspviJnAbQhQ4kqWsfk4JBgY4PdpsNmXo2a42WlUf4T22iVFe+NOqYSq8L/6LNbrVpZ7a7DWzH3Sbv/Ellow0SigIre5EmFOn5ZinaWCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWLIWD8u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWLIWD8u"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so213288055e9.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777456975; x=1778061775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TZK79NyiP0epb5fVJggrcxSZAZVHUoUoFgq9e6ejq4=;
        b=lWLIWD8usDMatX6eHZMwBhwvKUloO+wJ81sTQhq+xIp97AT4riIAgyM/P6u/3NmsSx
         +HqXYqJyS68I8ioncGmXaGzR6d/ZFJ4drPx4TGeQNpQ7c21cCRBBkDHZ/dgHhc1i18Ki
         REBOByMg2yzkBEQfuwN1CQz9RIrbIcW6UgWO07sPH81C4P499c8VNARG7UgTg6mUXwl1
         Qc7PQDFHQJ/vghXVM78o2BSzQn63x4b1R51DUKRWBQb8vFnammA5ogsVvFzI5dj4Uzax
         LDwWMC4eUYu8F7nuZczGfnZeiOb5ZOR5o9uTomb1mML5QxAZ66khgRFbE9VhvdqkE0f/
         sAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777456975; x=1778061775;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TZK79NyiP0epb5fVJggrcxSZAZVHUoUoFgq9e6ejq4=;
        b=RttqYMpg2MW2RARZsj8g/MlCViaAIsMxwfPJ+Ps8y3TqYuIVxG5fO450xm+1CzNidf
         Dog7rHHWHEoQEylK/QzJ+lBhaTE0RMRtOt1OIpIHeafU/4EpcT5NZZKrv+5cYrS+7hZ+
         Rv+hn57K/wbxF6e6/9HBViE8O1VfXk+lB8sY0/2YY0vzB3qYemKyVOYsyDkPwRbviC3A
         KGD4li2F+rNE3jN4fqJ0ir1WhEa+Z3lwTxqsHSCoE5A6RQi2F3+UMGPh4e076O4rY7AC
         6kToQLKHcRXCZkjG4n2/cG0P65gLQlt+WkuwwBCd91zO1EG4R9yxz1cg8BHIvuWEaeL/
         S8eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JrZENBFOKQ9rrd75Pa3ywlR3vWayxKoJ1BrbU5dgnujTiKssByryCqNjFLZcLGYI+vxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/8r2b6kxfZdfbJRfSIXTszJLQDktawU/U/eVCpkNYwh7a0iX
	Ov6gAD7RCglJxolaksIOAifJxcGgK2kcLN9DuFet9R8EA3Zdh5gA5m2g
X-Gm-Gg: AeBDietz+vByTxdyW4Uf73/RZMixTqvLm1kz8+40wxWvpD+88W1VyC5nWUNKIGI1pb3
	cX+jX7O4OmFY+AYRNpreD9qDaUut+Qnp8lCIumxuEs2gFUV7lRxIPDCfjFuBsuM0Pd3M+pmNZMt
	+uLFI4xZv62obXHcLhyv8FzN5QzGvDrsFe5wVrrgYpoum+/N5zM7TI3nV7aqUIab1XVjW5Y0IlQ
	qxWPMKkh2e6o41OhlWPMcyrL8RUQGG/9lYqYba3jGrI9ECsRGbLj/X0RAbq6HgB+fS62TkzLzCg
	xc4GtNPr5bgvAdz0v3twx8ZuunwysAE6UGuIDjTK3qFzWx0gImreSIqQ9BoEgEQ6gIq5JPjiKAZ
	3RVxQtokzHNcvZdBIwD89+Wv91Kow3kDD2J/7yRQpUL1WiAjOf4KAhTgxmARl2b/zAdCth68pkB
	aRh7IGEdM0gmMo8E1SUbvXeereAy7T1XCNwazLPPisWXqasmUonkYn+8Y70xMG2G0HwawwVmVot
	xAM7aKjW0rg7g==
X-Received: by 2002:a05:600c:2e0a:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48a7b59d1camr30488155e9.16.1777456974090;
        Wed, 29 Apr 2026 03:02:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c3161a6sm14106045e9.23.2026.04.29.03.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:02:53 -0700 (PDT)
Message-ID: <cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com>
Date: Wed, 29 Apr 2026 11:02:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v16 5/5] checkout -m: autostash when switching branches
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
 <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
 <07d25fda91a1bbb3e13005d5462d1879303b15c0.1777401552.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <07d25fda91a1bbb3e13005d5462d1879303b15c0.1777401552.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 28/04/2026 19:39, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
>   	if (do_merge) {
> -		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> +		ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
> +					 opts->merge, &writeout_error);
> +		if (ret == MERGE_WORKING_TREE_UNPACK_FAILED && opts->merge) {
> +			strbuf_addf(&autostash_msg,
> +				    "autostash while switching to '%s'",
> +				    new_branch_info->name);
> +			create_autostash_ref(the_repository,
> +					     "CHECKOUT_AUTOSTASH_HEAD",
> +					     autostash_msg.buf, true);

If there are no local changes then doing this is pointless - it means 
unpack_trees() failed for another reason. Having said that the current 
code also tries a 3-way merge unconditionally so I think we can happily 
leave this for the future as #leftoverbits

> +			created_autostash = 1;
> +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
> +						 false, &writeout_error);
> +		}
> +		if (created_autostash) {
> +			if (opts->conflict_style >= 0) {
> +				struct strbuf cfg = STRBUF_INIT;
> +				strbuf_addf(&cfg, "merge.conflictStyle=%s",
> +					    conflict_style_name(opts->conflict_style));
> +				git_config_push_parameter(cfg.buf);
> +				strbuf_release(&cfg);
> +			}
> +			apply_autostash_ref(the_repository,
> +					    "CHECKOUT_AUTOSTASH_HEAD",
> +					    new_branch_info->name,
> +					    "local",
> +					    stash_label_base,
> +					    autostash_msg.buf);
> +		}
>   		if (ret) {
>   			branch_info_release(&old_branch_info);
> -			return ret;
> +			strbuf_release(&old_commit_shortname);
> +			strbuf_release(&autostash_msg);
> +			return ret < 0 ? 1 : ret;
>   		}
>   	}

If popping the stash created merge conflicts then it would be nice to 
print a blank line before the message about which branch we've switched 
to so that it is visually separated from the conflicts advice. That 
would mean apply_autostash_ref() would have to tell us if there we're 
conflicts. Again we can happily leave that for the future as #leftoverbits

Thanks

Phillip

