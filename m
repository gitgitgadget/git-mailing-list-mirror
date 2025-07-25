Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF113D994
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468861; cv=none; b=AykKWWaUkGfz3KywzVvbbg5lYmQvhcMfMpuR4kkbOQU34b5Qbn4K0Grvi0wzxc1OwZn6o7CDE5H8XY8nf5zUl+CIaPKhj1Ni+MdyeJn2uFgHU+PwYMK968dMJ4eYzMeWGW3mjwbNJEoqEpFbEb6JO3UysPWNpLdNAKqJDTILyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468861; c=relaxed/simple;
	bh=XVnSOFGwjGr9tnomtun7QbC0cD3VEPWgain4lGVnzAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jukb6pTr6MvbrNa4Qtb2te5KqDlXrJhBx4M4UInIDcYSyRSLxCSg+P1BJ4rMygoLxB0/jKgt0mq16aAyVu3ZmrRg98VBVFS28jR5fBxJ66zaOy5AiGgJOsJczeCr/2GqWWqEFq4Sr3a6mteXdkDesg73n+fZYiD2coZJF1THXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1wRws6W; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1wRws6W"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235d6de331fso31119735ad.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753468859; x=1754073659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHEA8sProScSz2yi37YQMLSMz5gb3VztI+jEjCgkxDw=;
        b=m1wRws6WeVZTmFrQko20xxtd8VTT2f1U5Nok0Ml24r6j9VRUejJ5bR9wdW6twtnbx3
         vgngN8CW2Lo4ecKNDlvhVa2HHrJnVmo4EkLY97RtSPyXuhwU7bQPXT0gDd+vseLwCQEP
         alTNef/2nqBMjtSNPOwz4tWuZzDESAWLCCC5DhZ/G5s/uvhnFPk1GOrtbu0jFZUQUisy
         leBW9T8lpI0Wsi109N/UjfNeNbWcMX3xR3V/cRtjebAPv1VU7p7cEWOtEwkOf0ISkPtu
         LUxFFhWsYgDmiuMU6CxpKEzPz76kkBHsIb4lRbmH2dAgeAxBwuKcw+jDiABWIQTDoUDa
         dgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468859; x=1754073659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHEA8sProScSz2yi37YQMLSMz5gb3VztI+jEjCgkxDw=;
        b=VpTh4Jf6EjenmXH3yBc1eXtvI87jnBpq78W0XESdPsMgJfj4hBsViv1gecsrtHJQQ8
         ouMRr11XFau2tN0YCwcXNdbuLOuZcgk/vGKaOWZ+jKl06PzC/ABCyaokG4xQXQkFeuWD
         GJR/OvDheSqhJfEW5MH7yhL+xcKsmMtziHWebKqpxDEEEQoo8v4lHoc63s7ZJSMYD6fa
         xaN20NouRUk/QZQISBfsp9x370HqIG0pp/hjOffBaE/YtwhWeVRrl3MGYHSlutqtBzdK
         eFTL+09e1omqyIR0T5bjNsT2T90gWIu0t+qIcE5JEdOBeabWd8EDrOl5NIoTBO66UlXH
         XlHw==
X-Gm-Message-State: AOJu0YwE5jVqAP3Smc8YWdbRCcqPUHX6yx2KqSgC9sYaIK3AU97rJccW
	4n+3GR7yulkAFnjJit30nax6pa3K9G2CkS63d3eNYwlP345F0hjXwlNt
X-Gm-Gg: ASbGnctnL9aBKD60m+3fjqIsRlHl6mFDToK6BeMA7pxzjR/znyv4hRAC+vJUkV2P5wR
	QAcdpeOo7um9DWq6Kt4Muu4WMZhOnKYiSsc4bF8mcj4h0Dt3bXMVZEsvOq9l/SBBohCyPrge/t5
	19p4TwbspoXaRVAtVhAGDwkbXMh07XVDk3+nJp8gIWusK7dOvS0MVvbvSeCKODUOqK4XYoHIwNi
	/CHkh/U5BgPGEZsMuJKdZYhz5W6Cg/gdVsXb+QuMOpGZTdcNt83kTNhANXHI7ZcIvZyASPOdGR2
	7X96CL/DyooCF/+HJ2rSwoDL9/9U6lyK3IAzRY0OVdB4FszX7IWrs4eMDdqM2oOeSSIPI5OnEN/
	IhktPJ6QJID2sCeXclfWuBJBM02Dt/frvokXrA0BHnHb+XVq72AIcgv0Ei+XLf4vTLVgQVsywed
	eUNfKYTw==
X-Google-Smtp-Source: AGHT+IFtD3h33+DrWmlbUCbMLAxcfw62yesPM0lC2p7dmZcO49Fz7/77k1H5hyMQ01zF0xm9Al8oww==
X-Received: by 2002:a17:902:ef46:b0:234:de0a:b36e with SMTP id d9443c01a7336-23fb3134d42mr51135815ad.49.1753468858851;
        Fri, 25 Jul 2025 11:40:58 -0700 (PDT)
Received: from ?IPV6:2600:100f:b06e:4b24:4ee2:75fd:4616:2822? ([2600:100f:b06e:4b24:4ee2:75fd:4616:2822])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fcc5csm2443325ad.80.2025.07.25.11.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 11:40:58 -0700 (PDT)
Message-ID: <fe5d1d5e-15fe-4d00-96c4-d5a4a3b568c5@gmail.com>
Date: Fri, 25 Jul 2025 10:40:56 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] git-phoenix - repository recovery tool
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
References: <f4b40536-346f-45a1-84ee-99b1200c022b@gmail.com>
 <CAP8UFD10KuuM8Xu5YDxDf+rzN5r0TxgOw=do94dPO51hOCyE1w@mail.gmail.com>
Content-Language: en-US
From: Daniil Iaitskov <dyaitskov@gmail.com>
In-Reply-To: <CAP8UFD10KuuM8Xu5YDxDf+rzN5r0TxgOw=do94dPO51hOCyE1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/25/25 10:12, Christian Couder wrote:
> Hi Daniil,
> 
> On Thu, Jul 24, 2025 at 8:49 PM Daniil Iaitskov <dyaitskov@gmail.com> wrote:
>>
>> Hi Git List,
>>
>> I would like to share a tool for recovery an unpublished Git repository
>> after accidental removal or file system failure. VCS usually implies
>> backup feature auto of the box, but due to Git decentralized nature and
>> developer's laziness source code sometimes can be lost. Recently I
>> accidentally deleted all projects, including a few unpulished POCs,
>> after infamous rm -rf * typo. Work on them has been interrupted for
>> quite awhile and rewriting them from scratch recalling all the hack
>> intricacies would be terribly boring. So I decided to invest my dev time
>> in a more creative way.
>>
>> https://github.com/yaitskov/git-phoenix/
> 
> Thanks for creating it. It doesn't seem to have a license, which might
> prevent some of us from using it, though.

License is specified in project file (BSD3):
https://github.com/yaitskov/git-phoenix/blob/9a88c55fd45f28d4e1865df3ac746b409474eaf7/git-phoenix.cabal#L135

The tool is also published on hackage under BSD3:
https://hackage.haskell.org/package/git-phoenix-0.0.2

I don't see much difference between open source licenses and picked BSD3 
just because it is popular here.

What license would like to see?

> 
> Anyway for now there is the following pull request to talk about it in
> the next Git Rev News edition:
> 
> https://github.com/git/git.github.io/pull/790
> 
> Best,
> Christian.

Best regards,
Daniil Iaitskov

