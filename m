Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563474;
	b=rgl7g66ZmOR9DC/FjIibS69u1+ecwwJzrjMHQmUndtJianJ+EESFwwaZ5QPEU5aAA4Ks
	 CVEHI/MOXJujBVOZ3DDK/FU0nAqWXcdpyMLSGQqmFUm/V9XOD8VMwK0MkmfTkh97J3Xnx
	 IhkJZj3W9+XJ/XGQnAauzsMmvjEPDL6Z5HTMbrJphE9gtVQiyz1Fv0VHOEbhaGsZg6fl5
	 5h89vsGslxyG3jze43k0E/3nw+QmcZ20ecGFqzS0b0+eC/GiTizI3WIlwRFhLxbkXDtdB
	 QMbludl9uHyGlY9WR2QmzNYA6qhMRz9P6l4ide5M+XJCSSkVYYFkYtxViYgT0xy/aEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GmROSvo2dV+e8Xp4NG3wXnZYYTpuwt4iYSAaT72/unc=;
	b=fCP5lVdaNt3eoEdYWx7Rkhv5SF2qK0ei65eSkitNCp3AUlvKhnHSwuLKu7VYvxY2tn17
	 qAQ8McVUSYu+C9xcs0EaRyDFOhHpM1p/6j5vxiFwmLPe6pEsW50f4Cz7Ry8sQ586mVFQB
	 2pdm125jOx6leX66Ix9Byf/aX9Q8e5pHMaZQveLLNB1ScorF4aHRI4PFXx+MqFYcrnvki
	 CC0tG1cjzdcEPM4CXOUYLY6Onl4jzr2oyuMNciUzmcG/GFl/RdSGDnXDh0SrkcQOPO+gj
	 mZ7h0CFLpEeodN98nPrpYlileZgevUjMoRiB6HPx/CnnmeTnMBWOuBKybIH8iooh60A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tELzqeAN;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301F606A32E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 09:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4301F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tELzqeAN
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so319261a12.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563473; x=1795168273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmROSvo2dV+e8Xp4NG3wXnZYYTpuwt4iYSAaT72/unc=;
        b=tELzqeAN4LyHKocNg7cLWa9gMghJneeBM9lxOpkVBrNEuMHZYINz4PnucnKpcBFFC5
         BEd6wSQlG3iUXZd/l+YnqfeBvs4g+muHZsfYnoV73VTHy+aza+115kvAxLK6/I2WLVl0
         smHWu3V9y2BpTNf7Wnmuibcw+qM1YsYVfuYaFu8LHY2fBqIRbHRpz+ltgKmS7n5ZjMuQ
         G77R7Pak6wYfplgBk/wPMKzft8zL03dYkOj2SFgUaTz8tqpP3WCh25pxBezv2sGn1As+
         Bdc3GafCORy8iaSdga1INK0vmPN8F9PklOOP8I6QhlUdkSbfBC3qkO1lorPBn/521J7m
         06mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563473; x=1795168273;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmROSvo2dV+e8Xp4NG3wXnZYYTpuwt4iYSAaT72/unc=;
        b=vfb+nfTwzlApoQvGNQ9Q+oazatS8aEzcMsxOGT4E2n/W8/UtbOUBNo+b+W7R+rF3Tr
         0sAyVZU/pS2PTmVKXKUlZ2xHTtoiDuj5JX2JxZorc/EQ2VTGkohXz0JyO6UyFN7Da/nR
         /LRbOTanvHBM/C7HseGZGlTF5Moz+0E/gPZqr9/4dHUyb9eyWMqc6d4UxbWa7x1EtaQr
         K6ATtgrjQYb7DoaqX+ZoXv/jcMS5K7Jzt6HTWDSESYV4xXls5apnaYh0Y9RYyKC5q+kE
         EMMlK9nmRNwZwG7fJii7fz3BekwdVSjfyq/l/7xyH3bqvenHp/DRi32g3H6gGR4WXY9V
         8Jyw==
X-Gm-Message-State: APuU4Z8DqvlDJCGgAuoJ0VHKz/Jo3UxPyYaOUIa7ryi23AbQ5/Xm/gQX
	CEB9uk+1RGwsXJPZRz1Pel6q1HblSTRWqxDsE/D2OpGWMGs8E7sOSiyvwl3cug==
X-Gm-Gg: AYBFou1ei/md+ZU2qnayrY3XQsPtzTqSkrJ066z1ZEeQMRWQ7KTvQIpPEnNqeFRDf2D
	aGbSGfjagRF2+8De7v5vRKz3AMd4NaqFpydXCK32S0w/UhdN4PgGDx5IxP9xzks7Sy6zodH5yjH
	2YcKjVhYSEShxTrcKwKoGDcU3mZUtwn9snENdbrEw5QuxotsliHj9vpdc6/H0x4MvFH9tZGsVuk
	rBckFIpubITL2XdDbBCoieGdOa65nobC1ZyoZxEX29K15L+lJq8KqQ219ixCt1TKH3e/r9+HkOL
	aIbg2twzDwCrR5y4cLkXIKOUiKo/SbqNZcbrH1hEWmUUESX6E6/aOYsexQ0ld3NbOntkvFMnK2f
	2E3uNqh9Cqtl+u6Jnxndj7DaHFyjlCiuif+UqIA1bwA6xkUDB5FxbrUZ/Tpn0QG2o7Y9355zYUl
	LLfEJENCCVaWHcY6q4SJ5hjz6W2f2xovejP3tevVCjSd9zI0FMEEzkjgwZZgQEVcp8mOIIc/tcp
	x9mR6pc4Na7rKSXIGzHDmUR4IEb8QpSQgBYNBCvb4zjJMqO1Y4OYDiblk9tvjIsuEJ9/LtPwRTl
	Q2Edhxl16nE2a5OgWDO9F1Sr1XJL+ktxZR/J49G5MCYF
X-Received: by 2002:a17:90b:39ab:b0:3ac:80dc:f40a with SMTP id 98e67ed59e1d1-3b1b0a1f081mr1535667a91.16.1794563473199;
        Fri, 13 Nov 2026 01:51:13 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm3872236a91.12.2026.11.13.01.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:51:12 -0800 (PST)
Message-ID: <a3ae6756-0985-4873-9d23-96d4bb49eda5@gmail.com>
Date: Fri, 13 Nov 2026 15:21:09 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Tatchou Yopa Nelly <yopatatchou@gmail.com>
Cc: git@vger.kernel.org
References: <20261104172434.691381-1-yopatatchou@gmail.com>
 <894327d9-57b5-4adc-b300-25d946211606@gmail.com>
 <CAG7jffxRscX3ntX3p8L1GwGbs7WJmj6WoKPRGUuz3wcCS0NZag@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAG7jffxRscX3ntX3p8L1GwGbs7WJmj6WoKPRGUuz3wcCS0NZag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 04:25, Tatchou Yopa Nelly wrote:
> Hi Tanga,
>

Next time try to make sure the person you are writing to is in the To/Cc 
fields as appropriate. Otherwise, there is a chance that they will not 
even receive your message since not everyone reads the list by 
subscribing to it.> Kaartic, I've also re-read 
SubmittingPatches#describe-changes and
> rewritten the commit message to describe the change rather than
> address the reviewers directly.

That is good!

> On the RFC point: I treated the
> Phase 2 config work as the micro-patch and skipped the RFC step
> you pointed out. Should I step back and send the design RFC first,
> or keep the current patch as a prototype while we discuss the
> config shape on the list?
> 

I think treating the current patch as a RFC patch and discussing the 
shape is a good idea. The only concern I have is that this patch is 
submitted in the context of Outreachy and the candidate that we may 
potentially pick will work[note 1] on this during their Outreachy 
internship period. So, discussing this now sounds a little premature to me

Of course, I don't mean to suggest that no two people should work on 
related areas. I'm just thinking it might be ideal to avoid premature 
work among Outreachy contributors before even the Outreachy selections 
are out.


[note 1]: During the candidate discussion, it may also happen that we 
may not pick a candidate for the project. It is totally fine to work on 
this in that case as there will be no conflicts. But none of this is 
clear now, TBH.

-- 
Sivaraam

