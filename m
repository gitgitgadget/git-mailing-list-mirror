Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93633411FAE
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899546; cv=pass; b=PFuWAhPIhfCWCwiQ4fjMuFwrazqLzMSrWetLGX6Em3EokyQ539a3ZdTZ8iMLV5STImhp8575EdQuXWG483GQRILNvgOwNbkmKGtqPGMtO6E5/swTPSyn8XSuMS182+ifnNrVZygjTTKgonEbIm0XBObWMrC/8MDWFbc/kvuV9FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899546; c=relaxed/simple;
	bh=y/SLx12lpuM+/4YGBjqOfQY0olyaPct5R3dP+xnidFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taBgbTdpHQg6FuY4zxX6dNbyovY9b6XGryAtlxJUPf42Mwk1t6/TpC8yGZpRz8Jb4hdOldlpuwLPb91CrZvARDqMxrqUkFHmcnqzbmO7yF6rOFisBq3VlBfI+s8C2aFjUEz9sFkxkfXNcu0BNOW/DbRl+ic2gLE+L/xtWsnkPfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIOWbSps; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIOWbSps"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2dcbcc546fso364215266b.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 06:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791899544; cv=none;
        d=google.com; s=arc-20260327;
        b=DKx1RUgs5hl+DvDYxaWOMypqPqQso2USecRuF69iEelwaM9jCHlrMC/1gJkywfTv9V
         W6YBBonC0BZr4bxRDWAgIkzZIfYFUOe2nmf/rAYuZixnj5R9bHbQRskEXXQi6FbOduNt
         Ui2jzg3Z/uh48PcrRlGtoriNe9gCf4e2bof04SsZFrYDLjU6Z17rjGCQ9EDQHloryzcB
         HJ4k5WI3Y5bgxFFbpEq3QhXXiCtPrzm0qZ1ZMdzKyOfq2ebPy9XqQuqwPrMivNcZGAAf
         7qjnBbSkRjtWBSoOKnb31sUju4BpAB2DahcinrYnRLULX6dKWNLyqMBY/ux6ii5HSFay
         hXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yWufkig6JUws0MKJIzvKAuBM7ct9n9KyDOeW3H6bm3w=;
        fh=dN6yqLrW2AhKjbphrjDMUGgim3uiEELP58JAayysshk=;
        b=T52SzZr/Et35hL/2g4DHvPjvu3cqPHnxpyLx30XkixemeRDxSR64/EGdysCdxagSWp
         aBRg4t324lILnbe514NBXNDlEJCLRk2Edt+ohNY5kJE8yypj6oj1NCZ2PnOmM+7cgiUZ
         NyxJvgtEsKHdCj9dsw1jS4bYtmlU/3E01HR+62pt3IBNqlbqylB0o+HOMSdAqPNmqNXw
         c9m6kb1GFl9cUbZ5aWb1E/vZFO7H0+yrR1OPjPBVRpnd2B2HVbVl+7D9XV0+duCnYsGy
         4MeebJNpnZMkeYjMTa3rD/sHAw0va7OFOa31kIr7nF5rm2BO2RZ8gu3Th1+wrqC85SZC
         Qs5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791899544; x=1792504344; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWufkig6JUws0MKJIzvKAuBM7ct9n9KyDOeW3H6bm3w=;
        b=CIOWbSpsnZ1lzc1L/s32h6G6pSNDxAwQofDg3q66KNkTkboj2SI0UtXQhLsXnikKnY
         w2vvrZ23RxsyeQu/+yEe8r5PLqXmuG8R0f8VkHNlFJa09hx5aC9ToDT2g/8cb9Ll51dQ
         PaevwVlk1Uzu82FUDPeyegqyyg44sDJ/a1KlGCsjp7e6XI3PHw8N1HLIDjYUJvNLLdPr
         MFU5vv6QrXecNuk5fuLMzKUeVYIoQC9X8381UgRPDRlAXPTgPKDrjR9vgoJcf/aTZQ3w
         ns5B11TUpYY8RZAL6FPBM2lErbBkj866METnaKqtITtH6FqT7m0PUjt/AybgkOeS8uA2
         4z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899544; x=1792504344;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yWufkig6JUws0MKJIzvKAuBM7ct9n9KyDOeW3H6bm3w=;
        b=bD4QO9sHzlSNVCJdt5RXPok7vbzgBn98aUccopJSA9OwkZC0JGnZTe1ulT+0TsMdGo
         jmQgaOBRFpWAlfCs4eILxauKYSH+3zfbO8AY8czCHbbA53YiphHWAUWl0D1PCRA3s/8w
         I7tvO8PEzhGUTTi+RsJ+mYEJUj4FezPO5C6yDSRyrL6CnU36gAoHvHJAFEGAS6GDJ/Mr
         X/yEplY1ExhB0Pp9OU7MLVXoIbSU6B7JhCAlHwXYtIMUX3kHI0iwzP82wamTsVFR2OF1
         3BhKBbHy7qQD7AanPLiJBQ6nWF3CFdGf1SbGaQZj1zZVTnuDO9TJgV6fiiMZc8ffqf0U
         jLCQ==
X-Gm-Message-State: AFq9FYLQBi2/cPhreHIL11RtRio1svX7xJ9zBwxnK+UGF5HxWaYujY0Y
	EdquqUXKSl0esB69QjDxFbWhH1SVqQA0dmobYTpT4CJP/sl6c6Q5Jts4RJDfN1t+ocSmpMzNxcF
	c6XIIz8qpqsbdYJM4rpaYbNiArqBkAf0=
X-Gm-Gg: AYBFou3cDEH6Detcj0PajR5rtfr12kjuBuiQw4BoK+bADcPMzh8whvYoqMujCgy669E
	uWO9JXkPXrAVcf7GW+HpDipnv4qn39Rn9Th6ty2gO2GUoD+xKmcx4UMyiZtwaS34Ru/CCqf/RwG
	gL33SyUCKGY5gHLewxRDDP5jgFCoOAbpQp1mIhpLxLwVxiHAbhx7Rq5MNoRgyPsTgxK/adIN6g3
	JQteItYL+2jZCYOK2ebRXRXROVazV78l4BHIhqvtF+OqavAlOJumULLY4g0/Qa1AJM2LlZq12jf
	ov54dNenJIQbLB/eUxNwhjyk9FZqvs4oHMKbsPd10Cd+axQs40db0QuqTubwp+omu88K37siPdO
	yd2XW1Gi2dkp1Kg==
X-Received: by 2002:a17:907:3d4e:b0:c29:f5d8:9c73 with SMTP id
 a640c23a62f3a-c31aa088b5cmr1279131866b.34.1791899543620; Tue, 13 Oct 2026
 06:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANHmUQTa8tLpHjZZ=Fp0m=X5Tb+uFuCcRobX7x05gKamXAgrqQ@mail.gmail.com>
In-Reply-To: <CANHmUQTa8tLpHjZZ=Fp0m=X5Tb+uFuCcRobX7x05gKamXAgrqQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 13 Oct 2026 14:52:10 +0100
X-Gm-Features: AclHuK8PwrGCYK-SQ0QQEhH1mdo-2U_TTvTLQ9GR9f-uNBbAAZmOnjfgdUhD3BM
Message-ID: <CAPSxiM_36hf1r33GQyEMEkCAs5yeEWr2J+gFfgk=rx_-DoTv3g@mail.gmail.com>
Subject: Re: "[Outreachy]" Intent to work on t0081 : replacing basic shell
 test command to test_path_is_*
To: Shashank S <shashu8660@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I'm shashank s , an Outreachy applicant for December 2026 cohort.
Hello Shashank,

Thanks for taking interest in the Git project.
>
> I plan to work on replacing old ' test -f ' with git modern
> 'test_path_is_*'  , So please assign the "t0081-find-pack.sh" as my
> microproject.
>
Yeah, there is only an instance of one "test -f" in that file, you can
take it as a
microproject since the main point of a microproject is to get you familiar with
the Git project workflow. You can work on it now. Also, we do not assign work
here. You are free to work on anything you like or interested in so
far, no other
a person is working on it.

Thank you.
Usman Akinyemi.
