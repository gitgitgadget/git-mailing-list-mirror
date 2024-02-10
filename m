Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2305BACE
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581618; cv=none; b=cAJSTvZgkUMweqp38Q8YDWcCsKOvUUxWYocb5Zfal6gEXmkd/SUPNvr1bo5cOcwsJ1s+wrH2/ssCG0vj7JSm86G+YO7G/9uvuqrtrgTkoD90hfS6ayNQO6OuzDsaZaKGmt0Jd1HZ5m/mRk+anh4dfdEjZ60cJvdR9cNlaRXdz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581618; c=relaxed/simple;
	bh=lBdUTCZSGmEWr0gPIhAZLCT/k4YYP3O9qnQp1yRs4k4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AzaqmXydtnxvzw0Fm/0aBt2YDCXIwg8Vf3Pq9q81atYRjxJn5CeZ+gE+1uNrqNZmbXgQ2KgSndo9N/+k/P4qqye1LU1p+TkLVpoDWIBPovbIyQoBUv4CzHLkFEXZtxfRemId1aHNtfu5O9vFNJ2UTUPxsJz6jk8+j32O5EUmr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNd0r1gF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNd0r1gF"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783def87c8cso106406085a.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707581616; x=1708186416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH4ofoFVRcnLoBbQ/L3Eb+DwEG3SQ/sZc/CSZGcZC4o=;
        b=iNd0r1gFcet4M77ZRLUiygQOz5VZKnbcA6gd/TJ7KkQ4ep4jbzo9pTB3dzlWdyif7a
         x3Dw6g3Zo7A0nemGNlqEBBbTw5AzJHKL1tbzioPW3f33C+GsV1Tirq10JMtUq6ofXEaH
         +oZLvfZzrt8qU4hsl2ydhXFc/Uhjdc6jnDPXD18lApsMPN3asXe7s910X6Xo6XT5h5Od
         ANSasXHAhHFO8Q+TtfWorasmk1hjJsu3u7fI0iW2wZCLDAV/YnhxgFzX/As9BJZuNG4U
         NX8emTEIy+YvMshQPyK5F58+FfXeSOF1Dljn7mpB0ZTicK0Q6Nm0sXXtBZ0oGO0Sahuj
         +cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707581616; x=1708186416;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IH4ofoFVRcnLoBbQ/L3Eb+DwEG3SQ/sZc/CSZGcZC4o=;
        b=b18cTzZTm98sO7gMvyOiZ4hAN3vOLTXzF0SPZA5ztihbdv3O6hu3VgtaN/+Mgo6iUv
         Oo8+V8wMpJRgw+NU+n7uOntLk/iTvJ+izSsjkEMHF6tz8Wtjz8UV3EngZjjWb7+qcWSC
         mL/TYVaxU17C2AV32iRCpoNZIb89mcc1i7ptwMrGYoBeDmeP2Kc4gkBWTwjTOCj8C6Tw
         qFaA/1aifMW0Cl2wAlUJAyW5N2MFFd+Y0cC9C8b5XFoJLA09p5nnXuj51rG1HJzl+wt9
         RSswbJXn1pyhmNuZw/msLmfZwdLK5RnYbkhSH5pYin1Po5KAQ17B+AFSu1HmgkkjcfIj
         EWVA==
X-Gm-Message-State: AOJu0YyalsdrCNJu+D5SFsVJjZpaS1nfgNU5J3EzPiBAn68fnclrq5hj
	6Z7CUOCrS+SfgWwPHvX6PaVgnq+66MHE27UYSZe4jH8t1qrrK3Gw3jxn55LU
X-Google-Smtp-Source: AGHT+IGTKRqNCEd5eFhugVi3fbgat/88O/BiwbMI0cr5PuC+tfPGSM8pYcyUYv4VvxWnaPdfJQLC8g==
X-Received: by 2002:a05:620a:1258:b0:785:a9e4:2288 with SMTP id a24-20020a05620a125800b00785a9e42288mr2050090qkl.25.1707581615985;
        Sat, 10 Feb 2024 08:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQnOCG0sL6kw7WW96Ez3ku6q07mUFhSFO5kUzYOzFUBr+k8/5wIaT2NyHHb8WtKZ1bIGDWGD248pTFjq2KjpoA5iGM5kv+
Received: from ?IPv6:2606:6d00:17:3855:7446:337:f37a:d47? ([2606:6d00:17:3855:7446:337:f37a:d47])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a166600b00783da2644besm661207qko.136.2024.02.10.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 08:13:35 -0800 (PST)
Subject: Re: [PATCH v2 4/5] builtin/help: add --config-all-for-completion
To: Patrick Steinhardt <ps@pks.im>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <d442a039b27820dbd44e604df75ec026b8243d47.1706534882.git.gitgitgadget@gmail.com>
 <ZcSF2mw-zR1d38UG@tanuki>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <527a643d-5d63-da05-70ad-99200a7b85d1@gmail.com>
Date: Sat, 10 Feb 2024 11:13:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcSF2mw-zR1d38UG@tanuki>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr
Content-Transfer-Encoding: 8bit



Le 2024-02-08 à 02:42, Patrick Steinhardt a écrit :
> On Mon, Jan 29, 2024 at 01:28:00PM +0000, Philippe Blain via GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> There is currently no machine-friendly way to show _all_ configuration
>> variables from the command line. 'git help --config' does show them all,
>> but it also sets up the pager. 'git help --config-for-completion' omits
>> some variables (those containing wildcards, for example) and 'git help
>> --config-section-for-completion' shows only top-level section names.
> 
> You can invoke `git --no-pager help --config` so that Git does not set
> up the pager. Is there a reason why we can't use that?

I'm glad to say there is no reason we can't use that! I just did not
think of it and dived straight into the C code. I'll use that in v3 and
just drop this patch from the series.

Thanks!

Philippe.
