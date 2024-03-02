Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9B17C77
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709393726; cv=none; b=I1LadWNOkXE7HU7F9GEaoGWPl710Qow6yz1n017z5mHFjxTeDTRD49WSQrHOWpEGTYo/HJS7uBPNcyMavUdlVxizBy55xoaqA0gT1LuKmlSbef6kxB0hTUIMz4IvBuGiBZsGwT1OBBR+8Bb2KjBQgDhmR+/z6NTaqwLlPlfD+gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709393726; c=relaxed/simple;
	bh=tHnMVbVku9VUDqxmH1HFOOD8L8OrM7eFdnC3oDWAGJg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xl+daR/D8fW7JDLVmHiysL6wHxqH+XiDapc6u5nBA7mKAV4PNdFltdcGSihRjsmnt749jKMQioJQx5uoPpAYETCMQr4T4hXABMkeqt7rIr34aTinZ26h1g9ocVUR+DfGPUZvMKuoj8U2RXfaCttPAH4C7Zj71tIWtk6vSf5w07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJub0TM/; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJub0TM/"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22034c323a3so1410317fac.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709393724; x=1709998524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kecApsksbQPAu1TiVQgenwEQYfzJl4VK8rMRy+Xi004=;
        b=IJub0TM/lP6gDCt8rxfZaue2NSgUjy5ewpbZY8MpbRSd+ZOvueJbAA/VdCGJ2NZiwd
         T/EZcPoKpBtF+HXyojwsoPLFgm1XAf2ODIbW380VKEIbGvBy3dXHYq83yNs9NWI9ilvX
         gN2O42hmuRrDOwPBsLNyAJfuhUS0uowgk0vPpkWp1TQbo6ZWjjKB5pkhxvW2Fx2VDkhi
         UlZN2EFe4HGTU9WhY1InOMFrsdUu3pHEcKG2pYpRfUwtqQ2VXtCsNhaDb97PSf4uSlKH
         cFYbsdoGtciXzm9uVZmmi/1OaU2hf3yM3BEjmf1Lk/XccKHbu5hPmHt55LKyc5B69uVb
         vLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709393724; x=1709998524;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kecApsksbQPAu1TiVQgenwEQYfzJl4VK8rMRy+Xi004=;
        b=dC+nravDzF5O5B0+atmjkJJxuvkn6rgGjUUgMPrZRSoM+yp55j04EgQtsz7/wm7qZV
         WhyeryYsp7yCz4OLeQa8kyVcCSdcoG80va8i/PrlKJWET57JNVoE2gm4dv/nUORXb9yn
         1pEN2wsA0IMDhP58mwO98g5oOtu8plMp/bKz4oZewgNaCqbG/mhIBPCns/oKMGclAfVC
         EihrMR7JDhL/PCIOqV9zMOItMxxPGv89R/StFI+61QoDYYOxmbIrNnpM5UpUmRhBdR33
         GxC+4XvYh+g+OdbI8Jcvdj7mmJzx/sP4vPhOW/LcH6tN8p+Om//X+2cksqKxNt9gisAz
         xLdw==
X-Forwarded-Encrypted: i=1; AJvYcCXvtELKswl0ODJExdq9sHcZoJM+/LBNk6GcyLIJKOgl8qiSko9C4NGwQLUDndAWrPPIgrKxywcqbLaBhyNIrUR87815
X-Gm-Message-State: AOJu0YwGlWdRalJw0LfNLEglhfqVi7vIMDvjgtJJF6Nz3x/TaABaa27j
	VJOxuJ9EiA+H6WrsYPf70XAGlGpM9eecCgBQ8IFLwfqKPWMrkDJh
X-Google-Smtp-Source: AGHT+IEOcxxGCggN0nJorbqCBHK0ZxNd9jjjflfwG/utbBFaFFjs9HkagB8DjQjrEyn+5WmVtaRhZQ==
X-Received: by 2002:a05:6870:1652:b0:220:b9e4:a2bc with SMTP id c18-20020a056870165200b00220b9e4a2bcmr5056903oae.42.1709393723953;
        Sat, 02 Mar 2024 07:35:23 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:4806:8044:1d22:cc7a? ([2606:6d00:11:ff90:4806:8044:1d22:cc7a])
        by smtp.gmail.com with ESMTPSA id vu1-20020a05620a560100b0078775c3b34csm2654257qkn.34.2024.03.02.07.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 07:35:23 -0800 (PST)
Subject: Re: [PATCH v6 0/2] Implement `git log --merge` also for
 rebase/cherry-pick/revert
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
 <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
 <3875a0dc-6ef2-4bd3-9852-c180043464c3@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <7d21027a-3b5d-dcef-7803-ce41be0a948c@gmail.com>
Date: Sat, 2 Mar 2024 10:35:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3875a0dc-6ef2-4bd3-9852-c180043464c3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Phillip,

Le 2024-02-28 à 09:40, phillip.wood123@gmail.com a écrit :
> Hi Philippe
> 
> On 28/02/2024 13:54, Philippe Blain wrote:
>> Range-diff versus v5:
>>
>> 1:  c9536431d1 ! 1:  363657561c revision: ensure MERGE_HEAD is a ref in prepare_show_merge
>>      @@ Commit message
>>           (2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
>>           (3) error out when MERGE_HEAD is a symref.
>>            +    Note that we avoid marking the new error message for translation as it
>>      +    will be done in the next commit when the message is generalized to other
>>      +    special refs.
> 
> Looking at the change below, the new message is in fact marked for translation. I don't think this matters (other than the commit message being confusing) as the translators will only see the final version of the massage.

Oops, you are right, I wanted to do what I wrote but ended up marking it also in 1/2.
Junio already merged it to next, so I guess it's gonna stay that way.

Thanks for your review,
Philippe.
