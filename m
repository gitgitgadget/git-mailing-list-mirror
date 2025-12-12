Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FA225390
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765547836; cv=none; b=N1zuHBpYCc0/0uUEKWGhMN24SYzQItjILGPQ5GD7VAolsVaEmEGGiXEqu+GxUkfa12Etaennxhgda7ck0u8T8xYELjwFTAY3AhkVGbR1EWUySNehP0unMU4fwYaZwBxLTwUmSrCNWFZQWLPRPeLLJsuSAVijY7xT8oTUHpBrJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765547836; c=relaxed/simple;
	bh=MpVU+uHMj1Zm04Qg8vypLiemUvQEsaIs14LVKXKH920=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItofvEAPGYX07Pp+XCVXfjqcUw82vssY4B+8mEep5zgQuth6+ZJpUsMuWcbRdqQSvkINYVS75IswfX7CzvfZDtVv9BvOluUm55bmf3Rt+ZbJ1bkl+jeIzYub09uMRIM/o3L8giiVH28p0+s5rmBuDMRn4+nlpbnfk04gQEVc5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrweOKvN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrweOKvN"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b5ed9e7500so94018485a.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765547833; x=1766152633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+/dZlh1Sd4ioITmXj6FvWQ3jst6yFSFvonkx07F8Z8=;
        b=lrweOKvNSZAUKKwVyKsfhm/ZlGm9dKDwXa07hitiuOM8Q+Fws2eQK5AJoYYYoSAyFc
         u980yK6KaXs+8BA0ayN9Cm7tPydBSv9JPpb0rGDDAlZH0bfCJHUaMaOQr/TrUWoAz1dA
         xgng/SMMQHaphkeNm0GNHJp9c8k328xxUSSgiIKwnEIVF0Sz+4Yq5zsGkImKZ3UxIAkB
         nJIRA5xZ8TS6Gnhzb4VsJgrRGvWKZ2/XNMgZBwo+gf2NLRptdnxoCy3h/tHicWe6Oomc
         lDk/dnth1yuNajIPDf4lhiQ7rDFNqr8BOmqn2rNXmSqlz6AeVTHULDVEelMrHGwBrZ76
         myWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547833; x=1766152633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+/dZlh1Sd4ioITmXj6FvWQ3jst6yFSFvonkx07F8Z8=;
        b=Nd8WYKM1qhc2l0nlN7g+sZPBql4GucsY7YIJgLARGAZkAjefvML8OQrjVaQRqsIGbd
         FZ3X3inQgfi2YNzWMUKMYQmwBrb0pKxRiGfmg83Q3uwLJSxx3eRAU4L0QYo/sjzQKxgz
         hPP5dCUJJrx4k5KW4UuGVAiHrGIGxhmNnQj6+J9sSGkyPAoYXyU37qmRBFN+IKiYXOHE
         MJInowszLIog+ot9eTfclaEBSqLGqKCLNfQxJUyieWSwNT4+48na3aGg8r8CCSUgx3Ls
         ooyIy8jgwOlIt11vijIDhSYo2dZW95osoSwjF3hoKLttivIwhTbgCISSWxxckALclNhX
         DPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpkdi3Ido++sRCzXt/Pnx9tgcI14/FubTVBoBFWltmM427tztRgcKsH44izpweKfSTzmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfGTCF42u/xZN9x4x12flrxZH5b9IWoTb/wd+BozN676n/n7a
	jJDFIjLObFvNKKFJ626zFinnuoqCi/SMBqZ5cqcGJtqBl/uu7PcD7uOS
X-Gm-Gg: AY/fxX6Izu5GVvuBayzu8IlYCVOVIm5SBggNJsAjzpuFafDQA2DozQpQHdY41+3h7Pg
	8iB1seOYKzfK9+6fIVZAFC/L4jrKeymqU8wySOd8wnG5g6GS3/PTkqtlhoQQiMWoBKbtVF3eOXC
	5cSNnWtfaJuJ9roxeL0NruY+aEPwEtIQPUSJt3RPjf9sgBwMB3UVrQttOq+6rpxz3Izq8wd6s/H
	W/Aw9QdvHBllhojx2Xcb/RWe1dVrYt+xsxETRsO8PEa4lL7NFftcRg9VPtBN8veMaX9oNU2ADlo
	9LvKDrk8J4Vuxa5NhWBE3+lj+4pQZxe9EETczvqTN8S6OGv7gO4oOnZK2RVOWw3fdpkUjSyVh33
	hUKSNY4Koei/x2qS+plFkEkNm+C1UOdmR72G5Q34d40avjf3DjQOkRV7cGV3oFv9VZi3FPT/aNl
	w+bFdISyA8cGZwRgYsq/hZCquimhZvxQ7ZGAsUef8UizwA+pfFEpfsUpf6Wg==
X-Google-Smtp-Source: AGHT+IESMaIJO8sj2nfab0t8bPiCCq2eFLskAicpY6S4l0UDyiOhY2ZwNSLwO5rcIxsWUjlSvCsRhg==
X-Received: by 2002:a05:622a:41:b0:4ed:8264:919c with SMTP id d75a77b69052e-4f1d060d406mr25501831cf.56.1765547832668;
        Fri, 12 Dec 2025 05:57:12 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f1bd5bc31bsm45010721cf.10.2025.12.12.05.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:57:12 -0800 (PST)
Message-ID: <7d347708-2c47-4847-8e29-56e03c6a6a13@gmail.com>
Date: Fri, 12 Dec 2025 08:57:11 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] scalar: remove stale config values
To: Matthew Hughes <matthewhughes934@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
 <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/2025 12:46 PM, Matthew Hughes wrote:
> On Mon, Dec 01, 2025 at 04:50:45PM +0000, Derrick Stolee via GitGitGadget wrote:
>> * core.preloadIndex: This value is true by default, now. Removing this
>>   causes some changes required to the tests that checked this config
>>   value. Use gui.gcwarning=false instead.
> 
> I was going to ask about if we could also rely on the default value of
> index.threads like we do here, but then went and did some reading and realised
> some config values, like index.recordOffsetTable, have their value set
> according to whether index.threads was explicitly set, so I guess there's an
> implicit reliance on that behaviour that we want to keep?

Thanks for identifying this subtle behavior. I will mention it explicitly so
any future change that removes that behavior could also lead to a removal of
this explicit setting.

Thanks,
-Stolee

