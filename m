Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6E145FE5
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561052; cv=none; b=IxOfo+c6AkQik6Itumw+L8e8vDJDvyrMOcjfg09PvvF7QuCfF31KTFKRH7MV2VFZ4uDDln4UB1UcNbtAWfES2oVjSX3DEghjZsIPRpoe+dB9O0nmxFg6Us8VxiPhFD8jWoqFowrnoMbnTnuKLrc1W7COWHC4ocB2hdRKPf9Jbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561052; c=relaxed/simple;
	bh=qyeBj+VL3gYTxztR6hfyikqI2UoOBRewk/TpaZf58zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKpzYPTyh5psINrmQHOUBcLrdiEshwdjJzJ7vSBCFKba0XC2gDy5pYkISKMWYQWxPujX0732gCi3BYpjZcF+utSs1VXfqbTbpBbx6TKMNQb+8hlLaWHSH33LCJOKukstmdWgDhhq9ptHZkB85KOPoSCfhwZQ/S/VmPqwj5NXQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xHfBm1bV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xHfBm1bV"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82ceab75c27so248764739f.1
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726561050; x=1727165850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyeBj+VL3gYTxztR6hfyikqI2UoOBRewk/TpaZf58zw=;
        b=xHfBm1bVKu1EeYLinHoX0HpScSnvl2qVy/1SUFY5FASgYbPxJO5eyRl1BrlTjVZx4a
         9e9723BKi0HiW7xjdDV5OiYO7vNVV/Vhixm6oR29CGn0t6bgNkIkxIMQq/PT0KoRtkCH
         yij16IuYtYtabrzJLTQ5HZcCrdxv1btha4KEGiNoQiTznB/HZxFIdmkLBT4siIO3uYW+
         jdjG82pNVVTWEhbHUB1F30VJNIpv1gbDGNxe9G/Lt8nd1JvsNcN038lu02qVGjyh3oUt
         Fq2JbaF+ZWr9vWsxZmf6+tCE5852fweXGjaE5u3ce4B+QmEgQcamOK4eY/SQBtBdZeOh
         C4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726561050; x=1727165850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyeBj+VL3gYTxztR6hfyikqI2UoOBRewk/TpaZf58zw=;
        b=MmAm5HrrqqFWMlswN7HvOv19YYfz5sUUjsNGBRXp4hMwr+rLiLCGo3KZ29zCbLTUtv
         s8eF+T0u/0FIFX7FuBLldcKlQMD0hUGYTJTJ9jKJ0c9VD+e9DUX76/wa3eQfci2FGM+V
         RdRmn5WmCZHACrCp9Y2rpPxiKzkw+ZE/XdPChlWBE8uNCIqyBoOM/u4/6Or5h5lFMc8C
         ow4qZylh0w7d5XFtdF+2U27d3lWPQVy3rcLVRh7ax94nHgouI4UXxh0aPOyABsl3arTc
         Ue43H9nNpF3reexpO2R7a9lPUHzTgqhtVfOWRoR1Nc9RYb3FurzCcfn8H3bXfKC4AiOb
         y9JA==
X-Forwarded-Encrypted: i=1; AJvYcCUL7i649FRzhtqlIKHTNJXAScjvkGgJ1iPAMI5bGE02VQ69arSI5+gl1YcQMd98LKIJChk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWI7npPhXsYAcQIQdg5CEOVnkIfG83Kpihl/aBED9Ug9hBC6A
	bBHcwvntN6rmDMJLKHgMSa0y1TDLlvzpsmDlR2TRwZ0iPUA8N5n6Z3JILayYxIU=
X-Google-Smtp-Source: AGHT+IEFlg6DaHoZ7V0ArSfmD5O/ZeVlptXJjd/+1cVK4BO1WZVh3/H5X3c0D2VHQroQbTsaWpnIZA==
X-Received: by 2002:a05:6e02:152d:b0:39a:ea89:22ec with SMTP id e9e14a558f8ab-3a08b70d108mr125613345ab.9.1726561050332;
        Tue, 17 Sep 2024 01:17:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e10b6dsm20856255ab.27.2024.09.17.01.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 01:17:29 -0700 (PDT)
Date: Tue, 17 Sep 2024 04:17:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #05; Fri, 13)
Message-ID: <Zuk7Fvo+a/e6UObo@nand.local>
References: <xmqqwmjerqvl.fsf@gitster.g>
 <ZuiJjQCZ23DznwJo@nand.local>
 <ZukiD4-GP-rcUWnS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZukiD4-GP-rcUWnS@pks.im>

On Tue, Sep 17, 2024 at 08:30:45AM +0200, Patrick Steinhardt wrote:
> There was also the open question of whether we want to rename the new
> `_fast` hash functions to `_unsafe` to make it stand out more that they
> are indeed not safe for cryptographic uses.

I am fine to rename it to unsafe_, etc. But the more that I think about
this collision in loose object files, the less I think that it matters
in practice.

We would only hit it when trying to write a loose object and racing with
another writer which is trying to write that same object as loose using
different compression settings, which seems awfully rare.

Perhaps there is some use-case or scenario that I am missing, but this
seems like a very rare case to disable a check that is otherwise useful.

Thanks,
Taylor
