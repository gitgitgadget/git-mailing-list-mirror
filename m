Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66F1C4616
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622240; cv=none; b=b5/5mj0mnb2Yq+sxt5uWj6uYRjbBH3TJrtw9SNlCfff+esF2xYb9SSsqriptevcHPmgBbjPgIMX0P0oO0ctLYvUNCbz2WG2tA2Gm8a8OwS+vgOjfZhYpyJWzcsJj4fTQFSy6CitBhnUdoNwIlmqzRpYVs4+mleLb9i712HhsUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622240; c=relaxed/simple;
	bh=/Td40Fh1XIlD3OjxqG1kRlkXR70PLerw9RfEoxE4NYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIiZzQU6Nk5xaUXRPH4G9zMjQL8QpGhK4pSNmzdKFvol8VQ3G75iGyuKmJRIX4BNg6az6cZGKdEPRPvXHiYekT/R6E5dOZdziQpB5R6mEx53fpivr5zGKxB12RxEgEuRfttoydBjbiUm+TYtXZj0d/RlCh/W478Cci+ixj04AOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ8HNs9K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ8HNs9K"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21288d3b387so41662845ad.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 03:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732622238; x=1733227038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2f09gm+izzQhN9Rq0MuYV3n9JBYUHTQ3ps6/u5gH7s=;
        b=WJ8HNs9KE7K4GWubQFqHzVlSR8U5rhCBUKuE6k44ZfvIdBcmAsxBO2PWfOkn42z+GQ
         ryHjIRSfJdILboKzMkJfs+o28z7uHnuN9NYsjTPMJlD+nbb8Q4MOnW/DnaBRUQkolNhu
         lbUN10UP5lXaQc0OGUH+1c/ZIMb1eebKseZNY3AL43sKEG/APAHWWlRlbD0I0RShOT89
         9gZWucT19b5RZdCosjD4JlOqEGGM1qeklN4eyUwT5yLs/PALjPYYgtwFHvH9Fu1SV91G
         ieFmU1mU1nRp/DhrE8vh/L4EMVop3ZYwY1hy8XL1nRY8nAdq6XmhWEBIOW4/SEQNyVkA
         Dvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732622238; x=1733227038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2f09gm+izzQhN9Rq0MuYV3n9JBYUHTQ3ps6/u5gH7s=;
        b=YYvFsD6VfQccfea33qjzbjoIFXyLlgysBhwCks9g/Ty+0GoqaFIWOFxacI8mNGBbGj
         HlBIFncCofaiy0exnCm/AqLClmix5OcwRJw4G1IU0ncwvrHvz+mmVNkbcQww8Y69pe6n
         wQPTlE3xwz/rfO11FV9NPqoTW2D+VGsZalzhhqul/ezrJU5mnO4ItKT3GJZfKEDXJ9iW
         GS7o3loyBYWZkSh20rq7XwyvYoWcl6cmyoyHdMI5KzdXBwgvjTaR8ELIPGaBH4VVlKXb
         eaGreS8DA/5n5Ic/NYf4ktwSnVsBaBNxFw7DL3I8/mFwZhTr3QLnBQc8SII5eu7yKuRm
         qbYQ==
X-Gm-Message-State: AOJu0YwcvlRrM+NslmNS/MAMlfZQr9LpOWOqBvbuBTmstCm+io1Pg1I6
	7rZiDVCTa4y13mik7zqDZr7lzyYRu0tEjLaUZr+gxBtls12qWlYMKz/vjB77
X-Gm-Gg: ASbGncuIQ5OlD9lpquSIdHXdZXK3DRmenA01fZxiv3yqEMO2vfoIHKORNXYvwlWxBjV
	SSTevmAb5juXWCnD6kRPb/HmUAOImrG2eoMAXesk2VbFzl2miIdUmwN6fOG+t9BDOY/q/bSBZ7Y
	TLayUKnNJ8Zu+w5XFRntQQFRvvrkZOqlhFBLVvJuTWUflH2f15IrClzURL5Uizc08rQ90+iopCf
	0B/rxn5MvB8SNkShdZb9gPi2foUsgdhJXBCdEjMKzBZsw==
X-Google-Smtp-Source: AGHT+IGutaLPabUeCL5a7l688W815mt7Z8M02sjbgaouVDPmQ+0f902W276l66uRvS3NIexH59b9Bg==
X-Received: by 2002:a17:902:f54a:b0:20c:da98:d752 with SMTP id d9443c01a7336-2129f5d853dmr222244665ad.16.1732622238438;
        Tue, 26 Nov 2024 03:57:18 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba5d4bsm82834995ad.80.2024.11.26.03.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:57:17 -0800 (PST)
Date: Tue, 26 Nov 2024 19:57:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] builtin: allow passing custom data to sub-commands
Message-ID: <Z0W3rgHQhmUxjgfp@ArchLinux>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
 <20241126-374-add-repository-to-subsubcommands-v2-1-417e0dc66c75@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-374-add-repository-to-subsubcommands-v2-1-417e0dc66c75@gmail.com>

On Tue, Nov 26, 2024 at 12:19:22PM +0100, Karthik Nayak wrote:
> In 9b1cb5070f (builtin: add a repository parameter for builtin
> functions, 2024-09-13) the repository was passed down to all builtin
> commands. This allowed the repository to be passed down to lower layers
> without depending on the global `the_repository` variable.
> 
> To remove usage of global variables like `the_repository` in
> sub-commands, it makes sense to pass down the repository value from the
> commands to the sub-commands. But let's make it more generic and modify
> `parse_opt_subcommand_fn` to instead take a `void *` value. This way we
> can provide custom structures to each sub-command.
> 

From my perspective, I think using either "struct repository *" or "void
*" is OK. However, I am a little concerned about using "void *" at
current. It gives me a feeling that we over-optimize here.

Thanks,
Jialuo
