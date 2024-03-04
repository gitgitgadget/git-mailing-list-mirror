Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E462147
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578119; cv=none; b=IHtyIkNatZ8o1ilBQeCBlqLUDvda626sIMHi6NZcylze9cT4Q4KS0CtdPGiEFt+x2+oa/qgHeLzYQWEDed3Ebf/rnoc1oyChoPZxCG6NqoSzoZnHdSs35wN0962plFb63ALs+MufWUZ7GxDLjm0jnA5iXGDHZBvs6ihN/VmGQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578119; c=relaxed/simple;
	bh=Yhbqizz3T6gg1v8MetUrpaxwIfuww5uy1KM7+kcIjOQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YuvJQMdaGeqf3ZdZ7hfR1/Vnjfm8wKCFeulMopHtRktMtRMVDzIEM/lZRwA2sHE9ns49kuxQE0Kcll6MI5CyvyLdo8V7yDIrlGBqS0fV5sMLTdWR7qCqfFhw2NBWsI7refRPls7nfGDTRB63Qv+WMxQWbcIWocceeHkbO64nkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI/KL1m7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI/KL1m7"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d27fef509eso67402391fa.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 10:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578116; x=1710182916; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70MX389pyQ1aHvm/mLiFqOgiTox2NqEVq4leoP2ZYgQ=;
        b=EI/KL1m7hZcF6E/o4v0/FZmm+NIifIx9KHGiiSByWG2H/ixh4/6zo3Z0rruKrz3OK/
         2wZQEvZ/OXcVuadu5p+E52cnxsHpGGp1c0T/8VWXlWHxwoADbarUDcev6JzBWPUXXH8t
         2cImyQ4S6ny8hvYHN/X8dukxApURrZGVSBAWfxmG9xHPQN7Hqm0PP1o+fgYEPlSXc24q
         TwCZSixcCCt0vGZHvZw48zqi6dfb46nvMtSj5wTdyxO/MvnKPzxzdBCica6OSK9epp1s
         3RafBHuCqsB6p3OEDj5jszMmVRJkt/Wv4z5iz6VkaiboOrBKD6DlK6pagfkSH3lbVU4U
         lq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578116; x=1710182916;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70MX389pyQ1aHvm/mLiFqOgiTox2NqEVq4leoP2ZYgQ=;
        b=IzTcuee4vB1vmHE9i/WV9kc93EweSRYN5L6dCaTzMgovysmaWBkttQgEceautkjgEO
         x1tK6ViFVsbQb/hSLLr4536puUcMhZd7oMWqJmfTSyBTDSsYqDfbHADc78gGKvKNICvC
         phtYoB/n42RBslE2FXMLHSs/+bxBhgHnyE7UHCkhA4e+IUl02ZDAu8AYyifoU3Eh8gz8
         s2Mg8UhAmgRut0FzjzoYDQoVGAkH+VMPXfytEFqOnyK0dspdaX0JajmQ2FTn+b79u66t
         V5kzogSTPNiBRQwIGIkJDDfO+QI5j1vRXI6sc23GHIpOWUyCE6HhLuG4Vv9BCHcBA1/1
         ly4g==
X-Gm-Message-State: AOJu0Yy0lRhVIp9SZmMe7rfTo/QZIYudLHbrJfor9rZVdLgV+SupvYTp
	Fant0zqHOPipwSw0GIjEKEhJX0nExNiK2uWnOX+s8YoS5xuj3HEV
X-Google-Smtp-Source: AGHT+IEXdV5vFVFHkbH+tWLBoxnGQILCYEEnpsiIau2hawwSvxJ5FbB7R5zHBlM6OCe+5qj+XhlRfA==
X-Received: by 2002:a19:6406:0:b0:512:eb9a:dab7 with SMTP id y6-20020a196406000000b00512eb9adab7mr6157716lfb.2.1709578115377;
        Mon, 04 Mar 2024 10:48:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b00513360b4f1esm1246056lfn.305.2024.03.04.10.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:48:35 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>,  "Kristoffer
 Haugsbakk" <code@khaugsbakk.name>
Subject: Re: [PATCH v2] clean: improve -n and -f implementation and
 documentation
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
	<20240303220600.2491792-1-gitster@pobox.com>
	<87h6hl96z7.fsf@osv.gnss.ru> <xmqqa5ndq1op.fsf@gitster.g>
Date: Mon, 04 Mar 2024 21:48:34 +0300
In-Reply-To: <xmqqa5ndq1op.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	04 Mar 2024 10:41:58 -0800")
Message-ID: <878r2x96kd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I wonder do you mean:
>> 
>> 	/* Dry run won't remove anything, so requiring force makes no
>> 	* sense. Interactive has its own means of protection, so don't
>> 	* require force as well */
>> 	if (dry_run || interactive)
>> 		require_force = 0;
>>
>> 	if (require_force != 0 && !force)
>>                 die_();
>> ...
>
> That is explained in a few messages after this one, so I'll wait
> until you read them all before responding ;-).

Ah, yeah, got it now! So no further response is needed.

Thanks,
-- Sergey Organov
